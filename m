Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D183ACDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndN-00036M-4A; Mon, 22 Jun 2026 19:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndJ-000346-J9
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndH-0002ZP-Rz
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:49 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZdxq1629244
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=; b=oUuVGNT6V5IBHc0t
 HH0Y4MCwcDlHv6Fd/YcZ+dCAR1/wheoKxCTTObIupYGMzcpYGlfpD4SQbSaujflf
 +wt6Ok30w4fGdx0ZB1tMYlGfCsVpPeO7+44v+DzbscAA2xYkxYx3w2DtZmHXLOuf
 AYqZh7/RuEUXGIAniFnKvkbWCmh6C8kSx4Dh7YHYSbxMEp1YiacswIMzWQPiSA08
 NNz0Y1ALHnVEt+cqqWNAf3aEiRXVeB/ach1XbyF2X9nIEfuAvRk17/Fp5IpJhNuz
 ZhTDslf1eWQdFaH9FQK6w0YRAIUYJ+V1uuqZ9kQsEpQbDqIClYqJL6wcUqBKf8Nq
 3fBy1Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3cq2hah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:45 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139553dd8acso21359325c88.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169245; x=1782774045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=;
 b=OSB3nAoF46fDvo8ahcZfwjcrlF/JPCijnEE17LOwph+QPmCwS3gvnSzm7NEzodj9PQ
 58daMr8uIeJ7EZxfdyAZ8oDb7q+euXv2GLgR1OQZXTpvPnJvt6oEKfDWxpDOvyUOoSUO
 Tc+PsQ9YL1JKzo8bBfMV86XP+Bf3sShf1P+txYKoqiuuGFFf9mNJw6jee4ejeDrVXnvJ
 BaSGQWBretfkb7GtJhbPp5dQFAhvaMfofhxGpvq6Li59jlo/y6jBLMQBPvhkXidmlxwN
 kNnpSuwXbyLFywy3vYDzESNYHoQYOckg6lvb/YNBkmHHT4zNSufhlsNJkvJe5gSAG/gh
 0I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169245; x=1782774045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c10dnjx3jWBtOFG53LaPJvlCxFR1rsBjBNQjpvdRffY=;
 b=G1h41dtqHb2FDzDm7Dg0DDfQcKr0dBoUIQt9h+OF1vzP/2ob3r2SlnQkmka3F4vPYY
 2P4h0gBXW7u7QEHwif5qJH3LIfEPRzpiCxpYS+TGU/xX/Zjn9jT5VJoxIaU+lL7iMtmM
 pJ50Dxmo3sQvKgNunltVmCZFnLc4JzGVfDAblQPodRe4ZMnUv+EEEJ9Db48W4tbhrLgm
 VbY6eQlCDRQHxCFbgHTRgzb2moLJ5HLFDyZGvPJ7D1558P/5Kh9htqmqlEaSJeg3fy7z
 +yb9FVQHMD6CfIezmuu7cdM21ht3xdkiJVDqhdGdVRsP+/ZvXdvm/FG3JK2bJDx+ocLK
 mj0Q==
X-Gm-Message-State: AOJu0YyUHGG//dWwZQeDQux/5liQZi+XvWQRLin0I2HSbQA67YWKtc5+
 VGhkTFT0bx556RAp4XKviljkNt+pT1oRJx6gs2iE1Xbpx44OdfoOL82HHpStJMiLXimrD8x98fF
 tzLl2/2jV3JaH3mPyktRVWH3fjGY7ckbPHjzhcf9atOillceOaJAkyBsTrmLehw/WHg==
