Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1944C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ9eS-00059I-VQ; Mon, 17 Jun 2024 06:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1sJ9eR-00058t-0R
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:31:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1sJ9eP-0001PB-3F
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:31:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H6OiVd029887;
 Mon, 17 Jun 2024 10:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pe4Oq7lbpeR5s7HIl1ykiprcC/N6O412k7karKSwY4A=; b=RB5hqMDb3e5Dc09r
 1Tk7uchF3i3dB2rUyyHHqJlE1y68rXdxv5TBlqeZ22a903dV8Vn9O5c0Vc4xTWhT
 IapUkuFStkzuapgBVzdtZLZ3SOpHsYleN43ou1dJMswS7EFxpt7Oq9VDxH0QjkMn
 kQId1p49OrtVdGX0+DolT1m8Upues50UtqkWIHtzLeX4br1XCwmbFOex9nV2fw0g
 QwSJKxcQSpOB1c9JSSN18XGAhkA9o74mHHMY7AljJVs5nISpdQS4eBDzRlVYocKl
 kzzAof3vNMYwQzKkGJZIq8rYzHqGP+XVeWouARwxboE+qDI9yslcwipXb1cZ6aRq
 tuu+mA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytfut0fg3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:31:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 45HAVglv009548
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:31:42 GMT
Received: from mathbern-mac.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Jun 2024 03:31:38 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <ltaylorsimpson@gmail.com>
CC: <qemu-devel@nongnu.org>, <bcain@quicinc.com>, <tedwood@quicinc.com>,
 <alex.benee@linaro.org>, <quic_mathbern@quicinc.com>,
 <sidneym@quicinc.com>, <quic_mliebel@quicinc.com>,
 <richard.henderson@linaro.org>, <philmd@linaro.org>, <ale@rev.ng>,
 <anjo@rev.ng>
Subject: Re: [PATCH v2] Hexagon: lldb read/write predicate registers
 p0/p1/p2/p3
Date: Mon, 17 Jun 2024 07:30:49 -0300
Message-ID: <20240617103118.92387-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613182209.140082-1-ltaylorsimpson@gmail.com>
References: <20240613182209.140082-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: HbBGGWWNKaVXjqVDANZg-kIyCD2zQlTG
X-Proofpoint-GUID: HbBGGWWNKaVXjqVDANZg-kIyCD2zQlTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=856
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406170081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0a-0031df01.pphosted.com
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

On Thu, 13 Jun 2024 12:22:09 -0600 Taylor Simpson <ltaylorsimpson@gmail.com> wrote:
>
> hexagon-core.xml only exposes register p3_0 which is an alias that
> aggregates the predicate registers.  It is more convenient for users
> to interact directly with the predicate registers.
> 
> Tested with lldb downloaded from this location
> https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.4/clang+llvm-18.1.4-x86_64-linux-gnu-ubuntu-18.04.tar.xz
> 
> BEFORE:
> (lldb) reg read p3_0
>     p3_0 = 0x00000000
> (lldb) reg read p0
> error: Invalid register name 'p0'.
> (lldb) reg write p1 0xf
> error: Register not found for 'p1'.
> 
> AFTER:
> (lldb) reg read p3_0
>     p3_0 = 0x00000000
> (lldb) reg read p0
>       p0 = 0x00
> (lldb) reg read -s 1
> Predicate Registers:
>         p0 = 0x00
>         p1 = 0x00
>         p2 = 0x00
>         p3 = 0x00
> 
> (lldb) reg write p1 0xf
> (lldb) reg read p3_0
>     p3_0 = 0x00000f00
> (lldb) reg write p3_0 0xff00ff00
> (lldb) reg read -s 1
> Predicate Registers:
>         p0 = 0x00
>         p1 = 0xff
>         p2 = 0x00
>         p3 = 0xff
> 
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>

Reviewed-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

