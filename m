Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F582606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=phZ2Gm+/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUCL-0000VX-1l; Thu, 29 Oct 2026 13:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006q7-4v
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003bh-Mi
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:34 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TH6vFB3808588; Thu, 29 Oct 2026 17:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fKDHrtJ+KDR
 614JgwqMNeCvIxtXo+6GpgyXnx8crrRk=; b=phZ2Gm+/lAjEEPEBeuTdK6s3OQS
 Rtiu9uJYTBXVLkJDWaVxIZWuYCQUttdizvr2N3YAKcOSWu1dY/pIJdEEcn7wMRPu
 PWrAskhf5gNnrvGLBAaZr+HZGMHOEoUavkxdvo0NvHeHH6rG0SinOEU5CpW0dvjQ
 8WglfnzgZv/5yF6b9YcAtbo0sf0Z+UWMQHkZ9t+luna4A7+ZaYkqJElUTTVUOiAa
 ykbV0xi6EJHV3rEg1VWpDGydS8iT2GmeTRt9Q1wZfpbieiCWya2fx9pCN3d4wbYU
 giHhEJ2BFYLlbNFi51gS37aD/DvnBMS90RBEAsCPIk2I+Js1va0oLxaMAvQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5sbh0y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:16 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiF3G2488412; Thu, 29 Oct 2026 17:44:15 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 69THiEwS2488386
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id B2FF025849; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
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
Subject: [PATCH 15/20] target/hexagon: add HLX paired ALU instructions
Date: Thu, 29 Oct 2026 10:44:08 -0700
Message-ID: <20261029174413.643130-16-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX8pZY7DA2RVlT
 bwaUxs5+1MGuGVjWZh87EFbzMOhfzI/eJzbBKihSk54beLbujqs3FC9pFJxVdyukegAxCil9H2q
 tYPUtTvPCA4xqLRkM3Zdrz2Pbrmfw/w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX7MH5eYpaavWT
 U2kxVXYwyRGxoI5DfgGNaZBsLwE/1P3NAfOJmEPacNfW8pjO6MMgFMKsUIyvym5X6/PNEeUES2W
 CI1meOKBUVyBRYPBwH7zZjF8gq5fwkogpAca/1EOJKclZA60qugiio3f9auv34lFE1hV1wfn1uS
 3sQv7FVXv7tZkXa0rSpuG16uk0IBe+aqm5IEHj1yLJGLFQEEaZNozb9pRrwiXz+44G0A9A9zYXn
 jvxXrtI0ruHyAWfabX6b8K5/KsHzvKbReJOL2MtQ8L3PxCLw9RqVH258IYSUUHiZMJ0cq0VD4k8
 9ZcmZ3nKUBEOVeP6UitI6bFs58Tg8+EwKKsEQvpbXL0cXP8moOTNXPLFFifzvemuoEY/Hr3myoc
 pSkdCvo7Gr9CaPVrart69TVMy0eUDA==
X-Proofpoint-ORIG-GUID: NVbFlsxZadtgwA8i2wwj1crmrnAvhHVl
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae385f0 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=is3lO79Pf3r2u9qVQnMA:9
X-Proofpoint-GUID: NVbFlsxZadtgwA8i2wwj1crmrnAvhHVl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Define HLX pair arithmetic, compare, logical, and combine instructions.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/imported/hlx/encode_ext.def |  40 +++++++
 target/hexagon/imported/hlx_ext.idef       | 117 +++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/target/hexagon/imported/hlx/encode_ext.def b/target/hexagon/imported/hlx/encode_ext.def
index cb6d1b03d8..5a11f58d79 100644
--- a/target/hexagon/imported/hlx/encode_ext.def
+++ b/target/hexagon/imported/hlx/encode_ext.def
@@ -51,6 +51,46 @@ DEF_ENC(LX_sub_wuh,"11100101001vvvv-PP1010uuuu0dddd1")
 DEF_ENC(LX_assign_u,"11100101001iiiiiPP1010----1dddd0")
 DEF_ENC(LX_assign_s,"11100101001iiiiiPP1010----1dddd1")
 
