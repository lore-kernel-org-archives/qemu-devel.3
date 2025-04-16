Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343BDC369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 14:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u54Dp-0005n2-FK; Wed, 16 Apr 2025 10:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u54Dm-0005mU-GE
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:58:38 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u54Dk-0002wB-K9
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:58:38 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d589ed2b47so21449615ab.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744815515; x=1745420315; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FjGCW5PhZQlTASC6/JHYFtFvcOGi4Ck5L5oKLVQ8brg=;
 b=b0qObDiUNDFdcRu+2Nh0vUjOXc/rVAFrm7J0Cy3WwvfsTdG34+YJMLy07mzLOS2yZR
 gWtinS/Hh0wfNrf1mE75I5eYUnQXu2fIOPChMpCVaUU6BbCJF7cxsDCEgGXlbHcE8ete
 cFWE2tye1W3hRAu30hVA+M4Ya7uFWgH0+kVnYmOOrNf83Q5QdLjmfvGU56JtMRe5Jn/h
 YMF97Jaj2Nv6pgYumDXswdkKHNt1Ah/aETgsZVd8ZUkk01qX5OLbPOHj/Q4PwmE2BDDG
 oes28v7Db2IaBdR7fyOKxOnXUNRLhFbk9hO4D77+YfdVU/8jgVSANq9321VXJ+fm9iqQ
 2mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744815515; x=1745420315;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FjGCW5PhZQlTASC6/JHYFtFvcOGi4Ck5L5oKLVQ8brg=;
 b=qBME6TvwyxKPfNK1JbND/LZwEYr8ptWvWbG+o3+E9Iig4nPQM6es9f//Eyj8V3EKom
 Z1oVTYzxVX6ddiv+Il3RkHjitoo0Su9aVoV16DKFWZJrxqL1jpu3iGDRz23mWkYkkCS7
 2YC07y0jKNVd3HFw5uo3WxGYGr9g4Q2mE9Dvd9Q68E3UKf+pfD0RsnoJszOqYHFa1h+z
 TWR+UBKRdPbYL/RTJPKveKJ1zJbv+sZ7poVb176eOXSl/I8KPEIndTNFQH1RqHaj+e92
 T4/Lu6mETSoKvUh28gqdxpAqwr7A4aryWwK0woTDmzEiO9LFhGZRI+unLeAzAZLcOyLn
 Jg6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJxlxoqnfrfWUWvMvIE5Zvw0sQ7UvU6Rg543/gQayQMZfa0bH/93veZhXcUp2W2blHVL2BbWZc5JhI@nongnu.org
X-Gm-Message-State: AOJu0Yzs6oOqaQSO2Lduws0CHqidhLXizwjt2ijkWhhmv0GEL3wtRY2V
 H6V3R/N2Sxa4u1uUI3ALkXfaCGbo9ubGFRzvOjSTeyWDmd2YYR2R
X-Gm-Gg: ASbGncsBJJrHH5QP9SsTFEs06skju6wiWCvzjrCmyeu4O7VdMHhLBLIbRekq5Vvx2cX
 rgFBdAzflbjqgNBUAqpQhExPM+Ag4fyxOvIA46Srz0pvxPo5w2HvPs1Xd4QgJSnbInWlDTmsLG+
 G3Qlvm9B6f++z1DVGqoxhLDDuGU8wWhKeOZFQ66um52NeAX2GGPyZl/60MT28wnr5RlFpDbcTo1
 m0QOVPAseJiL0CaTPrYbcdbXar2VoJdEKGuY4dyxtSa+5UJBTOSg/7cXZtTMwqfa4A7exDM6+h9
 wBfWgk0ZFYa8haccon3nvKt19Tj7NnbcZnwmT1NR8zSseSyTvvud8TquBbNn9a6qd2ojaa9e7ig
 =
X-Google-Smtp-Source: AGHT+IGATTLQgNIPI6XCpfFWWtdYlVPdE+WOCS1ryJvCRBlDNW0RmM1pJMrcNXiguImtkDHpAU0lfQ==
X-Received: by 2002:a05:6e02:3111:b0:3d8:975:b808 with SMTP id
 e9e14a558f8ab-3d815af7f18mr25264565ab.5.1744815514826; 
 Wed, 16 Apr 2025 07:58:34 -0700 (PDT)
