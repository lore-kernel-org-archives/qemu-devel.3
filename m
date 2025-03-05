Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F852C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 21:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpwAv-0001yC-Kt; Wed, 05 Mar 2025 16:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tpwAt-0001xb-A2
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 16:21:07 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tpwAq-0006HK-CI
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 16:21:07 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6e8f4c50a8fso15466d6.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 13:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741209663; x=1741814463; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OYeAA8TT3pgjnMX9T6/vB5PYR2wFTKyZ5Bzl52yXEfI=;
 b=iACVYmz535M/2suxA8P/Myc7/+RghNT3uoPxk3KA+nG0CguV7szc/QQPgXtr9pmpOL
 KcbZwXr1CmwSVy+MtDMuw/hajTTAcDHHPvVTVtOhW48L35m54DdxYuSTvQtVWIL0IUK4
 AIjM5YxU7yfkl9TVULDKg6JvPsGUpBaVCuiNzL6QDJGaNldpMxtm/x7jk/Ya8QUjUYny
 /1uOnwg8alElHjQtxiKMGsxDkRa8k4H26D/+oV3Dx1Lb4S2HIqbFF0U9sdeJuCQcPr7Z
 ZyEVixBST1sT9Xm84CsjWmtlL+M7zwSG722HSbbHzLgctIbfLqycVEjhol+iZ5TW7/9o
 EI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741209663; x=1741814463;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OYeAA8TT3pgjnMX9T6/vB5PYR2wFTKyZ5Bzl52yXEfI=;
 b=tXNAKHQU51ttROJIBIoQxX1v7cqndr3iLPhaT/jqTYfYciAR9Ey+o49SfYbBV2yQWn
 6G7YdHiZ7qz9CIlGkyariNTF6GMezJ/Q7xbEKFshuf04EDJ1q67fmROq4ZT3R7yGZCZS
 jECpK9kqx7y/8giQE9KPs25UIge78JhyjxRczOWztxBEfHO9RGtbly65bTnG8cfz5sw0
 bdGZSWf/VKK1p17GGiluFPAP4EQ8GocP9yH24Lz8Ng3+Av6iWdFHAH+w6qYjLkuCLCfS
 MINcU5lXuK5wvlc5iD7qYva9vXEh/EHdqnEUj39wAUdwC1+0gjmva1+xUBzc/TDKirCL
 NYwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw5PlEer/M9BkCwAFxrOnfbY3XL2nqJUR32x0j2wv9g/mfz27z+1D6i0v7yOWk/44jg5Ha8GgO+zSv@nongnu.org
X-Gm-Message-State: AOJu0YyBjWxorrbbAj5Exn63nGeys5mLoqIfVft4mje/HfmYoc+DplYU
 Q7v+xQKQKeSIXnAqHcxMXYxwx94ldPNPZ+jQZq5I2cmNcm6TOhAO
X-Gm-Gg: ASbGncvrOicP5WBsPSVa3RZc41eozUtOXPMQ2XM6dm5ZHWZtsb09f9pRct/BfkqC6Kx
 z3NECIZPFOVAjvDKRSmwYFOkhYMT2V8WB5HEXugg7I92Pbw1MyF3PGMOJ55XhaUo3y3myw99w+c
 fLsEFcNROT8emIlPMI7sQVx6izVxH5lYwVbj74GHKn/pu3CkG+y7sZuC2seqv0byKDLio8/+sIR
 NvCKMEckBuyPcGjwj/q9YSgahYQkUS3vdpmRKzkcmiphbsX+rRTtrUh7JMCsNpv9Rl7aeR6kz3d
 4lhxUnaTI9WvGkkoO50qBA6gyutDvgQV+JXiE/hh25WS2nwc9B0dI2/Eqcz+6ZQ=
X-Google-Smtp-Source: AGHT+IFd6eNZJyFtG29q8c0oodD7lMS3HMP0nri0FqvBYZClUgYv6CL6byFgX3iJhjriBFc7KOl5Ng==
X-Received: by 2002:a05:6214:4012:b0:6e8:ad15:e0b9 with SMTP id
 6a1803df08f44-6e8e6d34670mr76256666d6.20.1741209663107; 
 Wed, 05 Mar 2025 13:21:03 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:c425:d3e6:56b4:85c4])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f4b5c35dsm2067656d6.57.2025.03.05.13.21.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Mar 2025 13:21:02 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-3-brian.cain@oss.qualcomm.com>
 <01aa01db8e05$d5abd330$81037990$@gmail.com>
 <bf301657-eea6-4f3d-b64f-6a36c5375ec7@oss.qualcomm.com>
