Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9743EC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Xd-00008F-WF; Fri, 28 Aug 2026 18:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xc-00006y-ME
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xa-0005jb-Ua
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:20 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTTi43666178
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NNrFXE/s1if
 +xrRnCwzbfpZOJalxjOwkfnyFfG+0DYI=; b=dBKqcKLHOdiEb7TfTU0/10QJbYP
 rtBFTRYs7LaOY3uI/uJTYLPamr/mb6/9y+e8hOhJipTCBuqIVg27tNYW9DID0N3p
 wRQLISJh2A5yd4wDs0/7GLJClqdFk6GmglKRr+afeKVNbUOl6yTAUTMJwXb8rdaS
 dK0b9juz/6Xt1EPlyBZe9zE75lZAzqOZGTe/ORxNAANQuDr0IrDrTm9o4FJ7Mi2F
 v6M/0w/zFQYsRDBb2q/3qomFIb68ql3d6tl1HW3+z4nKRilaV42ahCHq4cpxEU6h
 PPlZfPI4HvBsA4z3J38BVSCSyADE8cZXc0xoaokzyIeEY7WFsFkmJXlA0rg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mubsvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so3590208a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957957; x=1788562757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NNrFXE/s1if+xrRnCwzbfpZOJalxjOwkfnyFfG+0DYI=;
 b=duXCCQ/2XvpHFfkCd5J+SUi52tFuy5QVB+dcWriwo2bfmVap7Fb8/qYJ9XB9AV5f1h
 gROPpvC/h2LnFrohco29GgaQUEgVGN3sb8ubSdwTPH6Kfygh3gNoVIhHF6AoieJvag4I
 Q/jXipNKaxO4hjzi8AVOUqmjyVxU3aY93omTktMbFcWj5bkj8fTfXmis4Cg1xd1mlBOs
 w0ONh/0E95lpy7P/1EQkd+54yZigCEPtWSpNKtgr8fQDIOfD3sGS4HklTPRFT/yyJXvI
 djaJKTD2iyQDhpmc4F6RODr8cJU+eCYl/reHVRfoI0TRrEQMEqBU6KAWh0csTB4tjshk
 nVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957957; x=1788562757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NNrFXE/s1if+xrRnCwzbfpZOJalxjOwkfnyFfG+0DYI=;
 b=EAtOo+878v4t0IuIocRmBsRS8+UGBBn+vdO3jyZEI/lYsoJ3PmaklBaZ0G5NvtUpBe
 ssdJK3tW3HwIf/x2es2wSa5G57/SvjNOFTrB5Wq37aeaMmDsqU2st0dsfSWHKu5PbQTo
 J8ZoW08v8W1MAfIa6JHUb08c+2QoQSxol4x+58qbNnAFYzu3Bdd6IHR3HfQz6l7AXOvn
 jmfytElaRAEkHUgsssRkpZFt4rmy3b0zySn7boyNOSnIO9L19062WNOyAaVZkHbjz52m
 nVrUy1ooYm1XivVxGMaZs+I1vpcAYR9ENW1eVN+MFEWdxsSKcFOi8LDRjZk6FXS6IpKT
 6frw==
X-Gm-Message-State: AFuF++lVlijJZgIbMm9pFSElER93QHH42kEcQL3qyiiLIuy1YyP1C5Cg
 HdQUou+D7/6UEFMDqjlQK8hFVxE2P+NtVecNCRWya+NMXiHxEpm+kzS3Xit6RBSqUuAx5ngfvQj
 wQXqR8IBTATp2nbmVKCIrL8QSd79oGzmgtwrwgWdehjYsuhnErSNrSC035/rZG/bQEQ==
X-Gm-Gg: AYBFou22XitNqtPH+gZP5na7nhJrEavA/2ywmpH0qKjIKn4teq/nWXcwluAmXTRPnmY
 fLmLojr1yTPHLYznk48VDHSXsCw+Swdp8B/1RBjKaH6iTLcUgzxekBW/mxe5UpjfNZUnrDZwgBL
 61xAjH1XR9xEqpqZpIznFMxPoncSiR3/L+XHusnQq4T0rMrGbHUDOQnPyK881sEcEvK2RHuBzh2
 MRzaC5gcTEVCpD+0KF0cvC8a1j0P2Q2CJGTrGo8/e6caFWy92qrdr4qkCwBQg/sUzM96WnEpNft
 YTHibyoHOkTU9P3FUNK0cCZs3DpxWXGA8X2WJaIMv9PXLHqMUy4evSDlJKWDte24UxMwBcxHgiw
 mfTWKZmAW5t2NLvCpYQmUhHqoXKf6iu+8KuPmgseq+8rfAPPC7Hcsdr/VkCA=
