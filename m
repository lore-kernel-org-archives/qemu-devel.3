Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BA2C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 17:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPdS-0008Ck-83; Wed, 12 Mar 2025 13:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1tsPdP-00084R-Qy
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:12:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1tsPdN-0001Y8-TS
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:12:47 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CARSlA008403;
 Wed, 12 Mar 2025 17:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jv1mjv4G1Ic9z63g11w32qjCJtkdOwSVbIsg6DdfY2s=; b=g2WVmTk3yvmem8yL
 QaUqihW/zMyTYqVkmJ8KYMZv0rHcELWXUli5aO9sZWl8IMI7RBuBcur8FuX6R9cl
 h+Mfb2sojX0FW1NBb+A8mcXnL+rctCzQDD0suDEWUeLnDryU2fwMzJm137GLzvrP
 cN9M8lkMoJwAxES5ngRugjHPYIlGxi1MDCCnReQTWMU7WjFrY5BBtel2nWq7Qrfo
 4MswRFHf7JrHmxeTv9QIybrxyc8kbfGBIA5to2AFcZIoCDZ9JQOe4aUZ0tljDkXH
 +4PlyHPhkHbMcDnC6HE+zzR/A3XhMDDvzeKKAlaVVvN8NpcziUthm0G+ohsKFlpV
 oUat+A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2qk4k2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 17:12:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52CHCe7Q007914
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 17:12:40 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Mar 2025 10:12:40 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <ltaylorsimpson@gmail.com>
CC: <brian.cain@oss.qualcomm.com>, <qemu-devel@nongnu.org>,
 <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>, <bcain@quicinc.com>,
 <mlambert@quicinc.com>
Subject: RE: [PATCH 34/38] target/hexagon: Add initial MMU model
Date: Wed, 12 Mar 2025 10:12:28 -0700
Message-ID: <20250312171228.3955620-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <011101db9370_ddebf410_99c3dc30_@gmail.com>
References: <011101db9370_ddebf410_99c3dc30_@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: QPTZ4PwsXX6zszOZBmz6g4GBy_n_FEJM
X-Authority-Analysis: v=2.4 cv=G5ccE8k5 c=1 sm=1 tr=0 ts=67d1c089 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=5RBRw4vXKsXq8PKbjmwA:9
X-Proofpoint-GUID: QPTZ4PwsXX6zszOZBmz6g4GBy_n_FEJM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=390 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120118
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 12 Mar 2025 12:04:49 -0500 <ltaylorsimpson@gmail.com> wrote:
>
> > -----Original Message-----
> > From: Brian Cain <brian.cain@oss.qualcomm.com>
> >
> > +void hex_mmu_realize(CPUHexagonState *env) {
> > +    CPUState *cs = env_cpu(env);
> > +    if (cs->cpu_index == 0) {
> > +        env->hex_tlb = g_malloc0(sizeof(CPUHexagonTLBContext));
> > +    } else {
> > +        CPUState *cpu0_s = NULL;
> > +        CPUHexagonState *env0 = NULL;
> > +        CPU_FOREACH(cpu0_s) {
> > +            assert(cpu0_s->cpu_index == 0);
> > +            env0 = &(HEXAGON_CPU(cpu0_s)->env);
> > +            break;
> > +        }
> 
> Seems fragile to assume cpu_index == 0 will be first in CPU_FOREACH.  This would be better
>     CPU_FOREACH(cpu0_s) {
>         if (cpu0_s->cpu_index == 0) {
>             env0 = &(HEXAGON_CPU(cpu0_s)->env);
>             break;
>         }
>     }
>     g_assert(env0);  /* Make sure we found it */

Or even:

    cpu0_s = qemu_get_cpu(0);
    g_assert(cpu0_s);
    env0 = &(HEXAGON_CPU(cpu0_s)->env);

