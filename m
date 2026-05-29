Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13955CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5EU-0006K4-Kl; Fri, 29 May 2026 17:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5EN-000617-UP
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:59:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5EL-0000z2-03
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:59:03 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2KjM2998018
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fUaYuHH5toEs9t7RmXfDzu5i0jf4bxYonzDo6f07Vg8=; b=aWhbzEecMlORpBfU
 J3YvGEa7rbvvCYyJ8lUGjvJxshtMy94q6W3fCk8G+blYSXF+Zn4otX0ldYaKoTML
 4jNpgsXPLUN7lhPEffNyaQMsed3VzCbl7fIrZLwatRC3bcO6045MVevr/0qKX82w
 9u8ganId7XYrkOFgKhEezLFl+43uErp5bTv2hdPK/flwWpx1DFkMAaViWpv1GQ3z
 44OOFT5RCMNBnlh+0nYUbk7wTScpnUqahEigWOaT8Sc/rYE5X1VSJniYibrKExFU
 LGSKlnfL1iIg0VMna9VeBk3c4hVeS34GtBBdJZ1HzoTzRSgWO+dnee7OeR/bxVlj
 b3sT2A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj4ewa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so5136859eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091929; x=1780696729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUaYuHH5toEs9t7RmXfDzu5i0jf4bxYonzDo6f07Vg8=;
 b=P3su0QPWKtb1dIjkA2j8xIToA47lw0m06LjxQcgF0aycjxg1s5cughWHCNq4oTVm2E
 d2qxWwFd7YLsNaEbd0WgIj0NBvcnmFu+3pLZIxc9P8bdaxkZTv12grh5r7mm6ciAFMB/
 62fd1EWwOkLgzjsQfIECnAZSUEGDVUpdvyAjXKUxMqFyw8ZEzTD2b1hljYbzS2CjOuFr
 4YOUm40mz386/JbsG+82mV95hLmfqgh274NHk80SBfWORdQhE1GPPOLVZOxEEjn89yBJ
 9cJ8t/lyPeT6YQJy5GP5pN+anIiHiSJKD1BylCE1nsgRZEtrwOXOqJleh/y4KktWsQ1G
 8lIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091929; x=1780696729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fUaYuHH5toEs9t7RmXfDzu5i0jf4bxYonzDo6f07Vg8=;
 b=TkXsgpQ4ny0OOA1kQV73Dq31ucoSekFmCwNtLag46NGW+m2dWb6QDIB7WUtlFfVazE
 gQ+jXpSeYeurAxAGsvShg8FcdgBD7oMs0hx6FLpZ8uaHlp5irr2DpM5CO0XBt0hGmTY0
 VTxsr3Cwvx26G55pdiI6943hzZDouci7Pe2RZ9KTYHEEDr2DMbD4t9yW+Eby9RzYXQHP
 I6d+yl9Ql8j/yaTObR8at3YDl1zZWmpvhMcks5yL8hm3gxiyeZBnaA0UG7thgAKY3bP/
 Z+Mxl+fBUY+1KmidhUfx7EOA8irPZC70ek28kV7FgL4fRBwStRgV1FOpY0uIvNL58iS8
 1q4g==
X-Gm-Message-State: AOJu0Yw/+mlIn+ZCDN73BAvdSntdeCOsDnbEqugAH9vAgENGWHxiJti6
 7RiJHpS3GduwvY46Hyix2C8G19LX63Y7Ua+4rQDTGX3RQmTn3SniyQelJ0uj8lBHwOlxMAgtjXl
 ikPcdhSOZhRcyouSZ96y2TvY+1mIBhu4vk8g9XhAmqNCoNAhET//yR7YyOzzU7i4kAw==
