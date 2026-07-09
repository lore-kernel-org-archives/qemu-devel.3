Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A902C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whoO3-0002Hx-Ky; Thu, 09 Jul 2026 09:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whoNi-00026X-4L
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:01:41 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whoNg-0000L6-Hh
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:01:33 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-667627ae83aso2438137d50.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 06:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783602090; cv=none;
 d=google.com; s=arc-20260327;
 b=ULYhRDNCgT4cihWcRJ42Nns2zdLcsRQ47HpF/uTT2cArDvPYL/PP9l7BnAtDe5Y3/Y
 4GLxbTdnRF8SwPuL0bFajusMgwjpFA/rVeYkrIrBjhKai6eB2rVych85WSEtpdwCBWip
 roP7MuOAd7qJ4s5bCXcHq6bS8JRSIxj8oDz4sMO3WLs+LqiWjrKBIgx5V6H/U/r1A1VX
 9yBYQFff/0u/8Qfc3yHh/Rf/CVvtoTftPd5yX3szP20+I+61fLtElmnQLZaUWEyjQ3bO
 xwX0PQEnQHzSqdajAkPIkd+a1t/UAgczSWQq0YqI/mbZcjGaXxhGqFSEfKXWEF+fWMhL
 bvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gOxFxPb0fXxfrOTgFJ55wT0DB+UjySCOyk8PXNaDbcw=;
 fh=mHdCTTwfXVEjxku01Hgm+yTOHZkUCpq+RBxvjzVzx90=;
 b=g+OQ+Xujk/ZAY9g0cHbOKHttTP5PWz6DHV3jv2HJUjPfbMhgf0GYouqn3TkPMUws6k
 eqgdD67Eoa23xmNVk0UUH+Nop6A47Cbxd6yjNrg06FkH+4D+do7g9M5qX+ADnjMt+Mmf
 ZHV0mp0Qgywxh3LpzzoLtlrVW9YAV2AL0liT7IXwm1qLhL1yVBQfhSvJT4HHsaG/cUFs
 Zc/XPP58mmkaEAiNiGrMgB3N6gQ9B0+lCisidyRVM8znH9CmXR0NfApX1GJYWKIeBvv7
 a6VvGgMvhhqgNoktEMES11G/NM6LsOCbWIolUefa1PmDIyYS3Hqbtg6VAozutXz0FymU
 CDpQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783602090; x=1784206890; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gOxFxPb0fXxfrOTgFJ55wT0DB+UjySCOyk8PXNaDbcw=;
 b=ubR4gcJVtEOhI6JmN0lAB1+IMWo3Bgtyz5pl/t08C/I1hH8lwgtObmURtfeSuATr+G
 hFcA19BREmXM7d4idqFbkkVi1VIM5ovvo1CTpMkrc269AP9VNjQH4a6UDownp145BReD
 wqHmmFPbciY6HFBxH+1hrq5od69cljPICfJQ4KQ1ZDSM1cLQCW9IpRqoSWhyCj/9bEOT
 UA9tFP81CK3n/LZwMZCJMKSnULglFT7hpvUGwkv0qRd3HriZ05bRxnNPWJ0AuxYxgqds
 rWc7E+a9NzY68fXRAr6+k5f2L2NPxmR8IKBoqTnRc2O3bXm8sJPOfUmSlINbC5/iF6qZ
 RUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783602090; x=1784206890;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gOxFxPb0fXxfrOTgFJ55wT0DB+UjySCOyk8PXNaDbcw=;
 b=O+ztIPKtPnvGda8dtQMd5HLsgy8e/3TgE9jrOVrVG456yu+xD+Zy6pgX0r1/gyEtLf
 1EyMqKP6kE9ch0bBVNFGARww4+W89TRp+6VYxS8OX2xImBLEjvzpDZ0yUFgo/BiBYpGV
 oeMG7ILnm47vmMoWaVAREpQMGSFnv+cnv6GXITf2DCf/8Hqf+rgAnZGEgeyr79DDnReO
 2J8N6UdaCOIGChHp90tlwlc85iF0PvvT9dfL2V/kY2c8Vbbe/hSk/SZcSy8/glY0w2/m
 fPoCeudSMtlIwDxe0+NvxnYF0tAxL5EMv2pbMD031qtfMPrAbDchg+/41ObJlBzu8/Yg
 HWAA==
X-Gm-Message-State: AOJu0YwLOuW7U82lSKN10YyvSNde1/fQX0EqKhIV2lHqTCblQZLnvY6X
 cTu0yxwkuA9OMSrEglJvJTni9d1tmXOKB06kKpZ2LLogL82iEYw5AqdZTVKpw0ONXtSiGl06+bM
 gYBj1JVUb0GzylmdyWFCftkScFWpgwxiceP2wGiCnUQ==
X-Gm-Gg: AfdE7cmnkheRVx/H5XSFqgZyPYYk9mbwFjytcCuZZLstnOsNtzc6LQr6nUCebJxL3vL
 EU/EOu2z2Dsb9DZPB+voesA1bd9dFp9eBumf4LgXuITy/cC9uM4nLSPWQ99T21YKAwWEwxFzVUC
 DOrSYv6icTmIJnZrUD0wuEd7aTQRfJb8JG03a65dFHyen2EN+FBjwy/CCFKUyduPisvY4teMq2P
 cbQvyvdHTWCtgYqaBSl/qhjehZVE6y5bE1mz9wT1S/lMHzcvqBoQcMhJac3zRcTF8Y4/obLv5d4
 99vbl1HP6Dd3Vd+ln+r1FeuCR/H9Bai+bTAKmWfs9h3MvmglAeNEwjg3
X-Received: by 2002:a53:acc5:0:10b0:667:69c:123f with SMTP id
 956f58d0204a3-6679f1cc478mr4131147d50.79.1783602090048; Thu, 09 Jul 2026
 06:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <87o6gge6b0.fsf@pond.sub.org>
In-Reply-To: <87o6gge6b0.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 14:01:19 +0100
X-Gm-Features: AVVi8Cf7N4WCMoBs4AQXOtejW8Wa1_pSR1PM7ntg91TEXe548sunjdMksZ4l28w
Message-ID: <CAFEAcA9goRQuxw3VD7AqUOHHTdOXu8MSfCxdQMBviE3QgGD58w@mail.gmail.com>
Subject: Re: A few Machines crash when "no default audio driver available"
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>,
 qemu-arm@nongnu.org, 
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, 
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 9 Jul 2026 at 12:44, Markus Armbruster <armbru@redhat.com> wrote:
>
> I stumbled over ARM machine musicpal, PPC machines pegasos1, pegasos2,
> and MIPS machine fuloong2e crashes.
>
> I run them like this:
>
> $ qemu-system-aarch64 -M musicpal -nodefaults -S -display none -monitor stdio

> Died when device_set_realized() tried to propagate a "no default audio
> driver available" error to &error_abort.

Is this something we want to have be a possibility the devices
have to cope with? Can we have the "ignores all audio data"
backend be always available instead?

Otherwise every audio device needs to cope with "there is no
audio backend available" and implement "do nothing with the
audio data" itself.

thanks
-- PMM

