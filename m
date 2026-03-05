Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66DFF30942
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 11:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6c8-0006JB-8f; Thu, 05 Mar 2026 06:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avi@scylladb.com>) id 1vy6c6-0006J3-T0
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 06:11:30 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <avi@scylladb.com>) id 1vy6c5-0007vy-20
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 06:11:30 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-948029fb1f2so2334650241.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 03:11:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772709087; cv=none;
 d=google.com; s=arc-20240605;
 b=CFgDDH7M19CCQwoZrAkXk1g3I/YVPIZ0inTLvpIV9iE/vjggTkw8wCEnmapFfToX5d
 ESC2MNB1UT32Xl2pRr5DbRFi55ZUzcRURsnGJS7foLTNI85gyPzKmWdGmu86WTxwnS2U
 qsL8+WP/KRLFsGIf+YslYV/TYwQpr6FeHhOPNC5y0ydQiSI9oA2Zb9pJZZKc4bWW/MYj
 HfsujiiH6UfGjguA/2VdgvOB0yH2L+hb5T9X2HkYC6emHNhiDuIvx/qAUf7gZZRZ6V8a
 Y9zJlXds/vZNUcjgKI5Ny8MD/AEAe7yziwC5lNAgFJDPpjmsXnokVw3LlLZ5ToL/iYDQ
 an4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BUoZRMKjTmLLtcaOARxzxh6BEiUTID1mR8KUMoGaarY=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=NciOOIF19ja+TTl74JS5IsEL+O2u5OaFcXBON0GSiirV1AggkCH2rZCQO+vTBhsbFG
 kKZyZULYLnQZJFvaSmb/UeQ3VMzlxFjk0vWHe586+nzMuosQd2w692cyx30teXmajNwr
 uaLttkqDmo0BY870+yuGOzrFT/fgpZbIqGuqPAuXXrkm5ba9IqViQjzXlod9YQUkmjF+
 Chh7s2gU0IC2IRv4I0T0jrcqkrazqLUkgsyy3GgozPi/LXUcdlfOsf/VH8+Ce42I7zZ8
 iLHTKY+hhIoY2rqhOCp+MpB49pXDf+xHGdRZ0QiUN5iMHrO01QUrkViAjGtHUV97YxwN
 XnyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scylladb.com; s=google; t=1772709087; x=1773313887; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BUoZRMKjTmLLtcaOARxzxh6BEiUTID1mR8KUMoGaarY=;
 b=mw9pfEooWDCdgTAvJuhy6aCZt9T+LOJA3pwtfPz9nYAbukmsvmjDOHbM25bM9HdJxn
 imD1ix+jT8XCCm1GiJ5R/o1LpVN8FO3fKY14H4q0pDQmqOy/OGWAAhAnAAGQnLgvHI/F
 jjOlo50Javc5B2To2yzGMRDkmG3hkFCTbcAO0K8TOnOefkkY63/1VE9dVZZjovu3BDwN
 SgeJ5Z1VO6a7dUK6qRUtZB40d0u7ZDvQOsY/hx/zjasHkGJPOatd4QMBy6FBa0fdgeBm
 apC+Z3VzyZI0gq0iTpn3nsF6HISc/vvFrKFzqvRhDWP55Vi6x1WRBKbGLX2KZD2KXOY6
 LUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772709087; x=1773313887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUoZRMKjTmLLtcaOARxzxh6BEiUTID1mR8KUMoGaarY=;
 b=MCfpqXroiN8uhAPmoah123l2+Q36mZO/4hIwcJsb/byotE+YY0wPPAkEcVJhcUOhUJ
 SSrP+L+0br1QowpVA9uQCJhLZIiqpWBqIEHFtqLiViUttKDoz0NGmar9hGBc4KjfmJOU
 zd2g/BrvbpuzTmjY6qCNavYDBz2wAqUONixnSgadQm+OUmJ3/ICmKCJkWIaPBeROYkjg
 qe7WWv+fqdsxseYSv5JpCcPc9ub8GLbIrAW/vrWnCkmcCGaNWTI9j831Mb5rdSSQkI5Z
 NHnHE46xJsMiJCaHbx+M5PT2JwM2oyrgk3eLsckIh5VuM4SWVN/yuHxJZoBB0mZnRTP4
 T3Xg==
X-Gm-Message-State: AOJu0Yzx0LVn0ahre36cf9PIpurJh0nVIJc9H5ZTrL3Kle3L85xKqawk
 SN/MyusFQkxvs6WDK5SQMFOLuzHxlQxBkwqMCrD/PYQkAf6xKTHm8iRo02yggFAWLMwxaWNGLNU
 llmrXRyhBix5OYmIYjuvd9rMhIVvwLSBCQ1DdPw7aLGJwfH4RmHdq3j70pzXZ1gN4A2eZlQ+pA6
 mYBZijOVOtg9ozE+X4pIgc3KAaX9RW5h73PypeRTK4XWrJUz42KNQ8SvyMSpLlADozwy4PaCCSO
 MF12rVV4tssSAauwTRCcsUbrCqkc9sy6TK48c9CmtIOG6vNF99SNhxV0X5hCYFIx5199osZ9R4s
 AKMO4FeoECCLfsCzsrGp8RW8JuYznCWGjIci2t7lzjJOIQ66g/AyjPqX+d7ZGJDXD2F5kXzV
