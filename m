Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A445CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9i-0003gG-0z; Mon, 22 Jun 2026 18:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9g-0003fX-Gk
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9e-0006cU-Te
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJafrx2176434
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=; b=pxpks4elRSJWVCmU
 ETq8lU6pY4gn5Z3Fy+ZipQ/0JX6sFL0xjJQ5cYhKsItqurIC2hhroUUEN45ryizJ
 zfIdu5489KT/vjJalaAYAhh7qoM/FO1kssCOQXk9jaKIXArWslePwZ+XC2sTncZK
 Igv/KNtdn02XJIFyVwECNxiJAw2n8CyiCKaQzP8AOa76zs4aIJ6G2akkCq+Za8NL
 67bxeZcj8rm20TOjAhAT8xBPXLvj5/89Rg4UZDDtEO9lIBggmAfK2HYHlj2pA74+
 qqD41y3hcXeMp1TgvQs5Ncfio5ZHbINbIDDf0j5gvPIYnTajE3wf7qmYSNQpcGkf
 CcvPWg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37hahe5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so6664649eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167399; x=1782772199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=;
 b=aXen/IewJbQFpfAT/mJqfQiT+tIhnoVelqY6Tu6/mw1LU5lyW2yTausvjNirtheRpb
 YZzbHa4aRDYqAN1VNTxAXafmPZcgc//pzkUPlBV+R5lbLBWj0ZQJ7+b0xOyHWcypvHCc
 XDZRMW5f7KU8hC5+T4AcYiLYYVFR5orzHfgw3P3dH6sTXrp9/MldighVyEWD4qaqb3+i
 QRF61fiZoomN/aHdOyDaqD8KvjW+Q1FsI2SMuKzf1QkBZuVx1eXlgCp/PFuZ0vhpQfi1
 SOeR+aEcTKu/HM90w7DBeufSJJ+UGSkldMLvJOBYKRYMsm2yC62ipNGfYQukzFOqsq62
 iHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167399; x=1782772199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=;
 b=PjKWMs2EdY+YzYBlfh87ZpY0kOe7d7Ck0vss+KXyqDVHah8uf9CfyB1+lSzILYF4IT
 pyDR58hDlbpYPP7OHJw7xkAOKnHFSlxqDLR4yJbev2EOOix32NjQebE/F57ny9HB8vBz
 oWfFdxgM/Q1qU6yxURJE34jT2mTr75Yd28tP8a2XjsxXioLe9LzkL311NNBKl4lCT/b8
 WHwNTWGvC3OHuu0s1VNkZifa+kUYbcRKYyl5WPOLIQz37mSX6Uj4ZQ4yZnlDjYPtS/Ao
 YJWDsFio3AkXwesZBSH5csXcxLbeacpKmDXizC9ors16g1pm6bQC/xUFYtcbknH1OAUu
 aQdQ==
X-Gm-Message-State: AOJu0YyiuKqSorykIAIYgcWavSrQiw9BDHymaVeN7ftndWiPta4IVDEP
 8ORQ/mPCAtICVMG7AyzAFHcftW/eilm2hcG+G8ZkM2cR2d4Akn8rBxEIcCxLTWcQ6uz+EpntqZE
 vue6/Str/hSOoYggRgd33T+8+Yw1S+3IyRLaTLf8iJLa11P/GE1xNbzGb/8v8k6AKKw==
X-Gm-Gg: AfdE7clAeETmAN1YzOEESKjq8MDYLN6rPvPhwkXbl7n0dkI6qXNwHUTSu4/hQyM1apy
 B3ZYKmV7YiIduA56mvsAFGjN81SYAKZJqrWn1BKEdQc+YWAezFSceaDQ20VWm9dpxfVhc+hTaU7
 KRoztKdq74Nwbe1YXHXwT/IKQFXWyCp2ROREB/tekWcBKsdvNJQc+BuenhgLkKHkeMEN1L16awR
 uiAZvJG+i4BrHPaKX67vlzA6EZsKMxRZb3vX8dnZNGwjmD/OrfQPj3E7uhodHCyxFytNukuwcRD
 vEcbv6s7JkFVG5SYEptntDLkbj9s2EZN2yPqzQYr2efR+UxNn92tSXFvJgMa6LXrF9EWNs1eX0R
 xbLThr8gZ4jX0K3VOKdPqg3uPZpUnIU57bC6eVy2DJwCYvhRrgjQwnocyUog=
