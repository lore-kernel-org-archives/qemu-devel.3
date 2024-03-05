Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38771C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 06:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhO91-0000EG-9a; Tue, 05 Mar 2024 01:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rhO8t-0000Bs-M9
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 01:19:13 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rhO8q-0000R1-69
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 01:19:10 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-47259486a1fso1119799137.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 22:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709619542; x=1710224342; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t9nqsjGsjHu0OgureRZqRYa80276z37A+29y5cW7SC8=;
 b=XXMdfnPO2PRtt3lijXfsHNZJNiKFSV1W3NaqwK8dIG/z+HWOLqyvItFR/of0e5L0ZS
 f2b0nzV+tY6QAV9RgmxYqylUK5QZN18gOxoZzNDE6WkuK/zxozlVamQEs0RBx1k43sx+
 GCOq5V2otlDzgxo2vuqcaJ+aPXGzd7O/4WFXZXGcbRX/axmLpEUBUmh/XIuq0jgsa78c
 QqRFsdTUJVWhxFxT6HlG0ritr9xQujF3JcU27P4ayCACPHnKuOOPXw5seFV2g1xG4dxR
 6GyKgq2F6PnX9uhE8M/dZ6THRvZhyec3ugZm/ZPooEBNqyhWTCARfu6ABTiOAyGwhHrT
 rnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709619542; x=1710224342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t9nqsjGsjHu0OgureRZqRYa80276z37A+29y5cW7SC8=;
 b=SCM6lX54Z/01HTbrL2R9mJkuJnevK/lXWZ6vbEEvbiq9Cw8EEGaFEbWaC0yau+wQya
 zRhJUYmVyjS/y5x1zlKxyNcnqgyGdQPz9osH2qSz22ivAuwUGLJzmSUnZvSa+22W1N1e
 R92s3KpOAwWcK5xdiR9rvbmnsvu7TolpkNIOlf3zaHEGbFk46+UqYKKDldVNHuysckF4
 5dON6TfJG2OGvwIqkgH3kg1Ut6wBrWZgPWdljOWWDiAlEFmQh+zn2kt0hbEUa83+jx0G
 Hs44WgpzcMQv6sMFVYZ2sYGTT2P3WZn8nHXInMElslWJgw2T7L/bVnnvssQsgllunYgP
 NVtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4gb9piNUvEIVvw0LgNOI5FLptgFKBipn3env1ozkkDzNnFHsdRBfIOhN2xzI/NaqX/Jk/TsCZ06n+eumFgrhmABlFfi0=
X-Gm-Message-State: AOJu0YzZQuc+h5+3HYTgthWlQq5IabtvtbIxWlzG4JpYqlkX5bWuNJuz
 NfgSAkEUmmUs4KeVePe1KsY7xprTSSlGCrSZbWiKuRcLgdPPlDqt82DU+u5wCFOLRDOQKIi9vfl
 cRM3IFw0xgH4t9B5tpGwjepcPQdl+EAMvhQK6Og==
X-Google-Smtp-Source: AGHT+IFTEtlS723KrD/sGIZR/iFRVUXunrKnfzDUdAb2xqPpk4so46bQuE/ZCyGuFmv4UDEUNbTKdFRhL65Y2+n3Wks=
X-Received: by 2002:a67:e9da:0:b0:472:990d:84a with SMTP id
 q26-20020a67e9da000000b00472990d084amr962104vso.20.1709619542310; Mon, 04 Mar
 2024 22:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
 <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Mon, 4 Mar 2024 22:18:51 -0800
Message-ID: <CAKPbEqqvdN=6773pKRbzRcu1Rgkiv2gWBX13bm6v1aWzEOQmww@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1 0/1] Improved Memory Tier Creation for
 CPUless NUMA Nodes
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, 
 tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, linux-cxl@vger.kernel.org, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008567cb0612e3d108"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=horenchuang@bytedance.com; helo=mail-vs1-xe32.google.com
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

--0000000000008567cb0612e3d108
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 6:47=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > The memory tiering component in the kernel is functionally useless for
> > CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the
nodes
> > are lumped together in the DRAM tier.
> >
https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0=
PR08MB7955.namprd08.prod.outlook.com/T/
>
> I think that it's unfair to call it "useless".  Yes, it doesn't work if
> the CXL memory device are not enumerate via drivers/dax/kmem.c.  So,
> please be specific about in which cases it doesn't work instead of too
> general "useless".

Thank you and I didn't mean anything specific. I simply reused phrases we
discussed

earlier in the previous patchset. I will change them to the following in v2=
:


"At boot time, current memory tiering assigns all detected memory nodes

to the same DRAM tier. This results in CPUless memory/non-DRAM devices,

such as CXL1.1 type3 memory, being unable to be assigned to the correct
memory tier,

leading to the inability to migrate pages between different types of
memory."


Please see if this looks more specific.

> > This patchset automatically resolves the issues. It delays the
initialization
> > of memory tiers for CPUless NUMA nodes until they obtain HMAT
information
> > at boot time, eliminating the need for user intervention.
> > If no HMAT specified, it falls back to using `default_dram_type`.
> >
> > Example usecase:
> > We have CXL memory on the host, and we create VMs with a new system
memory
> > device backed by host CXL memory. We inject CXL memory performance
attributes
> > through QEMU, and the guest now sees memory nodes with performance
attributes
> > in HMAT. With this change, we enable the guest kernel to construct
> > the correct memory tiering for the memory nodes.
> >
> > Ho-Ren (Jack) Chuang (1):
> >   memory tier: acpi/hmat: create CPUless memory tiers after obtaining
> >     HMAT info
> >
> >  drivers/acpi/numa/hmat.c     |  3 ++
> >  include/linux/memory-tiers.h |  6 +++
> >  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
> >  3 files changed, 77 insertions(+), 8 deletions(-)
>
> --
> Best Regards,
> Huang, Ying

