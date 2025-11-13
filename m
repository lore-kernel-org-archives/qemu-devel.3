Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65788CD5BC5
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 11:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJVZr-0007g3-Tn; Thu, 13 Nov 2025 06:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vJVZm-0007Rb-SG
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:33:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vJVZl-0007a1-2a
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763033595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WqmTCtcW3ujfxhfBw6wyVEU8uL1dsZiu375KvoDsotQ=;
 b=Rl3zEYcVQses59JThckJMhOD93Qp9Xdzty0Ut39CqlFA14AKrA3e+KkiiUwXNopwwFl6An
 dSi8Zw9hMrz+4OsYHSapMTcDdCLfMwXELcUqdvFjrAMI4FFLACnderXU9S6oBEjnXPeh/8
 L5iWrdJQ3vUrNi7bfFXvq77hh9rz6sE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-0uGoCjNsPaG_4JmuEAITDg-1; Thu, 13 Nov 2025 06:33:09 -0500
X-MC-Unique: 0uGoCjNsPaG_4JmuEAITDg-1
X-Mimecast-MFC-AGG-ID: 0uGoCjNsPaG_4JmuEAITDg_1763033589
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-343725e6243so1882246a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 03:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763033589; x=1763638389; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WqmTCtcW3ujfxhfBw6wyVEU8uL1dsZiu375KvoDsotQ=;
 b=FaoOxCrNcaA+nhxI9B8GnClAJLL56PmyPBknNJYPrjxoJqxXky58asSgt/DioRS/we
 EfB52R2LW33PnrLI/djGr6rl49z9KDrKufXPwZjD8MKU6J2Bw22wvdsb1TBHEcMEAtqj
 mEONKyS/FwjKMpM1SMqcxIdxA/PDX7TyH1sgOT6H8klBwOcQFyjyP+BTbayyGiER9hjm
 VMxoNXlAe920iuWZhzNR6F+wW17y91Q42OjnDqxttHubmK76eqWnl91j1QGRQWpBC2ds
 +hX7/GmDEulWcRGrH9yRZviYvPLSZnlztIwEwbXSg1onGBxVA0AOlxXXmLryfgosJpwH
 r0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763033589; x=1763638389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqmTCtcW3ujfxhfBw6wyVEU8uL1dsZiu375KvoDsotQ=;
 b=UikYHT1j+eBiYLzGFe6mEngP8Y0C2LfNfcN9QELGP9qxsdxwG4GKih53/EK2mguW+b
 bLsTvkfnX1M5qOMrfR0VF+S4c27aC2Du83QK8/dTq8LP5d6K2Glr5ehLwzr8gvJ+t6Eo
 Xk1Fv96iL4dNAuxtcJpdbsLnOy29Ovfyd1AmUV3ltfbUGwkzZy5EY1dLtfJgCIHBKiSe
 MCJf0FMI4xTN1xLx5lIKHgVHLl9N8za1bgRuE9zmmEkQ7KSepm0eXj6kbml3X1QufVF3
 lclNu8qPnFMLH306SuCnPN2u2mkyq0ncLYFU/FPqqN0v/IHiuD2mwkF18JioCTOCpLtc
 C8yQ==
X-Gm-Message-State: AOJu0YxEhV6IHOS7wMYTyE4XnPg1BKngoQXwYZVtzGSF893eRMlfdt/1
 NCnD6Ez46OATcuPsZFJ1BVntu1i7QIPUdQwdh3RMxdd7gSlBSBcJ0EIekYUu921lL7Fnqsq8VNk
 31aiakV8mSWdfEDLwogKQECT5LHYLSRiUGk9/TUKm8Nl3g8lqTMjv1sANKaxtv2QvWrt6+OFXtS
 6+YRoOWaDxE7S0Jl9q783xGomC5AMclu8=
X-Gm-Gg: ASbGnctXMGFR22zdzV0vxJtI1gFhmjdmU93MnUW/Zd9b7k0vu/i5Z+x7iOWeKO2CSC2
 m2JTMsiqdIvza7vmIK/u3j8MTPrxXb7Edg2zyU5RD1/eTOC7K0coWWe8dlEdC7GBSmOIvxV+e7q
 H0R2A3j/kBwFVZ+QhaF63VnMgF8GCFvC15uqNK4SbQxc8ARt/8q8dIKIpahZFvnpaWV97zfKOx0
 Y4RxhavPA5JQgg=
