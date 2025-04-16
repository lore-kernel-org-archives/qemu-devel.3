Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFDEC369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 22:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Api-00051R-7g; Wed, 16 Apr 2025 18:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u5Apg-0004zE-7k
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 18:02:12 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u5Ape-0000eq-2O
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 18:02:11 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-85e15dc801aso7896739f.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 15:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744840928; x=1745445728; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=h688ODngyyW/J+95F2p58lsO8Y8SOTF7MIcOece253M=;
 b=Zoocin1DGQzOVPGZ6ugSLDWHU7D+nytbGcUQew8cRZQ4kfnP+2MG1bg4Dqdm8UWmy0
 4+YgcbCAt2is+O1rH0wSZekaTOqHrHFqZatsYXZyfbWboVgwbYKJBq4Ch5KPHNNMGJhr
 NSqXFq/QxVUFmZy2BZkuk7JkMkj73ogwu21tk+tH3QLETWyqriViqerRMR7FDpCPJqtk
 QWUTORX69Jf1JqURveJ6Nkx33eKOQTDN9Zxc4BlfNFzF1GqD9uGelHFsf7LoE6sfC4Bh
 Zk4ScOn3Wl0SZBC7Ue5ykfe3BGQ47YIhNuTXQSrJ4jeqFuLb0v+xrxRGcL0EcDm42DLH
 XC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744840928; x=1745445728;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h688ODngyyW/J+95F2p58lsO8Y8SOTF7MIcOece253M=;
 b=RD/QjO28rKBvaP5R4hVqC0UegV8ypkLKo2Vq2Jf7ip5QrJAmHAMB0l9NAIpojqugA9
 6TumBnOcHSJI0r2tY5C8i77E6ZP0xYhA+Xo3DVzkk6p9qwZpJvMmfhWPufIFcWWxf9yA
 seiDALZqlaV7YsZYGGheNy7lEj7YnwtRkgkVSzuwkZOhKULprqb8xePd5X+dHNNswfkr
 6rtIaWezFhxYFfeWJ8FP421q3AXi+WS82CHH9R5e8THYdBfajop8d1DLhc/YKtoaTm/O
 44HHru0ZWa2qWLzDrygr8wjRdfoezbqkuNXRCyc5Hu5AAfDe+IfyopJmwPe4q4WPK3i8
 3Z0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWah9t20DlfMz621KYrinEW5KNADTynHdAiU0dfcC8ardKjRJL0IN/QCBif+kwZBF5GmMytrd69I1iu@nongnu.org
X-Gm-Message-State: AOJu0Yxu/RdsMgXeIiusDKzbdN058IwcDwI2z0IM6gBwFTw/G1dxgSlq
 UUA+oat7sMZ0wOEExqg/xW8dD25UhvbXhtMqPoC8jX1p61P8fH+J
X-Gm-Gg: ASbGncsm1HAPjal+lfg7Rnv1g3gnKg1flU8Lj6yM1CUeZ6viT4qs9t4lwrfwc8k8WYo
 S+osiT8b9JaiqTTwefvKCWcS3YqgFpIbf3NDmW9PBfHChlZSJV/6muOIq1Y8/JgadekoresCUkp
 /EjUfbvTyB7IU4EiSBReyxW1k6ziIXcQaWVwj13kEWHssnrnsF1qd6RmUvF8aB7DfcXNDRkIH1j
 UFyopfQL5dIWHUAXsqM1LfdMzAZUveLw7FFSCD6Ky9LHVMEeHEPkI9pAImpLYFGDMImhWBL95ik
 U6zXqLwN76AoC5tbeWkbTXr0vXtx3SHvcY9+Oh1/omP46+Sj1bFTowS92WxaKlSc6ndsiqphwGc
 =
