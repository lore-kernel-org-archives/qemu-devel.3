Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662DAC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 18:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsnaj-0006AM-9x; Thu, 13 Mar 2025 14:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsnah-00063q-1k
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:47:35 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsnaf-0004Wd-7q
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:47:34 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6e8fd49b85eso19326806d6.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 11:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741891652; x=1742496452; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UMv5uosJhdU3CPnzti2JESLApJNryQfKSomuXWYOMnQ=;
 b=Y9qqr7BxDLxEmtufoJVbivqQNnKSU5b7/7vB8rOuJvzNlksFkBo3guZmNNT9nCJWWv
 rnfsCSXsXc8TNyi1lNmXuNWy9jbOje0VP3rZX3sz+vsIeRQC4U5zaxn0vAXPvVZRUrEZ
 OQ8NLaC8UyMYNkFeOO+2BrRLSsIY0Al2iSI1Gq4JlnPGFXrjawu3agTgpcuwsFKqImDn
 pjfc+rVLWsOBFH/F0gseytjIW1IFZP3mAXxGG2vHwsqdEDTFM/kVgHVlMPWlBplAOShN
 /apuInYwE1jt9qCX5x9vXLc1fBT2NBfqh0IwqQMEO0Dok51YWfhLQl+z9G8/2pLHWtbO
 pzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741891652; x=1742496452;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UMv5uosJhdU3CPnzti2JESLApJNryQfKSomuXWYOMnQ=;
 b=tlaClMK4jKpxgMIY5/HS13OSRdvD+rTxP7MFcbg1m9jwlEBblAJVROyr/ZT+k07BPv
 H4thqy9PPnyTtsUDlQFjV6iu/0uEl2ECl5omxbEx26yXG6PN11pveDXiIHyvKCc6Xo0H
 jLYrJ/EoE7IAr7zdHAoofcoUHX3LNQDl8ham3Ca/5UlDaD/PYcSgi/8VUdzXYB+19ia2
 2bUgncB/NeUjycUYbonOF0vzcoOJ99QQyKmKOg8z7JHCiYbCPjZX0GKM3NFuIIeFAk1N
 9mo38MDmlY4QFOsXgTQHdny1XFnm42AI9Ek7xJYzz0eAgDU1fA4SFOIBw+28UATG7zcs
 Mvnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrCwXT8n+fr7plElcXffG3WyMXAPNbv9jrXtr7CNTOaBf9EKaDFBZoIf1qRbG+vt5Jmbt/BhVyxt8J@nongnu.org
X-Gm-Message-State: AOJu0Yw7NCqBWgoi/iwGx4JUrsCQfRkutYHLY3BM+NYtUd3aXJQ1p5lh
 cLT073rACdEmTKIjJkFRUzUrb5GsHi5uiRl8sWNjVmQkqfHAAwhN
X-Gm-Gg: ASbGnctTZbZa7vTyJwFfkjpdGNqq/bGq95VOBnCEh4cfpMijzc5UxV2ZVDWvqLXeMEg
 lWkxtAOKchf9tFWWkeyhprgVxWJ7M3kVHYnkY1lPlqOL1PCPMGdK0pZrR5YgWiaMvSOx7Srhbhd
 8jErfMvtwpLGmHFkWbrvtfohaB40D15OI03DG5l/8YlfNxYyoMtqiFQknBKBdLnCatpOTLFFXRt
 1t8BhVmK6vvVqpzm/mYiCHqAw+ZgD26ein29pEfEPj3WUnuL3zyXO4Mv/QKE7YgMZvYHmZXEzg6
 mwBOgY7Py+HWb2F3+yTV0KaDsdW5AVbyEgeKiRd0o5CuhvtzRgFnOusk/eqW2zI=
X-Google-Smtp-Source: AGHT+IHGF8gQ0fBOD5ewl0Cwuj9KnHFghPTkRKjYs3G6g/MBSuEuUcA75968qFkO4bviud4VApI4iQ==
X-Received: by 2002:a05:6214:da9:b0:6d8:9062:6616 with SMTP id
 6a1803df08f44-6eae79ac1e8mr14871236d6.7.1741891651626; 
 Thu, 13 Mar 2025 11:47:31 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:70f5:b65d:482b:3678])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade234b9dsm12656876d6.39.2025.03.13.11.47.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Mar 2025 11:47:31 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: =?UTF-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@linaro.org>,
 "'Brian Cain'" <brian.cain@oss.qualcomm.com>, <qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <quic_mathbern@quicinc.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-29-brian.cain@oss.qualcomm.com>
 <44e23197-a2ec-4477-a4b8-a526f83e47c2@linaro.org>
 <b84bcd2d-9974-41f0-b9f5-2d416ed16d0d@oss.qualcomm.com>
 <67b33d51-b8c8-421c-8aba-efa9a0b46bf5@linaro.org>
