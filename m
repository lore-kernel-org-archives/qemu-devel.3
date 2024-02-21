Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9814C5478B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctzw-0004D4-LU; Wed, 21 Feb 2024 16:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzf-0002lS-6K
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:19:07 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctza-0001Jj-TX
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:19:06 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412698ac6f9so1289045e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550341; x=1709155141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFzn/uz4uT8liK1wRCr+n2ERXfHQX8sWgAYNC3jQl+0=;
 b=n2dttVdBCvZ3XNufC5L9oz2YztjKdNL8T24gkYt5DLdIBJqg1UTz9fuNtn4hLFfk9n
 +PvxjYaCDXoPAZdo9FaYdC8EJkoPROnWXhWqL4+eXYPFN7RdbMghWtoFwUwhJl/Yv9G2
 Da/EG1l8RiNLd8flO2JsQTg8bry2tNi3b+Ng6RNzHiedbThRnSDcUXzeNUhNIW4gSUqB
 YhlgpTwKPt2rLqyfDobEETEAsW4uJcHnoV6xkNOktyedThsqIlUQokOk1bWQ5eCUroJt
 RwBow/tZiLpWx4Tog8GmRqP0UA7lltQGCIZCq9r6ZCQUbqnuaRb9tsb2ed2xBLfUVbNt
 g2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550341; x=1709155141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFzn/uz4uT8liK1wRCr+n2ERXfHQX8sWgAYNC3jQl+0=;
 b=ojIlMfdyHPXQVcGQqlgHWgtaiUGTnqbKJIYvmhvfgt9e5PtfJdZDpeEsM8UyWSpCk9
 3NhV0cHoeys5JSU7eGOnLCCAUiajCZ7i/9V5XOerxxaY2S9pb/ltlABsZ6HUoMMt593G
 rq1GmjwrBGLq8yjlkMWYHuk6MBxpovlZjuyT6391HzUVQkKnMF1ccd4gPcUsRhVSVKTO
 s0DbJ/EK837w3N10Nib18fHNgkRyZ48j6ep9DCHhzX/Bk490pez2JKsWg9NHHaCthabk
 12cGqG6Lpsaj//6zFHmdbjbjBSwfYBdYJ+3Gxn94C/jotUhKXM6jaYrbxUTKK68+B2rA
 TONw==
X-Gm-Message-State: AOJu0YwK/Bv0qnL0eCqYGoOAlTNvYsvgazVUMbJW/v7OAYU5uwn6RJtq
 vk9K4lwG/imc92nrtYvZn1zIIMh+fwWyuE6q5hheB6mGYlsSXwVam4PAXrtIoGcC7LzL/0CKSst
 uuP0=
X-Google-Smtp-Source: AGHT+IHf9EQhiCU8LHUlBdO0p3JrfPu98BpjiTZ0nGDY8kx3KV7sY1HdG089qjEqbX6G39NNiKGoHw==
X-Received: by 2002:a5d:4d8e:0:b0:33d:2012:6d64 with SMTP id
 b14-20020a5d4d8e000000b0033d20126d64mr609702wru.4.1708550340703; 
 Wed, 21 Feb 2024 13:19:00 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 r2-20020a05600c35c200b004123b049f86sm19731963wmq.37.2024.02.21.13.18.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:19:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 21/25] hw/ide: Move IDE device related definitions to ide-dev.h
Date: Wed, 21 Feb 2024 22:16:21 +0100
Message-ID: <20240221211626.48190-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Untangle internal.h by moving public IDE device related
definitions to ide-dev.h.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240220085505.30255-5-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ide/ide-dev.h  | 143 +++++++++++++++++++++++++++++++++++++-
 include/hw/ide/internal.h | 143 +-------------------------------------
 hw/ide/ide-dev.c          |   1 +
 3 files changed, 144 insertions(+), 143 deletions(-)

diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index 7e9663cda9..1f62e58ebc 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -20,9 +20,150 @@
 #ifndef IDE_DEV_H
 #define IDE_DEV_H
 
+#include "sysemu/dma.h"
 #include "hw/qdev-properties.h"
 #include "hw/block/block.h"
