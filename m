Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966C1CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Fa-0001sa-Sb; Fri, 29 May 2026 18:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5FN-0001ai-FG
 for qemu-devel@nongnu.org; Fri, 29 May 2026 18:00:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5FL-0001Fx-5w
 for qemu-devel@nongnu.org; Fri, 29 May 2026 18:00:05 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIQU7l876436
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0zLF50lL9Cmu9j8qij0E9tbWn/HgKIQuEfMHIJs/JPM=; b=NV+JjtlKHxyIgWy7
 5pB7sNqskVQtFiG0LPhtuf+d3KBmSDpgtMCeJHEMI+J+flalE2b2eDPnvJuddazc
 mRkOReTTiR4uB620pSB8cElOIkvRgShZnU20U4ISEWIr/15f1bbmMWKPjdEZvg03
 er8CjakYf9MdG1zZpM4+PGFQfO/QMsSoeyBtnHBdBKlwLP8fi7Gzz2SE/Ixb/0aP
 yhZv8TJCF19ZnPvlTwY/iti2sXRE5vU09fO+sqdfHqmjZntv4PXboS58XJKiIc7R
 P/cF3h7DfWnLxcktH3v7O6s1sBSsV2wGt3W5WyvfMGUbuAO5lDcJv0rrT89yRuDj
 SoZjqQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg340ugy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:59:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304d2447962so1481129eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091991; x=1780696791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zLF50lL9Cmu9j8qij0E9tbWn/HgKIQuEfMHIJs/JPM=;
 b=AYm7sxGir4gbd9taMbg6vJHV7NbSvhqAuFXx9zfnJ++O0OwLXDAp9LrRDIiq1G35ct
 7r//ANa4d7ZqT94UmBcCydd8mqo5JdQt4SOVAZSWwLsVzWVDH7yj+aY/1XgZXRC6KLMG
 r9j5Dl8H5Nhi/MAGa2N21MJdTp+oQ0OYGt+Jb0wf7xqnT3hsit0f0N3EDPkT871iMu4w
 j2UxUqBhlnEMnEufy8Ffu2CtIzHIPxJPeiXEyHEm7dRZsB95zUPFR1/WaZnuFWXNuYIV
 /m1swa4XlvUkJ3NlQjuBSA6w+j+XaxY3hs783VObzUc+z2HEvE03zvXJdEbzqs5qxXOq
 aciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091991; x=1780696791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0zLF50lL9Cmu9j8qij0E9tbWn/HgKIQuEfMHIJs/JPM=;
 b=WqVXF8VdnJwQUA1UE2BXsMiJ6Q6q+wgXDRgHDzmmv3baJcXUGel3jQLdWS6XHINlmj
 kin4UwIctYa7zmkKbIQlTGqCz5lfclU+GJxPkbbir4d/76DkkfTPGZgSRalzyUgqb/Pc
 3lfwejMAjd1dpufovCJ6DlODuwvRrGRYXXzag4eRm0YndsnYIHpMbdfbklHU0QpbTwEo
 JURAR6tg5Tge+X4e09kWrVZTMh240WUf5jbtb3FWdQGsftYG722pA5u9iErxAAI83ohU
 sxd+fhBGNFvZ7x5gU61l4xDWwRp9IW3Wn+gDkvcB/AoF1qxXaM9F6bDI28gQsT8nTqzF
 HsLg==
X-Gm-Message-State: AOJu0Yw/CyFjMZfeN7ApgVb7/rI99mZB65Mq+5dmsUR7sjXVYfqo/oJB
 rx+Z7Txjunp+ew+B1uI0Wc4n5ihyUq6RJF2Gy+fnvwNXPZ+vRzRheNQ7MtxRY94Nj3SzP4wUgwB
 +XjvxsBkcNVNWTAZOT1NfJfI5odYh342TE4cnsil0UKn0O2xPa0nlybgBLF7K8H1X5g==
