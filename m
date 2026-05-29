Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A21CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5EA-0005t4-Vt; Fri, 29 May 2026 17:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5E3-0005mL-OQ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5E2-0000v8-4p
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIfjPS119680
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kuTE6HgisKrwfOsg2yLkLYCYEjmFwpc3LGLU3ZkItsk=; b=Pr6t9KpmLqv+hWCr
 n8WMQYcDw7Ryiw6sjjY9l9swjvWfSz2cYnpChqxLvEf3mnD1zlWRhK0qX5P8+WY2
 B751KtgOgvetzJOyJd8DTamNWhJQ1+RrkYZgo4y1b13FwClPgAzquG+tI9ivhaMq
 T9Q8gOJWZDZpggBi5WcMWN7aASaDBnjjkLhBdkaz8xipuBegYJH66HReYcaVm369
 At42VTFjL61S8aYKt0KOLLfBRcQm5fTJFz8Rz5NnrdIiDMW8xbwBZQEGknvBs9lt
 qyCZlzgWfGzrI/etmhFV2wxCv+J/JVP0IwD74l8pFcNfLTlIJcTT48elOfyVNJ9J
 T1sQuw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9vrqje-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304ea42b025so409133eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091910; x=1780696710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuTE6HgisKrwfOsg2yLkLYCYEjmFwpc3LGLU3ZkItsk=;
 b=X3nsYHvv+wW3Jl7mf42Qou59mE2kPenANR4XojbQQfSQZyp7BK/S8NlBih+E5WZLHT
 KSB1Buaz6WS9S1Z11kRzERYD5PdQRL94BxUsRn6kHvQnCrkzBVJfuTG+cTqrkvfBBNQV
 +VlBdL6RWcE1kGudt2uGw+Iv8GGZniRlVaFM27vUckGdPl9MKBWjoOHpTOac6jsRtLH3
 Q+IVTQTyIgld46lv9Un+BKUTOQPEDW3XUvikDEADwZMHSMrf3KonHTddQ4KHVvnbfW2U
 pgM00rM0MIdQzpZ1qkB4rO3WXzoOJ5ClaipBSkvoQQrwWOegC4n2LV4dk1YcEZPi4GdH
 cCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091910; x=1780696710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kuTE6HgisKrwfOsg2yLkLYCYEjmFwpc3LGLU3ZkItsk=;
 b=ettzNXt/M6sTkRZdxBeH1hhO0mOjpzgtj+78HFX8Pzr7prl9wij9+DfTd5Ty0ul2+j
 S+iH506G1wOkRTnW53cEXD8XSMK5Id2Pn5Zmtp7nH8HmDYtwo++bp7nuaWiN9MCTyyqQ
 Z/YsqNyBt78qRwIUBTvdjc4paprd4u0nU0I/xwDPZlEK0Mz13w6K8Y7+384hfYF7sUp/
 mmNiQceXGDF+JP/0/+VmobEsupuTO/Jt254hcv3M01rmHcii+0/UFQqCAUrCG09bxg76
 J2qI2rQxOpRfmppiSTbpjZy0J6jmoNao9IyyFbAJ39P0gus/pC0B4zxu5Kh9plmlXAD1
 WMAg==
X-Gm-Message-State: AOJu0Yy7RGRjrWrB4qSOvHTc0BwEF0/CXENU7hdP0nMvsE5U0MQPfr6u
 wZ+Dt6/yww1gl14qr7hVa8Z7e51lc+vTSxGjseh/eNT8SZKv+yh5ujOsgGADlnBKj0/8hBttWUu
 INtHCgy3oYLRdL2r7BCyoyvp1I2MgVpzyzdHHvr64B+oq4qglW5+sazIcrkRwFms7sg==
