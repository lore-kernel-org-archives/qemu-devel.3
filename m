Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754A7C9833E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 02:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAerw-000536-6h; Sat, 26 Sep 2026 22:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAerv-00052j-0O
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 22:43:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAert-0007VL-AF
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 22:43:58 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R1rexu1788180
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zBYt8cFdzfyjjJx70fgYL1kIJytxJucH9oKmkDpbwfs=; b=Zquxe2p7BUzZZLTV
 CTTm5fPa9BQoMXjbBPtOTGwjmMfg3c6oXZiyyxl59JHUTndvTSVwmPYotnNKHsOU
 RRljUcQbYS6bsH86opi4oNB7HHE4aPRro/rCz3S3g5E/+5RLSQ90KiRdqyyBCdjn
 8JJ87wwedkYcTBjwwaA0/GkFlFvq0F1btQfV3z7vtAM0Y3puJwcmyq0Sd6ZD7Gqd
 MLBRqVmu6mNa7DSLaTJy9eLYhbl6Q/b/Yq3u8kGHVw58M2pi3pKmSUmCyrybHMhc
 24XcVa418D685fz0FavbjvdqHM0MhqiRACbapRM1mdzIsBFPgLi32kaXTd1Fdf4s
 64LmKQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx526j89e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:43:56 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1438492fb40so2961206c88.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790477035; x=1791081835; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zBYt8cFdzfyjjJx70fgYL1kIJytxJucH9oKmkDpbwfs=;
 b=c7NTn/6U9LDsCKHJHCBaTZdbdgnsjVEOR5dHBokjYUU0zw8fclZ15OAj0Z2QDBhsmy
 KI32SpoHDKW8/2EZZZGk263LLHKAO2mT+JXR8SlS1JR0JhxlYE9q7A7EnHF5cPLLvvP2
 LhCplIAOKIxKU3lSCPcLs14FvnOA6huOEp56XKOWwIMWyeLEMt0ybbhIO6kL1DdXUd9p
 Xci5/ir4at45csUyl5ycbORusUQsN8PsgJR4ProSR+GFNyXC3wuqNTqOf8Spbx2AUKuK
 SyL56LZuTY4J09Fc5lzzlguaydaZ7VM4BwIFolCC2DBmakNOtJg91TdcumGGI0heJrCR
 SR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790477035; x=1791081835;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zBYt8cFdzfyjjJx70fgYL1kIJytxJucH9oKmkDpbwfs=;
 b=iYFQ4IGJH9FNrmN4a5AQrKjm4vE5/z6QQMHmcGhm9Zc2vtG7y9d0hw1fT1GUSRxd2G
 Yqzp3oyIK8jrP0WLZif5WIO+CujAo+GDPxUgeM1E4uaX8bIP7kjXEppJVCC8jvANLpY2
 md9RMwN4f2dYSQXkFYaEp0ztnXwdISAkyE+2/eu1/uWYbNYTIQ/K8EUqr9UzcOMz9Sad
 KIfFWL3IUftHrGe3abD00EX8pVxNz/bsNYSQ2RCTvtsQ0W9vxVVFRI7p6WfL43CJCixp
 H7HyL5cWPojgAKEDTQq80/Qq1IULhx171cB3rHputdUVpgHdZ3DEm9CFncD7LHbfVwcm
 dc1g==
X-Gm-Message-State: AFuF++kEu2QYP/CopVOphc1UKTRpInAa8STukObZh3tUe22NSjlcCkgJ
 LhpR1D7tMzvqKFyOFjO9FdU1tuY4eeLVRSjJjSa8DU+ulHhMhj98c/lPHA+7dJjk/OrBoilcKnp
 0uE2xZLvOPLgz1yO4E0VB42A6/UAZzcS0qkDRqhadEdl3Lj7HnmvgfiC4YYyblqHCvw==
