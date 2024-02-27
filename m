Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8648FC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reyKv-00021L-GM; Tue, 27 Feb 2024 09:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1reyKt-0001xQ-Iu
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:21:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1reyKs-0005bY-1C
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:21:35 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41R9YAnN002460; Tue, 27 Feb 2024 14:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=Um9MWb8tj23ulYfcb6IUWDdzjNC7jMHHneRbMKXn8Ug=; b=aD
 00suka3n6x001JB/v5xBZ2dhNxetKYN0UzhlNDsGObm3a6LYQEYp8ca3IT1Ee4vT
 7ABeIZhtcUpttMcSUyD969+0mr1iFfkiAIBrv8rccoTl2Duig1wXumkrawaX/i+Q
 N/oYJ4R/xhblquJVBYpEP6P1luz7/Jhns+nyey7mVuLr4l1jBVLWGk5LgwMbsEss
 mF8EJGgOBsHZv2InVbyzZx/scFtI2WBh4oVAd2sd3580NWhTqQXrJNoPNxhpbjBq
 k2u7RHhnNVOxNCJmOmc8SR+pEFk9s07VQ6upuQMoCcpdJ1Gfs6vuzNyWHW/s5dfD
 0RXhOQqOalP7VFIoeHNQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh64qhk9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 14:21:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RELP34009665
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 14:21:25 GMT
Received: from mathbern-mac.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 06:21:23 -0800
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: Taylor Simpson <ltaylorsimpson@gmail.com>
CC: <qemu-devel@nongnu.org>, <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, 
 <sidneym@quicinc.com>, <quic_mliebel@quicinc.com>,
 <richard.henderson@linaro.org>, <philmd@linaro.org>, <ale@rev.ng>,
 <anjo@rev.ng>
Subject: Re: [PATCH 4/9] Hexagon (target/hexagon) Mark has_pred_dest in trans
 functions
Date: Tue, 27 Feb 2024 11:21:12 -0300
Message-ID: <20240227142112.56005-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240226201722.391879-5-ltaylorsimpson@gmail.com>
References: <20240226201722.391879-5-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: URMrOmQJtDjhWqYEcjE_FVk2Ru7ofVkd
X-Proofpoint-GUID: URMrOmQJtDjhWqYEcjE_FVk2Ru7ofVkd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=631 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
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

On Mon, 26 Feb 2024 13:17:17 -0700 Taylor Simpson <ltaylorsimpson@gmail.com> wrote:
>
> diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
> index 07292e0170..f1972fd2dd 100755
> --- a/target/hexagon/gen_trans_funcs.py
> +++ b/target/hexagon/gen_trans_funcs.py
> @@ -86,6 +86,7 @@ def gen_trans_funcs(f):
>  
>          new_read_idx = -1
>          dest_idx = -1
> +        has_pred_dest = "false"
>          for regno, regstruct in enumerate(regs):
>              reg_type, reg_id, _, _ = regstruct
>              reg = hex_common.get_register(tag, reg_type, reg_id)
> @@ -96,6 +97,8 @@ def gen_trans_funcs(f):
>                  new_read_idx = regno
>              if reg.is_written() and dest_idx == -1:
>                  dest_idx = regno
> +            if reg_type == "P" and not reg.is_read():
> +                has_pred_dest = "true"

I got a bit confused here. Why do we use "not reg.is_read()"? I though this
would be "reg.is_written()".

