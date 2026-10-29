Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1081606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i1ydWj1y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUFG-0004gB-Lr; Thu, 29 Oct 2026 13:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006qM-9p
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003bC-Iz
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDsJQ228442; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mONxb5Ni3O0
 tu+WxRokYQJXr+AnIG3oIN44QABApUbE=; b=i1ydWj1yulmmryRMBrnIyL++WCZ
 U8p8nFemrzxt0qt583vzf3fofbavY/BGM3P4X1FG/3WHKwpns7iKD3s1oMfd20aB
 +9Vh3Kpuv/FT/1I+H5USAgSNOW4PuehNCwAqKX4hxPHMuuNK0DGYOfP+zjWXhobx
 69s3JyDA16JgHlDVmFaLe0olvmmUozUAaqmuXn1kcvz9VBMQvx7viHRu8PidPE0o
 fn+LKMeQlSpZRY6xCwcnP2tWL9zIloT8PYYRLs2EK4IKoo35coRJSRxkcrHlHU1o
 1dzIqiY3J4b8yqpi2hbFzO3gURvfX7Xs/zz0G3k4ukP3JBuwO+LgIhUWdBg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fjjq4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEgM2488410; Thu, 29 Oct 2026 17:44:15 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 69THiEjW2488385
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id BD06125850; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
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
Subject: [PATCH 17/20] target/hexagon: add HLX multiply instructions
Date: Thu, 29 Oct 2026 10:44:10 -0700
Message-ID: <20261029174413.643130-18-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXznCJrBdXRLfn
 9jsS45Waa3MLhhNMNTK2wUhS+MnGhGXDmInABb0v06arU4ah7YDaU6r6bs2lVxk03fvPnwVrMiO
 yEYioFDI3fqyjQ8nERCo+WguxOlEofHJvv6zBqVV0EAxWv7JuvwxN9tK+yg3TQuYucLpDIP24e+
 F3OFijjVrkqCUPf9QUPxYl8Ddz9T1cB2fI8sI6F1bgxE5oO8lgRQnGhwFgKi7bQ/dPG85hL3SKH
 B83WO5H+iFAlryKWT8B2sti9fK6z/j6OzRQV8DxX/ONoFuvIf6AY3PuxYjGsO7MLih9R2cXPBUN
 XmCYpozSZLLJjuj2vI/ol0tdnFIBFXosL6r8hsu8AEsmptoNUp2ow/u3UuDwp2Ze48mLPO/mymH
 euCGGcwsvwnU6b1pAP+AgA0W+WiMBw==
X-Proofpoint-GUID: MjOiNxj2kkBCAE1SKruu0ZG3nuydsVCe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX6c1hoyYaDPUK
 O7OFTKYnz3MXY7w1LW2kM3R8OtTdc7/+zrzo5oLbmOFfESibUxsqdb9tDl90LoH9SMj5Fh7iTWC
 Zs/oj31gdIUyfluNBysU5zPtgzkgKus=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=asxyH75QIdsd1xpuhMIA:9
X-Proofpoint-ORIG-GUID: MjOiNxj2kkBCAE1SKruu0ZG3nuydsVCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290069
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

Define HLX multiply and multiply-accumulate instructions.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/imported/hlx/encode_ext.def | 25 ++++++++
 target/hexagon/imported/hlx_ext.idef       | 72 ++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/target/hexagon/imported/hlx/encode_ext.def b/target/hexagon/imported/hlx/encode_ext.def
index 520af860da..ee15c251d8 100644
--- a/target/hexagon/imported/hlx/encode_ext.def
+++ b/target/hexagon/imported/hlx/encode_ext.def
@@ -51,6 +51,31 @@ DEF_ENC(LX_sub_wuh,"11100101001vvvv-PP1010uuuu0dddd1")
 DEF_ENC(LX_assign_u,"11100101001iiiiiPP1010----1dddd0")
 DEF_ENC(LX_assign_s,"11100101001iiiiiPP1010----1dddd1")
 
