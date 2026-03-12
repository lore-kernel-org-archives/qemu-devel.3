Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4576D106ACEC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nuq-0006X6-CU; Thu, 12 Mar 2026 17:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w0nuo-0006Wh-Lh
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:49:58 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w0nun-000350-5R
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:49:58 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8296dabef74so1461358b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 14:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773352196; cv=none;
 d=google.com; s=arc-20240605;
 b=SVoAwa9DBHxlBnHjRMeHW7MnO8Oh7I32h0q/ixlPKInnpXywDmIFBXWwPZRyZlz/I+
 kSksnshMkwy1sUl2Cw3qYNKhQR0AvW0eg1fJccec3g1yQlVYsiJ768yx1dGnZOI0iZcl
 FCcG0miMubJm7/nLen5fTiU2+BD+0IU8PLZvwwr7nHo5DfOHc791PiSij1EthJLil33k
 1cDYtwUVjBE+4szoiuXBzsXR1neYLrLahEbCeXpCtX9TfHjqscxvjxyesuHdLkDhIvmH
 +cgdjct6nE9CE28SP/VW5r6GEqoh/LWIZYhSs719mpViOqPQ8mJ9ZXGWod7lENaAY3Y+
 RLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=37zosX1V0WBicCHOfzGBlycixqh7WVqmbY2hd5ScTGk=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=SXbEG/ZmFdV+zyPxC7RhatVdgr5wkAuxFtrT451xm5JXoQc1JWTKObvzpXtpNIrU5F
 D5+cHlFK8Rxvf7JVUr/89W8uByAqVJatzEYoQXB0BVt6OFy5j10a7Xrwb70A9iZQ/qeT
 nyKFgyMrw0zvZ8HHfY2zFNFwehxdCHDeiWxQVXWRKzQLcA5CmGx6TD+pwlxpdaTNdL95
 oXeqWiVqf+uHN8Lp7yf0Ieue1KVq4KCCRcqCyyy5mULLv7I1dTLDJ46YURK+FKnMc58g
 svCpCqwMFydDQSQSFE+mp1+voffifwT3i34Uoz6TYPN9W66JFGHjt2t8qaXfJcxrtxsB
 6Ktg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773352196; x=1773956996; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=37zosX1V0WBicCHOfzGBlycixqh7WVqmbY2hd5ScTGk=;
 b=SEqGbKX4JHGFlCNnRYI/vCUDs1QWwUrWWO826WS3QbyUXbLasJ/ZL/Lj6tCXDbuSqo
 jiVqXPwPF3EId7GipLjmXuQRcRUEOJV7gXgl68IKVxapd45cieNLnEJVYTi/MT9pAUVg
 PyIpMtNl2+8QDvMueyGOgUryI6iN1VhcMg9WDSl1H2qncyuVjqdk1MEOl1loTDL8ehQq
 BgoJwcGHM/eO8DOPb+fgCBolH8qx71JeXa5QgfWGOiYssiq/gmgkpKzq/0qVJKvx+YdV
 ZraKEqNWHVTiFe6F5ByqzSN2nqOcAGTs+6R9DR163FdLdgDeerLk+LxhCpmaVVNn6h8W
 hm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773352196; x=1773956996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37zosX1V0WBicCHOfzGBlycixqh7WVqmbY2hd5ScTGk=;
 b=wKSkxiNcFrnKkQk+xtEUYWY+Ay/QXvOAAsGzRhdk77VKGt8TrnyS0XaFWJ6rntM4Qq
 uae2sbOpCbW2Oy0Lxu0r/Kgv5NT03DsiqI/jNVIkLU60Y77vqeCQB16UQEnCjgdJaE1z
 zepg+2gAPD2NQaCVh9IjemprZNDsa1UeC7pjq1Yi/8VWFynCo1bOAygJaqYlhiZabbie
 oouhUHIrTGvBirF5nEeRtulwyW+aWvOD7WSCAQL4wAWw6ME+rMSHC9QxORnwqFh6MhZ5
 JEqCSkjQgdjwPv2dYjYDNY1/jqM0PAzDmwcm/MU4IIEvEphhuCl6w65alSdc+N7FjlqZ
 dkJQ==
X-Gm-Message-State: AOJu0YxFFURXel0iaFbspAYN8jJtJ26iSP58f8GBe0elkD5q284UhfOR
 YOwJtSVqyYzgZaByx1SebchEaQR4qmWZncEnKAjqpMfd8P0OQSjsbl5nEjerktKOxJ055nr8Ppf
 Y94vxCUrFkCHuee67NeIABPhkJAAbQpw=
X-Gm-Gg: ATEYQzzMNWqjriYpjhpr0Y/VtCGhk305tBmxMXDkwlxG3ew9X/BDKdgjCFnlDLT1LIV
 PpfQ9UKVQ50lrvkm86fjQAB3m95+sQSmXt9CLpDE33Crr2+iI4Zz4m5yZeVBzrIOWsOULayC7aO
 a9IeVx6bAPhCGGNrgQvGd2BxusPyiMopguiPcK/4wUtuSWbRmVtRWwYGTRvF3Z8XgrToE/tqej2
 0+ZmUIxFZ3YUj/1dB4L0deQtxUf6HJo+QnVpGDtXd88p3v+nl6IWwQ9dyYc7qK2PgAAub1M2REK
 kml/NqNbTpDo0IdVHv+vYAPczn7dc1S/QbQNjw==
X-Received: by 2002:a05:6a00:7589:b0:829:809e:8981 with SMTP id
 d2e1a72fcca58-82a19898505mr674905b3a.31.1773352195697; Thu, 12 Mar 2026
 14:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-9-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-9-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 12 Mar 2026 15:49:43 -0600
X-Gm-Features: AaiRm51CF7zqJxWwUvycW3EhpLNs9NxiVSIiqgtoUsQ57j-kT9HrcrFsrwuVc5g
Message-ID: <CAATN3NpRutT228cY8MmHT-EHgDBWTV2APxTXZ_1A7_aP7Od6wQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/32] target/hexagon: Add representation to count
 cycles
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000afb0c1064cdabbbd"
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000afb0c1064cdabbbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> The PCYCLE register can be enabled to indicate accumulated clock cycles.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 1a3c9014455..ee2e5eeece2 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -129,7 +129,7 @@ typedef struct CPUArchState {
>      target_ulong stack_start;
>
>      uint8_t slot_cancelled;
> -
> +    uint64_t t_cycle_count;
>

Should this be guarded by #ifndef CONFIG_USER_ONLY?

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000afb0c1064cdabbbd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mai=
lto:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
The PCYCLE register can be enabled to indicate accumulated clock cycles.<br=
>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h<br>
index 1a3c9014455..ee2e5eeece2 100644<br>
--- a/target/hexagon/cpu.h<br>
+++ b/target/hexagon/cpu.h<br>
@@ -129,7 +129,7 @@ typedef struct CPUArchState {<br>
=C2=A0 =C2=A0 =C2=A0target_ulong stack_start;<br>
<br>
=C2=A0 =C2=A0 =C2=A0uint8_t slot_cancelled;<br>
-<br>
+=C2=A0 =C2=A0 uint64_t t_cycle_count;<br></blockquote><div><br></div><div>=
Should this be guarded by #ifndef CONFIG_USER_ONLY?</div><div><br></div><di=
v>Otherwise</div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:lta=
ylorsimpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div><br></div=
></div></div>

--000000000000afb0c1064cdabbbd--

