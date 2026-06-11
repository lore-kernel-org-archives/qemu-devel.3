Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A44CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY9s-00018H-7v; Thu, 11 Jun 2026 01:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY8Q-0007wS-KE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:39:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY8O-0004wA-2d
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:39:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5Giv73812827
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=qgefbe8zN/BrkDY8uu9V5kiNWAGsog2iM8US+fuJldw=; b=U8
 OZk4qU4AH679VHZEXTuKo4EYgeZFmEE56bfPJiFIbeyTqrWCWMMs9PmxPWeE21yZ
 jOhMPXfJ7/1bGwGsz/xmhwbo+OEi0fnVJMYKsCY5i7nk+mG6SnB3Q+6KZraoPmzC
 Yq2hLaUnA3LsTAf4PpFO7rLkOGMRhcF99xctS6tVQLInGDpARXolvT0AiaZhPHaL
 124eI+F2km+2Sws51IW14ae7Q7yyoJXHfskeyRgCXSvBVk7TjFynw6RgoU2K5BBr
 VT59baERmhaxaVJKFC+KXtqcIuJ+wtCZSINlGKkNLGplGy0pOmVz2khVLodCxbHU
 X4a1CrTGgXF6ihXe4fBg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe71hw9a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:39:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304f23c55b2so8220374eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156358; x=1781761158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgefbe8zN/BrkDY8uu9V5kiNWAGsog2iM8US+fuJldw=;
 b=BNhBLzXMEGDpcdiXaK0hMRlok6Ofl92TURIDPx4c7zfa2UhCohtI5c9n3WUdbLMI8H
 OYSnzHgV4jbhALEBCVHwrQytmZzdce7BwTgHi6uwYGuhBfBDdMwer3nV+2+uqt5JQHLX
 fS5vE0HfiWWU5E23JzLyKfPDaoO6pdVhMfTzfw3QjRZs+YYIn4bF+n1smmj/U4ISUMoC
 1Xq4bpys4hcamXHKcnGiyfnn8+1+9cIkBRbMKJuPJZaFkkSpXgGJ5xgeeR288S751MfQ
 jk/guSsIy7cNC4007BIyiooHD6i1ec23RIywKOyBVY2FHkFSPEavWclUjUz688IEt1Pn
 kx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156358; x=1781761158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qgefbe8zN/BrkDY8uu9V5kiNWAGsog2iM8US+fuJldw=;
 b=et99N23RM6bt9mYdkY4yPFf97xotE8pIMDTrpvHhppDPmm8CVEV0/r2t2rjuVDYh+f
 /sY85i6cJCEJk7KThYM9IPxdPjnRQPALB1KyWtHSa+HD4s5gOpzrg2JhkE2LR5MDXMio
 QnxNV80x6pKEq4u561AFCZF1HaL9ZnHd8hvQsaco0TXK77Fc0xmPbjP239d6So5ExVmG
 vgba39sc1t88t7mwdZwDTddYhyQMRPd0cl3P25biNeOPtzEnEn9SEKNYnnK3BktmhU6J
 tTWwBX6+K4FP9XX3rmH1XTU8EEWaPhDPkSXusPwVXZuwwgDh9N1eVw8CG7vMbQhVrdb9
 MvIA==
X-Gm-Message-State: AOJu0Ywxl+VkJpzlU7PKQhX6iIcpbOjWTxKsLFV+tf6XDTtftSKEgXAy
 VFzOQBeY0IkDPU4I+ndjRgOYXDwBVufbVbmvUkSjI2TOkK3qctiqkRVqKvMo1Q342wG3x7+JTjp
 9JYd2znCrn/XMSJi8e8gIPDBR40iOaCmNekn56I6dCTRB/5MyT8ycYyBovLmkHbGeww==
X-Gm-Gg: Acq92OFu0mdIVRyaK0MSPPylKiLa0H8zg6mGRx/F/ESYtDiioPh8jq6JLux2+qvotmC
 +xHENCxqoarE2+2IPzxNAK8TXp+ZRKYlboQpEjjCckiXaI9ymoMMJaxZBOr1bYZliHunQAYYIFX
 5PtK9Jjh5/PcOZUKFtLPtG6zvptHf1Xw0h96zkKcTZ/dAZA1NJGpVP0aXZFWujNOQ4EqnevfKjz
 lb30/+3fbWci0V/D/+7W2Wh+uz3ivC8z4lPLJfmpEN+mYEK66eSHkqXHOEpoNIvuVQ7Fz/MVV4D
 LMhgxGXoyAFNeQNhCu+OcpL5VKVi8OH09CcDL5lamQS7I7/0RPldVPN4J6whhW/DySucmurGpio
 DwvNc18YMSp4D7XaNntaS4M+6oL0mGxyD7Rn3+Y5mQTY6JvNvjZhIW7D0IB6g5NWPEFTW9TaKqP
 wr0um1
