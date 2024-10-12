Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBC8D1A443
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 07:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szWj7-0004cE-NX; Sat, 12 Oct 2024 03:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1szWj5-0004Xb-Gx
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 03:39:47 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1szWj3-0004ED-3N
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 03:39:47 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5e8038d4931so1618438eaf.2
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1728718782; x=1729323582;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TfUEplD38YviOYL4MDo7kAXbkr2eDZCWenj06SLfBkQ=;
 b=SroeBiFZ05KLkfFD+q/1YNlZtjNb+UDZ9/yvdTBePykoajRQpDXk2DCJXmmaUE8krD
 XATBSjOUYAJ82L5uEPzFgQG4YCCIRO30g46peOkH3p7UGH5vPHq/kdspo5+1HEIRTRPD
 IAN7ZZ1r9tzZsAQqyv2/KRuCbWjBuEF+T3om0G1K6cUZW8YjX4o/ruFj6aU7h6jN57jW
 0wKo1IGGpndvN6Ta9vFlUkKeGq+9ObE8DtPmSBjbuLfcTGp6Nvhlmf8ecSyAQWaIE1zP
 K9n10E+s2yiSulv2CE7ncLTQugMUpa1JM81HcMDWO31RsVahlNkgSG7m11rqgzIu4jTF
 SJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728718782; x=1729323582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TfUEplD38YviOYL4MDo7kAXbkr2eDZCWenj06SLfBkQ=;
 b=dHPYMCnpbSaF200QlhdP0+N0ZXtWGckbtiwkXI3cWhIOYkcvDWByFppT0FKYjefzVt
 jMvaMCH3lCY9+E/VrosR+1UZmf36HcHH6WNxf0HNb8YoV0th+WWT72Y5KCOLvzLSA6zU
 Qsfs3hNs01DtoY6G7Sc0l4Wm7DxNuSsgbFPYwrqvqUapbCpLAWE1HYdr/TosNmUDNcd+
 6Nsgmla5907dqzNJnMspGMfcXxQTiY8mbCMuCx94YCvU1TAXAemEajRHGgOa+RnssfGp
 zZMKtCQYw4ibWRh/+k1zglKNnTIhFUAePwDaegbfFskyawRQQtWbqkYNRn/d5uMnRGzp
 W2mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1D1s3837bsmtFrOfw846M8hSfTtjE+V4DtUM+p88C4eKt9Kapn99BWZcVfeeWzST/5YyY1KDRFnwX@nongnu.org
X-Gm-Message-State: AOJu0YwzRMpBVWcPkpgBEkzFA5XIP9HPjie+2IxrTNu5N8F8YQbSVQ2l
 tMfeajk6lhKAfUqPu2O6u00j1GO2t5uztUOTjnVV5bcBbqT1lbdyFoxc5qCF6oBKQ9crfcIi+oz
 TEBEh8AhcfUZQqpPCI/HKisVLH3PxP3fuocVFKA==
X-Google-Smtp-Source: AGHT+IEO32QF6PfmZgrwKU0DLMA+G3JNy5LzNnLZyv7BzbFjCOUfsN7qPAL06dhAR2BUlxTc/g9SXB2ciTU+zIIzCNE=
X-Received: by 2002:a05:6870:79e:b0:267:dfce:95eb with SMTP id
 586e51a60fabf-2886dce9beamr2926919fac.5.1728718781660; Sat, 12 Oct 2024
 00:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241011153652.517440-1-peterx@redhat.com>
 <87v7xyr1jz.fsf@suse.de>
In-Reply-To: <87v7xyr1jz.fsf@suse.de>
From: Yong Huang <yong.huang@smartx.com>
Date: Sat, 12 Oct 2024 15:39:25 +0800
Message-ID: <CAK9dgmZ89J1N6iY+1xRYJwb8K8FVWqx7MbtLFMFvasDVTDDdqg@mail.gmail.com>
Subject: Re: [PATCH] migration: Put thread names together with macros
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Content-Type: multipart/alternative; boundary="000000000000e5d655062442b43a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000e5d655062442b43a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 1:29=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:

> Peter Xu <peterx@redhat.com> writes:
>
> > Keep migration thread names together, so it's easier to see a list of a=
ll
> > possible migration threads.
> >
> > Still two functional changes below besides the macro defintions:
> >
> >   - There's one dirty rate thread that we overlooked before, now we add
> >   that too and name it as "mig/dirtyrate" following the old rules.
> >
> >   - The old name "mig/src/rp-thr" has "-thr" but it may not be useful i=
f
> >   it's a thread name anyway, while "rp" can be slightly hard to read.
> >   Taking this chance to rename it to "mig/src/return", hopefully a bett=
er
> >   name.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>

Acked-by: Hyman Huang <yong.huang@smartx.com>

--=20
Best regards

--000000000000e5d655062442b43a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_defa=
ult" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Sat, Oct 12, 2024 at 1:29=E2=80=AFAM Fabiano Rosas &lt;<a href=3D"mailto:=
farosas@suse.de" target=3D"_blank">farosas@suse.de</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);p=
adding-left:1ex">Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=
=3D"_blank">peterx@redhat.com</a>&gt; writes:<br>
<br>
&gt; Keep migration thread names together, so it&#39;s easier to see a list=
 of all<br>
&gt; possible migration threads.<br>
&gt;<br>
&gt; Still two functional changes below besides the macro defintions:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0- There&#39;s one dirty rate thread that we overlooked bef=
ore, now we add<br>
&gt;=C2=A0 =C2=A0that too and name it as &quot;mig/dirtyrate&quot; followin=
g the old rules.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0- The old name &quot;mig/src/rp-thr&quot; has &quot;-thr&q=
uot; but it may not be useful if<br>
&gt;=C2=A0 =C2=A0it&#39;s a thread name anyway, while &quot;rp&quot; can be=
 slightly hard to read.<br>
&gt;=C2=A0 =C2=A0Taking this chance to rename it to &quot;mig/src/return&qu=
ot;, hopefully a better<br>
&gt;=C2=A0 =C2=A0name.<br>
&gt;<br>
&gt; Signed-off-by: Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" targe=
t=3D"_blank">peterx@redhat.com</a>&gt;<br>
<br>
Reviewed-by: Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de" target=3D=
"_blank">farosas@suse.de</a>&gt;<br>
</blockquote></div><br clear=3D"all"><div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">Acked-by: Hyman Huan=
g &lt;<a href=3D"mailto:yong.huang@smartx.com">yong.huang@smartx.com</a>&gt=
;</div><br></div><span class=3D"gmail_signature_prefix">-- </span><br><div =
dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic =
sans ms, sans-serif">Best regards</font></div></div></div>
</div>

--000000000000e5d655062442b43a--

