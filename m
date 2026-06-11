Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8522DCD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXz2-0007jq-Ue; Thu, 11 Jun 2026 01:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyu-0007hZ-4I
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyp-0000pk-QI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:31 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GSGx3792213
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=; b=F5
 yYGsoIMJtP3sUqyks/vCmiVa8dVMm7M0wWnDPj2SCOcNT428geXNf7McjWujBkT1
 DixO5eTwTqGdHYh4eCUsKNOC6kMVSsumlIn1opVruNBdoMK1OjcFs4IeEv0xGB1v
 UcafFIw2o9NgN0f6e9nAF7gdPASfP5/+GqAYlpSNJu0ZOHfWFVprIcVR7RQ09Qdu
 /HGYW+oyeACtO5xmZBVUdv4+2+kJ8pNEkR07rt/TqIVimPJ26lHc+TaEtrk8+f/Q
 26GF3u2raXdcc4JWDTv+APDlnrLezigiTepCDArvQNYQJmL4hzViIja34lQunl2A
 /5ct1h0seaBJbDK5K4nA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe701s1u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3075fa5a407so14559519eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155765; x=1781760565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=;
 b=DXjnAugDER/F8oORMEJD1/J4ca8dLIpMbNXP2D+CjfvR4rEiPzWBmtZn6aF1ZgOkp5
 yXRmElOLV4RUryJOIV6NHvAaz6/0Z1Xo21QgUiFaEG5/CFMmKdxyaBOWx5fE7Dv3tZRk
 ddgP5sUAsckTMs7uvUkdal2R1dwxWCqArdJWe2xtpfC5YvGmap1UDXF7w253Sm/AdoQb
 /Eyp1lmqBg/EXPFk2O3/eecU8bsdc2oAnZFy4qX/+9LOuRWaflqvxmYevF8BIw3JwHco
 ig1hLF19RUjIM6AVeht7q9KWuEHex9eDxKsh4giINwr/FJXUVWdLsr+wYJX08TJQvaFf
 xWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155765; x=1781760565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AWqgRF4Ibw8S5E/4OIgHvd5Hhd9R0yIZ8RFAsz/XZEg=;
 b=P7shhGN+hPmnKadslYOvOpKZ1W4ZvOxufxzOtyJGjAMQ8tjwCAWcMcjqg24wPPG7fL
 u3Ljifq54iETqcQ6npDIEsf1uT3SzmhYcvM6jKwIpGRrfqnZFtLWejSmUwTZ98jxtRDS
 EjvPVCmZU67r3bFp3knoIphKfdZhCF8crs7I/XNWrhK69XKi3zInI2QGOTNE7dMq5tlr
 D4gemXCs2mGCNTXrrf2ki+4tSeJcjQibsj30ihZSsV543STedhlQ7nD3F06xj7p7XcyA
 k1unOEcf6yQ4WLksGK2LMS4YG2/ivHV3rwHo/OKhY3RJqQ76E9US5wsPHokFKMyRO8/y
 SVGA==
X-Gm-Message-State: AOJu0YzAgvF/fP4UxJbTV90Cxo1XXn3kWF6fp4hZRKHAyTeep86zKqpt
 BQaOuwHEu3s1Oaj64w5Lkb/RV85FRfW/lx+P9hkwrXEreK7WvgzrDhMya/znZzHj2B2BZWAsrPY
 sVhPXG3lOJvK6Bd6j/nuFFqDagwFVfafOXi4J1p32TrABS4UNGmjXM8/XeB6+4xPXdw==
X-Gm-Gg: Acq92OEi6oPYApOtMexKME04CdICNgHgw1dhtT9AUsxZrSZxC7jR+w1gubNZsifjRxi
 eDylKlXCBI0GEo8/ycM8oyaZcazOBWglLUJVAjKV8NCNVkwgpETcLUE8SszFJusmITLpLoDEjwa
 i7jHI1FSpzoe+UfsBZy0uOiBnoQ90NqKyix1ssOeW4wIUq2A0Fj4cCP6HEOv8UXjrjcaM35bMXR
 Z/D/CYnWzAMQhaf7S11/TPJ7zh4ydLlrLmIib9rdcJYV2zTbjBnALw2cLnDR4jexHoM5gcaW128
 5DMCiqeiNudq6O9Ylq/hlEdBDVNM5oTNsulJeXx+wKpnrruevvIy1wXudbXBMc1m/pAatHI2zp7
 38WZC1ddlWyx3egDr5IwUD8mdy3J+70GS9wGagbFs1Z4bkVRh9S04KqUkJCIvA4CVyiQjtjMZSh
 J9vDhZ
X-Received: by 2002:a05:7300:6425:b0:304:e2a5:689a with SMTP id
 5a478bee46e88-308049fd34cmr1024581eec.21.1781155764794; 
 Wed, 10 Jun 2026 22:29:24 -0700 (PDT)
X-Received: by 2002:a05:7300:6425:b0:304:e2a5:689a with SMTP id
 5a478bee46e88-308049fd34cmr1024563eec.21.1781155764260; 
 Wed, 10 Jun 2026 22:29:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8] target/hexagon: Add TCG values for sreg, greg