-#include "hw/ide/internal.h"
+
+typedef struct IDEDevice IDEDevice;
+typedef struct IDEState IDEState;
+typedef struct IDEBus IDEBus;
+
+typedef void EndTransferFunc(IDEState *);
+
+#define MAX_IDE_DEVS 2
+
+#define TYPE_IDE_DEVICE "ide-device"
+OBJECT_DECLARE_TYPE(IDEDevice, IDEDeviceClass, IDE_DEVICE)
+
+typedef enum { IDE_HD, IDE_CD, IDE_CFATA } IDEDriveKind;
+
+struct unreported_events {
+    bool eject_request;
+    bool new_media;
+};
+
+enum ide_dma_cmd {
+    IDE_DMA_READ = 0,
+    IDE_DMA_WRITE,
+    IDE_DMA_TRIM,
+    IDE_DMA_ATAPI,
+    IDE_DMA__COUNT
+};
+
+/* NOTE: IDEState represents in fact one drive */
+struct IDEState {
+    IDEBus *bus;
+    uint8_t unit;
+    /* ide config */
+    IDEDriveKind drive_kind;
+    int drive_heads, drive_sectors;
+    int cylinders, heads, sectors, chs_trans;
+    int64_t nb_sectors;
+    int mult_sectors;
+    int identify_set;
+    uint8_t identify_data[512];
+    int drive_serial;
+    char drive_serial_str[21];
+    char drive_model_str[41];
+    uint64_t wwn;
+    /* ide regs */
+    uint8_t feature;
+    uint8_t error;
+    uint32_t nsector;
+    uint8_t sector;
+    uint8_t lcyl;
+    uint8_t hcyl;
+    /* other part of tf for lba48 support */
+    uint8_t hob_feature;
+    uint8_t hob_nsector;
+    uint8_t hob_sector;
+    uint8_t hob_lcyl;
+    uint8_t hob_hcyl;
+
+    uint8_t select;
+    uint8_t status;
+
+    bool io8;
+    bool reset_reverts;
+
+    /* set for lba48 access */
+    uint8_t lba48;
+    BlockBackend *blk;
+    char version[9];
+    /* ATAPI specific */
+    struct unreported_events events;
+    uint8_t sense_key;
+    uint8_t asc;
+    bool tray_open;
+    bool tray_locked;
+    uint8_t cdrom_changed;
+    int packet_transfer_size;
+    int elementary_transfer_size;
+    int32_t io_buffer_index;
+    int lba;
+    int cd_sector_size;
+    int atapi_dma; /* true if dma is requested for the packet cmd */
+    BlockAcctCookie acct;
+    BlockAIOCB *pio_aiocb;
+    QEMUIOVector qiov;
+    QLIST_HEAD(, IDEBufferedRequest) buffered_requests;
+    /* ATA DMA state */
+    uint64_t io_buffer_offset;
+    int32_t io_buffer_size;
+    QEMUSGList sg;
+    /* PIO transfer handling */
+    int req_nb_sectors; /* number of sectors per interrupt */
+    EndTransferFunc *end_transfer_func;
+    uint8_t *data_ptr;
+    uint8_t *data_end;
+    uint8_t *io_buffer;
+    /* PIO save/restore */
+    int32_t io_buffer_total_len;
+    int32_t cur_io_buffer_offset;
+    int32_t cur_io_buffer_len;
+    uint8_t end_transfer_fn_idx;
+    QEMUTimer *sector_write_timer; /* only used for win2k install hack */
+    uint32_t irq_count; /* counts IRQs when using win2k install hack */
+    /* CF-ATA extended error */
+    uint8_t ext_error;
+    /* CF-ATA metadata storage */
+    uint32_t mdata_size;
+    uint8_t *mdata_storage;
+    int media_changed;
+    enum ide_dma_cmd dma_cmd;
+    /* SMART */
+    uint8_t smart_enabled;
+    uint8_t smart_autosave;
+    int smart_errors;
+    uint8_t smart_selftest_count;
+    uint8_t *smart_selftest_data;
+    /* AHCI */
+    int ncq_queues;
+};
+
+struct IDEDeviceClass {
+    DeviceClass parent_class;
+    void (*realize)(IDEDevice *dev, Error **errp);
+};
+
+struct IDEDevice {
+    DeviceState qdev;
+    uint32_t unit;
+    BlockConf conf;
+    int chs_trans;
+    char *version;
+    char *serial;
+    char *model;
+    uint64_t wwn;
+    /*
+     * 0x0000        - rotation rate not reported
+     * 0x0001        - non-rotating medium (SSD)
+     * 0x0002-0x0400 - reserved
+     * 0x0401-0xffe  - rotations per minute
+     * 0xffff        - reserved
+     */
+    uint16_t rotation_rate;
+};
 
 typedef struct IDEDrive {
     IDEDevice dev;
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index a3a6702eec..1aab89b27b 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -8,23 +8,17 @@
  */
 
 #include "hw/ide.h"
-#include "sysemu/dma.h"
-#include "hw/block/block.h"
 #include "exec/ioport.h"
 #include "hw/ide/ide-dma.h"
+#include "hw/ide/ide-dev.h"
 
 /* debug IDE devices */
 #define USE_DMA_CDROM
 #include "qom/object.h"
 
-typedef struct IDEDevice IDEDevice;
-typedef struct IDEState IDEState;
-
 #define TYPE_IDE_BUS "IDE"
 OBJECT_DECLARE_SIMPLE_TYPE(IDEBus, IDE_BUS)
 
-#define MAX_IDE_DEVS 2
-
 /* Device/Head ("select") Register */
 #define ATA_DEV_SELECT          0x10
 /* ATA1,3: Defined as '1'.
@@ -327,23 +321,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(IDEBus, IDE_BUS)
 #define SMART_DISABLE         0xd9
 #define SMART_STATUS          0xda
 
-typedef enum { IDE_HD, IDE_CD, IDE_CFATA } IDEDriveKind;
-
-typedef void EndTransferFunc(IDEState *);
-
-struct unreported_events {
-    bool eject_request;
-    bool new_media;
-};
-
-enum ide_dma_cmd {
-    IDE_DMA_READ = 0,
-    IDE_DMA_WRITE,
-    IDE_DMA_TRIM,
-    IDE_DMA_ATAPI,
-    IDE_DMA__COUNT
-};
-
 extern const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT];
 
 extern const MemoryRegionPortio ide_portio_list[];
@@ -361,97 +338,6 @@ typedef struct IDEBufferedRequest {
     bool orphaned;
 } IDEBufferedRequest;
 
-/* NOTE: IDEState represents in fact one drive */
-struct IDEState {
-    IDEBus *bus;
-    uint8_t unit;
-    /* ide config */
-    IDEDriveKind drive_kind;
-    int drive_heads, drive_sectors;
-    int cylinders, heads, sectors, chs_trans;
-    int64_t nb_sectors;
-    int mult_sectors;
-    int identify_set;
-    uint8_t identify_data[512];
-    int drive_serial;
-    char drive_serial_str[21];
-    char drive_model_str[41];
-    uint64_t wwn;
-    /* ide regs */
-    uint8_t feature;
-    uint8_t error;
-    uint32_t nsector;
-    uint8_t sector;
-    uint8_t lcyl;
-    uint8_t hcyl;
-    /* other part of tf for lba48 support */
-    uint8_t hob_feature;
-    uint8_t hob_nsector;
-    uint8_t hob_sector;
-    uint8_t hob_lcyl;
-    uint8_t hob_hcyl;
-
-    uint8_t select;
-    uint8_t status;
-
-    bool io8;
-    bool reset_reverts;
-
-    /* set for lba48 access */
-    uint8_t lba48;
-    BlockBackend *blk;
-    char version[9];
-    /* ATAPI specific */
-    struct unreported_events events;
-    uint8_t sense_key;
-    uint8_t asc;
-    bool tray_open;
-    bool tray_locked;
-    uint8_t cdrom_changed;
-    int packet_transfer_size;
-    int elementary_transfer_size;
-    int32_t io_buffer_index;
-    int lba;
-    int cd_sector_size;
-    int atapi_dma; /* true if dma is requested for the packet cmd */
-    BlockAcctCookie acct;
-    BlockAIOCB *pio_aiocb;
-    QEMUIOVector qiov;
-    QLIST_HEAD(, IDEBufferedRequest) buffered_requests;
-    /* ATA DMA state */
-    uint64_t io_buffer_offset;
-    int32_t io_buffer_size;
-    QEMUSGList sg;
-    /* PIO transfer handling */
-    int req_nb_sectors; /* number of sectors per interrupt */
-    EndTransferFunc *end_transfer_func;
-    uint8_t *data_ptr;
-    uint8_t *data_end;
-    uint8_t *io_buffer;
-    /* PIO save/restore */
-    int32_t io_buffer_total_len;
-    int32_t cur_io_buffer_offset;
-    int32_t cur_io_buffer_len;
-    uint8_t end_transfer_fn_idx;
-    QEMUTimer *sector_write_timer; /* only used for win2k install hack */
-    uint32_t irq_count; /* counts IRQs when using win2k install hack */
-    /* CF-ATA extended error */
-    uint8_t ext_error;
-    /* CF-ATA metadata storage */
-    uint32_t mdata_size;
-    uint8_t *mdata_storage;
-    int media_changed;
-    enum ide_dma_cmd dma_cmd;
-    /* SMART */
-    uint8_t smart_enabled;
-    uint8_t smart_autosave;
-    int smart_errors;
-    uint8_t smart_selftest_count;
-    uint8_t *smart_selftest_data;
-    /* AHCI */
-    int ncq_queues;
-};
-
 struct IDEBus {
     BusState qbus;
     IDEDevice *master;
@@ -475,33 +361,6 @@ struct IDEBus {
     VMChangeStateEntry *vmstate;
 };
 
-#define TYPE_IDE_DEVICE "ide-device"
-OBJECT_DECLARE_TYPE(IDEDevice, IDEDeviceClass, IDE_DEVICE)
-
-struct IDEDeviceClass {
-    DeviceClass parent_class;
-    void (*realize)(IDEDevice *dev, Error **errp);
-};
-
-struct IDEDevice {
-    DeviceState qdev;
-    uint32_t unit;
-    BlockConf conf;
-    int chs_trans;
-    char *version;
-    char *serial;
-    char *model;
-    uint64_t wwn;
-    /*
-     * 0x0000        - rotation rate not reported
-     * 0x0001        - non-rotating medium (SSD)
-     * 0x0002-0x0400 - reserved
-     * 0x0401-0xffe  - rotations per minute
-     * 0xffff        - reserved
-     */
-    uint16_t rotation_rate;
-};
-
 /* These are used for the error_status field of IDEBus */
 #define IDE_RETRY_MASK 0xf8
 #define IDE_RETRY_DMA  0x08
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index 15d088fd06..c8e2033469 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -23,6 +23,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/ide/ide-dev.h"
+#include "hw/ide/internal.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
-- 
2.41.0


