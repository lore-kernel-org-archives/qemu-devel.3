Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968E2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCII-00045G-JH; Mon, 29 Jun 2026 09:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHj-0003nZ-MZ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHh-0006HA-QD
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATSQ02579625
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yp87kcoinbDBfUm50phdJD1Q0SWWmLVPCkRoyO7PWUc=; b=gFpuNgT5ke2GDuuE
 aKb8B7/k6n7aYhua5TtvmILJ6cJpMveuOmPpSt3kH1uDY3K5SnIrp9AcXrWOcT30
 H36j0wsfJnSW2fryOpcG7P0CJUoLo9IONy8C3RmCc1KI94cjQFmOIvmAF45Hbapo
 1JsK7OKwY8VOBbNiYZVPe5E7jBggYGPf0oPmLIBqyla90haUWzjeRk9g4f/kc3tB
 XHtam+Q0o21R0h6Wfo77xqx7wdMOc+zH5NEFLkcer/qdDTgMEIaE8TMlliuuR6U+
 qLATSBvTZOtT7pC4VJf1tPzYz27KRpXebm7Uzt2bBVGVtrzWTxZ9KC8Kv6wnTsUm
 DYNKfA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hktp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c9a700dc0eso12987985ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740654; x=1783345454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yp87kcoinbDBfUm50phdJD1Q0SWWmLVPCkRoyO7PWUc=;
 b=giWIuYSW3wceLOLjNgLtpMD7+w87P3NkBnGMO16pAlICIblQcnXDgwU8K8f38PbkbB
 pP2N2piWuW42RwuC6APz7yUA1TGze3ItWIbIiR1M9wRrVFCYzoXuDwVa+dzizETZzo+r
 sT7QvbZDH/QgywS8RD81PXgO9iSXqA1+3hUz7BXN2EF9fdo/FGXAF4wbp3806fviB7Ah
 drba9CYQ7dEVecCTceNm/hYQPH8tXXfSsK7ibXOsQXDIDuXuyhovYQr7AjuHu6Y9JRjq
 iIBmg7t1q+ybCb9trXDKL/dVsrnL73ysMLhu8bFLCm0YeuLcb88/ODhUrJ0AQeuwo/0f
 4DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740654; x=1783345454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yp87kcoinbDBfUm50phdJD1Q0SWWmLVPCkRoyO7PWUc=;
 b=OlXfTMscdZzLctkLE3N6BXxUT2J+SrZj/7ZAexwiuBcPHcu7TN1LXlZ/TcYttxcArf
 b9THH7ujf+UAiv2G3QeQGda4RwqZPa/durllxcqzXP7q46ZmYUNWTCt7YNM8udonvmFm
 ISONzVYR9cQvGVmyC0mQkNfcKPknCw9pNOTg1vYXRHcaPO/OnREgpZES0F0BSTgdz8VM
 CfpMVXW8v79Ez2t26P9TSaBUp+OD/QmZEWFwJtXklRAJYdx+sH/b0vATi6Y6a4B6C6+j
 gAR4dtfvHpfq9FmZ8I9aaFrYyEjUfmyhn61Zb/oqMP9ns0bq6uN+G+bXQ+z7r/VIvD4m
 Mu+A==
X-Gm-Message-State: AOJu0YwloPblXn2VcruIwj9/Ud8FIte1ICmaSGqLjYhTLg50qvojIR2S
 eRXQ4of14bA5V1XNAQeCBNfKNLdnWoEPrr4rDjNG57r7wGY538tjPXNs06SfXfiL8umx/kC9UAx
 sMa6tCSWG0N2v1YxG8O1Qj4Zh9oR2/q6HjZJDg874HmRpozb3scEUu/cftj1ZtqhvuQ==
