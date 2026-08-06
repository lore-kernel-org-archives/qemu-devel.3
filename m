Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2FFC55ABA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrphk-0002r3-Qe; Thu, 06 Aug 2026 00:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrphc-0002pQ-J7
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpha-0003C4-Ua
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:27:32 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6763wnku1070843
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ePXkyVxEno0JPHqjrZ3ngTZknDbEiohL6PsqlnyeIQU=; b=kvzlkc/qJ6qzuZm8
 07qzZOcQHM+NfwsWvMaclinIg/1VpEXv5cZq5xpACW12Mr+XQptEBxONQ/ogq8WV
 YN/JziOPa7VaeD11XZy2e6CZMsXCea5HAJxYQH00UvKn6ElCl/XuKn2eSLTA8769
 Z+n8gXk8YMhtunfD18k0njl98WJg/iYPMhiy9lGE7F1MuuJvf1bjm3CvBcomsSOA
 EFJeM2UPvu6znBmPf5Pis184SExUPfquceIxZ0BwsFWy997N14ndx6nYuEF+s3fA
 YCZjOdB8pcvoB0aEsrSJl8TjnMyKKLCvD8kP8hJ0b90Bek3Y3j3YLszHBkQMSlKE
 iOHymA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjucg363-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:27:29 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dbe39ce62so531767a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990448; x=1786595248; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ePXkyVxEno0JPHqjrZ3ngTZknDbEiohL6PsqlnyeIQU=;
 b=dtZrWUoC95PfveY0EVMaCHFhOCuRuFTVLWv6NRnThdyHoZnYgNuIWzBe1wyCIQboPz
 YKIkg5sMnhFc/F+9OZ/cObLdT4ml+RbkV2XWN1bijQZ/Bc1X/sM5og6Ij2o6W0bHdIdf
 KxNUwZFhjRbLfTDMIEaSgMYmRaFa9jmu/dSx0i7M46xSgplWx/1pPR/mbdLoFAdVuP0J
 /kTCGhGUj66hmbO14t7qVf2i5nLe0pUJ/SP7cTPNLyMZu+ESYLsMf/yGfyITVWc94eqC
 m+LoOI+ZpDQ/lMFYSYF6u4qZqtB7zeWOT2WU5ckKtVsq2xi0q4p98C/NTJlyGcNqEfm2
 T2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990448; x=1786595248;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ePXkyVxEno0JPHqjrZ3ngTZknDbEiohL6PsqlnyeIQU=;
 b=lzmxS936OrROSqBtmvj1GuHzEcbENSc/JfMcdNoOdK7A14HOzYxe6FrNUHMy2yv5dX
 HHzeNyPEF+OXK0DWDScZkycsj+ory9DbTcN3//brtlKctcMksusVzCrKT5gqIwYgReBj
 Rscd8llHJTn8dHFHaf+8qHReppuGfENsKAe/L9NHXpgNKfAypBMskhEl5M4iOJHf+CYQ
 B5TBGNKtHjWW9Oc0FGKXsP+jy1hDfwU7aW/MCFYM4ZHh7pLUd3FtbPJqy9od+UEcqrn3
 e3+np3Azx+J3ZVQvIjm3blBo0LNIXZ6WLJAIj9/A7kTXN+qLLliNLT2MaOddWwUhE7uJ
 WDUw==
X-Gm-Message-State: AOJu0YwsrA7whGKBaFeoFY0TWHTnjcWPvA7MUh3ajF+AjgwA12jO6Vi4
 hSF3wNWzPOyrXCb8VD3mGIpFi8qEUkBhPlRbuVgm/6XydH2DxWvefeqbpOM9Jqk9oTC0XcdhojO
 C9Gd91FY9l4E2c+elnxXMMVSo06x9GWKjguQvcVDu1k3n+F5Il138FootqX8Xq0U7HA==
X-Gm-Gg: AR+sD12ylSmxxFMfPXhT/HRJ/9ZAIuJrvRFiBWw6GGYSE6ESCpvVzjRejEOpePAhKCs
 2aJ5Vhzww9lnfXHCa3x8G2fqXeN1x1Y0i4wWrgc3OQwYTRRgFFzHPlz6CoNzNaEywEOc0ZFQgk7
 vcsEk4Pks3pwH6HwtkUI9A81UOWzAp658aY3/cwF1QgCY/Rcn+d1nmQsT70W+cdrwknt8ykYJiJ
 BgSCoKBZHAQv3DQ9TMm7GJh8euxbRro9+MbY2l87EmrKQuF7ZJR7Cj9CIGQKskH7pDCn7dZjuaV
 veYlFy1lYHxrX66j1N68HmELXIWe3+MQO99GLFaIPzDkD/gyBywaTFKMwBgPY9P+d6NaTcanqzY
 ZhG1XioLzM1YK3JmIOSkuqzIMHzSaB+YKx3CNpDP0gAG6bgyu
