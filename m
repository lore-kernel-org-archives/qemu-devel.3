Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43882606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FDoAkZrK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUDt-0002i6-Bn; Thu, 29 Oct 2026 13:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUBO-000755-9S
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB8-0003c5-G4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:46 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDX7u3234252; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6isjkrVTAkW
 bwjdn4zgP8WUHmR5LWW2dtMMew4acsTU=; b=FDoAkZrKBTeW+/Q6wSny+fN1zHt
 gzECaDAkiLG+jGC+DPHjk+kzov7kSBFy1W1tbTmPO24bp7D3jfAbm+hPkXkbDDIz
 kWm62yVlcEp5cORihAAYtldmZb3FEukr+s3If5dZqzrcA1I0KG9QAkkAl/iwBokG
 Kw8zXj0+5/HNonYUCHBtaXWvGjDifT2q3YNtZrymAZFVSW65JNs1InQWU1XvTJC6
 M9skkbM9uRCj+pgC9UQC0rCi8sKoATUG7yAPFGplA2A2mnwdKDFINMgtflkQ7Oxe
 X0hb9XPcyDsOkGf4enp6u+abahwuXK1qSgtPZXsvM397tJXpmdAO+07QdTQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b28ct-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEKk2516236; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69THiEVI2516200
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id AE15C25848; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
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
Subject: [PATCH 14/20] target/hexagon: add HLX common ALU instructions
Date: Thu, 29 Oct 2026 10:44:07 -0700
Message-ID: <20261029174413.643130-15-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX2ySC583yskH4
 WjfVF45uTrqJmKpqDAPRy9UjnN+MGdEQyDrgkGaFuDIZcLHT8x1q1lvJwHzFoc04zTQcpMvXiGU
 s+M+rwHGMYm5dSpQEOoXBPNLBsL2ma0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX3KHznhI49j+5
 xqEmpK5ng+3uP6n0EnN3pKOaV2cGxPu/efnwgAH2R+4zgggJtrghYPe/FAgTad8aIl3bJNFrcBO
 PqDUsa9wP78tzUWUkg0c0TN4+gst65QL84xesoRW6RcIglIxHreiE0jZjB5fE5C/a1yzc9duW7z
 wFn+r1MlgwH47tlYh71Y6+Gh9NaB65nKQmYz1p17zH2g+Ys/0MnhsnuAbkWpwy1MrWSGCQ72mLa
 4QJz6i9UrJu9R0rKiIw+9F1isG7kjWdCAjBuw6ch9Oeu3C+vyRlIBB2JPcXfkt8CNLaDdGikfw5
 jgBlL8cGagNUnwMybIC6m4ugszOHNUZXxYU5MMfQVfRhkXagCoB+nXT0aUW4onoFLiH+8W6nsea
 3v/l3/fQo8GzmCNVrsiZDT1RCBR/aHhcjGD4NtWz6FUWsVysoRPsD6ruNoVbI6PxZ3xrLn/3huB
 9ToQobMT1lP6pWqkStQ==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=pNewoNV9I5d_eDowl80A:9
X-Proofpoint-GUID: QmpnA021s9LWW8vPWlz7gMiDNr3-a90Z
X-Proofpoint-ORIG-GUID: QmpnA021s9LWW8vPWlz7gMiDNr3-a90Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Define single-register HLX arithmetic, compare, logical, conversion, and
assignment instructions.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/imported/hlx/encode_ext.def |  38 ++++++
 target/hexagon/imported/hlx_ext.idef       | 132 +++++++++++++++++++++
 target/hexagon/mmvec/macros.h              |   5 +
 3 files changed, 175 insertions(+)

diff --git a/target/hexagon/imported/hlx/encode_ext.def b/target/hexagon/imported/hlx/encode_ext.def
index 10d13db376..cb6d1b03d8 100644
--- a/target/hexagon/imported/hlx/encode_ext.def
+++ b/target/hexagon/imported/hlx/encode_ext.def
@@ -13,6 +13,44 @@ DEF_ENC(LX_L16b_p_tmp,"1001100----sssssPP-10vv--100dddd")
 DEF_ENC(LX_S16b_new,"1010-1001--sssssPP000----000uuuu")
 DEF_ENC(LX_S16b_p_new,"1010-1001--sssssPP000vv--100uuuu")
 
