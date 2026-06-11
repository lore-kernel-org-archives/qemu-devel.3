Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3C3CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXzL-00080s-GJ; Thu, 11 Jun 2026 01:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzJ-0007zr-Q8
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzI-0000t1-5N
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:57 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GQcp3835154
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4+acMbo/C4i2O//kllAUg/Ia3Ltqbfkk1HizCSwYn1c=; b=ZkECXCP1likxl+cd
 3l/dmB44T+ezoU+VblisOhH83f0K+94ISASEWzYD34FQK4Bk0jj4ajq/noxF49AP
 lKMYaAViLc7ZRwtyOe7RGh/qqSdscAxLkFBfciDHmjz8nOoabZnBR/u/Fa9bgG5h
 vuZyoJwKE7R+QDGQZ8aHSRFLxM4aChFMGkT8kiu/i1rd5EeKtejTp1STJzV8j5d0
 BnvTLaB5t+Ux3gtytMm1rItL7NO0VLN7x/2k1+8aUouM+WQ+woMxo9ZhwO3Ma2AS
 oMixG6kWKM/LKPiatq75Qqu35gpqRxsEk9Yc20yqHWtwJ1LN/kph8Ggl8m4TF0r4
 +yHAzw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ths77-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304d0d0b28eso10719527eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155784; x=1781760584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+acMbo/C4i2O//kllAUg/Ia3Ltqbfkk1HizCSwYn1c=;
 b=IxLCdIVBPTf+pBksXYuOJUAAfg5lrDbZq1UpaaKqP5ZKAmAhLwKtWE68l+YSlYV43D
 2RCnBMqPJbiwJgrw93h7h+WYuNdRbXzpIqXHV1qV031ENoSpHT1fyFZ0/OZ9nP7io7lk
 6+ief7IEXXNDAk50qnI0jRBS7xDOJbZC00GrmnFMgLhcIV9jyweNepBIIZylCgTRv+ZP
 EohS7obBGHVvcPRIzhm9Y4J56ax28I+KkGvCxRVYFYQ6cb3/NBHaK/Z75aFT1SHgWdhY
 hNisAFaHlVlw4Ufpq7XQYHPeN7QvCLBpW3kd44EmFro1c4ddt5LXtEFkYl/usCaCAFxI
 mZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155784; x=1781760584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4+acMbo/C4i2O//kllAUg/Ia3Ltqbfkk1HizCSwYn1c=;
 b=GrvKXwtOkMwvXhqTiuJ9A5tFl8lbjgepK+Dfa0cvl3qZTdhtXzMSKMIMzkj6HaKatR
 0BnbcEwhoV/CYOLdDkn7u+U6cZS+2cRiAiNea92UnT8pIZ4Kns6k8LDiFt2ZpErZJKNJ
 qCmzxq6LcZNBw+DbqOAeRc0zdaOGIDHxWb64IBDDOf2YgSBy/7VLtRVLAgjdp/cH+5W9
 7udA62FDGvK0bArEingsZgy2sDWQb/TOlTalsMYEHtruh9tyM33DUaIZuAJDf0MFXtMr
 4xTo0Xklu9ZNgD/FAB7zjrPSzi1eK/OQYEO1DQwEZBMjASDId2nmNwg11ox2ERESO8Vm
 Q2wQ==
X-Gm-Message-State: AOJu0YzNP/xHI0R0WweCQFEaSJXQ2mUjFJnYrNpDOiqappKm5uMq9Oap
 0LKY7FtF6kB0RKI48WlxZNgOdHTLqWUSK2GmPrzu7q75RfhPvrvFfrvjA2Qc+a6MX2Emo120J6I
 dzsjYn8dDqYdNFk/KZ403/FymXUwO0C3yk7MGBkyGluI4LQfv6WAEn7N476TEGj4ocw==