X-Received: by 2002:a17:90b:578f:b0:380:86d8:8162 with SMTP id
 98e67ed59e1d1-39083b3dab1mr2221597a91.18.1785990448419; 
 Wed, 05 Aug 2026 21:27:28 -0700 (PDT)
X-Received: by 2002:a17:90b:578f:b0:380:86d8:8162 with SMTP id
 98e67ed59e1d1-39083b3dab1mr2221576a91.18.1785990447984; 
 Wed, 05 Aug 2026 21:27:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca926c0bsm19572628c88.14.2026.08.05.21.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:27:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v5 02/18] hw/hexagon: move VTCM to the common machine state
Date: Wed,  5 Aug 2026 21:27:07 -0700
Message-Id: <20260806042723.3785369-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
References: <20260806042723.3785369-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX1dfewhbu53lI
 aDWl0cUY1M9mzlBQUl6JHjkH3sRhQBW6Ux+r7d//UZRufOTFIemsihQNHzodBcHZZCLC3dm49AR
 OGFpOTdsQfqlUWKoWSLw2aXOw7LAHTY=
X-Proofpoint-GUID: 8U7gSWiCQAujNGAgHf5OCInv-5OS2ihb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMCBTYWx0ZWRfX19UoJiWNr5cV
 wMSnuAtH9cQYnhsUyYpqn/6bkNQzisKKgqnJF9BunQbPowtmyUdF3vbjPCB89N8jM6HwYeZbpOU
 2f8c6bokQxNZOkvgizhmwhxvd/7+zXc38e8Q0hjUfObgQZqBDzVi2Gy8t9XYWUcKdRfqdEMQ3Qx
 IvAWCuF5/B9D25EG5o9MIZLnSKtKopI6BLrDgUIKv8YGlNu1jvY6cPBxvPK22wHL4xBf/0STNGT
 ra7vkdhkiyZGTVzFxFI8GXqna8xOf+T/YUFueN+gDZqeFqINI0TmFCj8h4TgQL0Ko+Xizg+z/J6
 AOXja1Uor4JF0MYLNliviESSgIfDyGfLqJXcTqAwX2go/1tqaRNe4K5kLtqjs2kttgVUQQpIX4Z
 mmePsijOWDpQIVNseWsfDnpdtY6vazOJjI4b33ufRtk7Kxbp/Ugsd487UmqZFCNByA1lvRnFWD4
 nFde8fNCbDIMqjf2NLw==
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a740d31 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=31cAqr7vU2O6cbMaemAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 8U7gSWiCQAujNGAgHf5OCInv-5OS2ihb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060030
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

