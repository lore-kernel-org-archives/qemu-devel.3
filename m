Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B4606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lBx1DUEC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUCi-0000vO-2Q; Thu, 29 Oct 2026 13:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006qK-9F
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003c9-MI
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDWka3234206; Thu, 29 Oct 2026 17:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FcEKjpqPSeH
 5R+Aud8LNg1VD2MJ4zx0lovdlzH2NUCM=; b=lBx1DUEC/C87bf3Sc88iWHcZDHI
 kfIyVXHyC7db6wRtWTS+fkfpHnxbyDs93eq/FmWtbaywVqsV3rSNoYoi85Fs824t
 Wp9v4MLULrYoMojgB08vCXyoqTC/p3eLGMeBten6Q1SbnmRaIsdYOOYnP02GCaYS
 LSPSdaOCT5gmHya6XBxWaFas7DcTDWQ7MlGMhprmtDMt94GZbqIHJaAwIDFUbOhs
 PdaCFcG7drMleupDMQLHaE7YPyuXOIcY3s7dSRMYRaWs87M0nB3Xf+NPodgt6EuT
 jq64xC29gyjGmCnlt3F38ab6pbDP7gk5qQHeSyTGQXBQGOF8VVszpsXtSog==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b28d1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEe12516195; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69THiEos2516243
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id B81A22584C; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
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
Subject: [PATCH 16/20] target/hexagon: add HLX shift,
 average and lookup instructions
Date: Thu, 29 Oct 2026 10:44:09 -0700
Message-ID: <20261029174413.643130-17-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX2wRafm284Jzr
 Gqm8oQs80Sf2QC560oHcheRS7hRpFyQ/q2QJm4d0WWjfg+2tL2zdDC0xZZHIYDilngW6RSKWwKb
 YWhcHDRc1qjNppoITviHH1/+DKr9UHw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX3ntmZb4f0PGW
 n5P+qw8SDB722HiYzivU+0WuABOWMFC0AFW6suEIS7a373dvt8Wrjuv9/roTR95JQtlRS9FBeyY
 NmjArXJR67HFhGOcdjG/di3Gv6Sd+XmN2mEkV9AGVL8eXWHe77N8R/4HuR2FZP3EdSk8cw9bi5v
 bUtHeYXen9wTka8L0tYwVIEAqXy1wQpzw3ipJnXNvBte5pYkYTjKWfKqqCeN8+TReyh+Kc15hzS
 Xx64551hi6/IqcvB2g8oWLpKLGqclVU4xD64unzBrc4i0gaOuSZv4FWV+c2LABQ/P6yhDzuiVhA
 HWksaDl7cGmmareG/A+tdVcZiwGt7JxkVBusoKzkx9qcYJ8jDEuAV/VfD9MDqiooiYWQn3ykNif
 IhE5XILroplUhQ50yITejiTDNxjoN4Vj1bFfgO7uDBvdQeny16tJHvnpYBbkiqPLPt6ErVIkE7I
 L9oh+6g1Z104lFyOsTA==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=PnqcjmUFUnyM6qC52qUA:9
X-Proofpoint-GUID: vcQ2BGPEWd74xL6aICsvGfk-gm5eFIdx
X-Proofpoint-ORIG-GUID: vcQ2BGPEWd74xL6aICsvGfk-gm5eFIdx
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

Define HLX shift, average, absolute difference, lookup, conversion, and
ilog2 subtraction instructions.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/imported/hlx/encode_ext.def |  59 +++++++
 target/hexagon/imported/hlx_ext.idef       | 174 +++++++++++++++++++++
 2 files changed, 233 insertions(+)

diff --git a/target/hexagon/imported/hlx/encode_ext.def b/target/hexagon/imported/hlx/encode_ext.def
index 5a11f58d79..520af860da 100644
--- a/target/hexagon/imported/hlx/encode_ext.def
+++ b/target/hexagon/imported/hlx/encode_ext.def
@@ -51,6 +51,65 @@ DEF_ENC(LX_sub_wuh,"11100101001vvvv-PP1010uuuu0dddd1")
 DEF_ENC(LX_assign_u,"11100101001iiiiiPP1010----1dddd0")
 DEF_ENC(LX_assign_s,"11100101001iiiiiPP1010----1dddd1")
 
