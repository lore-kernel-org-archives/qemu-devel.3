Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5773CC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 08:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfWE-0003ut-JY; Mon, 24 Jun 2024 04:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLfWD-0003uk-Do
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:57:45 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLfWB-0000fr-S5
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:57:45 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6fd513f18bso239113266b.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719219462; x=1719824262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TG9RYctjuvVk+ReKmjNSNBamoxLlAFcFzKZFsKk6czs=;
 b=j8Jwjp9S4kbK8ex8Ywm3PdjBpVClwYQ3myTJef/UmdMxxpehkVqR/uaU/S2oKc7K1R
 ugLjGLwkIPUL88vi7KqDqzFxMag/zrcHLtLidNTq1z9auMDZLWjLxaKUg7PaK2XlxT0u
 iUdghxRPto7pob1LycK7xdKrPaJ1JPQG1R7/c2H2I5SZKsg/JSVTEX+eX9GuaY+1NevB
 xjxNKE/bDiF3N6qsODNQx7H24Ap2DdCqgNbnwNl+fyl6VGC82aw/0834H+FJjXQZqI9r
 IjP9qF35itg132YqqySHf1WuLjfxqCvYYCgMs8StMBEMw6KhlTbOTGlb3HebQuajWpXP
 dkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719219462; x=1719824262;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TG9RYctjuvVk+ReKmjNSNBamoxLlAFcFzKZFsKk6czs=;
 b=F9DH2OrYw1Yi5MfakxNCSswRHybgNaWz3/CS5wgFnD3lFVc1PLSQ2uSycZ6Reaw420
 Z80Z/cuXenGRD47WuOfIzIEq7RDIdSksEEXHZZ+BJLnvmHvKHvjS/i9IctRLpYrcKS3X
 2G5GEHevZ3FJ9lsM8WEj4aSP9vnlX0X6/NSaOVHJ8f+ZeYvRSLdyDuhEOH5aoSicepik
 xa++k2/l0lfTmXHsAWsWS1VOzyfTAtAwX2VEwZZWSTZSRHPIfAOmP8agir9X7ZRSOpL6
 qeGxjmyutcmXctO/mie1/dgjwxOR54qmkcembEzu6G7DejVPgd7jQrziKbEE49Mx8AaR
 KGSA==
X-Gm-Message-State: AOJu0YxTZGAp8b8cr02GBoqCroc6vmosHTkMvlSxnSdscs7fqcvpL8bT
 PPRpYeY9mgULrIt0Au2/HCDJ0Kc2yS889R3skhGohq3O3HGCkKKkdp4F8LlcAJQ=
X-Google-Smtp-Source: AGHT+IHvw1csdPACauyVkAKxbn3Axbz7CQGHD4tMG0lhdM8BarfDLukUqwrQHNsMYK4xhx3b+TqauQ==
X-Received: by 2002:a17:906:bf45:b0:a6f:e8c3:4c with SMTP id
 a640c23a62f3a-a7245c2cc70mr277869666b.52.1719219461686; 
 Mon, 24 Jun 2024 01:57:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a725d546f6asm33110366b.125.2024.06.24.01.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 01:57:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4C29C5F789;
 Mon, 24 Jun 2024 09:57:40 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: tugouxp <13824125580@163.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Did the "TCG" emulation mode has a full capability compare with
 the "KVM" emulation mode?
In-Reply-To: <62981bf0.8f16.190495cbb92.Coremail.13824125580@163.com>
 (tugouxp's message of "Mon, 24 Jun 2024 16:28:52 +0800 (CST)")
References: <62981bf0.8f16.190495cbb92.Coremail.13824125580@163.com>
Date: Mon, 24 Jun 2024 09:57:40 +0100
Message-ID: <877ceera4b.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

tugouxp <13824125580@163.com> writes:

> Hello folks:
>    I have a puzzle on qemu major two emuation implentions on whole system=
 emulation, that is ,except the emuation speed,
> did the TCG work mode has any weakness than "KVM" work mode on whole syst=
em emulations(including kernek and
> user-space)?

It depends on the guest architecture. Some are more complete than
others. The x86 emulation for example doesn't cover all the modern x86
extensions although there have been some improvements to its vector
handling recently.

One thing TCG can do that KVM can't is emulate code running at higher
priority than kernel-mode. For example for ARM we can emulate the
EL3/Root domain and secure and confidential realms. In KVM you can only
run a guest EL1 kernel and its user space.

> is there any work that kvm can do but TCG cant?=20
>
> of course kvm is much faster than TCG, but my question just about the fun=
tion, not care about speed.
>
> thanks for your kindly help!
> BRs
> zilong.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

