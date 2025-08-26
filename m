Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3445CCA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 17:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqxoH-0007hN-V8; Tue, 26 Aug 2025 13:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqxoD-0007ea-Rz
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 13:50:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqxo8-0007IM-2G
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 13:50:13 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45b627ea685so15996315e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756230600; x=1756835400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SewMXGS3C9PprrRoXFBooAU8hl2KOU7xEuIS5b5fjQw=;
 b=P8n8numi0yUWS2kvPHsgq1NTakECXiQAdtxsuogyR2qzBP8zz2P3F4rE5VQDGvm6Wf
 HXqR60DufQgvRuWQMb8lAl3SVjURSA5/QeVYXFhzLjsw+CqPpz36IJ35m3QTDOw/i8C6
 uLt+CarH21zeuS+sij24kFlfYkOrgnM+BZWSGo3iDFeRnJ5eI+fUvBYL5ZzhfIf8jOBb
 CqEAstRK50rglIy6Ehba3/QijmKoJlFp0SfcBSg9E1uodn+lgxUot5fxdGkqojg8roXe
 1MgxrwNFBL7mY9zZEO+ItSwFRDTPD8IFkT9cl3XqcOI0Ly+m/zVHCeOtoqkHNpXU6N1q
 TPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756230600; x=1756835400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SewMXGS3C9PprrRoXFBooAU8hl2KOU7xEuIS5b5fjQw=;
 b=sPkMVF6xMXKa9a8XW+yYAQXE6h4uSwAMiw8Y0F9xLPSD/4Up7xYVdsYDBGAmGLzqg8
 b+26pvZ2e6n+BZce3QpjkF769WEgMb+DiGU2TJb56kS5WF2zOEG/6bgaQlfEHxBL1dAd
 jrE37mD335hwUWUtgJNp0mhIeEooxTnP1Gf62SOF1eNJEzt12uLRiWDA1WZnpsCYx0e0
 npbShaW4BqDOppSjLJjPryC1ickpb1lX4Jf8fFCPh3UztIaYutyKyocc8HnzNnBfdj3t
 SfyANGZVx5aGUxynGuf0RAlo2BVrktzfUKihBsgOZEeM9fvv5zNxrBTjkqacOacFoEsy
 FIFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSbPWkIrnZ/jO6ZHTFOKZgFmtRDAK3g9vz5ivq5L3l1yBfIuX4w6UQO7Ca1HlxTXzBA/mddGgeYvBT@nongnu.org
X-Gm-Message-State: AOJu0YxlJYT7qCZuzfrlE3vQXcL0CKJAhyLaZlb1laLsk5Zclvi4GqVy
 vBBYae6xNFI4BiMDLlEZMEjQFHPrPq877vAma7KE3TJaODF5EPj05oyFeuHdWAMllZA=
X-Gm-Gg: ASbGncvDkJkgO++YAK2uB+nPuhPj8HUcT4Ixb7h1h0hDpFyo2A/wV6IywvoLWrzew01
 xLJh7FdtUq1KTMsBgJoHFAyWe0d1ueO47Yaz232OJuf9kbknU13opWNuYwhd4A8ZbzEv9SKrAHj
 bpjgKEklX9l3lHDxWaShNV97f4EnHGuXkzpLgbJka6C/xjsAzG2hjzjvq2iNwubqs9nz/DnEhO5
 CLovMnRbGkF7sHe+1VF2G4v2EXlHicfO7tts8MduAOxr1MyIT7FaQ1YUaVvo0hiG77apEAZ8vH9
 ig0VZMSrefo7re4LgIZFc/k3uZKEAWNe2DQxzp3qr9apylvLi0eJlEh+c3C54UX7lveJyec3TsT
 3B+qPOeD+zS0EFIXYy89JQLL5ixZ8
X-Google-Smtp-Source: AGHT+IFHjIcnpaePc0el3LVWE2E82mR2SxTjA7Coypu8hPUxMgYwwsV0gYQ7b7oVnd884rexKSbsXw==
X-Received: by 2002:a05:600c:1381:b0:45b:6b57:5308 with SMTP id
 5b1f17b1804b1-45b6b575361mr4639525e9.7.1756230600150; 
 Tue, 26 Aug 2025 10:50:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6c5356a7sm2593435e9.15.2025.08.26.10.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 10:49:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH 1/2] hw/misc/xlnx-versal-cframe-reg: Free FIFO,
 g_tree on deinit
Date: Tue, 26 Aug 2025 18:49:55 +0100
Message-ID: <20250826174956.3010274-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826174956.3010274-1-peter.maydell@linaro.org>
References: <20250826174956.3010274-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In the xlnx-versal-cframe-reg device we create a FIFO in
instance_init but don't destroy it on deinit, causing ASAN
to report a leak in the device-introspect-test:

Direct leak of 400 byte(s) in 1 object(s) allocated from:
    #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c53fecd904ba5fc1f521d7da080a0e4103b)
    #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x5aded850059d in fifo8_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../util/fifo8.c:27:18
    #3 0x5aded582b9e4 in fifo32_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/fifo32.h:35:5
    #4 0x5aded582b326 in cframe_reg_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/misc/xlnx-versal-cframe-reg.c:693:5

Similarly, we don't clean up the g_tree we create:
Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c5
3fecd904ba5fc1f521d7da080a0e4103b)
    #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x71fbfaccc799 in g_tree_new_full (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x93799) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d7
5)
    #3 0x5aded582b21a in cframe_reg_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/misc/xlnx-versal-cframe-reg.c:691:18

Add an instance_finalize method to clean up what we
allocated in instance_init.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/xlnx-versal-cframe-reg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index 1ce083e2409..95e167b9213 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -693,6 +693,14 @@ static void cframe_reg_init(Object *obj)
     fifo32_create(&s->new_f_data, FRAME_NUM_WORDS);
 }
 
+static void cframe_reg_finalize(Object *obj)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
+
+    fifo32_destroy(&s->new_f_data);
+    g_tree_destroy(s->cframes);
+}
+
 static const VMStateDescription vmstate_cframe = {
     .name = "cframe",
     .version_id = 1,
@@ -833,6 +841,7 @@ static const TypeInfo cframe_reg_info = {
     .instance_size = sizeof(XlnxVersalCFrameReg),
     .class_init    = cframe_reg_class_init,
     .instance_init = cframe_reg_init,
+    .instance_finalize = cframe_reg_finalize,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_XLNX_CFI_IF },
         { }
-- 
2.43.0