+DEF_ENC(LX_lut4,"11101101000tttttPP1000uuuu0dddd0")
+DEF_ENC(LX_lut4_sh,"11101101000tttttPP1000uuuu0dddd1")
+DEF_ENC(LX_lut4_sh_neg,"11101101000tttttPP1000uuuu1dddd0")
+DEF_ENC(LX_lut4_mask,"11101101000tttttPP1000uuuu1dddd1")
+DEF_ENC(LX_absdiff_h,"11101101000vvvv-PP1001uuuu0dddd0")
+DEF_ENC(LX_absdiff_w,"11101101000vvvv-PP1001uuuu0dddd1")
+DEF_ENC(LX_absdiff_uh,"11101101000vvvv-PP1001uuuu1dddd0")
+DEF_ENC(LX_absdiff_uw,"11101101000vvvv-PP1001uuuu1dddd1")
+DEF_ENC(LX_avg_h,"11101101000vvvv-PP1010uuuu0dddd0")
+DEF_ENC(LX_avg_w,"11101101000vvvv-PP1010uuuu0dddd1")
+DEF_ENC(LX_avg_uh,"11101101000vvvv-PP1010uuuu1dddd0")
+DEF_ENC(LX_avg_uw,"11101101000vvvv-PP1010uuuu1dddd1")
+DEF_ENC(LX_avg_h_rnd,"11101101000vvvv-PP1011uuuu0dddd0")
+DEF_ENC(LX_avg_w_rnd,"11101101000vvvv-PP1011uuuu0dddd1")
+DEF_ENC(LX_avg_uh_rnd,"11101101000vvvv-PP1011uuuu1dddd0")
+DEF_ENC(LX_avg_uw_rnd,"11101101000vvvv-PP1011uuuu1dddd1")
+DEF_ENC(LX_navg_h,"11101101000vvvv-PP1100uuuu0dddd0")
+DEF_ENC(LX_navg_w,"11101101000vvvv-PP1100uuuu0dddd1")
+DEF_ENC(LX_navg_uh,"11101101000vvvv-PP1100uuuu1dddd0")
+DEF_ENC(LX_navg_uw,"11101101000vvvv-PP1100uuuu1dddd1")
+DEF_ENC(LX_conv_b_h_lo,"11101101000vvvv-PP1101uuuu0dddd0")
+DEF_ENC(LX_conv_b_h_hi,"11101101000vvvv-PP1101uuuu0dddd1")
+DEF_ENC(LX_conv_h_b_lo,"11101101000-----PP1101uuuu1dddd0")
+DEF_ENC(LX_conv_h_b_hi,"11101101000-----PP1101uuuu1dddd1")
+DEF_ENC(LX_shra_h_uh,"11101101000vvvv-PP1110uuuu0xxxx0")
+DEF_ENC(LX_shrar_h_uh,"11101101000tttttPP1110uuuu0xxxx1")
+DEF_ENC(LX_shra_h_h,"11101101000vvvv-PP1110uuuu1xxxx0")
+DEF_ENC(LX_shrar_h_h,"11101101000tttttPP1110uuuu1xxxx1")
+DEF_ENC(LX_shra_w_uw,"11101101000vvvv-PP1111uuuu0xxxx0")
+DEF_ENC(LX_shrar_w_uw,"11101101000tttttPP1111uuuu0xxxx1")
+DEF_ENC(LX_shra_w_w,"11101101000vvvv-PP1111uuuu1xxxx0")
+DEF_ENC(LX_shrar_w_w,"11101101000tttttPP1111uuuu1xxxx1")
+DEF_ENC(LX_sub_ilog2_h,"11101101001iiii-PP1001uuuu0dddd0")
+DEF_ENC(LX_sub_ilog2_uh,"11101101001iiii-PP1001uuuu0dddd1")
+DEF_ENC(LX_sub_ilog2_w,"11101101001iiiiiPP1001uuuu1dddd0")
+DEF_ENC(LX_sub_ilog2_uw,"11101101001iiiiiPP1001uuuu1dddd1")
+DEF_ENC(LX_shr_h,"11101101001vvvv-PP1010uuuu0dddd0")
+DEF_ENC(LX_shrr_h,"11101101001tttttPP1010uuuu0dddd1")
+DEF_ENC(LX_shr_uh_uh,"11101101001vvvv-PP1010uuuu1dddd0")
+DEF_ENC(LX_shrr_uh_uh,"11101101001tttttPP1010uuuu1dddd1")
+DEF_ENC(LX_shr_uw_uw,"11101101001vvvv-PP1011uuuu0dddd0")
+DEF_ENC(LX_shrr_uw_uw,"11101101001tttttPP1011uuuu0dddd1")
+DEF_ENC(LX_shr_w_w,"11101101001vvvv-PP1011uuuu1dddd0")
+DEF_ENC(LX_shrr_w_w,"11101101001tttttPP1011uuuu1dddd1")
+DEF_ENC(LX_shr_h_w_uh,"11101101001vvvv-PP1100uuuu0dddd0")
+DEF_ENC(LX_shrr_h_w_uh,"11101101001tttttPP1100uuuu0dddd1")
+DEF_ENC(LX_shr_h_w_sat,"11101101001vvvv-PP1100uuuu1dddd0")
+DEF_ENC(LX_shrr_h_w_sat,"11101101001tttttPP1100uuuu1dddd1")
+DEF_ENC(LX_shr_h_w_rnd_sat,"11101101001vvvv-PP1101uuuu0dddd0")
+DEF_ENC(LX_shrr_h_w_rnd_sat,"11101101001tttttPP1101uuuu0dddd1")
+DEF_ENC(LX_shr_uh_w_sat,"11101101001vvvv-PP1101uuuu1dddd0")
+DEF_ENC(LX_shrr_uh_w_sat,"11101101001tttttPP1101uuuu1dddd1")
+DEF_ENC(LX_shr_uh_w_rnd_sat,"11101101001vvvv-PP1110uuuu0dddd0")
+DEF_ENC(LX_shrr_uh_w_rnd_sat,"11101101001tttttPP1110uuuu0dddd1")
+DEF_ENC(LX_shr_uh_uw_rnd_sat,"11101101001vvvv-PP1110uuuu1dddd0")
+DEF_ENC(LX_shrr_uh_uw_rnd_sat,"11101101001tttttPP1110uuuu1dddd1")
+DEF_ENC(LX_shr_uh_uw_sat,"11101101001vvvv-PP1111uuuu0dddd0")
+DEF_ENC(LX_shrr_uh_uw_sat,"11101101001tttttPP1111uuuu0dddd1")
+
 DEF_ENC(LX_add_w,"11101111000vvvv-PP1000uuuu0dddd0")
 DEF_ENC(LX_add_w_sat,"11101111000vvvv-PP1000uuuu0dddd1")
 DEF_ENC(LX_add_uw_sat,"11101111000vvvv-PP1000uuuu1dddd0")
