Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBF4C43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39z-0002Qx-32; Sun, 28 Jun 2026 23:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39x-0002Cs-10
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39u-0006Me-P9
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2cfP81503812
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=; b=AggeNnT93sGlExb1
 AwRuGR5g+RDwJ6vn2Vd+xfLYov949i86hZAGYsXzexUXr/4IDcI9/OCJRnE2DVim
 Duw9+uXqFI8EOsQ90lhQVQZ/cqm2R547EgLRAV/UA2eIy1BPxTXgA3KRw+KbJ5m7
 fPrqxkAaKS0LSOtkLJtatRJ4TJsFSPNkfUTDQBAM0K2ThWgqX2POk0WEslQjd+2I
 BmwR16B2Qt153zIsFetfrXt/MOwRj56AU4+EBEBG5sOcRPaOfkj2n8RhQN3Y5BnN
 rS7i+w4mbkrm9QEpPLw2VSRsm+Jbd0ki9b4iKGDeh5gijK1+WGzGoc3ThEvZWMY+
 yy+ROA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7v834-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:35 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139871a52c2so4054855c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705574; x=1783310374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=;
 b=M/Cz9G622i3jVdtOFNe51BFLIX/Sfehx4bEkQQNqQkPv8tEj88mRVh3/bFCywC9aaH
 Obzqzt6xC7B64vrWyychTPS2cJojk8aODapNW5fvoTw9mlfpNxjjb+b5zih9VugHNHMd
 ilwI7MO+G8mWhRER7+EM0maVneInX0LjFaPfzgB0ai3+iddC3gECoxJXoLoxo7wLw41K
 QpgoH6ojplsE4vI4qP1XFw3FXltIqqX7epx/X71VxAb05X08CPUMZCZ14h7FuqO9L4cB
 bbPvMR+Y0ZfjAfDdF9BzJ6Q+v0fLVdqfGOoH1Nn/KpckCXcMjBzU0rk84rjuCwWgE98i
 m2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705574; x=1783310374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=;
 b=Q0YBX/BYMorFC2nod5/VYFHEgSVkKMLRfE0LVzkFZ4M4EsJuePwzVkJH1VqQOoDkwl
 tkzB5dJtr7RslKmpvvo7p/+DvEH7n+y4AOq2UfqUPebKNw9aTUBwcSUvhRZ4l/mJToxT
 M42MdNX4neZFc4tIb+xWOJo65byfrQ6sIzbUI9Pbb9D6OMHoubKYCD5zS9D9D2G01wqn
 smzLh8pFZkfwTsnmN6YbjJoA0IGZJ16y6RMGhEhWWswS3MxR9x+HdndiWiXsstt7ZTat
 3hBe36MeBxIEWzy8FZ7Zfqlfb/fQHt7VygGAurZ/aYRUqslUrR7DLJSm0CqjwJ2jPO1p
 xO1Q==
X-Gm-Message-State: AOJu0YwPk2kSH33QJAIo1nQtnA6FIkgYgE+Ag6K1pjrbAYJJ0zWF3U7h
 WxC4zlFMY9BleimTERaMlp1Jzy2QQWRxzs3oVSFPzGhPsmJ7YqV655+I5kMFo91ziJr7UsqsIrS
 rp5i75Kad+s/OIZknEkBZyDyFruUnVqy8fn+f4xcY1w9RxSydz80nYjTV3E7o12mzdQ==
X-Gm-Gg: AfdE7cnpajjx5+d4oPkrSlbUOB3DpCMb9o3QqpRtsRhCsb27ebvuQ1wTgtTnrFRe0Ew
 L1jrRq96M7x2Tm18bbGueBCn4MJUp23kAOUwB9ahWDXY7RkbJplRbSBvDtcywXx8O+B/b6XCD9G
 VMqYj7Exu4GmY9KCvUkoCagP5tE/N2h4LMAalyAb0+e9p7oM+YFWQrUeCWNpleCckiMohDKjf6l
 ohJlFx8pASn7GGavIXAGimG8XglgInk11NlMDB3DWTHgX9D1tgphC7eqtHIteWTlaY8ymjhDH1h
 M3R2rCLJkc6ZtU5zxByXZlYgHhzOjhb9vG9XewQDE6jTJ+fpS1d+5pOX45Lu/+/oE3ZHIsVSBp3
 AgCc7IArpaTIne6UcmwU34GKcFvBmpdArjj90Q5Ae/ZzY0WedZ8PBMlEP7Qc=
X-Received: by 2002:a05:7022:523:b0:139:ed5d:5ca5 with SMTP id
 a92af1059eb24-139ed5d5daemr6454331c88.46.1782705574396; 
 Sun, 28 Jun 2026 20:59:34 -0700 (PDT)
X-Received: by 2002:a05:7022:523:b0:139:ed5d:5ca5 with SMTP id
 a92af1059eb24-139ed5d5daemr6454318c88.46.1782705573892; 
 Sun, 28 Jun 2026 20:59:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 36/77] target/hexagon: Add cpu modes, mmu indices,
 next_PC to state
Date: Sun, 28 Jun 2026 20:57:49 -0700
Message-Id: <20260629035830.1520296-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX7iCSXDz8tQit
 zQYgg7zvhpkyWTPbtVKyshMjT9P5iTV1C2phG+HppNAQVp18keHPseEVCAbhYnjkC+F/OJqD8U5
 QiIkEGRjKmVpECjB/qqWWd+97/1Brgu0TUb5cRtMbL7ekx/YuDO4payxRoNge+9zdPDlAvBkZA0
 6A5WFNPUa/G6CZtksJqTptHMFxlT/rl4ssUgDo25uuLrV2X/Y04+r4WDt/zgSY6TAZj7zkFLlFE
 kNKIdS0crRB4yCpWYCAkk0Qfik1wR50zUFHYB9KuQHtJgUt8yA+In0vc2V4XBjAiaTfMCfapx5i
 OSPpxlzW6T+ZmRt1KJWbIfBPdlVpnMzF8yma9V5YcDXZBC0XVug4VQS9KrWTc3d6QDRXWg3RQZV
 Rernge7WryKsQiiHiiGh5OfE2GXleG4yxGRVD9o3JZrAm0+SjDbY6urnxMLzRa+bhggasdA4wc8
 2sVmCkp50/GUW41olkQ==
X-Proofpoint-GUID: ywteU_r2VcdDzV0KB2HXuKKMhRjdNKtr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX6WggmrXlxT5j
 svb+GbMEctP+z0SRV3Vy/pNHi+HjwOcp70O6jqmuYvImiMMk8PCXm3V7LKRvSR+XkllIgPasC4N
 xrEVGAkUpanpSQk5W9jCuKvDZbJYF5o=
X-Proofpoint-ORIG-GUID: ywteU_r2VcdDzV0KB2HXuKKMhRjdNKtr
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a41eda7 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=StfCoqezVcLOyubjZekA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

