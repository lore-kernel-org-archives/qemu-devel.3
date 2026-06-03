Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C582DCD6E71
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsas-0000zZ-Uw; Wed, 03 Jun 2026 16:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZt-0008Cn-ID
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZm-0004I6-9z
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653HA6r42651365
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CiINoMcGNa7
 BjZALmFPyOcUditi0g/BfBdReZ8MePxg=; b=Z1yItKN414+a0FGQQGM+n5pOQGR
 SdBxucNIzYP+rek+4yIOaW8RK3rYHk3FuP0SeFrr8G8D1kkVqEm2//QMmae5AyJ5
 ATqniAi+qpYo9JQhnH9tDxkZ4tANdVd7jdaKWfcV9BADuTTPuUrsByNXSIqf8HAp
 h8avj6kCoHu1gnnOvSkCT0nHmRz561ThxgKIB9JIiSKyIgXmHE0Sl/ZpaBp3iG6E
 3wE1WBMnFUOWht3/B5354S0kMFAfu2OiE3f0m8lWbrmtJsq9EPzo0+eFIYB7dyxJ
 RTFIGoxSfjU2B60ZEHpQ8M3GbBVpt+XU1Vm39MWfHbMYIxm/lOqBNWe/ciQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejre9gvhn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:26 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30762d67a64so444312eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519945; x=1781124745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiINoMcGNa7BjZALmFPyOcUditi0g/BfBdReZ8MePxg=;
 b=IlbNSqLhXrEf6OsvBalxuucdu0a6lXpfbcVg18I9ZKRWCYpEuNklwGqdSRLy6n1kW3
 9k+a59Dygk65cMqGzJaTYjMW/EAjQ2ckyyRsziJ1P9ZUeLSt0yOJpLk6j6c6ZH+/1I05
 g1RGLUrFEq+dDbVngEaoNFIRdy/ojflqIyeiILFsIr5t0mtvhkWaMD9kJBk8JXMg+A+A
 it+LvUB6+UDOwjpGJMplvibIk4DGN6Yu7KDwZj340Bz/igE0ApZc1a4ZyRIDt192qs6o
 F7Ys8bcMkVE+IouNbBew4x+nwww5IspwMK4B/ih7QZCNUL7YBR/vmf+8e0DLsQv0G2O7
 iyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519945; x=1781124745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CiINoMcGNa7BjZALmFPyOcUditi0g/BfBdReZ8MePxg=;
 b=scv0wrkna5v9svKP5RB1XdJYrFPgkOSIfTYC9iHSkNsC3SP5PQ+w33mRbCVGXi1Qmo
 tah9M+SkvIvlrSwEfK2w2Qawc2OWIxFLc1zRTYCp7nnDbTuma4CNP4Qx8ydEXK03cr+Y
 t3Mls56Lcm3ZiJWP13Mw8S0muk0orGUkjsL8yjxBtNJvUz33KQFifgOAmDY8LYruXQFT
 Fp5VCweJeCk8QqA+quYUBoRyfGFciVEj+8GNVPe8qm+aRlK8F/99An09t4FEfqbopIvQ
 ZpyboV2kGPt31Kj6AcTKGVIMAvDwCAgq9Ggt0QXhQkAsERnIe3+UUZWtuOESgVRddEss
 ZOiA==
X-Gm-Message-State: AOJu0YwNbwlC5pJwSTDtqw332ZjtHzeC17wAgBGYB34lIlG4FlUX4Vvl
 XDoBOZjAbJkayLUeuXMjFWjii6dc5L9sgrSmdJjxTuiFbwNRtQlIbNT8sTiPV6EPE0rW54Z4H49
 rbDpMcbA1CAvK9anq8tKnHo/yyAKIz70Gp4wFGzwbehNkXokePB/IDD2xRrDJ2qbq9wGp
X-Gm-Gg: Acq92OFf0FpvxMiF+qm7SumX2X36hJdADxGNG9Wx5LKoqDXzT4fddGa2oLABrHy6E4g
 9iMF0/5TeAK8pmcraSYmq4rM4eSQRljx7TvV8HTHkA8i/QBMrzWvCqFUOG5AAO4lUYIBmAzinal
 yPG2vNGJC5Ggx4eWqJK7vKSMG+ULGdKe6ghAdN9bi1P1kYM1CtZPeUfCXbDTTUJNYIO6t4RhbZt
 UkzVysPhZjvuOYNt4lCfUjn/aldpUv2T1b7+hHWF6FvJQzIvJ3vi1Pvl+F9D5EH6w4PLjwYBkUO
 x7ifVKUL+RSWAtn3rnSP3MZxEt6I00Sm3b8YFxkE6Zl0xUAeDRUcFEiTR+cTI3TZtZ9V4cGYPVt
 BfLz/X+i4LFAoGkZXoU/OIhka3VB8gQhX3v7BYmaOTSVJkG3NHkbqndNLMr7U1N3B/UWVnBIM8I
 8vZujv/SX2zCmoQHo6