X-Gm-Gg: AfdE7cnQNphVANQLMYFYTlSSUqgAjSTDnBEKsy+5+UXpOhnlJWCV8nEEKk1B35fe+If
 MKusE00QPpE9wyzAtVaqU7qrf4Hl7QgrrR8XelZbdgWQujRW0E+TIDvNQb3HHWE4r4gA7hCXzPR
 I/eF6R09wwlHFOPM6BAcaxjnswFqxfAgN701RDnLCaft3gzWQPT5wU4dNFVpr2wMphHqML1sBfM
 NAHi12Atumm+r+u4g4/6e38U2EBmZsV/BtpARrms5zok2kyXPEBq0/fNJR9jMw6Yf2iySa0dV3x
 eoSRT+42E1rvp2+ZzKf1cUCNyFEc7a3BJtZDCe6eSKV1deMtfcwFriYuj+iXcIXylKfHC0b5M/o
 vw5KVxQ6xtqn85pzjd3/DqDcG4xzt4KUYRcdl3n57i++m10EM5Y+5zE7EuLc=
X-Received: by 2002:a17:903:b86:b0:2ca:e3f:6a4a with SMTP id
 d9443c01a7336-2ca0e3f6c4emr21027345ad.21.1782740653618; 
 Mon, 29 Jun 2026 06:44:13 -0700 (PDT)
X-Received: by 2002:a17:903:b86:b0:2ca:e3f:6a4a with SMTP id
 d9443c01a7336-2ca0e3f6c4emr21027095ad.21.1782740653116; 
 Mon, 29 Jun 2026 06:44:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 61/77] target/hexagon: Add next_PC, {s,g}reg writes
Date: Mon, 29 Jun 2026 06:12:16 -0700
Message-Id: <20260629131232.2487780-62-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX0WeTMMtQuSRC
 oBdxBobCXaEI8o/FOBa6IzTzReWCF/eosl3StmyRMi8j30eyQmPgZ3JFvCpYvnfvwN1eYhPIoBt
 ys69xqFCEXgOCgYW0ylvT+ZlHuXc46o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX5PNXL0r6GQTc
 kLGMknFevGaaWamPLBmETw38Qj5u5GMtYHCrJSO10gagpGm1l2Dso070/zKs/oDYtTxlaAgjbN2
 h3cMt7HUawXK3D5zUp27F3F558/RPJPIkUWiN4j7Daxqx3I7tm0JdS9mlcj5SMi7kpSdHxgwO/W
 kB7VXTcatwgBO1XXPMzHWWHk/1NY5DHhgb8jlVIbFLfysMjwiczCijx5NTL04WWviT4dusaezVV
 PSTxcNTG7EcMaOJJ+IvnHeHwrBjJFv+Mno8bFCZmvb54EbGb0r8X9OyP5/O+7rT2nSbRa+SBzkF
 nk3vIAtTNbKexx69jr8iDzhO0KoxxkPNxndRnjK453pSWzBcT4tslQqwiymZTa+woAPtkGvB6XL
 Q6BPGZAUrCADfI9X43ZJaRdiK7QMX/8MYMEvEgp42XXc0qiXLMGPc7bqSlZjKJ++8iZGUPPgGEp
 Oupn+5444OwqSePiKgQ==
