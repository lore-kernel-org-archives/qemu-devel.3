Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DF0C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIr-00065S-HP; Mon, 29 Jun 2026 09:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCIB-0003zh-9l
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCI7-0006Sr-Nr
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:54 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT3vv2646911
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=6Wt5EJgewH9h32VqnTvpeUdkce3hlYMJmq6TBx1dEGg=; b=VZ
 K/BQjPGeK6qnmNw0vDKNBmhS26YKcFXtYO8vt2hbUraoqqga80CHt8wo7Fv5WZa2
 2qNJ4E2lu7lK0SogLv3VFF3sMMV3KfzU/WqmrB1PFs1d0ut8M7iFkcv2TdTxvbds
 y5jaCMiihVuttyLVFLfHT6WpoMb/NJM/dWmrgQTlaMT0hvEx0VOHfz94hRfxxqiv
 dqb9e/mov5Vx6XAPpAzQEJsMYFQCQ6Tq6r1JyqfW5I6weBzemBiNp3ERdc0H08fI
 BtRlD440CADzjhLY+UTJLJHSJ0MQQOUyY7g+9Q+7+BN3vawGxLJc+cof3f2tmyIL
 V1nhaW+oZZVeMOulAyRw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4tshjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c7ee3952d6so26054435ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740680; x=1783345480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Wt5EJgewH9h32VqnTvpeUdkce3hlYMJmq6TBx1dEGg=;
 b=PAJzaz3FqDd6zDvOcF7NCXF8NmdR9Xtbc+PnE6WRdAxH9V+lwov7S/cYLt/Qo/E8qh
 wZIb0myDCvP5Ji1dHxYenwF73rqOneckWSpn1QMkc1V5bouy79Y3PJpz1A6EYUMsZ50U
 Avxjg+45F2AkTbq1zaaxE/5QVKSd3Tpq2/ttdbCeChRMa437PIefEEVi/KLmxEm0epSj
 lcE9oEzUmlPzCPYI8jlen4iLs7cxC/CyAvJe+WZjfMRiPzH2eaRmEjn7fOk87MZeDQAF
 f7rcgMiNJnp4ZQ5LIGRhvaso9eQTMWwSaS6/a0JcAZGC+4B5RJBQ9bNXnv6UiGB570Q6
 x8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740680; x=1783345480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Wt5EJgewH9h32VqnTvpeUdkce3hlYMJmq6TBx1dEGg=;
 b=GXrWO24YCcTF2R3uw9juXSw1vHGJdTP1FDZ54sSJA7FGQRGTF8Tx9D360m0HsM7xd8
 Tav7+rWJhOEC72N+4uAOzdQ+9UohqgOo59qEqALJEIwizYcrMXz4prkNAexnyG7AkAea
 1pPdojURY6GVzFdypBKc0T01uEXyZQOJ8dPIaD7DvmLmZOY18CtTXeiEAxEC97qQuI8V
 w1gk6sYuTdh4woQZyyq+XIlVJj3dwGBhuHin7EEAIuTMDIPQA1B6nMfq0N1DgLUhcXtw
 hjnEfPOQ75UlPmMr2iLOrdZDeZYMZKaeMF3eIzRkMsXGVrYKv2sbyogoxicGASsuIQ8g
 ALIQ==
X-Gm-Message-State: AOJu0YwaL+1e4Mt1KPK9LrabzJBxWjzf9a4SJ6L/yfwUcuEa158rYTez
 nC9XhkmljuVkXLPCOrwKVRCZAlL6ej5DBmcoUHBhuHmPoJHvfaTMtjYzb3vxFbHkcuFtYxNpOlV
 AXTpaEeRscvWchNCZP++yIeB7LLm0MFU8MB8rkHCc6v+drbIICRzLvETkySn3Qrf43g==
