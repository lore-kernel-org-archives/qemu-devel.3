Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61527CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbneF-0003vP-2i; Mon, 22 Jun 2026 19:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbnde-0003Dn-GU
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:01:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndc-0002cY-T8
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:01:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJafgC2176425
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=wjuhDqFA99bfqKwa5FJeRGdXAp8yPWnYoBMxxqb/9H4=; b=Iw
 85mvyeeukE9SlUrtn5K81A/hYM2UYfrxuYbm8px2Ae+oYdGJSG+yvTJYL7DOWo+S
 T4BsOPFqwdso3+dKrE8iuY3OXJLo9ObopSbncFYe4dxOL0mmzBD+qvBFgwPFsb8l
 /I6P8xv1bQ2F70XGXVySUzCp7T2dKE8UB9X/7V80JRfgfmQ0nfOJNXjawqlbSO9z
 xTij3wEnWOpgWeAoODTVwGwb9A4HQti9DBaRz1BSSK4bITI45pMtWZsryNFTrAOJ
 jPpQ09s7Yex/IPxvQhBFJW87C06sC8Gm+EEodoowU22w3BJ1/Pkt/DEaa7AEnX4G
 4zvDPMuB2iHXMVcCvn7Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37haknu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so5884043eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169257; x=1782774057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wjuhDqFA99bfqKwa5FJeRGdXAp8yPWnYoBMxxqb/9H4=;
 b=am2ezs055zTQuTr/xKHAkx6p7gW9biSljCffOqY2nt0qugWxYHRmkNsg58Cm/e6lh3
 IsyLqWBJrY02FReBwTZo8kgqGd+AO5PcXpO5/kG7gpWbG4KgMiU/ebN+l3W/ZF4LE1xy
 1AdpufNcGU7soPeFq9NMiEWlJNhPQRzs0O6LJ2s+GcNWr5pTD1CqQK8P6PVvy69He3j+
 5j09d4BosEmBKI4MmQRaBFGq0w1HEIu5GBaPHRyqhxrqGCsMGiX0g+VJHp6lH4HNAsM9
 ZRXkOLED2X/uAw5uzUzMNtI0HncMfnTP1IZMam1grBbBhLn3yMVMhmpAvdk6qHW+lQFC
 n7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169257; x=1782774057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wjuhDqFA99bfqKwa5FJeRGdXAp8yPWnYoBMxxqb/9H4=;
 b=qDDWysIzD4iMeyndBca6z9AxkxR6fMYDALLX6cnQB78HAFWfRNIZ555tZ/VZlliL3m
 WYzjV4dvp91eMM/9aa85x7BHtgzzfLXwYZQj6X63pbCEnBfBwUTJ6oJgfahpwlgdWuNs
 JaXphNjkOXQC29M6GUqgzsdYAsTCxEdV2VqOftZUCRLbiU4K527A1+7jPXqrnfE/RCds
 UjURLtYkOI9w9PSTzbDnmVJ+Gu/h7+c2yBRjFMVra/i00OEGXJcQ8RjPWF/nwJPonYxL
 1pYiidzTbYsoLrHYseKguGO1/zszJJnntcww0gQUyWZvePorjKiB1Lmr7h+aVkQE5AiY
 taNA==
X-Gm-Message-State: AOJu0YyfHJVyxrUaZds129GCe9e1KMcc6jwrvmz7Q8ns/kLQc5QmWCCx
 0SyVKkNEvmo+aXHQNMyotLY7X9q6DQJTPKRU6Q9ia76fAFkH44tWUWz9hR1hAI1ndrNa+gVb5CD
 CoiKn0UpGnf3AmpuxeSxK0IB+MWf0A3EIQ8oDqL5CGTy/8Qjr/nrTbibTjVj84mMLbQ==
X-Gm-Gg: AfdE7ckenVWAvcee4rZSjHtQutqoqSJk8/S6AO3HnrBt88XdLsDIDlWdViiGdQkb//U
 mtwvBj+cCv4vfGMfBPV3euz5f049FW2t8GEcNOtctmNu7Jw3LowiMIzUR7q8cEZIkvS9exJvumm
 TYffmPBMEEQx3QITKlL08H3e2uV63EX/qi0coVJP7B5N3PWj3/upaH9HJ09+bmN6YL6tP4oVCLX
 N7QMTIHE/tXbiacYqPRcVYA6MMyofJZQHctgbgr2Hgsgqw+oEpsthoaNIX6kEFrR6CHm3uIIQ+j
 jZ5cCfVYg/WvS5dlPM19dzCHh0Tu+CrcK7LXHxR/2zijqV3B2nIsnyCUeH5im/yEIaRbJbUMrpj
 310oRb2nk4HJCeFPO37zxI46CTdrSbfjVc1JvE0F8Ss5ZMkgPS5CecY5vpuE=
