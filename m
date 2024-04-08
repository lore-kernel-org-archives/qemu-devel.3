Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F42C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 10:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtmHD-0007bx-RR; Mon, 08 Apr 2024 06:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtmHD-0007bp-0G
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:30:59 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtmHA-0004Qr-Iq
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:30:58 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e509baddaso972693a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 03:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712572255; x=1713177055; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etgbE+5O8ZwJouD0570OJAdfsHFSf4gt23LHKfX4rIc=;
 b=NfimQ55BDfL919SUuLwfKqGDWKaM718s/zuRCGgXarSc2lCJnc+yvOJUFbgZrt+FxW
 Vz+GE8ojxZsnwkXN0T68tVCNpU74y3P2hajNZVIvN1118weAdTQO/5lqvdCbICtHcxak
 ltF7ZG0z8KgL21v89SHmQqlVM6X5wbJcCmsijB4+w6rJbaw0yFLYJ9H3vwCetDJTzqeq
 eltc8oI5J8QA9tlBvvSkyLOFjN0R57gswNOQiFLcTEMgCGQ37vS0A6lR1AVU0nl4f7b/
 OuLQctH8VVD5+yu+zLIu4Lk7y17LpWsM1r9ZhTOpgrAwZw2SE+cUqlvj5NyyhPLkWSwt
 8Guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712572255; x=1713177055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=etgbE+5O8ZwJouD0570OJAdfsHFSf4gt23LHKfX4rIc=;
 b=ltnogDE8B1awRQouzoQxCDyxWs4O8ylF+YLqbSFE8JAUNDMNPYQMNwX8RaCFrcuz5N
 wqnuiQYvoPby1f1++Eny0VvwrjAS6gZdwkCnxxwekRG5AzSnCUb1LK2lboHJ4HdX0aXW
 Jattrd8F1z7d4she1Z+8x+rQTqEuKvYiHCij0kBjDm8Gw+MI6Jvj0KvpnG6dSkmKtSL0
 bTHSgpB9aS/6+fNhm8Y8T7d4mgCYjuphX3DNMOuipBWPbg4hbKkJ0NZeC3A79tb/H9vq
 sunVBvrDap9Cug+hZss0TZVKqDLEY1gq7rSu4FP81YG2XnU2Pk1RDHcxiIx7iXgvx3fM
 fkFA==
X-Gm-Message-State: AOJu0Yzsr8KDWsCXLHgybjCLWuqZOJIyFKSf7MoBKiLErYBtp90/t0z/
 FQ9JB+MW3m6E3xChRnG3hSkw7pIMYJFJ4nphS8vzQA2puQsF8xVoZu5ZhHPmUv6vfYyaXlo8w1X
 q3ty1RY0H5tOVegJa40zHphdtSfGSzD5QKBIHcg==
X-Google-Smtp-Source: AGHT+IHJxrUfHHlYIUWSPsDozTgnS0NFsUnaRRhf10tguKwkSk8amKrovCAh1UTDu8C/MpEEWkopuPrKVMgVXp+aCag=
X-Received: by 2002:a50:baec:0:b0:56e:241c:3f3d with SMTP id
 x99-20020a50baec000000b0056e241c3f3dmr6486134ede.25.1712572254697; Mon, 08
 Apr 2024 03:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240408095217.57239-1-philmd@linaro.org>
 <20240408095217.57239-2-philmd@linaro.org>
In-Reply-To: <20240408095217.57239-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2024 11:30:43 +0100
Message-ID: <CAFEAcA-v+HzTH2j_UApdLijm-ARUd1G5gUcRb0X33Nj-XYAcyg@mail.gmail.com>
Subject: Re: [PATCH-for-9.0? 1/2] hw/misc/applesmc: Do not call DeviceReset()
 from DeviceRealize()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Zheyu Ma <zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 8 Apr 2024 at 10:52, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> QDev core layer always call DeviceReset() after DeviceRealize(),
> no need to do it manually. Remove the extra call.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/misc/applesmc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
> index 72300d0cbc..8e65816da6 100644
> --- a/hw/misc/applesmc.c
> +++ b/hw/misc/applesmc.c
> @@ -342,7 +342,6 @@ static void applesmc_isa_realize(DeviceState *dev, Er=
ror **errp)
>      }
>
>      QLIST_INIT(&s->data_def);
> -    qdev_applesmc_isa_reset(dev);
>  }
>
>  static Property applesmc_isa_properties[] =3D {
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

