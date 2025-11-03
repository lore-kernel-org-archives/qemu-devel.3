Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA59CCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 07:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFp2I-00076e-5V; Mon, 03 Nov 2025 02:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vFp27-0006vV-4v
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 02:31:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vFp22-0004HH-Rv
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 02:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762155066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6A8WiAIXSjdQXPbvwzf83w42f4yxPuuGTHptinfBG5E=;
 b=XU0cqNoZB74YmNIa42OmPZiw/ca2b7i4syBTFfAeS/jr+TsArpmhE3ehCVXIkTxf0oOZsF
 GgWWx/rV0a/KWglRHAvKEYmKF9ppYe95sf3mvIlMCjjzFjuY2yELIDobX+Qr406OPFFF0E
 6wjhD0M36BTjslTUqSXItx9eDmo3bik=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-XBbPkwRsOXyQlK6iWfD52Q-1; Mon, 03 Nov 2025 02:31:03 -0500
X-MC-Unique: XBbPkwRsOXyQlK6iWfD52Q-1
X-Mimecast-MFC-AGG-ID: XBbPkwRsOXyQlK6iWfD52Q_1762155063
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88022ad6eb3so137301026d6.2
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 23:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762155063; x=1762759863; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6A8WiAIXSjdQXPbvwzf83w42f4yxPuuGTHptinfBG5E=;
 b=r2YnsgqD81OMQdCfN+8SfW+WVdpqfH9ooryg3YBfXQZ0PQxDM2ejE6RjtpXMvQ02pG
 ocg102LECRnz5RxckSc7xTaNbjzv5FBmsoJveUHxH8s0rmVb0h6GFCsZ6F5HYhrdmD26
 gYiB2F5DPhHtqoBxwUcAVUpWRIwvnbpsYLVgJN9xlaxbS8Frb+JqPMubfHMpr1GysCyC
 d/gqdH9wa6WzvsLrGujycDwJ3YHtkR9y+IwDy695Q2gyScOhXLKH8oxNJt7ymRCZgAos
 S0EExofVDfR8t1WZjIm/4HBcfRjMcIpvP9evFCwihfn8/auAq4SnkLCgGJgkHLrrZN3i
 5uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762155063; x=1762759863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6A8WiAIXSjdQXPbvwzf83w42f4yxPuuGTHptinfBG5E=;
 b=XFPJrb2ZRlYjNSFP/j2XJ/4IJf3E0ielzLNun4XrGB4I5U/lGKOUZxqKd87TZd1YP3
 aXoxMltN8MfahjGnhA9DCGidHdJupsnT7LgxQpxcyM6iZY4yhQRE5dN+yZoX0t/UFUkB
 jiyCZebGJKdwC//So4opAqOZ1evTAiJZ/8vNzekMvPWjVc/UvIM3YqsISA3fKOaabf1Q
 E0feKzpt9hd0aGIPyMs9VlJgMvEC7qw2emIVGq7cYl227tEbsOo0MNgW5ys2VJAki+iZ
 DYv9EC5mtj508We/D7jtHyKyeEnJiIIgGFafA39hxItGcZRd0p46SBpfCQNe/zGeNjT3
 m+yQ==
X-Gm-Message-State: AOJu0YxTXiirpx2zEHgQuyO2wq096a5dvX2c3sYICGiu4CcNj8pBHRhB
 RjdcZ/bk2tizo1EF9ce5Zookvjnp9BGLFigR1OAoa6Zlg1pUH3MhIjzrItxCGVi0u5XRlb5AyjB
 gCfI6hqNFMFn1rs0yWxtSUuj/teYVeRY/M3SQA4b58WbluVUM32kHX+o2HYN8/eUxewPGagVSXI
 wZEdW073Ux4nbcEUoEQ05LrUVbqnvkA40=
X-Gm-Gg: ASbGncvDpJ3aaTlzfZwv329J8gzbtsh5h9ldaIHvtVFM9Pb79PXxcxTbPD5gVyQasu/
 1yBqQIKAubPum5K4jeIEpx9eSRRpchs6rnjR7TUute/jkxBTjweCDdBw/A+k5V+Y7MutA+TmwrU
 2o2PXhs72Xa6xBWw8C0ZrIo3yTPXxJM+ld/VdxZdlPCsv22nK5Cqj/TGvf/g==
X-Received: by 2002:a05:6214:f2e:b0:880:4ec0:4183 with SMTP id
 6a1803df08f44-8804ec04237mr63234396d6.46.1762155063235; 
 Sun, 02 Nov 2025 23:31:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMDTrkFcAl/FFXFNHZ/bKjp95dLcQu0hMt444+ZUTWLnjEI4LeQ1jEtlaUdMYUr3ylmmj9+KVdWF7zLIrtSKs=
X-Received: by 2002:a05:6214:f2e:b0:880:4ec0:4183 with SMTP id
 6a1803df08f44-8804ec04237mr63234156d6.46.1762155062851; Sun, 02 Nov 2025
 23:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20251101130330.1927-1-shentey@gmail.com>
 <CAFEAcA-ycNEcZGF0kqLYBzq4xLSJikYZL_Q0JyKbuMuDtAJ7JA@mail.gmail.com>