X-Received: by 2002:a05:7300:7487:b0:304:bf07:f19e with SMTP id
 5a478bee46e88-30804a40079mr995012eec.28.1781156357917; 
 Wed, 10 Jun 2026 22:39:17 -0700 (PDT)
X-Received: by 2002:a05:7300:7487:b0:304:bf07:f19e with SMTP id
 5a478bee46e88-30804a40079mr994998eec.28.1781156357336; 
 Wed, 10 Jun 2026 22:39:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a9fesm735778eec.16.2026.06.10.22.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:39:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7] target/hexagon: add build config for softmmu
Date: Wed, 10 Jun 2026 22:39:00 -0700
Message-Id: <20260611053902.3927367-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053902.3927367-1-brian.cain@oss.qualcomm.com>
References: <20260611053902.3927367-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: I3MYMdor0EBTBZPBvGrxwKoEqMDY-tWQ
X-Proofpoint-GUID: I3MYMdor0EBTBZPBvGrxwKoEqMDY-tWQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MyBTYWx0ZWRfX0A0EWPjPvF0z
 FGRJXAQQnQiG1NWnwCVMxOgU4iYQO9VOm0zS5gObD4f5Bf+ij3DHh7GUfibLgeuxBBqsfzegNXJ
 vNNoeYMTwMuv39xf2xV+Yi4hdBP8T7EkB3uljzL7DGTio14oPeA0VJdXmgJW5aKYPB6kbyBakyN
 VENIisaQLgGeM90wfRg/oFx7OxHOnjEzX1qEto4+Q3qpkRWBkjtDBU3suiRo3sLeQV5axxu8RTY
 f2dAxHr8KVewAnlc0BgSbB5sho7eopx3izZMeWzBw9EB7DKZDsz3O5p5P0pt9nTTBkf9AkuephP
 hmZrkxgc+HKP1mIAwSfLVFf5lVAhU0n7hzUfh5Jt7RQf5njlJdP/qXRXIc9sO65lkCQO2OQvPR7
 MOLaaKdMxh6WcEwRstSJxpeqk9zGzeL2paUkK5nVhZTUz4g9t1z5rGmY/lRMx7LlCCEdBZdk6Gk
 FiP+waBziEMl9UmVejg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MyBTYWx0ZWRfX1h044lgV7ndK
 jAL1/D7mjzq0WmzVPdwnQrAHUkp/YFzywgglk/Curpgl2qW29NU56+PHNd2vPR3YqH9Dweqtir8
 oEwR0K1Il3IxrjoGonHqQkH55DM/VeQ=
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a2a4a07 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=S56xvJB5AAAA:8 a=nnu-IgKveahPCV3q3nEA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110053
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
QUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCmluZGV4IDIxMDNjMzNmZmRjLi42OWExYTAyYjY1OCAx
MDA2NDQKLS0tIGEvTUFJTlRBSU5FUlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTI1Nyw2ICsyNTcs
NyBAQCBGOiBsaW51eC11c2VyL2hleGFnb24vCiBGOiB0ZXN0cy90Y2cvaGV4YWdvbi8KIEY6IGRp
c2FzL2hleGFnb24uYwogRjogY29uZmlncy90YXJnZXRzL2hleGFnb24tbGludXgtdXNlci9kZWZh
dWx0Lm1haworRjogY29uZmlncy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hawog
RjogdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVzL2RlYmlhbi1oZXhhZ29uLWNyb3NzLmRvY2tlcgog
RjogZ2Ric3R1Yi9nZGIteG1sL2hleGFnb24qLnhtbAogRjogZG9jcy9zeXN0ZW0vdGFyZ2V0LWhl
eGFnb24ucnN0CmRpZmYgLS1naXQgYS9jb25maWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2Rl
ZmF1bHQubWFrIGIvY29uZmlncy9kZXZpY2VzL2hleGFnb24tc29mdG1tdS9kZWZhdWx0Lm1hawpu
ZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uZjdmYzg3NGViMGMKLS0tIC9k
ZXYvbnVsbAorKysgYi9jb25maWdzL2RldmljZXMvaGV4YWdvbi1zb2Z0bW11L2RlZmF1bHQubWFr
CkBAIC0wLDAgKzEsNiBAQAorIyBEZWZhdWx0IGNvbmZpZ3VyYXRpb24gZm9yIGhleGFnb24tc29m
dG1tdQorCisjIFVuY29tbWVudCB0aGUgZm9sbG93aW5nIGxpbmVzIHRvIGRpc2FibGUgdGhlc2Ug
b3B0aW9uYWwgZGV2aWNlczoKKworIyBCb2FyZHMgYXJlIHNlbGVjdGVkIGJ5IGRlZmF1bHQsIHVu
Y29tbWVudCB0byBrZWVwIG91dCBvZiB0aGUgYnVpbGQuCisjIENPTkZJR19IRVhfRFNQPXkKZGlm
ZiAtLWdpdCBhL2NvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrIGIvY29uZmlncy90
YXJnZXRzL2hleGFnb24tc29mdG1tdS5tYWsKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMDAwMDAuLmZkZmEyOWI0ZjM5Ci0tLSAvZGV2L251bGwKKysrIGIvY29uZmlncy90YXJnZXRz
L2hleGFnb24tc29mdG1tdS5tYWsKQEAgLTAsMCArMSw3IEBACisjIERlZmF1bHQgY29uZmlndXJh
dGlvbiBmb3IgaGV4YWdvbi1zb2Z0bW11CisKK1RBUkdFVF9BUkNIPWhleGFnb24KK1RBUkdFVF9Y
TUxfRklMRVM9aGV4YWdvbi1jb3JlLnhtbCBoZXhhZ29uLWh2eC54bWwKK1RBUkdFVF9MT05HX0JJ
VFM9MzIKK1RBUkdFVF9OT1RfVVNJTkdfTEVHQUNZX0xEU1RfUEhZU19BUEk9eQorVEFSR0VUX05P
VF9VU0lOR19MRUdBQ1lfTkFUSVZFX0VORElBTl9BUEk9eQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCA0YTEyZGMwNDcyNy4uNzY5
NGZkOTFmYTggMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5oCkBAIC0zOCwxMCArMzgsNyBAQCB0eXBlZGVmIHN0cnVjdCBIZXhhZ29uR2xv
YmFsUmVnU3RhdGUgSGV4YWdvbkdsb2JhbFJlZ1N0YXRlOwogI2luY2x1ZGUgImh3L2NvcmUvcmVn
aXN0ZXJmaWVsZHMuaCIKICNpbmNsdWRlICJxZW11L2JpdG1hcC5oIgogCi0jaWZuZGVmIENPTkZJ
R19VU0VSX09OTFkKLSNlcnJvciAiSGV4YWdvbiBkb2VzIG5vdCBzdXBwb3J0IHN5c3RlbSBlbXVs
YXRpb24iCi0jZW5kaWYKLQorI2luY2x1ZGUgInRhcmdldC9oZXhhZ29uL3JlZ19maWVsZHMuaCIK
IAogI2RlZmluZSBOVU1fUFJFR1MgNAogI2RlZmluZSBUT1RBTF9QRVJfVEhSRUFEX1JFR1MgNjQK
ZGlmZiAtLWdpdCBhL3RhcmdldC9LY29uZmlnIGIvdGFyZ2V0L0tjb25maWcKaW5kZXggM2M3M2Uz
YmFlMDEuLjAyODhhM2Y0MTY0IDEwMDY0NAotLS0gYS90YXJnZXQvS2NvbmZpZworKysgYi90YXJn
ZXQvS2NvbmZpZwpAQCAtMTYsNiArMTYsNyBAQCBzb3VyY2Ugc2g0L0tjb25maWcKIHNvdXJjZSBz
cGFyYy9LY29uZmlnCiBzb3VyY2UgdHJpY29yZS9LY29uZmlnCiBzb3VyY2UgeHRlbnNhL0tjb25m
aWcKK3NvdXJjZSBoZXhhZ29uL0tjb25maWcKIAogY29uZmlnIFRBUkdFVF9CSUdfRU5ESUFOCiAg
ICAgYm9vbApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vS2NvbmZpZyBiL3RhcmdldC9oZXhh
Z29uL0tjb25maWcKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjdlNTU2
ZjM1MDYzCi0tLSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24vS2NvbmZpZwpAQCAtMCww
ICsxLDIgQEAKK2NvbmZpZyBIRVhBR09OCisgICAgYm9vbApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vbWVzb24uYnVpbGQgYi90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCA1Mjhi
ZWNhM2NkMC4uYmM3YTI5MmU0N2IgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1
aWxkCisrKyBiL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCkBAIC0yMzUsNiArMjM1LDcgQEAg
ZGVjb2RldHJlZV90cmFuc19mdW5jc19nZW5lcmF0ZWQgPSBjdXN0b21fdGFyZ2V0KAogICAgIGNv
bW1hbmQ6IFtweXRob24sIGZpbGVzKCdnZW5fdHJhbnNfZnVuY3MucHknKSwgc2VtYW50aWNzX2dl
bmVyYXRlZCwgJ0BPVVRQVVRAJ10sCiApCiBoZXhhZ29uX3NzLmFkZChkZWNvZGV0cmVlX3RyYW5z
X2Z1bmNzX2dlbmVyYXRlZCkKK2hleGFnb25fc29mdG1tdV9zcyA9IHNzLnNvdXJjZV9zZXQoKQog
CiBoZXhhZ29uX3NzLmFkZChmaWxlcygKICAgICAnY3B1LmMnLApAQCAtMjUzLDYgKzI1NCwxNCBA
QCBoZXhhZ29uX3NzLmFkZChmaWxlcygKICAgICAnbW12ZWMvc3lzdGVtX2V4dF9tbXZlYy5jJywK
ICkpCiAKK2hleGFnb25fc29mdG1tdV9zcy5hZGQoZmlsZXMoCisgICAgJ2NwdV9oZWxwZXIuYycs
CisgICAgJ2hleF9tbXUuYycsCisgICAgJ2hleF9pbnRlcnJ1cHRzLmMnLAorICAgICdoZXhzd2ku
YycsCisgICAgJ21hY2hpbmUuYycsCispKQorCiAjCiAjIFN0ZXAgNC41CiAjIFdlIHVzZSBmbGV4
L2Jpc29uIGJhc2VkIGlkZWYtcGFyc2VyIHRvIGdlbmVyYXRlIFRDRyBjb2RlIGZvciBhIGxvdApA
QCAtMjYyLDcgKzI3MSw4IEBAIGhleGFnb25fc3MuYWRkKGZpbGVzKAogIyAgICAgaWRlZi1nZW5l
cmF0ZWQtZW5hYmxlZC1pbnN0cnVjdGlvbnMKICMKIGlkZWZfcGFyc2VyX2VuYWJsZWQgPSBnZXRf
b3B0aW9uKCdoZXhhZ29uX2lkZWZfcGFyc2VyJykKLWlmIGlkZWZfcGFyc2VyX2VuYWJsZWQgYW5k
ICdoZXhhZ29uLWxpbnV4LXVzZXInIGluIHRhcmdldF9kaXJzCitpZiBpZGVmX3BhcnNlcl9lbmFi
bGVkIGFuZCAoJ2hleGFnb24tbGludXgtdXNlcicgaW4gdGFyZ2V0X2RpcnMgb3IKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAnaGV4YWdvbi1zb2Z0bW11JyBpbiB0YXJnZXRfZGlycykKICAg
ICBpZGVmX3BhcnNlcl9pbnB1dF9nZW5lcmF0ZWQgPSBjdXN0b21fdGFyZ2V0KAogICAgICAgICAn
aWRlZl9wYXJzZXJfaW5wdXQuaC5pbmMnLAogICAgICAgICBvdXRwdXQ6ICdpZGVmX3BhcnNlcl9p
bnB1dC5oLmluYycsCkBAIC0zOTAsMyArNDAwLDQgQEAgYW5hbHl6ZV9mdW5jc19nZW5lcmF0ZWQg
PSBjdXN0b21fdGFyZ2V0KAogaGV4YWdvbl9zcy5hZGQoYW5hbHl6ZV9mdW5jc19nZW5lcmF0ZWQp
CiAKIHRhcmdldF9hcmNoICs9IHsnaGV4YWdvbic6IGhleGFnb25fc3N9Cit0YXJnZXRfc3lzdGVt
X2FyY2ggKz0geydoZXhhZ29uJzogaGV4YWdvbl9zb2Z0bW11X3NzfQotLSAKMi4zNC4xCgo=

