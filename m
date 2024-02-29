Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674B5C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 02:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfWaS-00012y-St; Wed, 28 Feb 2024 21:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rfWaR-00012i-9K
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:55:55 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rfWaP-0004s3-07
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:55:54 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-299a2456948so276648a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 18:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709175348; x=1709780148; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IBMUS1S/dOGYBlTzQd/jThBmF946FVgTiiz6z4wd2MI=;
 b=jmlpeHg595Y//CNTXqC/jkVlGwDtw5d6/T4xhZTvO2k3PRGpHdTR3HegQJ5lQPsuCR
 LNztHczswtEncysJvC3ZZNdr25T49AoZNsLYRtL2U63r90SNGwzwDh9jcsV3HRAs8WaR
 le/KurPBjJ+Yd+8mG9koK2DFq8xASiBXteWq8ZZO5e9Xu2IMoPhMutvncuLv+evPcWYG
 QvZv4fPUTjtUX6T1OX8kjWkVGGdPmfEKo4L2iInFPus9xqN3DSUVZZcBa4i8lChirspu
 6a9atCibBbWhpgo2HdGMYmhwcw9es9ZRozEkPtNry3hkoL7O9Y+drPYeE2dsoEhxyBGe
 mbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709175348; x=1709780148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IBMUS1S/dOGYBlTzQd/jThBmF946FVgTiiz6z4wd2MI=;
 b=lCVNEkBRH4YRCy7H75n2/kAKIj3OYkpPZOwhmNCYiqY61NYHAd3DipB1+5z2gase7T
 IFdFzzuWlqPpNa0rqZQMdXGYuiKkW3+0t8IPeJJKEu17bkTPM0ok2HeZnl7B0lQ9dGAE
 leW8n3PHwWax4dmjcClPF3NS83tyYATM24gsaRgAQ2wTB6D8WPseiMEKpPi2Oz0buK0u
 bN2rMuKLXx0jfROkMpsYeOGxhiM+78MI2zBM22kiRtIxXYVjBIHhDeKPoFXprnSrDWJP
 gXC1hDvVfvIGG2PkeDh6H1Nd9z/MauL/Aa1laYu41+1DsekzhLCFAwgsrYq7hORjJA9I
 JcKQ==
X-Gm-Message-State: AOJu0YwInY3BHpLhpG9sL3k6qAneJ5sLJDWb4YXhBrH7AEG9ymBK6PpW
 JkWsI6bK15o0OpOUgjrNBraZxl7eu2ZSTIs7Yt8Eev9P0opcHMybkkO6mimrHJ6eudh4+jxViuK
 xec36IAnK3S17H75qWbKc+9jjFHtgPssUDbDv3w==
X-Google-Smtp-Source: AGHT+IE7/KhZxsG213j8lW0V9xP6VJcdAblcElQ0ny6Z70D0ZMqFgpiVMCw357bqxFe877QXyW3bF+Q4y/vpEd9S65E=
X-Received: by 2002:a17:90b:292:b0:299:906b:488e with SMTP id
 az18-20020a17090b029200b00299906b488emr1113564pjb.18.1709175347937; Wed, 28
 Feb 2024 18:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
 <20231231205804.2366509-6-bryan.zhang@bytedance.com> <ZbdmJ3CnBft_g9qI@x1n>
In-Reply-To: <ZbdmJ3CnBft_g9qI@x1n>
From: "Bryan Zhang ." <bryan.zhang@bytedance.com>
Date: Wed, 28 Feb 2024 18:55:37 -0800
Message-ID: <CAF4wfVMzdCjwxYNYwQyYOJxeEcQP3yzRPLqyTaKFw1FVM-26qA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 5/5] migration: Add integration test for
 'qatzip' compression method
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, marcandre.lureau@redhat.com, 
 quintela@redhat.com, peter.maydell@linaro.org, hao.xiang@bytedance.com
Content-Type: multipart/alternative; boundary="00000000000079240506127c65a8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000079240506127c65a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 12:53=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:

> On Sun, Dec 31, 2023 at 08:58:04PM +0000, Bryan Zhang wrote:
> > Adds an integration test for 'qatzip'.
>
> Please use "tests" as prefix of this patch.  It can be "tests/migration:"=
,
> "tests/migration-test:", etc.
>
> Will do.