+DEF_ENC(LX_add_w,"11101111000vvvv-PP1000uuuu0dddd0")
+DEF_ENC(LX_add_w_sat,"11101111000vvvv-PP1000uuuu0dddd1")
+DEF_ENC(LX_add_uw_sat,"11101111000vvvv-PP1000uuuu1dddd0")
+DEF_ENC(LX_add_uw_w_sat,"11101111000vvvv-PP1000uuuu1dddd1")
+DEF_ENC(LX_sub_w,"11101111000vvvv-PP1001uuuu0dddd0")
+DEF_ENC(LX_sub_w_sat,"11101111000vvvv-PP1001uuuu0dddd1")
+DEF_ENC(LX_sub_uw_sat,"11101111000vvvv-PP1001uuuu1dddd0")
+DEF_ENC(LX_sub_uw_w_sat,"11101111000vvvv-PP1001uuuu1dddd1")
+DEF_ENC(LX_add_hp,"11101111000vvvv-PP1010uuuu0dddd0")
+DEF_ENC(LX_add_hp_sat,"11101111000vvvv-PP1010uuuu0dddd1")
+DEF_ENC(LX_add_uhp_sat,"11101111000vvvv-PP1010uuuu1dddd0")
+DEF_ENC(LX_add_uhp_h_sat,"11101111000vvvv-PP1010uuuu1dddd1")
+DEF_ENC(LX_sub_hp,"11101111000vvvv-PP1011uuuu0dddd0")
+DEF_ENC(LX_sub_hp_sat,"11101111000vvvv-PP1011uuuu0dddd1")
+DEF_ENC(LX_sub_uhp_sat,"11101111000vvvv-PP1011uuuu1dddd0")
+DEF_ENC(LX_sub_uhp_h_sat,"11101111000vvvv-PP1011uuuu1dddd1")
+DEF_ENC(LX_abs_uw,"11101111000-----PP1100uuuu0dddd0")
+DEF_ENC(LX_abs_uw_sat,"11101111000-----PP1100uuuu0dddd1")
+DEF_ENC(LX_abs_uhp,"11101111000-----PP1100uuuu1dddd0")
+DEF_ENC(LX_abs_uhp_sat,"11101111000-----PP1100uuuu1dddd1")
+DEF_ENC(LX_cmp_gt_uw,"11101111000vvvv-PP1101uuuu0dddd0")
+DEF_ENC(LX_cmp_gt_w,"11101111000vvvv-PP1101uuuu0dddd1")
+DEF_ENC(LX_cmp_gt_hp,"11101111000vvvv-PP1101uuuu1dddd0")
+DEF_ENC(LX_cmp_gt_uhp,"11101111000vvvv-PP1101uuuu1dddd1")
+DEF_ENC(LX_min_hp,"11101111000vvvv-PP1110uuuu0dddd0")
+DEF_ENC(LX_min_uhp,"11101111000vvvv-PP1110uuuu0dddd1")
+DEF_ENC(LX_max_hp,"11101111000vvvv-PP1110uuuu1dddd0")
+DEF_ENC(LX_max_uhp,"11101111000vvvv-PP1110uuuu1dddd1")
+DEF_ENC(LX_min_w,"11101111000vvvv-PP1111uuuu0dddd0")
+DEF_ENC(LX_min_uw,"11101111000vvvv-PP1111uuuu0dddd1")
+DEF_ENC(LX_max_w,"11101111000vvvv-PP1111uuuu1dddd0")
+DEF_ENC(LX_max_uw,"11101111000vvvv-PP1111uuuu1dddd1")
+DEF_ENC(LX_and_w,"11101111001vvvv-PP1000uuuu0dddd0")
+DEF_ENC(LX_or_w,"11101111001vvvv-PP1000uuuu0dddd1")
+DEF_ENC(LX_xor_w,"11101111001vvvv-PP1000uuuu1dddd0")
+DEF_ENC(LX_combine_w,"11101111001vvvv-PP1000uuuu1dddd1")
+DEF_ENC(LX_andn_w,"11101111001vvvv-PP1001uuuu0dddd0")
+DEF_ENC(LX_not_w,"11101111001-----PP1001uuuu0dddd1")
+DEF_ENC(LX_orn_w,"11101111001vvvv-PP1001uuuu1dddd0")
+
 #undef DEF_ENC
 #undef EXTEXTNAME
 #undef CONCAT
diff --git a/target/hexagon/imported/hlx_ext.idef b/target/hexagon/imported/hlx_ext.idef
index 4cee4ce816..47e1171473 100644
--- a/target/hexagon/imported/hlx_ext.idef
+++ b/target/hexagon/imported/hlx_ext.idef
@@ -85,18 +85,90 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fZXTN(16,32,LuV.uh[i]); })
 EXTINSN(LX_conv_w_h,"Ldd16.w=sxt(Lu16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Convert halfword to word",
 fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fSXTN(16,32,LuV.h[i]); })
 
