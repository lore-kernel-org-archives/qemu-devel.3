Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A00C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEh-0001Q2-VC; Thu, 03 Sep 2026 15:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEf-0001OO-RC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:33 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEd-0004BF-2f
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:32 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so231511a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464189; x=1789068989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ycFh0f47IuceK21rmhYjAzxurWXaF92SY8dhiJMI5DE=;
 b=tB3IlDClbD/8VJsv98HcG5xJFGXZgaeAwRRB4R+Ogvvsa0VVXyNkZZR7F9tR0A5RIh
 hPTi5m+13qsTMuMKMoiY+0tUmH1zVgsa6y43JqYEHdW2GbSzn4hBShF05Lk5hhaI7RGj
 vujqpLIgna/Qo6YwSlJ+FzyMHnT02gUAcSSqUMRwuuVfk/VUEd4GK5fMSQP3GcW+qeta
 G/Wy/rYIlYivBTAlDUUwXcfJFenHxJItMWYIVbWgPZbVik3juZAyovi3fIzTZCVBXPfW
 i8PfC1ys1KXs/SqVtdLni2HjrLeHVJ1ye4ZaT4riopMkzCgl4lFFFmZQE1DAC35WUwkT
 rMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464189; x=1789068989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ycFh0f47IuceK21rmhYjAzxurWXaF92SY8dhiJMI5DE=;
 b=P1aWg+db7328a49az6b4sOKqc8O7TWWW79/F6kDvTfnXZxdFX6Nr/JJ6GKfw+XvRbr
 CoKovRsdmTEEBBsaIrPbn7d4431kSsqqhx7U39G81zt1F8y9H/bwqIhkP8di0ZTLd1TR
 eWS+QSa2zKbNSfjb5SfFQ8weYkrnoP/un7UjbQ+BlAdHlEtu4zAv/kvApoM1cRXb16Be
 WTxvEI9H6fNjB/M7IVq5YDEgZQuJca4IrXW9QGj5dIdLpqg9zv9UuC8At42d6TwKhj13
 JOjuwBtsVw+b3OaJI0U2bcfVcdTJ97MOdzRmdXBvZgIIDdHv36WLilPWotaQ4QI/Xt85
 nABQ==
X-Gm-Message-State: AFuF++kPq5C0eFo35dkRSLDooKLLWqSq9zPqvRcSQLbe/DDU+moO6cJ5
 Anff4iqJ3aUZdWEX8lun4uKt1w+j9VdyBR56sZSpOS4XeKtQZgxdQh2YSd9CuJsq/s8=
X-Gm-Gg: AYBFou3LKf9/TycSgPHwj1gWvY8p0ej6IwizlPZP+8tw7VE/bMrtFZTaZctXUOlUkHd
 oo2iJC75z2L22f0hj/nRqWoS8q7vFBmXPgzgvBYtmO2F5JmhgYlJ+WETFnTaP2QqPWNB5o1GSVk
 tFRoXR2TbPBHkru2O23fKVyBAHnzVIACIn7vIEhnB9P+hD6WzLbvUJQcfWF5WW9sxI5kWou2I5p
 2G3nFgvOqrn/s16Cow1Nqy4jkrJlZnB9K+AnKXLSGsEfTxdcMyZ5kPxq3QOot+tT9RoY0OWN0/D
 fFgNZQSlZe+n1ovXprhiVfbOlW00qt8I9MyHG3WIWhrwL7qXV6004ZZe48LixuI74s0Q9vbpHzb
 HaG94J1tnlJGkrAAtNy/TuR+WSJKm2k2Qdl4jkaqUDWnYxKl2SYGCFh1tVThPS9DEd5MxKfrGYR
 eKJvmmXNx4N04YDppHKlpM3VTvQ6xjgEi2N5VbUsxI4RxiyWfxDyzufvb7qn+c1TwiMePBnoQ4X
 Pprapnlq0gXBUw=
X-Received: by 2002:a17:90b:3d89:b0:398:9be8:ea69 with SMTP id
 98e67ed59e1d1-39b262167e7mr1125588a91.22.1788464189422; 
 Thu, 03 Sep 2026 12:36:29 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:29 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 09/24] hw/core/loader: Add a ROM loader notifier
Date: Thu,  3 Sep 2026 13:35:56 -0600
Message-ID: <20260903193611.1058589-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1034.google.com
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


