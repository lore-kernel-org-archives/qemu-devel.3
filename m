Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B551CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOvj-0003Qa-3y; Sun, 04 Oct 2026 12:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOvh-0003Q2-EK
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:19:13 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOvf-0001OT-V2
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:19:13 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 00721157ae682-8ab445ac183so7855447b3.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791130751; cv=none;
 d=google.com; s=arc-20260327;
 b=ghWjIOSVo7UXqkcvwgrWXP64KQAgRqEMEhhOsiTkoqScs1GB/5I4uJMoO00Jw3HO+x
 bD5I/avgd0vPZJWtPHIcjVlR/Ez4UsD4RYFQ6Mvycm9NeXRq4RskMuyNz1lZwFox+LSt
 GcXmsurSyxrAYkr+uM7iw/e+GDuedC6Y+Hte8m9rvbrEJdREBOcoroSjjUm7tBv1gAj3
 DLSYHPcniYV3rDech/2i0guKMTTG0g9eRmJ+DWwB4lZlAM6rzySCmZ0+bUPI67lMZkk3
 mHROPdiH5o0KeBZFfmUdbSGDVpD00NGDD7PdVADXfhV4kyC0YevOyd2moo7ovNT5RWmX
 X69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nVyMLZGNdLhI1P8JwCR4uPXvAjjlF5nWABPKxGFTaBE=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=FcWu9h7AgMiqvZQ5TcrdMNO3AnOwa9rgJnnWgWEtnz/aH1eF4QRjLZs0SWTVscDM4V
 4XHQ4GA3sQnS+wjPNP3YgprYGaCixVzsqQroir3UbGlQwScFBxyqiYNxQC/DaU94gM93
 sbl15HDhFaYSM+nK2zlRg4562ex5mujphs4mZuvWganx6x310oywoxnKTpXV6mxkhtQZ
 6vWnTpoam+IDjRnU6y53jYxuVYAd4tG/ysAc7n1eVYULfIhHRa7vmrri5LwKrWvmGEuX
 J1rhlsgu/8kIEEmZVfuzp6gyA8dj6KwOYDOXBM4qmwdKzBnm87tsD3JsIOrwXfSugcBu
 VqGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791130751; x=1791735551; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nVyMLZGNdLhI1P8JwCR4uPXvAjjlF5nWABPKxGFTaBE=;
 b=CUYOdWC09zfGxWfsEfRiu4UuKUjZGRd/xt3R6mtrMEOmDtCLH/ZglffIZua3Wxpck6
 uRsP3SUKJveE829Foks8K/DBvN2OJVZruh/X0DdFwgm9qQ2x9rJmvWWT7Kb3s3TPew1n
 r8OBIJgd2EciLaaO7TVygiHwG8u245tfpGvOaAzHvmZsmaBhePwtc5ObDsVlLEjYQOcy
 ATK+4RYZa6wsuiX1W9CpI57haJS6nbFklGHRhg7Dh/xEvP1i37uMTY2+BrSWK3wumooG
 Ina37l1lqWiX+8WrnDokkalpoX4o3uSDw61YogAmzJwMsZnxpCUY7in4P2y+m0gp1afM
 nJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130751; x=1791735551;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nVyMLZGNdLhI1P8JwCR4uPXvAjjlF5nWABPKxGFTaBE=;
 b=K0DQGKYK4cbO5Mq2H6+dM9ZHjcw4Hiwqpq4mgDu1yj/X7uAL4u8fBJdvFgO5D9jPbk
 tBCEB3XZ/YAiR8OvMti8SoyZlqBh1V4BqkYrPWXkzzUfHRpL/yLyliwOUY1YHOrOTxPW
 rPEL8OiFdOFoysa9Ll3wOXO0SvlcNRdevjatCcebevR5DfXIMP/HSQNAL64sl9zz251U
 wkfx43Lp3KqKIqiZapNpSfzTn4GJcgmnM+6B3FMw8lXUJ6aua3BjPKfbQGoPEqfX/3H3
 6hqTWrHkLDeammd63ZV51xjvDl1l/GtGO86WTyLZ/l8HQUVBVBttao+MgRdqAumiv1lk
 eo8Q==
X-Gm-Message-State: AFq9FYKJPDi6ybFeV1fyj2Xg210ds8GahpUcsCF6Rm0M/x0iWbmtH+MC
 8z4MPF+Yhik/avv7ck0Ceags82iyxFRBp+I8cYSMm0G+nWfw8BMpNfTC/kdFhoP59px/wDIfer/
 +YPLmroLYmTptOPNy9jNBtKqR0qbcC4E=
X-Gm-Gg: AYBFou1W/SSKXVtd3/JO7tII7TGAesMmQYhGYA14GGpzkSQ5+UwRbbp/vh8e2NYSxKk
 lZ6HQpsLCv1ZWiQWqsMmQkf0Sje1r4eenRZ7kysWjlzY04wNYqG4gM1otW/XlCjfi8AwCff6nzO
 DTU59wgYSLo9/I/TmhxLNDEd4lv4uiNdOo5PtNnQipzGRbHz3qh0/ZzCrIxtmT4R5GJMsLfKxGg
 CCSYtpDtdwEehkx3lh2ZrvB+CazQOCHj2bBUKUWgTUrgjXhI7xNXbqXNOOfkvQeoP2Wzl76QUVv
 FCJorup7AoS5v4IpFytdnRWLnBM6wpon1ucgLVy7CgfJRdFZHDpCt7ez0gsNcuSYgaDJkZSGghE
 HOPUBDKsu5XdNQgeF
X-Received: by 2002:a05:690c:3481:b0:8af:1843:a9e5 with SMTP id
 00721157ae682-8af1843bbb9mr6462307b3.23.1791130750729; Sun, 04 Oct 2026
 09:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-17-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-17-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:18:57 +0800
X-Gm-Features: AclHuK8af1MPViklR1Kdl2_E6gteyKVfv0DqECsuNaIziOq-35RO9Gwi_qRtcB0
Message-ID: <CAEUhbmWYkkWYkfSik_Q2XcW8CB+j+6k_ecqKZ5unac2juVWd3g@mail.gmail.com>
Subject: Re: [PATCH v2 16/30] hw/misc/Kconfig: Remove redundant
 USB_EHCI_SYSBUS from config IMX
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Oct 4, 2026 at 8:33=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Since commit 464ce71a963b "Kconfig: Extract CONFIG_USB_CHIPIDEA from
> CONFIG_IMX" all relevant i.MX SoC models select USB_CHIPIDEA such
> that selecting USB_EHCI_SYSBUS became redundant in CONFIG_IMX. Remove
> it.
>
> Fixes: 464ce71a963b ("Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IM=
X")
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/misc/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

