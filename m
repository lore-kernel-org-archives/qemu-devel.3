Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F364CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkkR-0007qL-Vu; Fri, 16 Oct 2026 12:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkM-0007oW-Qm
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkJ-0002iq-K2
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:30 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG1DMN2551819
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ohTfPY50zyq
 OZlHlbQHcEjxY2RQzEiKVhfqFzXIRikA=; b=cOPA4U8+POP28SuTCPQGNRiCsk7
 mdjt+sYWF65KIiSox22TdjEUh1zd4nrYj/IG/oeeUZqFJmBezp2llInsyTiyhYw5
 8aoCeD337CpMiHHJth5A7WaMMf/AhfcblA2XBvER964qEuGYzrNB3EVvIa9aRY/i
 OZKBnplDvwbvadvOvc0aq7T5h2i9Duo7sY7ix3ZLLLmxjYMQUlIrkBH2ej3z5W98
 uojefQPENWgpxXU+MHjm8V4XPXptSVofsHGC79U/NAlZlG0VAtrgO6Q6jnitqP8x
 plO27UAGtVT41ni3FFySsS4tlaHxf1w26/UgLjv4Ct5wM6XsmJIYsLTlkLQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq2wr9dx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac0ae43900so179325a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792167922; x=1792772722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ohTfPY50zyqOZlHlbQHcEjxY2RQzEiKVhfqFzXIRikA=;
 b=kJ9a0QNokWUnTTETQykmztPzzfSfrM09SwzaYmlWmpZlzVRK20XsDqmblf6Hlj43fH
 hB1+vtcNoep7dbohyi+WbJtWCVrMiOkWsrmAPziepDLCN+ywzSV4cJzIM+R4v52KWuJu
 Im2iG4HtxX0afB76u6j/1DsJvDpTO/csmKIr23my7NKjV9QM+omfUVDzs+tP0FbV6nPs
 hfKMnzjMQzrKPSVFvaoIFZMQH9glbsyFuIF1ghgwW8vfMFoZ232wj3S48cqDaQvLAP+y
 C2/5GXuyU+wd6iWvMNtpBk6jnF+AfccDbM+P2hpmA4qTtaV1WyTQBgMWzuLr+La2nFNH
 pR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792167922; x=1792772722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ohTfPY50zyqOZlHlbQHcEjxY2RQzEiKVhfqFzXIRikA=;
 b=qkJpgeiU4pJCKyF61XkMGLYGT/BOVW9RgPsmRhDPlXZjzPUx7DSgTgdKRAaXYTHzYs
 8XTrleNThpaa0PHV95J28CJzZv9rtGfB9AkuWvLJlVZ50CgUjPDtGBHi0mBTQV0h50Qu
 VOonf4IHC0kSIbsmdQlctSAqWaaC9dRAtE/r/bJ7ORpzALjJZw0xOsWb0UxUdvnbTeWZ
 UDjujdKvxgWHd3b/QmDmwoB7owg0oGddM7CJKoDxnNki2kCJRuy6p56PMAnxoRoTPanh
 PhD3/WSgjZCFQ1yZb8wTwWD/8he+odh6eqNyIgHBYqQbDQceG8w2TQRIqvEbeXIhLsQ4
 uIuw==
X-Gm-Message-State: AFq9FYIQwYBk2z9DelySiaSdh+/TfC4NyP3L1k+atI4K8ljYjzYzU0Gi
 1LFLFMZA2ypxKTzNLdxV9fFxCfHMeAEq8kt5IyqswFzlM6BDCYLqyviXCRPdEovw3FopZCa9E2m
 ZFbOeBq4xnbyS7dP0Qu+tU80fsrooViWm3ixM9keA/JGkkvHGwVtZfgCG/D4JyUihKg==
X-Gm-Gg: AYBFou1c8x2ulE2aNE8uQaj8yclchMqp/AiAxy3Oo9Jl5qIOUr5AmIOEwV7u2tMoxND
 SLQsSVoCD9xfYHYoIFY8RmNh5P6kq308f1u5u9YpsoYCJQQ2Tw62KWYZgZlkVjrwKEbuNgeeyeH
 gvRAPK1T1GJWDiLPdruvaIp/oc6Pw6194+dYrVoVPgKyFL6XU7bPn6a2bPRLXubyu07+OEV8FE2
 6MzA90oKZdA5Ty3Z2WWY+JDUrVFvSxPZAxjbLuGgtaZkathRLl8amfqjj9b5d73bYtaf06dfiIh
 P/qbLPzy3Xy3OSkS4iCSz59PaDemji/em/NmDjjAEDyHWnwM3GWq22di8GjWmgmSzRD2brKxwPp
 woOyW2mGPj1z59wWTRAjWTzxespQTQny3MvVFe7noywBIIyWEJ1ckjJLCcLnIrHU=
