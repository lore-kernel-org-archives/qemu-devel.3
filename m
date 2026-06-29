Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37C3C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCHn-0003kG-4V; Mon, 29 Jun 2026 09:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHA-0003Zg-Fd
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:43:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCH8-0006C3-UV
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:43:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TB5FHo2728482
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=; b=JU5LAriVUOvw6c82
 V/DTivKAGNJ5cy6fVFj+G09wxBKY1n6M4xJo4jlZucYe0wYboDWM1HKbuwec7+Cz
 g00wUplKctKi1Fp1HPqoxhbhCFXmXkUOv/PCb65ihJR4w/i7Pih1/Jlv31Y6P0oT
 jCOdF/PwLRs86+bhO5vflpxSP2SY3Bh/ttRjIqHaBYxpJ3gtTlI6IHRik+wXa7tK
 NouTXFFy+e9AOdfRCWLsG7wwykg51FHdbuSLuVY2vm+K8k9T+yZajiBxth3saItD
 ar7vYCGf+ceO6dKN5roa17G9ySiRuZL/KH0+Dt6W5mo54ymOo9RoTz7LpYuAUCZV
 Vd7I9w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3qha8jqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c354050c34so21713255ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740629; x=1783345429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=;
 b=E4Bf/HUIb1c0HepJtW2M/s0VyY37BSdRYKPoSFWBpvtbtVspnC0Sy3yZGbYqbP8jpG
 ADNMHwEIxoea9DqajISptkv1zD7t752N4oRKqWIA4Zsqk5StKPDpWhFH2/hK1DLXLVqE
 s+28dh0C4GmRoTE6XTFjA1V+bnn45aFW61Py7j68MHyC6N4/ZYTQcqJIsi+rIv53vOuK
 s7fsRWsLRtGbiWMHsReJuuOm1+dYlxeF1e4dfuF6HZFwelHB/fB+XrYPmQf/YzUhlwMV
 S6jyBFURMpAaZgGDt22+obw2EGb0hziqEE0RkPkq8pQJEzDFYKIOi4BnjFm/LBNMfurh
 OYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740629; x=1783345429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TfVBLrLYsvAhGMAw1f7WT0DQu5QIyyTkxXEQsAXLmCA=;
 b=sB0whkPg9r9vKCvatfLmsDuaiYTUJbE+JkQYQ+WT6hLTYKMxv4i98GqPjDzJYzV8NI
 QNUjGUJjfJ7xgx+IC9fNr840GZVIEpsiR6QY8PdxwW6Lawra7YtZWo+7EmGio6K2L+vv
 giIS5jQR0n4LOvq1hQ7F0o/mpzOl9VzaeIDpWPy94LS242argNlTCiJzTuXbtUF4eqFt
 jrY+TwwwmijmA/NqYFeAdveiP7QxgJHregYnPkLtuJ53QtM8NkfOH/ll4inXMHl8jmd0
 Yy0bbPGHqMA2TFMB3DIM+gA0otr0rTP5oZg7tO2jpKhLzdThJsczVkpr0t96AQrGO+4h
 Filw==
X-Gm-Message-State: AOJu0YycjiHOy7iptgkaItdSsDY9NSYRbYNj5124pomFHkR3V85/0gkU
 K4PLk+nSGu+U+xO0Ic82IL2QEeBbyYSgvNMdrY0Ao4L21csjn0RSTxFqFiJFuQ8dJKPYhouAV8a
 ZNot74Ru1HsIyvJIjtZ1qN3kTzw8uGxMHCfgfKyEhOSsg8CAI1CE1zAo0lquTo2ExhA==
X-Gm-Gg: AfdE7ck/LUllHh4zsdpeRtBtrvbQR24E5qkAVk4ZONKuNmS1N6IafWbw0nu5FFtwOAV
 j47tvjFPXGZVzp8k+ew0YLdtga2wPmfbxoE8fDbrzyz+g4ywxOXvgsDG0z5RNrlvGk9dboriZBX
 XQYswqrdlW4JFZ09GUAb99f4ln0dbbJyEwcM+L8W+IlruBq7VVrgWY+ANL47mB+PcZ1AQR94AMc
 0rJODfmBTPN27/Igyy7sb+RXA+FCQ5xA+hHFWNmI1Da1pvKGuswXoS/GSqk8OtykQojoFP11HSV
 iilbxWeMf+VmSOEzGbSVEvzlVzM/pyst8TY4VLAGl1ChUz6BtqDz4waHcQIUGOeuXdhQaTqpJSb
 gMXHsu+JgMqYW6tnFq8CB6JSqBSY04SCF4CsduRYVt0/AUbS8AFuA9/18FBU=
