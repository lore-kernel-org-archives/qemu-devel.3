Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE30C10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYPK-0000vQ-7B; Wed, 08 Apr 2026 15:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAYMs-0006x7-Or
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:15:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKQR-0005ig-2r
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:22:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637NflVw1259505
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eS5ihb8Q3Wz0SkTdk6wjG+t9ylH9RVSPrzx1RphpHuQ=; b=hy8m0qKKTi4muGWi
 UCRLuYf59DEmEoHiFAaXmC/yqDLAcWz0GpQGy4OorQLHvLmiLUUEJkRviCAk+EoK
 jFLUsJzApHEiQwBWUSnnjo9p0Lc4DOLoGo7rueTVR/U2oEs/33q9JP5XMhyD2Sdp
 7uEPHrCcctMjrYRBeaK3lCWYRcPMgkdb8gsGAihtjVyGncbPPldpn4wxLI6BXOw2
 2Zs3K9hu3Yi3fRh/LVwrkVpTVFdhQoHE4EvmSC3lc4pj4ClLX5oOV+nzaS4A+S2v
 BbUri8UhD3FGOVyJEwowercAYcz93s+8RN5zZPZXORuOAbRAFYMr3HzosK3vcj17
 aOYS/g==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddbttrquk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:21:57 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12c20d5d7f4so1170906c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622117; x=1776226917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS5ihb8Q3Wz0SkTdk6wjG+t9ylH9RVSPrzx1RphpHuQ=;
 b=eF2qFOG2qRC2b22KGmbMZvvC7Ldnycfn/zfv4BMaddZrGLe2NFl60LKcWkCOvMkcIW
 dHAHzRGBPuabARK/YBl2e5W7QYtfPt3C6TaKJJz7ZmSfcnMNsj0+lmKGpN34bv1NYVQq
 PX+Chp4J7sz7uJPPz11XCJEaGv7PTWXxpGNxswf2wH9KL4MiG8xP6UtJbjWfmFVo7pot
 IRVwav2hOuKA7wpaiNlh6FvfQ9HC+YZl7mUJs+AWY8C/7OAls0pTDIwpidv0OOn2nA7z
 oKHTbJVbaQFZoZgAFe5JvhJLUY/JBz08Q7A7hOHT4oAR4YhQM7hEjLhf6hJ0pKk4Qb77
 ruAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622117; x=1776226917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eS5ihb8Q3Wz0SkTdk6wjG+t9ylH9RVSPrzx1RphpHuQ=;
 b=s1QvLb/2KAH4fcZIs9h8eJX2Ai6TO80lcVDa8lhVKz3qBRFISSq8xpGtHcvvTZ9z2W
 v2udsc7ZTHo7IQzwyxmarkYWUJMyTdcpEZrA/4r4rsv34sDNRoeLrWlHoOZFYvu6zt4n
 HBmP5Ei3ls7kVkzcy28puJfOH/tSt1KE31CxX0Mflhx8lbTYF/du0polqUzmTlOzI43g
 WNOsdr13/c0h2IyHabHYCAFBuvqLmi7BnAHhoV/3cDFXE23TpnyJyTtYfuSG/hOQPua6
 hoNZwfjavuGvmHdgUSTvYBk+7o7njGO7SfCpBPjujGWq6pmA3tAaubC5lmixqBByzpEw
 N3ag==
X-Gm-Message-State: AOJu0YxwC0SAyAeuJ8OcLXd6NgNxnvV3wFC8wJ/kDhjGhCLOZIDrar2N
 7Vyg7f1XSGcjbjC9nPFIK0zSe7tHC2T90knZUoS7XHSoWZozAztzPZkRK4t1hheuqrd4Hv8vSL8
 A+uoPoI3zBPS91wMa3nw7XkMyzhdxvQ738RDFJtlY4ApwliC02lq0KLqFQ6tsOtL2fw==
X-Gm-Gg: AeBDievVBLQmd/g+7723Gwn4NV6LhGHoRNXjy7qvJMi7KQVcyEfPWQA5uhXf769i0st
 xCO1FmPBVQEmb0TREl0yfRH1IEQzrJCVCTtKxqMLDJPwrvDcIO2/H93Gyj/+tJUxzGHXmMuLVtJ
 O8u2RfLAMd1dU+ejTJj7L7v4PKDVxgTYibBx+HX8qqUilvfaq7KXbqqSz2aF9MHOTQP7PzzNI/7
 pAJpFtOlgWLP2+whjcQDllbDvYdFd1uZhO8tCs6GepUdbb+7Ba3S7xhZipZPWuGg+hHUjTkhyuN
 ygV7ufqzAwLunf+0PPZyuGUbxdhkvz8PIY5vXLdLyZQiQu6vsoDaXxIPjk3B3al7VThd0nPH/6M
 rlIOa3Yci6oDMk+jGQRbbXVc7N2QB/68bvPMMzgDfWhrBrXJ7xOZIyUsfV9INpGRYHHpYIw==
X-Received: by 2002:a05:7022:3d0b:b0:12a:6fbb:3353 with SMTP id
 a92af1059eb24-12bfb6e8cd5mr11223840c88.3.1775622116839; 
 Tue, 07 Apr 2026 21:21:56 -0700 (PDT)
X-Received: by 2002:a05:7022:3d0b:b0:12a:6fbb:3353 with SMTP id
 a92af1059eb24-12bfb6e8cd5mr11223817c88.3.1775622116235; 
 Tue, 07 Apr 2026 21:21:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bed93f861sm23474816c88.0.2026.04.07.21.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:21:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Sid Manning <sidneym@quicinc.com>
