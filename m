Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF5BC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 18:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHSkD-0001xT-Vy; Wed, 12 Jun 2024 14:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1sHSk2-0001wE-R3
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:30:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1sHSk0-0003r8-1V
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:30:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CFNOB8016703;
 Wed, 12 Jun 2024 18:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 si6An54rgbK6FfapjfzVC7p9aZAyjkE1B5AFy4lJ26U=; b=OPBhL06p10GGS0pU
 25ghULXQXbySUG7NHxmgBTWub/nUpje992XIR46CJ7SbYM6xPtY7XYX4D7lDybNs
 e4LSHHRed60NldSaOHWDylVG3/6DeroSifSyQDtHIJdp4ryciD6t0kH1fJLL3lG1
 S+aX+NdcedQ519FRvTl7GF6t8Z9fc0OrvE22p6E8yGdRHUgn7QM2uesVp/aDd592
 QwgORmhKdfbalhikaFs5okl1UqjvCvZyNjXV9okaPLbazv5Ba5mKJuYmjXyy7SIo
 7tvz0sJo8E9ON/stRnedSHtVs94OMwXYHyShJhokIcfQk6JvYIEWbqj3Lkzb6Rr5
 3oRAXQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqe93ghpe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jun 2024 18:30:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 45CIUIKu018238
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jun 2024 18:30:18 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Jun 2024 11:30:17 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <ltaylorsimpson@gmail.com>
CC: <qemu-devel@nongnu.org>, <bcain@quicinc.com>, <tedwood@quicinc.com>,
 <alex.bennee@linaro.org>, <quic_mathbern@quicinc.com>,
 <sidneym@quicinc.com>, <quic_mliebel@quicinc.com>,
 <richard.henderson@linaro.org>, <philmd@linaro.org>, <ale@rev.ng>,
 <anjo@rev.ng>
Subject: Re: [PATCH] Hexagon: lldb read/write predicate registers p0/p1/p2/p3
Date: Wed, 12 Jun 2024 15:30:08 -0300
Message-ID: <20240612183008.4123155-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240612164239.90276-1-ltaylorsimpson@gmail.com>
References: <20240612164239.90276-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 4mrqWsE030Kug36HDjV5ge4nUShLJc_s
X-Proofpoint-ORIG-GUID: 4mrqWsE030Kug36HDjV5ge4nUShLJc_s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_10,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxlogscore=425
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120132
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 12 Jun 2024 10:42:39 -0600 Taylor Simpson <ltaylorsimpson@gmail.com> wrote:
>
> diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
> index 502c6987f0..e67e627fc9 100644
> --- a/target/hexagon/gdbstub.c
> +++ b/target/hexagon/gdbstub.c
> @@ -56,6 +64,15 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>          return sizeof(target_ulong);
>      }
>  
> +    n -= TOTAL_PER_THREAD_REGS;
> +
> +    if (n < NUM_PREGS) {
> +        env->pred[n] = ldtul_p(mem_buf);
> +        return sizeof(uint8_t);

I wonder, shouldn't this be sizeof(target_ulong) since we wrote a target_ulong?

> +    }
> +
> +    n -= NUM_PREGS;
> +
>      g_assert_not_reached();
>  }