diff --git a/target/hexagon/imported/hlx_ext.idef b/target/hexagon/imported/hlx_ext.idef
index 47e1171473..7a6ab194b9 100644
--- a/target/hexagon/imported/hlx_ext.idef
+++ b/target/hexagon/imported/hlx_ext.idef
@@ -19,12 +19,60 @@
     } \
 }
 
+EXTINSN(LX_lut4,"Ld16.h=lut4(Lu16.uh,Rtt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR64),"Large 4 entry lookup table",
+fHIDE(f64BIT_SCALAR_MASK(RttV)) fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]= fGETHALF(((LuV.uh[i]>>14)&0x3), RttV ); })
+
+EXTINSN(LX_lut4_sh,"Ldd16.w=lut4(Lu16.uh,Rtt32.uh):>>1",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR64),"Large 4 entry lookup table",
+fHIDE(f64BIT_SCALAR_MASK(RttV)) fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4s(fGETUHALF(((LuV.uh[i]>>14)&0x3), RttV ))<<15; })
+
+EXTINSN(LX_lut4_sh_neg,"Ldd16.w=lut4(Lu16.uh,Rtt32.uh):>>1:neg",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR64),"Large 4 entry lookup table",
+fHIDE(f64BIT_SCALAR_MASK(RttV)) fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = (fCAST4u(fGETUHALF(((LuV.uh[i]>>14)&0x3), RttV )) - (1<<16))<<15; })
+
+EXTINSN(LX_lut4_mask,"Ld16.h=lut4(Lu16.uh,Rtt32.h):mask",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR64),"Large 4 entry lookup table",
+fHIDE(f64BIT_SCALAR_MASK(RttV)) fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (fGETHALF(((LuV.uh[i]>>14)&0x3), RttV ) & ((LuV.uh[i] & 0x3FFF) == 0 ? 0xFFFF : 0)); })
+
 Q6INSN(LX_mux_h_alt,"if(Lv16.h<0) Lx16.h = Lu16.h",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from if(Lv16.h<0) Lx16.h = Lu16.h to Lx16.h=mux(Lx16.h,Lu16.h,Lv16.h)",
 fASM_MAP("if(Lv16.h<0) Lx16.h = Lu16.h","Lx16.h=mux(Lx16.h,Lu16.h,Lv16.h)"))
 
 EXTINSN(LX_mux_h,"Lx16.h=mux(Lx16.h,Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Mux select",
 fHIDE(int i;) fLVFOREACH(1024, i) { LxV.h[i] = (LvV.h[i] < 0) ? LuV.h[i] : LxV.h[i]; })
 