Date: Wed, 10 Jun 2026 22:28:33 -0700
Message-Id: <20260611052857.3911981-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MCBTYWx0ZWRfXwnqnEFNn5PCk
 vDt7/16UU9FcOislD7vE/6M4RsO6qtUbgT2W7wSMejM6UHr5HMBEYeyNDtucTaMm9FHIxJ+irNY
 Iec0aCGbza+UkgCstRznMfhH5zMDzvlJBKrvGPON3Xgl3y7EAR1ene0E8i8IHkcD/VxLh7S0yfs
 9ockwBdNFKfHrZHvFgE42DKj/DrQcd4xL4UlOeXjZbDdq/2oqTI9M+O+JshS6UA0S33bqg3FIZC
 Hjdv6PP13B/hxj0X7BS0EB7bq7olfKg7ym+gmEAuA13Q3F9IxfxmBrr+LRKSQ8ZytSU1p+LePQu
 PHfWeJB+gmCDmDUXR9TvWxDSaYZDFvZyvduiQxGgB/c4aaEl/QV1sEXTBJKFeBhq4xV1/gfupE9
 pwGluKM8JEhLufcES/rO3H83yqsmOmzUKwsO5OtibzStJkftXRjwUgEaLCeDZ+V1slFLmK7PUJT
 wcNNRnYTHV+LWaq2/0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MCBTYWx0ZWRfXxJBkxY41uPXV
 S0MIurBWl8iBpHbhPu+bifkR8I5AIYp5z6177em2CJP7soG38nPTIMhaSXZ57knIDzGVS3Ybu2L
 z7gZeS2gOkA4t6dsEfguNrOmFpKpm0w=
X-Proofpoint-GUID: fXYiQXJ_DQwqz2OzLAFlOlbehj201KJ9
X-Proofpoint-ORIG-GUID: fXYiQXJ_DQwqz2OzLAFlOlbehj201KJ9
X-Authority-Analysis: v=2.4 cv=Z5Tc2nRA c=1 sm=1 tr=0 ts=6a2a47b5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=8kp5zrIFwsha1M26KQwA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110050
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTYgKysr
KysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuaAppbmRleCBkODBiYzUzMmUyNC4uZDhlZWE1NjE5MWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0y
ODIsNiArMjgyLDExIEBAIGV4dGVybiBUQ0d2X2k2NCBoZXhfbGxzY192YWxfaTY0OwogZXh0ZXJu
IFRDR3YgaGV4X3ZzdG9yZV9hZGRyW1ZTVE9SRVNfTUFYXTsKIGV4dGVybiBUQ0d2IGhleF92c3Rv
cmVfc2l6ZVtWU1RPUkVTX01BWF07CiBleHRlcm4gVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNU
T1JFU19NQVhdOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitleHRlcm4gVENHdl9pMzIgaGV4
X2dyZWdbTlVNX0dSRUdTXTsKK2V4dGVybiBUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107
CisjZW5kaWYKKwogCiB2b2lkIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihEaXNhc0NvbnRleHQg
KmN0eCwgaW50IGV4Y3ApOwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUu
YyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGQ2MTY1OGE3OThjLi45Nzg0OWFi
ODYxYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTY2LDYgKzY2LDggQEAgVENHdiBoZXhfdnN0b3JlX3Np
emVbVlNUT1JFU19NQVhdOwogVENHdiBoZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwog
CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK1RDR3ZfaTMyIGhleF9ncmVnW05VTV9HUkVHU107
CitUQ0d2X2kzMiBoZXhfdF9zcmVnW05VTV9TUkVHU107CiBUQ0d2X2kzMiBoZXhfY2F1c2VfY29k
ZTsKICNlbmRpZgogCkBAIC0xMDg0LDYgKzEwODYsMjAgQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0
ZV9pbml0KHZvaWQpCiAKICAgICBvcGNvZGVfaW5pdCgpOwogCisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVNX0dSRUdTOyBpKyspIHsKKyAgICAgICAgICAg
IGhleF9ncmVnW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3X2kzMih0Y2dfZW52LAorICAgICAgICAg
ICAgICAgIG9mZnNldG9mKENQVUhleGFnb25TdGF0ZSwgZ3JlZ1tpXSksCisgICAgICAgICAgICAg
ICAgaGV4YWdvbl9ncmVnbmFtZXNbaV0pOworICAgIH0KKyAgICBmb3IgKGkgPSAwOyBpIDwgTlVN
X1NSRUdTOyBpKyspIHsKKyAgICAgICAgaWYgKGkgPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAg
ICAgICAgICAgIGhleF90X3NyZWdbaV0gPSB0Y2dfZ2xvYmFsX21lbV9uZXdfaTMyKHRjZ19lbnYs
CisgICAgICAgICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0X3NyZWdbaV0pLAor
ICAgICAgICAgICAgICAgIGhleGFnb25fc3JlZ25hbWVzW2ldKTsKKyAgICAgICAgfQorICAgIH0K
KyNlbmRpZgogICAgIGZvciAoaSA9IDA7IGkgPCBUT1RBTF9QRVJfVEhSRUFEX1JFR1M7IGkrKykg
ewogICAgICAgICBoZXhfZ3ByW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3KHRjZ19lbnYsCiAgICAg
ICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGdwcltpXSksCi0tIAoyLjM0LjEKCg==

