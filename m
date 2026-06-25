Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B4ACDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclO4-0002sU-TQ; Thu, 25 Jun 2026 10:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNu-0002iX-NP
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNs-00009i-FB
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:54 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9js2S2009329
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=; b=ZW3Ar85rq0IdyGtQ
 eS7V3NES+CUr3maRKslPKZLETcRtK06PGMQZln2G7vTaqu8Ru6D3uj5ekK4LIOMp
 prShdJRad/3nIBsUeVfOAgPj9RUAq5LiLJZRMkjR+CPYdrQ0YuhlR6Kcupt5z2YF
 7HvLXw/9x1TXds1zA9Kli3/l28ugG/tDoXhHylNoEni32gSG/aGx1eOl+jBhhmLj
 MOyCP42yvQ2VyIBNZ/F43J5Wy4+YzVnpDsj8Affo618SH8rPQ87P2nsTBBTJ5Mc+
 1OHNDt4VMupN/Kpd+maLKhpqzN3XgjxDSWDwllPE/kAQDJVWeVolYQE4vJLsapiD
 6t2Rww==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uhmjqvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:40 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c8a940e76so783121eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398920; x=1783003720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=;
 b=FJ3f+r7QCYcX3lH3HwKKcqGiDAg43bsctvxZ0QT9jAUAtIn8hIabrvpJGTS1Zofvo+
 HB4M6xwKX6OL6UxxQAmUPmW3P99TRIm6PVrybakPmhd+qlHW37WzhsZwb/Sp3ShJe9Ea
 T0xovyC0g9jmP01iw6bLuOK3CYP8euqJaG/WiWYTYC9pK0zmMG+t9v7rFz4mAhzgjIDc
 sCPp4LnVSmAtidFO1e2TdKsEHMCeCkhZgbILI5ti0/2y+KSpVe38WiclxjHozNKftY8C
 t67WLIg6texTer6H+UwgJNNJ6+ByV8pdEWnEEv5dRf9rXkWzVAC+lw7uCNGNc5i7Ripc
 cQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398920; x=1783003720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=;
 b=ZtntCAUmUpp9Sj68iABD+dQdpvo8azvmUidG5IN2nFVG2jITXy0Q+/BYcE6Xa9ZtYo
 jrSmLCedg181RFWrHWaPzEZJQlqCSZ/LlZ43Y8Ca7ZytedvkyEvJFoQvz5dHOGSmXeBa
 cCWr3jnpyttWqNkavC2kmokP2sID1pgX+nUg/eqZIFt6+ZKQa13zMIEJs3nZyF2KtHA1
 PCorcL19L2Y7nWbJCF3P5ykiMnQGWaxUgmrhkkL0ta44cTODW45IIIT6L0TxnKJ04uW7
 Po4SkWfzO5zlMUUw7mbpklK2FP26LlLtC8+Ds9E9iExKlzvW6soxY74MBbo0OkQUO9RU
 T5/w==
X-Gm-Message-State: AOJu0YzQDtTiu54xJfOt2Lv1D69Dh0uxwdF/+V6Hfeh+vLe3q2ifu7lp
 gdcgO2MGzhgBTWAUksvanA98c6k9kQjvfxu9I/T7uGeteLtbNn0h28hu6C5eD8NHywvniY30ijz
 9eRMU/Vua/Cjj+K7/dDvN3ORAM8hqLaoBZZvjMXJjBKVJy7NIoPi+k99mu67ppD0MEg==
X-Gm-Gg: AfdE7clMl6W4j7yUjGDohHHEu0JJVgrSW+Vu8oSV/PLJYe/smiWU86U/P7F4GhutDNn
 SdbVCA1QHybHsaTpA9UTxXPsoe5IZTqsPlIxNtSSvZ1Wbt0IRNdd/ir+4k9dG5bh221oBLnsFAo
 eNZHMNjohnQwctsUuhxFvkM28oKtsc52ZCYY5ih+lMOQq05173uDNThA/wpWD+AMmnEcnftJMrE
 TzdUP1FyvwXYOoPm8E5te41VVM+kldpIKyHQp1uw9S9a/n0cuunNZ4XqhfWicsGy97TdSGzjMSA
 9aoo293Js62o7ls53a9WonFiXXcTMCDhwzzNKzMOdAynCr2AZMq7EW1PQ99VS0Vu42SZJWfzT2I
 OsOGRs73jY1mKprcHks1D7IdelhVmmLZMaAfJD1ENZT/XolyWoKIyqy/xev0=