+DEF_ENC(LX_mux_h,"11100101000vvvv-PP1000uuuu0xxxx0")
+DEF_ENC(LX_cmp_gt_h,"11100101000vvvv-PP1000uuuu0dddd1")
+DEF_ENC(LX_cmp_gt_uh,"11100101000vvvv-PP1000uuuu1dddd0")
+DEF_ENC(LX_max_h,"11100101000vvvv-PP1001uuuu0dddd0")
+DEF_ENC(LX_min_h,"11100101000vvvv-PP1001uuuu0dddd1")
+DEF_ENC(LX_max_uh,"11100101000vvvv-PP1001uuuu1dddd0")
+DEF_ENC(LX_min_uh,"11100101000vvvv-PP1001uuuu1dddd1")
+DEF_ENC(LX_conv_uw_uh,"11100101000--001PP1010uuuu0dddd0")
+DEF_ENC(LX_conv_w_h,"11100101000--001PP1010uuuu0dddd1")
+DEF_ENC(LX_abs_uh,"11100101000--001PP1010uuuu1dddd0")
+DEF_ENC(LX_abs_uh_sat,"11100101000--001PP1010uuuu1dddd1")
+DEF_ENC(LX_add_h,"11100101000vvvv-PP1011uuuu0dddd0")
+DEF_ENC(LX_add_h_sat,"11100101000vvvv-PP1011uuuu0dddd1")
+DEF_ENC(LX_add_uh_sat,"11100101000vvvv-PP1011uuuu1dddd0")
+DEF_ENC(LX_add_uhh_sat,"11100101000vvvv-PP1011uuuu1dddd1")
+DEF_ENC(LX_sub_h,"11100101000vvvv-PP1100uuuu0dddd0")
+DEF_ENC(LX_sub_h_sat,"11100101000vvvv-PP1100uuuu0dddd1")
+DEF_ENC(LX_and,"11100101000vvvv-PP1101uuuu0dddd0")
+DEF_ENC(LX_andn,"11100101000vvvv-PP1101uuuu0dddd1")
+DEF_ENC(LX_not,"11100101000-----PP1101uuuu1dddd0")
+DEF_ENC(LX_xor,"11100101000vvvv-PP1101uuuu1dddd1")
+DEF_ENC(LX_or,"11100101000vvvv-PP1110uuuu0dddd0")
+DEF_ENC(LX_orn,"11100101000vvvv-PP1110uuuu0dddd1")
+DEF_ENC(LX_assign,"11100101000-----PP1110uuuu1dddd0")
+DEF_ENC(LX_assign_w,"11100101000-----PP1110uuuu1dddd1")
+DEF_ENC(LX_sub_uh_sat,"11100101000vvvv-PP1111uuuu0dddd0")
+DEF_ENC(LX_sub_uhh_sat,"11100101000vvvv-PP1111uuuu0dddd1")
+DEF_ENC(LX_add_wwh,"11100101000vvvv-PP1111uuuu1dddd0")
+DEF_ENC(LX_add_wwuh,"11100101000vvvv-PP1111uuuu1dddd1")
+DEF_ENC(LX_sub_wwuh,"11100101001vvvv-PP1000uuuu0dddd1")
+DEF_ENC(LX_sub_wwh,"11100101001vvvv-PP1000uuuu0dddd0")
+DEF_ENC(LX_assign_r,"11100101001tttttPP1001----1dddd0")
+DEF_ENC(LX_assign_rw,"11100101001tttttPP1001----1dddd1")
+DEF_ENC(LX_add_wuh,"11100101001vvvv-PP1010uuuu0dddd0")
+DEF_ENC(LX_sub_wuh,"11100101001vvvv-PP1010uuuu0dddd1")
+DEF_ENC(LX_assign_u,"11100101001iiiiiPP1010----1dddd0")
+DEF_ENC(LX_assign_s,"11100101001iiiiiPP1010----1dddd1")
+
 #undef DEF_ENC
 #undef EXTEXTNAME
 #undef CONCAT