+EXTINSN(LX_shra_h_uh,"Lx16.h+=shr(Lu16.uh,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxV.h[i]+=fLSHIFTU(LuV.uh[i],LvV.h[i]); })
+
+EXTINSN(LX_shrar_h_uh,"Lx16.h+=shr(Lu16.uh,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxV.h[i]+=fLSHIFTU(LuV.uh[i],fCAST2_2s(RtV)); })
+
+EXTINSN(LX_shra_h_h,"Lx16.h+=shr(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxV.h[i]+=fLSHIFT(LuV.h[i],LvV.h[i]); })
+
+EXTINSN(LX_shrar_h_h,"Lx16.h+=shr(Lu16.h,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxV.h[i]+=fLSHIFT(LuV.h[i],fCAST2_2s(RtV)); })
+
+EXTINSN(LX_shra_w_uw,"Lxx16.w+=shr(Luu16.uw,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w+=fLSHIFTU(LuuV.l[i].uw,LvV.h[i]); })
+
+EXTINSN(LX_shrar_w_uw,"Lxx16.w+=shr(Luu16.uw,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w+=fLSHIFTU(LuuV.l[i].uw,fCAST2_2s(RtV)); })
+
+EXTINSN(LX_shra_w_w,"Lxx16.w+=shr(Luu16.w,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w+=fLSHIFT(LuuV.l[i].w,LvV.h[i]); })
+
+EXTINSN(LX_shrar_w_w,"Lxx16.w+=shr(Luu16.w,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
+fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w+=fLSHIFT(LuuV.l[i].w,fCAST2_2s(RtV)); })
+
+EXTINSN(LX_sub_ilog2_h,"Ld16.h=sub(ilog2(Lu16.h),#u4)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR32),"Count leading bits of halfword",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fBIT_WIDTH(16,LuV.h[i] ^ -(LuV.h[i] < 0)) - 1 - uiV; fHIDE(check_ilog2_compliance(LdV.h[i],LuV.h[i], uiV);); })
+
+EXTINSN(LX_sub_ilog2_uh,"Ld16.h=sub(ilog2(Lu16.uh),#u4)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR32),"Count leading bits of unsigned halfword",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fBIT_WIDTH(16,LuV.uh[i]) - 1 - uiV; fHIDE(check_ilog2_compliance(LdV.h[i],LuV.uh[i], uiV);); })
+
+EXTINSN(LX_sub_ilog2_w,"Ld16.h=sub(ilog2(Luu16.w),#u5)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR32),"Count leading bits of word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fBIT_WIDTH(32,LuuV.l[i].w ^ -(LuuV.l[i].w < 0)) - 1 - uiV; fHIDE(check_ilog2_compliance(LdV.h[i],LuuV.l[i].w, uiV);); })
+
+EXTINSN(LX_sub_ilog2_uw,"Ld16.h=sub(ilog2(Luu16.uw),#u5)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR32),"Count leading bits of unsigned word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fBIT_WIDTH(32,LuuV.l[i].uw) - 1 - uiV; fHIDE(check_ilog2_compliance(LdV.h[i],LuuV.l[i].uw, uiV);); })
+
 EXTINSN(LX_L16b_tmp,"Ld16.tmp=mem(Rs32)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_NOTE_HLX_MEM,A_HLX_MEM,A_VTCM_ALLBANK_ACCESS,A_LOAD,A_RESTRICT_SLOT1ONLY,A_HLX_TMP),"Aligned HLX load",
 { fEA_REG(RsV); fLOADMML(EA,LdV,false,false);})
 
@@ -85,6 +133,18 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fZXTN(16,32,LuV.uh[i]); })
 EXTINSN(LX_conv_w_h,"Ldd16.w=sxt(Lu16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Convert halfword to word",
 fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fSXTN(16,32,LuV.h[i]); })
 
+EXTINSN(LX_conv_b_h_hi,"Ld16.b=packhi(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Grab the high byte of two halfwords and pack into 16-bit register",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.b[2*i+1] = LuV.b[2*i+1]; LdV.b[2*i] = LvV.b[2*i+1]; })
+
+EXTINSN(LX_conv_b_h_lo,"Ld16.b=packlo(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Grab the low byte of two halfwords and pack into 16-bit register",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.b[2*i+1] = LuV.b[2*i]; LdV.b[2*i] = LvV.b[2*i]; })
+
+EXTINSN(LX_conv_h_b_hi,"Ldd16.h=unpackhi(Lu16.b)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Place bytes from two-byte packed register in high byte of each 16-bit register",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].b[3] = LuV.b[2*i+1]; LddV.l[i].b[1] = LuV.b[2*i]; })
+
+EXTINSN(LX_conv_h_b_lo,"Ldd16.h=unpacklo(Lu16.b)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Place bytes from two-byte packed register in low byte of each 16-bit register",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].b[2] = LuV.b[2*i+1]; LddV.l[i].b[0] = LuV.b[2*i]; })
+
 EXTINSN(LX_add_w,"Ldd16.w=add(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector add word",
 fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w + LvvV.l[i].w; })
 
