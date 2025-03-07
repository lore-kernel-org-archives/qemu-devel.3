Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15311C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcwr-0001jL-Ax; Fri, 07 Mar 2025 14:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqcwl-0001eB-B4
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:01:27 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqcwj-0002De-I4
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:01:23 -0500
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7c08f9d0ef3so137857885a.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741374078; x=1741978878; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=w/R1O3YLdqGlmMACJzMlbMzhf4Z4Gk2YTjjraP7JN1E=;
 b=gif43WjJGHhOAiXDxda1YlGHaZbiDquziFGhMCQrA7IqeZTmbg5rZzNhEOwT2EIZDa
 PsWvs3KAKVv1I+IJATq1CrQL/aIMucaGyMgRl0FTYMGw1w5Th0UM9nqXX9AbdA1SZEgV
 ejjhvuFKCyeKKM090Tc3WqvPmRhb/60KqQKS1ImKpAkddXOmFH2nO4DbHlkQ3UvqGZ51
 iZJc4do4yLPCGJm19v0uSFxaeLItkk466uPplgfhgV7H61lo9qlXHIrtwZ+oKZOrd5nA
 eHfK1mH79V/+EEGaAWyCYFKI4FDtyxr1tKUpbae8r1FQYVd0Nbxuze9EKJ5tkTktR7ZX
 vi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374078; x=1741978878;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w/R1O3YLdqGlmMACJzMlbMzhf4Z4Gk2YTjjraP7JN1E=;
 b=hEdPuY32yjKPmccKdAlxy4cy0/x8zHcImdunfBzScvj/yUcZql5CCKVJROqr4JRMIw
 7mX08b8qaxtEiac6pmXa6GvGxIr08GcfetFQVwRM1/48Wi6s16PQIN/zhW+DP4pwWhaG
 E0+0LgMxQBRT6+3VeIBN5GsMXm1Fpgz9SJdVtQbBF128CTc79waoYUpQWxWTqk7Df41n
 Xvxt90J5B60pc15yD7p1P9dvW+ff6FHbYQJf+JiRKhha/IPjn38IhySBTSdf3kXLBX8P
 FDJ7K5MwTNG6Gw65BAyOtZGg0MDw3vU+29C0PMfLFWjhab4S1130BV5J2YbEFTg6H/x0
 Ua/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgZFJ6g0u+qdlLnTO91G+mZX4ZbLUBwqmt6MS4Xm9m/PJBYef3rLDrRRL3OKZ/BBjwgJWxcQZKeVN8@nongnu.org
X-Gm-Message-State: AOJu0Yys2mxcFtD/Z7SJK+5oiz1VmFBMrjyu5eRYp3wRlvGFSm+BpuKa
 p0WgPUdWbD27PvytV6zpUaPL0ae2BkOPv/XBpZZoE/DdmDqaj5YU
X-Gm-Gg: ASbGnct0rQAMUH/SbVp5kqmXx/rLZYQ9YkbYxLeXlx5zrRkX9j0lL7afR2Fk9unSZOy
 Ql13hCYTnc1K1/+4pWJYmoHUvTPbGhcu9YdyFn61NEbqQet1TE2WtiA3vnbEGS2UwfBuiNOzpak
 UURWNduXcpNc4w5R7fV37gjiTL0jBE5uhKMv3GwZmtGknPGjCA8wrDuPeKhPWRZ6pKrKth+G6hm
 c9i1gG4TbBK1xmgoC69qtzrw/3i+L/aXzGp+mpGPL4am7usDZNdLsTSR+WVu7i7jykuH98y52mR
 bOaZHWi1GUfBZ6FRfoQg374i96V4kH2v+DukCmsfB6c0Kj/6G9r6YEj6us3fAG0=
X-Google-Smtp-Source: AGHT+IFGCu/Ukzp0uyAILW+H/9Nd6iJYQ2FAaaSVBg0IPi3DpO/QdghnG+mdgbs6l1x2oIO/ckeOew==
X-Received: by 2002:a05:620a:6289:b0:7c3:d778:6c0 with SMTP id
 af79cd13be357-7c4e617abacmr670159085a.43.1741374078515; 
 Fri, 07 Mar 2025 11:01:18 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:f449:4838:1970:9d05])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f7090ea6sm22506456d6.37.2025.03.07.11.01.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:01:17 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-13-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-13-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 12/38] target/hexagon: Add imported macro,
 attr defs for sysemu
