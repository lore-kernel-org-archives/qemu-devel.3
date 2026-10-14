Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0756DCC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH51g-0005Qe-GP; Wed, 14 Oct 2026 15:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH51f-0005OJ-2U
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:52:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH51d-0002V1-7g
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:52:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EFMpQN1682879
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9qA0HvElR8KqKQ54ShMiSWRK9Kne/0JSjJvT7+R1iVk=; b=AitTYJdm38UQwhVk
 4yXkpNJJWtksB6mwSnioV04w/kLuhdZ2MuaZRAsocfW9a8OjrMVhnqrf1rFHJBEg
 5pgYZyTaT9LnMTtf4FN4VKDSQXJU3UkOIT4F+faebiUxog9crt7pku1Zc+OTAoG7
 CSprlk7i0NZQ89EX4kqNpyDn9mw46w7QJ6voraGJlgMwv3pxdT1yHS9j1PX3wKhy
 I7fOgResDdT30yakWxp8HoHthxyI2ybRGw71rLdav3AfOjHOiCicZMhPsI4py1Up
 DgQwMgVXBplhSHYtXUJ4FhQvx89dX/D5rBWb+YTaStxG9UgPeMKDg+7lHubwXesN
 d2UdHg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb0118k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:52:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3592749a017so1315701eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792007551; x=1792612351; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9qA0HvElR8KqKQ54ShMiSWRK9Kne/0JSjJvT7+R1iVk=;
 b=gZ7NQ8lctq35L7kdQftd4PVT+5IwgoPtTS3PKySZ9g3FI2Iytj/DqZW0xKahhzI17Q
 q+c3W913Yq/hJKw+otB4XPp/gR+k/zEV9pjYGwjg3X8bQPvLdmmeWyEHdacwYnKDfoYV
 nLa6fd30WnRQ9Mj7zWLn0iARA/zaUiBjIq9ccAAdOOgFf1Aprt29FewhCNKGR+2Ko32T
 5cMudG3olymp3ylvxwFt4YHZDl3IH2ZzqhSJijMZE3f0fW8ZNZ6Wpfae7huxnteXXjLW
 LGFTLlervDisx8G83Ph9xmBSyhZJAuChapz8EcC3QXkfI0ZzpQKvjpD6aGPLubZOP5n1
 Ma4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007551; x=1792612351;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9qA0HvElR8KqKQ54ShMiSWRK9Kne/0JSjJvT7+R1iVk=;
 b=JQP1MagfEwwHSWy0GXLqrtB7NmenHv5+Ncmq213basomo5H0lHxu+EDjDWXzJcsVKr
 i1xz+MYZYNYamQrHRwV7SKofQ3Ke6plCG1X3FVY5QuzjDYNZnqY5mMFF7BxXzrrWeGM4
 6pLjkWB2z6AhGr4rXS2bbu7Hk23lU1+CWpRrQQPAuNKniL/ExY975lV80FhPJR14zD85
 t3/uecS8rWGrAq4SwH8skkrYtq/S6x8xfWVDlnb5ErvCFLmkyPcOvXRhq1OsiWbToU0Q
 EirLVewrFDBo4mutNlD8XZ7uEGTdf7n1/HwNBXr1lbOhWuF+aiHyMVnFKvMQaV4ks8Ja
 ZOFA==
X-Gm-Message-State: AFq9FYINWAhwdLO7v3kdD7x0XKNN7AEoeaHbU5RkqVMeWSb0TWEYfoWJ
 HJ8MuEkCWIkf1rjMZ+naNfOUnMHbBo/feFRq9JyHIJWWzNGXo0Babzt7Z7d2l6NpAW9d9L176ha
 AT3k2/uyvWi6693UoNRrAZUzHgdSHDY19jH6NY+ldBX+vddA6Ps796VHXNHuIynJUKg==
X-Gm-Gg: AYBFou1i7ycyXaUwwlgHkhkPuV/AYhm0fi5Z9Oi9/HUZfhsJ2YUbhE3AOIRtSpN6Sw7
 xWNmsr7S620AiJaQRKpauKkoYwvM0Lwqf8EgxlnsHN1d0lRSggWFR6MGK38RrzMrfm7HtgzEgGF
 N41VyLwpNWMAMEYgMHVJ7LuC0FsVSNpl5WCwAtWcdy9Dg3ct+EdgKhgPQSz1DG60K4FQC9GeRbE
 WytXA4YSsc/BUluAW6zLLyepdnCWQ2R/wEvI4hm4T91QL3nKS/UVSreEcvCUiDnPlghpd/wNnDS
 h+CxcADcYwdZCfIWw8NaoQQ4IbAQOAWGTmaqID/ZQE+fxM5F75ZaER1lfmAOpWu5fiC7YwJlBhk
 A6z45gxK/f236JX+UNhjkgRjEp3GPrDQs5iKrS49q/4hMRXM=
X-Received: by 2002:a05:7300:aeaf:b0:341:c383:9afb with SMTP id
 5a478bee46e88-3536c59ed2amr22311815eec.20.1792007550956; 
 Wed, 14 Oct 2026 12:52:30 -0700 (PDT)
