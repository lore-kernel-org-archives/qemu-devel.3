Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30ABC282DE
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 01:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqj3j-0002Qk-H7; Fri, 07 Mar 2025 20:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqj3i-0002Qc-Py
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 20:32:58 -0500
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqj3g-0007Nd-Mr
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 20:32:58 -0500
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7c3ca86e8c3so171665185a.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 17:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741397575; x=1742002375; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jK7tEy/Ej9XI2JRv3i6devjtfWbSjQQvLCrP9FGGaQI=;
 b=i/TOcOYtvbul3Ex+o/3m21kJn2aVncKbF63sgwyaKf2FDiJOyc06qp4k/1xIoQ+2j5
 YW86qOR0g1vJ5QuwZxUDE+xL+MhSuzlw2qrjFTJ3NkOVnog7Tp3mbgWuItWYLutTyLaI
 MrFN/B8HSunDnxVlMlIzfp3RegUCAQI6PyAQR1RDynwoxsevVe8AvJzz2ObLosFQOV81
 xOzmW661Ibp76YLRHppz6HoNvK0/91/xPiCSrqOlavw/B2rhINsag3+UOlWxnQrbcolR
 rQ/odIssg8LQh2lrVqvSUBtbo+KX0z4MvuDDsuAYLg5PqCiU17y/uJn50q7i3Hme50Sp
 FwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741397575; x=1742002375;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jK7tEy/Ej9XI2JRv3i6devjtfWbSjQQvLCrP9FGGaQI=;
 b=uYlN9jXgs6UO243W+cTMtbyRZKN6nRjgnrs7G5liYPHfmcb0MN62zHgDYGmq/AEAl1
 hAJFa9+39AZL/DshAxO5OT83B8NTE/2qi2+mWB5q3idxYgI6n5g+jkXZcfPyYwmRNmBU
 4g78KZfe92FlNMV7a1KLPQBQZnZieGW9rCMVtPLbxbtacnKA3OlxUnfXA8rLSkbsaat6
 dSDwNPWAIaXvnJm1I5wEzE7gTOT6qB+8YKKr8GnmVkFcc/ADkVLlDIn4ByATt+u4uVMQ
 K/8nayIuWDZFc9O/7l2IfWJwPIZUzdoesSL2oq7Zh7BUdVCeM7q6HSjHqk/+X5i4ufBt
 OEjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxDRMjb6Fs77ZHS3GDMwQvkIQvwcpKCgD1eU57Jj5GVrZALCSvsMW3p3nU9CBddCEh19S9nPdR15WS@nongnu.org
X-Gm-Message-State: AOJu0YwtlHE46zOpCVC5oP4tQr7W3D90vs1r6A1SLgkUVhBwzcMDXlKZ
 oANDyN1oEkLLlY0m75iSVYD02DayaPSqG6haCF4V0lYVnWWnNoGM
X-Gm-Gg: ASbGncv+dMjQtQQ6mA+UKEZDyrso21J3b393lV2keVug2LZdJVaCDcg6+86WoODH6I8
 rQ5Clki5IKDFoTqE4CdDFeB5E6LdwUeEwG8RiYTpNBEtBWfkeVb4wSXraWCnteMI668j6ZL6O13
 hkXyqQaOCVvajYM3pwglIWphpUfUMgF/3OI6nfU3btVRlbSp6DnrujXOFGG139QOQtAXI5SjMwX
 K0+Vmy8monQSK1BmzGq3BOwrNS5BmxKmi1YDcRGhLeNGvkC9aSMi32/xi7wzlaiQsZu1Jsl1Jwz
 96h3SBo/ZiW6pPp4zp7OPmiCO98O0BEA0XSRn7YQ6GErUfP5sO46CRllaSqIvJg=
X-Google-Smtp-Source: AGHT+IH4x6L3wbYDTWw0l270orjNpPRT3qzgTTF23Hhhy7bb4KbVMAx8596Cks9PhwhJfdg7/hmL9Q==
X-Received: by 2002:a05:620a:2855:b0:7c3:c33f:df2a with SMTP id
 af79cd13be357-7c4e617ae09mr1126997485a.36.1741397575266; 
 Fri, 07 Mar 2025 17:32:55 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:8188:4e08:c1e3:fcd4])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3e553dfd7sm317384485a.115.2025.03.07.17.32.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Mar 2025 17:32:54 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-22-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-22-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 21/38] target/hexagon: Add system reg insns
Date: Fri, 7 Mar 2025 19:32:53 -0600
Message-ID: <030601db8fca$04123730$0c36a590$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgJqRJmrtOl+aaA=
X-Antivirus: Norton (VPS 250307-8, 3/7/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x736.google.com
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
> Subject: [PATCH 21/38] target/hexagon: Add system reg insns
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/macros.h               |   2 +
>  target/hexagon/hex_common.py          |  15 +-
>  target/hexagon/imported/encode_pp.def | 213 +++++++++++++++------
>  target/hexagon/imported/system.idef   | 262
> +++++++++++++++++++++++---
>  4 files changed, 410 insertions(+), 82 deletions(-)
>=20
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h index
> 6e4a3a1697..b0e9610d98 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -675,3 +675,5 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv
> val, int shift)  #endif
>=20
>  #endif
> +
> +#define fPREDUSE_TIMING()

Why wasn't this in the previous patch with all the changes to macros.h?