+DEF_ENC(LX_mpyr_uw_uh,"11100111000tttttPP1000uuuu0dddd0")
+DEF_ENC(LX_mpy_uw_uh,"11100111000vvvv0PP1000uuuu0dddd1")
+DEF_ENC(LX_mpyr_w_huh,"11100111000tttttPP1000uuuu1dddd0")
+DEF_ENC(LX_mpy_w_huh,"11100111000vvvv0PP1000uuuu1dddd1")
+DEF_ENC(LX_mpy_w_h,"11100111000vvvv0PP1001uuuu0dddd0")
+DEF_ENC(LX_mpyr_w_h,"11100111000tttttPP1001uuuu0dddd1")
+DEF_ENC(LX_mpa_wuh,"11100111000vvvv-PP1001uuuu1xxxx0")
+DEF_ENC(LX_mpar_wuh,"11100111000tttttPP1001uuuu1xxxx1")
+DEF_ENC(LX_mpar_whuh,"11100111000tttttPP1010uuuu0xxxx0")
+DEF_ENC(LX_mpa_whuh,"11100111000vvvv-PP1010uuuu0xxxx1")
+DEF_ENC(LX_mpar_wh,"11100111000tttttPP1010uuuu1xxxx0")
+DEF_ENC(LX_mpa_wh,"11100111000vvvv-PP1010uuuu1xxxx1")
+DEF_ENC(LX_mpar_wuh_lo,"11100111000tttttPP1011uuuu0xxxx0")
+DEF_ENC(LX_mpa_wuh_lo,"11100111000vvvv-PP1011uuuu0xxxx1")
+DEF_ENC(LX_mpar_whuh_lo,"11100111000tttttPP1011uuuu1xxxx0")
+DEF_ENC(LX_mpa_whuh_lo,"11100111000vvvv-PP1011uuuu1xxxx1")
+DEF_ENC(LX_mpar_wuh_hi,"11100111000tttttPP1100uuuu0xxxx0")
+DEF_ENC(LX_mpa_wuh_hi,"11100111000vvvv-PP1100uuuu0xxxx1")
+DEF_ENC(LX_mpar_wh_hi,"11100111000tttttPP1100uuuu1xxxx0")
+DEF_ENC(LX_mpa_wh_hi,"11100111000vvvv-PP1100uuuu1xxxx1")
+DEF_ENC(LX_mpar_uwuhuw_si,"11100111111tttttPP1101uuuu0xxxx0")
+DEF_ENC(LX_mpa_uwuhuw_si,"11100111111vvvv-PP1101uuuu0xxxx1")
+DEF_ENC(LX_mpar_wuhw_si,"11100111111tttttPP1101uuuu1xxxx0")
+DEF_ENC(LX_mpa_wuhw_si,"11100111111vvvv-PP1101uuuu1xxxx1")
+
 DEF_ENC(LX_lut4,"11101101000tttttPP1000uuuu0dddd0")
 DEF_ENC(LX_lut4_sh,"11101101000tttttPP1000uuuu0dddd1")
 DEF_ENC(LX_lut4_sh_neg,"11101101000tttttPP1000uuuu1dddd0")
