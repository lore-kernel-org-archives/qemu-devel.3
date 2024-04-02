Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534B2C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 16:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrgyG-0002sV-T2; Tue, 02 Apr 2024 12:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrgxZ-0002Tm-HD
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:26:08 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrgxX-0002ZA-5I
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:26:04 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56c0bd07e7bso5655649a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712075161; x=1712679961; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KK9NTlpRrRxEgAvHn/mL2lF+E/6ZZ0CVXpnhGp027WI=;
 b=Y1F3EIYxnsmoa+FnXChRdg69ABIcPjsm7A7ZLckJ66r8+A8ANv3nJ8wArOJxfG6Xtj
 lZVcIN/56vsqS9DhCTZsOhQlHSuKtNKpC7VORvKF1hly3iKulVTtlxOGMtpXTArAOt0f
 4Twc970LKvFPF3c20KmhBnHcGDXwTtsaymLblz7FNkkV/M3Ps4/+ErzV/CuqCt006y8Y
 /kdsMLwSkRcEj48AFciTt3RsQ0vt7e8z4GvJLipjiEfGzGo3lmPj9y+HnYy6+gkrWfp2
 3D6qDyvfsECyNS/uYi+w9db+Thor2I5EbzYeGNYJ2jgxu8tvineMkLmscX5IzT9mvPM/
 XE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712075161; x=1712679961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KK9NTlpRrRxEgAvHn/mL2lF+E/6ZZ0CVXpnhGp027WI=;
 b=XaugYODn3BQdorqyxn3ipHZNFtoItQHErHrJPGJQzNCfn9orFt27wDJ0uop2i53sOC
 h9JR4XLE2KfE/CSFlHhCiR9s3QZDmASM0y9Xco99lsqkAoq1dhfH4WTA/0AiyfvQA+XW
 L8720qwfvS9NI7e+u/7uJARZuRmIjG8j9/N1mxbAXQvnhPc5E6j6VBh13HyYFlJEnCC4
 Hu8NWZOuOX8PQh+QsFyl1153oNaz6ajuztQgsICrGwRtX5XHSzpq63OkTwwlQjT5k6I3
 P1hZj41aFT6lK10xTzI7iVfdXTD+NOKSh7uddkZxEOLQ0rUOiYqG39z4loE3Dtdfxvi7
 3LdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa9MFDAYJv6nz4KGrm/ppsfvlYzf2CTElXKWTslbljt9ntq/G4vAEqgYcbnkwQAyhiI8xXjCeYyDDefP9n9fBYSGETy2U=
X-Gm-Message-State: AOJu0Yzi/vL4n8XxxW0xZwdUIvCUkH/3xyHL3WrRV27kijjDGBYkN3HS
 C4CXtu5Ai3j1qvYkNZ29eCuBGxpFlROBn0mucIgTCCeCvcdxi4vuaEOvDU1tP7CpzgqTRNaiywn
 38HDBAr6bURJAtuZ1GAjK5GfU4+cmgUj986V1yA8RGfvPQvQC
X-Google-Smtp-Source: AGHT+IEuDrRkduukpPhbK4FbvpynltOX0R0MUA6cFmAYeHCX9kjK2055g4dQyM25oeRphz8/sQiB5+1c2Vs9Jp4UtOw=
X-Received: by 2002:a50:a446:0:b0:568:b48e:bb2 with SMTP id
 v6-20020a50a446000000b00568b48e0bb2mr7418405edb.25.1712075161354; Tue, 02 Apr
 2024 09:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240330103128.3185962-1-ruanjinjie@huawei.com>
 <20240330103128.3185962-14-ruanjinjie@huawei.com>
In-Reply-To: <20240330103128.3185962-14-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 17:25:50 +0100
Message-ID: <CAFEAcA8kT4c-zhygwr=ifR7_nVk+fhNLBFvkTKa_Mb+UgVMddw@mail.gmail.com>
Subject: Re: [PATCH v11 13/23] hw/intc: Enable FEAT_GICv3_NMI Feature
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 30 Mar 2024 at 10:33, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Added properties to enable FEAT_GICv3_NMI feature, setup distributor
> and redistributor registers to indicate NMI support.

The subject line is misleading, since we don't actually
enable the FEAT_GICv3_NMI feature here. I suggest:


hw/intc/arm_gicv3: Add has-nmi property to GICv3 device

Add a property has-nmi to the GICv3 device, and use this to set
the NMI bit in the GICD_TYPER register. This isn't visible to
guests yet because the property defaults to false and we won't
set it in the board code until we've landed all of the changes
needed to implement FEAT_GICV3_NMI.

> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