X-Received: by 2002:a05:7301:a88:b0:304:4f23:4466 with SMTP id
 5a478bee46e88-30c84be5889mr3191575eec.15.1782398919975; 
 Thu, 25 Jun 2026 07:48:39 -0700 (PDT)
X-Received: by 2002:a05:7301:a88:b0:304:4f23:4466 with SMTP id
 5a478bee46e88-30c84be5889mr3191548eec.15.1782398919363; 
 Thu, 25 Jun 2026 07:48:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 61/76] target/hexagon: Add implicit sysreg writes
Date: Thu, 25 Jun 2026 07:16:18 -0700
Message-Id: <20260625141633.449487-62-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=cqerVV4i c=1 sm=1 tr=0 ts=6a3d3fc8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ySlkKLH3HnL0fBWr2zQA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX8oDi4psKfx06
 onM7yo3jBFOzXDJgbTXFVLPavLphwOCgwLr+C3jQA7bbskYzJh1Y54g2qf+sp+kTG/mTJLegbR4
 vfiYhG/CuUNaCYWszm/F1v9AnRLY6+lXXyWonxrr/XvZnHMUXHNOceTTF9jPDSpI/Gt2ai4nnMv
 2NKuQuHvag0+5mJz108idiRJsDxLlc2X/7TzQIXQPEXS/aY7No3rrUvaY8hhYr9j7cIgec+C+ND
 EfC92LsxSQGu+1j+xc9RpFbzpIT4UOxhTVg5r8oPycFpAqXxoOycAY6idna/V0WL7qfMd2+xQMc
 5XOi/MGHejyFsYZ1lhVC8/6ZE6W7m8xIZ98L+9Wqopzp4Qu/NOy2Ju2HUW8+cEXP+KLrKwwvESK
 6OX25HCMR+amc7itqMyysxgY138vLmGoImWH+tDaqluBflO8jKvrO121dvge73RcSKnawEweb/X
 tMinT2LSppB9D78fQMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX8Akm75POmxlG
 1LlnMbTsVOV15D7cUoU8HOl1eiRsKIs/Q2UjReus+oiZvM65znHB5hHWRd9bHnssEBIALDi8K+j
 Rg1qXStmS1xnK61bGOAwAz+ulx3O1h8=
X-Proofpoint-GUID: V53O0Qjk4y-o2UguRNtq9-CnWV_ppyTI
X-Proofpoint-ORIG-GUID: V53O0Qjk4y-o2UguRNtq9-CnWV_ppyTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250127
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jIHwgMTYgKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGY0YTM1Mzk1OGZmLi5mNTQ1MGNlZDdkZSAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKQEAgLTQyNCw2ICs0MjQsMTYgQEAgc3RhdGljIHZvaWQgbWFya19pbXBsaWNp
dF91c3Jfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBhdHRyaWIpCiAgICAgfQogfQogCisj
aWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIG1hcmtfaW1wbGljaXRfc3JlZ193
cml0ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IGF0dHJpYiwgaW50IHNudW0pCit7CisgICAgdWlu
dDE2X3Qgb3Bjb2RlID0gY3R4LT5pbnNuLT5vcGNvZGU7CisgICAgaWYgKEdFVF9BVFRSSUIob3Bj
b2RlLCBhdHRyaWIpKSB7CisgICAgICAgIGN0eF9sb2dfc3JlZ193cml0ZShjdHgsIHNudW0pOwor
ICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMo
RGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgbWFya19pbXBsaWNpdF9yZWdfd3JpdGUoY3R4LCBB
X0lNUExJQ0lUX1dSSVRFU19GUCwgIEhFWF9SRUdfRlApOwpAQCAtNDM2LDYgKzQ0NiwxMiBAQCBz
dGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMoRGlzYXNDb250ZXh0ICpjdHgpCiAK
ICAgICBtYXJrX2ltcGxpY2l0X3Vzcl93cml0ZShjdHgsIEFfSU1QTElDSVRfV1JJVEVTX1VTUik7
CiAgICAgbWFya19pbXBsaWNpdF91c3Jfd3JpdGUoY3R4LCBBX0ZQT1ApOworCisjaWZuZGVmIENP
TkZJR19VU0VSX09OTFkKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJ
Q0lUX1dSSVRFU19TR1AwLCBIRVhfU1JFR19TR1AwKTsKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdf
d3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TR1AxLCBIRVhfU1JFR19TR1AxKTsKKyAgICBt
YXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TU1IsIEhFWF9T
UkVHX1NTUik7CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQgbWFya19pbXBsaWNpdF9wcmVkX3dy
aXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgYXR0cmliLCBpbnQgcG51bSkKLS0gCjIuMzQuMQoK