diff --git a/target/hexagon/imported/hlx_ext.idef b/target/hexagon/imported/hlx_ext.idef
index 7a6ab194b9..1e52148941 100644
--- a/target/hexagon/imported/hlx_ext.idef
+++ b/target/hexagon/imported/hlx_ext.idef
@@ -73,6 +73,78 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fBIT_WIDTH(32,LuuV.l[i].w ^ -(Luu
 EXTINSN(LX_sub_ilog2_uw,"Ld16.h=sub(ilog2(Luu16.uw),#u5)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR32),"Count leading bits of unsigned word",
 fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fBIT_WIDTH(32,LuuV.l[i].uw) - 1 - uiV; fHIDE(check_ilog2_compliance(LdV.h[i],LuuV.l[i].uw, uiV);); })
 
+EXTINSN(LX_mpyr_uw_uh,"Ldd16.uw=mpy(Lu16.uh,Rt32.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Widening multiply with HLX unsigned half and scalar unsigned half",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fLMPY16UU(LuV.uh[i],fGETUHALF(0,RtV)); })
+
+EXTINSN(LX_mpy_uw_uh,"Ldd16.uw=mpy(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY),"Widening multiply with two HLX unsigned half",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fLMPY16UU(LuV.uh[i],LvV.uh[i]); })
+
+EXTINSN(LX_mpyr_w_huh,"Ldd16.w=mpy(Lu16.h,Rt32.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Widening multiply with HLX unsigned half and scalar unsigned half",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fLMPY16SU(LuV.h[i],fGETUHALF(0,RtV)); })
+
+EXTINSN(LX_mpy_w_huh,"Ldd16.w=mpy(Lu16.h,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY),"Widening multiply with unsigned half and signed half",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fLMPY16SU(LuV.h[i],LvV.uh[i]); })
+
+EXTINSN(LX_mpyr_w_h,"Ldd16.w=mpy(Lu16.h,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Widening multiply with HLX signed half and scalar signed half",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fLMPY16SS(LuV.h[i],fGETHALF(0,RtV)); })
+
+EXTINSN(LX_mpy_w_h,"Ldd16.w=mpy(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY),"Widening multiply with signed half and signed half",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fLMPY16SS(LuV.h[i],LvV.h[i]); })
+
+EXTINSN(LX_mpar_wuh,"Lxx16.w+=mpy(Lu16.uh,Rt32.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Large multiply add",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w += fLMPY16UU(LuV.uh[i], fGETUHALF(0,RtV)); })
+
+EXTINSN(LX_mpa_wuh,"Lxx16.w+=mpy(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY),"Large multiply add",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w += fLMPY16UU(LuV.uh[i], LvV.uh[i]); })
+
+EXTINSN(LX_mpar_whuh,"Lxx16.w+=mpy(Lu16.h,Rt32.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Large multiply add",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = LxxV.l[i].w + fLMPY16SU(LuV.h[i], fGETUHALF(0,RtV)); })
+
+EXTINSN(LX_mpa_whuh,"Lxx16.w+=mpy(Lu16.h,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY),"Large multiply add",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = LxxV.l[i].w + fLMPY16SU(LuV.h[i], LvV.uh[i]); })
+
+EXTINSN(LX_mpar_wh,"Lxx16.w+=mpy(Lu16.h,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Large multiply add",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = LxxV.l[i].w + fLMPY16SS(LuV.h[i], fGETHALF(0,RtV)); })
+
+EXTINSN(LX_mpa_wh,"Lxx16.w+=mpy(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY),"Large multiply add",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = LxxV.l[i].w + fLMPY16SS(LuV.h[i], LvV.h[i]); })
+
+EXTINSN(LX_mpar_wuh_lo,"Lxx16.uw=add(mpy(Lu16.uh,Rt32.uh),lo(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fLMPY16UU(LuV.uh[i], fGETUHALF(0,RtV)) + fZE16_32(LxxV.l[i].uh[0]); })
+
+EXTINSN(LX_mpa_wuh_lo,"Lxx16.uw=add(mpy(Lu16.uh,Lv16.uh),lo(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD),"Large multiply add",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fLMPY16UU(LuV.uh[i],LvV.uh[i]) + fZE16_32(LxxV.l[i].uh[0]); })
+
+EXTINSN(LX_mpar_whuh_lo,"Lxx16.w=add(mpy(Lu16.h,Rt32.uh),lo(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = fLMPY16SU(LuV.h[i], fGETUHALF(0,RtV)) + fZE16_32(LxxV.l[i].uh[0]); })
+
+EXTINSN(LX_mpa_whuh_lo,"Lxx16.w=add(mpy(Lu16.h,Lv16.uh),lo(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = fLMPY16SU(LuV.h[i], LvV.uh[i]) + fZE16_32(LxxV.l[i].uh[0]); })
+
+EXTINSN(LX_mpar_wuh_hi,"Lxx16.uw=add(mpy(Lu16.uh,Rt32.uh),hi(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fLMPY16UU(LuV.uh[i], fGETUHALF(0,RtV)) + fZE16_32(LxxV.l[i].uh[1]); })
+
+EXTINSN(LX_mpa_wuh_hi,"Lxx16.uw=add(mpy(Lu16.uh,Lv16.uh),hi(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fLMPY16UU(LuV.uh[i], LvV.uh[i]) + fZE16_32(LxxV.l[i].uh[1]); })
+
+EXTINSN(LX_mpar_wh_hi,"Lxx16.uw=add(mpy(Lu16.h,Rt32.uh),hi(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fLMPY16SU(LuV.h[i], fGETUHALF(0,RtV)) + fZE16_32(LxxV.l[i].uh[1]); })
+
+EXTINSN(LX_mpa_wh_hi,"Lxx16.uw=add(mpy(Lu16.h,Lv16.uh),hi(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fLMPY16SU(LuV.h[i], LvV.uh[i]) + fZE16_32(LxxV.l[i].uh[1]); })
+
+EXTINSN(LX_mpar_uwuhuw_si,"Lxx16.uw=add(mpy(Lu16.uh,hi(Lxx16).uh),Rt32.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_MPY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Large multiply add",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fGETWORD(0,RtV) + fMPY3216UU(LxxV.l[i].uh[1],LuV.h[i]); })
+
+EXTINSN(LX_mpa_uwuhuw_si,"Lxx16.uw=add(mpy(Lu16.uh,hi(Lxx16).uh),Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_MPY),"Large multiply add",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = LvvV.l[i].w + fMPY3216UU(LxxV.l[i].uh[1],LuV.h[i]); })
+
+EXTINSN(LX_mpar_wuhw_si,"Lxx16.w=add(mpy(Lu16.uh,hi(Lxx16).h),Rt32.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_MPY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Large multiply add",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = fGETWORD(0,RtV) + fMPY3216SU(LxxV.l[i].h[1],LuV.uh[i]); })
+
+EXTINSN(LX_mpa_wuhw_si,"Lxx16.w=add(mpy(Lu16.uh,hi(Lxx16).h),Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_MPY),"Large multiply add",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = LvvV.l[i].w + fMPY3216SU(LxxV.l[i].h[1],LuV.uh[i]); })
+
 EXTINSN(LX_L16b_tmp,"Ld16.tmp=mem(Rs32)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_NOTE_HLX_MEM,A_HLX_MEM,A_VTCM_ALLBANK_ACCESS,A_LOAD,A_RESTRICT_SLOT1ONLY,A_HLX_TMP),"Aligned HLX load",
 { fEA_REG(RsV); fLOADMML(EA,LdV,false,false);})
 
-- 
2.43.0