X-Received: by 2002:a17:90b:510a:b0:3aa:6b5d:9fe4 with SMTP id
 98e67ed59e1d1-3aceebb682cmr332760a91.12.1792167922041; 
 Fri, 16 Oct 2026 09:25:22 -0700 (PDT)
X-Received: by 2002:a17:90b:510a:b0:3aa:6b5d:9fe4 with SMTP id
 98e67ed59e1d1-3aceebb682cmr332732a91.12.1792167921568; 
 Fri, 16 Oct 2026 09:25:21 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc4872861sm5246143a91.7.2026.10.16.09.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:25:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 5/6] target/s390x: rename qmp_query_cpu_model_expansion to
 qmp_query_s390x_cpu_model_expansion
Date: Fri, 16 Oct 2026 16:25:08 +0000
Message-ID: <20261016162509.24854-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WIHqzXsR c=1 sm=1 tr=0 ts=6ad24ff3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=_EvUVWPg2Jsa6Pmdj2gA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: objEoadeU4-jHG63NXCDJrf_YXN4iQ8a
X-Proofpoint-ORIG-GUID: objEoadeU4-jHG63NXCDJrf_YXN4iQ8a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX21RcDitQXQk5
 TzRaYD3dBYfUuPqtsFUFA8BHgAhcXHf4Lw5dMMbWEjAKe2IpkHnUmyC3J+4LTirX/WgFhDBwpbv
 A7g8GGc25dVEZvGecyPqVHAVxK+JzZ9s+Ivl08Lx4VCx7BhTkHAHTZC9h1ow4rY/lwsuChP44Aq
 3E9CqNvc8qOy+NK7FuOEhp/j13fCHMex3r83Cq0EFEjqwj2F+WY8BaXteNaG3cD4bflO4izFKH7
 ZSVRUVZYVOX6p7R0OnpY3Tdv6Kd/mqfpQ1RLtFopN1pAaLWSuCNNvWRFXFMRdIQDzOQvMeFfy0u
 lXFn62S66zK+ssoUOWM6XCrKHPu3oxLQGHxtpBj9C3j2dNKofhs9I5IjYG/zwZKa0TIBuDO4Zdd
 FTlYZRlSde3G3V7c/MzJoqyvaQy4s4JMO/KFsaOqE1Yfqgenw+VLO2wCapQUJcYcL7rFw7u0m7s
 vJN4HmJUZfs+DpfLT3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX8MfOtqifJYUc
 N6hmfdmnUcp6ohf2ZvYr2Y+UnwwGVEriabtlxLJ9UQdBMmjOLeiM9IOxMf4q1Og4wqMpA8P3dp6
 WVDSB5f+8HdAa6Xp0od397yt4pQYmY0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h         |  4 ++++
 target/s390x/cpu_models_system.c | 15 ++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index 4d530af1c5a..ae58d0cd580 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -33,5 +33,9 @@ CpuModelExpansionInfo *
 qmp_query_riscv_cpu_model_expansion(CpuModelExpansionType type,
                                     CpuModelInfo *model,
                                     Error **errp);
+CpuModelExpansionInfo *
+qmp_query_s390x_cpu_model_expansion(CpuModelExpansionType type,
+                                    CpuModelInfo *model,
+                                    Error **errp);
 
 #endif
diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
index f82b693b0cd..ccfc918b383 100644
--- a/target/s390x/cpu_models_system.c
+++ b/target/s390x/cpu_models_system.c
@@ -209,9 +209,10 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
     }
 }
 
-CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                      CpuModelInfo *model,
-                                                      Error **errp)
+CpuModelExpansionInfo *
+qmp_query_s390x_cpu_model_expansion(CpuModelExpansionType type,
+                                    CpuModelInfo *model,
+                                    Error **errp)
 {
     Error *err = NULL;
     CpuModelExpansionInfo *expansion_info = NULL;
@@ -259,6 +260,14 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     return expansion_info;
 }
 
+CpuModelExpansionInfo *
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    return qmp_query_s390x_cpu_model_expansion(type, model, errp);
+}
+
 static void list_add_feat(const char *name, void *opaque)
 {
     strList **last = (strList **) opaque;
-- 
2.43.0


