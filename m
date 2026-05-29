Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8BFCD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Df-0003ev-Bg; Fri, 29 May 2026 17:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5De-0003Um-3y
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dc-0000qZ-7U
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2Pia1912450
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s1PQwc3EWBskqrO8WaBE8ES2PeyNfuiHhDMrAGd0t2s=; b=grY02eOKvhrmzBse
 T8I24YJ96mO02VC/M2etwJhPQgruBObH5/lCFE833GaeMXaGi+BBUqTZJY1T0YOW
 6CLZ4592mEtNYCfydwMvpMKPcU/DVV4neqQIpt7F7gOXgOQRC32JA7Zqui3it+EK
 iL0FORh54vrqK6zjXrCArNzaQnArgVnPkvQTjNECniSM72eqHtLNr78vgpfY92b2
 DCGMFReS/zYIjSS95lOT+VeuDNW+zbdtirU284Q6GQ1/t1uBZ73OGxsscREWk6vl
 eOvX0+biXOk8k9FmzV45WeIhxmQP7dsOp3oz7vNpllsk2Ob8cgWfmvqOxPqyK2OX
 9j6Y4A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efbu52gr1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304e4636205so3327453eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091894; x=1780696694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s1PQwc3EWBskqrO8WaBE8ES2PeyNfuiHhDMrAGd0t2s=;
 b=YKuGKSJROamTtVkr8MYc4838bGnV6EaQYCKaZlKBEXLNdov6splDGPP+kb9C+yszEj
 GQxhLpGWSqSMVsvC+dTBA6CFZT6NhC8h23ZtlLK2qreWAsuerXuMcVU566Vm8b/ti8Lv
 2YLtU3eOUt0HqS0/45+Rm+oaX6kkB2WgBiDrXuc3zR5ttTvnFFTNxNeDY2VJSN1O2zxS
 6A076+MDTbJWWb2ka4cRtdzBE/8lIZfUB6p4ZPf6OYvNVYD6I0anoJknEWTwDTktkYcZ
 LMsd1LYOtbo6ABQRpLarX2i+QcpAjgTr3QppKOBjx1QzWBRhICNhXXdmbI5UCGOcLF8l
 u9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091894; x=1780696694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s1PQwc3EWBskqrO8WaBE8ES2PeyNfuiHhDMrAGd0t2s=;
 b=pkiHMHUwuKHjpbU93UplI3z15vZbWjMrw+GrsLjbuwl9HKTTkQkx/jqDm2P1al9JX/
 4ge1STIOoFCqEkx7zuzYF/C3WBuWNMQg4Knw5J5jd7pJAUakMKULQ5NhTu0AnESJzAGA
 KJsT2RoK0Lxn0I+YXVxInivrp/sEaV0HofN4R8x9+6S9B+f0yi8ESXPrazKYI//n5uU9
 wMnXouK4LsG8k6c4Zec/2L5sKM2/nmDfb5QnV16+9+dYG5T0Djd/pboroOSnALW5+psL
 7GneJ+R8RK5DXNygLumOoVUgv99HbgxMt2AP3xEFgipWYu18etXtWWJRK35ZbnlUfWVd
 jycw==
X-Gm-Message-State: AOJu0YwAc7ViqPUxymUBNvYKXHvcn9L9eVz8CCAFKhFelHjSu9tX1zpo
 UCBuQ8jdfy0LIg2az54R1++NTlaoMrpkqXuzQwFygnGCcPwfpA3xOXfIJFkvYOOn679JaYVJt5N
 Q4hJCMj0gp6Ru1Q0r75M8skk09SmgjTJK/u7WL4XmoLKmGoOt6Vkq1N2W7v1cKR7XEQ==
X-Gm-Gg: Acq92OFq3cabckF98BrGPSPgbsrckcmrITijLt+yVBcDrlc6qouKMARrkc6sob1CZaw
 qQTqDnonF2jZC5qP6z5jwXeQcd6a+8FwTGvPvrZ88MzyQUA4k5Zn7QF5aQIreSb8iubYWTIDsuw
 ZmIQUlPl0CuENikKurTOjUaDzkXz6cziAfCpJYro8Q081uVBwNr4S4bu7ASWKUqmLcxk6BeeosK
 xKLgM7pNidAjHcTn1TWgsLjL4n7gUX6rMW9gLfcZc54obDFy0D7beSjoH9Jwp6fDkDi8UAgYG3D
 5hs3yHXB/ErI1pDTTh6rFlK8BjeKMq5pCRhs6gnuSuuBBCGpJy3fCHg5I6POyzm5yJbtz7wEu1m
 8xxqgypf9fjxdG64WepwpToC4GHoseOrHNQyA5ccD6XjUhybx2zt5soPrMd5Bhn26kd85NGohG3
 tthLJO
