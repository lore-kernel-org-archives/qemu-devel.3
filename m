Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6926D2E9D1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 09:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAR9e-0002kP-7a; Mon, 11 Nov 2024 04:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tAR9Q-0002jh-4b
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 04:56:04 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tAR9M-0002FY-9S
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 04:56:03 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-84fd057a993so1824821241.3
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 01:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731318958; x=1731923758;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k1NaZzNLNEWnr446KL2HeFVoJ66FsDx+sNb8sXj1S6A=;
 b=1PpNcHZpfrpWxnpQcm5XBtSNDu2hfpkTpWFeuPJPkDCmkVEUqhy9ELteKOZhNMhSok
 iJa4jTkptnLjr/T1AVAU4SdKS16GqYuO7N3enfzgrBgESlzBoWnLpk/Xy7bL8m9MVy0O
 yyR34dypPRMdpMHCRmwRQ/4htNSwEV1gnFIyP4/OqgY4QvZ7HtOLv7PJCLrjWTil1YeI
 EnOAxLF3c0phZjRBI4heIM1hU0PcpIul0S22k23O2VXTiGUag7sB40shshdwl5W23Q/j
 VVYEQeKYlYsDX6gVgDDnaK1OapYEr+6aTv2Nh8Py5lJhW7JDbKMmH76wJ8DQlLqetmz4
 idrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731318958; x=1731923758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k1NaZzNLNEWnr446KL2HeFVoJ66FsDx+sNb8sXj1S6A=;
 b=WWAcx3FjF1Jx+891P0zk5tZ3keUelMEv2faC7u9gTYUO/HNcMmc5K2akb9gGtE8XJn
 hdMB8aIThCeUnqI+jx6k3FbZHYpRU9Pz2vEaeaqvVAvzy1QMnq/ITksAMpYuI9aG5aU/
 ntSeFbx18arahB1fNi8d5TP2LOllAr7Meim7SIya11+e4pIPUkRPQKz6wQaCffSy08BT
 zRvt4C6odem+kNdXH72XCn+LFPSXcxx4hxDjt4yooaIAH+U6J+Dzr/brImKSGivCiDAT
 RwE6kzSDwvJgwoq0YuMk3e30dlWciwCyDDVLFWWJ13gK29tlvHH9rOYNx8LvNJa9f9RF
 NnRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXer0dTkN0QGgk5Mns3SBDqQToUrPKk1M/WnJPz6gjbB8yVjPYhrowN6s5/PH6+h8QtH+oU8K7k+iuj@nongnu.org
X-Gm-Message-State: AOJu0Yy92kvWQLGeUe14tOILx7ArPaTpkkLqomCdZJIqXiwi119gCMj7
 HswF/Z4F+tBnanWIgbS4F1K7LPGRH9d3lVl7ejUx5us57NFKPSrnb4U8xYsA+JMxT4ip5Fiw4Cn
 5K2R7/1XZlw+6TCbS3DiDcTvmXvblpaUGm5MG
X-Google-Smtp-Source: AGHT+IE/VVWrbqHfXxUQARQ1DQedtqv29y1nOvyIrffFguo07pE320u217ho/MC8acqZUfvrSBbxo8I64hXVVtrqOmM=
X-Received: by 2002:a05:6102:3f09:b0:4a4:8651:3c2c with SMTP id
 ada2fe7eead31-4aae1686ad9mr10075987137.20.1731318957707; Mon, 11 Nov 2024
 01:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20241108144709.95498-1-phil@philjordan.eu>
 <20241108144709.95498-2-phil@philjordan.eu>
 <9c2e0b96-2125-4041-9f66-116d54accb04@daynix.com>
 <CAAibmn3NbtOEwWLQFOo_UmAGTehOj+dDP04A=-JGMZVK9AYMDw@mail.gmail.com>
 <ZzHJgAbBJZYrSt84@redhat.com>
In-Reply-To: <ZzHJgAbBJZYrSt84@redhat.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 11 Nov 2024 10:55:46 +0100
Message-ID: <CAAibmn2+pT_kpcdHd26KsFggRNRR3yPep11fToOK=GZ9AEDHpw@mail.gmail.com>
Subject: Re: [PATCH v8 01/15] ui & main loop: Redesign of system-specific main
 thread event handling
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org,
 agraf@csgraf.de, 
 peter.maydell@linaro.org, pbonzini@redhat.com, rad@semihalf.com, 
 quic_llindhol@quicinc.com, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000077b18f0626a01bb0"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::936;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x936.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--00000000000077b18f0626a01bb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 at 10:08, Daniel P. Berrang=C3=A9 <berrange@redhat.com>
wrote:

> On Sun, Nov 10, 2024 at 08:08:16AM +0100, Phil Dennis-Jordan wrote:
> > On Sun 10. Nov 2024 at 08:01, Akihiko Odaki <akihiko.odaki@daynix.com>
> > wrote:
> >
> > > On 2024/11/08 23:46, Phil Dennis-Jordan wrote:
> > > > macOS's Cocoa event handling must be done on the initial (main)
> thread
> > > > of the process. Furthermore, if library or application code uses
> > > > libdispatch, the main dispatch queue must be handling events on the
> main
> > > > thread as well.
> > > >
> > > > So far, this has affected Qemu in both the Cocoa and SDL UIs,
> although
> > > > in different ways: the Cocoa UI replaces the default qemu_main
> function
> > > > with one that spins Qemu's internal main event loop off onto a
> > > > background thread. SDL (which uses Cocoa internally) on the other
> hand
> > > > uses a polling approach within Qemu's main event loop. Events are
> > > > polled during the SDL UI's dpy_refresh callback, which happens to r=
un
> > > > on the main thread by default.
> > >
> > > GTK should also do the same as SDL and requires treatment; I forgot t=
o
> > > note that in previous reviews.
> >
> >
> > Although it=E2=80=98s possible to build Qemu with GTK support enabled o=
n macOS,
> > that UI doesn=E2=80=99t actually work on macOS at all, and apparently h=
asn=E2=80=99t been
> > supported since 2018, see:
> > https://stackoverflow.com/a/51474795
> >
> > I don=E2=80=99t think there=E2=80=99s any point making adjustments to t=
he GTK code by
> > guessing what might be needed if someone did fix that to work with macO=
S
> at
> > some point.
>
> If we don't support GTK on macOS, then we should update meson.build
> to actively prevent users enabling GTK on macOS builds, rather than
> letting them suffer random runtime crashes.
>
>
Agreed - I'm now more confused than ever though because
https://gitlab.com/qemu-project/qemu/-/issues/2539 sort of implies that
Philippe has previously been using it successfully. Or perhaps this was
created in response to https://gitlab.com/qemu-project/qemu/-/issues/2515 ?
But it seems like even the SDL implementation isn't perfect:
https://gitlab.com/qemu-project/qemu/-/issues/2537

Basically, it seems like Qemu's UI threading on macOS is currently a bit of
a mess, except in the Cocoa UI.

--00000000000077b18f0626a01bb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, 11 Nov 2024 at 10:08, Daniel =
P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Sun, Nov 10, 2024 at 08:08:16AM +0100, Phil Dennis-Jordan wrote:<br>
&gt; On Sun 10. Nov 2024 at 08:01, Akihiko Odaki &lt;<a href=3D"mailto:akih=
iko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br=
>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On 2024/11/08 23:46, Phil Dennis-Jordan wrote:<br>
&gt; &gt; &gt; macOS&#39;s Cocoa event handling must be done on the initial=
 (main) thread<br>
&gt; &gt; &gt; of the process. Furthermore, if library or application code =
uses<br>
&gt; &gt; &gt; libdispatch, the main dispatch queue must be handling events=
 on the main<br>
&gt; &gt; &gt; thread as well.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; So far, this has affected Qemu in both the Cocoa and SDL UIs=
, although<br>
&gt; &gt; &gt; in different ways: the Cocoa UI replaces the default qemu_ma=
in function<br>
&gt; &gt; &gt; with one that spins Qemu&#39;s internal main event loop off =
onto a<br>
&gt; &gt; &gt; background thread. SDL (which uses Cocoa internally) on the =
other hand<br>
&gt; &gt; &gt; uses a polling approach within Qemu&#39;s main event loop. E=
vents are<br>
&gt; &gt; &gt; polled during the SDL UI&#39;s dpy_refresh callback, which h=
appens to run<br>
&gt; &gt; &gt; on the main thread by default.<br>
&gt; &gt;<br>
&gt; &gt; GTK should also do the same as SDL and requires treatment; I forg=
ot to<br>
&gt; &gt; note that in previous reviews.<br>
&gt; <br>
&gt; <br>
&gt; Although it=E2=80=98s possible to build Qemu with GTK support enabled =
on macOS,<br>
&gt; that UI doesn=E2=80=99t actually work on macOS at all, and apparently =
hasn=E2=80=99t been<br>
&gt; supported since 2018, see:<br>
&gt; <a href=3D"https://stackoverflow.com/a/51474795" rel=3D"noreferrer" ta=
rget=3D"_blank">https://stackoverflow.com/a/51474795</a><br>
&gt; <br>
&gt; I don=E2=80=99t think there=E2=80=99s any point making adjustments to =
the GTK code by<br>
&gt; guessing what might be needed if someone did fix that to work with mac=
OS at<br>
&gt; some point.<br>
<br>
If we don&#39;t support GTK on macOS, then we should update meson.build<br>
to actively prevent users enabling GTK on macOS builds, rather than<br>
letting them suffer random runtime crashes.<br>
<br></blockquote><div><br></div><div>Agreed - I&#39;m now more confused tha=
n ever though because <a href=3D"https://gitlab.com/qemu-project/qemu/-/iss=
ues/2539">https://gitlab.com/qemu-project/qemu/-/issues/2539</a> sort of im=
plies that Philippe has previously been using it successfully. Or perhaps t=
his was created in response to <a href=3D"https://gitlab.com/qemu-project/q=
emu/-/issues/2515">https://gitlab.com/qemu-project/qemu/-/issues/2515</a> ?=
 But it seems like even the SDL implementation isn&#39;t perfect: <a href=
=3D"https://gitlab.com/qemu-project/qemu/-/issues/2537">https://gitlab.com/=
qemu-project/qemu/-/issues/2537</a></div><div><br></div><div>Basically, it =
seems like Qemu&#39;s UI threading on macOS is currently a bit of a mess, e=
xcept in the Cocoa UI.</div><div><br></div></div></div>

--00000000000077b18f0626a01bb0--