X-Gm-Gg: Acq92OH90N1OP8uaMQ4EXFb/QEkWd4wLt4SUwVCX/c5IjfGb4WXbtu39y2n4pP7bmqH
 3/OE2NTNMw9yPEw2c7Hu2W+qXDKPbgqRjqFN1GsJFxNsvsXlXzBCqhgVi6EkHM3EpAe+mNr5BlQ
 WPMxxSWFyJZtt3gAMH7wAVSCPWVs1c6DumWsLNDAUlSMl7wQaBHp/puFjAPgMC4DznrkbatRYS+
 G8uKkvDunQI4rXIvNPz8isr8sXT+JHDquZAEBDlNg1CYVAR+RVUKyqFcqPotObwqqNmXH4FbnJG
 EY98/W2Kc/yvylXMj5AineYMHuMBLe0AoavKDCMAmgeAKUkehcNO9jUF5ZylO5mnt6ZVDX9IA05
 7Px4MhnYx9a9aZ13BkZUPL/poaCEe/41F3P1nVQYz0OXV7Lp4G/uxIv7CrRzg0bh/YgxRTSHtbT
 pmx20X
X-Received: by 2002:a05:7300:6d05:b0:304:56fc:775 with SMTP id
 5a478bee46e88-304eb22df94mr1929079eec.21.1780091910004; 
 Fri, 29 May 2026 14:58:30 -0700 (PDT)
X-Received: by 2002:a05:7300:6d05:b0:304:56fc:775 with SMTP id
 5a478bee46e88-304eb22df94mr1929071eec.21.1780091909469; 
 Fri, 29 May 2026 14:58:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 14/28] target/hexagon: Implement hexagon_resume_threads()
Date: Fri, 29 May 2026 14:57:52 -0700
Message-Id: <20260529215806.608770-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX6p9xlS5zOqTl
 Qi6tszEXU2OFDXjEDZpj+6FequdzOxXNpiKhIoUPwKAxyv7qPvyxcs57UF3mlLz9UW+MkX6WTLG
 Zb5ADhpTzvI5CQG17AV4hzKWWzxGT7qrVBPlaTiiWLo8IPZg/mMayfA2nO0Eb3XdW+ENjcV3q39
 pOMqQ/lMItx4X/yCwwR2uShHk6qu4xajCJEAApwVuLVoMwZIcdyTQFwQBgGLKVAOwLn9+3urmd4
 J2MzaIuAwzNC6PDcEY9aYR3JpmKbDY7494K525veU/uHYzp3ecbjA7HdGD2a8FJEYPppkA9Twzc
 66YB5Cr1ONUX5HyEAcbl/BYlwpcnk0C7C1gDP5wAo8mgA+qX7/fiqlAtfmg8r98TkkVEVxMKcTB
 pEaQzFkSOmpleKsJbSoMZLrtpoQ5SOVziQsXRrRDGJYvOq51HxX7m/g01P5vMyFOR2UwJwcPNE6
 vGEzioe8pCxf5U4Cuqw==
X-Proofpoint-GUID: ulnwFDErc8VZ0dFsSqhSiytLPpdO6gu-
X-Proofpoint-ORIG-GUID: ulnwFDErc8VZ0dFsSqhSiytLPpdO6gu-
X-Authority-Analysis: v=2.4 cv=MJpQXsZl c=1 sm=1 tr=0 ts=6a1a0c07 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=uy5dMy9T3THg1DqjAFIA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDMgKystCiAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggMjk5Y2Jk
OTJkZGMuLjU1NTk1NWI1OTI2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNTQsNiArNTQsNyBAQCB0eXBlZGVmIHN0cnVjdCBI
ZXhhZ29uR2xvYmFsUmVnU3RhdGUgSGV4YWdvbkdsb2JhbFJlZ1N0YXRlOwogI2RlZmluZSBQUkVE
X1dSSVRFU19NQVggNSAgICAgICAgICAgICAgICAgICAvKiA0IGluc25zICsgZW5kbG9vcCAqLwog
I2RlZmluZSBWU1RPUkVTX01BWCAyCiAjZGVmaW5lIE1BWF9UTEJfRU5UUklFUyAxMDI0CisjZGVm
aW5lIFRIUkVBRFNfTUFYIDgKIAogI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9IRVhB
R09OX0NQVQogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IGUzNmVi
MmRmODZkLi42NGYxZmIyMDQzZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE2MDAsNyArMTYwMCw4IEBA
IHZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIAog
dm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgaGV4YWdvbl9yZXN1bWVfdGhyZWFkcyhlbnYsIG1hc2spOwogfQogCiB1aW50MzJfdCBIRUxQ
RVIoZ2V0aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQpCi0tIAoyLjM0
LjEKCg==