X-Gm-Gg: AfdE7cknq6Ic9RVW0RkgDv5Ahvk+Up+7zigY87rGN+fz09Jo3jwZVu9x6fMxfVvyAHI
 IoJPPGqMRlrh9X6e7EV3ZFNmRTowYxnmF9oXupVWB8Y+LjD/GUuCM/3ekPiKTbm1G3/BVMSQ92Z
 YdN9vl9HIqJl9vCTQe3fCb1ZeQbW31R5SdVJk4l38S7UBOlNI3SLRmu0Bod6vUA7Zp4EP7J/GiL
 JrFez8uyGpc293s65H8HL7gtRBMuzlbbR4kgjaIsElHm5OcaKPcxQ85u1Tj/mI2LG1VjrEwVXhK
 9752TUYQ+yGObMGz6maPnGfPMP4wN8WnK8P6OPuCgeh5CsNXBLQn7umJqE7ayQKcKANehP335Bu
 FZUbZ5P053QtFg/ygaly+uvfrYXPPM1GYg0Kb2vewfn5A9+WF74aVx+7udwA=
X-Received: by 2002:a17:903:1850:b0:2c9:dbb5:c1ec with SMTP id
 d9443c01a7336-2c9dbb5c4f3mr51537495ad.47.1782740679653; 
 Mon, 29 Jun 2026 06:44:39 -0700 (PDT)
X-Received: by 2002:a17:903:1850:b0:2c9:dbb5:c1ec with SMTP id
 d9443c01a7336-2c9dbb5c4f3mr51537195ad.47.1782740679251; 
 Mon, 29 Jun 2026 06:44:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v5 77/77] tests/qtest: Add hexagon boot-serial-test
Date: Mon, 29 Jun 2026 06:12:32 -0700
Message-Id: <20260629131232.2487780-78-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX0ON1+c48iZlw
 Iyv7YRUJ0CoLl4wqFB3M7Eqo//0bPIi1SO0BVKgZ1uXmbzU/EEcMD6U7TR+RCnRCDBZZH5Lvls2
 7P1s9yha/nxVNwdh9zgfqm0c0jElVZZ+0D1vcjOUxELN8JMDEQ9PP+dxseml162ZxgcLNk1jOU5
 MgSt8sqrlIYjZPzSX6/iG4Gi0ourQLP+Z/GK2p52XlhB0OkjNabWN3DStNQ4952v0Rp/epHEay9
 d7jyOhlSvYJOJ5ImGbGqD8sZnJ2Fdy/xe2XjRIR+sQ/tXKEbXAg7o86a2ST/WIJXUpy6hvFS8IR
 0Wn/4r1DscZ/ibSR5Yd8GU8D4NS1njTsPbG/w5srl8UayVkvYjK1ANs+8oakfaiusc5G9SUjYJp
 d+/P7oEObQ1xeYlRWINKHq2Ma0BuqqB5rMDnAx2Suuqbu5Ub3cCbYN0jHAJHP6L38CuIXTzesNd
 8aGXv0kURoJ6G2FFtaQ==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a4276c8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_K2MQWaM9sUw3x3I4k0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX9EsTpXvM2o+c
 ckenkrSHSYf1j1EHzkSWjXzS9JNCxfMl6dKG1+8jJEobJ6CoY9MSMmYLe3LQhijV4wP0sn4s/F9
 XbiJGbwWGMIe23xv/jcBBcRIhX9QeAY=
X-Proofpoint-ORIG-GUID: HQJ6gyQb1vekIzsmIBRlVlp0bXgnqGoo
X-Proofpoint-GUID: HQJ6gyQb1vekIzsmIBRlVlp0bXgnqGoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