X-Google-Smtp-Source: AGHT+IEFGfh+VY4RpL1lpBb9onaD6MkegyGKWzMEzkO13SFQuqCx2zn/vV9oLP8ATEm+f3wt/eo9Tw==
X-Received: by 2002:a05:6602:4c85:b0:85d:f316:fabc with SMTP id
 ca18e2360f4ac-861c50ee04cmr382331539f.8.1744840928030; 
 Wed, 16 Apr 2025 15:02:08 -0700 (PDT)
Received: from DESKTOPUU50BPD (c-67-190-160-7.hsd1.co.comcast.net.
 [67.190.160.7]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-86165428907sm313600639f.17.2025.04.16.15.02.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Apr 2025 15:02:06 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-4-brian.cain@oss.qualcomm.com>
 <079301dbaef8$91e8ff10$b5bafd30$@gmail.com>
 <d9b21bcf-cf13-4a4e-b942-2a61f71bbdad@oss.qualcomm.com>
In-Reply-To: <d9b21bcf-cf13-4a4e-b942-2a61f71bbdad@oss.qualcomm.com>
Subject: RE: [PATCH 03/38] target/hexagon: Add System/Guest register
 definitions
Date: Wed, 16 Apr 2025 16:02:03 -0600
Message-ID: <07a901dbaf1b$3160b200$94221600$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgIkiLuRAT03n/cBddyiSLUUuLkA
Content-Language: en-us
X-Antivirus: Norton (VPS 250416-4, 4/16/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd2f.google.com
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
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Wednesday, April 16, 2025 1:43 PM
> To: ltaylorsimpson@gmail.com; qemu-devel@nongnu.org
> Cc: richard.henderson@linaro.org; philmd@linaro.org;
> quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; alex.bennee@linaro.org;
> quic_mburton@quicinc.com; sidneym@quicinc.com; 'Brian Cain'
> <bcain@quicinc.com>
> Subject: Re: [PATCH 03/38] target/hexagon: Add System/Guest register
> definitions
>=20
>=20
> On 4/16/2025 12:54 PM, ltaylorsimpson@gmail.com wrote:
> >
> >> -----Original Message-----
> >> From: Brian Cain <brian.cain@oss.qualcomm.com>
> >> Sent: Friday, February 28, 2025 10:26 PM
> >> To: qemu-devel@nongnu.org
> >> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> >> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng;
> >> anjo@rev.ng; quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> >> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> >> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> >> Subject: [PATCH 03/38] target/hexagon: Add System/Guest register
> >> definitions
> >>
> >> From: Brian Cain <bcain@quicinc.com>
> >>
> >> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >> ---
> >>   target/hexagon/gen_analyze_funcs.py |  21 +++-
> >>   target/hexagon/hex_common.py        | 163
> >> ++++++++++++++++++++++++++++
> >>   2 files changed, 181 insertions(+), 3 deletions(-) diff --git
> >> a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index
> >> 758e5fd12d..db50defeb6 100755
> >> --- a/target/hexagon/hex_common.py
> >> +++ b/target/hexagon/hex_common.py
> >> @@ -33,6 +33,41 @@
> >>   overrides =3D {}  # tags with helper overrides  =
idef_parser_enabled =3D
> >> {}  # tags enabled for idef-parser
> >>
> >> +
> >> +def is_sysemu_tag(tag):
> >> +    return "A_PRIV" in attribdict[tag] or "A_GUEST" in
> >> +attribdict[tag]
> >> +
> >> +
> >> +def tag_ignore(tag):
> >> +    tag_skips =3D (
> >> +        "Y6_diag",
> >> +        "Y6_diag0",
> >> +        "Y6_diag1",
> >> +    )
> >> +    attr_skips =3D (
> >> +        "A_FAKEINSN",
> >> +        "A_MAPPING",
> > Add A_CONDMAPPING to this list.
>=20
>=20
> Will do.

Great.  Also, make sure tag_ignore is used by all the generator scripts. =
 Then, these won't show up any of the generated files (e.g., =
opcodes_def_generated.h.inc).