+EXTINSN(LX_add_w,"Ldd16.w=add(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector add word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w + LvvV.l[i].w; })
+
+EXTINSN(LX_add_w_sat,"Ldd16.w=add(Luu16.w,Lvv16.w):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector add & saturate word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVSADDSAT(32, LuuV.l[i].w, LvvV.l[i].w); })
+
+EXTINSN(LX_add_uw_sat,"Ldd16.uw=add(Luu16.uw,Lvv16.uw):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector add & saturate unsigned word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fVUADDSAT(32, LuuV.l[i].uw, LvvV.l[i].uw); })
+
+EXTINSN(LX_add_uw_w_sat,"Ldd16.uw=add(Luu16.w,Lvv16.w):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector add & saturate unsigned word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fVUSADDSAT(32, LuuV.l[i].w, LvvV.l[i].w); })
+
+EXTINSN(LX_sub_w,"Ldd16.w=sub(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector sub word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w - LvvV.l[i].w; })
+
+EXTINSN(LX_sub_w_sat,"Ldd16.w=sub(Luu16.w,Lvv16.w):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector sub & saturate word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVSSUBSAT(32, LuuV.l[i].w, LvvV.l[i].w); })
+
+EXTINSN(LX_sub_uw_sat,"Ldd16.uw=sub(Luu16.uw,Lvv16.uw):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector sub & saturate unsigned word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fVUSUBSAT(32, LuuV.l[i].uw, LvvV.l[i].uw); })
+
+EXTINSN(LX_sub_uw_w_sat,"Ldd16.uw=sub(Luu16.w,Lvv16.w):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector sub & saturate unsigned word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fVUSSUBSAT(32, LuuV.l[i].w, LvvV.l[i].w); })
+
+EXTINSN(LX_add_hp,"Ldd16.h=add(Luu16.h,Lvv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register add paired halfword",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = LuuV.l[i].h[0] + LvvV.l[i].h[0]; LddV.l[i].h[1] = LuuV.l[i].h[1] + LvvV.l[i].h[1] ; })
+
+EXTINSN(LX_add_hp_sat,"Ldd16.h=add(Luu16.h,Lvv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register add & saturate paired halfword",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = fVSADDSAT(16, LuuV.l[i].h[0], LvvV.l[i].h[0]); LddV.l[i].h[1] = fVSADDSAT(16, LuuV.l[i].h[1], LvvV.l[i].h[1]) ; })
+
+EXTINSN(LX_add_uhp_sat,"Ldd16.uh=add(Luu16.uh,Lvv16.uh):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register add & saturate unsigned paired halfword",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = fVUADDSAT(16, LuuV.l[i].uh[0], LvvV.l[i].uh[0]); LddV.l[i].uh[1] = fVUADDSAT(16, LuuV.l[i].uh[1], LvvV.l[i].uh[1]) ; })
+
+EXTINSN(LX_add_uhp_h_sat,"Ldd16.uh=add(Luu16.h,Lvv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register add & saturate unsigned paired halfword",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = fVUSADDSAT(16, LuuV.l[i].h[0], LvvV.l[i].h[0]); LddV.l[i].uh[1] = fVUSADDSAT(16, LuuV.l[i].h[1], LvvV.l[i].h[1]) ; })
+
+EXTINSN(LX_sub_hp,"Ldd16.h=sub(Luu16.h,Lvv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register sub paired halfword",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = LuuV.l[i].h[0] - LvvV.l[i].h[0]; LddV.l[i].h[1] = LuuV.l[i].h[1] - LvvV.l[i].h[1] ; })
+
+EXTINSN(LX_sub_hp_sat,"Ldd16.h=sub(Luu16.h,Lvv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register sub & saturate paired halfword",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = fVSSUBSAT(16, LuuV.l[i].h[0], LvvV.l[i].h[0]); LddV.l[i].h[1] = fVSSUBSAT(16, LuuV.l[i].h[1], LvvV.l[i].h[1]) ; })
+
+EXTINSN(LX_sub_uhp_sat,"Ldd16.uh=sub(Luu16.uh,Lvv16.uh):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register sub & saturate unsigned paired halfword",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = fVUSUBSAT(16, LuuV.l[i].uh[0], LvvV.l[i].uh[0]); LddV.l[i].uh[1] = fVUSUBSAT(16, LuuV.l[i].uh[1], LvvV.l[i].uh[1]) ; })
+
+EXTINSN(LX_sub_uhp_h_sat,"Ldd16.uh=sub(Luu16.h,Lvv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register sub & saturate unsigned paired halfword",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = fVUSSUBSAT(16, LuuV.l[i].h[0], LvvV.l[i].h[0]); LddV.l[i].uh[1] = fVUSSUBSAT(16, LuuV.l[i].h[1], LvvV.l[i].h[1]) ; })
+
 EXTINSN(LX_abs_uh,"Ld16.uh=abs(Lu16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Absolute value of large vector of half word",
 fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fABSW(LuV.h[i]); })
 
 EXTINSN(LX_abs_uh_sat,"Ld16.h=abs(Lu16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Absolute value & saturate of large vector of half word",
 fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVSATH(fABSW(LuV.h[i])); })
 