VGhlIFZUQ00gaXMgZGVzY3JpYmVkIGJ5IHRoZSBjb25maWcgdGFibGUsIHNvIGV2ZXJ5IG1hY2hp
bmUgY2FuIHNldCBpdAp1cCB0aGUgc2FtZSB3YXkuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogaW5jbHVkZS9ody9o
ZXhhZ29uL2hleGFnb24uaCB8IDEgKwogaW5jbHVkZS9ody9oZXhhZ29uL3ZpcnQuaCAgICB8IDEg
LQogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICB8IDggKysrKysrKysKIGh3L2hleGFnb24v
dmlydC5jICAgICAgICAgICAgfCA1IC0tLS0tCiA0IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2hleGFnb24vaGV4
YWdvbi5oIGIvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaAppbmRleCAxMDM0YjA5YzJhYy4u
OWM3M2NhZGIxNmQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmgKKysr
IGIvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaApAQCAtMTU2LDYgKzE1Niw3IEBAIHN0cnVj
dCBIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlIHsKIAogICAgIE1lbW9yeVJlZ2lvbiByYW07CiAg
ICAgTWVtb3J5UmVnaW9uIGNmZ3RhYmxlX3JvbTsKKyAgICBNZW1vcnlSZWdpb24gdnRjbTsKIH07
CiAKICNlbmRpZgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9oZXhhZ29uL3ZpcnQuaCBiL2luY2x1
ZGUvaHcvaGV4YWdvbi92aXJ0LmgKaW5kZXggZmNiNDc3NjIxOTQuLmNmMGNkMmY4ZjIyIDEwMDY0
NAotLS0gYS9pbmNsdWRlL2h3L2hleGFnb24vdmlydC5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdv
bi92aXJ0LmgKQEAgLTE3LDcgKzE3LDYgQEAgc3RydWN0IEhleGFnb25WaXJ0TWFjaGluZVN0YXRl
IHsKICAgICBpbnQgZmR0X3NpemU7CiAgICAgTWVtb3J5UmVnaW9uICpzeXM7CiAgICAgTWVtb3J5
UmVnaW9uIHRjbTsKLSAgICBNZW1vcnlSZWdpb24gdnRjbTsKICAgICBNZW1vcnlSZWdpb24gYmlv
czsKICAgICBDbG9jayAqYXBiX2NsazsKIH07CmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleC1z
dWJzeXMuYyBiL2h3L2hleGFnb24vaGV4LXN1YnN5cy5jCmluZGV4IGQxNDZlZTBjMDc1Li4wYzIw
Y2YwMmU3ZCAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKKysrIGIvaHcvaGV4
YWdvbi9oZXgtc3Vic3lzLmMKQEAgLTI5LDQgKzI5LDEyIEBAIHZvaWQgaGV4X3N1YnN5c19jcmVh
dGUoSGV4YWdvbkNvbW1vbk1hY2hpbmVTdGF0ZSAqaG1zLAogICAgIHJvbV9hZGRfYmxvYl9maXhl
ZF9hcygiY29uZmlnX3RhYmxlLnJvbSIsICZtX2NmZy0+Y2ZndGFibGUsCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNpemVvZihtX2NmZy0+Y2ZndGFibGUpLCBtX2NmZy0+Y2ZnYmFzZSwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KTsKKworICAgIGlm
IChtX2NmZy0+Y2ZndGFibGUudnRjbV9zaXplX2tiID4gMCkgeworICAgICAgICBtZW1vcnlfcmVn
aW9uX2luaXRfcmFtKCZobXMtPnZ0Y20sIE5VTEwsICJ2dGNtLnJhbSIsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbV9jZmctPmNmZ3RhYmxlLnZ0Y21fc2l6ZV9rYiAqIDEwMjQsCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2ZhdGFsKTsKKyAgICAgICAgbWVt
b3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKHN5c21lbSwgbV9jZmctPmNmZ3RhYmxlLnZ0Y21fYmFz
ZSA8PCAxNiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZobXMtPnZ0Y20p
OworICAgIH0KIH0KZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vdmlydC5jIGIvaHcvaGV4YWdvbi92
aXJ0LmMKaW5kZXggYWQwYmM0ZjEzMjkuLjUzZWFhZmFmODVhIDEwMDY0NAotLS0gYS9ody9oZXhh
Z29uL3ZpcnQuYworKysgYi9ody9oZXhhZ29uL3ZpcnQuYwpAQCAtNzUsMTEgKzc1LDYgQEAgc3Rh
dGljIHZvaWQgZmR0X2FkZF9odngoSGV4YWdvblZpcnRNYWNoaW5lU3RhdGUgKnZtcywKICAgICBj
b25zdCBNYWNoaW5lU3RhdGUgKm1zID0gTUFDSElORSh2bXMpOwogICAgIHVpbnQzMl90IHZ0Y21f
c2l6ZV9ieXRlcyA9IG1fY2ZnLT5jZmd0YWJsZS52dGNtX3NpemVfa2IgKiAxMDI0OwogICAgIGlm
ICh2dGNtX3NpemVfYnl0ZXMgPiAwKSB7Ci0gICAgICAgIG1lbW9yeV9yZWdpb25faW5pdF9yYW0o
JnZtcy0+dnRjbSwgTlVMTCwgInZ0Y20ucmFtIiwgdnRjbV9zaXplX2J5dGVzLAotICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9mYXRhbCk7Ci0gICAgICAgIG1lbW9yeV9yZWdp
b25fYWRkX3N1YnJlZ2lvbih2bXMtPnN5cywgbV9jZmctPmNmZ3RhYmxlLnZ0Y21fYmFzZSA8PCAx
NiwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2bXMtPnZ0Y20pOwotCiAg
ICAgICAgIHFlbXVfZmR0X2FkZF9zdWJub2RlKG1zLT5mZHQsICIvc29jL3Z0Y20iKTsKICAgICAg
ICAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmcobXMtPmZkdCwgIi9zb2MvdnRjbSIsICJjb21wYXRp
YmxlIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInFjb20saGV4YWdvbl92dGNt
Iik7Ci0tIAoyLjM0LjEKCg==

