Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5DBC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 14:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2XaT-0003r7-K8; Thu, 02 May 2024 10:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1s2XaP-0003qP-9y
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:39:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1s2XaJ-000483-Bd
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:39:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 442DGmPB022047;
 Thu, 2 May 2024 14:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=E8o15yCWWcgbLk/lxdIWGDyyT239rl7gS0h7n1hyfJI=; b=Fu
 Qhu2ncxfBMWJqtrrvXQ5/Aj/FAIEnBjHkc5v4lLKLNL60UTVO2KW8/AW0uuchBWp
 vM0tS26yJElXWeKbyF4wEMnkPpVflJAIjJ2tFv5FkbneTA2YmGpkAdveVxmu8W9H
 3hKw+fgY+ZQg+x21LHz2l0wGdzKAG6mqyggANyRP3k+VVQJGPCLlH7RZEutQFUgS
 7zgGlVa6015W0pEkE/DlW/xY7MAJloapU/p8aZlkFsyOUYz/K2H1TvSleLz+Egev
 /IrwHwrj8irxItrUEGRtC5zNzLBXCIvIddOpIgtxbVNvIxzg2Qg2gUU+S1ag32D1
 oc2LMUeq0oryV0e3xg/A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xup5ktnb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 May 2024 14:38:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442EclaQ025338
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 2 May 2024 14:38:47 GMT
Received: from mathbern-mac.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 May 2024 07:38:44 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <richard.henderson@linaro.org>
CC: <quic_mathbern@quicinc.com>, <qemu-devel@nongnu.org>, <bcain@quicinc.com>, 
 <sidneym@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <ltaylorsimpson@gmail.com>, <laurent@vivier.eu>
Subject: Re: [PATCH v3] Hexagon: add PC alignment check and exception
Date: Thu, 2 May 2024 11:35:09 -0300
Message-ID: <20240502143831.51821-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <29135846-744f-471b-9e21-ec5a6309bacc@linaro.org>
References: <29135846-744f-471b-9e21-ec5a6309bacc@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: VuKw_QZwytLwx4lmYnwGIJmXETfn-dec
X-Proofpoint-GUID: VuKw_QZwytLwx4lmYnwGIJmXETfn-dec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_05,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 mlxlogscore=777 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 30 Apr 2024 08:52:36 -0700 Richard Henderson <richard.henderson@linaro.org> wrote:
>
> On 4/30/24 07:25, Matheus Tavares Bernardino wrote:
> > +void test_multi_cof(void)
> > +{
> > +    asm volatile(
> > +        "p0 = cmp.eq(r0, r0)\n"
> > +        "{\n"
> > +        "    if (p0) jump test_multi_cof_unaligned\n"
> > +        "    jump 1f\n"
> > +        "}\n"
> > +        "1: nop\n"
> > +        : : : "p0");
> > +}
> 
> I will say you could just add the label to the end of the asm here, like
> 
> 	.byte 0
> test_multi_cof_unaligned:
> 
> rather than use a separate source file.
>

That would be nice, but unfortunately that doesn't work because the label gets
aligned by the assembler :( 

diff --git a/tests/tcg/hexagon/unaligned_pc.c b/tests/tcg/hexagon/unaligned_pc.c
index 1add2d0d99..3772947a86 100644
--- a/tests/tcg/hexagon/unaligned_pc.c
+++ b/tests/tcg/hexagon/unaligned_pc.c
@@ -33,10 +33,12 @@ void test_multi_cof(void)
     asm volatile(
         "p0 = cmp.eq(r0, r0)\n"
         "{\n"
-        "    if (p0) jump test_multi_cof_unaligned\n"
+        "    if (p0) jump 2f\n"
         "    jump 1f\n"
         "}\n"
         "1: nop\n"
+        ".byte 0\n"
+        "2: nop\n"
         : : : "p0");
 }

Ends up producing:

00020dc0 <test_multi_cof>:
   20dc0:       00 c0 9d a0     a09dc000 {      allocframe(#0x0) }
   20dc4:       00 c0 00 f2     f200c000 {      p0 = cmp.eq(r0,r0) }
   20dc8:       06 40 00 5c     5c004006 {      if (p0) jump:nt 0x20dd4 <test_multi_cof+0x14>
   20dcc:       04 c0 00 58     5800c004        jump 0x20dd0 <test_multi_cof+0x10> }
   20dd0:       00 c0 00 7f     7f00c000 {      nop }
   20dd4:       00 00 c0 00 <unknown>