X-Gm-Gg: Acq92OGILzYXWuTDSKYThwRNYPGaZygDGJShGJopoQwC0kccPAZ9RDxVreXtVYhHdJx
 9LTZKWSl7omypUZBx4D2N9XG4+wEBfJwPcY9CTq4suEEgc5lmKW2BmE7t23++Wg5wluWzGRS3dy
 /WK5NJesuew1bM5foCWWY1c9rbwmusDSdQbWHJuRjarXf7HdmUjToGXqWpEryJ83PKfUxFdbLud
 Q4xy7uxZ+Yo3S6bKXqoFWah9pn1TOMp05P8MYAKQ5qnIB8CzcACzik+4tOYXhpljF9QNNBpBcCv
 XyLX6uwfzRZoUeVSSM/tdnap32q3n794IvJq9bcVUxYSLj2r81UQ8L5LZUIKIaTZMV3h91DR6/8
 Z4UshLP6Iy5d4vhrunzwNaZuxjSaF/xnSdNb42HnklUxsErKbtPy29XbkxDttEf/ZgXH4AMAzUI
 Aq0k4g
X-Received: by 2002:a05:7300:2313:b0:2ea:c085:44b1 with SMTP id
 5a478bee46e88-304fa5a7a4fmr912633eec.19.1780091928969; 
 Fri, 29 May 2026 14:58:48 -0700 (PDT)
X-Received: by 2002:a05:7300:2313:b0:2ea:c085:44b1 with SMTP id
 5a478bee46e88-304fa5a7a4fmr912616eec.19.1780091928466; 
 Fri, 29 May 2026 14:58:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH v5 28/28] target/hexagon: Add guest reg reading functionality
Date: Fri, 29 May 2026 14:58:06 -0700
Message-Id: <20260529215806.608770-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX17Apuzq27QD6
 WTHaNb03FD9EHTb1DRbU5HCITbY6FyNk/Ob5kB2cU6PEvnUBD1kg+Qz9My3r2s3QR9+Usja6j0I
 78brm2/mHtCAX1ydYDoVXPFmeBiFZvMu7ztkUqs0oPp9QebXbOYChyIWzOISOR38t96H0ArvjJ9
 2odnyNTq4DWx0t71yO5WER/r3+B09XcfpeMr4lX0JvJpjv1PQdzrX/wXhdZOaahNEMoislhk/HE
 T46vY5H3Zplba0qE9hbSIg0wM6jNDnIwg9Yx6OgfW83goqVdf2qo6XfTQN8aeMyHcUk3OSx5pQq
 dOuAQ5BvfIp3u5jfHrOtLpgOhvoXYyJhRSazje2fqytaJulAlNeoIZwoDYqZF6F9+OuWgZFpusa
 zWlzJQ1QZiiYmbA/gb1xSxnoLA71KRWPwhocu1wq+c+PygMijUEcyxa4rScVf81rg+pzYFv7/5A
 BY2cJuBz1RXye8gn3hQ==
