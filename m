Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51338CD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5EP-00063q-W3; Fri, 29 May 2026 17:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5EC-0005x5-Jq
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5EA-0000ws-SF
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:52 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2M0K2998061
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1FH9Vrebnph0cDt2VnXxaNS69a2zKQrCd85zToEq/sI=; b=pav49KV9ZtT9bG7l
 XenKg2B5ujxpvaxjb/ay56Vv8B8snrJn6GZzcn1dSKyEhUS3jzUeO6ggG7v4YONZ
 IMpL0BdqFImbncV/VgDe4JWvGYo+bnwWQATCTcGU0EAFheEcRxjnrb/HBFTGykM+
 /a9DQ5+2khWVL7NptWOk1u3hE5WdIXNZz/MtxdWZwRCNfExS7DHJWkTSYuY0Ooeo
 +lJdOQ/qR3UevO2Tt+YexkzvuiSmjpI/BjRVLsTSWRXABv/KNhM2vM8Ro7h1HRjX
 RuJ85lq8btsLA48Y3Zm0DpYtF8Rd6FpQrScVj92pov18qA49FGCqKo+s6YrvZn/i
 NSooew==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj4evg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304df51ff3eso2146503eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091919; x=1780696719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FH9Vrebnph0cDt2VnXxaNS69a2zKQrCd85zToEq/sI=;
 b=eBR7QUXkEQVQOXWZBmV/CtKAckfF/Xjqafg+9WFPAQbcnoqEj0Q+vZmWKV5VeABSre
 fhIebmLNJ7nzWCb1lyO2F8Vt0zMyHU9aPgH1zaPNakqXYU6Gct64WREA3zBs6QdLlmQD
 AtiQN+0f5uTWTFuA87jVyfnEPX3qrO90dY3gicbo61LoXUTzGy2GQgimgrY7blB2DAa/
 YRhP7IZ5yZB4PBKXFtTp7rS0kAh21IcGtputxbEIeLuLsmBatqQG/1htb8a2PvhRDpUo
 esqq4P9x3bEpLVlAtVJ3BXILp96oifFWEVuNG2HbnkaICoCub9ooEj1X7RAKwnh4LeIv
 yvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091919; x=1780696719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1FH9Vrebnph0cDt2VnXxaNS69a2zKQrCd85zToEq/sI=;
 b=ewm+K/SdPZNZV9cz/rfniOdy5UqZz0rKHpJNmIWfVe3mOXKP3jOSIg+wy18/VmX2AI
 sqT/99/YG56isYT7ldsmbQMQlJ3w2JnNucDdD+ule4ynudJWKi5YElgCEFDCetl7HOiZ
 wEgeh8MeI6+pjcA0MxnnIXnfeLXwYspohuAvo3lo5I7E2SlU2qlNqPUt8q1ftQSbq03P
 4lEQog8qKzA8QR2MWSsMT2i8yxkLHOnmImoEbIJo/07ChA94Ye1Lh3gVHRX26GaKlpMK
 C1kEoCHmBvw6pmTcvla/O69KQsr2VmgPt6ZTNFBGep/USPF6u86DgNvMK1r6ynJXZ2Dw
 4ZAw==
X-Gm-Message-State: AOJu0YzoHwvXEQaV230OE2rCgrHJJTMn1hALIBooru6gR7wVKKRrHQEh
 uPrFjxv8886/6RiwYbmV/my4ZYPd3HMdTdnMrJmcnAXEzi0f/YGrOtAsSQQtSjKtKc3BPnbnrW3
 ORU8bz4hTaqMId/ndQsVzSojJlFb5vqL02ursE4vnU9pHEwVIixclfvjmfTsfevhksA==