Date: Fri, 7 Mar 2025 13:01:16 -0600
Message-ID: <028c01db8f93$4ebc2840$ec3478c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgFLLUsNtPH992A=
X-Antivirus: Norton (VPS 250307-6, 3/7/2025), Outbound message
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
> Subject: [PATCH 12/38] target/hexagon: Add imported macro, attr defs =
for
> sysemu
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/attribs_def.h.inc   | 414 +++++++++++++++++++--
>  target/hexagon/imported/macros.def | 558
> +++++++++++++++++++++++++++++
>  2 files changed, 942 insertions(+), 30 deletions(-)  mode change =
100755 =3D>
> 100644 target/hexagon/imported/macros.def
>=20
> diff --git a/target/hexagon/attribs_def.h.inc
> b/target/hexagon/attribs_def.h.inc
> index 9e3a05f882..e6523a739b 100644
> --- a/target/hexagon/attribs_def.h.inc
> +++ b/target/hexagon/attribs_def.h.inc
> @@ -19,20 +19,41 @@
>  DEF_ATTRIB(AA_DUMMY, "Dummy Zeroth Attribute", "", "")
>=20
>  /* Misc */
> +DEF_ATTRIB(FAKEINSN, "Not a real instruction", "", "")
> +DEF_ATTRIB(MAPPING, "Not real -- asm mapped", "", "")
> +DEF_ATTRIB(CONDMAPPING, "Not real -- mapped based on values", "", "")
>  DEF_ATTRIB(EXTENSION, "Extension instruction", "", "")
> +DEF_ATTRIB(SHARED_EXTENSION, "Shared extension instruction", "", "")
> +DEF_ATTRIB(CABAC,
> +           "Cabac Instruction. Used in conjuction with =
QDSP6_CABAC_PRESENT",
> "",
> +           "")
> +DEF_ATTRIB(EXPERIMENTAL, "This may not work correctly not supported =
by
> RTL.",
> +           "", "")

Personally, I don't think we should be adding all of these.  Few are =
needed, and we run the risk of having attributes that aren=E2=80=99t =
used in QEMU and therefore aren=E2=80=99t properly implemented in QEMU.  =
Somewhere down the road, an instruction or macro could show up in the =
imported directory with such an attribute, and it will cause unnecessary =
headaches.  Examples above are CONDMAPPING and EXPERIMENTAL.  These =
should be included in hex_common.tag_ignore.

Better to wait until an instruction in a future version of Hexagon shows =
up that uses an attribute.  These will be few, so it will be simpler to =
examine each new attribute to ensure it is properly implemented in QEMU.

>=20
>  /* access to implicit registers */
>  DEF_ATTRIB(IMPLICIT_WRITES_LR, "Writes the link register", "", =
"UREG.LR")
> +DEF_ATTRIB(IMPLICIT_READS_LR, "Reads the link register", "UREG.LR", =
"")
> +DEF_ATTRIB(IMPLICIT_READS_LC0, "Reads loop count for loop 0",
> +"UREG.LC0", "") DEF_ATTRIB(IMPLICIT_READS_LC1, "Reads loop count for
> +loop 1", "UREG.LC1", "") DEF_ATTRIB(IMPLICIT_READS_SA0, "Reads start
> +address for loop 0", "UREG.SA0", "") DEF_ATTRIB(IMPLICIT_READS_SA1,
> +"Reads start address for loop 1", "UREG.SA1", "")
> +DEF_ATTRIB(IMPLICIT_WRITES_PC, "Writes the program counter", "",
> +"UREG.PC") DEF_ATTRIB(IMPLICIT_READS_PC, "Reads the program
> counter",
> +"UREG.PC", "")
>  DEF_ATTRIB(IMPLICIT_WRITES_SP, "Writes the stack pointer", "",
> "UREG.SP")
> +DEF_ATTRIB(IMPLICIT_READS_SP, "Reads the stack pointer", "UREG.SP",
> "")
>  DEF_ATTRIB(IMPLICIT_WRITES_FP, "Writes the frame pointer", "",
> "UREG.FP")
> +DEF_ATTRIB(IMPLICIT_READS_FP, "Reads the frame pointer", "UREG.FP",
> "")
> +DEF_ATTRIB(IMPLICIT_WRITES_GP, "Writes the GP register", "",
> "UREG.GP")
> +DEF_ATTRIB(IMPLICIT_READS_GP, "Reads the GP register", "UREG.GP", "")
>  DEF_ATTRIB(IMPLICIT_WRITES_LC0, "Writes loop count for loop 0", "",
> "UREG.LC0")  DEF_ATTRIB(IMPLICIT_WRITES_LC1, "Writes loop count for
> loop 1", "", "UREG.LC1")  DEF_ATTRIB(IMPLICIT_WRITES_SA0, "Writes =
start
> addr for loop 0", "", "UREG.SA0")  DEF_ATTRIB(IMPLICIT_WRITES_SA1,
> "Writes start addr for loop 1", "", "UREG.SA1")
> +DEF_ATTRIB(IMPLICIT_WRITES_R00, "Writes Register 0", "", "UREG.R00")

The IMPLICIT_READS_* and IMPLICIT_WRITES_* are examples that would need =
to be handled properly if ever used.  Look at IMPLICIT_*_P0 to see how =
they are used in translate.c::analyze_packet.  Imagine a day in the =
future when an instruction gets imported with IMPLICIT_WRITES_R00 =
attribute.  When that instruction is in a packet with an instruction =
that reads R0, analyze_packet will not know there is a conflict and =
decide it's OK to short-circuit the packet semantics.  That bug would go =
unnoticed for a long time and only show up when a large program runs =
incorrectly on QEMU.

Thanks,
Taylor