X-Received: by 2002:a05:7301:fa06:b0:304:6448:dfea with SMTP id
 5a478bee46e88-304fa774efbmr848034eec.33.1780091894066; 
 Fri, 29 May 2026 14:58:14 -0700 (PDT)
X-Received: by 2002:a05:7301:fa06:b0:304:6448:dfea with SMTP id
 5a478bee46e88-304fa774efbmr848015eec.33.1780091893515; 
 Fri, 29 May 2026 14:58:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 03/28] target/hexagon: Implement start/stop helpers,
 soft reset
Date: Fri, 29 May 2026 14:57:41 -0700
Message-Id: <20260529215806.608770-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=SMRykuvH c=1 sm=1 tr=0 ts=6a1a0bf6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mCWuZxMSpaUKZHDxuVkA:9
 a=gIRNa_MW_fgC-PB2:21 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: LG4g_6fYt_WkP0jInHzMH-M6kTIUuwCE
X-Proofpoint-ORIG-GUID: LG4g_6fYt_WkP0jInHzMH-M6kTIUuwCE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX29H/C92itasq
 nJl67Kaf0QYXETpnz6pX8OXwmYgT0q5gZf23vAiVSjrxqjpXIRrsohlmE7t66a+moNZYttQ7MjG
 P9kVYsJBuz1D/sj/Q0WtYlzVo3t3tpISeuyhQ23L+PnVNRMGXzo+R3NgkFr2w1NGh8Dxk0oIECJ
 WxhokOAvD4YEg+WCFXM8Zp4VLFYFVdB2MWRyQ7BaG3XQFFbnPctl0S+0vOb+r78CJgoUxXaMedA
 nx2I+x364mAN1SCu4GjZJWjNQTSueZZ5t5lQFMwk3Z/H4uC5H2ZACxk8GpsfTkzDOEq/N4abrqU
 YoLQnYZAdceZlz75mYxFWC4zs0z9RMdU5/hN0AI0EMIfSYQqyIgLvQB6X/zhyRQlx03o8BeIzDL
 whFqppzsdi3WuOyVRZ2O8FW7gq+/znek+gZ+8w3kixILJg2ktYXGfKN5gMcgz7XmYoiChZBIX1O
 ScPqxBNBR6qSkLdJfDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1LmggICAgICAgfCAgOSArKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgIHwg
MjggKysrKysrKysrKysrKysrKysrKysrKysrKystLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMgfCAgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdv
bi9jcHUuaAppbmRleCA5ZjQ5MzI5NjAwYS4uMjk5Y2JkOTJkZGMgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0yMTUsNiArMjE1
LDE1IEBAIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIoQ1BVSGV4
YWdvblN0YXRlICplbnYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnQzMl90IGV4Y2VwdGlvbiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludHB0cl90IHBjKTsKIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisv
KgorICogQHJldHVybiB0cnVlIGlmIHRoZSBAYSB0aHJlYWRfZW52IGhhcmR3YXJlIHRocmVhZCBp
cworICogbm90IHN0b3BwZWQuCisgKi8KK2Jvb2wgaGV4YWdvbl90aHJlYWRfaXNfZW5hYmxlZChD
UFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYpOwordm9pZCBoZXhhZ29uX2NwdV9zb2Z0X3Jlc2V0
KENQVUhleGFnb25TdGF0ZSAqZW52KTsKKyNlbmRpZgorCiB0eXBlZGVmIEhleGFnb25DUFUgQXJj
aENQVTsKIAogdm9pZCBoZXhhZ29uX3RyYW5zbGF0ZV9pbml0KHZvaWQpOwpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBmNWE1M2Q3
MzliOC4uNGFlMDU3Njk0MzggMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBi
L3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0zMyw2ICszMyw3IEBACiAjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKICNpbmNsdWRlICJzeXNfbWFjcm9zLmgiCiAjaW5jbHVkZSAiYWNjZWwvdGNnL2Nw
dS1sZHN0LmgiCisjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCIKICNlbmRpZgogCiBzdGF0aWMg
T2JqZWN0Q2xhc3MgKmhleGFnb25fY3B1X2NsYXNzX2J5X25hbWUoY29uc3QgY2hhciAqY3B1X21v
ZGVsKQpAQCAtMzEwLDYgKzMxMSwyOCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX3Jlc3RvcmVfc3Rh
dGVfdG9fb3BjKENQVVN0YXRlICpjcywKIH0KIAogCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkK
K3ZvaWQgaGV4YWdvbl9jcHVfc29mdF9yZXNldChDUFVIZXhhZ29uU3RhdGUgKmVudikKK3sKKyAg
ICBIZXhhZ29uQ1BVICpjcHU7CisKKyAgICBCUUxfTE9DS19HVUFSRCgpOworICAgIGVudi0+dF9z
cmVnW0hFWF9TUkVHX1NTUl0gPSAwOworICAgIGhleGFnb25fc3NyX3NldF9jYXVzZShlbnYsIEhF
WF9DQVVTRV9SRVNFVCk7CisKKyAgICBjcHUgPSBlbnZfYXJjaGNwdShlbnYpOworICAgIGlmIChj
cHUtPmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgdWludDMyX3QgZXZiID0KKyAgICAgICAgICAgIGhl
eGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19FVkIsCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQpOworICAgICAgICBl
bnYtPmdwcltIRVhfUkVHX1BDXSA9IGV2YjsKKyAgICB9IGVsc2UgeworICAgICAgICBlbnYtPmdw
cltIRVhfUkVHX1BDXSA9IGNwdS0+Ym9vdF9hZGRyOworICAgIH0KK30KKyNlbmRpZgorCisKIHN0
YXRpYyB2b2lkIGhleGFnb25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0
eXBlKQogewogICAgIENQVVN0YXRlICpjcyA9IENQVShvYmopOwpAQCAtMzM5LDkgKzM2MiwxMCBA
QCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5
cGUgdHlwZSkKIAogICAgIGVudi0+dF9zcmVnW0hFWF9TUkVHX0hUSURdID0gY3B1LT5odGlkOwog
ICAgIGVudi0+dGhyZWFkSWQgPSBjcHUtPmh0aWQ7Ci0gICAgZW52LT5ncHJbSEVYX1JFR19QQ10g
PSBjcHUtPmJvb3RfYWRkcjsKLSNlbmRpZgorICAgIGhleGFnb25fY3B1X3NvZnRfcmVzZXQoZW52
KTsKICAgICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfRVZFTlRfTk9ORTsKKyAgICBlbnYtPmdwcltI
RVhfUkVHX1BDXSA9IGNwdS0+Ym9vdF9hZGRyOworI2VuZGlmCiB9CiAKIHN0YXRpYyB2b2lkIGhl
eGFnb25fY3B1X2Rpc2FzX3NldF9pbmZvKGNvbnN0IENQVVN0YXRlICpjcywKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMK
aW5kZXggN2U2ZTA0ZTUxMmEuLmEyOGVkMDYxNDEyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQ3OCwx
MiArMTQ3OCwxMiBAQCB1aW50MzJfdCBIRUxQRVIoaWFzc2lnbnIpKENQVUhleGFnb25TdGF0ZSAq
ZW52LCB1aW50MzJfdCBzcmMpCiAKIHZvaWQgSEVMUEVSKHN0YXJ0KShDUFVIZXhhZ29uU3RhdGUg
KmVudiwgdWludDMyX3QgaW1hc2spCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAg
ICBoZXhhZ29uX3N0YXJ0X3RocmVhZHMoZW52LCBpbWFzayk7CiB9CiAKIHZvaWQgSEVMUEVSKHN0
b3ApKENQVUhleGFnb25TdGF0ZSAqZW52KQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7
CisgICAgaGV4YWdvbl9zdG9wX3RocmVhZChlbnYpOwogfQogCiB2b2lkIEhFTFBFUih3YWl0KShD
UFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKQotLSAKMi4zNC4xCgo=