X-Gm-Gg: Acq92OHaYzamGarbcxb7wXlsVScVtSP9FleB7uQlHMeglWe7E2j64n0XDSYF+DsaPS8
 NFqRI3QnjqprZZa4HkUib4ME9SGJ/VOUXomBDpBW7LqjZ7UPw/uCEzLXhAhCA8r9zDpCCNl510O
 I4NSrcM+MkkHNxd4rbXkDBoRvsxf4m/bM+FOP2KCJb+bP8cgKunQ6+e9c/RjSiMhUGL1bxFOwVW
 i8yNSnE/AiP7C3VOM3XLVbt4ESgvhgGYsQTSVnGgOW3sEhB9djwwqdXruq8TvYF1biwQvArgO6K
 tncO/e6a+mSM8o5aSxXrLBHKJeDVv3hDUXcl0rNDzRaUYVfaDcagaeD9Cs2jvR2sHQ1riopiZmN
 doze0S1IQzNr00zPryW/pjdBjA2G6t/MzvnWjlOi4Nywoz9q8DNlMqhsU8p8LrUvqjjIOvntuDb
 fdYCbW
X-Received: by 2002:a05:7300:e58b:b0:2f2:5c68:5074 with SMTP id
 5a478bee46e88-304fa5163f7mr888499eec.13.1780091918833; 
 Fri, 29 May 2026 14:58:38 -0700 (PDT)
X-Received: by 2002:a05:7300:e58b:b0:2f2:5c68:5074 with SMTP id
 5a478bee46e88-304fa5163f7mr888475eec.13.1780091918307; 
 Fri, 29 May 2026 14:58:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 21/28] target/hexagon: Add next_PC, {s,g}reg writes
Date: Fri, 29 May 2026 14:57:59 -0700
Message-Id: <20260529215806.608770-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX9sbXNO99UITJ
 CG5xNPalOhjT0vq4ZeTg2bsMA6P8BxOv5UoccIpqiTDrdOLLkzSg7SqgTZWrAmBt07GSYIkuZgp
 redtcHINPaomooXKHERipwAEYQOP0J+QbQ82EsthNzuSidDI/MIxcnIs58zUVKym+k5DPmIzh3a
 ru8vj3TktyZ7ALsfQh9rPNGnm1V1xmxx6tqSmCzdbO3Jiv/Ad3ZVe0N4WEAwOasg0eLhq2zTDkn
 gJJO8MIIjPu3X5UMBxjOLlyLu+tYA0ucsmJFjrZb9XH5ZIZsDdhLXjAC3fMkbfqkYfV5tI2+CTi
 efGGrhk3hFsydvZTLch/mCHNZSG0A6Zbslbb6sVLP/fFJzxWiISTnKuiU36d4WdlMUVrCQuH6/V
 1ySfC/hn6NBUyr0r5+bwqNjKqLs669K1SLupoUeG1hYc/wXv8Yq6wvK4uSQTbAgsEaLj5/zSq/4
 iKkqSFV7DGBjTIi9nHA==