X-Proofpoint-ORIG-GUID: pvyZzdz4sluAbst2KewoaLj0vOdtTxQD
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1a0c19 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=IJQQmebJWjVxhimlKuwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pvyZzdz4sluAbst2KewoaLj0vOdtTxQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b20+CgpTaWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8cXVpY19tYXRo
YmVybkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2lt
cHNvbkBnbWFpbC5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgfCAgMSArCiB0
YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICB8IDE5ICsrKysrKysrKysrKysrKysrKysKIHRhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTYgKysrKysrKysrKysrKystLQogMyBmaWxlcyBjaGFu
Z2VkLCAzNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggNTU1OTU1YjU5MjYu
LmIxODhjY2MzYzZkIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuaApAQCAtMjIyLDYgKzIyMiw3IEBAIEdfTk9SRVRVUk4gdm9pZCBoZXhh
Z29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgKiBub3Qgc3Rv
cHBlZC4KICAqLwogYm9vbCBoZXhhZ29uX3RocmVhZF9pc19lbmFibGVkKENQVUhleGFnb25TdGF0
ZSAqdGhyZWFkX2Vudik7Cit1aW50MzJfdCBoZXhhZ29uX2dyZWdfcmVhZChDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgcmVnKTsKIHZvaWQgaGV4YWdvbl9jcHVfc29mdF9yZXNldChDUFVI
ZXhhZ29uU3RhdGUgKmVudik7CiAjZW5kaWYKIApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
Y3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA0NzhhODljMjM1YS4uODk1YWZhMmMx
ZmYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29u
L2NwdS5jCkBAIC03NjksNiArNzY5LDI1IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNz
X2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZvaWQgKmRhdGEpCiAjZW5kaWYKIH0KIAorI2lm
bmRlZiBDT05GSUdfVVNFUl9PTkxZCit1aW50MzJfdCBoZXhhZ29uX2dyZWdfcmVhZChDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKQoreworICAgIGlmIChyZWcgPD0gSEVYX0dSRUdf
RzMpIHsKKyAgICAgICAgcmV0dXJuIGVudi0+Z3JlZ1tyZWddOworICAgIH0KKyAgICBzd2l0Y2gg
KHJlZykgeworICAgIGNhc2UgSEVYX0dSRUdfR1BDWUNMRUxPOgorICAgICAgICByZXR1cm4gaGV4
YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coZW52KTsKKyAgICBjYXNlIEhFWF9HUkVHX0dQ
Q1lDTEVISToKKyAgICAgICAgcmV0dXJuIGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnRfaGln
aChlbnYpOworICAgIGRlZmF1bHQ6CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1QLCAi
cmVhZGluZyBncmVnICUiIFBSSWQzMgorICAgICAgICAgICAgICAgICIgbm90IHlldCBzdXBwb3J0
ZWQuXG4iLCByZWcpOworICAgICAgICByZXR1cm4gMDsKKyAgICB9Cit9CisjZW5kaWYKKwogc3Rh
dGljIHZvaWQgaGV4YWdvbl9jcHVfY2xhc3NfYmFzZV9pbml0KE9iamVjdENsYXNzICpjLCBjb25z
dCB2b2lkICpkYXRhKQogewogICAgIEhleGFnb25DUFVDbGFzcyAqbWNjID0gSEVYQUdPTl9DUFVf
Q0xBU1MoYyk7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDRlYjlmODA5MmI3Li5kY2VkYWEwYjJiNCAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMKQEAgLTE4NzcsMTMgKzE4NzcsMjUgQEAgdWludDY0X3QgSEVMUEVSKHNyZWdf
cmVhZF9wYWlyKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKQogfQogCiB1aW50
MzJfdCBIRUxQRVIoZ3JlZ19yZWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVn
KQorCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICByZXR1cm4gaGV4YWdvbl9n
cmVnX3JlYWQoZW52LCByZWcpOwogfQogCiB1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFkX3BhaXIp
KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCisKIHsKLSAgICBnX2Fzc2VydF9u
b3RfcmVhY2hlZCgpOworICAgIGlmIChyZWcgPT0gSEVYX0dSRUdfRzAgfHwgcmVnID09IEhFWF9H
UkVHX0cyKSB7CisgICAgICAgIHJldHVybiAodWludDY0X3QpKGVudi0+Z3JlZ1tyZWddKSB8Cisg
ICAgICAgICAgICAgICAoKCh1aW50NjRfdCkoZW52LT5ncmVnW3JlZyArIDFdKSkgPDwgMzIpOwor
ICAgIH0KKyAgICBzd2l0Y2ggKHJlZykgeworICAgIGNhc2UgSEVYX0dSRUdfR1BDWUNMRUxPOgor
ICAgICAgICByZXR1cm4gaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudChlbnYpOworICAgIGRl
ZmF1bHQ6CisgICAgICAgIHJldHVybiAodWludDY0X3QpaGV4YWdvbl9ncmVnX3JlYWQoZW52LCBy
ZWcpIHwKKyAgICAgICAgICAgICAgICgodWludDY0X3QpKGhleGFnb25fZ3JlZ19yZWFkKGVudiwg
cmVnICsgMSkpIDw8IDMyKTsKKyAgICB9CiB9CiAKIC8qCi0tIAoyLjM0LjEKCg==

