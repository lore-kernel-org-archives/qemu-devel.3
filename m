Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA54AC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 05:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLy5C-00025U-OI; Mon, 02 Jun 2025 01:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLy3H-0001fC-IR
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:49:41 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLy3D-0007KU-0u
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:49:37 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-234fcadde3eso48036175ad.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 22:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748843365; x=1749448165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVjrW993BqqXU9EpDADVH1dB+hpwPyajnX8KVD/tm+w=;
 b=HKMURTwqZFITq4K7gO1GPMU2fn4PpsF7cvycKbMSVyJN91/ysKuevWE2F4cd2Fnuw/
 XQmy0a/gun51Sw36GRlGR0YF91jLsQ/8MHo2xt6n02KKqiSWPSSJtYyJrNpZqXdL2iqN
 DQkOwoOGNLfEaDzhz810zjY+YNylcmQH7YIBCSu7IexI5/FxfNGnjJqYAR/0qu35D0To
 5mBvmRCH/iR5+gmw2/0vIq2ijefGO8bd8KxXe1Zp6M7Oe/ZZmeB500wI436W/g4KGODm
 ICpvXgVo39e7he/x90L6NsUVG3pNYs7yZToDhxs67xzDo6bLh1Vp/0Q3rFd8CqNA3tG9
 iuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748843365; x=1749448165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVjrW993BqqXU9EpDADVH1dB+hpwPyajnX8KVD/tm+w=;
 b=vY6wcL0CntTme47kzrWH+2oqD+iWuch1ohANC018uHAD7QPGTt8UMgcYQAiiTvDGv0
 3YqhrkxqFGkhYoHGMVSf/gL3XUBXPTFGhjMyU/nmAnbk96bGsomIGmS0UoMUmjhBn3R6
 EgNj+OA1q11Y1/P1Ttn9YlILHJTX5iaBHqlUA+t/ZSX2mUaE3r9AQBPW60GoCij3ot/q
 O+Wx1BIVt4L2xOmNAnP6Dkit92Sn/Ufm+Yvk99EOY+8Hb3U0giiKEkgr2INrCI2bTJvb
 ooxabh22m9tBrCoa3UWU6sX6s5TgvLikRPlxHqiN9q061gwRz/zsGaxxWf1Z7w93swYW
 iD8Q==
X-Gm-Message-State: AOJu0Yx8YgtT/ud6QilcIj6ENS/ZWw+2UD305YQCy71YmqoSz0/aMIJN
 eftGNxZxdRSAaR1t2RIg0Cm4JFjkFBeyED+GLxtF3OPw6NVneq0fy6+xmVYiZo+YnKc=
X-Gm-Gg: ASbGncs+iNo3gTkvg61BZChywLwJLJZm5IT7cjgOsklmSmndUNxUvENGCnG0Ki7I9Lk
 zbzXd+dE50UA6L0ApN5z37qX2h2d+EopPeGmAE9cV/EKYIsO3mn4s7T8nj+KzZWT/U1KcEQvViM
 4loKP/lLtcrGaQhy2s5yQg/YCMwFiY9OGwlrAeO0B1W2VzCtDfclDYCsQbcKwhMIOjlnUqc6UQD
 8TWdOADC9bvKfirnXJWaBFqNL07ObgB8T1XEdmR2EMLQvEGTU2A4r0YjT2ZUqa5R+KkUxiFkAvH
 fxpIsVETkKcLcpPSM08ds3bZtS2XmpV20/kHN0n0s8d32cY82wo=
X-Google-Smtp-Source: AGHT+IHdvAAwIcTA69PUaX3lJzNaij88l+EBx8zrztEDlgQi9ewOfWkzCmVYeCWp+z15gSht1C9zow==
X-Received: by 2002:a17:902:e5d2:b0:234:8f5d:e3bd with SMTP id
 d9443c01a7336-2355f9ef3cemr104802515ad.39.1748843364969; 
 Sun, 01 Jun 2025 22:49:24 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506bdce12sm63464085ad.99.2025.06.01.22.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 22:49:24 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v5 8/9] plugins: Remove use of qemu_plugin_read_register where
 it is not permitted
Date: Sun,  1 Jun 2025 22:49:15 -0700
Message-ID: <20250602054917.302638-9-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602054917.302638-1-rowanbhart@gmail.com>
References: <20250602054917.302638-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch is required to make the insn plugin work after adding
enforcement of QEMU_PLUGIN_CB_ flags in calls to read or write
registers. Previously, these flags were not enforced and the API could
be called from anywhere, but this was not intended as described by the
documentation. Now, the flags are enforced and qemu_plugin_read_register
can no longer be called from a vcpu_init callback because it does not
request the QEMU_PLUGIN_CB_ flag (nor does it have a mechanism to do
so).

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 tests/tcg/plugins/insn.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 0c723cb9ed..265d3ebe9e 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -81,25 +81,6 @@ static Instruction * get_insn_record(const char *disas, uint64_t vaddr, Match *m
     return record;
 }
 
-/*
- * Initialise a new vcpu with reading the register list
- */
-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
-{
-    g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
-    g_autoptr(GByteArray) reg_value = g_byte_array_new();
-
-    if (reg_list) {
-        for (int i = 0; i < reg_list->len; i++) {
-            qemu_plugin_reg_descriptor *rd = &g_array_index(
-                reg_list, qemu_plugin_reg_descriptor, i);
-            int count = qemu_plugin_read_register(rd->handle, reg_value);
-            g_assert(count > 0);
-        }
-    }
-}
-
-
 static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
 {
     qemu_plugin_u64_add(insn_count, cpu_index, 1);
@@ -295,8 +276,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     insn_count = qemu_plugin_scoreboard_u64(
         qemu_plugin_scoreboard_new(sizeof(uint64_t)));
 
-    /* Register init, translation block and exit callbacks */
-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    /* Register translation block and exit callbacks */
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
-- 
2.49.0