X-Proofpoint-ORIG-GUID: w2X7ZJndjfEOxf3LkT4_INmYONpTCKJd
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a4276ae cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=fJQQT6FIS2xgNqPK2MMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: w2X7ZJndjfEOxf3LkT4_INmYONpTCKJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmggfCAgMiArLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMg
fCA3NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogMiBmaWxlcyBjaGFu
Z2VkLCA3NCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXgg
ZmVhODhjYjJkYjcuLjBhN2YzN2Q1ODQyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDYsNyArNDYsNyBA
QCB0eXBlZGVmIHN0cnVjdCBEaXNhc0NvbnRleHQgewogICAgIGludCBncmVnX2xvZ19pZHg7CiAg
ICAgaW50IHNyZWdfbG9nW1NSRUdfV1JJVEVTX01BWF07CiAgICAgaW50IHNyZWdfbG9nX2lkeDsK
LSAgICBUQ0d2X2kzMiB0X3NyZWdfbmV3X3ZhbHVlW05VTV9TUkVHU107CisgICAgVENHdl9pMzIg
dF9zcmVnX25ld192YWx1ZVtIRVhfU1JFR19HTEJfU1RBUlRdOwogICAgIFRDR3ZfaTMyIGdyZWdf
bmV3X3ZhbHVlW05VTV9HUkVHU107CiAjZW5kaWYKICAgICBpbnQgcHJlZ19sb2dbUFJFRF9XUklU
RVNfTUFYXTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggMzVlOTAzNjI4ODAuLmY0YTM1Mzk1OGZmIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuYwpAQCAtNTQ1LDYgKzU0NSwxMCBAQCBzdGF0aWMgdm9pZCBnZW5fc3RhcnRfcGFj
a2V0KERpc2FzQ29udGV4dCAqY3R4KQogICAgIGN0eC0+cmVnX2xvZ19pZHggPSAwOwogICAgIGJp
dG1hcF96ZXJvKGN0eC0+cmVnc193cml0dGVuLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAg
IGJpdG1hcF96ZXJvKGN0eC0+cHJlZGljYXRlZF9yZWdzLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1Mp
OworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgY3R4LT5ncmVnX2xvZ19pZHggPSAwOwor
ICAgIGN0eC0+c3JlZ19sb2dfaWR4ID0gMDsKKyNlbmRpZgogICAgIGN0eC0+cHJlZ19sb2dfaWR4
ID0gMDsKICAgICBiaXRtYXBfemVybyhjdHgtPnByZWdzX3dyaXR0ZW4sIE5VTV9QUkVHUyk7CiAg
ICAgY3R4LT5mdXR1cmVfdnJlZ3NfaWR4ID0gMDsKQEAgLTU3Nyw2ICs1ODEsMjUgQEAgc3RhdGlj
IHZvaWQgZ2VuX3N0YXJ0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgKiBnZW4gcGhh
c2UsIHNvIGNsZWFyIGl0IGFnYWluLgogICAgICAqLwogICAgIGJpdG1hcF96ZXJvKGN0eC0+cHJl
Z3Nfd3JpdHRlbiwgTlVNX1BSRUdTKTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGZv
ciAoaSA9IDA7IGkgPCBIRVhfU1JFR19HTEJfU1RBUlQ7IGkrKykgeworICAgICAgICBjdHgtPnRf
c3JlZ19uZXdfdmFsdWVbaV0gPSBOVUxMOworICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgY3R4
LT5zcmVnX2xvZ19pZHg7IGkrKykgeworICAgICAgICBpbnQgcmVnX251bSA9IGN0eC0+c3JlZ19s
b2dbaV07CisgICAgICAgIGlmIChyZWdfbnVtIDwgSEVYX1NSRUdfR0xCX1NUQVJUICYmCisgICAg
ICAgICAgICAoY3R4LT5uZWVkX2NvbW1pdCB8fCByZWdfbnVtID09IEhFWF9TUkVHX1NTUikpIHsK
KyAgICAgICAgICAgIGN0eC0+dF9zcmVnX25ld192YWx1ZVtyZWdfbnVtXSA9IHRjZ190ZW1wX25l
dygpOworICAgICAgICB9CisgICAgfQorICAgIGZvciAoaSA9IDA7IGkgPCBOVU1fR1JFR1M7IGkr
KykgeworICAgICAgICBjdHgtPmdyZWdfbmV3X3ZhbHVlW2ldID0gTlVMTDsKKyAgICB9CisgICAg
Zm9yIChpID0gMDsgaSA8IGN0eC0+Z3JlZ19sb2dfaWR4OyBpKyspIHsKKyAgICAgICAgaW50IHJl
Z19udW0gPSBjdHgtPmdyZWdfbG9nW2ldOworICAgICAgICBjdHgtPmdyZWdfbmV3X3ZhbHVlW3Jl
Z19udW1dID0gdGNnX3RlbXBfbmV3KCk7CisgICAgfQorI2VuZGlmCiAKICAgICAvKiBJbml0aWFs
aXplIHRoZSBydW50aW1lIHN0YXRlIGZvciBwYWNrZXQgc2VtYW50aWNzICovCiAgICAgaWYgKG5l
ZWRfc2xvdF9jYW5jZWxsZWQoJmN0eC0+cGt0KSkgewpAQCAtNzM0LDYgKzc1Nyw1MCBAQCBzdGF0
aWMgdm9pZCBnZW5fcmVnX3dyaXRlcyhEaXNhc0NvbnRleHQgKmN0eCkKICAgICB9CiB9CiAKKyNp
Zm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIHZvaWQgZ2VuX2dyZWdfd3JpdGVzKERpc2Fz
Q29udGV4dCAqY3R4KQoreworICAgIGludCBpOworCisgICAgZm9yIChpID0gMDsgaSA8IGN0eC0+
Z3JlZ19sb2dfaWR4OyBpKyspIHsKKyAgICAgICAgaW50IHJlZ19udW0gPSBjdHgtPmdyZWdfbG9n
W2ldOworCisgICAgICAgIHRjZ19nZW5fbW92X3RsKGhleF9ncmVnW3JlZ19udW1dLCBjdHgtPmdy
ZWdfbmV3X3ZhbHVlW3JlZ19udW1dKTsKKyAgICB9Cit9CisKKworc3RhdGljIHZvaWQgZ2VuX3Ny
ZWdfd3JpdGVzKERpc2FzQ29udGV4dCAqY3R4KQoreworICAgIGludCBpOworCisgICAgVENHdl9p
MzIgb2xkX3JlZyA9IHRjZ190ZW1wX25ld19pMzIoKTsKKyAgICBmb3IgKGkgPSAwOyBpIDwgY3R4
LT5zcmVnX2xvZ19pZHg7IGkrKykgeworICAgICAgICBpbnQgcmVnX251bSA9IGN0eC0+c3JlZ19s
b2dbaV07CisKKyAgICAgICAgaWYgKHJlZ19udW0gPT0gSEVYX1NSRUdfU1NSKSB7CisgICAgICAg
ICAgICB0Y2dfZ2VuX21vdl90bChvbGRfcmVnLCBoZXhfdF9zcmVnW3JlZ19udW1dKTsKKyAgICAg
ICAgICAgIHRjZ19nZW5fbW92X3RsKGhleF90X3NyZWdbcmVnX251bV0sIGN0eC0+dF9zcmVnX25l
d192YWx1ZVtyZWdfbnVtXSk7CisgICAgICAgICAgICBnZW5faGVscGVyX21vZGlmeV9zc3IodGNn
X2VudiwgY3R4LT50X3NyZWdfbmV3X3ZhbHVlW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG9sZF9yZWcpOworICAgICAgICB9IGVsc2UgaWYgKChyZWdfbnVtID09
IEhFWF9TUkVHX1NUSUQpIHx8CisgICAgICAgICAgICAgICAgICAgKHJlZ19udW0gPT0gSEVYX1NS
RUdfSU1BU0spIHx8CisgICAgICAgICAgICAgICAgICAgKHJlZ19udW0gPT0gSEVYX1NSRUdfSVBF
TkRBRCkpIHsKKyAgICAgICAgICAgIGlmIChjdHgtPm5lZWRfY29tbWl0ICYmIHJlZ19udW0gPCBI
RVhfU1JFR19HTEJfU1RBUlQpIHsKKyAgICAgICAgICAgICAgICB0Y2dfZ2VuX21vdl90bChoZXhf
dF9zcmVnW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN0eC0+dF9z
cmVnX25ld192YWx1ZVtyZWdfbnVtXSk7CisgICAgICAgICAgICB9CisgICAgICAgICAgICBnZW5f
aGVscGVyX3BlbmRpbmdfaW50ZXJydXB0KHRjZ19lbnYpOworICAgICAgICB9IGVsc2UgaWYgKChy
ZWdfbnVtID09IEhFWF9TUkVHX0JFU1RXQUlUKSB8fAorICAgICAgICAgICAgICAgICAgIChyZWdf
bnVtID09IEhFWF9TUkVHX1NDSEVEQ0ZHKSkgeworICAgICAgICAgICAgZ2VuX2hlbHBlcl9yZXNj
aGVkKHRjZ19lbnYpOworICAgICAgICB9IGVsc2UgaWYgKGN0eC0+bmVlZF9jb21taXQgJiYgcmVn
X251bSA8IEhFWF9TUkVHX0dMQl9TVEFSVCkgeworICAgICAgICAgICAgdGNnX2dlbl9tb3ZfdGwo
aGV4X3Rfc3JlZ1tyZWdfbnVtXSwgY3R4LT50X3NyZWdfbmV3X3ZhbHVlW3JlZ19udW1dKTsKKyAg
ICAgICAgfQorICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBnZW5fcHJlZF93cml0ZXMo
RGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgLyogRWFybHkgZXhpdCBpZiBub3QgbmVlZGVkIG9y
IHRoZSBsb2cgaXMgZW1wdHkgKi8KQEAgLTEwMzAsNiArMTA5NywxMCBAQCBzdGF0aWMgdm9pZCBn
ZW5fY29tbWl0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKICAgICBwcm9jZXNzX3N0b3JlX2xv
ZyhjdHgpOwogCiAgICAgZ2VuX3JlZ193cml0ZXMoY3R4KTsKKyNpZm5kZWYgQ09ORklHX1VTRVJf
T05MWQorICAgIGdlbl9ncmVnX3dyaXRlcyhjdHgpOworICAgIGdlbl9zcmVnX3dyaXRlcyhjdHgp
OworI2VuZGlmCiAgICAgZ2VuX3ByZWRfd3JpdGVzKGN0eCk7CiAgICAgaWYgKGN0eC0+cGt0LnBr
dF9oYXNfaHZ4KSB7CiAgICAgICAgIGdlbl9jb21taXRfaHZ4KGN0eCk7CkBAIC0xMjQyLDYgKzEz
MTMsOCBAQCB2b2lkIGhleGFnb25fdHJhbnNsYXRlX2luaXQodm9pZCkKICAgICBoZXhfbGxzY192
YWxfaTY0ID0gdGNnX2dsb2JhbF9tZW1fbmV3X2k2NCh0Y2dfZW52LAogICAgICAgICBvZmZzZXRv
ZihDUFVIZXhhZ29uU3RhdGUsIGxsc2NfdmFsX2k2NCksICJsbHNjX3ZhbF9pNjQiKTsKICNpZm5k
ZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGhleF9jYXVzZV9jb2RlID0gdGNnX2dsb2JhbF9tZW1f
bmV3X2kzMih0Y2dfZW52LAorICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGNhdXNl
X2NvZGUpLCAiY2F1c2VfY29kZSIpOwogICAgIGhleF9jeWNsZV9jb3VudCA9IHRjZ19nbG9iYWxf
bWVtX25ld19pNjQodGNnX2VudiwKICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0
X2N5Y2xlX2NvdW50KSwgInRfY3ljbGVfY291bnQiKTsKICNlbmRpZgpAQCAtMTI4Miw4ICsxMzU1
LDQgQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0ZV9pbml0KHZvaWQpCiAgICAgICAgICAgICBvZmZz
ZXRvZihDUFVIZXhhZ29uU3RhdGUsIHZzdG9yZV9wZW5kaW5nW2ldKSwKICAgICAgICAgICAgIHZz
dG9yZV9wZW5kaW5nX25hbWVzW2ldKTsKICAgICB9Ci0jaWZuZGVmIENPTkZJR19VU0VSX09OTFkK
LSAgICBoZXhfY2F1c2VfY29kZSA9IHRjZ19nbG9iYWxfbWVtX25ldyh0Y2dfZW52LAotICAgICAg
ICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGNhdXNlX2NvZGUpLCAiY2F1c2VfY29kZSIpOwot
I2VuZGlmCiB9Ci0tIAoyLjM0LjEKCg==

