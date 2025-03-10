Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737C3C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdEV-0005JJ-JP; Mon, 10 Mar 2025 09:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdEH-0005F1-21
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:31:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdEE-0007MT-DF
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:31:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so4134815e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741613492; x=1742218292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZA80JJJqZ8qMbGMd+HaAS4atcLC9IPAT2AkoQ1qeBY=;
 b=PhjZs/85UcSm9w1cIUyItTJHj2H0Q6SVeaqNumO7uV8UVRisTGC35vmB9szhZXF4sf
 +wWI79vmrN2zSZ9NPTHoFy+QC3BDX088UY8Q4cOAcVZyhTvpopJc1hg4aHfhd07rqXgq
 9NLCEKBhEaVMr2kTfYR/1B/9GAJUqA/KJvZCDUzR4OCzAqEmfJtfChJ+xXQmny1ga9lI
 rdn9hYsMqxhHQscd5VV9fwGrirw9G5GyFIpACkP6mHTvIfi4n8dFAlo8ove/AHP4db0Z
 orZJsSIJthjHuPlEk2tYcZToxiLdfz77oIEwz4J6Z9VnG+rvbXOiCQCERh6LEPVX+nDw
 Xfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741613492; x=1742218292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ZA80JJJqZ8qMbGMd+HaAS4atcLC9IPAT2AkoQ1qeBY=;
 b=Nkeu5ib3+YwFmz3/un8YxeZdhMPzs1Ix6pLeHcy0VqTmBt7GFbIs3DVhwQMgZabsZJ
 M8s63k1isodITLUlyTI8TEzZNOkqitNPcDcr+PoeEhn9zXm8Tuubn8AwWF+enUMgnFcS
 xSUDVkhlm/lrGD1wuO7K4jThA6s3tSMYF//Mwvyw3dI+UhR5zn2il6c1TL7NfZgs1W/C
 kHruB00k6+NcVRh4KCv6L0VL/tVjnaK+ArMTc4OGvaemsMKkTfFdaR+yWUEP1sS6yzUk
 0w47CIXxHK9uWRAFAoJxbQ/8nAaMOQFspVd0IwgertKk1Eq4M4E/uCxmG9rNWXZnfenh
 BG5A==
X-Gm-Message-State: AOJu0YyMuAa8lD93vcUZ/WTlqqafmScpNLuPS0hJPNZX66uI++g6Avd0
 nKTPQNa5r65qdogzSJT3y/rd7vK1q8N1Fl15qjBb4jzDZ4vdpZTHaVNwCmJCVViUOZIkx3lsv6w
 OCNk=
X-Gm-Gg: ASbGncu8r6jqj34pqBSq+r/zCza2lFReajqQwkI3WvtE/pHLntdswdmcXSi7bfQIQfP
 kk4jwvzLBeV2IuOJLuu63oxvFhP+UdH/9GLmC3P8fBmJErAe6dfl1gXcXhJBLfD61+oAp4c74Ow
 Ab+Q1IF3TWZUII3m5NugbCALn6jlv0rlv42dKKqtQYxq/ORsI89oCwXvTMl5xzckI2X9WBmVNBs
 dFIaTRiC5nbUXwvvCErGT+DPsE02+EcRvhna4NKyBzpNmC2VJzSR0Pv7C3BWlG4tgu+6grK3/Es
 DiWmTOntd7G4xMZ3OwQD4nm7Y8PxpC6usOGiolRqwr1XniltUncQnP0RGKc7VYKk3gxe41OUemq
 WIxQebPjOefIwHZlJQ7o=
X-Google-Smtp-Source: AGHT+IHwnfAi14eQlNFQvoW2jaih94AgWaeLC4GwCbImMTo26x0P8ZkSde6jT1h2ckqrKYrRNv84rg==
X-Received: by 2002:a05:600c:4e8e:b0:439:8185:4ad4 with SMTP id
 5b1f17b1804b1-43ce097647fmr58861205e9.27.1741613491828; 
 Mon, 10 Mar 2025 06:31:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cfd1be243sm16868955e9.39.2025.03.10.06.31.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Mar 2025 06:31:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/3] cpus: Introduce SysemuCPUOps::qmp_dump_skeys() callback
Date: Mon, 10 Mar 2025 14:31:17 +0100
Message-ID: <20250310133118.3881-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310133118.3881-1-philmd@linaro.org>
References: <20250310133118.3881-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Allow generic CPUs to dump the architecture storage keys.

Being specific to s390x, it is only implemented there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 6 ++++++
 target/s390x/cpu-system.c        | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 877892373f9..d3534cba65c 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -47,6 +47,12 @@ typedef struct SysemuCPUOps {
      *       a memory access with the specified memory transaction attributes.
      */
     int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
+
+    /**
+     * @qmp_dump_skeys: Callback to dump guest's storage keys to @filename.
+     */
+    void (*qmp_dump_skeys)(const char *filename, Error **errp);
+
     /**
      * @get_crash_info: Callback for reporting guest crash information in
      * GUEST_PANICKED events.
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 9b380e343c2..ab7bb8d5cf5 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -38,6 +38,7 @@
 #include "system/system.h"
 #include "system/tcg.h"
 #include "hw/core/sysemu-cpu-ops.h"
+#include "hw/s390x/storage-keys.h"
 
 bool s390_cpu_has_work(CPUState *cs)
 {
@@ -179,6 +180,7 @@ static const struct SysemuCPUOps s390_sysemu_ops = {
     .get_phys_page_debug = s390_cpu_get_phys_page_debug,
     .get_crash_info = s390_cpu_get_crash_info,
     .write_elf64_note = s390_cpu_write_elf64_note,
+    .qmp_dump_skeys = s390_qmp_dump_skeys,
     .legacy_vmsd = &vmstate_s390_cpu,
 };
 
-- 
2.47.1