+EXTINSN(LX_abs_uw,"Ldd16.uw=abs(Luu16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Absolute value of large vector of word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fABSW(LuuV.l[i].w); })
+
+EXTINSN(LX_abs_uw_sat,"Ldd16.w=abs(Luu16.w):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Absolute value & saturate of large vector of word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVSATW(fABSW(LuuV.l[i].w)); })
+
+EXTINSN(LX_abs_uhp,"Ldd16.uh=abs(Luu16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Absolute value of L register pair halfword",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = fABSW(LuuV.l[i].h[0]); LddV.l[i].uh[1] = fABSW(LuuV.l[i].h[1]) ; })
+
+EXTINSN(LX_abs_uhp_sat,"Ldd16.h=abs(Luu16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Absolute value & saturate of large vector of word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = fVSATH(fABSW(LuuV.l[i].h[0])); LddV.l[i].h[1] = fVSATH(fABSW(LuuV.l[i].h[1])) ; })
+
 EXTINSN(LX_cmp_gt_uh,"Ld16.h=cmp.gt(Lu16.uh, Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Unsigned compare greater than",
 fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.uh[i] > LvV.uh[i]) ? 0xFFFF : 0x0; })
 
 EXTINSN(LX_cmp_gt_h,"Ld16.h=cmp.gt(Lu16.h, Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Signed compare greater than",
 fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.h[i] > LvV.h[i]) ? 0xFFFF : 0x0; })
 
+EXTINSN(LX_cmp_gt_w,"Ldd16.w=cmp.gt(Luu16.w, Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector signed word compare greater than",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = (LuuV.l[i].w > LvvV.l[i].w) ? 0xFFFFFFFF : 0x0; })
+
+EXTINSN(LX_cmp_gt_uw,"Ldd16.w=cmp.gt(Luu16.uw, Lvv16.uw)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Word element compare greater than",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = (LuuV.l[i].uw > LvvV.l[i].uw) ? 0xFFFFFFFF : 0x0; })
+
+EXTINSN(LX_cmp_gt_hp,"Ldd16.h=cmp.gt(Luu16.h, Lvv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector signed word compare greater than",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = (LuuV.l[i].h[0] > LvvV.l[i].h[0]) ? 0xFFFF : 0x0; LddV.l[i].h[1] = (LuuV.l[i].h[1] > LvvV.l[i].h[1]) ? 0xFFFF : 0x0 ; })
+
+EXTINSN(LX_cmp_gt_uhp,"Ldd16.h=cmp.gt(Luu16.uh, Lvv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Word element compare greater than",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = (LuuV.l[i].uh[0] > LvvV.l[i].uh[0]) ? 0xFFFF : 0x0; LddV.l[i].h[1] = (LuuV.l[i].uh[1] > LvvV.l[i].uh[1]) ? 0xFFFF : 0x0 ; })
+
 EXTINSN(LX_max_uh,"Ld16.uh=max(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector max ",
 fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = (LuV.uh[i] > LvV.uh[i]) ? LuV.uh[i] : LvV.uh[i]; })
 
@@ -109,6 +181,30 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.h[i] > LvV.h[i]) ? LuV.h[i]
 EXTINSN(LX_min_h,"Ld16.h=min(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector max ",
 fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.h[i] < LvV.h[i]) ? LuV.h[i] : LvV.h[i]; })
 
