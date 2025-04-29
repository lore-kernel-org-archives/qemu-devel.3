Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBAEC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ltv-0000qD-9g; Tue, 29 Apr 2025 10:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9ltW-0000bh-8B
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9ltT-0001DT-LQ
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745936706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ldTXU3xb6Uj55vJAVMIKvmWuqI+nN2VBgXfsl1y1sA=;
 b=KRCp7ilRlv3GsHuEPpSJmORRmtHqzHWv9Ty6l4r4lKuJ0WtZcvH3LEaqSm6exo3uvJ9Sn3
 NqQhV9CXJuql8uD8pJcWk1JO9F9fjTOMD/oxSVkm1wv5Mo3Adn7AjkN1qFLcIahAM2kkPZ
 28nA1CXARWGWl2DyKNrSR2M58l9ZgPs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-P-GHEd-JPw6iwQBi-jLe2A-1; Tue, 29 Apr 2025 10:25:04 -0400
X-MC-Unique: P-GHEd-JPw6iwQBi-jLe2A-1
X-Mimecast-MFC-AGG-ID: P-GHEd-JPw6iwQBi-jLe2A_1745936703
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a08a1c0fc5so534217f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745936703; x=1746541503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ldTXU3xb6Uj55vJAVMIKvmWuqI+nN2VBgXfsl1y1sA=;
 b=VZ1us0m2UiVLGgN5xhaj/oOLk8UHGPfqFrPr7R3qsOPtGr59SBZ4AxmdZ+RBp9WP/s
 KVVTe5pCiLNmhfkQZyk2BBLsD5RbF1lAmzo0WC/BL4IyI//1AhC//2PLMs3MgACMg6+6
 tiZ8w8gWKDf7yyudYAkTol72sVWuylZSMTASdsNsRY8furUHG++vcLLS1CgWLQg2GiOS
 fiHPX4Avju4Z37eBPndP5K7Ug+d3ig7lvXd1bE/uTdh4mJ9K+8qZvQRGarhDezVGsrJP
 gyeF9tYDvCB1T/Fz61Lh6oUOAJDys7tnIwOnsAYbr69LEUStcHGtTiyKM8myN4oiEvtJ
 VNWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsd21brWm8Sotnt53XWk9N2I3resoPv4n/rVOhSxCib/jl0LX6HiDE658Dhi9LADJXXVmxmFNNNVNp@nongnu.org
X-Gm-Message-State: AOJu0YyPDP6P82DI2MILhWM/+RpoRNXgRUIl8s5L4PZTBeRebvRI7f/g
 l2exdh5WJ7HeAlfc5gIdTTBNy+3C1koRuuBwblFQz3p9K3MXqgOAKoE3+w7aQPE5lOBOjUCztcd
 FcV59s5DZ92+D1zBEMrPHEKgZi7zdJ2uZYi5+P7fYdPxGO3jeZojwUIxSicbUB6pxLxvz79MEpI
 LoqjRxQ6l0uQ1UP088XwUEUFByJ6c=
X-Gm-Gg: ASbGnctrMA73F7xOlMXyZCodeCClQ81SYIITm7FgGuFEHrgYebY2i6W/73tzi583ioY
 J8yrqP0eETcYfkWzjy9RbLFBEbSXQjDgxCVw8/q8SI5cNG1HmG80AmdiXWGubzuMxL3E=
X-Received: by 2002:a5d:6947:0:b0:3a0:8325:8090 with SMTP id
 ffacd0b85a97d-3a0890ab7dfmr2775255f8f.18.1745936702583; 
 Tue, 29 Apr 2025 07:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn5K8ZiipJ8PpEcBMsEyVdUyMUHV60O+LocCKTeXg05u5JifTA54a9fkIAaxgd94jOLcBxt4BL4y0uSHEFFHg=
X-Received: by 2002:a5d:6947:0:b0:3a0:8325:8090 with SMTP id
 ffacd0b85a97d-3a0890ab7dfmr2775229f8f.18.1745936702204; Tue, 29 Apr 2025
 07:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <874iy85yx2.fsf@draig.linaro.org>
 <eefb308b-5cd8-4b30-bc32-e37f601cb07b@linaro.org>