@@ -151,6 +211,18 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = fABSW(LuuV.l[i].h[0]); Ldd
 EXTINSN(LX_abs_uhp_sat,"Ldd16.h=abs(Luu16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Absolute value & saturate of large vector of word",
 fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = fVSATH(fABSW(LuuV.l[i].h[0])); LddV.l[i].h[1] = fVSATH(fABSW(LuuV.l[i].h[1])) ; })
 
+EXTINSN(LX_absdiff_h,"Ld16.uh=absdiff(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Absolute differences: large vector of half word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fABSW(LuV.h[i] - LvV.h[i]); })
+
+EXTINSN(LX_absdiff_uh,"Ld16.uh=absdiff(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Absolute differences: large vector of unsigned half word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = (LuV.uh[i] > LvV.uh[i]) ? (LuV.uh[i] - LvV.uh[i]) : (LvV.uh[i] - LuV.uh[i]); })
+
+EXTINSN(LX_absdiff_w,"Ldd16.uw=absdiff(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Absolute differences: large vector of word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fABS(fSXTN(32,64,LuuV.l[i].w) - fSXTN(32,64,LvvV.l[i].w)); })
+
+EXTINSN(LX_absdiff_uw,"Ldd16.uw=absdiff(Luu16.uw,Lvv16.uw)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Absolute differences: large vector of unsigned word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = (LuuV.l[i].uw > LvvV.l[i].uw) ? (LuuV.l[i].uw - LvvV.l[i].uw) : (LvvV.l[i].uw - LuuV.l[i].uw); })
+
 EXTINSN(LX_cmp_gt_uh,"Ld16.h=cmp.gt(Lu16.uh, Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Unsigned compare greater than",
 fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.uh[i] > LvV.uh[i]) ? 0xFFFF : 0x0; })
 
@@ -262,6 +334,108 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=uiV; })
 EXTINSN(LX_assign_rw,"Ldd16.w=Rt32.w",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Assign half a scalar register to L register",
 fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w=RtV; })
 
