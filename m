Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31460606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dsmzlxWG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUBx-0000Hj-QV; Thu, 29 Oct 2026 13:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006qB-6h
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003bD-Mv
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:36 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGD7OU535458; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ybID590J04a
 gIJfhfUOLg+YqxUeeoTG9EvHQgm28M3o=; b=dsmzlxWGT2jj2OLjP54BguorC7b
 mg/XanFxf3ey1acyds5nMt6MMPK+GQ3VQm7D6Rs64VFAdE4+v40QUqn1GQYw4K8H
 J0suWuGZAQQk+mEX2117ac8Ne7KXczw79kQR8D4KL85kmvgvNLnmVuQtVZ8/PdUY
 oT34KUvbMvEoNtMKcXzSDpLXk4mhOHZ5Wt4ZMDkrqWoqtk0TSu6hYVqkoH80U8Pi
 A4jUmBnBBbDwd3++1MNdvdhRv27dyhZX6uSeIccMRt0l8Cm8+S7PrXxqQZovHEaL
 2vK+6h1wXfnlkM3kS8itIAadtQi5GR5zEt1IoH6IlIf6coZJtbGW9VdP9TA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm8k4hbjt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEhI2488376; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 69THiDDJ2488357
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:13 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 7272F25819; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 02/20] target/hexagon: add HLX attributes and exception cause
Date: Thu, 29 Oct 2026 10:43:55 -0700
Message-ID: <20261029174413.643130-3-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXynuOH8eUUX08
 FNG+BEd8sSOA6rfSGUiKQ85eL6xU0RvEvGZSV/wOmUl7ZUwoAuuizCw5+vz8bulFDoKeanUPNub
 tz1UE7J3yWcHXWGa092k9uopSmplS96NMPtyVGZEYuxGB/isfCr4BGkVYqAzC6fry3jxNazd8O1
 F4UnPdY+INpP1o+e7QezhUKCbfwsCvBVaXoob+a9sT8WUAsobzQBF1hTP+98WzV9cvTjIk45VPr
 ydoQXNTOzT4+Oie86B/Pzw3/AzkLlnGKL7d5391+w75g8bRl3DGjCcivjE0tY+AKpCCp4iUZPa1
 YNDcRwCIeSsmwUde3shILUPi2Vb3waQtW8MQGUHM0YuStn3R+vYiWFHk+8jAoa0LzqYilgBpnl9
 dx6Cm7btRQRYrTlWD0ShnSkInNJ7jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX1aHa0moh3xdV
 ET5wbNXHk1b8jFSCKUwVIZ0iub5OHj2OJqzlBOB56eHeIXT+HkUe8zaDyFDIIE+m0kYSQq4kgCV
 5SgmEk+4cDONw8F6TXz0V2qsNi9nrmo=
X-Authority-Analysis: v=2.4 cv=LuAHWXdc c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=SQNLHeiHp6WtZxeD8egA:9
X-Proofpoint-GUID: Fuoy_s8R1HZH39XMRhdfEw8PCRma1RrL
X-Proofpoint-ORIG-GUID: Fuoy_s8R1HZH39XMRhdfEw8PCRma1RrL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add HLX instruction attributes, a packet flag, and the
NO_COPROC3_ENABLE exception cause.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/attribs_def.h.inc | 18 ++++++++++++++++++
 target/hexagon/cpu_bits.h        |  1 +
 target/hexagon/hexswi.c          |  1 +
 target/hexagon/insn.h            |  1 +
 4 files changed, 21 insertions(+)

diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
index 96ad1fd2f8..a02261ee5e 100644
--- a/target/hexagon/attribs_def.h.inc
+++ b/target/hexagon/attribs_def.h.inc
@@ -69,6 +69,24 @@ DEF_ATTRIB(RLS_SAME_THREAD, "Store release with the same thread", "", "")
 /* V6 Vector attributes */
 DEF_ATTRIB(CVI, "Executes on the HVX extension", "", "")
 
+/* HLX attributes */
+DEF_ATTRIB(HLX, "Executes on the HLX extension", "", "")
+DEF_ATTRIB(HLX_MEM, "HLX memory instruction", "", "")
+DEF_ATTRIB(HLX_MPY, "HLX multiply instruction", "", "")
+DEF_ATTRIB(HLX_SHIFT, "HLX shift instruction", "", "")
+DEF_ATTRIB(HLX_COMMON_ALU, "HLX common ALU instruction", "", "")
+DEF_ATTRIB(HLX_PAIRED_ALU, "HLX paired ALU instruction", "", "")
+DEF_ATTRIB(HLX_ANY_RESOURCE, "HLX can use any resource", "", "")
+DEF_ATTRIB(HLX_SLOT23, "HLX can execute in slot 2 or 3", "", "")
+DEF_ATTRIB(HLX_NEW, "HLX new-value instruction", "", "")
+DEF_ATTRIB(HLX_TMP, "HLX temporary register instruction", "", "")
+DEF_ATTRIB(HLX_CU_SCALAR, "HLX scalar CU instruction", "", "")
+DEF_ATTRIB(HLX_SCALAR32, "HLX 32-bit scalar operand", "", "")
+DEF_ATTRIB(HLX_SCALAR64, "HLX 64-bit scalar operand", "", "")
+DEF_ATTRIB(HLX_LXX_MPY, "HLX Lxx multiply operation", "", "")
+DEF_ATTRIB(HLX_LXX_ADD, "HLX Lxx add operation", "", "")
+DEF_ATTRIB(NOTE_HLX_MEM, "HLX memory access notes", "", "")
+
 DEF_ATTRIB(CVI_NEW, "New value memory instruction executes on HVX", "", "")
 DEF_ATTRIB(CVI_VM, "Memory instruction executes on HVX", "", "")
 DEF_ATTRIB(CVI_VP, "Permute instruction executes on HVX", "", "")
diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index c9ba09989e..65dda2175d 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -79,6 +79,7 @@ enum hex_cause {
     HEX_CAUSE_INVALID_OPCODE = 0x015, /* alias: same cause as INVALID_PACKET */
     HEX_CAUSE_NO_COPROC_ENABLE = 0x016,
     HEX_CAUSE_NO_COPROC2_ENABLE = 0x018,
+    HEX_CAUSE_NO_COPROC3_ENABLE = 0x019,
     HEX_CAUSE_PRIV_USER_NO_GINSN = 0x01a,
     HEX_CAUSE_PRIV_USER_NO_SINSN = 0x01b,
     HEX_CAUSE_VECTOR_STACK_OVERFLOW = 0x01c,
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index fb46c05360..f18ecaae42 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -923,6 +923,7 @@ void hexagon_cpu_do_interrupt(CPUState *cs)
         case HEX_CAUSE_INVALID_OPCODE:
         case HEX_CAUSE_NO_COPROC_ENABLE:
         case HEX_CAUSE_NO_COPROC2_ENABLE:
+        case HEX_CAUSE_NO_COPROC3_ENABLE:
         case HEX_CAUSE_UNSUPPORTED_HVX_64B:
         case HEX_CAUSE_VECTOR_STACK_OVERFLOW:
         case HEX_CAUSE_REG_WRITE_CONFLICT:
diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
index 5d59430da9..5751c9ced9 100644
--- a/target/hexagon/insn.h
+++ b/target/hexagon/insn.h
@@ -71,6 +71,7 @@ struct Packet {
 
     bool pkt_has_hvx;
     Insn *vhist_insn;
+    bool pkt_has_hlx;
 
     Insn insn[INSTRUCTIONS_MAX];
 };
-- 
2.43.0