X-Gm-Gg: ATEYQzw/xbWXfz4P+sE5+A2lGEcwx3Nw7FPNlp/7zeQhI5MgVUg7cUPg9D0CI2E+kPQ
 pmRzXNztoSdWJM4Q0XHxqlf+825MvheQFU2eb69zpHpZZhl4CFQFVYGbGmwiP3lps/6rlaN17T2
 kKqsHP/5ZY/tjisFURDeeZI/j8ZQTTwYYl6iBz31sdWxIBDSkZWMYztv7eqceQS847GsCAlOaDt
 bOLZPpbS2pNNOD8YyZOK+/d1qh8sOal0NElyHw+cmauT50742cRgjAHQlGmB3pg/ByP6cS4nApa
 FHlZfts=
X-Received: by 2002:a05:6102:32c1:b0:5ff:172c:2d96 with SMTP id
 ada2fe7eead31-5ffaaa867e8mr1962099137.3.1772709086466; Thu, 05 Mar 2026
 03:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20260302142831.1269291-1-avi@scylladb.com>
 <aaWhHEI4QaDINc8K@redhat.com>
 <CAF950WLOB1BXkJ+rmRea3nWuLRZG=O3gDas9HUhM1LMsmrnffA@mail.gmail.com>
In-Reply-To: <CAF950WLOB1BXkJ+rmRea3nWuLRZG=O3gDas9HUhM1LMsmrnffA@mail.gmail.com>
From: Avi Kivity <avi@scylladb.com>
Date: Thu, 5 Mar 2026 13:11:15 +0200
X-Gm-Features: AaiRm51Sqb9V8NdazBNDd53bZy1i-1uGELCCCxZ_5tO9XtOHGBNJ4e0O2HXLdSM
Message-ID: <CAF950WJJC+Wr+K4DQeyqM=_NdQfz=DJ+mN0fM-nyu0XBQe2pag@mail.gmail.com>
Subject: Re: [PATCH] hw/nvme: add `model` parameter
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000063aa19064c44ffc5"
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
Received-SPF: permerror client-ip=2607:f8b0:4864:20::92c;
 envelope-from=avi@scylladb.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

--00000000000063aa19064c44ffc5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 4:50=E2=80=AFPM Avi Kivity <avi@scylladb.com> wrote:

>
>
> On Mon, Mar 2, 2026 at 4:39=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
> wrote:
>
>> On Mon, Mar 02, 2026 at 04:27:48PM +0200, Avi Kivity wrote:
>> > Add a `model` parameter, readable with nvme-cli. This allows
>> > impersonating other disk manufacturers or hypervisors, similar
>> > to the the -smbios option.
>> >
>> > Signed-off-by: Avi Kivity <avi@scylladb.com>
>> > ---
>> >
>> > Disclosure: prepared with AI assistance. I believe it to be of good
>> > quality.
>>
>> Can you clarify how AI was involved,
>
>
> I asked an LLM (Claude) to add a model parameter to the nvme code, which
> it did, then I asked it to documented it, which it also did.
>
>
>> as QEMU's policy is to decline
>> any contributions where AI was involing in an authoring role:
>>
>
> Very unfortunate. It would have taken me an hour or two to re-orient
> myself in the code base, for something that took me a couple of minutes
> with AI.
>

So what's the verdict?

FWIW I think the probability of AI copying these few lines from some
non-GPL project is zero.

--00000000000063aa19064c44ffc5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 2, =
2026 at 4:50=E2=80=AFPM Avi Kivity &lt;<a href=3D"mailto:avi@scylladb.com">=
avi@scylladb.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 2, 2026 =
at 4:39=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@r=
edhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Mar 02, 2026 at 04:=
27:48PM +0200, Avi Kivity wrote:<br>
&gt; Add a `model` parameter, readable with nvme-cli. This allows<br>
&gt; impersonating other disk manufacturers or hypervisors, similar<br>
&gt; to the the -smbios option.<br>
&gt; <br>
&gt; Signed-off-by: Avi Kivity &lt;<a href=3D"mailto:avi@scylladb.com" targ=
et=3D"_blank">avi@scylladb.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; Disclosure: prepared with AI assistance. I believe it to be of good<br=
>
&gt; quality.<br>
<br>
Can you clarify how AI was involved, </blockquote><div><br></div><div>I ask=
ed an LLM (Claude) to add a model parameter to the nvme code, which it did,=
 then I asked it to documented it, which it also did.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">as QEMU&#39;s policy is =
to decline<br>
any contributions where AI was involing in an authoring role:<br></blockquo=
te><div><br></div><div>Very unfortunate. It would have taken me an hour or =
two to re-orient myself in the code base, for something that took me a coup=
le of minutes with AI.</div></div></div></blockquote><div><br></div><div>So=
 what&#39;s the verdict?</div><div><br></div><div>FWIW I think the probabil=
ity of AI copying these few lines from some non-GPL project is zero.</div><=
div>=C2=A0</div></div></div>

--00000000000063aa19064c44ffc5--