In-Reply-To: <eefb308b-5cd8-4b30-bc32-e37f601cb07b@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 29 Apr 2025 16:24:49 +0200
X-Gm-Features: ATxdqUEOSw3c3XC5DaIgbZ1zDMBwzK3d9WVx0Z-qRuyCunLOCOXiVxLVEoF-oUE
Message-ID: <CABgObfYmm2RgFUuViDJA_cuqeCUOh_DV5Qar8YLnrbfYVV39VQ@mail.gmail.com>
Subject: Re: KVM/QEMU Community call 29/04/2025 agenda items?
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Mark Burton <mburton@qti.qualcomm.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, 
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>, 
 Chao Peng <chao.p.peng@linux.intel.com>, Neo Jia <cjia@nvidia.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "Wedgwood, Chris" <cw@f00f.org>, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, 
 eblot@rivosinc.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, 
 Felipe Franciosi <felipe@nutanix.com>, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Jidong Xiao <jidong.xiao@gmail.com>, 
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Chou <max.chou@sifive.com>, 
 Meirav Dean <mdean@redhat.com>, mimu@linux.vnet.ibm.com, 
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, 
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, 
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "Wu, Zhiyong" <zwu.kernel@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000ef93a10633eb903b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000ef93a10633eb903b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 28 apr 2025, 14:58 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> On 28/4/25 13:05, Alex Benn=C3=A9e wrote:
> >
> > Hi,
> >
> > The KVM/QEMU community call is at:
> >
> > https://meet.jit.si/kvmcallmeeting
> > @
> > 29/04/2025 14:00 UTC
> >
> > Are there any agenda items for the sync-up?
> >
>
> For single binary / heterogeneous emulation, we'd like QAPI to
> be "feature-agnostic". In particular, using the example of KVM
> accelerator, whether a binary can run with it built-in or not
> should be is irrelevant for management applications: they should
> only check if it is used (enabled).
>
> The following series is adding KVM specific structures and commands:
>
> https://lore.kernel.org/qemu-devel/20250409082649.14733-2-zhao1.liu@intel=
.com/
> It could be interesting to discuss if this can be avoided. But this
> can also be discussed on the mailing list (as it is still currently).
>

Would it be possible to just mark the commands as "do not autoregister" and
then do the registration (for example) at machine/accelerator/CPU creation?

I think qemu-ga already has a similar run-time registration model but I
don't know why QEMU does not use it.

Paolo

>

--000000000000ef93a10633eb903b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 28 apr 2025, 14:58 Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 28/4/25 13:05, Alex Benn=C3=A9e wrote:<br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; The KVM/QEMU community call is at:<br>
&gt; <br>
&gt; <a href=3D"https://meet.jit.si/kvmcallmeeting" rel=3D"noreferrer noref=
errer" target=3D"_blank">https://meet.jit.si/kvmcallmeeting</a><br>
&gt; @<br>
&gt; 29/04/2025 14:00 UTC<br>
&gt; <br>
&gt; Are there any agenda items for the sync-up?<br>
&gt; <br>
<br>
For single binary / heterogeneous emulation, we&#39;d like QAPI to<br>
be &quot;feature-agnostic&quot;. In particular, using the example of KVM<br=
>
accelerator, whether a binary can run with it built-in or not<br>
should be is irrelevant for management applications: they should<br>
only check if it is used (enabled).<br>
<br>
The following series is adding KVM specific structures and commands:<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20250409082649.14733-2-zhao1.=
liu@intel.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lor=
e.kernel.org/qemu-devel/20250409082649.14733-2-zhao1.liu@intel.com/</a><br>
It could be interesting to discuss if this can be avoided. But this<br>
can also be discussed on the mailing list (as it is still currently).<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Would =
it be possible to just mark the commands as &quot;do not autoregister&quot;=
 and then do the registration (for example) at machine/accelerator/CPU crea=
tion?</div><div dir=3D"auto"><br></div><div dir=3D"auto">I think qemu-ga al=
ready has a similar run-time registration model but I don&#39;t know why QE=
MU does not use it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paol=
o</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div></div>

--000000000000ef93a10633eb903b--


