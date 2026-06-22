Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188FCCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9F-0003Np-1G; Mon, 22 Jun 2026 18:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9D-0003Nc-Sj
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9C-0006Qf-AT
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJbKMF2122737
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=; b=pGfKodynrFK1vazY
 Xf0jCKyFJ+IVOjup4k+M0adYBPiHuEJp9xTAZQWRc4FxryNE1o0nWxOzV68EYQua
 tI39CZc9H3AZ1BuINkN+AJjclrEbQGQLF8g8vrPiae9I9TWuK1Kt4xGZgSufj+WA
 5jH96UF5vlJjhqTB3o786CPJdCSXLr/kdJZf7vBmHnwYMv8PBV7vQViotN/WF/6e
 jtBOTe7QwaRy1rq+E+jOJy+scGElxqhcqeTRVxYChZuKelrrKw0CX9W6lv/CCE89
 yLITnJm/lhJrHT48fS8t6k3dzrqbhCEFxGureL1B+Ut5TOmkL6DXpnVT02oQ6ng2
 g4zdBA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n41xwc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c03c1dda3so6315691eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167370; x=1782772170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=EIU91NIpe1KRdkiBnQ6F3fZsa9qzApe3SGmLYipfUJe0ok+FvqN5ImrhSluQJb4OHK
 nKEyLEQU5wcaXZR6No/l6Q7jpBwEDIeOkIJ6xNqcTbPfF/r2g/eZmhdJUsYdjBl+oSZw
 ucBVDvc6QxkDTz6XzXXkkiQg6+hGmzajoh22bZwKj1IBhWqivCOIpK46y4v/hRPOLhD6
 yFjOsjAizcYLFQKIV4WL7z2m3vi2v5vvYQ8+bzUYoZLaHWIOySZoXTFp/TzSu39GCgEV
 MXOA9Gd4MlNN1WB4ni+BsPalXkyB9fJSMkCMA0qD8XhA+Eh6U6sNZsekY+b+XPqTHL0C
 FAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167370; x=1782772170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=aavIJU+gr7BSSm/EthmQHrWqM1bVnYwqt0LIoAWhHdxsVcI37fApZtJHTiRpkSaGm8
 Axo1TFw8HTGyjUrw5kjf9mcN9r7FSBJSK/qObYrs2YkxDv2WcmRew94/zhRZOzsyIfgx
 kzBxIjkPKVuxgnFw2CW3wK9Skh5H7a1Natqn95rtJNwr445lWH3koQQE4Y3CDbcDJARA
 lsZFVCznR7yEA5FBCq1XJnHn3AeXK8/zG3+95LZbHAlL7h6eApGvB9FRLlEax1yjqVyE
 Z7S825FZUWn5zKEb7fKsJS0e6SvUpMijlzNzD1qKZTbzhF1F4S+inR9yRNqUCuaiiL2/
 5vGg==
X-Gm-Message-State: AOJu0YwAvuJyHspH39nIbOQEKVXrdOUd8IZ9YOWIjd8IPvB6y9NaXayS
 FMC4eIyoIxzYbHhq1QBUkOoYhDCFGZScoShQb7czqe9/vTRGgXaBmduo8eC7M1jH7Hc5c1zLDqM
 5RlmhODiXcVZI6wj7cKvy6cu04HIFJ1T0Bw2n0Om5AXsVBhBK8Hs+HbN0Kf0bDIgvMw==
X-Gm-Gg: AfdE7clQ2xPP6ePczxFNOTtkV40ex790B4azhK43L0Jd4fAFTNr3lqIskghsnRRJp1f
 eulCgjZ0YcbidOEY98ueL/fuU3chLnxc4VbwWhTAlL5jwL+BVxvSaxoLHVT46UfhaGC+Bcx6ngp
 xiT4t4x068p4EqTbKkq3rq6DHNNvY0OfI9ziqpN2qnjCyRlUsncPZzFIjvgi6IDkh353buD/7Yp
 zmCulWWnwuF5op5fmcbEqVuS/lWphcDTZNwwGWwXmki8+BIC2J/fXN2aNUcRxeeAT0c+/s+8Aub
 LpWDIA3XHbzidYPVejS2CuE3KvSG2ZbMIc/+TXtxr+9Aqme0KVoc/HTeSFL4/m2C4uvt8IEyiXB
 S1Mxk7EV6E+YmabPK8K4wPpJ/J9fr+bBV90g3IK0YDabE1u6BXR8tXCflFDE=
X-Received: by 2002:a05:7300:641b:b0:30b:b65d:ef87 with SMTP id
 5a478bee46e88-30c1d9c69femr8891384eec.9.1782167370443; 
 Mon, 22 Jun 2026 15:29:30 -0700 (PDT)
X-Received: by 2002:a05:7300:641b:b0:30b:b65d:ef87 with SMTP id
 5a478bee46e88-30c1d9c69femr8891352eec.9.1782167369821; 
 Mon, 22 Jun 2026 15:29:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 12/75] target/hexagon: Add guest, system reg number state