X-Received: by 2002:a05:7300:2393:b0:304:cefc:5fd7 with SMTP id
 5a478bee46e88-3074fc910bbmr2757606eec.32.1780519945053; 
 Wed, 03 Jun 2026 13:52:25 -0700 (PDT)
X-Received: by 2002:a05:7300:2393:b0:304:cefc:5fd7 with SMTP id
 5a478bee46e88-3074fc910bbmr2757582eec.32.1780519944492; 
 Wed, 03 Jun 2026 13:52:24 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 18/25] plugins: add userdata to
 qemu_plugin_register_vcpu_syscall_cb
Date: Wed,  3 Jun 2026 13:51:45 -0700
Message-ID: <20260603205152.1440291-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YjHxKfGQwY1q2Xc_dr3qEJa8ZcdFBl-w
X-Proofpoint-GUID: YjHxKfGQwY1q2Xc_dr3qEJa8ZcdFBl-w
X-Authority-Analysis: v=2.4 cv=KoF9H2WN c=1 sm=1 tr=0 ts=6a20940a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=HFGiEJlbZgj7dAjcEtYA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX3JC3htBkIr4j
 qecnjwhg9rdUJz1RPXfMHlymTUz1CwynzRpYefh3uIues3XRRhxc71kvGdUqmhIkGzzYIZ1eHuk
 qqVDcR1SH4eVLN3NutPpSkIHXRbx6tNQeNRflBkHcsIue3el3tp+5zClf4/2qeaFHDeNR6dLeTF
 tBJG2n1yd4gTKeIFficGcHunSocKGf9Qt5leBkS+7wFWhL00+1P9XZVuFeDjrvGZQsYB0+iLZxi
 wmOeDj7CHhDiuV3VtIUs8xo5qPBBirVnOZ5k34e0BuvToaPrFjO5CHVy5YY+g9EXcVp9zPopKkx
 Hf1x/OPcnT3HHRQFXM1ErQlvinzhJbZBmjlslIvBERivY8ByPM+y/7LEOy8Vj/yeqNiBySqYEnT
 1VjxVwhW+xnGnpmms78+owHWq9+Uj4V1kTtO5gZcyEHXFAhkpi8MEs5JOnb5RmPeWbaqnUCBXRw
 URPMojwmzb5O2hmTLcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030203
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
 include/plugins/qemu-plugin.h | 8 ++++++--
 plugins/api.c                 | 5 +++--
 plugins/core.c                | 2 +-
 tests/tcg/plugins/syscall.c   | 5 +++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index d82d996bce6..909f19b7128 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -840,12 +840,14 @@ void qemu_plugin_update_ns(const void *handle, int64_t time);
  * @a6: the 6th syscall argument
  * @a7: the 7th syscall argument
  * @a8: the 8th syscall argument
+ * @userdata: user data for callback
  */
 typedef void
 (*qemu_plugin_vcpu_syscall_cb_t)(unsigned int vcpu_index,
                                  int64_t num, uint64_t a1, uint64_t a2,
                                  uint64_t a3, uint64_t a4, uint64_t a5,
-                                 uint64_t a6, uint64_t a7, uint64_t a8);
+                                 uint64_t a6, uint64_t a7, uint64_t a8,
+                                 void *userdata);
 
 /**
  * typedef qemu_plugin_vcpu_syscall_filter_cb_t - vCPU syscall filter callback
@@ -891,13 +893,15 @@ typedef void
  * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry callback
  * @id: plugin id
  * @cb: callback of type qemu_plugin_vcpu_syscall_cb_t
+ * @userdata: user data for callback
  *
  * This registers a callback for every syscall executed by the guest. The @cb
  * function is executed before a syscall is handled by the host.
  */
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
-                                          qemu_plugin_vcpu_syscall_cb_t cb);
+                                          qemu_plugin_vcpu_syscall_cb_t cb,
+                                          void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_syscall_filter_cb() - register a syscall filter
diff --git a/plugins/api.c b/plugins/api.c
index 774b1b80214..a72cec541dc 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -202,9 +202,10 @@ void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
 }
 
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
-                                          qemu_plugin_vcpu_syscall_cb_t cb)
+                                          qemu_plugin_vcpu_syscall_cb_t cb,
+                                          void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_SYSCALL, cb, userdata);
 }
 
 void
diff --git a/plugins/core.c b/plugins/core.c
index 878fc47cbe1..45136bf950a 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -533,7 +533,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        func(cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
+        func(cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8, cb->udata);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index bfe12ad5558..8a823acfca7 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -128,7 +128,8 @@ static void hexdump(const GByteArray *data)
 static void vcpu_syscall(unsigned int vcpu_index,
                          int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5,
-                         uint64_t a6, uint64_t a7, uint64_t a8)
+                         uint64_t a6, uint64_t a7, uint64_t a8,
+                         void *userdata)
 {
     if (statistics) {
         SyscallStats *entry;
@@ -271,7 +272,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         memory_buffer = g_byte_array_new();
     }
 
-    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
+    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall, NULL);
     qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
     qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
-- 
2.43.0


