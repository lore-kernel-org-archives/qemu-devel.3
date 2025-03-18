Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E86C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueKT-00060w-92; Tue, 18 Mar 2025 17:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1tueKR-00060P-8N
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:18:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1tueKP-00047g-8U
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:18:26 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ICeBgT029895;
 Tue, 18 Mar 2025 21:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RGBiRA12lqCHiwgjV7qPWEMXjl7XkiEmUew4c5T2mmQ=; b=G+TS2eT02rMOaugG
 iMRYQo3vJURQl8phNRBjaCwIqyK6DBl56THCpvmkB7H35bB4fNi3YmteaG0nulHK
 89SWp41CFMBqD1rX1rGwIUrQg2AxFflA4q2m64p55mNCH9YJ5fEUWNxl6DFLzfNL
 DXnbOP4+zRaoPSeJEZePS1+CTF198IbIq6yoIzmGikNMYIj6rLMSe8zit3jPUs2y
 Bi8Ua1srlL7y+Vd6oExzv60AufqAiI5PUKVQOwFWW2Lz18HFajX9RkAe1Yd3OVQk
 c4dTGcYcfGvfkmjZrgvd9irrrI4FpNqnHPAU/+tG1cq+IUM9onZIqovC7bon+6Ri
 Hrl3Cg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f91t1c8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 21:18:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52ILIL1w001224
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 21:18:21 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Mar 2025 14:18:21 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <quic_mathbern@quicinc.com>
CC: <qemu-devel@nongnu.org>, <ovoshcha@redhat.com>, <farosas@suse.de>,
 <philmd@redhat.com>, <thuth@redhat.com>, <bcain@quicinc.com>,
 <quic_mliebel@quicinc.com>
Subject: test_migration.py not working with netcat-traditional
Date: Tue, 18 Mar 2025 14:17:58 -0700
Message-ID: <20250318211758.814275-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <85909195b99964081ae01d9999384cc3b7a3fada.1742331648.git.quic_mathbern@quicinc.com>
References: <85909195b99964081ae01d9999384cc3b7a3fada.1742331648.git.quic_mathbern@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: spGOM-b06iqeRTC-TFQqOzEBs_P5tdYu
X-Authority-Analysis: v=2.4 cv=Xrz6OUF9 c=1 sm=1 tr=0 ts=67d9e31e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=_HV7dUTn6gDNUvmDq2YA:9
 a=x22-d2SVbb4A:10 a=QYH75iMubAgA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: spGOM-b06iqeRTC-TFQqOzEBs_P5tdYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=554 clxscore=1011 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180154
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

On Tue, 18 Mar 2025 14:13:03 -0700 Matheus Tavares Bernardino <quic_mathbern@quicinc.com> wrote:
>
> [...]
> 
> Thanks,
> Matheus

Sorry for the original title, I had some placeholder thrash in my buffer and that
ended up going as the subject :facepalm:

