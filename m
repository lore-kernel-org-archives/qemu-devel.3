Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13933C61DC4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzDP-0004F6-FP; Tue, 25 Aug 2026 18:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCx-0003Sj-Fg
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:27 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCv-0001Vz-ND
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:27 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3966791a6eeso561263a91.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695284; x=1788300084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ycFh0f47IuceK21rmhYjAzxurWXaF92SY8dhiJMI5DE=;
 b=WA/vwaPLD2FumlDtapRGoCySttWoQW1TFegYK8mCPWzDLOlDS+6prrD8jxBUaiq10l
 ZHIM+fpgioUeHJx2hNFxdguq64LbIQwA5UbLlT5dFgJYKYGg33n+n6MkSoZv6BLDz/jM
 NWtFwgqlf1wnO12DoInbAC80ha/gWOe6Ppw31ZME/KshVBAacFpJRrJ0rH15ln3fmu+J
 fbJ4pujWs/df1mF8ykFpuYzSnBt4kr6DouCR5UhQ9Y/Xf/iG+r0LmF1IXbUSCSN9S1qS
 Dd8a6fDmE4l//twP1X9ykdT7vMvRGgmIQD8QdKXRwGO+NQTHqZZ7DaIVMij7JQFpaiq0
 juEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695284; x=1788300084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ycFh0f47IuceK21rmhYjAzxurWXaF92SY8dhiJMI5DE=;
 b=PfdfWH+6OlW5EJ25T7Jc2IZ9lgbqKzKTlVbiB/2Pc7n4OaJL5Z0eyMmDcrgK4Rfmro
 x6kOOyKjjLMvQMSPg+SU0T19EVYIDIi6jk8QadqNlP+rwfq35UgbKIzUvXZTiEQyRHxS
 sUH+kyBI7kjsiZhl6A7+M3bBDn89NfUwivaefQ91Ucq1KcQ5miWI1ev/Ulifse6z7KzL
 rxGWICtGCdiW4JETXMZrqGQBdDhBhyJLNVAEUGpzui098dRZmWR7bERWbepu2MrjO/An
 mto3Y0ygEkIZxYvAdjqWpb3oRIFF1uZM5kb6JftKP7NEpNWPgej0SThTA1U2i1+aXR/m
 VI+Q==
X-Gm-Message-State: AFuF++lywO3L5xLe9MOQ+GQ+nMQcL7kRGaDr4bMpvjeoDTOi/DTSit0P
 fXDbpt5h7VfLMbeJrVfYiFjDIYC+qTGM6neO/yoNV+99OhYarEoJLRWMvy8BDc/9spc=
X-Gm-Gg: AR+sD10IiYyyVadIkWdZpf+NFFT5ftMSySW50naJN6QyauKqeVKMYW9rOMLn/J9zH5s
 LHpmvu9DTMc9+dsRKvIioriprMtRF1oY821C9IxAlmzyrDZwY1FmpALsY5ujI5fsCjjp4t6h3Q4
 1IqtY9TQ4Q769PhXSqVf8FF0Ko6z9j3WwMtuNTWGiczJeWdUnJm13CNMH6TtnY/NGaKggZN9TQM
 HFkvsU5g5YJwu/+81u8DrR7CORV5ShTWLQ5lH/hZOOuRdE353URaNXyIrxfu+xP24BbLctxBl+o
 ITZZkN8W8bZUjHbJgz8/eRgQagpZPNVaeixgfuwB0/Aqi/JNar55NgRxnM1JXHz2a9XDbH94foK
 VN5AlBnIwQXoqvpvelPjzFInIUdL62hhRilRsT9hZKj+gzcmSCS640CqsYNBpiuugvZVzLjB7MN
 yQtUT+HIXiquC8+4FMBpc4/lBVtnjxbPBqbNCEc2lKD7g3mJQrbxttHE0UbxwzxncQHOmdLQ7BK
 rAaXFFrHjIn0Tm3AOOSvUko/Q==
X-Received: by 2002:a17:90b:17d1:b0:38e:8300:af51 with SMTP id
 98e67ed59e1d1-3966d20b09fmr3611610a91.8.1787695284101; 
 Tue, 25 Aug 2026 15:01:24 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:23 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 09/24] hw/core/loader: Add a ROM loader notifier
Date: Tue, 25 Aug 2026 16:00:46 -0600
Message-ID: <20260825220101.3443954-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102a.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a function to register a notifier that is invoked when ROMs get
loaded into guest memory.

It will be used by Arm confidential guest support, in order to register
all blobs loaded into memory with KVM, so that their content is moved
into Realm state and measured into the initial VM state.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/core/loader.c         | 15 +++++++++++++++
 include/hw/core/loader.h | 17 +++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5cbfba0a86d2..388f10e828db 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -74,6 +74,8 @@
 #endif
 
 static int roms_loaded;
+static NotifierList rom_loader_notifier =
+    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
 
 /* return the size or -1 if error */
 int64_t get_image_size(const char *filename, Error **errp)
@@ -1201,6 +1203,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
     return mr;
 }
 
+void rom_add_load_notifier(Notifier *notifier)
+{
+    notifier_list_add(&rom_loader_notifier, notifier);
+}
+
 /* This function is specific for elf program because we don't need to allocate
  * all the rom. We just allocate the first part and the rest is just zeros. This
  * is why romsize and datasize are different. Also, this function takes its own
@@ -1242,6 +1249,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
 static void rom_reset(void *unused)
 {
     Rom *rom;
+    RomLoaderNotifyData notify;
 
     QTAILQ_FOREACH(rom, &roms, next) {
         if (rom->fw_file) {
@@ -1290,6 +1298,13 @@ static void rom_reset(void *unused)
         address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
 
         trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
+
+        notify = (RomLoaderNotifyData) {
+            .addr = rom->addr,
+            .len = rom->datasize,
+            .data = rom->data,
+        };
+        notifier_list_notify(&rom_loader_notifier, &notify);
     }
 }
 
diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index d9431e8a8d12..fdfddfa7443e 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -342,6 +342,23 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
 ssize_t rom_add_vga(const char *file);
 ssize_t rom_add_option(const char *file, int32_t bootindex);
 
+typedef struct RomLoaderNotifyData {
+    /* Address of the blob in guest memory */
+    hwaddr addr;
+    /* Length of the blob */
+    size_t len;
+    /* Blog data */
+    uint8_t *data;
+} RomLoaderNotifyData;
+
+/**
+ * rom_add_load_notifier - Add a notifier for loaded images
+ *
+ * Add a notifier that will be invoked with a RomLoaderNotifyData structure for
+ * each blob loaded into guest memory, after the blob is loaded.
+ */
+void rom_add_load_notifier(Notifier *notifier);
+
 /* This is the usual maximum in uboot, so if a uImage overflows this, it would
  * overflow on real hardware too. */
 #define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)
-- 
2.43.0