Subject: [PATCH v4 5/9] hw/hexagon: Add support for cfgbase
Date: Tue,  7 Apr 2026 21:21:44 -0700
Message-Id: <20260408042149.1902796-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
References: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: C8SXoq6XzrLrxDqJB0VGeoOIEgNFhwk6
X-Proofpoint-GUID: C8SXoq6XzrLrxDqJB0VGeoOIEgNFhwk6
X-Authority-Analysis: v=2.4 cv=TOt1jVla c=1 sm=1 tr=0 ts=69d5d7e6 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=kMsUHo8U3t7WCeOG3PUA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX1635zT5QLhIV
 2XXaggDjFEPVA1y2P6vkmtKGt7LZijsC44fWxDNrBFnl55pK6yoltQGQ5wfdq3IRncsFiE7WX5D
 wJ0G+3oTFWX5iJAasbmgt4whkQt5NoY5a7snbaDdFT/b288spuf1AiZHvotpDTtgcu0WadTbhAW
 lLhHvXkW3XmGILv8NC9HZXBziN1RM37eFdFrQd9qhYdsnEppqiCeKzhUeYn1hU5W10tZZSLPeJX
 mVEjtuseoUt1b36huNZ2q7+qQzEqCxzc5RCqsUYQEiJSjb2ErVgCDc49evWqUCBfotdRFwtKke3
 RLBH/FrtxFGizCl/0fnUU5V3fnSVhv4O6S+9kDa4YT9rOdz5HFuxNpiFOUPufHn/GGZy6XhjGUg
 iXFm5my9tabzFwMc8vXw1PlKjmGADzuhv9Yj0B3mOCYryogfwTWbMtpyPq9x44xiK8wkRNvZqlk
 kuyT2B3mfOAfcffG+Lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5
bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU2lk
IE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+Ci0tLQogaHcvaGV4YWdvbi9oZXhhZ29uX2Rz
cC5jIHwgMTEgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICB8ICAxIC0KIDIg
ZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYyBiL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYwpp
bmRleCBkNWRmODc2MDVmNC4uNjQ5Y2FmY2Y4ZWMgMTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4
YWdvbl9kc3AuYworKysgYi9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMKQEAgLTczLDYgKzczLDcg
QEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jb21tb25faW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUs
IFJldl90IHJldiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0
IGhleGFnb25fbWFjaGluZV9jb25maWcgKm1fY2ZnKQogewogICAgIE1lbW9yeVJlZ2lvbiAqYWRk
cmVzc19zcGFjZTsKKyAgICBNZW1vcnlSZWdpb24gKmNvbmZpZ190YWJsZV9yb207CiAgICAgTWVt
b3J5UmVnaW9uICpzcmFtOwogICAgIERldmljZVN0YXRlICpnbG9iX3JlZ3NfZGV2OwogCkBAIC04
Niw2ICs4NywxMiBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NvbW1vbl9pbml0KE1hY2hpbmVTdGF0
ZSAqbWFjaGluZSwgUmV2X3QgcmV2LAogCiAgICAgYWRkcmVzc19zcGFjZSA9IGdldF9zeXN0ZW1f
bWVtb3J5KCk7CiAKKyAgICBjb25maWdfdGFibGVfcm9tID0gZ19uZXcoTWVtb3J5UmVnaW9uLCAx
KTsKKyAgICBtZW1vcnlfcmVnaW9uX2luaXRfcm9tKGNvbmZpZ190YWJsZV9yb20sIE5VTEwsICJj
b25maWdfdGFibGUucm9tIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihtX2Nm
Zy0+Y2ZndGFibGUpLCAmZXJyb3JfZmF0YWwpOworICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJl
Z2lvbihhZGRyZXNzX3NwYWNlLCBtX2NmZy0+Y2ZnYmFzZSwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29uZmlnX3RhYmxlX3JvbSk7CisKICAgICBzcmFtID0gZ19uZXcoTWVtb3J5
UmVnaW9uLCAxKTsKICAgICBtZW1vcnlfcmVnaW9uX2luaXRfcmFtKHNyYW0sIE5VTEwsICJkZHIu
cmFtIiwKICAgICAgICAgbWFjaGluZS0+cmFtX3NpemUsICZlcnJvcl9mYXRhbCk7CkBAIC0xMTQs
NiArMTIxLDEwIEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY29tbW9uX2luaXQoTWFjaGluZVN0YXRl
ICptYWNoaW5lLCBSZXZfdCByZXYsCiAgICAgICAgIH0KIAogICAgIH0KKworICAgIHJvbV9hZGRf
YmxvYl9maXhlZF9hcygiY29uZmlnX3RhYmxlLnJvbSIsICZtX2NmZy0+Y2ZndGFibGUsCisgICAg
ICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihtX2NmZy0+Y2ZndGFibGUpLCBtX2NmZy0+Y2Zn
YmFzZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KTsK
IH0KIAogc3RhdGljIHZvaWQgaW5pdF9tYyhNYWNoaW5lQ2xhc3MgKm1jKQpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBiZDNlZWMw
ZDUyNS4uOTg4M2M0ZDE2ODEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBi
L3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC00MDQsNyArNDA0LDYgQEAgdm9pZCBoZXhhZ29uX2Nw
dV9zb2Z0X3Jlc2V0KENQVUhleGFnb25TdGF0ZSAqZW52KQogfQogI2VuZGlmCiAKLQogc3RhdGlj
IHZvaWQgaGV4YWdvbl9jcHVfcmVzZXRfaG9sZChPYmplY3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUp
CiB7CiAgICAgQ1BVU3RhdGUgKmNzID0gQ1BVKG9iaik7Ci0tIAoyLjM0LjEKCg==