X-Gm-Gg: Acq92OGxr6xZbPFYZeaMig7ooHRpcihtQldDPXPSEmSszLtYjNTE8tnLcp9wL8eFwPN
 Vnj+iFSU4TP1nY/drc6NpSVgB1Aw6Qtv+8ytc3B3Qdup1/dxrOclWERHcOpQC8RCE4G2oio5i2x
 R9FBzaH9Nzjx8adqxrZeF0tKGZVhA1r4K+SRThJXxPvJZz90c87X0cdLp4Yz50VM6lNflpmP2V2
 N34OY1Y5JoDB8mMufz1V3YNgUeAiAQoI8mP7S5Sr9ejkHOGdIEaMlf3lKL7iDqlPnmVuBWZUKLA
 DV8EvziOuseFdtH4u7tCfjx0gXjvfDJfk+Zk1859kJ6krkTxAnLUgk915+DBv8UhRFLGw72YVYd
 6NDOTBhozpn9dMFTTadB5Kf3+rLryotIy69GIaxZvxFWxZ9MVExf38ryohQKd6Vtt8GG5wo1QNw
 e0mZxN
X-Received: by 2002:a05:7300:1806:b0:307:4797:ccb8 with SMTP id
 5a478bee46e88-30804bb6b6bmr1097147eec.32.1781155783897; 
 Wed, 10 Jun 2026 22:29:43 -0700 (PDT)
X-Received: by 2002:a05:7300:1806:b0:307:4797:ccb8 with SMTP id
 5a478bee46e88-30804bb6b6bmr1097134eec.32.1781155783296; 
 Wed, 10 Jun 2026 22:29:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] target/hexagon: Add TCG overrides for thread ctl
Date: Wed, 10 Jun 2026 22:28:47 -0700
Message-Id: <20260611052857.3911981-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX9HPfvVQDemnQ
 lWCAMaIhFCUkPjgHhXmxL/i5DIFaU+6HR2yZNRM3SI+6SptBJ13wCaA6n8KqjVXht1vzwG0T7/k
 2jZAHF/GdovBUv6qumMoZVP3VqgUZoV7oMmALFBA4YrAJN+HLorM9BObl4CSo/nuQQcINxXb0hs
 1nEnS+8LUgScsHCDCdjcvgh05fHJRxyvPK/Xzo9MVou9pbqw7Bwxn5mau1ZFG5Rb4m/BJSwtHOk
 j/JMU5gz6NmFkOYJHnM3o2C7ifZmBIaN+5/iS511Ip3eROGnQoYuJHGvkjeN0KEbvNz2c8nKP83
 lW9x3J0lZxbBe+Zpce2+C/4uufkiow53KsLgISWO6aQQECeYqTOwgv0bzXpc8H59U8T7dzRGS0Q
 Y6aV3I9SHmJfFwfwI1QYQnGwO1Wtc8QFputIwkJLmnWjnZMkpTGBgq5aEGokaR1jwDudaPtPGCz
 0rJ/DgqMEKImzYy3Bhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX7J7fih19m3wE
 zopEVyS2f1W36Z7S7NIRoXAWhwW27TcPJ/H34+msjT32MAg1Au2DRpe/qOAixfxFyQsZsRHZTCD
 pVM0Ciy6ndzJxDkzisqqsfVYOzM8n7c=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2a47c8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t9Y8JitlK4h6-XB8aEcA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: fkOdzWaSa506h1rRch946xQrvsQw02hU