In-Reply-To: <67b33d51-b8c8-421c-8aba-efa9a0b46bf5@linaro.org>
Subject: RE: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
Date: Thu, 13 Mar 2025 13:47:29 -0500
Message-ID: <008601db9448$601bc370$20534a50$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgJRPWMEAoJ78HcCD2q79AMHZxbltLZpIgA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250313-6, 3/13/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Sent: Wednesday, March 12, 2025 6:40 PM
> To: Brian Cain <brian.cain@oss.qualcomm.com>; qemu-devel@nongnu.org
> Cc: richard.henderson@linaro.org; quic_mathbern@quicinc.com;
> ale@rev.ng; anjo@rev.ng; quic_mliebel@quicinc.com;
> ltaylorsimpson@gmail.com; alex.bennee@linaro.org;
> quic_mburton@quicinc.com; sidneym@quicinc.com; Brian Cain
> <bcain@quicinc.com>
> Subject: Re: [PATCH 28/38] target/hexagon: Initialize htid, modectl =
regs
>=20
> On 13/3/25 00:10, Brian Cain wrote:
> >
> > On 3/12/2025 2:19 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 1/3/25 06:26, Brian Cain wrote:
> >>> From: Brian Cain <bcain@quicinc.com>
> >>>
> >>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >>> ---
> >>>   target/hexagon/cpu.c | 8 ++++++++
> >>>   1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
> >>> 36a93cc22f..2b6a707fca 100644
> >>> --- a/target/hexagon/cpu.c
> >>> +++ b/target/hexagon/cpu.c
> >>> @@ -26,6 +26,7 @@
> >>>   #include "fpu/softfloat-helpers.h"
> >>>   #include "tcg/tcg.h"
> >>>   #include "exec/gdbstub.h"
> >>> +#include "cpu_helper.h"
> >>>     static void hexagon_v66_cpu_init(Object *obj) { }
> >>>   static void hexagon_v67_cpu_init(Object *obj) { } @@ -290,11
> >>> +291,18 @@ static void hexagon_cpu_reset_hold(Object *obj,
> ResetType
> >>> type)
> >>>       set_float_default_nan_pattern(0b11111111, &env->fp_status);
> >>>     #ifndef CONFIG_USER_ONLY
> >>> +    HexagonCPU *cpu =3D HEXAGON_CPU(cs);
> >>> +
> >>>       if (cs->cpu_index =3D=3D 0) {
> >>
> >> This doesn't scale to heterogeneous emulation.
> >>
> >
> > If we have a target-specific index here (instead of cpu_index)
> > guarding the "g_sreg" allocation shared by these Hexagon vCPUs, does
> > that suffice?  Or is the problem the shared allocation itself?
>=20
> I'm not sure that suffices, but it is still better from my PoV.
>=20
> Let's assume we instantiate 4 ARM cores, then 2 HEX ones. The first =
Hexagon
> core has cpu_index=3D5. Now for the same example machine we =
instantiate
> first the Hexagon cores, then the ARM ones. The first Hexagon core has
> cpu_index=3D0.
>=20
> > Could a heterogeneous emulation configuration consist of multiple
> > instances of (same-architecture) vCPU-groups?
>=20
> Up to you if you want to model multiple hexagon SoCs in the same =
machine
> ;) Note in that case you could use a CPUClusterState to group.

What we are trying to model is an instance of a Hexagon that has a =
number of threads and some resources that are shared.  The shared =
resources include the TLB and global S registers.  The initial thought =
was to tie the shared resources to the thread with cpu_index =3D=3D 0.  =
If we were to model a Qualcomm SoC, there would be multiple ARM cores =
and multiple Hexagon instances.  Each Hexagon instance would have =
distinct shared resources.  So, you are correct that using cpu_index is =
not going to scale.

What is the recommended way to model this?  I see a "nr_threads" field =
in CPUCore but no clear way to find the threads.  PPC has some cores =
that add a "threads" field.  Should we follow this approach?

HTH,
Taylor



