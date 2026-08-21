Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431CEC5DF94
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 23:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxZ1F-0001Uf-LZ; Fri, 21 Aug 2026 19:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxZ1D-0001Tx-CG
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 19:51:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxZ19-0002GI-38
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 19:51:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LMnBi13755562
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 23:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WdACKUQk8cf
 RxiBvZ666cJ3wF+P3DDBhy83vRvX87jE=; b=M74riHoinmiHuBPz+/y0QtktzXd
 it4fCiklS+gBt4z+9hAPinKHFHJVIQsh6kSB14ZUto3jsdNcT8i4KuuLvtm1j8bY
 qOTBW/JRfsATouIi98/0B4L5XrYk9IkQ9EedYlm+OhxhlXJAE6O0t/SNOH822X93
 gDVT1hTofAhm5b1Na0Ik+k2FDWSv+vRUBz+AXrGZEG5CqCTUxYcWjNWa9GItxUH4
 +6WMSGxDKfEn6PY+1xrG18OmOcu8EjRxRXNlLYvhYBura/LctzrIKJtUUGPwy10j
 3NzAkwscBmWUQr8lF+2y5wuvHcL5CxPW4mhXYVBECMUug6wpj7lYI+qoPsQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6yt784gr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 23:51:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbedf42f199so1663469a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 16:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787356280; x=1787961080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WdACKUQk8cfRxiBvZ666cJ3wF+P3DDBhy83vRvX87jE=;
 b=fIl4+XjvDrVX53BE0yCfpdC3Tk4+I7Sngs5qgySHbqcEuVhcgNmTiCnmKu9boffU2O
 kOdu4FKDGfDftujIgYp2BCyQkbTNVh7JKI5HAydldJJ0eWr3V5ZrPi2VzBP4TPH26o2r
 UTt+LTAJiTrhzvG2pYjePeQdJnU60enMREfuXApB603BlO6pPryMVT0OG/mUPuT9AVNE
 mMs0KnrKlLrlX6PknwWaFR/Vb8xt5m34edxZuQELyGrS5Ic//BigICcLoUsTDEJMfQmu
 v3AN0vGD1DDtL5hSMFK1j9ZqQANFul71m77WDuXc+IGnZwjD3QvLdWDIaVEDRLQVdQRN
 y6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787356280; x=1787961080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WdACKUQk8cfRxiBvZ666cJ3wF+P3DDBhy83vRvX87jE=;
 b=tQY3e/wN9/y7WyYGfbBl11OL9JeJI0ojgwj7S1kk2nqYUAhmzSKBJaCmqZ9OxwSHi6
 V22zGNkMk5uwChkBJLf0J/vwyDXnRNMeNmlNvTIMZvLufZBwzqkfHfwCi0cym9rxTtFL
 qutaMBhiIO9VaUwG/45QA6HUF1gWEVw+SMpLnKAkdkRURLOaQlud6klfp82tb0faWycd
 tIDXmShn+BXQpyumQ4dfENx07wTyZ7mQmOfyVI2xkoQcQ5hRRYNXvWia13ImvfL217S2
 PmST09CK1RdJzZJ2qYdpUV39Cql8T+xOr73G9nThrniqCTMca/ow7LciYi31mfDRbUtc
 sKXg==
X-Gm-Message-State: AFuF++m2nIq23B1W1NceYx1ZsjYi7iY4gCOclpXTK53p376kJilimPWK
 FCkx6VK44LCHkYP8/4xVo25iEY+ofcVlqC3y1uBhNjzzQW2l45GOD7spJ8MPmaNiSDPWmhxXGmJ
 D0Ij+cxql+D4OQ/9LUKhnskktK3lK/oz46vKpRDuBmfHeorTQgQQXw88UHdrUzEK+oQ==