X-Received: by 2002:a05:7301:4592:b0:2f5:3641:f126 with SMTP id
 5a478bee46e88-30c58ba8e12mr292404eec.24.1782167398922; 
 Mon, 22 Jun 2026 15:29:58 -0700 (PDT)
X-Received: by 2002:a05:7301:4592:b0:2f5:3641:f126 with SMTP id
 5a478bee46e88-30c58ba8e12mr292388eec.24.1782167398353; 
 Mon, 22 Jun 2026 15:29:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 33/75] target/hexagon: Add cpu modes, mmu indices,
 next_PC to state
Date: Mon, 22 Jun 2026 15:28:22 -0700
Message-Id: <20260622222904.607771-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: UHsO5A74_kU66gs1xtDiwDyrY0db1ZTc
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a39b767 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=StfCoqezVcLOyubjZekA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX7dmvC6tlfSyH
 SxnKMhw2kWdg85EaQlHQdS1eVmesVA31gDC1AfHtO4+23PljGCDOzFnSUG4H6rHwxzmDkIPlHU0
 oc66IzN6WtHL9g7q0W9Q6/Qy4dMzmb4=
X-Proofpoint-GUID: UHsO5A74_kU66gs1xtDiwDyrY0db1ZTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX8AEVmAb8Mqir
 zLn1m3DfayEAUDq1CKP9lQNqwf36MJer45t5g3+RQhwchiwF4fbKF2wpITsY4uLMQk7aYX4O7y3
 W9OFObWwDEMwNfujLbhV+cSv6bngAhkZy2vp2AZ9fZJ5sG7eaySdBrD8XRGyPKkfSyku3JQPfht
 M5JHc0QXdDSIv9at7/BnaugTVePwWjNifcAcOCjMje25kZWWGY1Tyfc6codCWZsz68RK9/AIluu
 SGRODdAEpDefsMy0v0+MFWPbQkjZBs1+msHNxgi7e26+3jCQB/nkDI+xCsix6To5jjYTgofSFaF
 sQI7WYU8D8qPvx2tfdB64fsDmty/OK0MEn3C3gQujhQV7ab8sVPd+6VUDnvQ3gNq7OSM/lnL589
 SgvgRONxHrzl0jLAxdBeGyFIKUY4aK3YcUOjlhjDhd/15hYH6dgRoHDfTbp6kSAGL48wfdyNeo1
 00UsqBZ9TtXzacN3lHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBZGQgY3B1IGV4ZWN1dGlvbiBt
