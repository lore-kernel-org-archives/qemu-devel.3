Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EEECCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 07:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFp2V-0007Lq-VK; Mon, 03 Nov 2025 02:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vFp2Q-0007JM-4C
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 02:31:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vFp2L-0004Oc-BV
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 02:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762155089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Uk7pgwkwoHm69B8eZKWcFFh5u5N4GFvBsLPEoE6mVE=;
 b=Xrycfmh745Zi2O9yf5OkYHyd6tlFyS2QAy6VQRGZI+0CPgV70OiHlYHlLcB2st0wKn49Js
 /Zo4F1eLaIC5XEc3wNQTqif5g59zXG4LcRuik6zHhX+kNFNzGzSVxOYIz1devxI7ZC5plb
 4IQiUSG7LX+53i51VUH4gqSDHzxNlO0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-oBypuqVePkqQYPaV8hJv4w-1; Mon, 03 Nov 2025 02:31:27 -0500
X-MC-Unique: oBypuqVePkqQYPaV8hJv4w-1
X-Mimecast-MFC-AGG-ID: oBypuqVePkqQYPaV8hJv4w_1762155087
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8805713e84fso18951516d6.1
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 23:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762155087; x=1762759887; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Uk7pgwkwoHm69B8eZKWcFFh5u5N4GFvBsLPEoE6mVE=;
 b=NpA7QS5NORZN9FdeqxQwUOWqGFBoLt9+2Pdin/w0NgYAElYKm/35Oi5N04Y0MF1CXD
 koyohVvZOb5hdH4LHL/+FQwFs8va9Sm1pd/ylTPb+AuuJlvTkYdnzMl4jpthafQsbpzz
 ngDfq/PSn9KkVsL5CMwefs8Sdevi3Z9D5z78o8+yUWJpzRW285Wi0WnLpgGoiGV+XPJw
 thOn5lzuzrKD+HB/Ne7qcqK6Kd6spdIklZl7YbWb085SGdLNhSA/1QFlz2MFHgM8EVdC
 eJu3y31Sj/k67GqQET2Wv6CbcHxJmz90o4sf793REN2ztjboAIfYh4eaYZMVYU3LotVt
 9NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762155087; x=1762759887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Uk7pgwkwoHm69B8eZKWcFFh5u5N4GFvBsLPEoE6mVE=;
 b=E5pj3ySas1YC6VwJrJL6TfYnTpgKjWiRVdQTOE6DnpbsbzIc9DN10II1kQ6hj9GA6u
 7n1S5nnqZqSZdXxkeckaX2PrkmX1zkEBHUr1SCQNyHsWWmZrCROByGA94UvQYxPTSV24
 7CTw3lmd7foJYl4VtM99YRQb9Im/OXVndIDW6I9DLdRVSui40sZrzCFc5LG3OGSku/D0
 Pw+bgliFIWOq9aKLhqSwb35Y39p5iCIiFSy8qrI4pCRHKtrCpJhIzDsd5ErO6MWTJjfU
 6phZqh2SCuoHjC3BzVNffMVG4pRH8IiVEZT5WGED375mak/7XoodZH+4+6rqLX9GIUJT
 iIdA==
X-Gm-Message-State: AOJu0YyqNq2xPt+znvvYXOT7FxL9qEWrV6p1XVuy4aCKzFd4q2TfwqX/
 AJRTz7yYmV0HFzhJWup7EDwAAgru91WZawwRnTb1rNqeuStYBJV98MZGPaBpYbOjxRfB/7oN+rC
 zZOVqLHF5gcha8KyhCdy3oVm4BtZLueZ4zuBzYVRPObJVfeGdFDIggzSbshfY0QwmFVKdGbwVFe
 plPMX26aibFd4cfvgW+7yWy+w9kXdgyak=
