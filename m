Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C78BC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reyJs-0000qa-LQ; Tue, 27 Feb 2024 09:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1reyJj-0000pU-UL
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:20:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1reyJi-0005Q1-D2
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:20:23 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41R9ZEWK022683; Tue, 27 Feb 2024 14:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=BiZnyed/QJnTK25V8bQEk8X37NgvJZ2sI1hnUVw29vA=; b=ay
 RaN96f/Me914pQFxKN0OzYiJI/5fUegAoaFu7+l+YLmV8A59GtzJlQqX/jn4Fyja
 NR81iZnwvnKGcKsoK6DZYK/zurZbm7r5yofjTyqndk7lt9ChgJvi0v1I8aAqa6ZO
 ntcHY6611D/NjIMbTsZQrCu/cMExOvIR6NeyG7cEcVx+aG1fWsy/Blmu+EUikbXE
 4ElAgl3LgTjdlILQ/vYEzUK+yTV5byIlDz3iVa/6tmcCrE2nSXwtlxGgZ41pAzOk
 E3lwIwXhp2isXsuxxpc3VE5P+YUNl67ErDOz86pa04+QnWotmfqyCzBvTovqHMOl
 mPTT4LbbL/Yj/3U8H7bA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh5079p3a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 14:20:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41REKH9J028081
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 14:20:17 GMT
Received: from mathbern-mac.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 06:20:13 -0800
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>
CC: <qemu-devel@nongnu.org>, <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, 
 <sidneym@quicinc.com>, <quic_mliebel@quicinc.com>,
 <richard.henderson@linaro.org>, <philmd@linaro.org>, <ale@rev.ng>,
 <anjo@rev.ng>
Subject: Re: [PATCH 2/9] Hexagon (target/hexagon) Mark new_read_idx in trans
 functions
Date: Tue, 27 Feb 2024 11:19:38 -0300
Message-ID: <20240227141938.63106-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240226201722.391879-3-ltaylorsimpson@gmail.com>
References: <20240226201722.391879-3-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: XX5cCR6mM8pkqOPfO9tTh7uoVcbVQg2Y
X-Proofpoint-GUID: XX5cCR6mM8pkqOPfO9tTh7uoVcbVQg2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=523 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270110
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 26 Feb 2024 13:17:15 -0700 Taylor Simpson <ltaylorsimpson@gmail.com> wrote:
>
> diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
> index 53e844a44b..79475b2946 100755
> --- a/target/hexagon/gen_trans_funcs.py
> +++ b/target/hexagon/gen_trans_funcs.py
> @@ -84,14 +84,15 @@ def gen_trans_funcs(f):
>                  insn->opcode = {tag};
>          """))
>  
> -        regno = 0
> -        for reg in regs:
> -            reg_type = reg[0]
> -            reg_id = reg[1]
> +        new_read_idx = -1
> +        for regno, regstruct in enumerate(regs):
> +            reg_type, reg_id, _, _ = regstruct
> +            reg = hex_common.get_register(tag, reg_type, reg_id)

Nit: since we don't care about the remaining elements of regstruct, we
could simplify (and future-proof) this even further to:

    reg_type, reg_id, *_ = regstruct

Or perhaps even eliminate the variable entirely:

    for regno, (reg_type, reg_id, *_) in enumerate(regs):
        ...

>              f.write(code_fmt(f"""\
>                  insn->regno[{regno}] = args->{reg_type}{reg_id};
>              """))
> -            regno += 1
> +            if reg.is_read() and reg.is_new():
> +                new_read_idx = regno
>  
>          if len(imms) != 0:
>              mark_which_imm_extended(f, tag)

