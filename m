Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC29CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDP06-00086o-BH; Sun, 04 Oct 2026 12:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDP02-00084O-64
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:23:42 -0400
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDP00-0001uR-Nb
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:23:41 -0400
Received: by mail-yx2-x0f.google.com with SMTP id
 956f58d0204a3-671563fb8beso829929d50.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791131019; cv=none;
 d=google.com; s=arc-20260327;
 b=AwSMFpJcI+jFin89D4rT/nuv1f4R1eu9zEbHyThDHD7lNrCWh4pd/EqsN+7dWYdFov
 bjbi9YSjHM64pPq0+hSwyoYq50aDSg0auRnHYmq7DmxETyg/f/ips08Fu9iUgiZDKprT
 mSfjxjLEcqb8SKxeQYg3ldU0/dex/uA0e1MzDNePmi5S/dUALMOcEBHdUrb0DngW3fmW
 EGyHH37+LAXQeTIVD/pgAhDW0P0DFhkyeaQezqjo+q1Kz/U5661z5ol4PQsy1tkgEq6i
 lCT0wwNqyvKsuniBObMa8CTIdjIhoNTMDJR+4e7EcFsO4q+hvorOhgP2Mw0h53+yswlr
 4e+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QvePUYJSZlCAOhsi+yrewZbslyAkmaf0faPw48P0Lp4=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=HGYCGrxHQvSs+CEr6RFXK618fv7dprfBrG7a55cHS2Su9HS8vfC/qxDAy7Hz61vMge
 TSMCKbliM+MixEJNhWq6CQhcmaie4Nja257oV24wEKthOS470D1fYA1BaLYfyZ5b7AVl
 sTN/A7fpqZBi654dTexcTDG7psC6x/G8BZph2gNNgyjXw6P22uhpNbN+65Cxal5z4Yuz
 W0i2bxx6wy+RZy0k9U6Q4FmChfaEVw7qQkAen2RmrQxt4fhlnKPbcjE7SjfuoiX/lk9Z
 DTpllXFKCH9xsE8qnK4tBJ2weq9yGsP/XYHMs/SCJ+2wMQErbrfgCXpsgn1BOjq2T/lT
 h4OQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791131019; x=1791735819; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QvePUYJSZlCAOhsi+yrewZbslyAkmaf0faPw48P0Lp4=;
 b=oisCxXISF/30w5xs+DNFUmDyz6/leJ1o7ZuUraycpI+aJCkfPU4fWbThEm+RDIj59V
 abWnsuUNykg09o+xySNiCeen8DkZCEBKYWkk8udVZvcH7az5sYyzbVTBACxAQEiuY2rD
 22MVLJrAslBDOnqPeiv7jTKASS40ZoUMdwdVl1wI6A3v5USH1DzWlTkLrA22lF6oETJE
 d15eLabyJHSjtTLjVm9X5xgN0hqIHBrhwffj4iu6Lhrdcd2KtS0EYGKWS5xvvt1DZe3O
 Lfd8SzzSVhdR2h2MHmPCueb75IPJQKLidxyLzgt5FMbH1fQCFVYDLrPTAZcXACorhVxx
 0N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131019; x=1791735819;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QvePUYJSZlCAOhsi+yrewZbslyAkmaf0faPw48P0Lp4=;
 b=Bh7kpgXl+SnEKpDLqB2dnia6bLooMxVpfi1BYC9acTuEVLz/C/rsygbdGQQPzz0UcX
 HEcJ7eUKkdaM5cOn1hBYULG++OHlkeuiFZsurXmhuV2Z195h+DadIg25mMc9O+4/3Jlp
 c2TOSAQbP+04HhtpfJp6dbahZk5AaET+oDnezeqstZj7m9S1RBIRKrKuw5GUi01uNqw5
 m8NfSuDpDcs6Gj2Qw0CWuHo7eJmqSgunIsLub0mPH7+If6BJpQASCC4kNkXlqXunDzRf
 8HgF9pFYlwy3fqRALNqbQM+Z48wbOAGxQquj+no8r0xf2r+equpLasuddSUSwq66vE4m
 xl9Q==
X-Gm-Message-State: AFq9FYKa0RKKnbJQ8DeG8T6eNYwia4OIT+gNw/+fixTRINW+lihgSw/h
 pDXNTP+dJWP8uKkWN0vpKfG3P7C/dbFpQFc/fQgz+0uVYnsUv7yZIqQvQwx64AEji3CDmOC/p44
 dQzQInmJd7Vxk6Z5A9hh4KVxnrvR7URk=
X-Gm-Gg: AYBFou1+VcmwL3f/TRYRV1N+zN0d7mg1z3zu0Zq88pbwuyhsKo17KuBSqcImTev4WAk
 9OqdJMnRxzErU+9Kv/ypuicYRXRKtKrA989aHwHsBikoU3UO33y69f6vnSnEXoYKhc7tv/ZcI/w
 zuHRPmLKg5xKVbAqmkEr77D/KoQHwNowhHPtwnmjnsKp+P4p/2F6YQqoqczXpM4HTIpMbvqlAkc
 4VyE2SGWR38xaQNMzjcTxT5y6B7dnFgaI8AjACaXqv8XqoO8wmnGJghtAYksPVg/9h965SUIkoT
 KhXCx8Yyy8Lx+PXq62nNWvFPVYyXTybU5HfhBbOCP6DTAi87rg0H7ObRCw/Srkh/Ct6aOMufDXc
 01QNihHvfiYwzcILv9EFySEaJNQ==
X-Received: by 2002:a05:690e:d86:b0:677:b844:c5a0 with SMTP id
 956f58d0204a3-677b844f9ebmr2163632d50.81.1791131019635; Sun, 04 Oct 2026
 09:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-26-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-26-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:23:26 +0800
X-Gm-Features: AclHuK8C4hYubfVbBYgXsXvN-zZGVXVmc775n-j4eVzSS6vCuLRIo5OxJTiJneM
Message-ID: <CAEUhbmU3+FLnssJrET6bg533JXqg2wo40oxEtL-XL4C02aQeag@mail.gmail.com>
Subject: Re: [PATCH v2 25/30] Kconfig: Extract config IMX_EPIT from config IMX
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
Received-SPF: pass client-ip=2607:f8b0:4864:41::f;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Oct 4, 2026 at 8:32=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config IMX_EPIT to eventually eliminate config IMX.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig       | 4 ++++
>  hw/misc/Kconfig      | 2 --
>  hw/timer/Kconfig     | 5 +++++
>  hw/timer/meson.build | 2 +-
>  4 files changed, 10 insertions(+), 3 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