X-Received: by 2002:a17:903:244f:b0:2c9:e261:95c4 with SMTP id
 d9443c01a7336-2c9e26196cfmr42648915ad.30.1782740628998; 
 Mon, 29 Jun 2026 06:43:48 -0700 (PDT)
X-Received: by 2002:a17:903:244f:b0:2c9:e261:95c4 with SMTP id
 d9443c01a7336-2c9e26196cfmr42648615ad.30.1782740628451; 
 Mon, 29 Jun 2026 06:43:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:43:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 43/77] target/hexagon: Implement start/stop helpers,
 soft reset
Date: Mon, 29 Jun 2026 06:11:58 -0700
Message-Id: <20260629131232.2487780-44-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: TJTAaUR1gAXUx6FY9-kpYbOaRx8CQTE5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXxSyrFYVV34qf
 nvmaQdCMGXJxghaZ3cyLaoWlxp0wuMQDl9cCLfhWjWBIY6oFGMGl4IvtnosRqyb59KHcp3op8AG
 pmdaWBfVHvpRkRRx2GzT6nW0YTJwqKzvyRCqqgrhDfysaeUeVfFF7qTp11MTL3rweLw+sQRPK58
 cSRzg51ZZXbaB+z3hkslE64HYRURPbeR8W8grpSyxJMu4nsVLjklYdRHGZ0DLEz26yi7659cnkn
 sf7iAz1JxO+ks9p8/AcA/rnRYohlLXG6hgcCnguMDxk3xZaNY68MN4ocBwP9NSGHIz2W4HIC1eT
 Pk46tIiM2vn7xYoLjMWVeWo0BPqIVe7K1X8O61mWVsGLQPAdt6vurDIUTll7dFW46j1moZkDxQ3
 Wd5E12Bb28xbuOT3kRrUwnhKpplzoUvgKx83b2IUnBo5IhOzIzGUlAZYdn1HQB/JRuHoH+iyOys
 05rFS14CG4gtiSLBMNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXw5mrAM3eOAn5
 pPYF0Bd+VPyHP0qtG6MnI3jSF1YLHnZXjP3if5J3ZyRjWLAHwC/rPiLf55La7H7Mv1wNHQYbjcD
 CddNgak52TYX3fy/dSdCotjQNRxD/pw=
