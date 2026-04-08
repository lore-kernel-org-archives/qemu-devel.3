Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB52710F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYPN-0001P0-AH; Wed, 08 Apr 2026 15:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAYNZ-0007d7-8U
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:15:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKQR-0005im-Ul
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:22:01 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637NfjVW1259485
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LEWN7D4QBDCm/3YwyXJ1nbi+9jJyq8HjarAU/LQbQ9I=; b=QoE83GtjKvfE41xA
 tTxBq1U0/WDnQky6tQ3Go1twPIP9S2cFnHROPpPhuDnWdRhDzjsxIPTtWSPyUvg2
 1Aq5sP64la0JyJ9FVltY9o+jnrL8A5Xp/6t6IfBN0rEyfJq0zqgrOfbtXhzmFfls
 gGjGb22U0RavZOc5mJQk5QM5fHBEtR17y5RqIfHUaZjyxmHExeTGNAjZF/RlSnvP
 j5ALAUezwsulOBIoVZBQPSxVnYNpVpZTIuQRYKKMUa2aexkNPIxaVNmFdddx9UXD
 g6hV5g66CNZ8BrU0VY5zWd/lvWw7WIUIXHWpVANQ8hVk9KLL/9Zo/kRD9N1hiVmj
 aie9Ig==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddbttrqur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:21:58 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c20a91932so4018113c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622118; x=1776226918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEWN7D4QBDCm/3YwyXJ1nbi+9jJyq8HjarAU/LQbQ9I=;
 b=OwaVBctp0su/eA2VtjK6zg6i8QimafpHZOlcXdcPX4hERhIgaOe/jNKIbcfm0/slzj
 QzHwaEzYOwVr6445ZnO6o7J1KLhoASFpqR88zX+IhXxa6hk8/OP9MULLL9+Q60B6xXaO
 Ezju1YxBJ7LNqIeCdmja/+M6VSg/UdlyhT4YU4Z0Ypcq7NDUvxwSb245xVcGTrQg18DI
 2bRf1DkC7B2aoLXzfHGE5SCOBeazR21tYQHeyb8sS5AHDdKGEvugZH3mD5VMgAY5EDv4
 b6elGA/8gDxDWbYii9D9ELz0s5b6Rkw2mvgG3L8wCZAib9a/+ivYvbn4eaSxhP8kDQ3V
 ohpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622118; x=1776226918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LEWN7D4QBDCm/3YwyXJ1nbi+9jJyq8HjarAU/LQbQ9I=;
 b=K4M5ZWzqC8wYlmYcT1dAboN1uFYk2FE4cgbFWKpg+W0o/VW+0bd+kRzwBDoS2oN3p5
 QV/8QoPA3T7gCm9ivcnu7eyJFBJX68eEL4+WLckoU0z0sJUp8p5FE2LQIFDMYzd0nO3Q
 S+QZd7htTXb/zQLDWhK7GGBmlC1UOABOVCKN80UQCoXTX30+Yq32PQRTW/OKgk1J5QqF
 ecEkpXW1fFiwygEpUPXGhcR3QOJEju1LPWEO/0RjcU0TQ9LnNe1RYpppubNdVaOzgFQI
 qd4XHcVhotmdQ50aOz4m1WWCGav3PkPJkcNv0vGPM6ZvlbQx6/M/0vav5IvSMduBHwWe
 nxSg==
X-Gm-Message-State: AOJu0Yz2uFKEDMt/TW92BLOnBZlb/f0n8ohAWjEZIJ4W47tPgfKu6esm
 vyBqK39mW0vzf2lst80RPP7gSM2Wgix1ippHHSls7UtJbrGjJNN0pRLSLPpno93DMPYBgTrSY2S
 B0j71KhrLSlETnl74H+/CmHU6AvBPi/tJGQGn3nesX6YIHyeJ7wfWkRvNRv8U69YBfA==
X-Gm-Gg: AeBDietXRWt5zbhtQtV3CiR0Q6tZIMggoCIR5YHG/XrGKXRGXr080iNd2HL2ZiGylKP
 ZqY2tHc2wutN6EjUk8MeCQl1UWetYEUIQGV5phRAR/3GbEF9oECUjl2ynwr4tvVrBEvx0XDJhZ5
 ab6ugVBbNrJJafY1zdqi7kVhMX/9+T/Hx8Miuu2LKmmzAXiKKXibgF09NMh1dNrGj4EmRKJINsk
 JvEINk68FTFV3RNay2JMX/Vos3eTt7O3SMGiiUdMYx9Qri97AjIyD6/ZLhzsNGkX4+9GvsYMpcA
 45FKpmU/slk7rAlBQQT65KDHzZnZAUCylT1SNBfLYGO67RITf7f0UZROd77QUH2Wb0WfQVEQRlv
 LKycm8FMlpD5vSjXhy6KFDQRGXLWEM3aVInMiE8sZn7ITQgL5l5M7GH0t1oJs2t6cpbbeSA==
X-Received: by 2002:a05:7022:4396:b0:128:bae9:c069 with SMTP id
 a92af1059eb24-12bfb76f731mr10510264c88.33.1775622117696; 
 Tue, 07 Apr 2026 21:21:57 -0700 (PDT)
X-Received: by 2002:a05:7022:4396:b0:128:bae9:c069 with SMTP id
 a92af1059eb24-12bfb76f731mr10510249c88.33.1775622117156; 
 Tue, 07 Apr 2026 21:21:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bed93f861sm23474816c88.0.2026.04.07.21.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:21:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 6/9] hw/hexagon: Modify "Standalone" symbols