In-Reply-To: <bf301657-eea6-4f3d-b64f-6a36c5375ec7@oss.qualcomm.com>
Subject: RE: [PATCH 02/38] docs/system: Add hexagon CPU emulation
Date: Wed, 5 Mar 2025 15:21:01 -0600
Message-ID: <01c401db8e14$7f4c5280$7de4f780$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgD3FrldAZv0cM4CMu5+o7TTNaQw
X-Antivirus: Norton (VPS 250305-8, 3/5/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf30.google.com
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
> Sent: Wednesday, March 5, 2025 2:13 PM
> To: ltaylorsimpson@gmail.com; qemu-devel@nongnu.org
> Cc: richard.henderson@linaro.org; philmd@linaro.org;
> quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; alex.bennee@linaro.org;
> quic_mburton@quicinc.com; sidneym@quicinc.com; 'Brian Cain'
> <bcain@quicinc.com>
> Subject: Re: [PATCH 02/38] docs/system: Add hexagon CPU emulation
>=20
>=20
> On 3/5/2025 1:36 PM, ltaylorsimpson@gmail.com wrote:
> >
> >> -----Original Message-----
> >> From: Brian Cain <brian.cain@oss.qualcomm.com>
> >> Sent: Friday, February 28, 2025 11:26 PM
> >> To: qemu-devel@nongnu.org
> >> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> >> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng;
> >> anjo@rev.ng; quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> >> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> >> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> >> Subject: [PATCH 02/38] docs/system: Add hexagon CPU emulation
> >>
> >> From: Brian Cain <bcain@quicinc.com>
> >>
> >> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >> ---
> >>   docs/system/hexagon/emulation.rst | 16 ++++++++++++++++
> >>   docs/system/target-hexagon.rst    |  1 +
> >>   2 files changed, 17 insertions(+)
> >>   create mode 100644 docs/system/hexagon/emulation.rst
> > Add to MAINTAINERS?
>=20
>=20
> I will fix this.
>=20
>=20
> >> diff --git a/docs/system/hexagon/emulation.rst
> >> b/docs/system/hexagon/emulation.rst
> >> new file mode 100644
> >> index 0000000000..03a6092a12
> >> --- /dev/null
> >> +++ b/docs/system/hexagon/emulation.rst
> >> @@ -0,0 +1,16 @@
> >> +.. _Hexagon Emulation:
> >> +
> >> +Hexagon CPU architecture support
> >> =
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +QEMU's TCG emulation includes support for v65, v66, v67, v68, v69,
> >> +v71,
> >> v73.
> >> +It also has support for the following architecture extensions:
> >> +
> >> +- HVX (Hexagon Vector eXtensions)
> >> +
> >> +For information on the specifics of the HVX extension, please =
refer
> >> +to the `Qualcomm Hexagon V69 HVX Programmer's Reference Manual
> >> +<https://docs.qualcomm.com/bundle/publicresource/80-N2040-
> >>
> 49_REV_AA_Qualcomm_Hexagon_V69_HVX_ProgrammerS_Reference_Ma
> >> nual.pdf>`_.
> > The target/hexagon/README file gives a link to the v73 version of =
the HVX
> PRM.  These should be consistent.
>=20
>=20
> The V79 PRM is newer -- I can update this to point to V79 and delete =
the one
> from the README, would that be acceptable?

Is v79 a typo?  I vote for pointing to the latest version that QEMU =
supports.

The README also has a link to the v73 scalar core document.

>=20
>=20
> > It would also be good to mention the README file in one of the files =
in docs
> as well as mentioning these files in the README.  Or is there a =
standard way
> the community handles this sort of thing?
>=20
>=20
> docs/system/hexagon/ is intended for public consumption by users (for
> example, at https://www.qemu.org/docs/master/ IIUC).  IMO the README
> reference (whose audience is QEMU developers) is not suitable there.
> However, I could make a reference from docs/devel/hexagon-sys.rst to =
the
> target/hexagon/README - sound good?

Agreed.  The README is for QEMU developers.

>=20
>=20
> >
> > Otherwise
> > Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> >


