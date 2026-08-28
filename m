Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B1DC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YD-0000ew-AU; Fri, 28 Aug 2026 18:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YA-0000dk-IA
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y8-0005nz-Qf
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTrs5503150
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fIFG6JbO1ml
 bQvZnNwow3mImO/O7WxrUTH+Pd4LwHs8=; b=pGMJc+OvqUdwFv85EnI9JTaXuM5
 v6TLwwkmtDuCqt1CsSFtvD0HugIaogoK3rD3oLx4r8RDai770v08TOWdYAD4Jeu0
 OtA8RWk07IXhoDpali67d35jM6XffOfgnzwitIQvtzyk8U0iNAuftOlG/mK6vCPh
 TACzZyuK7uFQhhadQjyByOKyRWxDwOIU9oZxtnXblM5M/btpg5HdCMIY5e8r7vwm
 QRviI3rR9v37BXQsZF8JQ2HU2mwLUBosAg0Oul5Q6LkzhVudfc0hibuKDuSPLIZI
 88gGJdxW3k7lzLB1nCPvJLeDzXyAwiWsMCRLlLi5zFiyEu5uMjs/UCh9fPg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbgpc0gr9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3968bb86fb7so2209360a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957991; x=1788562791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fIFG6JbO1mlbQvZnNwow3mImO/O7WxrUTH+Pd4LwHs8=;
 b=If0AA6RREvnD4RzekB7Xpaa/jaj/fsBpb01OFpmjfPzp4l5h3BCEgh87tZ8kBUctFB
 5ljOsvZ+NxyrjZWukxeQOiEeP2voiEnHQIN8ek5yC6bDaLdDZ25QscenY9WSFaWx580h
 fkXXu5aS3kB+usMZ2Hsrsa5u7854jOV2Ng7T511ukrg4Oko4TuJ+aSI3S0vKnzIPomxF
 KCET4FqKKVc3/he52DVm9WjGG2rMSVTcZTfgtYEdz8o3HTpvxb6EDvNW35EURuapY/1q
 a/ph/EOl8OsqIZs5V0fFTaFoc0bPpXq8xm1GMQh0zPmhF3ic7TCqpMv7LeTKJT3Z15xE
 nWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957991; x=1788562791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fIFG6JbO1mlbQvZnNwow3mImO/O7WxrUTH+Pd4LwHs8=;
 b=LFYpYrBOCrjZWcP3re/nPjtskA7cIHQFtQc1h1xyybYaPI/DtQR1TmHdpxys8BAfsa
 hfe2jFBrb5RXfGkvl0rtqaIOXnktIzHGHvh6Y9gs7wryRufDZ5iViiPq7MryfjupIgGO
 tZvi23DMjPfdF78oFHPUqaoXGLHqMfsEgeDaE0zRvIzjY8N+GM58nN9VvQrIhEIeg/vc
 WETTP2q/+T/yZgNxGMPhBVy4dfDo1WEJbk/AINGFwzowWDXSn3tDDKox8lnZKE5Cg5UK
 P3J5xBfX/QQihN6c2OAiA0/WmAXDJFDr1hUYVWt+vTP8EIo9Ik/bM5mRPD56VYVOmg+S
 p0Ew==
X-Gm-Message-State: AFuF++mG+K/tUyxt6b7vpLlykFJHGzJgD5rP0JDeeXe+jeOuJqIIOjZD
 K0EtM1vyM3vfVQ4CDXUScvlEGrWOzNSzXDWTABvVsUxz1oAlbvJaBBKp6gE6Dd1FVeZzUT3aaaY
 0Q62lA3GoL+4W9KtDBjewHC6y71YP4wm82dc/xnNWu9cadvX3JzBDOfb5UZ04Ih/HRg==
X-Gm-Gg: AYBFou3aZaQYkz+vUnzahCSXrvvhY0yeL5Iup50rUbnhpxD4gu2w2fg1LkhxqOvTb/i
 syyr6FoD6aOI/itaF/pwtyhg8dJUfYkEMsND8kL2peQ1Rwsdsto6Pc8o++dHh8DZRNQ2kafQsIv
 B78MdjVV1AlewdP6P7j00oB9ldbX196jRC6xAD5VWKEkUeUOP8nAFKmbEOrrRD3N+gx4uQDMaKo
 ggqF/BGRP4hTSugVZ9SMw4R1NgFdjpLgKsND2m1ehhm3w6wmWKbiBuZi3L5QwBLUfitaUKq5k23
 ICbpDXOFl3fOKpf/00UTXoRwMp3ytiiR3CpEQy4kGWdTTIXNZlrnS2hZTod9qusQtECVGGnvWd5
 aOCJUh31knsi84F2Lm7lA8gdATswO4V/+FIcmp1Yc+5ffaVz353mYTgewxDY=
X-Received: by 2002:a17:90b:50:b0:398:9bd1:3217 with SMTP id
 98e67ed59e1d1-3989bd135e2mr4434203a91.24.1787957990815; 
 Fri, 28 Aug 2026 15:59:50 -0700 (PDT)
X-Received: by 2002:a17:90b:50:b0:398:9bd1:3217 with SMTP id
 98e67ed59e1d1-3989bd135e2mr4434164a91.24.1787957990384; 
 Fri, 28 Aug 2026 15:59:50 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 34/47] system/vl: fallback to detect target from argv[0]