+EXTINSN(LX_min_w,"Ldd16.w=min(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector min word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = (LuuV.l[i].w < LvvV.l[i].w) ? LuuV.l[i].w : LvvV.l[i].w; })
+
+EXTINSN(LX_min_uw,"Ldd16.uw=min(Luu16.uw,Lvv16.uw)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector min unsigned word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = (LuuV.l[i].uw < LvvV.l[i].uw) ? LuuV.l[i].uw : LvvV.l[i].uw; })
+
+EXTINSN(LX_max_w,"Ldd16.w=max(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector max word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = (LuuV.l[i].w > LvvV.l[i].w) ? LuuV.l[i].w : LvvV.l[i].w; })
+
+EXTINSN(LX_max_uw,"Ldd16.uw=max(Luu16.uw,Lvv16.uw)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector max unsigned word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = (LuuV.l[i].uw > LvvV.l[i].uw) ? LuuV.l[i].uw : LvvV.l[i].uw; })
+
+EXTINSN(LX_min_hp,"Ldd16.h=min(Luu16.h,Lvv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector min word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = (LuuV.l[i].h[0] < LvvV.l[i].h[0]) ? LuuV.l[i].h[0] : LvvV.l[i].h[0]; LddV.l[i].h[1] = (LuuV.l[i].h[1] < LvvV.l[i].h[1]) ? LuuV.l[i].h[1] : LvvV.l[i].h[1]; ; })
+
+EXTINSN(LX_min_uhp,"Ldd16.uh=min(Luu16.uh,Lvv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector min unsigned word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = (LuuV.l[i].uh[0] < LvvV.l[i].uh[0]) ? LuuV.l[i].uh[0] : LvvV.l[i].uh[0]; LddV.l[i].uh[1] = (LuuV.l[i].uh[1] < LvvV.l[i].uh[1]) ? LuuV.l[i].uh[1] : LvvV.l[i].uh[1]; ; })
+
+EXTINSN(LX_max_hp,"Ldd16.h=max(Luu16.h,Lvv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector max word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = (LuuV.l[i].h[0] > LvvV.l[i].h[0]) ? LuuV.l[i].h[0] : LvvV.l[i].h[0]; LddV.l[i].h[1] = (LuuV.l[i].h[1] > LvvV.l[i].h[1]) ? LuuV.l[i].h[1] : LvvV.l[i].h[1]; ; })
+
+EXTINSN(LX_max_uhp,"Ldd16.uh=max(Luu16.uh,Lvv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector max unsigned word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = (LuuV.l[i].uh[0] > LvvV.l[i].uh[0]) ? LuuV.l[i].uh[0] : LvvV.l[i].uh[0]; LddV.l[i].uh[1] = (LuuV.l[i].uh[1] > LvvV.l[i].uh[1]) ? LuuV.l[i].uh[1] : LvvV.l[i].uh[1]; ; })
+
 EXTINSN(LX_and,"Ld16=and(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical And",
 fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] & LvV.uh[i]; })
 
@@ -127,12 +223,33 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] & ~LvV.uh[i]; })
 EXTINSN(LX_orn,"Ld16=orn(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical not OR",
 fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] | ~LvV.uh[i]; })
 
+EXTINSN(LX_and_w,"Ldd16=and(Luu16,Lvv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector logical AND word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w & LvvV.l[i].w; })
+
+EXTINSN(LX_or_w,"Ldd16=or(Luu16,Lvv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector logical OR word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w | LvvV.l[i].w; })
+
+EXTINSN(LX_xor_w,"Ldd16=xor(Luu16,Lvv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector logical XOR word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w ^ LvvV.l[i].w; })
+
+EXTINSN(LX_andn_w,"Ldd16=andn(Luu16,Lvv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector logical AND NOT word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w & ~LvvV.l[i].w; })
+
+EXTINSN(LX_orn_w,"Ldd16=orn(Luu16,Lvv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector logical OR NOT word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w | ~LvvV.l[i].w; })
+
+EXTINSN(LX_not_w,"Ldd16=not(Luu16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Assign an Lreg",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw=~LuuV.l[i].uw; })
+
 EXTINSN(LX_assign,"Ld16.h=Lu16.h",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Assign an Lreg",
 fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=LuV.uh[i]; })
 
 EXTINSN(LX_assign_w,"Ldd16.w=Luu16.w",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Assign a double Lreg",
 fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w=LuuV.l[i].w; })
 
+EXTINSN(LX_combine_w,"Ldd16=combine(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Combine two lregs",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[1] = LuV.h[i]; LddV.l[i].h[0] = LvV.h[i];; })
+
 EXTINSN(LX_assign_r,"Ld16.h=Rt32.h",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Assign half a scalar register to L register",
 fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fGETHALF(0,RtV); })
 
-- 
2.43.0