X-Proofpoint-ORIG-GUID: ESLmG8g9BaxqZT7NJV6mX0OZxZt2Jk_s
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1a0c0f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=fJQQT6FIS2xgNqPK2MMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ESLmG8g9BaxqZT7NJV6mX0OZxZt2Jk_s
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggfCAgMiArLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCA3NyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogMiBmaWxlcyBjaGFuZ2VkLCA3NCBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXggZmVhODhjYjJk
YjcuLjBhN2YzN2Q1ODQyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDYsNyArNDYsNyBAQCB0eXBlZGVm
IHN0cnVjdCBEaXNhc0NvbnRleHQgewogICAgIGludCBncmVnX2xvZ19pZHg7CiAgICAgaW50IHNy
ZWdfbG9nW1NSRUdfV1JJVEVTX01BWF07CiAgICAgaW50IHNyZWdfbG9nX2lkeDsKLSAgICBUQ0d2
X2kzMiB0X3NyZWdfbmV3X3ZhbHVlW05VTV9TUkVHU107CisgICAgVENHdl9pMzIgdF9zcmVnX25l
d192YWx1ZVtIRVhfU1JFR19HTEJfU1RBUlRdOwogICAgIFRDR3ZfaTMyIGdyZWdfbmV3X3ZhbHVl
W05VTV9HUkVHU107CiAjZW5kaWYKICAgICBpbnQgcHJlZ19sb2dbUFJFRF9XUklURVNfTUFYXTsK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKaW5kZXggMzVlOTAzNjI4ODAuLjMyNWMxYTllOGZiIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YwpAQCAtNTQ1LDYgKzU0NSwxMCBAQCBzdGF0aWMgdm9pZCBnZW5fc3RhcnRfcGFja2V0KERpc2Fz
Q29udGV4dCAqY3R4KQogICAgIGN0eC0+cmVnX2xvZ19pZHggPSAwOwogICAgIGJpdG1hcF96ZXJv
KGN0eC0+cmVnc193cml0dGVuLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAgIGJpdG1hcF96
ZXJvKGN0eC0+cHJlZGljYXRlZF9yZWdzLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOworI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisgICAgY3R4LT5ncmVnX2xvZ19pZHggPSAwOworICAgIGN0eC0+
c3JlZ19sb2dfaWR4ID0gMDsKKyNlbmRpZgogICAgIGN0eC0+cHJlZ19sb2dfaWR4ID0gMDsKICAg
ICBiaXRtYXBfemVybyhjdHgtPnByZWdzX3dyaXR0ZW4sIE5VTV9QUkVHUyk7CiAgICAgY3R4LT5m
dXR1cmVfdnJlZ3NfaWR4ID0gMDsKQEAgLTU3Nyw2ICs1ODEsMjUgQEAgc3RhdGljIHZvaWQgZ2Vu
X3N0YXJ0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgKiBnZW4gcGhhc2UsIHNvIGNs
ZWFyIGl0IGFnYWluLgogICAgICAqLwogICAgIGJpdG1hcF96ZXJvKGN0eC0+cHJlZ3Nfd3JpdHRl
biwgTlVNX1BSRUdTKTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGZvciAoaSA9IDA7
IGkgPCBIRVhfU1JFR19HTEJfU1RBUlQ7IGkrKykgeworICAgICAgICBjdHgtPnRfc3JlZ19uZXdf
dmFsdWVbaV0gPSBOVUxMOworICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgY3R4LT5zcmVnX2xv
Z19pZHg7IGkrKykgeworICAgICAgICBpbnQgcmVnX251bSA9IGN0eC0+c3JlZ19sb2dbaV07Cisg
ICAgICAgIGlmIChyZWdfbnVtIDwgSEVYX1NSRUdfR0xCX1NUQVJUICYmCisgICAgICAgICAgICAo
Y3R4LT5uZWVkX2NvbW1pdCB8fCByZWdfbnVtID09IEhFWF9TUkVHX1NTUikpIHsKKyAgICAgICAg
ICAgIGN0eC0+dF9zcmVnX25ld192YWx1ZVtyZWdfbnVtXSA9IHRjZ190ZW1wX25ldygpOworICAg
ICAgICB9CisgICAgfQorICAgIGZvciAoaSA9IDA7IGkgPCBOVU1fR1JFR1M7IGkrKykgeworICAg
ICAgICBjdHgtPmdyZWdfbmV3X3ZhbHVlW2ldID0gTlVMTDsKKyAgICB9CisgICAgZm9yIChpID0g
MDsgaSA8IGN0eC0+Z3JlZ19sb2dfaWR4OyBpKyspIHsKKyAgICAgICAgaW50IHJlZ19udW0gPSBj
dHgtPmdyZWdfbG9nW2ldOworICAgICAgICBjdHgtPmdyZWdfbmV3X3ZhbHVlW3JlZ19udW1dID0g
dGNnX3RlbXBfbmV3KCk7CisgICAgfQorI2VuZGlmCiAKICAgICAvKiBJbml0aWFsaXplIHRoZSBy
dW50aW1lIHN0YXRlIGZvciBwYWNrZXQgc2VtYW50aWNzICovCiAgICAgaWYgKG5lZWRfc2xvdF9j
YW5jZWxsZWQoJmN0eC0+cGt0KSkgewpAQCAtNzM0LDYgKzc1Nyw1MCBAQCBzdGF0aWMgdm9pZCBn
ZW5fcmVnX3dyaXRlcyhEaXNhc0NvbnRleHQgKmN0eCkKICAgICB9CiB9CiAKKyNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWQorc3RhdGljIHZvaWQgZ2VuX2dyZWdfd3JpdGVzKERpc2FzQ29udGV4dCAq
Y3R4KQoreworICAgIGludCBpOworCisgICAgZm9yIChpID0gMDsgaSA8IGN0eC0+Z3JlZ19sb2df
aWR4OyBpKyspIHsKKyAgICAgICAgaW50IHJlZ19udW0gPSBjdHgtPmdyZWdfbG9nW2ldOworCisg
ICAgICAgIHRjZ19nZW5fbW92X3RsKGhleF9ncmVnW3JlZ19udW1dLCBjdHgtPmdyZWdfbmV3X3Zh
bHVlW3JlZ19udW1dKTsKKyAgICB9Cit9CisKKworc3RhdGljIHZvaWQgZ2VuX3NyZWdfd3JpdGVz
KERpc2FzQ29udGV4dCAqY3R4KQoreworICAgIGludCBpOworCisgICAgVENHdl9pMzIgb2xkX3Jl
ZyA9IHRjZ190ZW1wX25ld19pMzIoKTsKKyAgICBmb3IgKGkgPSAwOyBpIDwgY3R4LT5zcmVnX2xv
Z19pZHg7IGkrKykgeworICAgICAgICBpbnQgcmVnX251bSA9IGN0eC0+c3JlZ19sb2dbaV07CisK
KyAgICAgICAgaWYgKHJlZ19udW0gPT0gSEVYX1NSRUdfU1NSKSB7CisgICAgICAgICAgICB0Y2df
Z2VuX21vdl90bChvbGRfcmVnLCBoZXhfdF9zcmVnW3JlZ19udW1dKTsKKyAgICAgICAgICAgIHRj
Z19nZW5fbW92X3RsKGhleF90X3NyZWdbcmVnX251bV0sIGN0eC0+dF9zcmVnX25ld192YWx1ZVty
ZWdfbnVtXSk7CisgICAgICAgICAgICBnZW5faGVscGVyX21vZGlmeV9zc3IodGNnX2VudiwgY3R4
LT50X3NyZWdfbmV3X3ZhbHVlW3JlZ19udW1dLAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG9sZF9yZWcpOworICAgICAgICB9IGVsc2UgaWYgKChyZWdfbnVtID09IEhFWF9TUkVH
X1NUSUQpIHx8CisgICAgICAgICAgICAgICAgICAgKHJlZ19udW0gPT0gSEVYX1NSRUdfSU1BU0sp
IHx8CisgICAgICAgICAgICAgICAgICAgKHJlZ19udW0gPT0gSEVYX1NSRUdfSVBFTkRBRCkpIHsK
KyAgICAgICAgICAgIGlmIChjdHgtPm5lZWRfY29tbWl0ICYmIHJlZ19udW0gPCBIRVhfU1JFR19H
TEJfU1RBUlQpIHsKKyAgICAgICAgICAgICAgICB0Y2dfZ2VuX21vdl90bChoZXhfdF9zcmVnW3Jl
Z19udW1dLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN0eC0+dF9zcmVnX25ld192
YWx1ZVtyZWdfbnVtXSk7CisgICAgICAgICAgICB9CisgICAgICAgICAgICBnZW5faGVscGVyX3Bl
bmRpbmdfaW50ZXJydXB0KHRjZ19lbnYpOworICAgICAgICB9IGVsc2UgaWYgKChyZWdfbnVtID09
IEhFWF9TUkVHX0JFU1RXQUlUKSB8fAorICAgICAgICAgICAgICAgICAgIChyZWdfbnVtID09IEhF
WF9TUkVHX1NDSEVEQ0ZHKSkgeworICAgICAgICAgICAgZ2VuX2hlbHBlcl9yZXNjaGVkKHRjZ19l
bnYpOworICAgICAgICB9IGVsc2UgaWYgKGN0eC0+bmVlZF9jb21taXQgJiYgcmVnX251bSA8IEhF
WF9TUkVHX0dMQl9TVEFSVCkgeworICAgICAgICAgICAgdGNnX2dlbl9tb3ZfdGwoaGV4X3Rfc3Jl
Z1tyZWdfbnVtXSwgY3R4LT50X3NyZWdfbmV3X3ZhbHVlW3JlZ19udW1dKTsKKyAgICAgICAgfQor
ICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBnZW5fcHJlZF93cml0ZXMoRGlzYXNDb250
ZXh0ICpjdHgpCiB7CiAgICAgLyogRWFybHkgZXhpdCBpZiBub3QgbmVlZGVkIG9yIHRoZSBsb2cg
aXMgZW1wdHkgKi8KQEAgLTEwMzAsNiArMTA5NywxMCBAQCBzdGF0aWMgdm9pZCBnZW5fY29tbWl0
X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKICAgICBwcm9jZXNzX3N0b3JlX2xvZyhjdHgpOwog
CiAgICAgZ2VuX3JlZ193cml0ZXMoY3R4KTsKKyNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZ
KQorICAgIGdlbl9ncmVnX3dyaXRlcyhjdHgpOworICAgIGdlbl9zcmVnX3dyaXRlcyhjdHgpOwor
I2VuZGlmCiAgICAgZ2VuX3ByZWRfd3JpdGVzKGN0eCk7CiAgICAgaWYgKGN0eC0+cGt0LnBrdF9o
YXNfaHZ4KSB7CiAgICAgICAgIGdlbl9jb21taXRfaHZ4KGN0eCk7CkBAIC0xMjQyLDYgKzEzMTMs
OCBAQCB2b2lkIGhleGFnb25fdHJhbnNsYXRlX2luaXQodm9pZCkKICAgICBoZXhfbGxzY192YWxf
aTY0ID0gdGNnX2dsb2JhbF9tZW1fbmV3X2k2NCh0Y2dfZW52LAogICAgICAgICBvZmZzZXRvZihD
UFVIZXhhZ29uU3RhdGUsIGxsc2NfdmFsX2k2NCksICJsbHNjX3ZhbF9pNjQiKTsKICNpZm5kZWYg
Q09ORklHX1VTRVJfT05MWQorICAgIGhleF9jYXVzZV9jb2RlID0gdGNnX2dsb2JhbF9tZW1fbmV3
X2kzMih0Y2dfZW52LAorICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGNhdXNlX2Nv
ZGUpLCAiY2F1c2VfY29kZSIpOwogICAgIGhleF9jeWNsZV9jb3VudCA9IHRjZ19nbG9iYWxfbWVt
X25ld19pNjQodGNnX2VudiwKICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0X2N5
Y2xlX2NvdW50KSwgInRfY3ljbGVfY291bnQiKTsKICNlbmRpZgpAQCAtMTI4Miw4ICsxMzU1LDQg
QEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0ZV9pbml0KHZvaWQpCiAgICAgICAgICAgICBvZmZzZXRv
ZihDUFVIZXhhZ29uU3RhdGUsIHZzdG9yZV9wZW5kaW5nW2ldKSwKICAgICAgICAgICAgIHZzdG9y
ZV9wZW5kaW5nX25hbWVzW2ldKTsKICAgICB9Ci0jaWZuZGVmIENPTkZJR19VU0VSX09OTFkKLSAg
ICBoZXhfY2F1c2VfY29kZSA9IHRjZ19nbG9iYWxfbWVtX25ldyh0Y2dfZW52LAotICAgICAgICBv
ZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGNhdXNlX2NvZGUpLCAiY2F1c2VfY29kZSIpOwotI2Vu
ZGlmCiB9Ci0tIAoyLjM0LjEKCg==