--
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

--0000000000008567cb0612e3d108
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sun, Mar 3, 2024 at 6:47=E2=80=AFPM Huang, Ying=
 &lt;<a href=3D"mailto:ying.huang@intel.com">ying.huang@intel.com</a>&gt; w=
rote:<br>&gt;<br>&gt; &quot;Ho-Ren (Jack) Chuang&quot; &lt;<a href=3D"mailt=
o:horenchuang@bytedance.com">horenchuang@bytedance.com</a>&gt; writes:<br>&=
gt;<br>&gt; &gt; The memory tiering component in the kernel is functionally=
 useless for<br>&gt; &gt; CPUless memory/non-DRAM devices like CXL1.1 type3=
 memory because the nodes<br>&gt; &gt; are lumped together in the DRAM tier=
.<br>&gt; &gt; <a href=3D"https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F=
08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/">https://=
lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB79=
55.namprd08.prod.outlook.com/T/</a><br>&gt;<br>&gt; I think that it&#39;s u=
nfair to call it &quot;useless&quot;.=C2=A0 Yes, it doesn&#39;t work if<br>=
&gt; the CXL memory device are not enumerate via drivers/dax/kmem.c.=C2=A0 =
So,<br>&gt; please be specific about in which cases it doesn&#39;t work ins=
tead of too<br>&gt; general &quot;useless&quot;.<br><br><div><p class=3D"gm=
ail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-a=
sian:normal;font-variant-alternates:normal;font-kerning:auto;font-feature-s=
ettings:normal;font-stretch:normal;font-size:13px;line-height:normal;font-f=
amily:&quot;Helvetica Neue&quot;">Thank=C2=A0you and I didn&#39;t mean anyt=
hing specific. I simply reused phrases we discussed</p><p class=3D"gmail-p1=
" style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:n=
ormal;font-variant-alternates:normal;font-kerning:auto;font-feature-setting=
s:normal;font-stretch:normal;font-size:13px;line-height:normal;font-family:=
&quot;Helvetica Neue&quot;">earlier in the previous=C2=A0<span style=3D"fon=
t-family:Arial,Helvetica,sans-serif;font-size:small">patchset</span>. I wil=
l change them to the following in v2:<span class=3D"gmail-Apple-converted-s=
pace">=C2=A0</span></p><p class=3D"gmail-p1" style=3D"margin:0px;font-varia=
nt-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:no=
rmal;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;fon=
t-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;">&quo=
t;At boot time, current memory tiering assigns all detected memory nodes</p=
><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font=
-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto=
;font-feature-settings:normal;font-stretch:normal;font-size:13px;line-heigh=
t:normal;font-family:&quot;Helvetica Neue&quot;">to the same DRAM tier. Thi=
s results in CPUless memory/non-DRAM devices,</p><p class=3D"gmail-p1" styl=
e=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;=
font-variant-alternates:normal;font-kerning:auto;font-feature-settings:norm=
al;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;=
Helvetica Neue&quot;">such as CXL1.1 type3 memory, being unable to be assig=
ned to the correct memory tier,</p><p class=3D"gmail-p1" style=3D"margin:0p=
x;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-a=
lternates:normal;font-kerning:auto;font-feature-settings:normal;font-stretc=
h:normal;font-size:13px;line-height:normal;font-family:&quot;Helvetica Neue=
&quot;">leading to the inability to migrate pages between different=C2=A0ty=
pes of memory.&quot;</p><p class=3D"gmail-p1" style=3D"margin:0px;font-vari=
ant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:n=
ormal;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;fo=
nt-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;"><br=
></p></div><div>Please see if this looks more specific.</div><br>&gt; &gt; =
This patchset automatically resolves the issues. It delays the initializati=
on<br>&gt; &gt; of memory tiers for CPUless NUMA nodes until they obtain HM=
AT information<br>&gt; &gt; at boot time, eliminating the need for user int=
ervention.<br>&gt; &gt; If no HMAT specified, it falls back to using `defau=
lt_dram_type`.<br>&gt; &gt;<br>&gt; &gt; Example usecase:<br>&gt; &gt; We h=
ave CXL memory on the host, and we create VMs with a new system memory<br>&=
gt; &gt; device backed by host CXL memory. We inject CXL memory performance=
 attributes<br>&gt; &gt; through QEMU, and the guest now sees memory nodes =
with performance attributes<br>&gt; &gt; in HMAT. With this change, we enab=
le the guest kernel to construct<br>&gt; &gt; the correct memory tiering fo=
r the memory nodes.<br>&gt; &gt;<br>&gt; &gt; Ho-Ren (Jack) Chuang (1):<br>=
&gt; &gt; =C2=A0 memory tier: acpi/hmat: create CPUless memory tiers after =
obtaining<br>&gt; &gt; =C2=A0 =C2=A0 HMAT info<br>&gt; &gt;<br>&gt; &gt; =
=C2=A0drivers/acpi/numa/hmat.c =C2=A0 =C2=A0 | =C2=A03 ++<br>&gt; &gt; =C2=
=A0include/linux/memory-tiers.h | =C2=A06 +++<br>&gt; &gt; =C2=A0mm/memory-=
tiers.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 76 +++++++++++++++++++++=
+++++++++++----<br>&gt; &gt; =C2=A03 files changed, 77 insertions(+), 8 del=
etions(-)<br>&gt;<br>&gt; --<br>&gt; Best Regards,<br>&gt; Huang, Ying<br><=
br>--<br>Best regards,<br>Ho-Ren (Jack) Chuang<br>=E8=8E=8A=E8=B3=80=E4=BB=
=BB</div>

--0000000000008567cb0612e3d108--