X-Proofpoint-GUID: fkOdzWaSa506h1rRch946xQrvsQw02hU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Igc3RhcnQsIHN0b3AsIHdhaXQsIHJlc3VtZSBpbnN0cnVjdGlvbnMuCgoKUmV2aWV3ZWQt
Ynk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9nZW5fdGNnX3N5cy5oIHwgMTggKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4
YWdvbi9oZWxwZXIuaCAgICAgIHwgIDQgKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMg
ICB8IDIwICsrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oIGIvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZ19zeXMuaAppbmRleCA0Y2JiZGQxZjcwYi4uODY1MGY2NGE2ZDQgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIvdGFyZ2V0L2hleGFn
b24vZ2VuX3RjZ19zeXMuaApAQCAtNzcsNCArNzcsMjIgQEAKICAgICAgICAgfSBcCiAgICAgfSB3
aGlsZSAoMCkKIAorI2RlZmluZSBmR0VOX1RDR19ZMl93YWl0KFNIT1JUQ09ERSkgXAorICAgIGRv
IHsgXAorICAgICAgICBSc1YgPSBSc1Y7IFwKKyAgICAgICAgZ2VuX2hlbHBlcl93YWl0KHRjZ19l
bnYsIHRjZ19jb25zdGFudF90bChjdHgtPnBrdC0+cGMpKTsgXAorICAgIH0gd2hpbGUgKDApCisK
KyNkZWZpbmUgZkdFTl9UQ0dfWTJfcmVzdW1lKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJf
cmVzdW1lKHRjZ19lbnYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZMl9zdGFydChTSE9SVENP
REUpIFwKKyAgICBnZW5faGVscGVyX3N0YXJ0KHRjZ19lbnYsIFJzVikKKworI2RlZmluZSBmR0VO
X1RDR19ZMl9zdG9wKFNIT1JUQ09ERSkgXAorICAgIGRvIHsgXAorICAgICAgICBSc1YgPSBSc1Y7
IFwKKyAgICAgICAgZ2VuX2hlbHBlcl9zdG9wKHRjZ19lbnYpOyBcCisgICAgfSB3aGlsZSAoMCkK
KwogI2VuZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3RhcmdldC9o
ZXhhZ29uL2hlbHBlci5oCmluZGV4IDk1NTI4NzEzM2U0Li42ODJmMGM2YzI2ZSAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgK
QEAgLTEyMyw0ICsxMjMsOCBAQCBERUZfSEVMUEVSXzIoZ3JlZ19yZWFkLCBpMzIsIGVudiwgaTMy
KQogREVGX0hFTFBFUl8yKGdyZWdfcmVhZF9wYWlyLCBpNjQsIGVudiwgaTMyKQogREVGX0hFTFBF
Ul8zKHNyZWdfd3JpdGVfbWFza2VkLCB2b2lkLCBlbnYsIGkzMiwgaTMyKQogREVGX0hFTFBFUl8z
KHNldHByaW8sIHZvaWQsIGVudiwgaTMyLCBpMzIpCitERUZfSEVMUEVSXzIoc3RhcnQsIHZvaWQs
IGVudiwgaTMyKQorREVGX0hFTFBFUl8xKHN0b3AsIHZvaWQsIGVudikKK0RFRl9IRUxQRVJfMih3
YWl0LCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihyZXN1bWUsIHZvaWQsIGVudiwgaTMy
KQogI2VuZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IGVlMjgyZTY2ZTg2Li5kYTAwZGZkNjVjMyAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMKQEAgLTE0MTksNiArMTQxOSwyNiBAQCB1aW50MzJfdCBIRUxQRVIoaWFzc2ln
bnIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCiAgICAgZ19hc3NlcnRfbm90
X3JlYWNoZWQoKTsKIH0KIAordm9pZCBIRUxQRVIoc3RhcnQpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBpbWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit2
b2lkIEhFTFBFUihzdG9wKShDUFVIZXhhZ29uU3RhdGUgKmVudikKK3sKKyAgICBnX2Fzc2VydF9u
b3RfcmVhY2hlZCgpOworfQorCit2b2lkIEhFTFBFUih3YWl0KShDUFVIZXhhZ29uU3RhdGUgKmVu
diwgdGFyZ2V0X3Vsb25nIFBDKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisK
K3ZvaWQgSEVMUEVSKHJlc3VtZSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2sp
Cit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwogdWludDMyX3QgSEVMUEVSKGdl
dGltYXNrKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGlkKQogewogICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7Ci0tIAoyLjM0LjEKCg==