Date: Mon, 22 Jun 2026 15:28:01 -0700
Message-Id: <20260622222904.607771-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX57cQBpSmMuom
 qaPaK6A8uFMCfzrCijfgIppylu4ocutlbl8HP+yU8LC633hmCbgrznwCBsV/pFQYWGo5phxCMae
 GlG609fBM0l4xA1ACnFCZSQgDz7L25g=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a39b74b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ikZfMmNF8Hme0_TNbpMA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: nU-MywmE8rpNCG_qtqB69W4xov46aSej
X-Proofpoint-GUID: nU-MywmE8rpNCG_qtqB69W4xov46aSej
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX+MZ2fixKuKAJ
 oHSm+wKGgyMbKfiim8/fEMWGnivvEptczasYrVwQbXIvMoxLeNwrfVYzvD8fB5BIfCnROYGrWhf
 RBwRB6jQgRREosZstIQkBnTpgk3e1BCNzf1/p1FyFB8drwCfdoicrpQ/wgPIRiK8UQHrlGSyuqq
 LZ3woxYLES2SGgj8hA90mzX5k5kWPJJTBT/TFSrwkI6zR0Rfs5EzYP5AtF6fT3Cs26zEjSr6D7n
 Wx+Rg8ti55qXB7s7P5ZzLvGzKkFxOWmjYvmd0Bk83w5eiJBn+CNf9QPs/brvtsfyJZEcPbcZRwt
 0jOywZejkihJ5scC/3AirgbmxJkzhSW2Gerf+AKvewZOZAsuu77ZFu1gLZ79b5ppT82lCbPZKzf
 ZK9eFzzFE0PtM7x8JQq6EFwN8lOqXS8fWJMdGGdFoZkUwlP5MYAPzGexqc4OWMutt43Jn8MOo6h
 FckcTlaSDe9AhbaiGkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220216
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
dS5oIHwgMTEgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgIDUgKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggZTBjZjg3ZTVhNGMuLjRiZWE5
NTNhYzczIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuaApAQCAtMTAwLDYgKzEwMCwxNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVBcmNoU3Rh
dGUgewogICAgIHRhcmdldF91bG9uZyBzdGFja19zdGFydDsKIAogICAgIHVpbnQ4X3Qgc2xvdF9j
YW5jZWxsZWQ7CisKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIC8qIFNvbWUgc3lzdGVt
IHJlZ2lzdGVycyBhcmUgcGVyIHRocmVhZCBhbmQgc29tZSBhcmUgZ2xvYmFsLiAqLworICAgIHVp
bnQzMl90IHRfc3JlZ1tOVU1fU1JFR1NdOworCisgICAgdWludDMyX3QgZ3JlZ1tOVU1fR1JFR1Nd
OworICAgIHVpbnQzMl90IHdhaXRfbmV4dF9wYzsKKworICAgIC8qIFRoaXMgYWxpYXMgb2YgQ1BV
U3RhdGUuY3B1X2luZGV4IGlzIHVzZWQgYnkgaW1wb3J0ZWQgc291cmNlczogKi8KKyAgICB1aW50
MzJfdCB0aHJlYWRJZDsKKyNlbmRpZgogICAgIHRhcmdldF91bG9uZyBuZXdfdmFsdWVfdXNyOwog
CiAgICAgTWVtTG9nIG1lbV9sb2dfc3RvcmVzW1NUT1JFU19NQVhdOwpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA1YmY2ZTg1Yjkz
OS4uZDMwZTViNjRlYWMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2NwdS5jCkBAIC0yOTksNiArMjk5LDExIEBAIHN0YXRpYyB2b2lkIGhleGFn
b25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQogICAgIHNldF9m
bG9hdF9kZXRlY3RfdGluaW5lc3MoZmxvYXRfdGluaW5lc3NfYmVmb3JlX3JvdW5kaW5nLCAmZW52
LT5mcF9zdGF0dXMpOwogICAgIC8qIERlZmF1bHQgTmFOIHZhbHVlOiBzaWduIGJpdCBzZXQsIGFs
bCBmcmFjIGJpdHMgc2V0ICovCiAgICAgc2V0X2Zsb2F0X2RlZmF1bHRfbmFuX3BhdHRlcm4oMGIx
MTExMTExMSwgJmVudi0+ZnBfc3RhdHVzKTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAg
IG1lbXNldChlbnYtPnRfc3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9TUkVHUyk7Cisg
ICAgbWVtc2V0KGVudi0+Z3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9HUkVHUyk7Cisg
ICAgZW52LT53YWl0X25leHRfcGMgPSAwOworI2VuZGlmCiAgICAgZW52LT5jYXVzZV9jb2RlID0g
SEVYX0VWRU5UX05PTkU7CiB9CiAKLS0gCjIuMzQuMQoK