In-Reply-To: <CAFEAcA-ycNEcZGF0kqLYBzq4xLSJikYZL_Q0JyKbuMuDtAJ7JA@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 3 Nov 2025 09:30:52 +0200
X-Gm-Features: AWmQ_bmufAaOfe-NkfJwgZAMt1eimvqB-rqU1bQZtV8HD6e9pTwEKcgp3zScQy4
Message-ID: <CAPMcbCrime0pad7Nqa-n+yUk7jU9AP5ixYOVX3QekTqXt9Vm1w@mail.gmail.com>
Subject: Re: [PATCH] qga/vss-win32/install: Remove
 _com_util::ConvertStringToBSTR()
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000008f8a790642abb27e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

--0000000000008f8a790642abb27e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This function is used inside Windows headers. You can find the following
code in comutil.h in MinGW

inline _bstr_t::Data_t::Data_t(const char *s) : m_str(NULL),m_RefCount(1) {
m_wstr =3D _com_util::ConvertStringToBSTR(s);
}

But MinGW does not implement ConvertStringToBSTR, so QEMU should implement
this function.
We use _bstr_t in VSS-provided DLL, so this function is mandatory for us.


Best Regards,
Kostiantyn Kostiuk.


On Sat, Nov 1, 2025 at 3:13=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Sat, 1 Nov 2025 at 13:04, Bernhard Beschow <shentey@gmail.com> wrote:
> >
> > Now that MSYS2 provides an implementation of the function it clashes wi=
th
> > QEMU's, resulting in a compilation error. Remove it since it doesn't se=
em
> > to be used anyway.
>
> The comment says it's used by _bstr_t, which presumably
> is in some Windows header or library that we're linking against.
> Our code seems to use _bstr_t a lot. Is this function definitely
> not required, or should we have something so we provide it only
> when MSYS2 does not?
>
> thanks
> -- PMM
>
>

--0000000000008f8a790642abb27e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div>This function is used inside Windows h=
eaders. You can find the following code in comutil.h in MinGW<br><br><div s=
tyle=3D"color:rgb(204,204,204);background-color:rgb(31,31,31);font-family:&=
quot;Droid Sans Mono&quot;,&quot;monospace&quot;,monospace;font-weight:norm=
al;font-size:14px;line-height:19px;white-space:pre"><div><span style=3D"col=
or:rgb(86,156,214)">inline</span><span style=3D"color:rgb(204,204,204)"> </=
span><span style=3D"color:rgb(78,201,176)">_bstr_t</span><span style=3D"col=
or:rgb(204,204,204)">::</span><span style=3D"color:rgb(78,201,176)">Data_t<=
/span><span style=3D"color:rgb(204,204,204)">::</span><span style=3D"color:=
rgb(220,220,170)">Data_t</span><span style=3D"color:rgb(204,204,204)">(</sp=
an><span style=3D"color:rgb(86,156,214)">const</span><span style=3D"color:r=
gb(204,204,204)"> </span><span style=3D"color:rgb(86,156,214)">char</span><=
span style=3D"color:rgb(204,204,204)"> </span><span style=3D"color:rgb(212,=
212,212)">*</span><span style=3D"color:rgb(204,204,204)">s) : </span><span =
style=3D"color:rgb(220,220,170)">m_str</span><span style=3D"color:rgb(204,2=
04,204)">(</span><span style=3D"color:rgb(86,156,214)">NULL</span><span sty=
le=3D"color:rgb(204,204,204)">),</span><span style=3D"color:rgb(220,220,170=
)">m_RefCount</span><span style=3D"color:rgb(204,204,204)">(</span><span st=
yle=3D"color:rgb(181,206,168)">1</span><span style=3D"color:rgb(204,204,204=
)">) {</span></div><div><span style=3D"color:rgb(204,204,204)">  m_wstr </s=
pan><span style=3D"color:rgb(212,212,212)">=3D</span><span style=3D"color:r=
gb(204,204,204)"> </span><span style=3D"color:rgb(78,201,176)">_com_util</s=
pan><span style=3D"color:rgb(204,204,204)">::</span><span style=3D"color:rg=
b(220,220,170)">ConvertStringToBSTR</span><span style=3D"color:rgb(204,204,=
204)">(s);</span></div><div><span style=3D"color:rgb(204,204,204)">}</span>=
</div></div><br></div><div>But MinGW does not implement=C2=A0ConvertStringT=
oBSTR, so QEMU should implement this function.=C2=A0</div><div>We use=C2=A0=
_bstr_t in VSS-provided DLL, so this function=C2=A0is mandatory for us.<br>=
<br></div><div><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail=
_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best R=
egards,</div><div>Kostiantyn Kostiuk.</div></div></div></div><br></div><br>=
<div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"=
gmail_attr">On Sat, Nov 1, 2025 at 3:13=E2=80=AFPM Peter Maydell &lt;<a hre=
f=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Sat, 1 Nov=
 2025 at 13:04, Bernhard Beschow &lt;<a href=3D"mailto:shentey@gmail.com" t=
arget=3D"_blank">shentey@gmail.com</a>&gt; wrote:<br>
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

--0000000000008f8a790642abb27e--


