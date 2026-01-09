Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D15D26D7A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 17:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veGZ1-0005dy-Sj; Fri, 09 Jan 2026 12:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veGZ0-0005bW-63
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:46:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veGYw-0004Ew-7z
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767980772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMhxTgp9mB0Bqr+x3YbE9tQTnJukCjbgm2daopxBl6k=;
 b=CTM7haWfDyBoRaNx2yHVynTFSwQhmotO33WbRsj5uOKI+WS9F1arVOxTyv+h+QMftV2Cfo
 3yTQgYp16KnnZMF+0kfAPDPUNX3ngs2H/N1PwtovEc9Ty0k2hMRotsWs8Hici9Ahq/DN0U
 WchXkUenBOUjfWegl2hz7Xf9cPEeQ2c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-P4KvB9KgNsGza5ee6RkMhA-1; Fri, 09 Jan 2026 12:46:11 -0500
X-MC-Unique: P4KvB9KgNsGza5ee6RkMhA-1
X-Mimecast-MFC-AGG-ID: P4KvB9KgNsGza5ee6RkMhA_1767980770
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fdc1fff8so2763735f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 09:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767980770; x=1768585570; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sMhxTgp9mB0Bqr+x3YbE9tQTnJukCjbgm2daopxBl6k=;
 b=Gfz2ZWJb+nvfRmkCvzrCSVenv0ROyAb/SsL9mzMECtWUhDsJAIn0ddSluYQTAmO+TZ
 zwYhbVhUmbgi0SnO3BFDsMO55ttyiNKDgA4P0etfd7xMS76F1qsIayqbfM1eVBMgrTTK
 MBawYxWSo729BZ9g5rUfoAwbOqFxFdadq9xXNhqzniBby6SPNTkUNAdWfmm8h52KnOJd
 Gdii3P4IdTRZ5BmByHo2FAXLYDGvEkub6KayT1rajungIE7t0HmhCuq4iStjY4mQ+DwT
 6E7v9diaDfBOW+NrY12pDP7IdlLUrTHyKwlkMVUErGMkL8TaowSfN01Dcg8ueE1Y9fhM
 EuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767980770; x=1768585570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMhxTgp9mB0Bqr+x3YbE9tQTnJukCjbgm2daopxBl6k=;
 b=vmD+buHjY3CK6lxtsCJPLf4nd4QeH3JRi2x23Pfno9NMwLZrUBFUoCt0LymO78i5cv
 qWmGLc+Sa5ctShmpu44Kqu2sK3MhD5iNKdY20I25br9qDbyfcgs+xJa9yXfZXQ5XwFyw
 aaLY5+MCWLGC8p96OCtQX6cLC/Xh2rRnXKIBsFvEWB/8Nmz33r0GJl5L+OjxEV6DBVbr
 KsoRlx7+xP8yKn7wrztD3hH1/DwMXMc2oc09j8dEq4bLcTrQjnsq3NuwSDX2nnRNVr9F
 OG23TnRdLzZgm6Mk1xyyR2vSB2KhMyZFRKKcdmJf6LSRwBWulhHJNGM29uxWTyZPRTjG
 zb/Q==
X-Gm-Message-State: AOJu0YwtVwDtI79ffXG0Kcncfzf8A+aumC+9q/tDkDhnwF5VCGATB0QY
 uPtcEJrmQiHU2A4dS9JbpvLcC2U1dYNaR79AztIkA1mgtf5xzoDJJqBuIL1rmC5bpFNR4/zBFT8
 O5/LcyoTBMupO6CICYrt7CZJ04WPOlRMpwIXtc0ySOWlJYS8I+jmgEEn5BQN9Bgnhk/GonBsIXP
 JlO5aQ6yURxyrjcI37g1WTzbvABZXGZM4=
X-Gm-Gg: AY/fxX4UsQguN4O2KU5GO/nsaZaxayAJDBOP3IH/8cKlxKnA37TZY79XyVmEbo3CepE
 hXruIR2LISXiadCF62u24zNOWYmVgiVlYnjw4NufjnOt03caf/y5GdKRIrWvHqvnIyyI6/hiO2y
 rgUHX7p1pyfFToB5067zFSuuseZgbuu0S5CWkcmdVkw0fFhoNMQwd2BdJCYhfG2X3gA4hekP0HU
 OYXsSvcqZLdLcIjKRqpF+YxjfTfOV+GTihHoYEa05cDm68Umsi5DzR74YwybPM8Z+rs5g==