diff --git a/target/hexagon/imported/hlx_ext.idef b/target/hexagon/imported/hlx_ext.idef
index 3685596e5e..4cee4ce816 100644
--- a/target/hexagon/imported/hlx_ext.idef
+++ b/target/hexagon/imported/hlx_ext.idef
@@ -19,6 +19,12 @@
     } \
 }
 
+Q6INSN(LX_mux_h_alt,"if(Lv16.h<0) Lx16.h = Lu16.h",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from if(Lv16.h<0) Lx16.h = Lu16.h to Lx16.h=mux(Lx16.h,Lu16.h,Lv16.h)",
+fASM_MAP("if(Lv16.h<0) Lx16.h = Lu16.h","Lx16.h=mux(Lx16.h,Lu16.h,Lv16.h)"))
+
+EXTINSN(LX_mux_h,"Lx16.h=mux(Lx16.h,Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Mux select",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxV.h[i] = (LvV.h[i] < 0) ? LuV.h[i] : LxV.h[i]; })
+
 EXTINSN(LX_L16b_tmp,"Ld16.tmp=mem(Rs32)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_NOTE_HLX_MEM,A_HLX_MEM,A_VTCM_ALLBANK_ACCESS,A_LOAD,A_RESTRICT_SLOT1ONLY,A_HLX_TMP),"Aligned HLX load",
 { fEA_REG(RsV); fLOADMML(EA,LdV,false,false);})
 
@@ -31,6 +37,132 @@ EXTINSN(LX_S16b_new,"mem(Rs32)=Ku16.new",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PAR
 EXTINSN(LX_S16b_p_new,"if (Pv4) mem(Rs32)=Ku16.new",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_NOTE_HLX_MEM,A_HLX_MEM,A_VTCM_ALLBANK_ACCESS,A_STORE,A_HLX_NEW,A_DOTNEWVALUE,A_RESTRICT_SLOT0ONLY,A_CONDEXEC),"Aligned HLX new halfword store",
 { fEA_REG(RsV); if(fLSBOLD(PvV)){fSTOREMML(EA,fNEWLREG(KuN),false,false);} else {STORE_CANCEL(EA);};})
 