X-Gm-Gg: ASbGncu4xw2RPeXXuX98NS/jdFDWYwMht9lyb9R7gzNZw375a+VqYVfWGPgoOVLr/Jz
 Na10MkbS6QxLYOlixlAwCKqTTYFnsB9xj1ji76Q6hYPWATjyqfutJe0F3cwGvDZixl7Xu6vr4Cf
 xIn5klGfEiLJuL5Zie6ZxJZLWdMRAahIjGo3u4Lsp//zfDuwAYs2+PtinbWw==
X-Received: by 2002:a05:6214:483:b0:87f:fb1b:ef95 with SMTP id
 6a1803df08f44-8802f2a1f70mr129779926d6.8.1762155087399; 
 Sun, 02 Nov 2025 23:31:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTOA6ApLsedd84xikAL1LQ4FrbUaalRVEmwEB24MnUv4hESLNR6qZyuh6UfW3378emaqj44SjClrnnp5wBCsA=
X-Received: by 2002:a05:6214:483:b0:87f:fb1b:ef95 with SMTP id
 6a1803df08f44-8802f2a1f70mr129779796d6.8.1762155087027; Sun, 02 Nov 2025
 23:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20251101130330.1927-1-shentey@gmail.com>
 <CAFEAcA-ycNEcZGF0kqLYBzq4xLSJikYZL_Q0JyKbuMuDtAJ7JA@mail.gmail.com>
 <CAPMcbCrime0pad7Nqa-n+yUk7jU9AP5ixYOVX3QekTqXt9Vm1w@mail.gmail.com>
In-Reply-To: <CAPMcbCrime0pad7Nqa-n+yUk7jU9AP5ixYOVX3QekTqXt9Vm1w@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 3 Nov 2025 09:31:16 +0200
X-Gm-Features: AWmQ_bkRL8ZdvIZ5kSQok_0CoEm4GQJ94mgUMeHTp2RfVGor4XfZmzaSoOFXees
Message-ID: <CAPMcbCpyPN=mZECq2ZfkBFW-CFcM-v-0q+C9kah8uxAfOLC+dg@mail.gmail.com>
Subject: Re: [PATCH] qga/vss-win32/install: Remove
 _com_util::ConvertStringToBSTR()
To: Bernhard Beschow <shentey@gmail.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000006dd50642abb483"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

--000000000000006dd50642abb483
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC @Yan Vugenfirer <yvugenfi@redhat.com>

Best Regards,
Kostiantyn Kostiuk.


On Mon, Nov 3, 2025 at 9:30=E2=80=AFAM Kostiantyn Kostiuk <kkostiuk@redhat.=
com>
wrote:

>
> This function is used inside Windows headers. You can find the following
> code in comutil.h in MinGW
>
> inline _bstr_t::Data_t::Data_t(const char *s) : m_str(NULL),m_RefCount(1)
> {
> m_wstr =3D _com_util::ConvertStringToBSTR(s);
> }
>
> But MinGW does not implement ConvertStringToBSTR, so QEMU should implemen=
t
> this function.
> We use _bstr_t in VSS-provided DLL, so this function is mandatory for us.
>
>
> Best Regards,
> Kostiantyn Kostiuk.
>
>
> On Sat, Nov 1, 2025 at 3:13=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org>
> wrote:
>
>> On Sat, 1 Nov 2025 at 13:04, Bernhard Beschow <shentey@gmail.com> wrote:
>> >
>> > Now that MSYS2 provides an implementation of the function it clashes
>> with
>> > QEMU's, resulting in a compilation error. Remove it since it doesn't
>> seem
>> > to be used anyway.
>>
>> The comment says it's used by _bstr_t, which presumably
>> is in some Windows header or library that we're linking against.
>> Our code seems to use _bstr_t a lot. Is this function definitely
>> not required, or should we have something so we provide it only
>> when MSYS2 does not?
>>
>> thanks
>> -- PMM
>>
>>