Received: from DESKTOPUU50BPD (c-67-190-160-7.hsd1.co.comcast.net.
 [67.190.160.7]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d7dc5826cfsm36315055ab.55.2025.04.16.07.58.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Apr 2025 07:58:33 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: <brian.cain@oss.qualcomm.com>, <quic_mathbern@quicinc.com>,
 <sidneym@quicinc.com>, <quic_mliebel@quicinc.com>,
 <richard.henderson@linaro.org>, <ale@rev.ng>, <anjo@rev.ng>
References: <20250415235542.71703-1-ltaylorsimpson@gmail.com>
 <c7588131-2c4f-4a66-8107-cba4df904278@linaro.org>
 <074e01dbaede$2516b720$6f442560$@gmail.com>
In-Reply-To: <074e01dbaede$2516b720$6f442560$@gmail.com>
Subject: RE: [PATCH] Hexagon (target/hexagon) Remove gen_tcg_func_table.py
Date: Wed, 16 Apr 2025 08:58:29 -0600
Message-ID: <075601dbaee0$05faee40$11f0cac0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKaLHs1ylS/ArO36JsiYcELWqd62wKrQYO0Ax73lDCx+xGWEA==
Content-Language: en-us
X-Antivirus: Norton (VPS 250416-2, 4/16/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12c.google.com
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
> From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
> Sent: Wednesday, April 16, 2025 8:45 AM
> To: 'Philippe Mathieu-Daud=C3=A9' <philmd@linaro.org>; qemu-
> devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; quic_mathbern@quicinc.com;
> sidneym@quicinc.com; quic_mliebel@quicinc.com;
> richard.henderson@linaro.org; ale@rev.ng; anjo@rev.ng
> Subject: RE: [PATCH] Hexagon (target/hexagon) Remove
> gen_tcg_func_table.py
>=20
>=20
>=20
> > -----Original Message-----
> > From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Sent: Wednesday, April 16, 2025 12:18 AM
> > To: Taylor Simpson <ltaylorsimpson@gmail.com>; qemu-
> devel@nongnu.org
> > Cc: brian.cain@oss.qualcomm.com; quic_mathbern@quicinc.com;
> > sidneym@quicinc.com; quic_mliebel@quicinc.com;
> > richard.henderson@linaro.org; ale@rev.ng; anjo@rev.ng
> > Subject: Re: [PATCH] Hexagon (target/hexagon) Remove
> > gen_tcg_func_table.py
> >
> > Hi Taylor,
> >
> > On 16/4/25 01:55, Taylor Simpson wrote:
> > > This can easily be done in C with opcodes_def_generated.h.inc
> > >
> > > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > > ---
> > >   target/hexagon/genptr.c              |  6 ++-
> > >   target/hexagon/README                |  1 -
> > >   target/hexagon/gen_tcg_func_table.py | 66 =
----------------------------
> > >   target/hexagon/meson.build           | 10 -----
> > >   4 files changed, 5 insertions(+), 78 deletions(-)
> > >   delete mode 100755 target/hexagon/gen_tcg_func_table.py
> > >
> > > diff --git a/target/hexagon/gen_tcg_func_table.py
> > > b/target/hexagon/gen_tcg_func_table.py
> > > deleted file mode 100755
> > > index 299a39b1aa..0000000000
> > > --- a/target/hexagon/gen_tcg_func_table.py
> > > -        f.write("const SemanticInsn opcode_genptr[XX_LAST_OPCODE] =
=3D
> > {\n")
> > > -        for tag in hex_common.tags:
> > > -            ## Skip the priv instructions
> > > -            if "A_PRIV" in hex_common.attribdict[tag]:
> > > -                continue
> > > -            ## Skip the guest instructions
> > > -            if "A_GUEST" in hex_common.attribdict[tag]:
> > > -                continue
> > > -            ## Skip the diag instructions
> > > -            if tag =3D=3D "Y6_diag":
> > > -                continue
> > > -            if tag =3D=3D "Y6_diag0":
> > > -                continue
> > > -            if tag =3D=3D "Y6_diag1":
> > > -                continue
> >
> > What about all these skipped tags? IIUC gen_opcodes_def.py doesn't
> > skip them. If it isn't necessary to skip, please mention it in the
> > commit description for clarity.
> >
> > Regards,
> >
> > Phil.

I looked into this.  There aren't any instructions currently in the code =
that would be skipped by this logic.  Perhaps this logic was needed at =
one point in time but is no longer needed because those instructions =
were removed at some point.

I recall that Brian consolidated the logic to decide which instructions =
to skip into a single function in hex_common.py as part of the system =
mode patch series.  So, I'll go ahead and add a comment to the commit =
description as you suggest.

Thanks,
Taylor