X-Received: by 2002:a5d:64c6:0:b0:42f:b581:c69d with SMTP id
 ffacd0b85a97d-432c3628323mr11980723f8f.3.1767980769857; 
 Fri, 09 Jan 2026 09:46:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJNv58I3u2tGecPJHxd1KDqMHMbzHFAQaSwyMFPf9/x61ENdFREn/79hDPTrcpipFWz7Jstz4Xx0uFxEIWP74=
X-Received: by 2002:a5d:64c6:0:b0:42f:b581:c69d with SMTP id
 ffacd0b85a97d-432c3628323mr11980697f8f.3.1767980769453; Fri, 09 Jan 2026
 09:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
 <73ac5b61-ebd1-4451-884f-0b78eaf0ff02@redhat.com>
 <44f59945-0de8-48e7-91da-6322182b4721@linaro.org>
In-Reply-To: <44f59945-0de8-48e7-91da-6322182b4721@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Jan 2026 18:45:59 +0100
X-Gm-Features: AZwV_QhzXROivLVNIUSA6EuMo1DxRAIQjhspcEvTvdKMRoDKkWLgfuSr8hXxstg
Message-ID: <CABgObfZ6qCCS89u7i+QW=FU-_aKe9ytFuwqFHNEqNNLm6=tEEQ@mail.gmail.com>
Subject: Re: [PATCH 15/29] accel/tcg/translate-all.c: detect addr_type
 dynamically
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>, Anton Johansson <anjo@rev.ng>
Content-Type: multipart/alternative; boundary="000000000000bbbea40647f8190d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000bbbea40647f8190d
Content-Type: text/plain; charset="UTF-8"

Il ven 9 gen 2026, 17:26 Pierrick Bouvier <pierrick.bouvier@linaro.org> ha
scritto:

> > I know you're trying to avoid more treewide changes and focus on arm
> > instead; but it would not be hard to make this TCGType already, or at
> > least use TCGV_TYPE_TARGET_LONG only for the other four mixed-length
> > frontends (i386, riscv, sparc, and x86_64).
> >
>
> I'm not opposed to do this change, but I was (and am) not sure which
> value should apply to which arch.
> Mips and ppc have 32 and 64 bits also.
> I would feel safer to start with arm only for now and tag other
> architecture while we continue progressing on the single-binary.
>

The value corresponding to TARGET_LONG_BITS, i.e. TCG_TYPE_TL, is always
safe to use (though for single-size target it would be cleaner to use the
right one).

> Also, please call it addr_type since tcgv_type makes less sense in the
> > long run.
> >
>
> Ok!
>

Thanks,

Paolo

--000000000000bbbea40647f8190d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 9 gen 2026, 17:26 Pierric=
k Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouvi=
er@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">&gt; I know you&#39;re trying to avoid more treewide chan=
ges and focus on arm<br>
&gt; instead; but it would not be hard to make this TCGType already, or at<=
br>
&gt; least use TCGV_TYPE_TARGET_LONG only for the other four mixed-length<b=
r>
&gt; frontends (i386, riscv, sparc, and x86_64).<br>
&gt;<br>
<br>
I&#39;m not opposed to do this change, but I was (and am) not sure which <b=
r>
value should apply to which arch.<br>
Mips and ppc have 32 and 64 bits also.<br>
I would feel safer to start with arm only for now and tag other <br>
architecture while we continue progressing on the single-binary.<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">The value c=
orresponding to TARGET_LONG_BITS, i.e. TCG_TYPE_TL, is always safe to use (=
though for single-size target it would be cleaner to use the right one).</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Also, please call it addr_type since tcgv_type makes less sense in the=
<br>
&gt; long run.<br>
&gt;<br>
<br>
Ok!<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Thanks,</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></=
div>

--000000000000bbbea40647f8190d--