X-Gm-Gg: AR+sD13NFLqdA7IfEA37g4WpCk+mX/x7P8ROom+k0m+ZCcHlFNpIrYGwRRHqEZWPtbI
 s2oU4AQ/g5tK8BYdljRJjHY+HaYUm/PNAIZdieWkzQpdT/S4R/TJmh1f9wLEY98D/E2f/5NFnVN
 DNyCqP+2D2LJdS8Iyq3cyI5jwEpa1RKCZWK5D+tDFSy920s2AVhbAbnV2FtOyrAE5+eVykmm6qq
 n4dQk80iOwQaRWvb7C9C1f/D1uXxZ2OabNPSgU0W/1C/4zdS4vSNiRgk5MI2n+e4RSUCBF9ErPs
 /vJzTVNaV3+m6wwXQwxvSFoVhDHDRXQSY9k2sMBDw/DNAdNk8CIw+ya810TRs5wW64Wng6LyEu/
 wu3/sZ1YMLOuRrR5ksbD5wWYAtrvH8VbnkWSpqlhpKwHXSuwt8+7SMXp3q5k=
X-Received: by 2002:a17:90b:4d0e:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-395decb87edmr2820272a91.0.1787356280290; 
 Fri, 21 Aug 2026 16:51:20 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0e:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-395decb87edmr2820224a91.0.1787356279733; 
 Fri, 21 Aug 2026 16:51:19 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4af6e88sm605618a91.9.2026.08.21.16.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 16:51:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@oss.qualcomm.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 1/2] qom/object: add available_if field to TypeInfo
Date: Fri, 21 Aug 2026 23:51:11 +0000
Message-ID: <20260821235112.193381-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821235112.193381-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260821235112.193381-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE5MiBTYWx0ZWRfX93lmpnYXOaDj
 I2iYHT+5XXHhaMwxW4X8yoGLHq0q3ZWkkCOhMHnenI+/V4jBqLgqxo7gKEgj/qEvh/PH6evZQRo
 BDoKf+sWza8+IeCPIwHZtRn9VcCqB/4=
X-Proofpoint-ORIG-GUID: _XQosya_UWTEgols9S2Iio8bmlxfMB1_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE5MiBTYWx0ZWRfXxVZs9T8pd+Od
 XO+dOHX/CNLUaxSBAewJvxOOsXVU9aBg8sDXvi3J3Of1boTejR6g0HLb6cpeoewdiN6hQIHvMH3
 2eXJDJhVuwTNkImDO4vx1nYvUZPdrYW887xBgfxBAuLVRI0rB22XCHhPI+mm+o2dzLDXGpZU8tY
 /rZcIg1CCyAHTrt22JO62n92IJqQX+oDTt3ZVNmv8Yv+1lrVpmMCe878F7QL0Fh1kBMWp1kMomK
 pLK/hHWMPagtUAuBa8PAxfo3mqGmeHffnobXhmbRm/WfHPvM6JSDk5Xm6MEIwk8E2kVPLR/rRyz
 AGcskmMg76rvsT82Rp4UH5PmKKCg2XrhFsXs18Nx1lvKj7KZDbYqbyHn2N/fPFJ8DD8d0S4GFda
 NdofZ/ROQJ0V7OsYhavQYvDvMYRlMwanltA04f2LRYuVJXw5P15NL12j0Gyh+UPjfw3u6TcZtNa
 sSHFX1iRutMXm7rjCXQ==
X-Authority-Analysis: v=2.4 cv=b9KCJNGx c=1 sm=1 tr=0 ts=6a88e479 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=JYRGAXhrQzj-LjSNeY0A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: _XQosya_UWTEgols9S2Iio8bmlxfMB1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210192
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

With the single-binary, we start mixing types for different targets,
that may or may not be available for current one.

Previously, we implemented an approach based on interfaces, but it
proved to be too limited. It requires duplication between
machines/cpus/devices, and does not handle specific cases where a type
should be available based on a target configuration (Kconfig).

To solve this, we add a new field, available_if, to TypeInfo.
It is an array containing a list of requirements for type to be
available.

For now, we have only targets as requirements, but later we'll add
specific target config entries also.

