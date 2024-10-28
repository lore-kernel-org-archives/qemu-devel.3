Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B184D339AF
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 18:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ULB-0007Sk-D6; Mon, 28 Oct 2024 14:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1t5UKr-0007LI-By
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:19:30 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1t5UKp-0003Fn-OQ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:19:25 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539e66ba398so2785e87.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730139558; x=1730744358; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I9KpKqmLLGgWQg4P3FM7fUf1XDrH/wvRuXnmbYM3Wa0=;
 b=TrtiJPS2nMYzDDJifz04HGa+6f7RJl1gILbrX6K+3pe38Rtik+0bu8HebCHD9hNI6H
 alJEApvBJ6dsrlgHYmU8FrguH7bvmOu5cv1ehEprz+DfSD2SqKczErlGIP5HcXfpqtk6
 wLdilKuzZAR6yMYSzOEXGru0P6qzskWmdLb12cH35ePzPV0w6LbPrQT69WTwGnGctQhw
 jOeCw3/Hg6mkxjOzIpM3IDpewxZ4J8Bhf8vwjNRtiSzK/k/i+eOdl6AEULLS4zGjawGi
 znuBSapldFQMlWr4//S2niiSTCeiXP751kn+/1yO9LZcPzK+DxGpVN/zvPpxCm0lDqun
 3vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730139558; x=1730744358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I9KpKqmLLGgWQg4P3FM7fUf1XDrH/wvRuXnmbYM3Wa0=;
 b=SyIgpwwfm6mxm5FA1jZiv4k4nJgVKEvnBeo4fcdXSLg+C5FdOMkqhPuNbMBrnd9JO5
 weSdK9RhlAC6nio5bXwYMq3uUS/AovxcBeruL3xyj7V+HmjPKNRYK1k1hHDPPkOzHQ5V
 qbVnizNxIMRKK7jcuiGSEVkXfMbKg8ZL0EJZ5Pn9BxgI1ZcyWH7U67JALh7bpK7ykfTs
 k7HOxl+0wGgHe6p9lCYUihcNmyovvKfXS0LwQ6nyWbZEcaMsGXPZrXY0lOjNXK/Gvsh5
 HInwQtDTVWmqErF58FUHNE71k1a5YWFz8jd/r0T/+K871heTQg032xeya0ch60AvC0LK
 1bgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuN0Qw+7VX7mVn9UaaZqZJUowdMQwamCW4IlmWIyrhWzKUaTLOnY4WpmPYQumQk1VhL8Ul1s3qmCLN@nongnu.org
X-Gm-Message-State: AOJu0YyZR/8cXYUgaGQhKKVbarwge9G6J/ORw26Bq8Kk3iuaU/pdqK9c
 mCY2SnZ3+a4WCgI6NjLczwUY2JuVa9jkDkdhmIwN0jJI6O0nOtCSeud2B1Rn9nFr3gBOufNQcJD
 tu/X52oHrd5IE73npsaPoHlC6G1WMh1MDgyvD
X-Google-Smtp-Source: AGHT+IFSow7/H7wTYdQYqWSsLp7XO0afeI9AEYp5qH8pO3c6CIBoAy8TE/PH7Ky5liOdOYn2WRdF5m8X+1t1KmRHj2A=
X-Received: by 2002:a05:6512:4017:b0:538:9e44:3034 with SMTP id
 2adb3069b0e04-53b480a3b88mr19500e87.6.1730139557940; Mon, 28 Oct 2024
 11:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241028181420.1438938-1-venture@google.com>
In-Reply-To: <20241028181420.1438938-1-venture@google.com>
From: Hao Wu <wuhaotsh@google.com>
Date: Mon, 28 Oct 2024 11:19:03 -0700
Message-ID: <CAGcCb13zjuH4dAspE=dAdWZXG88b5e3OkGFaE+KcwcWDjioyUQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: enable at24c with aspeed
To: Patrick Leis <venture@google.com>
Cc: clg@kaod.org, peter.maydell@linaro.org, steven_lee@aspeedtech.com, 
 leetroy@gmail.co, jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, 
 joel@jms.id.au, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c3bb9306258d814a"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=wuhaotsh@google.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000c3bb9306258d814a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 11:15=E2=80=AFAM Patrick Leis <venture@google.com> =
wrote:

> Enable AT24C with ASPEED in the KConfig because the boards build this
> device.
>
> Signed-off-by: Patrick Leis <venture@google.com>
>
Reviewed-by: Hao Wu <wuhaotsh@google.com>

> ---
>  hw/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index e7fd9338d1..1b25e73578 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -539,6 +539,7 @@ config ASPEED_SOC
>      select PMBUS
>      select MAX31785
>      select FSI_APB2OPB_ASPEED
> +    select AT24C
>
>  config MPS2
>      bool
> --
> 2.47.0.163.g1226f6d8fa-goog
>
>
>

--000000000000c3bb9306258d814a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 28, 2024 at 11:15=E2=80=
=AFAM Patrick Leis &lt;<a href=3D"mailto:venture@google.com">venture@google=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Enable AT24C with ASPEED in the KConfig because the boards build this<b=
r>
device.<br>
<br>
Signed-off-by: Patrick Leis &lt;<a href=3D"mailto:venture@google.com" targe=
t=3D"_blank">venture@google.com</a>&gt;<br></blockquote><div>Reviewed-by: H=
ao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com">wuhaotsh@google.com</a>&gt=
;=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/arm/Kconfig | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig<br>
index e7fd9338d1..1b25e73578 100644<br>
--- a/hw/arm/Kconfig<br>
+++ b/hw/arm/Kconfig<br>
@@ -539,6 +539,7 @@ config ASPEED_SOC<br>
=C2=A0 =C2=A0 =C2=A0select PMBUS<br>
=C2=A0 =C2=A0 =C2=A0select MAX31785<br>
=C2=A0 =C2=A0 =C2=A0select FSI_APB2OPB_ASPEED<br>
+=C2=A0 =C2=A0 select AT24C<br>
<br>
=C2=A0config MPS2<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
-- <br>
2.47.0.163.g1226f6d8fa-goog<br>
<br>
<br>
</blockquote></div></div>

--000000000000c3bb9306258d814a--

