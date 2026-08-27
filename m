Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C34FC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVnF-0006n2-8q; Thu, 27 Aug 2026 04:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzVnE-0006mq-8t
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:49:04 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzVnC-0008AO-Me
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:49:04 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-836ce6cbe1eso24389187b3.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:49:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787820541; cv=none;
 d=google.com; s=arc-20260327;
 b=lHvHAQ/x/aRBAPUC/2urOcutahKWO9vUYOs//YQEX5mbylZZ8ATuh2EaoFf/Q8H7q9
 2HZtBIRTgDBqZRmkNAN0BFRcYYIHLG5eRD9y7u0jGw1exSKA+5shtrKpyeSnbGXqam/9
 tgaNaBpHc3hkWn2Hchr8EfObARKwf3tpRHby7ITdJwe1IPJep1LR//o5CQwW0J7wcW4a
 kdvAGIb2/1qG0pyqGcCs/wTPH694W7kruxPlImU/k6DJX5nINUnsVua0UnMG8VkpA8Ql
 qXturPLJ1wtUUA90s2mL9xdeLaljKFvXl1hQnX8lPurriF0AuxebB81aZIbDs6XkZd53
 ca7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rR4F7voyXnR3OapohUC/RnVoVjpb/JEA6/VILqsxqlo=;
 fh=6BO/J4gjMuMAc+trLHU90Lj/JIm5nm/1p4XD/1+2pog=;
 b=pZ9xurotKxrb2VLpD2RUq9jFYBBraVdtIw3quRJwMiA2qPt2pGLLEF4hBI3gQ+o79l
 MM/xXuP8qXr47Z3WKmAAs727SLBYAI1rfeesKC/98xDBgoquTUGw71YGM8BvV8p9VpSZ
 0T5ubfEnSMw19PxPOUaZmQzfmZ1z1OggOABrhaFALiD8kTaUhCIe15REY+IUru3M8i1Y
 TkBtQjQ8PjrAVdzCpLMe6QbipdHb60dU7gqySCVD1SuIJwCUbzhLdMvSSAZ+nfkVcMqD
 N7+WkLZsCgLBCgiufS7jlqigqhDAQDe9V+Y8RvcanHZ9CQUQmqSfz5byA2stEdTdsoxX
 VlMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787820541; x=1788425341; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rR4F7voyXnR3OapohUC/RnVoVjpb/JEA6/VILqsxqlo=;
 b=v95PPL4obSX1XHgscs6xIPhl1oeqgJ4SpCAsjemzOWpX3AvH49apmYPvz3VWHCCY3c
 rhFljr1M6awvwLYVktNqdQPgoU6ovWDYAKvOPhGJX69yweMSFtDiBDVg08qpj0oTAsmQ
 BKovP++aVUIEd9kBM8Og83JZp92xz283FKVVuhSBaoG07RbcflJYUc/H6xds1qn5Q5Fl
 kBEKyro3D9POStgYOG7iFWUZyGT+HsPangGYgC/S3MZH1mPrC6MEufPgVoFvf2lxYNm1
 OtgQxy4VbeNTvCkH3wmZbw3GLyqCLEj2hMix4X6sBnWBMVIsvyAmVyEealKE0G+BjA7a
 BsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787820541; x=1788425341;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rR4F7voyXnR3OapohUC/RnVoVjpb/JEA6/VILqsxqlo=;
 b=QKC48y/RJj1aa0L9/pYU8aTM7FBqvPx4oAIFVURqfpX7W/+ohKGkaV0YEfM32QM1QB
 hm+JyD4SxfnDcRhTrRasNZrYqanPWr10d4q5VvNWtulfNYZ5kfhJqa+D3siz/nrf8kYB
 cxI2t/EuaUpg9668ILd6Y+mleJHKhzn3HnAcmsu0Vh3YLaynVei1YmMy4FJMnB3T8udY
 gPSJj3lRKgO6JOXHfJWmwllL6wHdFWCay6LrMwDZuWGfbySannNoKTyWHSEu9M2pItMo
 +MEVVg+jS3rO+YIrIlDdWpCHtx+eSUdplQ9MR3NhdU4WyNhFTiWHLpkxL1qFwYAL7c0b
 wcXA==
X-Gm-Message-State: AFuF++lodlUFmBgo9LClodPYLSoE/vRlkFOj2FvFjiztd52XjQYykmUR
 mcwGyCyG4lpBJy5Mcage+BvR8zLmoTUmfJ2LSzUKO8Dtrl57JS6IRwCELEKxX5jbkcVlXNdON4X
 RMeH506t5RW4tIwL4XMav3M2ZNkb2yDKXpgcXZ5S7Xw==
X-Gm-Gg: AR+sD12s5DD4BCQ+f5IcZvfzjiKzRTDK92XcnGCLBPcdoLVGgJbVmkGoyWB/Yki3DZI
 UXXhtoXToJ19Djt9w/3FySWmBpw4z3oaZyd7d5yvKPhLsPcoD/9yuaU4ka6nsl+ueR6WrX1Fb9N
 R7jy/20Nx/Cc+sz420bLC1i8JBJSkXHVGrv/F9g4CSe3/GaX4BlKw69ZlQ3ZfG2v8NURbH+KNpI
 mY8taLbLpb1v/zjU7O+TO9gD2MqRbsam8nxKeuC6JEeXC3xYIXC7RmUWi5Ki5DkQuZlwKKD2RQ7
 L75fh4ra7kScheqPHrw9dwXB8t2455kGvtw5nB3jqe3lM+VlesrGNm9wvTeTlavYBaXnMeV9Oqj
 XxFU4yQndsmJ6nBuh8FFKz1BuiEld
X-Received: by 2002:a05:690c:4b8f:b0:816:b469:ccec with SMTP id
 00721157ae682-8573cfbda13mr62400057b3.15.1787820541434; Thu, 27 Aug 2026
 01:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260824122942.85863-1-berrange@redhat.com>
In-Reply-To: <20260824122942.85863-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 09:48:50 +0100
X-Gm-Features: AcwNN1UlR_z5TlMyx9ikvGktsjwJYqOUmo4wrvnsvzftJY0CmjWs8ST02xkej0M
Message-ID: <CAFEAcA-P889KqaTK5NUDQ8Y4ZoeHqUTLFSdoGcO0T_9n05BduQ@mail.gmail.com>
Subject: Re: [PATCH] system: improve -mon deprecation warning
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 24 Aug 2026 at 13:29, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Expand the text a bit to make the new syntax more explicit and point
> users to the man page for further info.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  system/vl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index 061cbdf860..d5b5392569 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -3239,8 +3239,11 @@ void qemu_init(int argc, char **argv)
>                  default_monitor =3D 0;
>                  break;
>              case QEMU_OPTION_mon:
> -                warn_report_once("'-mon' is deprecated, use '-object' wi=
th "
> -                                 "'monitor-hmp' or 'monitor-qmp' types i=
nstead");
> +                warn_report_once("'-mon' is deprecated. Switch to either=
 "
> +                                 "'-object monitor-hmp,id=3DID,chardev=
=3DCHR-ID' "
> +                                 "or '-object monitor-qmp,id=3DqmpNN,cha=
rdev=3DCHR-ID' "

why the difference in id=3DID vs id=3DqmpNN ?

> +                                 "instead. See '-object' docs in 'qemu(1=
)' for further "
> +                                 "configuration guidance.");

Personally I think of the HTML docs as our primary documentation
and the manpages as a kind of "not very well maintained extracted
subset", so I wouldn't want to point people at qemu(1).

thanks
-- PMM

