Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19154FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWep-00044e-Hw; Fri, 06 Mar 2026 10:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeo-00041j-40
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:02 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWem-0002R8-HG
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:01 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so898319f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809199; x=1773413999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=johyxWgACHRod1tW8e+D3L9ds2TR7uVcjXlXo3awJiM=;
 b=MmnLOeifFgM7jVRs0oHV00X1ymyUVo2YynkFOvdauMkTxDE98hYEVDdr3Z0DBm7xR3
 8QEpchGywdzMKzVzhJjU9D5YGHq+bfbMKUUxVDz9dihmk8AXRpecGsIvzHE3J2mBVsik
 DighV1tXlVyTtcU0L/5Tk2IUOeJ2Y9ngoXeISzQgQZ/4W40clysJeXWsLEqlUhj4lUrQ
 WuFbe/1o0rOw6IFpydIhGPRvIxmU2EGimidkNt9uj0ZhY5DbxU/5Bto7r773eSk9eXYQ
 AAadyLvVp3z2fNXkvsYzIf7aoTYih7NdlZUV92h1lbZ/xpLztnntOjQILLmA+KiVKYE2
 M3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809199; x=1773413999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=johyxWgACHRod1tW8e+D3L9ds2TR7uVcjXlXo3awJiM=;
 b=khruUJqcnE3xwQyZrOxOjfSuf/++sAlIJfUqWYWcpA7/WjIxdau1f9T3WffmDx9IR6
 23jV7tyUbZykPUAxxSNB4VarXDCx1Zn9+TYrAvb+d8+m7CMpb/wukUKdRniIYDfBR3hf
 TMgHjWNMXexMi98NCtff92q6hCdjs+b2BSJwGFxauGe+rsZEwNajb3mEdsq1z7WgEjlV
 qBqRKNRMcXFzKAzUlI5TrTN5IFDzCSCk3nwnEGDE9nZ4zcb5Rilb8dYA0f5N7w4JXX9z
 a0X1jTPTu4Vc3MflsXQgQVBSMvQSgN2muncLqqcgvANHEqtG4D5bqgAgujZFzaaQZiqb
 A8oQ==
X-Gm-Message-State: AOJu0Yy0v4Sp+v/EMApFTrwf1VTkHG3NXqvjEjr9/DRKcXIJt2khetJ9
 4+7s5RnxrpQbFY5PLe3/zc9jloVl+XgzN94/D3yY6cXuberzqOW+P4MOKBZQJfGeBDx8JJNjZvn
 EkHaU
X-Gm-Gg: ATEYQzxGAuoexn3EagCwfcNfVkDQTPs2AdXbg5WyRFg9iVRXJziMuYGWHedClwVJGl+
 gl0RbY/NYyX3buG1UEpCxviQSdEx/b0dcqUtkQotO9yxoV+W5sRMC8tjwr0sFmTrV/IJlEUWNh6
 Jw300Oss/+nfe97mWr35YvlB0AnoZAMXvkspY4EgyT2YExG4UaEEL6LSBY28ZFNe727J35hdpQq
 g9JYDjePXlF+5RJi9n7G4CfAXx8EuR9orKQ3wR42G4xYXY4cZn4i2zC2roUtwfA2UWrXRNFFEtj
 pn7us5q7pGVLMv31n0ZecDt9Jww28fIfLkm/IYF6DGquAR4sC5sDnouELqVyAs0apQqUjSHZrT7
 /FYqKQ+K3RMOmz0QRio+1XlvPl5xI1ma+h/xuNXUONNRWDSG08+w5KbxRDVN0/ib/FuJJMS1Cto
 9Xo9u0TJVA22wdO4dCCDT+yy2TVKbfrvhHmwWBNJUWYCjQY1SG7eJJBQN6PB5zboN5UTNHHKFmk
 7qOFF9OC1JPgkTHSdi7HkTW3oyVKvg=
X-Received: by 2002:a05:600c:c4a5:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-485269199c0mr33306305e9.4.1772809199068; 
 Fri, 06 Mar 2026 06:59:59 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/49] target/arm/machine: Trace all register mismatches
Date: Fri,  6 Mar 2026 14:59:09 +0000
Message-ID: <20260306145939.2162189-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

At the moment, cpu_post_load() exits with error on the first
catch of unexpected register in the incoming stream. Let the code
go further and trace all the issues before exiting.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260304101625.1962633-7-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/machine.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index d9b65b5eed..4d9158e697 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1061,6 +1061,7 @@ static int cpu_post_load(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
+    bool fail = false;
     int i, v;
 
     trace_cpu_post_load(cpu->cpreg_vmstate_array_len,
@@ -1093,13 +1094,14 @@ static int cpu_post_load(void *opaque, int version_id)
      */
 
     for (i = 0, v = 0; i < cpu->cpreg_array_len
-             && v < cpu->cpreg_vmstate_array_len; i++) {
+             && v < cpu->cpreg_vmstate_array_len;) {
         if (cpu->cpreg_vmstate_indexes[v] > cpu->cpreg_indexes[i]) {
             g_autofree gchar *name = print_register_name(cpu->cpreg_indexes[i]);
 
             warn_report("%s: %s "
                         "expected by the destination but not in the incoming stream: "
                         "skip it", __func__, name);
+            i++;
             continue;
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
@@ -1107,12 +1109,18 @@ static int cpu_post_load(void *opaque, int version_id)
 
             error_report("%s: %s in the incoming stream but unknown on the destination: "
                          "fail migration", __func__, name);
-            return -1;
+            v++;
+            fail = true;
+            continue;
         }
         /* matching register, copy the value over */
         cpu->cpreg_values[i] = cpu->cpreg_vmstate_values[v];
+        i++;
         v++;
     }
+    if (fail) {
+        return -1;
+    }
 
     if (kvm_enabled()) {
         if (!kvm_arm_cpu_post_load(cpu)) {
-- 
2.43.0


