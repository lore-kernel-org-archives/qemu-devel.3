Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DA5C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 19:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpuXO-0002sg-I8; Wed, 05 Mar 2025 14:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tpuXI-0002sE-I2
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 14:36:08 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tpuXG-0007qH-KO
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 14:36:08 -0500
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7c3c4ff7d31so393813685a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 11:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741203365; x=1741808165; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ruh8SPCuaW4VBOJ9AghCuy3ig6sXE8zMcTJOGnbfxnc=;
 b=VHKnsDkmPiod+6rjtqqAHIMNiQnxMSVuFSsp9kQUQfG80Xf/O0mAeH5HQ1psrjK1IF
 hTDqAFqbp4kTD+Mg8tgp1jL21cRboFZZ5TEhFxhrQNc50xpHHLEVb7HH42VMP6XyVAC0
 MN4le0Ml8X/LKGxy49yucafQU6Oh0mTrdDep0vSYEH8hRRocpy926lrkqKdeUeWcChnE
 hZC/5ygn/TEtWQ/zp0eVBV5TgtfI3WY0WH2BvhVCkVCg3nSdnJYZJV5tfZfr15MzNCY1
 TgP8vZk/Pi1iGf54mXixmq6YyjHVP7W0epyIsS/RHFZSIOhL7jSnphNyrgkpO7cvztDY
 f7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741203365; x=1741808165;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ruh8SPCuaW4VBOJ9AghCuy3ig6sXE8zMcTJOGnbfxnc=;
 b=TeBi/mqZyUrRUfsv4MWlKEHcXU47rXLBj1OtREXYJjorNhlpySIRyNkSzTOkZUnfIW
 79huPLTDITV2Ls+0P5/xNhbd3jNGNBsF7wM3zFK5HBgVaKwfO/a+sfNYdIvkoXqxwsxN
 Qik7zwRH45hh4v56atI+/Ygg6hi+jRQ9EJ25DJ4C11dOJupowYY99KQuX57OYRu9Pi6Q
 o0uyyCo+Kye2qVd9Usz09lykeSP5GEss1r9u+xc9wmYaD109/hdHaltTvtXLWSIe8R3t
 nwR6z0VOzYBL0eYE/OUSWGNMR1Atm7d9HvPbU0yTjoymXF/I2SxOS9+uqDojJbgGdNLF
 g4xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp7CNGSZWzu7vrF4tRLFFecxQV9u1jyQ5A8JLTexYsnmhKVm9zB98c+RLqHPO7+YTmUcCUQqoMzlvM@nongnu.org
X-Gm-Message-State: AOJu0YwZ3zxOFKe8nyTtvxfDEp7dEVvUrgKSPa0w0ENP+HHEJo13oyzg
 vP+h/snFg2RHKAxwnogR8qm318/BF/kWsUMKBvDuaeBGRkzLkNRe
X-Gm-Gg: ASbGncvBE9/Cg3vwPiEy1HI1DxxRExEbyzYy0ZYpFbQCHlYHVOkLNCSpxBtqwaFhxoo
 uy44beThyF1molIofhD+5f8hbxg0JW2/mU86xf1lM2mpoTR58bYFF+pNvuwkEzWrICDEMtBvDK6
 I+cLMCjfZ00jJo6WhQaTyyMvFXoyYlBmKbVRhjM72Hv2cAwMw7pX0naMpIvEhaj9kaCfZMf13Tn
 tDA2GbBEozfoHc8T985FY44SfTONSLmGo0TutT3DZcJLW8DvVvvmiDICC2rr87ACr0hHl+Qets6
 Rm3+2IPH0RVUgkKlJn+dfBsphPrfjsHAA4fSVPae4nLtP6sgA0R89Yxha1dLVBzomE4wg8v0MTb
 ECOGnvH0=
X-Google-Smtp-Source: AGHT+IGMOE1f74lX0nkDSyomGG1bCGB3WAIaCpJwNFkkx/FyZCQWU/XWBcr6yyfjki6iP25vGmpoSA==
X-Received: by 2002:a05:620a:27d5:b0:7c0:a70e:b936 with SMTP id
 af79cd13be357-7c3d8e25b1dmr728301685a.8.1741203365504; 
 Wed, 05 Mar 2025 11:36:05 -0800 (PST)
Received: from DESKTOPUU50BPD (syn-174-097-131-055.res.spectrum.com.
 [174.97.131.55]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-474e0f1e0c1sm49555311cf.47.2025.03.05.11.36.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Mar 2025 11:36:05 -0800 (PST)
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
In-Reply-To: <20250301052628.1011210-3-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 02/38] docs/system: Add hexagon CPU emulation
Date: Wed, 5 Mar 2025 13:36:02 -0600
Message-ID: <01aa01db8e05$d5abd330$81037990$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgD3FrldtPGRyZA=
X-Antivirus: Norton (VPS 250305-8, 3/5/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x735.google.com
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
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 02/38] docs/system: Add hexagon CPU emulation
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/system/hexagon/emulation.rst | 16 ++++++++++++++++
>  docs/system/target-hexagon.rst    |  1 +
>  2 files changed, 17 insertions(+)
>  create mode 100644 docs/system/hexagon/emulation.rst

Add to MAINTAINERS?

>=20
> diff --git a/docs/system/hexagon/emulation.rst
> b/docs/system/hexagon/emulation.rst
> new file mode 100644
> index 0000000000..03a6092a12
> --- /dev/null
> +++ b/docs/system/hexagon/emulation.rst
> @@ -0,0 +1,16 @@
> +.. _Hexagon Emulation:
> +
> +Hexagon CPU architecture support
> =
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +QEMU's TCG emulation includes support for v65, v66, v67, v68, v69, =
v71,
> v73.
> +It also has support for the following architecture extensions:
> +
> +- HVX (Hexagon Vector eXtensions)
> +
> +For information on the specifics of the HVX extension, please refer =
to
> +the `Qualcomm Hexagon V69 HVX Programmer's Reference Manual
> +<https://docs.qualcomm.com/bundle/publicresource/80-N2040-
> 49_REV_AA_Qualcomm_Hexagon_V69_HVX_ProgrammerS_Reference_Ma
> nual.pdf>`_.

The target/hexagon/README file gives a link to the v73 version of the =
HVX PRM.  These should be consistent.

It would also be good to mention the README file in one of the files in =
docs as well as mentioning these files in the README.  Or is there a =
standard way the community handles this sort of thing?


Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