X-Received: by 2002:a05:7022:11c:b0:139:819b:ec4f with SMTP id
 a92af1059eb24-139a205289amr10256314c88.14.1782169256797; 
 Mon, 22 Jun 2026 16:00:56 -0700 (PDT)
X-Received: by 2002:a05:7022:11c:b0:139:819b:ec4f with SMTP id
 a92af1059eb24-139a205289amr10256268c88.14.1782169255999; 
 Mon, 22 Jun 2026 16:00:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 72/75] target/hexagon: add build config for softmmu
Date: Mon, 22 Jun 2026 15:29:01 -0700
Message-Id: <20260622222904.607771-73-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: rmrbl7mZFboScHZkG1cRv6_vrGmygFYc
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a39beaa cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=S56xvJB5AAAA:8 a=nnu-IgKveahPCV3q3nEA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXxyoewYcnHCRv
 DEJtTgDSUqVoI61Ersxu5+h1NGCPX0soxLHTVPL6iV5CFekrkRXjkX026mGyQ0UAta5VvbhSiS1
 XWRfhC7vJpjQQlk1iK/9883E/AB5wCA=
X-Proofpoint-GUID: rmrbl7mZFboScHZkG1cRv6_vrGmygFYc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX9m2MGKXx7xvv
 SvHUqN79nA1J/5D8ywG1k8G3Cnto6HuJdEKOFAq8GWsNZ3K261W+rFDDBQUzOWf8SUeVyu5nEv8
 V4rh+hr4tl13kdiRVfWTTRIoHPvzKz1/wVc26hY7XyOY6+3AKz1dg/xgOuj2+y6K8CTPYQ093x1
 bwhWDcUgqNfQihU7/RtsJ/wOzqgWhxFWGqepkiEPgZgLtEYWpKZy1YwX9j16SaFzhbYXRK8soxR
 dOQ9475bV/b7EBsyeMK3J83MoG23AVW3KG5B2cSzVp18lOWCkCGE4pXj1w6pzffxxDH/4dJURFb
 PAunnxZ6byvX5TSZng1Z/9eyAHEBZpoWiM9iq7EUfTiuljkNS5cmILDPW6nwCPf/TCzRewaYJWb
 RUKk+nW2jNZPKvcbL0DVrRRT6l0NosYFrQ++orFNAEc9MpWF8/LR1lnn6ZN90qVh6PUY7o+bYyj
 3I9/ug58m049YnPJsVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220221
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

UmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJl
dmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29t
bS5jb20+CkFja2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG1haWxvLmNv
bT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
PgotLS0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSAr
CiBjb25maWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2RlZmF1bHQubWFrIHwgIDYgKysrKysr
CiBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hayAgICAgICAgIHwgIDcgKysrKysr
KwogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgICAgICAgICAgICAgICAgICB8ICA1ICstLS0t
CiB0YXJnZXQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwogdGFy
Z2V0L2hleGFnb24vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8ICAyICsrCiB0YXJnZXQv
aGV4YWdvbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgIHwgMTMgKysrKysrKysrKysrLQog
NyBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGNvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11Lm1hawog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL0tjb25maWcKCmRpZmYgLS1naXQgYS9N
QUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCmluZGV4IDQ0MDYzZDZlMTNiLi5jZGE0ZDU3YjQ5NSAx
MDA2NDQKLS0tIGEvTUFJTlRBSU5FUlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTI1Niw2ICsyNTYs
NyBAQCBGOiBsaW51eC11c2VyL2hleGFnb24vCiBGOiB0ZXN0cy90Y2cvaGV4YWdvbi8KIEY6IGRp
c2FzL2hleGFnb24uYwogRjogY29uZmlncy90YXJnZXRzL2hleGFnb24tbGludXgtdXNlci5tYWsK
K0Y6IGNvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrCiBGOiB0ZXN0cy9kb2NrZXIv
ZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyCiBGOiBnZGJzdHViL2dkYi14
bWwvaGV4YWdvbioueG1sCiBGOiBkb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QKZGlmZiAt
LWdpdCBhL2NvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsgYi9jb25m
aWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2RlZmF1bHQubWFrCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAwLi5mN2ZjODc0ZWIwYwotLS0gL2Rldi9udWxsCisrKyBiL2Nv
bmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsKQEAgLTAsMCArMSw2IEBA
CisjIERlZmF1bHQgY29uZmlndXJhdGlvbiBmb3IgaGV4YWdvbi1zb2Z0bW11CisKKyMgVW5jb21t
ZW50IHRoZSBmb2xsb3dpbmcgbGluZXMgdG8gZGlzYWJsZSB0aGVzZSBvcHRpb25hbCBkZXZpY2Vz
OgorCisjIEJvYXJkcyBhcmUgc2VsZWN0ZWQgYnkgZGVmYXVsdCwgdW5jb21tZW50IHRvIGtlZXAg
b3V0IG9mIHRoZSBidWlsZC4KKyMgQ09ORklHX0hFWF9EU1A9eQpkaWZmIC0tZ2l0IGEvY29uZmln
cy90YXJnZXRzL2hleGFnb24tc29mdG1tdS5tYWsgYi9jb25maWdzL3RhcmdldHMvaGV4YWdvbi1z
b2Z0bW11Lm1hawpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uZmRmYTI5
YjRmMzkKLS0tIC9kZXYvbnVsbAorKysgYi9jb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0bW11
Lm1hawpAQCAtMCwwICsxLDcgQEAKKyMgRGVmYXVsdCBjb25maWd1cmF0aW9uIGZvciBoZXhhZ29u
LXNvZnRtbXUKKworVEFSR0VUX0FSQ0g9aGV4YWdvbgorVEFSR0VUX1hNTF9GSUxFUz1oZXhhZ29u
LWNvcmUueG1sIGhleGFnb24taHZ4LnhtbAorVEFSR0VUX0xPTkdfQklUUz0zMgorVEFSR0VUX05P
VF9VU0lOR19MRUdBQ1lfTERTVF9QSFlTX0FQST15CitUQVJHRVRfTk9UX1VTSU5HX0xFR0FDWV9O
QVRJVkVfRU5ESUFOX0FQST15CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuaCBiL3Rh
cmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDRhMTJkYzA0NzI3Li43Njk0ZmQ5MWZhOCAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKQEAg
LTM4LDEwICszOCw3IEBAIHR5cGVkZWYgc3RydWN0IEhleGFnb25HbG9iYWxSZWdTdGF0ZSBIZXhh
Z29uR2xvYmFsUmVnU3RhdGU7CiAjaW5jbHVkZSAiaHcvY29yZS9yZWdpc3RlcmZpZWxkcy5oIgog
I2luY2x1ZGUgInFlbXUvYml0bWFwLmgiCiAKLSNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQotI2Vy
cm9yICJIZXhhZ29uIGRvZXMgbm90IHN1cHBvcnQgc3lzdGVtIGVtdWxhdGlvbiIKLSNlbmRpZgot
CisjaW5jbHVkZSAidGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkcy5oIgogCiAjZGVmaW5lIE5VTV9Q
UkVHUyA0CiAjZGVmaW5lIFRPVEFMX1BFUl9USFJFQURfUkVHUyA2NApkaWZmIC0tZ2l0IGEvdGFy
Z2V0L0tjb25maWcgYi90YXJnZXQvS2NvbmZpZwppbmRleCAzYzczZTNiYWUwMS4uMDI4OGEzZjQx
NjQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9LY29uZmlnCisrKyBiL3RhcmdldC9LY29uZmlnCkBAIC0x
Niw2ICsxNiw3IEBAIHNvdXJjZSBzaDQvS2NvbmZpZwogc291cmNlIHNwYXJjL0tjb25maWcKIHNv
dXJjZSB0cmljb3JlL0tjb25maWcKIHNvdXJjZSB4dGVuc2EvS2NvbmZpZworc291cmNlIGhleGFn
b24vS2NvbmZpZwogCiBjb25maWcgVEFSR0VUX0JJR19FTkRJQU4KICAgICBib29sCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9LY29uZmlnIGIvdGFyZ2V0L2hleGFnb24vS2NvbmZpZwpuZXcg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uN2U1NTZmMzUwNjMKLS0tIC9kZXYv
bnVsbAorKysgYi90YXJnZXQvaGV4YWdvbi9LY29uZmlnCkBAIC0wLDAgKzEsMiBAQAorY29uZmln
IEhFWEFHT04KKyAgICBib29sCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWls
ZCBiL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCmluZGV4IGZkM2Q2OWZlZmZkLi41OWNiMDlj
MTA3MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKKysrIGIvdGFyZ2V0
L2hleGFnb24vbWVzb24uYnVpbGQKQEAgLTIzNSw2ICsyMzUsNyBAQCBkZWNvZGV0cmVlX3RyYW5z
X2Z1bmNzX2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgY29tbWFuZDogW3B5dGhvbiwg
ZmlsZXMoJ2dlbl90cmFuc19mdW5jcy5weScpLCBzZW1hbnRpY3NfZ2VuZXJhdGVkLCAnQE9VVFBV
VEAnXSwKICkKIGhleGFnb25fc3MuYWRkKGRlY29kZXRyZWVfdHJhbnNfZnVuY3NfZ2VuZXJhdGVk
KQoraGV4YWdvbl9zb2Z0bW11X3NzID0gc3Muc291cmNlX3NldCgpCiAKIGhleGFnb25fc3MuYWRk
KGZpbGVzKAogICAgICdjcHUuYycsCkBAIC0yNTMsNiArMjU0LDE0IEBAIGhleGFnb25fc3MuYWRk
KGZpbGVzKAogICAgICdtbXZlYy9zeXN0ZW1fZXh0X21tdmVjLmMnLAogKSkKIAoraGV4YWdvbl9z
b2Z0bW11X3NzLmFkZChmaWxlcygKKyAgICAnY3B1X2hlbHBlci5jJywKKyAgICAnaGV4X21tdS5j
JywKKyAgICAnaGV4X2ludGVycnVwdHMuYycsCisgICAgJ2hleHN3aS5jJywKKyAgICAnbWFjaGlu
ZS5jJywKKykpCisKICMKICMgU3RlcCA0LjUKICMgV2UgdXNlIGZsZXgvYmlzb24gYmFzZWQgaWRl
Zi1wYXJzZXIgdG8gZ2VuZXJhdGUgVENHIGNvZGUgZm9yIGEgbG90CkBAIC0yNjIsNyArMjcxLDgg
QEAgaGV4YWdvbl9zcy5hZGQoZmlsZXMoCiAjICAgICBpZGVmLWdlbmVyYXRlZC1lbmFibGVkLWlu
c3RydWN0aW9ucwogIwogaWRlZl9wYXJzZXJfZW5hYmxlZCA9IGdldF9vcHRpb24oJ2hleGFnb25f
aWRlZl9wYXJzZXInKQotaWYgaWRlZl9wYXJzZXJfZW5hYmxlZCBhbmQgJ2hleGFnb24tbGludXgt
dXNlcicgaW4gdGFyZ2V0X2RpcnMKK2lmIGlkZWZfcGFyc2VyX2VuYWJsZWQgYW5kICgnaGV4YWdv
bi1saW51eC11c2VyJyBpbiB0YXJnZXRfZGlycyBvcgorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICdoZXhhZ29uLXNvZnRtbXUnIGluIHRhcmdldF9kaXJzKQogICAgIGlkZWZfcGFyc2VyX2lu
cHV0X2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgICAgICdpZGVmX3BhcnNlcl9pbnB1
dC5oLmluYycsCiAgICAgICAgIG91dHB1dDogJ2lkZWZfcGFyc2VyX2lucHV0LmguaW5jJywKQEAg
LTM5MCwzICs0MDAsNCBAQCBhbmFseXplX2Z1bmNzX2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQo
CiBoZXhhZ29uX3NzLmFkZChhbmFseXplX2Z1bmNzX2dlbmVyYXRlZCkKIAogdGFyZ2V0X2FyY2gg
Kz0geydoZXhhZ29uJzogaGV4YWdvbl9zc30KK3RhcmdldF9zeXN0ZW1fYXJjaCArPSB7J2hleGFn
b24nOiBoZXhhZ29uX3NvZnRtbXVfc3N9Ci0tIAoyLjM0LjEKCg==