We also add a TARGET_REQS macro, to declare a list of requirements. For
sanity sake, we don't use a complex variadic macro prefixing each
parameter. It requires a lot of macro boilerplate in C, and prevent
readers to jump easily to definition for each parameter.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 11 +++++++++++
 include/qom/object.h       |  5 +++++
 qom/object.c               | 10 ++++++++++
 rust/qom/src/qom.rs        |  1 +
 stubs/meson.build          |  1 +
 stubs/target-info.c        | 11 +++++++++++
 target-info.c              | 13 +++++++++++++
 7 files changed, 52 insertions(+)
 create mode 100644 stubs/target-info.c

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 6c5b714288e..6379e65bbcf 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -50,6 +50,17 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+typedef enum TargetReq {
+    /* 0 is reserved for end of array */
+    TARGET_REQ_BASE_ARM = 1,
+    TARGET_REQ_AARCH64,
+    TARGET_REQ_ARM,
+} TargetReq;
+
+#define TARGET_REQS(...) (const TargetReq[]){__VA_ARGS__, 0}
+
+bool target_requirement(TargetReq Req);
+
 /**
  * target_base_arm:
  *
diff --git a/include/qom/object.h b/include/qom/object.h
index 11b1c9d2dc8..75bac929c14 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -24,6 +24,7 @@ typedef struct TypeInfo TypeInfo;
 
 typedef struct InterfaceClass InterfaceClass;
 typedef struct InterfaceInfo InterfaceInfo;
+typedef enum TargetReq TargetReq;
 
 #define TYPE_OBJECT "object"
 #define TYPE_CONTAINER "container"
@@ -469,6 +470,9 @@ struct Object
  * @class_data: Data to pass to the @class_init,
  *   @class_base_init. This can be useful when building dynamic
  *   classes.
+ * @available_if: List of requirements for type to be available. This
+ *   should point to a static array that's terminated with a zero filled
+ *   element.
  * @interfaces: The list of interfaces associated with this type.  This
  *   should point to a static array that's terminated with a zero filled
  *   element.
@@ -491,6 +495,7 @@ struct TypeInfo
     void (*class_base_init)(ObjectClass *klass, const void *data);
     const void *class_data;
 
+    const TargetReq *available_if;
     const InterfaceInfo *interfaces;
 };
 
diff --git a/qom/object.c b/qom/object.c
index 47977b1f440..02c5cd9d7b8 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -17,6 +17,7 @@
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
+#include "qemu/target-info.h"
 #include "qapi/visitor.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
@@ -172,6 +173,15 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
 TypeImpl *type_register_static(const TypeInfo *info)
 {
     assert(info->parent);
+
+    if (info->available_if) {
+        for (const TargetReq *req = info->available_if; *req; ++req) {
+            if (!target_requirement(*req)) {
+                return NULL;
+            }
+        }
+    }
+
     return type_register_internal(info);
 }
 
diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
index cc00ddcfc98..f065df57542 100644
--- a/rust/qom/src/qom.rs
+++ b/rust/qom/src/qom.rs
@@ -691,6 +691,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
         class_init: Some(rust_class_init::<Self>),
         class_base_init: Self::CLASS_BASE_INIT,
         class_data: core::ptr::null(),
+        available_if: core::ptr::null(),
         interfaces: core::ptr::null(),
     };
 
diff --git a/stubs/meson.build b/stubs/meson.build
index 3b2f2680b19..dee2bc5a1a2 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -8,6 +8,7 @@ stub_ss.add(files('iothread-lock.c'))
 stub_ss.add(files('is-daemonized.c'))
 stub_ss.add(files('monitor-core.c'))
 stub_ss.add(files('replay-mode.c'))
+stub_ss.add(files('target-info.c'))
 stub_ss.add(files('trace-control.c'))
 
 if have_block
diff --git a/stubs/target-info.c b/stubs/target-info.c
new file mode 100644
index 00000000000..ab034e7a8d2
--- /dev/null
+++ b/stubs/target-info.c
@@ -0,0 +1,11 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info.h"
+
+bool target_requirement(TargetReq req)
+{
+    return true;
+}
diff --git a/target-info.c b/target-info.c
index 04c69c41f8a..a4ff24e021f 100644
--- a/target-info.c
+++ b/target-info.c
@@ -47,6 +47,19 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
+bool target_requirement(TargetReq req)
+{
+    switch (req) {
+    case TARGET_REQ_BASE_ARM:
+        return target_base_arm();
+    case TARGET_REQ_AARCH64:
+        return target_aarch64();
+    case TARGET_REQ_ARM:
+        return target_arm();
+    }
+    g_assert_not_reached();
+}
+
 bool target_base_arm(void)
 {
     switch (target_arch()) {
-- 
2.43.0