X-Gm-Gg: Acq92OGEdvif+IhJn5u9PBE+1Whx1OVUE2aD90xiqBU/MFV29HNDEhvq3xJ6F5gMIf+
 CQb2W6ot3iefaC8d0H+DXPvYA3gjUUVuHewYXO+724KAFCCQxqwx9PAqPLz5hCcLuLjb52OoLC3
 bTgpaUbpTikoWHCOmIdYWODsMQhJGmcLuLM7ugiJoesl4vIY1lszIEJb+W9YHAn/B41ihC7QD9m
 Vv/JFSKdn5I+QQRzj/rM/bAJOWdsNheW76r98tmRXA2yZY43nliv0i7bldV1iS7aCVpaIxxcSM4
 ceRsY35rCTeQcGn2JESSf1YgSunoIfyaRJF2tCzdsxKKf87fLwyTJVc4E98uaszT+DmLFT9iboH
 Q7Tyh+5NqwDei7IusjiIhrUHSjmPhYByuFJT+adExTx+L1CNhWJml+ucU62g9zXcdW0n3s7bkgR
 IwAPyo
X-Received: by 2002:a05:7022:f96:b0:136:c2fa:32d6 with SMTP id
 a92af1059eb24-137d43d1db6mr545329c88.7.1780091990863; 
 Fri, 29 May 2026 14:59:50 -0700 (PDT)
X-Received: by 2002:a05:7022:f96:b0:136:c2fa:32d6 with SMTP id
 a92af1059eb24-137d43d1db6mr545318c88.7.1780091990306; 
 Fri, 29 May 2026 14:59:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69c0asm2101445c88.11.2026.05.29.14.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:59:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 7/9] target/hexagon: add build config for softmmu
Date: Fri, 29 May 2026 14:59:35 -0700
Message-Id: <20260529215937.610229-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215937.610229-1-brian.cain@oss.qualcomm.com>
References: <20260529215937.610229-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 5Wnf71kFT682InM_SiQTK4SbNawuQw8g
X-Authority-Analysis: v=2.4 cv=EOI2FVZC c=1 sm=1 tr=0 ts=6a1a0c57 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=CenlsehQYOEbj_0fHNQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 5Wnf71kFT682InM_SiQTK4SbNawuQw8g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX/uYunRck+Bj4
 2FPrbrRzRf/+zvf73qfDnIfu6/qakn1CuL8zhDsvMULur6ORX/R0nXFztHR6Fgeg2kvZ4L/7VML
 bOzgvS2IAXuW+FPql0TnscI6DwTLOKCwqVkDOyAXvH69NaDeQTKXXl3iHiWtKB9hYleFYN5qyQt
 25Gk5mAvrNF1VtmbnWb9tlvTw2acqiT+J12ivQE4Wy5WIk6MPDNf7uM/4SDGDUDMD2vBzWk1mMV
 hMx2J6/iQPK27py7cnP3Twi22rMd90Fk5llVQPM5qtB632RBT39hPND15gZ53ABBcyVhyRNu+XX
 os9UcKlAZTJnqKgko5FSm42XwjI1D3iqfAmRNFyfEgjXtPSW+soEqyz29ug4WVibXPq/wXj7Zg4
 a47Wolgk0ivh+FkjzftiAhl6VA9rI2mOKe8KZ7dBCWgz+4djG1F15rsGwdC6YZpKdSELNSr0Wtn
 6qm3Sxf1UEp7GL8NwXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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

UmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJl
dmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29t
bS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDEgKwogY29uZmlncy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hayB8ICA3ICsr
KysrKysKIGNvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrICAgICAgICAgfCAgNyAr
KysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgIDcg
Ky0tLS0tLQogdGFyZ2V0L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAx
ICsKIHRhcmdldC9oZXhhZ29uL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgfCAgMiArKwog
dGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICB8IDEzICsrKysrKysr
KysrKy0KIDcgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkK
IGNyZWF0ZSBtb2RlIDEwMDY0NCBjb25maWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2RlZmF1
bHQubWFrCiBjcmVhdGUgbW9kZSAxMDA2NDQgY29uZmlncy90YXJnZXRzL2hleGFnb24tc29mdG1t
dS5tYWsKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9LY29uZmlnCgpkaWZmIC0t
Z2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUwppbmRleCAwNTI4Mzg3Y2UxNy4uMmU4N2Y4
ZGE3MzggMTAwNjQ0Ci0tLSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0yNTcs
NiArMjU3LDcgQEAgRjogbGludXgtdXNlci9oZXhhZ29uLwogRjogdGVzdHMvdGNnL2hleGFnb24v
CiBGOiBkaXNhcy9oZXhhZ29uLmMKIEY6IGNvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLWxpbnV4LXVz
ZXIvZGVmYXVsdC5tYWsKK0Y6IGNvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVs
dC5tYWsKIEY6IGRvY2tlci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5kb2NrZXIK
IEY6IGdkYnN0dWIvZ2RiLXhtbC9oZXhhZ29uKi54bWwKIEY6IGRvY3Mvc3lzdGVtL3RhcmdldC1o
ZXhhZ29uLnJzdApkaWZmIC0tZ2l0IGEvY29uZmlncy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9k
ZWZhdWx0Lm1hayBiL2NvbmZpZ3MvZGV2aWNlcy9oZXhhZ29uLXNvZnRtbXUvZGVmYXVsdC5tYWsK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjA4ZTcwOWFlYTcyCi0tLSAv
ZGV2L251bGwKKysrIGIvY29uZmlncy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1h
awpAQCAtMCwwICsxLDcgQEAKKyMgRGVmYXVsdCBjb25maWd1cmF0aW9uIGZvciBoZXhhZ29uLXNv
ZnRtbXUKKworIyBVbmNvbW1lbnQgdGhlIGZvbGxvd2luZyBsaW5lcyB0byBkaXNhYmxlIHRoZXNl
IG9wdGlvbmFsIGRldmljZXM6CisKKyMgQm9hcmRzIGFyZSBzZWxlY3RlZCBieSBkZWZhdWx0LCB1
bmNvbW1lbnQgdG8ga2VlcCBvdXQgb2YgdGhlIGJ1aWxkLgorIyBDT05GSUdfSEVYX0RTUD15Cisj
IENPTkZJR19MMlZJQz15CmRpZmYgLS1naXQgYS9jb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0
bW11Lm1hayBiL2NvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi5mZGZhMjliNGYzOQotLS0gL2Rldi9udWxsCisr
KyBiL2NvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrCkBAIC0wLDAgKzEsNyBAQAor
IyBEZWZhdWx0IGNvbmZpZ3VyYXRpb24gZm9yIGhleGFnb24tc29mdG1tdQorCitUQVJHRVRfQVJD
SD1oZXhhZ29uCitUQVJHRVRfWE1MX0ZJTEVTPWhleGFnb24tY29yZS54bWwgaGV4YWdvbi1odngu
eG1sCitUQVJHRVRfTE9OR19CSVRTPTMyCitUQVJHRVRfTk9UX1VTSU5HX0xFR0FDWV9MRFNUX1BI
WVNfQVBJPXkKK1RBUkdFVF9OT1RfVVNJTkdfTEVHQUNZX05BVElWRV9FTkRJQU5fQVBJPXkKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5k
ZXggYjE4OGNjYzNjNmQuLjc2OTRmZDkxZmE4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9j
cHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtMzgsMTIgKzM4LDcgQEAgdHlwZWRl
ZiBzdHJ1Y3QgSGV4YWdvbkdsb2JhbFJlZ1N0YXRlIEhleGFnb25HbG9iYWxSZWdTdGF0ZTsKICNp
bmNsdWRlICJody9jb3JlL3JlZ2lzdGVyZmllbGRzLmgiCiAjaW5jbHVkZSAicWVtdS9iaXRtYXAu
aCIKIAotI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCi0jZXJyb3IgIkhleGFnb24gZG9lcyBub3Qg
c3VwcG9ydCBzeXN0ZW0gZW11bGF0aW9uIgotI2VuZGlmCi0KLSNpZm5kZWYgQ09ORklHX1VTRVJf
T05MWQotI2VuZGlmCisjaW5jbHVkZSAidGFyZ2V0L2hleGFnb24vcmVnX2ZpZWxkcy5oIgogCiAj
ZGVmaW5lIE5VTV9QUkVHUyA0CiAjZGVmaW5lIFRPVEFMX1BFUl9USFJFQURfUkVHUyA2NApkaWZm
IC0tZ2l0IGEvdGFyZ2V0L0tjb25maWcgYi90YXJnZXQvS2NvbmZpZwppbmRleCAzYzczZTNiYWUw
MS4uMDI4OGEzZjQxNjQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9LY29uZmlnCisrKyBiL3RhcmdldC9L
Y29uZmlnCkBAIC0xNiw2ICsxNiw3IEBAIHNvdXJjZSBzaDQvS2NvbmZpZwogc291cmNlIHNwYXJj
L0tjb25maWcKIHNvdXJjZSB0cmljb3JlL0tjb25maWcKIHNvdXJjZSB4dGVuc2EvS2NvbmZpZwor
c291cmNlIGhleGFnb24vS2NvbmZpZwogCiBjb25maWcgVEFSR0VUX0JJR19FTkRJQU4KICAgICBi
b29sCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9LY29uZmlnIGIvdGFyZ2V0L2hleGFnb24v
S2NvbmZpZwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uN2U1NTZmMzUw
NjMKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdvbi9LY29uZmlnCkBAIC0wLDAgKzEs
MiBAQAorY29uZmlnIEhFWEFHT04KKyAgICBib29sCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9tZXNvbi5idWlsZCBiL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCmluZGV4IDUyOGJlY2Ez
Y2QwLi5iYzdhMjkyZTQ3YiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQK
KysrIGIvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKQEAgLTIzNSw2ICsyMzUsNyBAQCBkZWNv
ZGV0cmVlX3RyYW5zX2Z1bmNzX2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgY29tbWFu
ZDogW3B5dGhvbiwgZmlsZXMoJ2dlbl90cmFuc19mdW5jcy5weScpLCBzZW1hbnRpY3NfZ2VuZXJh
dGVkLCAnQE9VVFBVVEAnXSwKICkKIGhleGFnb25fc3MuYWRkKGRlY29kZXRyZWVfdHJhbnNfZnVu
Y3NfZ2VuZXJhdGVkKQoraGV4YWdvbl9zb2Z0bW11X3NzID0gc3Muc291cmNlX3NldCgpCiAKIGhl
eGFnb25fc3MuYWRkKGZpbGVzKAogICAgICdjcHUuYycsCkBAIC0yNTMsNiArMjU0LDE0IEBAIGhl
eGFnb25fc3MuYWRkKGZpbGVzKAogICAgICdtbXZlYy9zeXN0ZW1fZXh0X21tdmVjLmMnLAogKSkK
IAoraGV4YWdvbl9zb2Z0bW11X3NzLmFkZChmaWxlcygKKyAgICAnY3B1X2hlbHBlci5jJywKKyAg
ICAnaGV4X21tdS5jJywKKyAgICAnaGV4X2ludGVycnVwdHMuYycsCisgICAgJ2hleHN3aS5jJywK
KyAgICAnbWFjaGluZS5jJywKKykpCisKICMKICMgU3RlcCA0LjUKICMgV2UgdXNlIGZsZXgvYmlz
b24gYmFzZWQgaWRlZi1wYXJzZXIgdG8gZ2VuZXJhdGUgVENHIGNvZGUgZm9yIGEgbG90CkBAIC0y
NjIsNyArMjcxLDggQEAgaGV4YWdvbl9zcy5hZGQoZmlsZXMoCiAjICAgICBpZGVmLWdlbmVyYXRl
ZC1lbmFibGVkLWluc3RydWN0aW9ucwogIwogaWRlZl9wYXJzZXJfZW5hYmxlZCA9IGdldF9vcHRp
b24oJ2hleGFnb25faWRlZl9wYXJzZXInKQotaWYgaWRlZl9wYXJzZXJfZW5hYmxlZCBhbmQgJ2hl
eGFnb24tbGludXgtdXNlcicgaW4gdGFyZ2V0X2RpcnMKK2lmIGlkZWZfcGFyc2VyX2VuYWJsZWQg
YW5kICgnaGV4YWdvbi1saW51eC11c2VyJyBpbiB0YXJnZXRfZGlycyBvcgorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICdoZXhhZ29uLXNvZnRtbXUnIGluIHRhcmdldF9kaXJzKQogICAgIGlk
ZWZfcGFyc2VyX2lucHV0X2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgICAgICdpZGVm
X3BhcnNlcl9pbnB1dC5oLmluYycsCiAgICAgICAgIG91dHB1dDogJ2lkZWZfcGFyc2VyX2lucHV0
LmguaW5jJywKQEAgLTM5MCwzICs0MDAsNCBAQCBhbmFseXplX2Z1bmNzX2dlbmVyYXRlZCA9IGN1
c3RvbV90YXJnZXQoCiBoZXhhZ29uX3NzLmFkZChhbmFseXplX2Z1bmNzX2dlbmVyYXRlZCkKIAog
dGFyZ2V0X2FyY2ggKz0geydoZXhhZ29uJzogaGV4YWdvbl9zc30KK3RhcmdldF9zeXN0ZW1fYXJj
aCArPSB7J2hleGFnb24nOiBoZXhhZ29uX3NvZnRtbXVfc3N9Ci0tIAoyLjM0LjEKCg==