+EXTINSN(LX_avg_h,"Ld16.h=avg(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of half word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVAVGS(16, LuV.h[i], LvV.h[i]); })
+
+EXTINSN(LX_avg_h_rnd,"Ld16.h=avg(Lu16.h,Lv16.h):rnd",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of half word with rounding",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVAVGSRND(16, LuV.h[i], LvV.h[i]); })
+
+EXTINSN(LX_navg_h,"Ld16.h=navg(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Negative average of large vector of half word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVNAVGS(16, LuV.h[i], LvV.h[i]); })
+
+EXTINSN(LX_avg_w,"Ldd16.w=avg(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVAVGS(32, LuuV.l[i].w, LvvV.l[i].w); })
+
+EXTINSN(LX_avg_w_rnd,"Ldd16.w=avg(Luu16.w,Lvv16.w):rnd",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of word with rounding",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVAVGSRND(32, LuuV.l[i].w, LvvV.l[i].w); })
+
+EXTINSN(LX_navg_w,"Ldd16.w=navg(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Negative average of large vector of word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVNAVGS(32, LuuV.l[i].w, LvvV.l[i].w); })
+
+EXTINSN(LX_avg_uh,"Ld16.uh=avg(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of unsigned half word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVAVGU(16, LuV.uh[i], LvV.uh[i]); })
+
+EXTINSN(LX_avg_uh_rnd,"Ld16.uh=avg(Lu16.uh,Lv16.uh):rnd",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of unsigned half word with rounding",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVAVGURND(16, LuV.uh[i], LvV.uh[i]); })
+
+EXTINSN(LX_navg_uh,"Ld16.h=navg(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Negative average of large vector of unsigned half word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVNAVGU(16, LuV.uh[i], LvV.uh[i]); })
+
+EXTINSN(LX_avg_uw,"Ldd16.uw=avg(Luu16.uw,Lvv16.uw)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of unsigned word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fVAVGU(32, LuuV.l[i].uw, LvvV.l[i].uw); })
+
+EXTINSN(LX_avg_uw_rnd,"Ldd16.uw=avg(Luu16.uw,Lvv16.uw):rnd",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of unsigned word with rounding",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fVAVGURND(32, LuuV.l[i].uw, LvvV.l[i].uw); })
+
+EXTINSN(LX_navg_uw,"Ldd16.w=navg(Luu16.uw,Lvv16.uw)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Negative average of large vector of unsigned word",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVNAVGU(32, LuuV.l[i].uw, LvvV.l[i].uw); })
+
+EXTINSN(LX_shr_uh_uh,"Ld16.uh=shr(Lu16.uh,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional shift large vector",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fLSHIFTU(LuV.uh[i], LvV.h[i]); })
+
+EXTINSN(LX_shrr_uh_uh,"Ld16.uh=shr(Lu16.uh,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional shift large vector",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fLSHIFTU(LuV.uh[i], fGETHALF(0,RtV)); })
+
+EXTINSN(LX_shr_h,"Ld16.h=shr(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional shift large vector",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fLSHIFT(LuV.h[i], LvV.h[i]); })
+
+EXTINSN(LX_shrr_h,"Ld16.h=shr(Lu16.h,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional shift large vector",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fLSHIFT(LuV.h[i], fGETHALF(0,RtV)); })
+
+EXTINSN(LX_shr_uw_uw,"Ldd16.uw=shr(Luu16.uw,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional shift large vector",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw=fLSHIFTU(LuuV.l[i].uw, LvV.h[i]); })
+
+EXTINSN(LX_shrr_uw_uw,"Ldd16.uw=shr(Luu16.uw,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional shift large vector",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw=fLSHIFTU(LuuV.l[i].uw, fGETHALF(0,RtV)); })
+
+EXTINSN(LX_shr_w_w,"Ldd16.w=shr(Luu16.w,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional shift large vector",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w=fLSHIFT(LuuV.l[i].w, LvV.h[i]); })
+
+EXTINSN(LX_shrr_w_w,"Ldd16.w=shr(Luu16.w,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional shift large vector",
+fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w=fLSHIFT(LuuV.l[i].w, fGETHALF(0,RtV)); })
+
+EXTINSN(LX_shr_h_w_uh,"Ld16.h=shr(Luu16.w,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Narrowing modular shift",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fGETHALF(0,(LuuV.l[i].w >> (LvV.uh[i] & 15))); })
+
+EXTINSN(LX_shrr_h_w_uh,"Ld16.h=shr(Luu16.w,Rt32.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Narrowing modular shift",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fGETHALF(0,(LuuV.l[i].w >> (fGETUHALF(0,RtV) & 15))); })
+
+EXTINSN(LX_shr_h_w_sat,"Ld16.h=shr(Luu16.w,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional narrowing shift large vector with saturation",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fVSATH(fLSHIFT(LuuV.l[i].w, LvV.h[i])); })
+
+EXTINSN(LX_shr_h_w_rnd_sat,"Ld16.h=shr(Luu16.w,Lv16.h):rnd:sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional narrowing shift large vector with round and saturation",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fVSATH(fLSHIFT_RND(LuuV.l[i].w, LvV.h[i])); })
+
+EXTINSN(LX_shrr_h_w_sat,"Ld16.h=shr(Luu16.w,Rt32.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional narrowing shift large vector with saturation",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fVSATH(fLSHIFT(LuuV.l[i].w, fGETHALF(0,RtV))); })
+
+EXTINSN(LX_shrr_h_w_rnd_sat,"Ld16.h=shr(Luu16.w,Rt32.h):rnd:sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional narrowing shift large vector with round and saturation",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fVSATH(fLSHIFT_RND(LuuV.l[i].w, fGETHALF(0,RtV))); })
+
+EXTINSN(LX_shr_uh_uw_sat,"Ld16.uh=shr(Luu16.uw,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional narrowing shift large vector with saturation",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFTU(LuuV.l[i].uw, LvV.h[i])); })
+
+EXTINSN(LX_shr_uh_uw_rnd_sat,"Ld16.uh=shr(Luu16.uw,Lv16.h):rnd:sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional narrowing shift large vector with round and saturation",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFTU_RND(LuuV.l[i].uw, LvV.h[i])); })
+
+EXTINSN(LX_shrr_uh_uw_sat,"Ld16.uh=shr(Luu16.uw,Rt32.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional narrowing shift large vector with saturation",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFTU(LuuV.l[i].uw, fGETHALF(0,RtV))); })
+
+EXTINSN(LX_shrr_uh_uw_rnd_sat,"Ld16.uh=shr(Luu16.uw,Rt32.h):rnd:sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional narrowing shift large vector with round and saturation",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFTU_RND(LuuV.l[i].uw, fGETHALF(0,RtV))); })
+
+EXTINSN(LX_shr_uh_w_sat,"Ld16.uh=shr(Luu16.w,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional narrowing shift large vector with saturation",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFT(LuuV.l[i].w, LvV.h[i])); })
+
+EXTINSN(LX_shr_uh_w_rnd_sat,"Ld16.uh=shr(Luu16.w,Lv16.h):rnd:sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional narrowing shift large vector with round and saturation",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFT_RND(LuuV.l[i].w, LvV.h[i])); })
+
+EXTINSN(LX_shrr_uh_w_sat,"Ld16.uh=shr(Luu16.w,Rt32.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional narrowing shift large vector with saturation",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFT(LuuV.l[i].w, fGETHALF(0,RtV))); })
+
+EXTINSN(LX_shrr_uh_w_rnd_sat,"Ld16.uh=shr(Luu16.w,Rt32.h):rnd:sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional narrowing shift large vector with round and saturation",
+fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFT_RND(LuuV.l[i].w, fGETHALF(0,RtV))); })
+
 Q6INSN(LX_zero,"Ld16=#0",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ld16=#0 to Ld16=xor(L15,L15)",
 fASM_MAP("Ld16=#0","Ld16=xor(L15,L15)"))
 
-- 
2.43.0