X-Gm-Gg: AfdE7clfHrbcDXRwm6crxzdhAtjamkah/rhFfv0Ad5czxYPY9kfrsZQg9R7ISL2VxLU
 jFHVwrUwSMtV387YO9LH4LecJ9Zyc5KfxqB1jC/6Rm4ilpz+oqVsCVkBBhhEt8h2RPpxj5AgDye
 hnPkbk54dx3UTpsT/kUWu0OkfSz0yAnLj5OUzFpOHc/FNxHpc3mfgDgsSg3D8ebrvqbeZXhJool
 Tgl+9OC7Moe5vcocenwOELTB2QxaOJF/ArHXvFtl9jEdxDzPczGBn0ZkGNlhS2bCRem0EAKeKpW
 7ndwTfiGO9/pd9J8EgarcvJymoRoosGC1QXJuf8JXEx3XasBWsut8qu7duhyoQr5Leyp9kOWNOp
 bwK3jlZX+oPBImxKONcMkrA1wY+Uo8ZOGLFXKT2CbhtCTwQ3JWwEICMiOzsE=
X-Received: by 2002:a05:7022:623:b0:138:364e:3213 with SMTP id
 a92af1059eb24-139a34f5263mr10257022c88.14.1782169245284; 
 Mon, 22 Jun 2026 16:00:45 -0700 (PDT)
X-Received: by 2002:a05:7022:623:b0:138:364e:3213 with SMTP id
 a92af1059eb24-139a34f5263mr10257000c88.14.1782169244637; 
 Mon, 22 Jun 2026 16:00:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 65/75] target/hexagon: Add guest reg reading functionality