X-Received: by 2002:a05:7300:aeaf:b0:341:c383:9afb with SMTP id
 5a478bee46e88-3536c59ed2amr22311784eec.20.1792007550376; 
 Wed, 14 Oct 2026 12:52:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35f0c3bcf80sm547069eec.7.2026.10.14.12.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:52:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 04/12] linux-user/hexagon: report ISA HWCAP through v85
Date: Wed, 14 Oct 2026 12:52:15 -0700
Message-Id: <20261014195223.3233623-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6acfdd7f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=RcCyqxnK1iORyYYg75cA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfX2d+SY3oXpNu7
 TITWrbCh4frHQ+unjFTXDm3SMndWMT/3mlp7yaDsTHCROdnOM0ky222gXcbYHRkEpxbTqktjcbR
 idQ0QM6KCckhGNXpGg/duW1d9ORP8Ig=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfX3aGnk4FTm8Sy
 3QH9tmDmOd3yVfkPPQFaJ1qnTq/8n6wPYGeNSd0H8MXmIxgcSPWD5+l9UUX25gq2sYErmFUzlGl
 DZdQEv5DGwCV4DLdEZ7CY3l+SkU9ceult7vpjl6mn3TbfuImwSTrvQ1k4MSPQXa6AbsvwhidoMt
 Ff5mmcr4VIztREnS3mkuhpteSMCCm3ocIwOXp3RZw4kdRLg7Gh9IF2yvQdxY00b9mhuGc4AUuY6
 VLhdkIXFkCw8HaQ8Z52vhFZhpGf8x2JD1LTFJE2me2jAVSDNoiyCL33a76Wx/OzpbovSWcU01pQ
 pIzFvhMUp4Db1b7J8RwSNU+ed7Kg/l8ChYSCzZZBIAvVblMNGSARal/GnlTwTCt+8LgEaOgKc6I
 NnmfduH4BYHpgTOxmXV/wRiywE9dqPzUu4l+QdEGvsV+9mRRVHmj0H2Zswwu22GEWNPu9BuwMuG
 gXYBQJtHePX1cD/mFrg==
X-Proofpoint-ORIG-GUID: mh8k8l0hV1s2II1UMFgasZncHXA_Bk0g
X-Proofpoint-GUID: mh8k8l0hV1s2II1UMFgasZncHXA_Bk0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140079
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIGxpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRfZWxmLmggfCAyICsrCiBsaW51eC11c2VyL2hl
eGFnb24vZWxmbG9hZC5jICAgIHwgNiArKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9lbGYuaCBiL2xp
bnV4LXVzZXIvaGV4YWdvbi90YXJnZXRfZWxmLmgKaW5kZXggOTBlNTAzMmQ1YWEuLmIxZWI1ZWE1
MDM3IDEwMDY0NAotLS0gYS9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCisrKyBiL2xp
bnV4LXVzZXIvaGV4YWdvbi90YXJnZXRfZWxmLmgKQEAgLTQzLDYgKzQzLDggQEAgZW51bSB7CiAg
ICAgSFdDQVBfSEVYQUdPTl9JU0FfVjc3ICAgICAgICAgICA9IDE2LAogICAgIEhXQ0FQX0hFWEFH
T05fSVNBX1Y3OSAgICAgICAgICAgPSAxNywKICAgICBIV0NBUF9IRVhBR09OX0lTQV9WODEgICAg
ICAgICAgID0gMTgsCisgICAgSFdDQVBfSEVYQUdPTl9JU0FfVjgzICAgICAgICAgICA9IDE5LAor
ICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y4NSAgICAgICAgICAgPSAyMCwKICAgICBIV0NBUF9IRVhB
R09OX0hWWCAgICAgICAgICAgICAgID0gMSA8PCA3LAogICAgIEhXQ0FQX0hFWEFHT05fQ0FCQUMg
ICAgICAgICAgICAgPSAxIDw8IDgsCiAgICAgSFdDQVBfSEVYQUdPTl9IVlhfTEVOR1RIXzEyOEIg
ICA9IDEgPDwgOSwKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMgYi9s
aW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jCmluZGV4IDlmOThhZDhmYjg2Li5kYjBiZjI5OWNj
MCAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYworKysgYi9saW51eC11
c2VyL2hleGFnb24vZWxmbG9hZC5jCkBAIC02Miw2ICs2MiwxMiBAQCBhYmlfdWxvbmcgZ2V0X2Vs
Zl9od2NhcChDUFVTdGF0ZSAqY3MpCiAgICAgY2FzZSBIRVhfVkVSX1Y4MToKICAgICAgICAgaHdj
YXBzID0gSFdDQVBfSEVYQUdPTl9JU0FfVjgxOwogICAgICAgICBicmVhazsKKyAgICBjYXNlIEhF
WF9WRVJfVjgzOgorICAgICAgICBod2NhcHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WODM7CisgICAg
ICAgIGJyZWFrOworICAgIGNhc2UgSEVYX1ZFUl9WODU6CisgICAgICAgIGh3Y2FwcyA9IEhXQ0FQ
X0hFWEFHT05fSVNBX1Y4NTsKKyAgICAgICAgYnJlYWs7CiAgICAgZGVmYXVsdDoKICAgICAgICAg
cmV0dXJuIDA7CiAgICAgfQotLSAKMi4zNC4xCgo=