Date: Tue,  7 Apr 2026 21:21:45 -0700
Message-Id: <20260408042149.1902796-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
References: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: iTKq00IKo18zDVyExPrU1rHJ4Ws_9nVZ
X-Proofpoint-GUID: iTKq00IKo18zDVyExPrU1rHJ4Ws_9nVZ
X-Authority-Analysis: v=2.4 cv=TOt1jVla c=1 sm=1 tr=0 ts=69d5d7e6 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QhYL57-57G4zB7GrFpIA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX+qCpxt38GfYW
 KTrQ7u3VGLV6+5zJafZjRU1dNRUF4+XAMx86SHY5+JEs8DeyrgbuceKbZhO3OOZXoE09qBKMbiK
 47WsKunXzg/IP8dSiFCgE4qT01m24o/zWYpRsiPVOBO2lm+Kq4ljTVkygolBft3N6DGtqLFFe+f
 of0KOkj+ldrwY3QFt0iGjPDSx1HJDFhRYu3MxtZPpzq081dapHhFnNxF0ll9/smo3FLVs58jXKG
 wo7dbc6nrRqux4fGvCIXV9mpFdjYfgj4RuepAYYfrSOVoddHLz9+49LO5rBS44rEjPexXDvDZII
 33ynwsGAMEk8QLAqSsjRwb6mPBOqNlV7XDYfJoxgSGbDZ/zBcMQMgJR8bzsmm3lapXITyYmom4m
 Apv2XwQMKu9BaEjq5DF3eDsSMBrrxpKTeyQTFqiacIpmhR3DFQaC/9AOrJR79f74Us5KSwiSjRC
 kZ0IDVmff6M309idXKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGVzZSBzeW1ib2xzIGFyZSB1
c2VkIGJ5IEhleGFnb24gU3RhbmRhbG9uZSBPUyB0byBpbmRpY2F0ZSB3aGV0aGVyCnRoZSBwcm9n
cmFtIHNob3VsZCBoYWx0IGFuZCB3YWl0IGZvciBpbnRlcnJ1cHRzIGF0IHN0YXJ0dXAuICBGb3Ig
UUVNVSwKd2Ugd2FudCB0aGVzZSBwcm9ncmFtcyB0byBqdXN0IGNvbnRpbnVlIGNydDAgc3RhcnR1
cCB0aHJvdWdoIHRvIHRoZSB1c2VyCnByb2dyYW0ncyBtYWluKCkuCgoKUmV2aWV3ZWQtYnk6IFRh
eWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hl
eGFnb25fZHNwLmMgfCAxNiArKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYyBiL2h3L2hl
eGFnb24vaGV4YWdvbl9kc3AuYwppbmRleCA2NDljYWZjZjhlYy4uM2MyNjlmZWVkMjggMTAwNjQ0
Ci0tLSBhL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYworKysgYi9ody9oZXhhZ29uL2hleGFnb25f
ZHNwLmMKQEAgLTI4LDkgKzI4LDE3IEBACiAKICNpbmNsdWRlICJtYWNoaW5lX2NmZ192NjZnXzEw
MjQuaC5pbmMiCiAKK3N0YXRpYyBod2FkZHIgaXNkYl9zZWN1cmVfZmxhZzsKK3N0YXRpYyBod2Fk
ZHIgaXNkYl90cnVzdGVkX2ZsYWc7CiBzdGF0aWMgdm9pZCBoZXhfc3ltYm9sX2NhbGxiYWNrKGNv
bnN0IGNoYXIgKnN0X25hbWUsIGludCBzdF9pbmZvLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50NjRfdCBzdF92YWx1ZSwgdWludDY0X3Qgc3Rfc2l6ZSkKIHsKKyAgICBpZiAo
IWdfc3RyY21wMCgiaXNkYl9zZWN1cmVfZmxhZyIsIHN0X25hbWUpKSB7CisgICAgICAgIGlzZGJf
c2VjdXJlX2ZsYWcgPSBzdF92YWx1ZTsKKyAgICB9CisgICAgaWYgKCFnX3N0cmNtcDAoImlzZGJf
dHJ1c3RlZF9mbGFnIiwgc3RfbmFtZSkpIHsKKyAgICAgICAgaXNkYl90cnVzdGVkX2ZsYWcgPSBz
dF92YWx1ZTsKKyAgICB9CiB9CiAKIC8qIEJvYXJkIGluaXQuICAqLwpAQCAtNTgsNyArNjYsMTUg
QEAgc3RhdGljIHZvaWQgaGV4YWdvbl9sb2FkX2tlcm5lbChIZXhhZ29uQ1BVICpjcHUpCiBzdGF0
aWMgdm9pZCBoZXhhZ29uX2luaXRfYm9vdHN0cmFwKE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgSGV4
YWdvbkNQVSAqY3B1KQogewogICAgIGlmIChtYWNoaW5lLT5rZXJuZWxfZmlsZW5hbWUpIHsKKyAg
ICAgICAgdWludDMyX3QgbWVtID0gMTsKKwogICAgICAgICBoZXhhZ29uX2xvYWRfa2VybmVsKGNw
dSk7CisgICAgICAgIGlmIChpc2RiX3NlY3VyZV9mbGFnKSB7CisgICAgICAgICAgICBjcHVfcGh5
c2ljYWxfbWVtb3J5X3dyaXRlKGlzZGJfc2VjdXJlX2ZsYWcsICZtZW0sIHNpemVvZihtZW0pKTsK
KyAgICAgICAgfQorICAgICAgICBpZiAoaXNkYl90cnVzdGVkX2ZsYWcpIHsKKyAgICAgICAgICAg
IGNwdV9waHlzaWNhbF9tZW1vcnlfd3JpdGUoaXNkYl90cnVzdGVkX2ZsYWcsICZtZW0sIHNpemVv
ZihtZW0pKTsKKyAgICAgICAgfQogICAgIH0KIH0KIAotLSAKMi4zNC4xCgo=