+EXTINSN(LX_add_h,"Ld16.h=add(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = LuV.h[i] + LvV.h[i]; })
+
+EXTINSN(LX_add_h_sat,"Ld16.h=add(Lu16.h,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVSADDSAT(16, LuV.h[i], LvV.h[i]); })
+
+EXTINSN(LX_add_uh_sat,"Ld16.uh=add(Lu16.uh,Lv16.uh):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVUADDSAT(16, LuV.uh[i], LvV.uh[i]); })
+
+EXTINSN(LX_add_uhh_sat,"Ld16.uh=add(Lu16.h,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVUSADDSAT(16, LuV.h[i], LvV.h[i]); })
+
+EXTINSN(LX_sub_h,"Ld16.h=sub(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector sub h",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = LuV.h[i] - LvV.h[i]; })
+
+EXTINSN(LX_sub_h_sat,"Ld16.h=sub(Lu16.h,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVSSUBSAT(16, LuV.h[i], LvV.h[i]); })
+
+EXTINSN(LX_sub_uh_sat,"Ld16.uh=sub(Lu16.uh,Lv16.uh):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVUSUBSAT(16, LuV.uh[i], LvV.uh[i]); })
+
+EXTINSN(LX_sub_uhh_sat,"Ld16.uh=sub(Lu16.h,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVUSSUBSAT(16, LuV.h[i], LvV.h[i]); })
+
+EXTINSN(LX_add_wwh,"Ldd16.w=add(Luu16.w,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector addition with widen into two large vectors",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4_4s(LuuV.l[i].w + fSXTN(16,32,LvV.h[i])); })
+
+EXTINSN(LX_add_wwuh,"Ldd16.w=add(Luu16.w,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector addition with widen into two large vectors",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4_4s(LuuV.l[i].w + fZXTN(16,32,LvV.uh[i])); })
+
+EXTINSN(LX_sub_wwh,"Ldd16.w=sub(Luu16.w,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector sub with widen into two large vectors",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4_4s(LuuV.l[i].w - fSXTN(16,32,LvV.h[i])); })
+
+EXTINSN(LX_sub_wwuh,"Ldd16.w=sub(Luu16.w,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector sub with widen into two large vectors",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4_4s(LuuV.l[i].w - fZXTN(16,32,LvV.uh[i])); })
+
+EXTINSN(LX_add_wuh,"Ldd16.w=add(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector addition with widen into two large vectors",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4_4s(fZXTN(16,32,LuV.uh[i]) + fZXTN(16,32,LvV.uh[i])); })
+
+EXTINSN(LX_sub_wuh,"Ldd16.w=sub(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector addition with widen into two large vectors",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4_4s(fZXTN(16,32,LuV.uh[i]) - fZXTN(16,32,LvV.uh[i])); })
+
+EXTINSN(LX_conv_uw_uh,"Ldd16.uw=zxt(Lu16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Convert unsigned halfword to unsigned word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fZXTN(16,32,LuV.uh[i]); })
+
+EXTINSN(LX_conv_w_h,"Ldd16.w=sxt(Lu16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Convert halfword to word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fSXTN(16,32,LuV.h[i]); })
+
+EXTINSN(LX_abs_uh,"Ld16.uh=abs(Lu16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Absolute value of large vector of half word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fABSW(LuV.h[i]); })
+
+EXTINSN(LX_abs_uh_sat,"Ld16.h=abs(Lu16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Absolute value & saturate of large vector of half word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVSATH(fABSW(LuV.h[i])); })
+
+EXTINSN(LX_cmp_gt_uh,"Ld16.h=cmp.gt(Lu16.uh, Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Unsigned compare greater than",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.uh[i] > LvV.uh[i]) ? 0xFFFF : 0x0; })
+
+EXTINSN(LX_cmp_gt_h,"Ld16.h=cmp.gt(Lu16.h, Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Signed compare greater than",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.h[i] > LvV.h[i]) ? 0xFFFF : 0x0; })
+
+EXTINSN(LX_max_uh,"Ld16.uh=max(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector max ",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = (LuV.uh[i] > LvV.uh[i]) ? LuV.uh[i] : LvV.uh[i]; })
+
+EXTINSN(LX_min_uh,"Ld16.uh=min(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vectormac max ",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = (LuV.uh[i] < LvV.uh[i]) ? LuV.uh[i] : LvV.uh[i]; })
+
+EXTINSN(LX_max_h,"Ld16.h=max(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector max ",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.h[i] > LvV.h[i]) ? LuV.h[i] : LvV.h[i]; })
+
+EXTINSN(LX_min_h,"Ld16.h=min(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector max ",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.h[i] < LvV.h[i]) ? LuV.h[i] : LvV.h[i]; })
+
+EXTINSN(LX_and,"Ld16=and(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical And",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] & LvV.uh[i]; })
+
+EXTINSN(LX_or,"Ld16=or(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical OR",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] | LvV.uh[i]; })
+
+EXTINSN(LX_xor,"Ld16=xor(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical XOR",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] ^ LvV.uh[i]; })
+
+EXTINSN(LX_not,"Ld16=not(Lu16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical NOT",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = ~LuV.uh[i]; })
+
+EXTINSN(LX_andn,"Ld16=andn(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical not And",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] & ~LvV.uh[i]; })
+
+EXTINSN(LX_orn,"Ld16=orn(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical not OR",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] | ~LvV.uh[i]; })
+
+EXTINSN(LX_assign,"Ld16.h=Lu16.h",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Assign an Lreg",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=LuV.uh[i]; })
+
+EXTINSN(LX_assign_w,"Ldd16.w=Luu16.w",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Assign a double Lreg",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w=LuuV.l[i].w; })
+
+EXTINSN(LX_assign_r,"Ld16.h=Rt32.h",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Assign half a scalar register to L register",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fGETHALF(0,RtV); })
+
+EXTINSN(LX_assign_s,"Ld16.h=#s5",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23,A_HLX_SCALAR32),"Assign a signed immediate to L register",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=siV; })
+
+EXTINSN(LX_assign_u,"Ld16.uh=#u5",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23,A_HLX_SCALAR32),"Assign a unsigned immediate to L register",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=uiV; })
+
+EXTINSN(LX_assign_rw,"Ldd16.w=Rt32.w",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Assign half a scalar register to L register",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w=RtV; })
+
+Q6INSN(LX_zero,"Ld16=#0",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ld16=#0 to Ld16=xor(L15,L15)",
+fASM_MAP("Ld16=#0","Ld16=xor(L15,L15)"))
+
+Q6INSN(LX_zero_w,"Ldd16=#0",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ldd16=#0 to Ldd16=xor(L15:14,L15:14)",
+fASM_MAP("Ldd16=#0","Ldd16=xor(L15:14,L15:14)"))
+
+Q6INSN(LX_assign_alt,"Ld16=Lu16",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ld16=Lu16 to Ld16.h=Lu16.h",
+fASM_MAP("Ld16=Lu16","Ld16.h=Lu16.h"))
+
+Q6INSN(LX_assign_w_alt,"Ldd16=Luu16",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ldd16=Luu16 to Ldd16.w=Luu16.w",
+fASM_MAP("Ldd16=Luu16","Ldd16.w=Luu16.w"))
+
+Q6INSN(LX_hi,"Ld16=hi(Luu16)",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ld16=hi(Luu16) to Ld=lo(LW)",
+fASM_MAP("Ld16=hi(Luu16)","Ld=lo(LW)"))
+
+Q6INSN(LX_lo,"Ld16=lo(Luu16)",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ld16=lo(Luu16) to Ld=hi(LW)",
+fASM_MAP("Ld16=lo(Luu16)","Ld=hi(LW)"))
+
 Q6INSN(LX_LL16b_tmp,"Ldd16.tmp=mem(Rs32)",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ldd16.tmp=mem(Rs32) to LWd.tmp=mem(R)",
 fASM_MAP("Ldd16.tmp=mem(Rs32)","LWd.tmp=mem(R)"))
 
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index 0e643b2910..ef22fe3306 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -341,6 +341,11 @@
     fVSATN(WIDTH, fSXTN(WIDTH, 2 * WIDTH, U) + fSXTN(WIDTH, 2 * WIDTH, V))
 #define fVUSUBSAT(WIDTH, U, V) \
     fVSATUN(WIDTH, fZXTN(WIDTH, 2 * WIDTH, U) - fZXTN(WIDTH, 2 * WIDTH, V))
+/* Signed inputs, result saturated to the unsigned range */
+#define fVUSADDSAT(WIDTH, U, V) \
+    fVSATUN(WIDTH, fSXTN(WIDTH, 2 * WIDTH, U) + fSXTN(WIDTH, 2 * WIDTH, V))
+#define fVUSSUBSAT(WIDTH, U, V) \
+    fVSATUN(WIDTH, fSXTN(WIDTH, 2 * WIDTH, U) - fSXTN(WIDTH, 2 * WIDTH, V))
 #define fVSSUBSAT(WIDTH, U, V) \
     fVSATN(WIDTH, fSXTN(WIDTH, 2 * WIDTH, U) - fSXTN(WIDTH, 2 * WIDTH, V))
 #define fVAVGU(WIDTH, U, V) \
-- 
2.43.0