QWRkIGJvb3Qtc2VyaWFsLXRlc3Qgc3VwcG9ydCBmb3IgSGV4YWdvbiBhcmNoaXRlY3R1cmUgdXNp
bmcgdGhlIHZpcnQKbWFjaGluZS4KClJldmlld2VkLWJ5OiBGYWJpYW5vIFJvc2FzIDxmYXJvc2Fz
QHN1c2UuZGU+CkFja2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMgfCA4ICsr
KysrKysrCiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAgfCAyICsrCiAyIGZpbGVzIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9ib290LXNl
cmlhbC10ZXN0LmMgYi90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMKaW5kZXggYmNkMGE5
YzUwZTcuLjM3ZmVlN2E5MWM0IDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10
ZXN0LmMKKysrIGIvdGVzdHMvcXRlc3QvYm9vdC1zZXJpYWwtdGVzdC5jCkBAIC0xNDIsNiArMTQy
LDEzIEBAIHN0YXRpYyBjb25zdCB1aW50OF90IGtlcm5lbF9zdG0zMnZsZGlzY292ZXJ5W10gPSB7
CiAgICAgMHgwNCwgMHgzOCwgMHgwMSwgMHg0MCAgICAgICAgICAgICAgICAgIC8qIDB4NDAwMTM4
MDQgPSBVU0FSVDEgVFhEICovCiB9OwogCitzdGF0aWMgY29uc3QgdWludDhfdCBiaW9zX2hleGFn
b25bXSA9IHsKKyAgICAweDAwLCAweDQwLCAweDAwLCAweDAxLCAgICAgICAgICAgICAgICAgLyog
aW1tZXh0KCMweDEwMDAwMDAwKSAqLworICAgIDB4MDAsIDB4YzAsIDB4MDAsIDB4NzgsICAgICAg
ICAgICAgICAgICAvKiByMCA9ICMjMHgxMDAwMDAwMCAqLworICAgIDB4NTQsIDB4YzAsIDB4MDAs
IDB4M2MsICAgICAgICAgICAgICAgICAvKiBtZW1iKHIwKyMwKSA9ICMweDU0IFdyaXRlICdUJyAq
LworICAgIDB4ZjgsIDB4ZmYsIDB4ZmYsIDB4NTkgICAgICAgICAgICAgICAgICAvKiBqdW1wIDB4
MCA7IExvb3AgYmFjayB0byBzdGFydCAqLworfTsKKwogdHlwZWRlZiBzdHJ1Y3QgdGVzdGRlZiB7
CiAgICAgY29uc3QgY2hhciAqYXJjaDsgICAgICAgLyogVGFyZ2V0IGFyY2hpdGVjdHVyZSAqLwog
ICAgIGNvbnN0IGNoYXIgKm1hY2hpbmU7ICAgIC8qIE5hbWUgb2YgdGhlIG1hY2hpbmUgKi8KQEAg
LTE5NCw2ICsyMDEsNyBAQCBzdGF0aWMgY29uc3QgdGVzdGRlZl90IHRlc3RzW10gPSB7CiAgICAg
eyAiYXJtIiwgIm1pY3JvYml0IiwgIiIsICJUIiwgc2l6ZW9mKGtlcm5lbF9ucmY1MSksIGtlcm5l
bF9ucmY1MSB9LAogICAgIHsgImFybSIsICJzdG0zMnZsZGlzY292ZXJ5IiwgIiIsICJUIiwKICAg
ICAgIHNpemVvZihrZXJuZWxfc3RtMzJ2bGRpc2NvdmVyeSksIGtlcm5lbF9zdG0zMnZsZGlzY292
ZXJ5IH0sCisgICAgeyAiaGV4YWdvbiIsICJ2aXJ0IiwgIiIsICJUVCIsIHNpemVvZihiaW9zX2hl
eGFnb24pLCBOVUxMLCBiaW9zX2hleGFnb24gfSwKIAogICAgIHsgTlVMTCB9CiB9OwpkaWZmIC0t
Z2l0IGEvdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgYi90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZApp
bmRleCBlMTU0YWJiMDVkMi4uODIyZTBiZDI4NjkgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L21l
c29uLmJ1aWxkCisrKyBiL3Rlc3RzL3F0ZXN0L21lc29uLmJ1aWxkCkBAIC0yOTYsNiArMjk2LDgg
QEAgcXRlc3RzX3Jpc2N2NjQgPSBbJ3Jpc2N2LWNzci10ZXN0J10gKyBcCiAgICBbJ2lvbW11LXJp
c2N2LXRlc3QnXSA6IFtdKSArIFwKICAgKGNvbmZpZ19hbGxfZGV2aWNlcy5oYXNfa2V5KCdDT05G
SUdfSzIzMCcpID8gWydrMjMwLXdkdC10ZXN0J10gOiBbXSkKIAorcXRlc3RzX2hleGFnb24gPSBb
J2Jvb3Qtc2VyaWFsLXRlc3QnXQorCiBxb3NfdGVzdF9zcyA9IHNzLnNvdXJjZV9zZXQoKQogcW9z
X3Rlc3Rfc3MuYWRkKAogICAnYWM5Ny10ZXN0LmMnLAotLSAKMi4zNC4xCgo=