Date: Fri, 28 Aug 2026 22:58:48 +0000
Message-ID: <20260828225901.367438-35-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: h8z_WElc5HQC3we3zggaBWThJbYx0YKV
X-Proofpoint-GUID: h8z_WElc5HQC3we3zggaBWThJbYx0YKV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX+PKwWPDe4AN7
 loqxQQ3bcL7UWxahr51mqTIrSmBGiVA//Jos/dB8ozU5PWtw/k3pUxt6aN42H7BTgkq+q+kGLVv
 nxhHaJefRe+Yb7Y2Y31oxAoovExMtp0=
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a9212e7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=NwfIHIH1ne--GP4jnRoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX2q4KvVK3XqFw
 5Kez9rgJkWShcilbIiVyeBswpU+L8nJA8SCgOUrg66U+OwHXSPw62i2OIODRZVuEXFv3FVOS7xe
 9JvfD4Z3yFy3glK9NeVT15J8SC52nDtpdKWUroQDkQoyyIBzw2pLymG2AgfYsD4ATTUwiHvmA+p
 eJGkSgIeYB2dLDsmhNFpt0xNeoR0y3eBiH+CAsNTC6wBWr4q/UPH/ZtpZVH6+yPo7iqzthJWM2d
 ffXnf8DFwjgiV86/5kX8wVVirmKO6giTihxui7lLLrfpY+s+SjkgnSBf9At3vdEqotZ7ypLNURn
 YSIY4q4kvn9JkKvUjOIDqxn68n9HUxZMoHaO6HxncqEuSm7EAWGzlmbs4n+6x61emTA4G9N0qgo
 inItDPQY2eLFrdlwXPriFaLBWBS0ZA7nVCvy3fmGdQh2t/Ghkf6lflWOoiVWTf/+c1mDNp4v8bN
 76VL4woQ3K1b+MYINMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

The existing target_info_qom_set_target() enforces that a single target
is available at runtime.

Now, we can derive target from current qemu binary name.

If a single target is available, select it and ignore binary name.
If multiple targets are available, we strip various parts from binary
name and check if an available target match this name.
In case target is set through -target option, we simply pick this one.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-qom.h |  1 +
 system/vl.c                    |  2 +-
 target-info-qom.c              | 61 ++++++++++++++++++++++++++++++++++
 tests/qtest/fuzz/fuzz.c        |  2 +-
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 87f3a51ccd4..7643a90d49b 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -27,5 +27,6 @@ OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
 
 void target_info_qom_set_target(void);
 void target_info_qom_set_target_from_name(const char *name);
+void target_info_qom_set_target_from_argv0(const char *argv0);
 
 #endif /* QEMU_TARGET_INFO_QOM_H */
diff --git a/system/vl.c b/system/vl.c
index 60c5ce85580..dc415bfe02d 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2928,7 +2928,7 @@ void qemu_init(int argc, char **argv)
         }
     }
     if (!target_info()) {
-        target_info_qom_set_target();
+        target_info_qom_set_target_from_argv0(argv[0]);
     }
 
     module_init_info(qemu_modinfo);
diff --git a/target-info-qom.c b/target-info-qom.c
index a2f506c15ef..069d867ea30 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -84,3 +84,64 @@ void target_info_qom_set_target_from_name(const char *name)
     list_targets_available();
     exit(1);
 }
+
+void target_info_qom_set_target_from_argv0(const char *argv0)
+{
+    g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
+    size_t num_targets = g_slist_length(targets);
+    g_assert(num_targets > 0);
+
+    /* if we have only one target, set it as default */
+    if (num_targets == 1) {
+        const TargetInfo *ti = TARGET_INFO_CLASS(targets->data)->target_info;
+        target_info_ptr = ti;
+        return;
+    }
+
+    g_autofree char *basename_cstr = g_path_get_basename(argv0);
+    g_autoptr(GString) basename = g_string_new(basename_cstr);
+
+    const char *rm_common_patterns[] = {"qemu-system",
+                                        "qemu-fuzz",
+                                        "-target",
+                                        "-unsigned",
+                                        ".exe",
+                                        NULL};
+    for (const char **rm = rm_common_patterns; *rm; ++rm) {
+        size_t len = strlen(*rm);
+        char *found = strstr(basename->str, *rm);
+        if (found) {
+            size_t pos = found - basename->str;
+            g_string_erase(basename, pos, len);
+        }
+    }
+
+    /* remove ^[-.] */
+    const char *rm_separator[] = {"-", ".", NULL};
+    for (const char **rm = rm_separator; *rm; ++rm) {
+        size_t len = strlen(*rm);
+        if (!strncmp(basename->str, *rm, len)) {
+            g_string_erase(basename, 0, len);
+        }
+    }
+
+    /* remove [-.]{ok, ko, this-is-my-custom-binary-name, .*} */
+    for (const char **rm = rm_separator; *rm; ++rm) {
+        char *end = strstr(basename->str, *rm);
+        if (end) {
+            size_t pos = end - basename->str;
+            size_t len = basename->len - pos;
+            g_string_erase(basename, pos, len);
+        }
+    }
+
+    if (basename->len > 0) {
+        target_info_qom_set_target_from_name(basename->str);
+        return;
+    }
+
+    /* we have a qemu-system single-binary and multiple targets */
+    error_report("missing -target parameter");
+    list_targets_available();
+    exit(1);
+}
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index a3a131c80f8..eda899d43ae 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -174,7 +174,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     /* Initialize qgraph and modules */
     qos_graph_init();
     module_call_init(MODULE_INIT_TARGET_INFO);
-    target_info_qom_set_target();
+    target_info_qom_set_target_from_argv0((*argv)[0]);
     module_call_init(MODULE_INIT_FUZZ_TARGET);
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_LIBQOS);
-- 
2.43.0