Date: Mon, 22 Jun 2026 15:28:54 -0700
Message-Id: <20260622222904.607771-66-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: LL7YSUzAbEnXbgkU104Jqr2V2QJ8GJiZ
X-Authority-Analysis: v=2.4 cv=VKXtWdPX c=1 sm=1 tr=0 ts=6a39be9d cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=IJQQmebJWjVxhimlKuwA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: LL7YSUzAbEnXbgkU104Jqr2V2QJ8GJiZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXyeF/2J8yBqYu
 w/uESA0G+bvm0X/lCFEZFdNBrH/szd2vrO36aCGKvq/t0A97sdZ0utpRZv/69lj6O+6feLVZEzq
 c7Ua7rxwYBulOe0+WPxBaoQ+oqe7qlwUL1Jz+PmF0jHeyfx9TvMj9pmlskok9+i9znWBOXPFVWJ
 BES4svPYdRf1m8nQiF8nqZAiflgnuOGTcuT8QxB3lZ7476LIHb8UGT8I5Exh6WMn+DfkeEyoICu
 s8SQIYrRYjZcIztflvmB7FeZPyyxSGNIukmF7XdWMwPe7nAWYehbvd5MIzO4MqRTUhbt/y1a0ef
 iGWnOGdkZltJBzU4Hy2LiAIc/95L6gTUUgz01Q51hZENdN9SFNTiWQk8RTM2Dxq+Qze1MfqVlVM
 iElVNmAJfu0C6J3v7Ycbg8vxkuaRpZj+DtGwGtFrWCb9Y66nlfC+vmPmT0J9gufq/jUM2suopQe
 xa2dRFO7uMcqRZIvMLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX1vOMUpjIPfYW
 l7azNpLK2xcJCAKallljV329dS2JbKtZD8cWXKMwx2QPRflnnuW3kPkBRedMsvHCJgIndY+txue
 ZimwKMSge417CN1B56uBkhw2P9uPqGU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220221
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b20+CgpTaWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8cXVpY19tYXRo
YmVybkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2lt
cHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICB8ICAxICsKIHRh
cmdldC9oZXhhZ29uL2NwdS5jICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMgfCAxNiArKysrKysrKysrKysrKy0tCiAzIGZpbGVzIGNoYW5n
ZWQsIDM0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCA2YTk1YTZiYzViMS4u
NGExMmRjMDQ3MjcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oCkBAIC0yMjAsNiArMjIwLDcgQEAgR19OT1JFVFVSTiB2b2lkIGhleGFn
b25fcmFpc2VfZXhjZXB0aW9uX2VycihDUFVIZXhhZ29uU3RhdGUgKmVudiwKICAqIG5vdCBzdG9w
cGVkLgogICovCiBib29sIGhleGFnb25fdGhyZWFkX2lzX2VuYWJsZWQoQ1BVSGV4YWdvblN0YXRl
ICp0aHJlYWRfZW52KTsKK3VpbnQzMl90IGhleGFnb25fZ3JlZ19yZWFkKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCByZWcpOwogdm9pZCBoZXhhZ29uX2NwdV9zb2Z0X3Jlc2V0KENQVUhl
eGFnb25TdGF0ZSAqZW52KTsKICNlbmRpZgogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9j
cHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IGIzNWNhYWVjZmFlLi4wNmJlNWM4ZDQ5
OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKQEAgLTc3MCw2ICs3NzAsMjUgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfY2xhc3Nf
aW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0YSkKICNlbmRpZgogfQogCisjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKK3VpbnQzMl90IGhleGFnb25fZ3JlZ19yZWFkKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCit7CisgICAgaWYgKHJlZyA8PSBIRVhfR1JFR19H
MykgeworICAgICAgICByZXR1cm4gZW52LT5ncmVnW3JlZ107CisgICAgfQorICAgIHN3aXRjaCAo
cmVnKSB7CisgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFTE86CisgICAgICAgIHJldHVybiBoZXhh
Z29uX2dldF9zeXNfcGN5Y2xlX2NvdW50X2xvdyhlbnYpOworICAgIGNhc2UgSEVYX0dSRUdfR1BD
WUNMRUhJOgorICAgICAgICByZXR1cm4gaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9oaWdo
KGVudik7CisgICAgZGVmYXVsdDoKKyAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsICJy
ZWFkaW5nIGdyZWcgJSIgUFJJZDMyCisgICAgICAgICAgICAgICAgIiBub3QgeWV0IHN1cHBvcnRl
ZC5cbiIsIHJlZyk7CisgICAgICAgIHJldHVybiAwOworICAgIH0KK30KKyNlbmRpZgorCiBzdGF0
aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19iYXNlX2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0
IHZvaWQgKmRhdGEpCiB7CiAgICAgSGV4YWdvbkNQVUNsYXNzICptY2MgPSBIRVhBR09OX0NQVV9D
TEFTUyhjKTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggOGEzNzIzY2JhZmEuLjEyNTk1MmFlZTU5IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYwpAQCAtMTg3OCwxMyArMTg3OCwyNSBAQCB1aW50NjRfdCBIRUxQRVIoc3JlZ19y
ZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCiB9CiAKIHVpbnQz
Ml90IEhFTFBFUihncmVnX3JlYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcp
CisKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHJldHVybiBoZXhhZ29uX2dy
ZWdfcmVhZChlbnYsIHJlZyk7CiB9CiAKIHVpbnQ2NF90IEhFTFBFUihncmVnX3JlYWRfcGFpciko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKKwogewotICAgIGdfYXNzZXJ0X25v
dF9yZWFjaGVkKCk7CisgICAgaWYgKHJlZyA9PSBIRVhfR1JFR19HMCB8fCByZWcgPT0gSEVYX0dS
RUdfRzIpIHsKKyAgICAgICAgcmV0dXJuICh1aW50NjRfdCkoZW52LT5ncmVnW3JlZ10pIHwKKyAg
ICAgICAgICAgICAgICgoKHVpbnQ2NF90KShlbnYtPmdyZWdbcmVnICsgMV0pKSA8PCAzMik7Cisg
ICAgfQorICAgIHN3aXRjaCAocmVnKSB7CisgICAgY2FzZSBIRVhfR1JFR19HUENZQ0xFTE86Cisg
ICAgICAgIHJldHVybiBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50KGVudik7CisgICAgZGVm
YXVsdDoKKyAgICAgICAgcmV0dXJuICh1aW50NjRfdCloZXhhZ29uX2dyZWdfcmVhZChlbnYsIHJl
ZykgfAorICAgICAgICAgICAgICAgKCh1aW50NjRfdCkoaGV4YWdvbl9ncmVnX3JlYWQoZW52LCBy
ZWcgKyAxKSkgPDwgMzIpOworICAgIH0KIH0KIAogLyoKLS0gCjIuMzQuMQoK