> diff --git a/target/hexagon/hex_common.py
> b/target/hexagon/hex_common.py index 7fb11a0819..9147701333 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -1235,11 +1235,18 @@ def init_registers():
>      for reg in new_regs:
>          new_registers[f"{reg.regtype}{reg.regid}"] =3D reg
>=20
> +def is_new_reg(tag, regid):
> +    if regid[0] in "NO":
> +        return True
> +    return regid[0] =3D=3D "P" and \
> +           f"{regid}N" in semdict[tag] and \
> +           f"{regid}V" not in semdict[tag]
> +
>  def get_register(tag, regtype, regid):
> -    if f"{regtype}{regid}V" in semdict[tag]:
> -        return registers[f"{regtype}{regid}"]
> -    else:
> -        return new_registers[f"{regtype}{regid}"]
> +    regid =3D f"{regtype}{regid}"
> +    is_new =3D is_new_reg(tag, regid)
> +    reg =3D new_registers[regid] if is_new else registers[regid]
> +    return reg

This looks OK but is out of place in this patch.

>=20
>  def helper_ret_type(tag, regs):
>      ## If there is a scalar result, it is the return type diff --git
> a/target/hexagon/imported/encode_pp.def
> b/target/hexagon/imported/encode_pp.def
> index 0cd30a5e85..37faf62b1b 100644
> --- a/target/hexagon/imported/encode_pp.def
> +++ b/target/hexagon/imported/encode_pp.def
> @@ -1,5 +1,5 @@
>  /*
> - *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All =
Rights
> Reserved.
> + *  Copyright(c) 2019-2020 Qualcomm Innovation Center, Inc. All =
Rights
> Reserved.

Why are you changing the copyright date badkward?

>   *
>   *  This program is free software; you can redistribute it and/or =
modify
>   *  it under the terms of the GNU General Public License as published =
by @@
> -16,6 +16,7 @@
>   */
>=20
>  /*
> + * encode32.def
>   * Encodings for 32 bit instructions
>   *
>   */
> @@ -341,6 +342,8 @@ DEF_ENC32(L4_pload##TAG##tnew_abs,ICLASS_LD"
> 1 11 "OPC"  iiiii  PP110tti  1--ddd
> DEF_ENC32(L4_pload##TAG##fnew_abs,ICLASS_LD" 1 11 "OPC"  iiiii  =
PP111tti
> 1--ddddd")
>=20
>=20
> +
> +
>  /*               0 000  misc: dealloc,loadw_locked,dcfetch      */
>  STD_LD_ENC(bzw4,"0 101")
>  STD_LD_ENC(bzw2,"0 011")
> @@ -375,6 +378,7 @@ DEF_ANTICLASS32(ICLASS_LD" 1110 000----- PP------ =
--
> ------",LD_ADDR_POST_REG)
>=20
>  DEF_ENC32(L2_deallocframe,    ICLASS_LD" 000 0 000 sssss PP0----- ---
> ddddd")
>  DEF_ENC32(L4_return,          ICLASS_LD" 011 0 000 sssss PP0000-- =
---ddddd")
> +
>  DEF_ENC32(L4_return_t,        ICLASS_LD" 011 0 000 sssss PP0100vv =
---ddddd")
>  DEF_ENC32(L4_return_f,        ICLASS_LD" 011 0 000 sssss PP1100vv =
---ddddd")
>  DEF_ENC32(L4_return_tnew_pt,  ICLASS_LD" 011 0 000 sssss PP0110vv ---
> ddddd") @@ -382,15 +386,18 @@ DEF_ENC32(L4_return_fnew_pt,
> ICLASS_LD" 011 0 000 sssss PP1110vv ---ddddd")
> DEF_ENC32(L4_return_tnew_pnt, ICLASS_LD" 011 0 000 sssss PP0010vv ---
> ddddd")  DEF_ENC32(L4_return_fnew_pnt, ICLASS_LD" 011 0 000 sssss
> PP1010vv ---ddddd")
>=20
> -DEF_ENC32(L2_loadw_locked,ICLASS_LD" 001 0 000 sssss PP000---
> 000ddddd")
> -
> +/** Load Acquire Store Release Encoding **/
>=20
> +DEF_ENC32(L2_loadw_locked,    ICLASS_LD" 001 0 000 sssss PP000---
> 000ddddd")
> +DEF_ENC32(L4_loadd_locked,    ICLASS_LD" 001 0 000 sssss PP010---
> 000ddddd")

There are lots of changes here that look like formatting/whitespace.  It =
would be easier to review if you could minimize these.

> diff --git a/target/hexagon/imported/system.idef
> b/target/hexagon/imported/system.idef
> index 7c6568e75e..fd7ef18b3e 100644
> --- a/target/hexagon/imported/system.idef
> +++ b/target/hexagon/imported/system.idef
> @@ -25,44 +25,262 @@
>  /* User->OS interface                       */
>  /********************************************/
>=20
> -Q6INSN(J2_trap0,"trap0(#u8)",ATTRIBS(A_COF),
> +Q6INSN(J2_trap0,"trap0(#u8)",ATTRIBS(A_COF,A_NOTE_NOPACKET,A_RES
> TRICT_N
> +OPACKET),
>  "Trap to Operating System",
> -    fTRAP(0,uiV);
> +	fTRAP(0,uiV);

The formatting/whitespace changes are not as rampant in this file, but =
this is one example.

>  )