--000000000000006dd50642abb483
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>CC=C2=A0<a class=3D"gmail_plusreply" id=3D"plusReplyC=
hip-1" href=3D"mailto:yvugenfi@redhat.com" tabindex=3D"-1">@Yan Vugenfirer<=
/a>=C2=A0</div><div><br></div><div><div dir=3D"ltr" class=3D"gmail_signatur=
e" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</=
div><div>Kostiantyn Kostiuk.</div></div></div></div><br></div><br><div clas=
s=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_att=
r">On Mon, Nov 3, 2025 at 9:30=E2=80=AFAM Kostiantyn Kostiuk &lt;<a href=3D=
"mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><br><=
/div><div>This function is used inside Windows headers. You can find the fo=
llowing code in comutil.h in MinGW<br><br><div style=3D"color:rgb(204,204,2=
04);background-color:rgb(31,31,31);font-family:&quot;Droid Sans Mono&quot;,=
&quot;monospace&quot;,monospace;font-weight:normal;font-size:14px;line-heig=
ht:19px;white-space:pre-wrap"><div><span style=3D"color:rgb(86,156,214)">in=
line</span><span style=3D"color:rgb(204,204,204)"> </span><span style=3D"co=
lor:rgb(78,201,176)">_bstr_t</span><span style=3D"color:rgb(204,204,204)">:=
:</span><span style=3D"color:rgb(78,201,176)">Data_t</span><span style=3D"c=
olor:rgb(204,204,204)">::</span><span style=3D"color:rgb(220,220,170)">Data=
_t</span><span style=3D"color:rgb(204,204,204)">(</span><span style=3D"colo=
r:rgb(86,156,214)">const</span><span style=3D"color:rgb(204,204,204)"> </sp=
an><span style=3D"color:rgb(86,156,214)">char</span><span style=3D"color:rg=
b(204,204,204)"> </span><span style=3D"color:rgb(212,212,212)">*</span><spa=
n style=3D"color:rgb(204,204,204)">s) : </span><span style=3D"color:rgb(220=
,220,170)">m_str</span><span style=3D"color:rgb(204,204,204)">(</span><span=
 style=3D"color:rgb(86,156,214)">NULL</span><span style=3D"color:rgb(204,20=
4,204)">),</span><span style=3D"color:rgb(220,220,170)">m_RefCount</span><s=
pan style=3D"color:rgb(204,204,204)">(</span><span style=3D"color:rgb(181,2=
06,168)">1</span><span style=3D"color:rgb(204,204,204)">) {</span></div><di=
v><span style=3D"color:rgb(204,204,204)">  m_wstr </span><span style=3D"col=
or:rgb(212,212,212)">=3D</span><span style=3D"color:rgb(204,204,204)"> </sp=
an><span style=3D"color:rgb(78,201,176)">_com_util</span><span style=3D"col=
or:rgb(204,204,204)">::</span><span style=3D"color:rgb(220,220,170)">Conver=
tStringToBSTR</span><span style=3D"color:rgb(204,204,204)">(s);</span></div=
><div><span style=3D"color:rgb(204,204,204)">}</span></div></div><br></div>=
<div>But MinGW does not implement=C2=A0ConvertStringToBSTR, so QEMU should =
implement this function.=C2=A0</div><div>We use=C2=A0_bstr_t in VSS-provide=
d DLL, so this function=C2=A0is mandatory for us.<br><br></div><div><br cle=
ar=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div>Best Regards,</div><div>Kostiantyn Kostiuk.</div></div></div>=
</div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Sat, Nov 1, 2025 at 3:13=E2=80=AFPM Peter Maydell &lt;<a href=
=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Sat, 1 Nov 2025 at 13:04, Bernhard Beschow &lt;<a href=3D"mailto:she=
ntey@gmail.com" target=3D"_blank">shentey@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Now that MSYS2 provides an implementation of the function it clashes w=
ith<br>
&gt; QEMU&#39;s, resulting in a compilation error. Remove it since it doesn=
&#39;t seem<br>
&gt; to be used anyway.<br>
<br>
The comment says it&#39;s used by _bstr_t, which presumably<br>
is in some Windows header or library that we&#39;re linking against.<br>
Our code seems to use _bstr_t a lot. Is this function definitely<br>
not required, or should we have something so we provide it only<br>
when MSYS2 does not?<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000006dd50642abb483--


