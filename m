Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDADEE3695
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZWn-0008K4-9s; Thu, 12 Feb 2026 11:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqZWl-0008HH-Ly
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:26:51 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqZWk-0007Yn-2n
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:26:51 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-794fe698e36so523307b3.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:26:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770913609; cv=none;
 d=google.com; s=arc-20240605;
 b=ba5hlrT72iRPKrrzOQm4NRB576roxmrq5gERThu8gAehU1pTuEof/ukpPwzlkaMMmn
 L/nK8lB6iMviy1ZDk7PWmQd8t3ei2W5bPN2m5Wp804xZ6sFrPyKsj6oMcw/f6zhYu5Q6
 8qB9ak+NH0Dxy1+pq8/cOJZ4/cmLGx/mPN+NA9Bp0L04UWu9r5qmQl382HdHHCP9lz7g
 JakGUANsG2K5vnRXxHuZKBcxNzrRm37YJmf8T8lZvUgCes/RT/2JW2Rj48GghuFYBrcl
 ovRqSjx7mxsmya+m5+wPuiFDfM5EizYJ0Rl2GP+opMqa0r0h8xdMNJkFnDZMIuN5/Q2t
 qJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9CUC5suL8eO4VYya72tWpNlbL0nqIu8CchiksuGKmz0=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=JibXm4TknD5NrwgWiXOalq7g61DjghErRL56lYGJlrCJ6o1wutIZqWirEy3E7nhp8I
 Zw9VvRfgv+z6q8xiEpMaC0WJhFeXDpRcqAbXi+gSPdk+VjpUrbDPSvZLExBoHYbqdhft
 Cnmcwb75FEsCB7cAYHGZxkS3a+2jDVcPTV8OKqHdbdNqTaNVFlwzS09KjE2R4HzIolK7
 KwBo0l0/jfbcdsmkDi0nqDkF2IZv5iujnuNYMcyGiAxLMNo0m6Alr8tjS7TsLPhe/s2S
 wenzZJwb1wlnSKu/F3DWAbRF9ogeoHyKJ/1QTP2xROKd0FXl5dTjaXFkIvF+jKOsz+jJ
 SsyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770913609; x=1771518409; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9CUC5suL8eO4VYya72tWpNlbL0nqIu8CchiksuGKmz0=;
 b=gmp/NqKmUeNg1iZQ1NVP2xJyVRP7lrgjfiFyJ3wZHKtqXUpywl2qHDBDwZIdzCi3G7
 9CtF1q3ZorBzw3w2Rs3JKKRrdpNSf50vIOgiZHSEGzifOZuT8UAikRGmFAaKkdQ1Yhls
 r7A9zRMzEFaxqjKrXjTFpt/8xDwXzE6RFbpiGsbgAX3dqU8qcJCweR+OU+iotmgU6o6R
 bV+HFPoEo6PX3S7iifUxvmSujSy8pGfAh3D2kCU7DUlmGSntAwXR8hIFPOja/wmcq3A7
 /CqWXzQotjvNxp+PvrG9E3zdnXf8fiDsaFDImjGz3fSsHF+qaW/71/+ATlRw/kbtajDA
 KDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770913609; x=1771518409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9CUC5suL8eO4VYya72tWpNlbL0nqIu8CchiksuGKmz0=;
 b=aqvZfTlyatDmv5qkeTzKf7HGNhaaHh6DjDn7SEPyDxG8EPzR8HUk8odQ0Pwg6yYk3O
 4GPkI3u9n5e9avNvtDHH74BjD6fA1/UT4GZZBJeL07JOE0s+Kv0ykUUjMZFFiCfpFjaW
 0um/a7zojxNiZKD3Gc2y0oZQDIT5Ei5V4KguxyKsJ2LqgoblAUC327GoosYoqfAL5y/M
 O4/eHSETuTImAbDIj6c7zLYTCmfxc4YWgF4xdkQBoa6kQngfxc6o+UGhJPNnV6rhl9+B
 ZsvVUKZmVMraMS4S40NKY3oe0+SaazWejRBDTsDv8qyuwpmx8UQTdl5wSwZG3uyxK75B
 MXog==
X-Gm-Message-State: AOJu0YwbCgUjd1YtTPBh4vgP20EDExfG8npBCiVzfMKp0ryU/9js2+Ds
 bqEYdlnaEwBO602u+qm4TO5VV2IUWQ1t/rzUJLkhMUikgBZW/yVnz8J9a+DaA/s32DpTpuk4upa
 HumssqdsQvRCT3Oi1pWnppeUVTQSITddn2PQGO5acyOoahqIGWRLj
X-Gm-Gg: AZuq6aKGRIU1RB+n0NjOe9WwaSn9uGKlyF1Y0LnGnLx6qPEZNS2AKVJoEgViGdtSy+u
 Bvk4Xbs+jJEWEMmAegKiHswT7pdkldTCfPPEjcg+rUsEygnHLVcue7PqGqVdsCrYKoKtoIije/m
 9KSLZWYPVT+3Tvbftc5+h1Gdi6ePyes2PS8jnFHsrUhwxLz9/hVd6JpoTvtfhPcKjbZFq4LgbgL
 O6DrKzbUSwQsxvgOjGA3/VPCZNmR5UeKYy4cMJyLeqfClNseL6Wac/Llinj2rKjT8mW7e8ivumO
 naed4TplmtWJyrN0dFw4Tk39yUTOZNu8pBZMbwu4/NU0fobWS4xjOsTLYpld64e72ao=
X-Received: by 2002:a05:690c:c224:b0:793:c8ab:8bc5 with SMTP id
 00721157ae682-797931f8fafmr17155167b3.46.1770913608608; Thu, 12 Feb 2026
 08:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20260212144244.22579-1-pbonzini@redhat.com>
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Feb 2026 16:26:37 +0000
X-Gm-Features: AZwV_Qg0q0ORSQYkvpMLsIKqIPqlLJGLcJI_ID5TviJVsnTCp84UIqA64sqGLzE
Message-ID: <CAFEAcA8s4p7QbVcQXWX_-HyKLyhoQwYz1b6rkazLN5uWzjXv9w@mail.gmail.com>
Subject: Re: [PULL 00/41] QOM, target/i386 patches for 2026-02-12
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 12 Feb 2026 at 14:44, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit cd5a79dc98e3087e7658e643bdbbb0baec77ac8a:
>
>   Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-02-05 13:54:50 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 28a29efe4342055b4631de96ba71fd577ae83e07:
>
>   target/i386/mshv: remove unused optimization of gva=>gpa translation (2026-02-10 14:41:08 +0100)
>
> ----------------------------------------------------------------
> * hw/i386: Remove deprecated PC 2.6 and 2.7 machines
> * i386/cpu: Fix incorrect initializer in Diamond Rapids definition
> * qom: Clean up property release
> * target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu" is configured
> * target/i386/kvm: reset AMD and perfmon-v2 PMU registers during VM reset
> * mshv: Cleanup
> * target/i386: convert SEV-ES termination requests to guest panic events
>
> ----------------------------------------------------------------

Hi; the commit for this patch:

> Aidan Khoury (1):
>       i386/cpu: Fix incorrect initializer in Diamond Rapids definition

includes this change to the roms/seabios-hppa submodule:

>  roms/seabios-hppa                                 |   2 +-

which is not mentioned in the commit message and is not
related to the change. This seems likely to have been introduced
by accident during a patchseries rebase: could you remove it
from the commit and resend, please ?

thanks
-- PMM