X-Received: by 2002:a17:90b:1dcd:b0:398:9be5:b416 with SMTP id
 98e67ed59e1d1-3989be5b4f8mr4403578a91.17.1787957956815; 
 Fri, 28 Aug 2026 15:59:16 -0700 (PDT)
X-Received: by 2002:a17:90b:1dcd:b0:398:9be5:b416 with SMTP id
 98e67ed59e1d1-3989be5b4f8mr4403530a91.17.1787957956369; 
 Fri, 28 Aug 2026 15:59:16 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 09/47] qom/object: add is_available callback to TypeInfo
Date: Fri, 28 Aug 2026 22:58:23 +0000
Message-ID: <20260828225901.367438-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZbMt8MVA c=1 sm=1 tr=0 ts=6a9212c5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=5ZIdXS--4o23KDU03jkA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: a1Ma9Jd2JJpbNklig9Ul0vlD4W7J3J2n
X-Proofpoint-GUID: a1Ma9Jd2JJpbNklig9Ul0vlD4W7J3J2n
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX1U/x3S6O9Obr
 cxj4XnWqC2qFRjg+ohb61Hyad6is4MBzb5ECWlXFWFsLgGc3LqPhpSm1nC9TR9+m4cIPiHhfjwX
 7oZyo+fPNhaym4miit5glbg9l9lwIPM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX8bnF/EXeOdFd
 AfL//uRbkPXboLupfvGYmR0w0sVC2m5mokTDsO0UycF9YUf1fTMt/zGZHBTtTscUZt0gR+YmwPy
 V6ctKBqSJX+3MAgaoGx7GtWs3Rb+shEGhcuQD5GSwNrAXPNARNNWDI2tDlXMcqqpT3C3rkjXKaq
 CgkANoTLLX/fFczjaLTOx1QkEjrAmLmxtVRyshGAlWouZVeAMD/eEeEaNSGeEYanrZLztDFRwSX
 gl2AK8tES4dYrVJdQkJmcOeC3JR/Ltp9seb+jkqBgByepE0hfx3lKBOmlFWz0n6ldr+VBKKxaDJ
 L1VWK3CSNOhq8vcdAdKj/Jt60EhIKBLPt9qzbozeUEUmFOA/RuGpJ+HQktnTcciXuHvt1qK47iI
 z+yVzoBBbKQfQxs6fVSHrLHQQPqFib/9/5Pb4+Nis9oztEUYM/s0btbF+OsylOYrAXZBLJDmF16
 +Bxby34KSOARmlcPW4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

With the single-binary, we start mixing types for different targets,
that may or may not be available for current one.

Previously, we implemented an approach based on interfaces, but it
proved to be too limited. It requires duplication between
machines/cpus/devices, and does not handle specific cases where a type
should be available based on a target configuration (Kconfig).

To solve this, we add a new callback, is_available, to TypeInfo.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qom/object.h | 3 +++
 qom/object.c         | 4 ++++
 rust/qom/src/qom.rs  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index e24f0a2b2d0..7ecd0f210fb 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -469,6 +469,8 @@ struct Object
  * @class_data: Data to pass to the @class_init,
  *   @class_base_init. This can be useful when building dynamic
  *   classes.
+ * @is_available: callback invoked at registration time, to dynamically check if
+ *   this type should be available or not.
  * @interfaces: The list of interfaces associated with this type.  This
  *   should point to a static array that's terminated with a zero filled
  *   element.
@@ -491,6 +493,7 @@ struct TypeInfo
     void (*class_base_init)(ObjectClass *klass, const void *data);
     const void *class_data;
 
+    bool (*is_available)(void);
     const InterfaceInfo *interfaces;
 };
 
diff --git a/qom/object.c b/qom/object.c
index 85bbd7f9fe1..b1834a57cc9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -163,6 +163,10 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
         abort();
     }
 
+    if (info->is_available && !info->is_available()) {
+        return NULL;
+    }
+
     ti = type_new(info);
 
     type_table_add(ti);
diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
index cc00ddcfc98..bbb485e2cfd 100644
--- a/rust/qom/src/qom.rs
+++ b/rust/qom/src/qom.rs
@@ -691,6 +691,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
         class_init: Some(rust_class_init::<Self>),
         class_base_init: Self::CLASS_BASE_INIT,
         class_data: core::ptr::null(),
+        is_available: None,
         interfaces: core::ptr::null(),
     };
 
-- 
2.43.0