X-Authority-Analysis: v=2.4 cv=O9UJeh9W c=1 sm=1 tr=0 ts=6a427696 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mCWuZxMSpaUKZHDxuVkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: TJTAaUR1gAXUx6FY9-kpYbOaRx8CQTE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vY3B1LmggICAgICAgfCAgOSArKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5j
ICAgICAgIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKystLQogdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgfCAgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJn
ZXQvaGV4YWdvbi9jcHUuaAppbmRleCAxYjIyNWUzNWFiYy4uOTJkNGJiOTcxMjkgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0y
MTMsNiArMjEzLDE1IEBAIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9l
cnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQzMl90IGV4Y2VwdGlvbiwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludHB0cl90IHBjKTsKIAorI2lmbmRlZiBDT05GSUdfVVNF
Ul9PTkxZCisvKgorICogQHJldHVybiB0cnVlIGlmIHRoZSBAYSB0aHJlYWRfZW52IGhhcmR3YXJl
IHRocmVhZCBpcworICogbm90IHN0b3BwZWQuCisgKi8KK2Jvb2wgaGV4YWdvbl90aHJlYWRfaXNf
ZW5hYmxlZChDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYpOwordm9pZCBoZXhhZ29uX2NwdV9z
b2Z0X3Jlc2V0KENQVUhleGFnb25TdGF0ZSAqZW52KTsKKyNlbmRpZgorCiB0eXBlZGVmIEhleGFn
b25DUFUgQXJjaENQVTsKIAogdm9pZCBoZXhhZ29uX3RyYW5zbGF0ZV9pbml0KHZvaWQpOwpkaWZm
IC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRl
eCBlYjFmNzA0OTI5OC4uMjdmMGVmNTBkZjIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2Nw
dS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0zMyw2ICszMyw3IEBACiAjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKICNpbmNsdWRlICJzeXNfbWFjcm9zLmgiCiAjaW5jbHVkZSAiYWNj
ZWwvdGNnL2NwdS1sZHN0LmgiCisjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCIKICNlbmRpZgog
CiBzdGF0aWMgT2JqZWN0Q2xhc3MgKmhleGFnb25fY3B1X2NsYXNzX2J5X25hbWUoY29uc3QgY2hh
ciAqY3B1X21vZGVsKQpAQCAtMzEwLDYgKzMxMSwyOCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX3Jl
c3RvcmVfc3RhdGVfdG9fb3BjKENQVVN0YXRlICpjcywKIH0KIAogCisjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKK3ZvaWQgaGV4YWdvbl9jcHVfc29mdF9yZXNldChDUFVIZXhhZ29uU3RhdGUgKmVu
dikKK3sKKyAgICBIZXhhZ29uQ1BVICpjcHU7CisKKyAgICBCUUxfTE9DS19HVUFSRCgpOworICAg
IGVudi0+dF9zcmVnW0hFWF9TUkVHX1NTUl0gPSAwOworICAgIGhleGFnb25fc3NyX3NldF9jYXVz
ZShlbnYsIEhFWF9DQVVTRV9SRVNFVCk7CisKKyAgICBjcHUgPSBlbnZfYXJjaGNwdShlbnYpOwor
ICAgIGlmIChjcHUtPmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgdWludDMyX3QgZXZiID0KKyAgICAg
ICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19F
VkIsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQpOwor
ICAgICAgICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IGV2YjsKKyAgICB9IGVsc2UgeworICAgICAg
ICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IGNwdS0+Ym9vdF9hZGRyOworICAgIH0KK30KKyNlbmRp
ZgorCisKIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJl
c2V0VHlwZSB0eXBlKQogewogICAgIENQVVN0YXRlICpjcyA9IENQVShvYmopOwpAQCAtMzM5LDkg
KzM2MiwxMCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2Jq
LCBSZXNldFR5cGUgdHlwZSkKIAogICAgIGVudi0+dF9zcmVnW0hFWF9TUkVHX0hUSURdID0gY3B1
LT5odGlkOwogICAgIGVudi0+dGhyZWFkSWQgPSBjcHUtPmh0aWQ7Ci0gICAgZW52LT5ncHJbSEVY
X1JFR19QQ10gPSBjcHUtPmJvb3RfYWRkcjsKLSNlbmRpZgorICAgIGhleGFnb25fY3B1X3NvZnRf
cmVzZXQoZW52KTsKICAgICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfRVZFTlRfTk9ORTsKKyAgICBl
bnYtPmdwcltIRVhfUkVHX1BDXSA9IGNwdS0+Ym9vdF9hZGRyOworI2VuZGlmCiB9CiAKIHN0YXRp
YyB2b2lkIGhleGFnb25fY3B1X2Rpc2FzX3NldF9pbmZvKGNvbnN0IENQVVN0YXRlICpjcywKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3Bf
aGVscGVyLmMKaW5kZXggNmYwMWYzYjkxZDguLmI5Y2YxZjE4OGJiIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpA
QCAtMTQ3OSwxMiArMTQ3OSwxMiBAQCB1aW50MzJfdCBIRUxQRVIoaWFzc2lnbnIpKENQVUhleGFn
b25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCiAKIHZvaWQgSEVMUEVSKHN0YXJ0KShDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdWludDMyX3QgaW1hc2spCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKKyAgICBoZXhhZ29uX3N0YXJ0X3RocmVhZHMoZW52LCBpbWFzayk7CiB9CiAKIHZvaWQg
SEVMUEVSKHN0b3ApKENQVUhleGFnb25TdGF0ZSAqZW52KQogewotICAgIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkKCk7CisgICAgaGV4YWdvbl9zdG9wX3RocmVhZChlbnYpOwogfQogCiB2b2lkIEhFTFBF
Uih3YWl0KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0X3Vsb25nIFBDKQotLSAKMi4zNC4x
Cgo=

