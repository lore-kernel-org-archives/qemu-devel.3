Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5864C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 19:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsS2Q-0001w7-8k; Wed, 12 Mar 2025 15:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1tsS2O-0001vP-BK
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:46:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1tsS2M-0006T4-Gi
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:46:44 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C9OvhQ028516;
 Wed, 12 Mar 2025 19:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ieZEjs4TP+8dzMxcfldmLF3j4Qm/5VIJ2XfsAZGwAXo=; b=Eg1LOWdsb7YRdnRG
 e5QlDBPXEp7Ds4m3VYhK87iTC7mu2DewdCz2CqXFgUidDTvM7l5EmNcgXvxRtwmZ
 CLwlSdO9+QObXbbCfq07p5clTy5n5B3ZMHFdFakTxsP61u1GmjwZUAXz2/jBMC1B
 msRorZdT5ywLMwVwnzvlyT+MNl55yqWRoFUc9SJj/Gf/Dc5ioKOWw6MzoCGJkJkH
 HE5zH+tViFw85kJLZZ9FmCuj8zVXF5KXnijfZVOrpn5n+WILr0xCAceSP2ynQGyS
 7SPTJXPkkEWfFdmE2UkrfHI/P/jFDQ25+vDh7nCjxlFIAi9vG8SMrUGFsYaevPEW
 0nJfzA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2pug3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 19:46:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52CJkcqe021094
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 19:46:38 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Mar 2025 12:46:37 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <sidneym@quicinc.com>
CC: "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>,
 <brian.cain@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, <quic_mathbern@quicinc.com>,
 "ale@rev.ng" <ale@rev.ng>, "anjo@rev.ng" <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, <quic_mburton@quicinc.com>, <bcain@quicinc.com>
Subject: RE: [PATCH 33/38] target/hexagon: Add gdb support for sys regs
Date: Wed, 12 Mar 2025 12:46:28 -0700
Message-ID: <20250312194628.4032213-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <DS0PR02MB948229C8C6268809898EFA5FBED02@DS0PR02MB9482.namprd02.prod.outlook.com>
References: <DS0PR02MB948229C8C6268809898EFA5FBED02@DS0PR02MB9482.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=P506hjAu c=1 sm=1 tr=0 ts=67d1e49e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=cH8kOsUFl_ylhAIbSvoA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0MhxPueKCigzrDhy66DjKJn9o0_hCsJ_
X-Proofpoint-ORIG-GUID: 0MhxPueKCigzrDhy66DjKJn9o0_hCsJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=554 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120139
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

On Wed, 12 Mar 2025 19:27:14 +0000 Sid Manning <sidneym@quicinc.com> wrote:
>
> > From: Sid Manning <sidneym@quicinc.com>
> > > From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
> > > > From: Brian Cain <bcain@quicinc.com>
> > > >
> > > > +uint32_t hexagon_sreg_read(CPUHexagonState *env, uint32_t reg) {
> > > > +    return sreg_read(env, reg);
> > > > +}
> > > > +
> > >
> > > Why not just use sreg_read?
> > [Sid Manning]
> > The usage of this is in gdbstub.c and I don't think the extra layer is needed so
> > it can be removed and the stub updated.
> [Sid Manning] 
> OK there is a reason this is like this, sreg_read is declared statically above and is not available to the debug stub.

Yeah, and it is also annotated with QEMU_ALWAYS_INLINE. But I think we could
simplify the code by renaming sreg_read to hexagon_sreg_read and making it
non-static/non-inlined.