X-Gm-Gg: AYBFou1tDL0PUvxnfe5eXaSuJvcU4EeoSbw9bfRjyY1XTW4tDn5YVjZd1ZH+nU1Q2RY
 INCD5Kx95PkXCG2VFrXBPvejbksrebwSfkQcfYYZh/1OAcGCTnQkj4+cJ4ajoOJP2gwTd81bXE0
 7/o6QCEwi1wVM7+gz3jXwQj6pLrx7WGcNvLhRZkXKTQ+5wp3dp2psrGkzUoR8PuWVIUKuSD42T3
 8msjBApLzquwhuHQbafDysbnY1LIieWjdJVlagSfWl2GHraPbU/oqZgSIOmxLTfzp/Qo8wcE8Ef
 r2foHSCSP4dIGMR4pTSpsZRCxsfo1mW6u5Qa+X6nVOPsDi7xV59PcHToF03kV80g9FQe40ns2L9
 y68ZeeeyhRpW6Bv9fpspwrRmYK1cQb4UsGEGxkoUllNVBwSI=
X-Received: by 2002:a05:7022:4581:b0:143:26ed:2dd5 with SMTP id
 a92af1059eb24-146cfcd7046mr7354038c88.31.1790477034340; 
 Sat, 26 Sep 2026 19:43:54 -0700 (PDT)
X-Received: by 2002:a05:7022:4581:b0:143:26ed:2dd5 with SMTP id
 a92af1059eb24-146cfcd7046mr7354005c88.31.1790477033778; 
 Sat, 26 Sep 2026 19:43:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145ac67c3f8sm15459747c88.3.2026.09.26.19.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 19:43:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 3/5] hw/hexagon: protect the shared architectural TLB
Date: Sat, 26 Sep 2026 19:43:45 -0700
Message-Id: <20260927024347.3545385-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
References: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=VvS2kO2n c=1 sm=1 tr=0 ts=6ab882ec cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=rp48sNE5vvaaZFK1b3sA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: jKgld8Dsa8q57Tr4rblayrTn7dep-q11
X-Proofpoint-ORIG-GUID: jKgld8Dsa8q57Tr4rblayrTn7dep-q11
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAxMCBTYWx0ZWRfX2RnYi6OFcX6L
 brrErFWPUH7dDhnzFIFSRW1mrL7tEx+JcK/ehqJJ3yhIkfAUN3uQ6HHDGMMneeW2xQ0YqGCgshc
 HSvUCmWJPBuWwbNx3hFtG6K4LXnQqnDQ+wNxh84AKOOdMTaArNOEVqL3FmYXdlcK0pFi9EZQoKI
 JbTM5Lu90PydJpyOxTnMgdbjRBbkFJMJN5Yv5+qcqIUPxhREcTpOVAQBW9x8S8dOrq4Z3E6IHYm
 wv8HdWFao3ibXVRBuY8YYHEDOBdAsRf4+pqKwP6N5NntPHeht5v21YeR6FzePLI9cQc0EQokWx7
 D0ltQIglfDqGSvDUg9hOcn5LLgl9AUhnyCULGZhIQjvwZVhkwUu06n7kHp0mZKEd6TdDaV0GQ0Q
 KFRqUDGA17/qzG3d6X+Wg64IBfhAvx6EVI7BTvPRO01JAxashaCPUfO+Ju7u/f2hhHD2iUkkzdy
 GKYhiRhsbbEF/A8a8Yw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAxMCBTYWx0ZWRfX6HrqWFk1MQUK
 6CVnsFtB200ELc/+sh8Khbs4MOgttBnng/yrEzK/wzXwRv0PvwXZbh9HAwcF7nJLDDLhlRTyDxZ
 8DBFmmE+JBKrictHMVVLGYiLBtmAOlY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270010
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

