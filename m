Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C054D63935
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 12:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDjWy-0005d6-Gi; Wed, 20 Nov 2024 07:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDjWx-0005cx-Hh
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 07:09:59 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDjWw-0002ZU-0y
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 07:09:59 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so332363466b.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 04:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732104596; x=1732709396; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6wA9Bedt/Rw78Rtl+AvRbwBv6X7fY1eFHhZqF+U6KjM=;
 b=RgnvwLRrQi6yTCVLTRPmIm8+wYCTdv3zXiOjdDiRyKL1YTodhmDEns/+5Jh+MhaeUz
 3jnFNvIIlSZd+1qULNQvHa2iOw17lLvvOSItCw8NCdx/9weeB1eYQI2fedHtP4iWHYxd
 I6PG3IberQH3pd02OuhQA+2Ut4g07bIM7kCa4mZxm4VcPw/tn+Drg20LKQgVI4Mn7RBi
 XNNjb/a7Ffj75RSffV5B4zHC5ey+emADOP//YoVzGM22zbomF/S8JiDxVbcZvvNgFe5H
 tRYtChAGV23ippy2DKpp9RCPabdopW5gmS/XipfsJZIQrZMOiFItwzV2+WwQKN7Qn6Wt
 EHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732104596; x=1732709396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6wA9Bedt/Rw78Rtl+AvRbwBv6X7fY1eFHhZqF+U6KjM=;
 b=NGO6nXB/sWyTB9wpCoPGi+8fMzW41PiPF4LB6w9Mxvb59OkvilKSurGZYExi/jgoCx
 Y16UoNQgQth2lusl0dFIB0q+5QVIeAdK0sdHfnPzdRzdPTpf8y8mgmfTYNGRn8lByC0v
 O7Vlwnno3v/lczmXxFhQ66QyeATDVL3KbjlldAb0XSydiDw7d52XWkegItBhSCbUi0lV
 tPnm9gywEPDsmjrlSOQCr1EWjaxu/KOy6JwG+z2uw/MFj6axSr2/QmOO6byAZQ34hO/g
 YTPGy0/fS3uAbJ5R3/EBcUMq7rQAsylfPg3ByyTuyQFN/0Wf1ZMzIQavkWyeTimrc14d
 yJ+Q==
X-Gm-Message-State: AOJu0Yw3a5gOnSVsGMbApxMK8UOdgYdpodGMicG86LZmqtHng66V+fOS
 eN43UaqWd7UZOvhY9jjlBluqIjyrmXhyNWVMUB8ZsiyJ0nqiA46AW/JHA1/V/ENqEaa3lHUY1WF
 Fk8MnB+PgpmhdbtheF5Pk54+KZgX41PYbgiC2w5/6inqYCFMn
X-Google-Smtp-Source: AGHT+IEdCnBRPuTiJQJzOrQcc+vUs9QfrGnLBVOPReKy/PTk7ux259FcM99z7OsSHtV4wbu+LNOl15CghCvHbMspo+w=
X-Received: by 2002:a05:6402:84d:b0:5ce:d435:c26d with SMTP id
 4fb4d7f45d1cf-5cff4c433a5mr2046647a12.19.1732104596379; Wed, 20 Nov 2024
 04:09:56 -0800 (PST)
MIME-Version: 1.0
References: <20241120072723.103477-1-pbonzini@redhat.com>
In-Reply-To: <20241120072723.103477-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Nov 2024 12:09:45 +0000
Message-ID: <CAFEAcA9kLLA4i-_Xd_84EEQUf8sLs946yewUWYETdGrafT22PA@mail.gmail.com>
Subject: Re: [PULL 0/5] More changes for QEMU 9.2 rc
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

On Wed, 20 Nov 2024 at 07:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit e6459afb1ff4d86b361b14f4a2fc43f0d2b4d679:
>
>   Merge tag 'pull-target-arm-20241119' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-11-19 14:23:34 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to b73d7eff1eedb2399cd594bc872d5db13506d951:
>
>   scsi: fix allocation for s390x loadparm (2024-11-20 01:29:29 +0100)
>
> ----------------------------------------------------------------
> * target/i386: fix warning on macOS
> * target/i386: fix coverity barfing on vmport and smp cache support
> * scsi: fix off by one
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