> >
> > Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>
> [...]
>
> >  test_migrate_multifd_tcp_tls_psk_start_match(QTestState *from,
> > @@ -3480,6 +3504,19 @@ int main(int argc, char **argv)
> >      qtest_add_func("/migration/multifd/tcp/plain/zstd",
> >                     test_multifd_tcp_zstd);
> >  #endif
> > +#ifdef CONFIG_QATZIP
> > +    /*
> > +     * Use QATzip's qzInit() function as a runtime hardware check.
> > +     * Ideally there might be a cleaner way to probe for the presence
> of QAT.
> > +     */
> > +    QzSession_T sess;
> > +    memset(&sess, 0, sizeof(QzSession_T));
> > +    if (qzInit(&sess, 0) =3D=3D QZ_OK) {
>
> Does "0" means it'll fail if no hardware is available, no matter whether
> due to processor too old, or limited resources?
>
> Would it make sense to test it even if only software fallbacks are
> available?  IIUC the migration path will still be covered in software
> fallbacks, so it may still makes sense to me.  It can be very likely that
> most CIs will not cover the qatzip paths otherwise, because of either no
> control over hardwares, or limited privileges of the CI user (does qat HW=
s
> need special privilege normally?  I have no idea how QAT resource
> management is done if there're only limited HW resources).
>
> Besides, I believe all the data points you provided in the cover letter a=
re
> collected with 2 QAT HWs enabled?  I'm curious how's the performance of t=
he
> software fallback of qatzip comparing to existing algorithm: iiuc zstd is
> mostly always preferred if sololy comparing to zlib?  where does qatzip
> soft-mode stand in the picture?


> Yes, as I understand it, 0 means the code will error if the hardware is
unavailable for whatever reason.

We can enable software fallback in the live migration path, which will also
enable using software to run the QATzip tests (and will conveniently allow
us to remove the awkward `qzInit` check in the test code). It also might be
a good idea since it would also avoid failure in case of, e.g., a transient
hardware problem?

Performance: The software fallback seems prohibitively slow. QATzip
fallback uses the built-in zlib implementation, but I ran a migration test
that normally takes zlib about 150 seconds and the QATzip fallback took
about 30 minutes before my SSH session disconnected :P

Also, a note: When enabling software fallback, QATzip and the QAT driver
will both repeatedly print a complaint to the QEMU monitor when trying to
compress without hardware. Is it bad form to introduce
seemingly-unsuppressable prints from dependencies, or is this acceptable?

>
> Thanks,
>
> --
> Peter Xu
>
> Thanks for your feedback.

--
Bryan Zhang

--00000000000079240506127c65a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Jan 29, 2024 at 12:53=E2=80=AFAM =
Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">peterx@redhat.com</a>&gt;=
 wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Sun, Dec 31, 2023 at 08:58:04PM +0000, Bryan Zhang wr=
ote:<br>
&gt; Adds an integration test for &#39;qatzip&#39;.<br>
<br>
Please use &quot;tests&quot; as prefix of this patch.=C2=A0 It can be &quot=
;tests/migration:&quot;,<br>
&quot;tests/migration-test:&quot;, etc.<br>
<br></blockquote><div>Will do.=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
&gt; <br>
&gt; Signed-off-by: Bryan Zhang &lt;<a href=3D"mailto:bryan.zhang@bytedance=
.com" target=3D"_blank">bryan.zhang@bytedance.com</a>&gt;<br>
&gt; Signed-off-by: Hao Xiang &lt;<a href=3D"mailto:hao.xiang@bytedance.com=
" target=3D"_blank">hao.xiang@bytedance.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt;=C2=A0 test_migrate_multifd_tcp_tls_psk_start_match(QTestState *from,<b=
r>
&gt; @@ -3480,6 +3504,19 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qtest_add_func(&quot;/migration/multifd/tcp/plain/=
zstd&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0test_multifd_tcp_zstd);<br>
&gt;=C2=A0 #endif<br>
&gt; +#ifdef CONFIG_QATZIP<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Use QATzip&#39;s qzInit() function as a runtime=
 hardware check.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Ideally there might be a cleaner way to probe f=
or the presence of QAT.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 QzSession_T sess;<br>
&gt; +=C2=A0 =C2=A0 memset(&amp;sess, 0, sizeof(QzSession_T));<br>
&gt; +=C2=A0 =C2=A0 if (qzInit(&amp;sess, 0) =3D=3D QZ_OK) {<br>
<br>
Does &quot;0&quot; means it&#39;ll fail if no hardware is available, no mat=
ter whether<br>
due to processor too old, or limited resources?<br>
<br>
Would it make sense to test it even if only software fallbacks are<br>
available?=C2=A0 IIUC the migration path will still be covered in software<=
br>
fallbacks, so it may still makes sense to me.=C2=A0 It can be very likely t=
hat<br>
most CIs will not cover the qatzip paths otherwise, because of either no<br=
>
control over hardwares, or limited privileges of the CI user (does qat HWs<=
br>
need special privilege normally?=C2=A0 I have no idea how QAT resource<br>
management is done if there&#39;re only limited HW resources).<br>
<br>
Besides, I believe all the data points you provided in the cover letter are=
<br>
collected with 2 QAT HWs enabled?=C2=A0 I&#39;m curious how&#39;s the perfo=
rmance of the<br>
software fallback of qatzip comparing to existing algorithm: iiuc zstd is<b=
r>
mostly always preferred if sololy comparing to zlib?=C2=A0 where does qatzi=
p<br>
soft-mode stand in the picture?=C2=A0</blockquote><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><br></blockquote><div>Yes, as I understand it, 0 m=
eans the code will error if the hardware is unavailable for whatever reason=
.</div><div><br></div><div>We can enable software fallback in the live migr=
ation path, which will also enable using software to run the QATzip tests (=
and will conveniently allow us to remove the awkward `qzInit` check in the =
test code). It also might be a good idea since it would also avoid failure =
in case of, e.g., a transient hardware problem?</div><div><br></div><div>Pe=
rformance: The software fallback seems prohibitively slow. QATzip fallback =
uses the built-in zlib implementation, but I ran a migration test that norm=
ally takes zlib about 150 seconds and the QATzip fallback took about 30 min=
utes before my SSH session disconnected :P</div><div><br></div><div>Also, a=
 note: When enabling software fallback, QATzip and the QAT driver will both=
 repeatedly print a complaint to the QEMU monitor when trying to compress w=
ithout hardware. Is it bad form to introduce seemingly-unsuppressable print=
s from dependencies, or is this acceptable?</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br></blockquote><div>Thanks for your feedback.</div><div><br></div><div>--=
</div><div>Bryan Zhang</div></div></div>

--00000000000079240506127c65a8--