b2RlICh1c2VyL3N1cGVydmlzb3IvZ3Vlc3QpLCBNTVUgaW5kZXgsIGFuZCBuZXh0X1BDCnRvIERp
c2FzQ29udGV4dCBhbmQgdHJhbnNsYXRpb24gc3RhdGUuIERlY2xhcmUgdGhlIE1NVV9JTkRFWCBi
aXQgZmllbGQKaW4gVEJfRkxBR1MgYW5kIHVzZSBpdCB0byBwcm9wYWdhdGUgdGhlIG1tdSBpbmRl
eCBpbnRvIHRyYW5zbGF0aW9ucy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxv
cnNpbXBzb25AZ21haWwuY29tPgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAg
ICAgfCAyMiArKysrKysrKysrKysrKysrKysrKystCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAg
ICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgIDIgKy0KIDMgZmlsZXMgY2hh
bmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IGRkZjZkYTc4YzE4
Li43YmExZDMwNDdkZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmgKQEAgLTQ5LDggKzQ5LDI2IEBACiAjZGVmaW5lIFZTVE9SRVNfTUFY
IDIKIAogI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9IRVhBR09OX0NQVQorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisjZGVmaW5lIENQVV9JTlRFUlJVUFRfU1dJICAgICAgQ1BVX0lO
VEVSUlVQVF9UR1RfSU5UXzAKKworI2RlZmluZSBIRVhfQ1BVX01PREVfVVNFUiAgICAxCisjZGVm
aW5lIEhFWF9DUFVfTU9ERV9HVUVTVCAgIDIKKyNkZWZpbmUgSEVYX0NQVV9NT0RFX01PTklUT1Ig
MworCisjZGVmaW5lIEhFWF9FWEVfTU9ERV9PRkYgICAgIDEKKyNkZWZpbmUgSEVYX0VYRV9NT0RF
X1JVTiAgICAgMgorI2RlZmluZSBIRVhfRVhFX01PREVfV0FJVCAgICAzCisjZGVmaW5lIEhFWF9F
WEVfTU9ERV9ERUJVRyAgIDQKKyNlbmRpZgorCisjZGVmaW5lIE1NVV9VU0VSX0lEWCAgICAgICAg
IDAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2RlZmluZSBNTVVfR1VFU1RfSURYICAgICAg
ICAxCisjZGVmaW5lIE1NVV9LRVJORUxfSURYICAgICAgIDIKKworI2VuZGlmCiAKLSNkZWZpbmUg
TU1VX1VTRVJfSURYIDAKIAogI2RlZmluZSBIRVhBR09OX0NQVV9JUlFfMCAwCiAjZGVmaW5lIEhF
WEFHT05fQ1BVX0lSUV8xIDEKQEAgLTExMiw2ICsxMzAsNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVB
cmNoU3RhdGUgewogICAgIHVpbnQzMl90IHRocmVhZElkOwogICAgIHVpbnQ2NF90IHRfY3ljbGVf
Y291bnQ7CiAjZW5kaWYKKyAgICB1aW50MzJfdCBuZXh0X1BDOwogICAgIHRhcmdldF91bG9uZyBu
ZXdfdmFsdWVfdXNyOwogCiAgICAgTWVtTG9nIG1lbV9sb2dfc3RvcmVzW1NUT1JFU19NQVhdOwpA
QCAtMTY0LDYgKzE4Myw3IEBAIHN0cnVjdCBBcmNoQ1BVIHsKICNpbmNsdWRlICJjcHVfYml0cy5o
IgogCiBGSUVMRChUQl9GTEFHUywgSVNfVElHSFRfTE9PUCwgMCwgMSkKK0ZJRUxEKFRCX0ZMQUdT
LCBNTVVfSU5ERVgsIDEsIDMpCiBGSUVMRChUQl9GTEFHUywgUENZQ0xFX0VOQUJMRUQsIDQsIDEp
CiAKIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIoQ1BVSGV4YWdv
blN0YXRlICplbnYsCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCmluZGV4IDA3NzNlZjhmZTc5Li42MjYxMDBkNDNmZCAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTMwNyw2
ICszMDcsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2Jq
LCBSZXNldFR5cGUgdHlwZSkKICAgICBtZW1zZXQoZW52LT50X3NyZWcsIDAsIHNpemVvZih1aW50
MzJfdCkgKiBOVU1fU1JFR1MpOwogICAgIG1lbXNldChlbnYtPmdyZWcsIDAsIHNpemVvZih1aW50
MzJfdCkgKiBOVU1fR1JFR1MpOwogICAgIGVudi0+d2FpdF9uZXh0X3BjID0gMDsKKyAgICBlbnYt
Pm5leHRfUEMgPSAwOwogI2VuZGlmCiAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0VWRU5UX05P
TkU7CiB9CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGVkOTZkOWE2NmIzLi5jZTViYmU5MmQ1ZCAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJh
bnNsYXRlLmMKQEAgLTk4OCw3ICs5ODgsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX3RyX2luaXRf
ZGlzYXNfY29udGV4dChEaXNhc0NvbnRleHRCYXNlICpkY2Jhc2UsCiAgICAgSGV4YWdvbkNQVSAq
aGV4X2NwdSA9IGVudl9hcmNoY3B1KGNwdV9lbnYoY3MpKTsKICAgICB1aW50MzJfdCBoZXhfZmxh
Z3MgPSBkY2Jhc2UtPnRiLT5mbGFnczsKIAotICAgIGN0eC0+bWVtX2lkeCA9IE1NVV9VU0VSX0lE
WDsKKyAgICBjdHgtPm1lbV9pZHggPSBGSUVMRF9FWDMyKGhleF9mbGFncywgVEJfRkxBR1MsIE1N
VV9JTkRFWCk7CiAgICAgY3R4LT5udW1fcGFja2V0cyA9IDA7CiAgICAgY3R4LT5udW1faW5zbnMg
PSAwOwogICAgIGN0eC0+bnVtX2h2eF9pbnNucyA9IDA7Ci0tIAoyLjM0LjEKCg==

