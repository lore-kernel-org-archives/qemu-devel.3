Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90603C43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIp-0005lc-4S; Mon, 29 Jun 2026 09:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHw-0003tW-8x
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHu-0006OQ-Ch
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TB5FsP2728548
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=DM7++QGB9GmTMFbDy49xEx0+EvG3fHygx+cTnWTwfqg=; b=ky
 xMRLGPXFhRjQqdj+2egHdUIneJ8+W1+dLPQ2CqwHHZis+w2RcUxRl5hrYTVbGhn5
 bjw5HMQfxGRTfR32JROVmHvt2S8Dd5bXxPBeUZbKm59fXVm1q8BF+sjDMd6FPtYo
 38EYYnKAVEn85a7igO2sEjSQ9wx6p2cNWtf0XT9/DQ0xmvqbEdKikzIVFXiKD/7b
 rJB6W2640PhGuCNey2BIDg0A1iNMEhPhQed+goqpUqvvDzrd1cT+99O7E9nlsuHb
 3Z+x1J48jIGb2h2ERM6TODonCQMQsWcCn3LvKkWfDaUCSYdZ+aAMuUHC1HiPIqvo
 kNN/kAqSIcfxZtR8VSJQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3qha8jsp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bf55c3f44aso23298035ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740676; x=1783345476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DM7++QGB9GmTMFbDy49xEx0+EvG3fHygx+cTnWTwfqg=;
 b=ggAQXSks204HIeIc8OQdktN87/e4UsBMW4LszNDgYGaBLkG+1ipt4tkYRstEFi4T/4
 Ydqaq+i7ByOBktZrRMK8A+ACUXzSi8JlTSKg4qkfdC1zH+1SwnXHx8W6qZ7l5VqvViMB
 vKzbx/Xo6KcLMwxz1sDDqw1mRQlUQx3d3m6BumSp7q4zbVPjyuExqVe1pZfF0557Js3t
 ya6ZjhL+USx02mAp5nW26W4PP/67xwzeS226dr8W+KNIE9iZGI1pvNTSWBvOMcd1/3/N
 e9YoQDimWGbQkPZ/qhd9Syel33tt0CcLYXGbycM74L9IHYbT4yxlRTJiUe5CHHl+sh8b
 TmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740676; x=1783345476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DM7++QGB9GmTMFbDy49xEx0+EvG3fHygx+cTnWTwfqg=;
 b=dgs5+HupCiyYgtTpT4Kpyg2MVeRD9f9iHRAZBY9IilRutJd4wdJLUYcuDTLkfjrwOx
 RuKSfD90T3D1/L/1zHj+JELNwMftZtzMH/Ait2E4uKqZZd0gWzUnZLpKeTgVy/OIBbGI
 n00qHhdIHdRmvmlZT/Xa3+Uam1qut1CkLsFCZmRCeesiRKGvrhRGUX39Q1q8AsjT0Bjp
 o6UTeNRb2rRmg+vcD9K56isijWg2VIKs1aKFx8F7GL6h6+mdpLfVJUQ7qdUIPIbhNtgT
 A5+qqwBfbybRXzWUtV7etYmrczsLkN5fZZodjzD4RYcJPn+zjk482zGQuo2i66YWySeM
 CDUg==
X-Gm-Message-State: AOJu0YyCB/FeDGRvlnI0uwCSMSsnQQ8YZqrtt1/eGA2UiKXtoTmZUpZ+
 nAeOL0Oy2szw5a2eFA8vLYdpjAYGXgf909ajfu2cHMvVvfJACyXlLQrHFHlGBbfbhwSwkYlxXoh
 7HAWYx/mQD5w2hKgAzpim666Uw0zahw/XJtFKbzCR25dM0j4D2cgQo2ikVfnVzIaeXA==
X-Gm-Gg: AfdE7clCfiZ4OaqP4s2Bq7a/IcWrkbB4VuRnJ5g41wvkcT9nKbi7dWGe8ZZoaC8qpIH
 D2w4ov067dD2gxvz7YbFcuphPcWqFOiE+w2jsY4DACysEqzCNeM623PUuRLLgB3I4tAkBkAwQQ7
 dTQyEXz8u1l3Blw4p8fT8Pd1pLj15pLTOTJhJNg9JPqHw4/NSR68Bv7FUk6X1zaTF/J4KaUsRVn
 7lneqFLvXnxWEHWs3+H+4XxIrzDqlgLV/emYkzzG0dGCsvsjFo/Uwqw6AvihZ3J7T8+4e1RzDnf
 GN4OaVLOaSetRsp+2iFC066130crSKvTbSAs8BM04a0JzfZTwomw0QF63k/E9lkhTllEh6kEw6w
 0m6IhsqyAtstah1aFvyoZS7N8LZ3WV0RNkevgwxX415pmpKXp9hEWfG6Mghk=
X-Received: by 2002:a17:903:f87:b0:2ca:feb:2aae with SMTP id
 d9443c01a7336-2ca0feb2cb0mr16842245ad.21.1782740676326; 
 Mon, 29 Jun 2026 06:44:36 -0700 (PDT)
X-Received: by 2002:a17:903:f87:b0:2ca:feb:2aae with SMTP id
 d9443c01a7336-2ca0feb2cb0mr16842015ad.21.1782740675842; 
 Mon, 29 Jun 2026 06:44:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v5 75/77] target/hexagon: add build config for softmmu
Date: Mon, 29 Jun 2026 06:12:30 -0700
Message-Id: <20260629131232.2487780-76-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: M3nZJ-lno54GNoOlC0gzXtnkdw37Ls5B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX4l6huS0zBHL4
 wh0EJvvVtT+vMJU8I4wAY0Yh82nD84YJV8JlKPFa8zug5Ma1YTsi/uCa9m8fD1pm2p9VIKiGMPl
 wthvnJbKTDUk6XzObR16vvTyIt1L0kLYe+Wnk2I2932Z2YHDXZdN6aThw209FcUMW/M/Etmm6Gx
 IwGobyRMJRmNqCO4uP+oLuD9k8XrX60amrY8N6HPJ2oSRoUtXuidOiUT8qmGhJyEpRJKQGBjt5R
 j/UjVVoBc0p+/Vir/WMePSfESsEuY+XfpTMLWRy/6Gvmz1zx1nLfpmzm4ZL6yGubSj6st4d/Aw4
 uGgxnRJL9H6FWKJdH68hCSbdojp9PBywVo6RowcDSM7C6SqPEcpYn5+YUGfv07USIqtSxKuuSJ4
 3hm17748UDuCERJJHRSoYzA+JBmdcw02L6aOInNg78C3n0JPDcc21mfZslSBkIEfUBrZLhsOXvZ
 ygcfgXlE3M50pC4jHHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX57OfTpG7Tzg1
 1xm63eIy8ZTw0rOrEYnL1ot4ISTfkPj/sbVGeFW04hkt+UMDmzTEIokyJr0p2tcU1H89hWJhC7G
 Mn1WpeJef/LdeEPRYcrRLIX10v5hY+g=
X-Authority-Analysis: v=2.4 cv=O9UJeh9W c=1 sm=1 tr=0 ts=6a4276c5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=S56xvJB5AAAA:8 a=nnu-IgKveahPCV3q3nEA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-ORIG-GUID: M3nZJ-lno54GNoOlC0gzXtnkdw37Ls5B
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
QUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCmluZGV4IDM5OThhYmFlY2YxLi4zYjMwNWQ4ZWQwYyAx
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