X-Received: by 2002:a17:90b:548c:b0:340:29a3:800f with SMTP id
 98e67ed59e1d1-343eacb9cdfmr3694321a91.15.1763033588695; 
 Thu, 13 Nov 2025 03:33:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyLzKGQyvIa60IeEdkCGH4uesJuhRY6qZ2oxCno0Wk/pILqQAuwl3d1kU50MdzjQc9kdmDfQ+AdKKbLXpwPL8=
X-Received: by 2002:a17:90b:548c:b0:340:29a3:800f with SMTP id
 98e67ed59e1d1-343eacb9cdfmr3694303a91.15.1763033588419; Thu, 13 Nov 2025
 03:33:08 -0800 (PST)
MIME-Version: 1.0
References: <20251112134143.27194-1-philmd@linaro.org>
 <20251112134143.27194-9-philmd@linaro.org>
In-Reply-To: <20251112134143.27194-9-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Nov 2025 15:32:55 +0400
X-Gm-Features: AWmQ_bm173myUQedBtrl95deeV6m4-dy_fLNKr3AZW9T06aHP0X9vQvTQnZLuWs
Message-ID: <CAMxuvawq81=wz7vVQcd13Ys_vDL-Me+5wDcchtdXbD1vUxSdOw@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] chardev/char: Document qemu_chr_fe_write()'s
 return value
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c3dd590643783ee4"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000c3dd590643783ee4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/chardev/char-fe.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index 36bcf1f88a6..fbec6a73dbb 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -238,8 +238,9 @@ guint qemu_chr_fe_add_watch(CharFrontend *c,
> GIOCondition cond,
>   * will send data from the front end to the back end.  This function
>   * is thread-safe.
>   *
> - * Returns: the number of bytes consumed (0 if no associated Chardev)
> - *          or -1 on error.
> + * Returns: 0 if no associated Chardev or no data could be written,
> + *          a positive value indicating the number of bytes consumed,
> + *          or a negative %errno indicating a definite error.
>   */
>  int qemu_chr_fe_write(CharFrontend *c, const uint8_t *buf, int len);
>
> @@ -254,8 +255,8 @@ int qemu_chr_fe_write(CharFrontend *c, const uint8_t
> *buf, int len);
>   * this function will block if the back end cannot consume all of the da=
ta
>   * attempted to be written.  This function is thread-safe.
>   *
> - * Returns: the number of bytes consumed (0 if no associated Chardev)
> - *          or -1 on error.
> + * Returns: 0 if no associated Chardev or no data could be written,
> + *          @len on success or a negative %errno indicating a definite
> error.
>   */
>  int qemu_chr_fe_write_all(CharFrontend *c, const uint8_t *buf, int len);
>
> --
> 2.51.0
>
>

--000000000000c3dd590643783ee4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 12,=
 2025 at 5:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Suggested-by: Peter Maydell &lt;<a href=
=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro=
.org</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0include/chardev/char-fe.h | 9 +++++----<br>
=C2=A01 file changed, 5 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h<br>
index 36bcf1f88a6..fbec6a73dbb 100644<br>
--- a/include/chardev/char-fe.h<br>
+++ b/include/chardev/char-fe.h<br>
@@ -238,8 +238,9 @@ guint qemu_chr_fe_add_watch(CharFrontend *c, GIOConditi=
on cond,<br>
=C2=A0 * will send data from the front end to the back end.=C2=A0 This func=
tion<br>
=C2=A0 * is thread-safe.<br>
=C2=A0 *<br>
- * Returns: the number of bytes consumed (0 if no associated Chardev)<br>
- *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or -1 on error.<br>
+ * Returns: 0 if no associated Chardev or no data could be written,<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a positive value indicating the numbe=
r of bytes consumed,<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or a negative %errno indicating a def=
inite error.<br>
=C2=A0 */<br>
=C2=A0int qemu_chr_fe_write(CharFrontend *c, const uint8_t *buf, int len);<=
br>
<br>
@@ -254,8 +255,8 @@ int qemu_chr_fe_write(CharFrontend *c, const uint8_t *b=
uf, int len);<br>
=C2=A0 * this function will block if the back end cannot consume all of the=
 data<br>
=C2=A0 * attempted to be written.=C2=A0 This function is thread-safe.<br>
=C2=A0 *<br>
- * Returns: the number of bytes consumed (0 if no associated Chardev)<br>
- *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or -1 on error.<br>
+ * Returns: 0 if no associated Chardev or no data could be written,<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @len on success or a negative %errno =
indicating a definite error.<br>
=C2=A0 */<br>
=C2=A0int qemu_chr_fe_write_all(CharFrontend *c, const uint8_t *buf, int le=
n);<br>
<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--000000000000c3dd590643783ee4--