QWRkIGEgbXV0ZXggdG8gSGV4YWdvblRMQlN0YXRlIGFuZCBob2xkIGl0IHdoaWxlIGludGVyYWN0
aW5nIHdpdGggVExCCmVudHJpZXMuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5j
YWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25fdGxi
LmggfCAgNSArKysrLQogaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5jICAgICAgICAgfCAyNyArKysr
KysrKysrKysrKysrKysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdv
bl90bGIuaCBiL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oCmluZGV4IDZiYzMzYzA1
NDUyLi41NmFhMGIyYmVlZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25f
dGxiLmgKKysrIGIvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25fdGxiLmgKQEAgLTEzLDYgKzEz
LDcgQEAKICNpbmNsdWRlICJleGVjL2h3YWRkci5oIgogI2luY2x1ZGUgImV4ZWMvbW11LWFjY2Vz
cy10eXBlLmgiCiAjaW5jbHVkZSAibW9uaXRvci9obXAuaCIKKyNpbmNsdWRlICJxZW11L3RocmVh
ZC5oIgogCiAjZGVmaW5lIFRZUEVfSEVYQUdPTl9UTEIgImhleGFnb24tdGxiIgogT0JKRUNUX0RF
Q0xBUkVfU0lNUExFX1RZUEUoSGV4YWdvblRMQlN0YXRlLCBIRVhBR09OX1RMQikKQEAgLTIyLDEw
ICsyMywxMiBAQCBzdHJ1Y3QgSGV4YWdvblRMQlN0YXRlIHsKIAogICAgIHVpbnQzMl90IG51bV9l
bnRyaWVzOwogICAgIHVpbnQ2NF90ICplbnRyaWVzOworICAgIFFlbXVNdXRleCBsb2NrOwogfTsK
IAogdWludDY0X3QgaGV4YWdvbl90bGJfcmVhZChIZXhhZ29uVExCU3RhdGUgKnRsYiwgdWludDMy
X3QgaW5kZXgpOwotdm9pZCBoZXhhZ29uX3RsYl93cml0ZShIZXhhZ29uVExCU3RhdGUgKnRsYiwg
dWludDMyX3QgaW5kZXgsIHVpbnQ2NF90IHZhbHVlKTsKK3VpbnQ2NF90IGhleGFnb25fdGxiX3dy
aXRlKEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBpbmRleCwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQ2NF90IHZhbHVlKTsKIAogYm9vbCBoZXhhZ29uX3RsYl9maW5kX21h
dGNoKEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBhc2lkLAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQzMl90IFZBLCBNTVVBY2Nlc3NUeXBlIGFjY2Vzc190eXBlLApkaWZm
IC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5jIGIvaHcvaGV4YWdvbi9oZXhhZ29uX3Rs
Yi5jCmluZGV4IDE1N2QwM2U1MWJmLi4yODYwMWI3OGE2ZiAxMDA2NDQKLS0tIGEvaHcvaGV4YWdv
bi9oZXhhZ29uX3RsYi5jCisrKyBiL2h3L2hleGFnb24vaGV4YWdvbl90bGIuYwpAQCAtNyw2ICs3
LDcgQEAKIAogI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKICNpbmNsdWRlICJxZW11L2xvZy5oIgor
I2luY2x1ZGUgInFlbXUvbG9ja2FibGUuaCIKICNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25f
dGxiLmgiCiAjaW5jbHVkZSAiaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaCIKICNpbmNsdWRlICJo
dy9jb3JlL3Jlc2V0dGFibGUuaCIKQEAgLTE2Miw2ICsxNjMsNyBAQCBib29sIGhleGFnb25fdGxi
X2R1bXBfZW50cnkoTW9uaXRvckhNUCAqaG1wLCB1aW50NjRfdCBlbnRyeSkKIAogdm9pZCBoZXhh
Z29uX3RsYl9kdW1wKE1vbml0b3JITVAgKmhtcCwgSGV4YWdvblRMQlN0YXRlICp0bGIpCiB7Cisg
ICAgUUVNVV9MT0NLX0dVQVJEKCZ0bGItPmxvY2spOwogICAgIGZvciAodWludDMyX3QgaSA9IDA7
IGkgPCB0bGItPm51bV9lbnRyaWVzOyBpKyspIHsKICAgICAgICAgaGV4YWdvbl90bGJfZHVtcF9l
bnRyeShobXAsIHRsYi0+ZW50cmllc1tpXSk7CiAgICAgfQpAQCAtMzAzLDEzICszMDUsMjAgQEAg
c3RhdGljIGJvb2wgaGV4X3RsYl9pc19tYXRjaCh1aW50NjRfdCBlbnRyeTEsIHVpbnQ2NF90IGVu
dHJ5MiwKIHVpbnQ2NF90IGhleGFnb25fdGxiX3JlYWQoSGV4YWdvblRMQlN0YXRlICp0bGIsIHVp
bnQzMl90IGluZGV4KQogewogICAgIGdfYXNzZXJ0KGluZGV4IDwgdGxiLT5udW1fZW50cmllcyk7
CisgICAgUUVNVV9MT0NLX0dVQVJEKCZ0bGItPmxvY2spOwogICAgIHJldHVybiB0bGItPmVudHJp
ZXNbaW5kZXhdOwogfQogCi12b2lkIGhleGFnb25fdGxiX3dyaXRlKEhleGFnb25UTEJTdGF0ZSAq
dGxiLCB1aW50MzJfdCBpbmRleCwgdWludDY0X3QgdmFsdWUpCit1aW50NjRfdCBoZXhhZ29uX3Rs
Yl93cml0ZShIZXhhZ29uVExCU3RhdGUgKnRsYiwgdWludDMyX3QgaW5kZXgsCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1aW50NjRfdCB2YWx1ZSkKIHsKKyAgICB1aW50NjRfdCBvbGQ7CisK
ICAgICBnX2Fzc2VydChpbmRleCA8IHRsYi0+bnVtX2VudHJpZXMpOworICAgIFFFTVVfTE9DS19H
VUFSRCgmdGxiLT5sb2NrKTsKKyAgICBvbGQgPSB0bGItPmVudHJpZXNbaW5kZXhdOwogICAgIHRs
Yi0+ZW50cmllc1tpbmRleF0gPSB2YWx1ZTsKKyAgICByZXR1cm4gb2xkOwogfQogCiBib29sIGhl
eGFnb25fdGxiX2ZpbmRfbWF0Y2goSGV4YWdvblRMQlN0YXRlICp0bGIsIHVpbnQzMl90IGFzaWQs
CkBAIC0zMjMsNiArMzMyLDcgQEAgYm9vbCBoZXhhZ29uX3RsYl9maW5kX21hdGNoKEhleGFnb25U
TEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBhc2lkLAogICAgICpleGNwID0gMDsKICAgICAqY2F1c2Vf
Y29kZSA9IDA7CiAKKyAgICBRRU1VX0xPQ0tfR1VBUkQoJnRsYi0+bG9jayk7CiAgICAgZm9yICh1
aW50MzJfdCBpID0gMDsgaSA8IHRsYi0+bnVtX2VudHJpZXM7IGkrKykgewogICAgICAgICBpZiAo
aGV4X3RsYl9lbnRyeV9tYXRjaCh0bGItPmVudHJpZXNbaV0sIGFzaWQsIFZBLCBhY2Nlc3NfdHlw
ZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUEEsIHByb3QsIHNpemUsIGV4Y3As
IGNhdXNlX2NvZGUsIG1tdV9pZHgpKSB7CkBAIC0zNDksNiArMzU5LDcgQEAgdWludDMyX3QgaGV4
YWdvbl90bGJfbG9va3VwKEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBhc2lkLAogICAg
IHVpbnQzMl90IG5vdF9mb3VuZCA9IDB4ODAwMDAwMDA7CiAgICAgdWludDMyX3QgaWR4ID0gbm90
X2ZvdW5kOwogCisgICAgUUVNVV9MT0NLX0dVQVJEKCZ0bGItPmxvY2spOwogICAgICppbXByZWNp
c2VfZXhjZXB0aW9uID0gMDsKICAgICBmb3IgKHVpbnQzMl90IGkgPSAwOyBpIDwgdGxiLT5udW1f
ZW50cmllczsgaSsrKSB7CiAgICAgICAgIHVpbnQ2NF90IGVudHJ5ID0gdGxiLT5lbnRyaWVzW2ld
OwpAQCAtMzg3LDYgKzM5OCw3IEBAIGludCBoZXhhZ29uX3RsYl9jaGVja19vdmVybGFwKEhleGFn
b25UTEJTdGF0ZSAqdGxiLCB1aW50NjRfdCBlbnRyeSwKICAgICBpbnQgbWF0Y2hlcyA9IDA7CiAg
ICAgaW50IGxhc3RfbWF0Y2ggPSAwOwogCisgICAgUUVNVV9MT0NLX0dVQVJEKCZ0bGItPmxvY2sp
OwogICAgIGZvciAodWludDMyX3QgaSA9IDA7IGkgPCB0bGItPm51bV9lbnRyaWVzOyBpKyspIHsK
ICAgICAgICAgaWYgKGhleF90bGJfaXNfbWF0Y2goZW50cnksIHRsYi0+ZW50cmllc1tpXSwgZmFs
c2UpKSB7CiAgICAgICAgICAgICBtYXRjaGVzKys7CkBAIC00MTIsNiArNDI0LDE2IEBAIHVpbnQz
Ml90IGhleGFnb25fdGxiX2dldF9udW1fZW50cmllcyhIZXhhZ29uVExCU3RhdGUgKnRsYikKIAog
c3RhdGljIHZvaWQgaGV4YWdvbl90bGJfaW5pdChPYmplY3QgKm9iaikKIHsKKyAgICBIZXhhZ29u
VExCU3RhdGUgKnMgPSBIRVhBR09OX1RMQihvYmopOworCisgICAgcWVtdV9tdXRleF9pbml0KCZz
LT5sb2NrKTsKK30KKworc3RhdGljIHZvaWQgaGV4YWdvbl90bGJfZmluYWxpemUoT2JqZWN0ICpv
YmopCit7CisgICAgSGV4YWdvblRMQlN0YXRlICpzID0gSEVYQUdPTl9UTEIob2JqKTsKKworICAg
IHFlbXVfbXV0ZXhfZGVzdHJveSgmcy0+bG9jayk7CiB9CiAKIHN0YXRpYyB2b2lkIGhleGFnb25f
dGxiX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQpAQCAtNDM2LDYgKzQ1
OCw4IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fdGxiX3VucmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2
KQogc3RhdGljIHZvaWQgaGV4YWdvbl90bGJfcmVzZXRfaG9sZChPYmplY3QgKm9iaiwgUmVzZXRU
eXBlIHR5cGUpCiB7CiAgICAgSGV4YWdvblRMQlN0YXRlICpzID0gSEVYQUdPTl9UTEIob2JqKTsK
KworICAgIFFFTVVfTE9DS19HVUFSRCgmcy0+bG9jayk7CiAgICAgaWYgKHMtPmVudHJpZXMpIHsK
ICAgICAgICAgbWVtc2V0KHMtPmVudHJpZXMsIDAsIHNpemVvZih1aW50NjRfdCkgKiBzLT5udW1f
ZW50cmllcyk7CiAgICAgfQpAQCAtNDc2LDYgKzUwMCw3IEBAIHN0YXRpYyBjb25zdCBUeXBlSW5m
byBoZXhhZ29uX3RsYl9pbmZvID0gewogICAgIC5wYXJlbnQgPSBUWVBFX1NZU19CVVNfREVWSUNF
LAogICAgIC5pbnN0YW5jZV9zaXplID0gc2l6ZW9mKEhleGFnb25UTEJTdGF0ZSksCiAgICAgLmlu
c3RhbmNlX2luaXQgPSBoZXhhZ29uX3RsYl9pbml0LAorICAgIC5pbnN0YW5jZV9maW5hbGl6ZSA9
IGhleGFnb25fdGxiX2ZpbmFsaXplLAogICAgIC5jbGFzc19pbml0ID0gaGV4YWdvbl90bGJfY2xh
c3NfaW5pdCwKIH07CiAKLS0gCjIuMzQuMQoK

