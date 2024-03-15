Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454C5C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 16:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlAb3-00080M-Lg; Fri, 15 Mar 2024 12:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rlAaw-000802-LJ
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 12:39:46 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rlAat-0006gM-JQ
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 12:39:46 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a466f89560eso287818466b.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710520782; x=1711125582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3BJ+70MnWU8jvhVqOWXYrc/s+eGuVzDpwMTXY43zKg=;
 b=TrP/ttybeLGHDoo6eFGj49+Ee54u1hFtR8Ju+1hPxnvBiJW3Gb0jHp8BhBBUa2xqnq
 9RTL7pkGXNCaVfJAsrYcUDqDS2EQXuSTuZDW8Yf2pi7Gk2Dxi5ald9G+h1QSZzvtCcDH
 Grbjauxx323dal9Q2FJI8xUk6Na9ZmG6kJLSO0JrR+SME5N710Ne4tp2ShF82z+3QHzB
 15YmEkWNgXK0hxu4hZRdlSjOvrE9iwXDtiSmsYPtwWpRj0NzDNEymgOzMhZE5y+Vfm2S
 hFIaRYQ0s+3K+BVZekx2Bh+QOPEqzWSfkMOTTCB5C5NB0MIbU66dexfdnRejmZA+N+k1
 IjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710520782; x=1711125582;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B3BJ+70MnWU8jvhVqOWXYrc/s+eGuVzDpwMTXY43zKg=;
 b=BLXnkqFZ/sUFnw7Rpb7HYrdoGae52I+XCaUeb/R2DDXq49KtogKpHv3z/X5Cc3pZVS
 aaR6YUqigXr8HPBb5DrQ5puJORckyLQvLRLoG1SWEV+GQCEJWlo2DCp50VV+LdsPZGto
 lseJVLl+HhDsIRWiiTyIYqIHfOWUm/uVapGsy1kLz7dm+qQU1u262/WynMWwbyw89V8W
 9LyHG5qotz53pnhuLUhhfhIWi7OaNjE3ewofMykl6whTmtOGvcHa3g8EpU1VPsNbgulw
 3wm95AoJco+m/PJa9Jon6G1wMygSc9mOloc9ZSb4lI90a4x+VoFLxY22cphCDFS5zfi3
 Ys0Q==
X-Gm-Message-State: AOJu0Yxu1cXzoNJAHsFFZpF6meMKOFZBnnN69C7LCvKVBpbZJQN3zKxQ
 IhQJ7nGRC7nYtW2oVi41XplYxlmp0Ht3ZPtwZJg0tWKwxk0PpXo3dfkLDz+2rLU=
X-Google-Smtp-Source: AGHT+IF9ywiAFboEu2cNiVyapUcTWi2oQLL2zhX1VwKioSskAS6RB+MhHatTP7JdByyMF6Kjhhm5Xw==
X-Received: by 2002:a17:907:6d1d:b0:a46:8d95:ff7e with SMTP id
 sa29-20020a1709076d1d00b00a468d95ff7emr1964813ejc.21.1710520781810; 
 Fri, 15 Mar 2024 09:39:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 wr6-20020a170907700600b00a466c66804bsm1831116ejb.49.2024.03.15.09.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 09:39:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1A5965F873;
 Fri, 15 Mar 2024 16:39:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lorenz Brun <lorenz@brun.one>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Fam Zheng
 <fam@euphon.net>
Subject: Re: [PATCH] scsi-generic: fix io_timeout property not applying
In-Reply-To: <20240315145831.2531695-1-lorenz@brun.one> (Lorenz Brun's message
 of "Fri, 15 Mar 2024 15:58:31 +0100")
References: <20240315145831.2531695-1-lorenz@brun.one>
User-Agent: mu4e 1.12.1; emacs 29.2
Date: Fri, 15 Mar 2024 16:39:41 +0000
Message-ID: <87plvv30vm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Lorenz Brun <lorenz@brun.one> writes:

> The io_timeout property, introduced in c9b6609 (part of 6.0) is
> silently overwritten by the hardcoded default value of 30 seconds
> (DEFAULT_IO_TIMEOUT) in scsi_generic_realize because that function is
> being called after the properties have already been applied.
>
> The property definition already has a default value which is applied
> correctly when no value is explicitly set, so we can just remove the
> code which overrides the io_timeout completely.
>
> This has been tested by stracing SG_IO operations with the io_timeout
> property set and unset and now sets the timeout field in the ioctl
> request to the proper value.
>
> Fixes: c9b6609b69facad ("scsi: make io_timeout configurable")
> Signed-off-by: Lorenz Brun <lorenz@brun.one>
> ---
>  hw/scsi/scsi-generic.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index b7b04e1d63..ee945f87e3 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -752,7 +752,6 @@ static void scsi_generic_realize(SCSIDevice *s, Error=
 **errp)
>=20=20
>      /* Only used by scsi-block, but initialize it nevertheless to be cle=
an.  */
>      s->default_scsi_version =3D -1;
> -    s->io_timeout =3D DEFAULT_IO_TIMEOUT;
>      scsi_generic_read_device_inquiry(s);
>  }

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

