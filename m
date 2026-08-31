Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D92C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12RP-0004Nq-CY; Mon, 31 Aug 2026 09:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12RM-0004Mo-Mo
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12RJ-000418-EO
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788184364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KN20tbZuutJDgdlaY9S7sS/A8dOBAhXHQZ9ffbHxohc=;
 b=Gqfffr/XCiUBzpS9CgexNirO37/5Kn51jH3eAb5vMGNyjfxHFchZ8yNE5YK+OnkCtPo+uq
 Z/rt956ZxodKa4UU4i4DSbpWfnHAXF5gi27Zs4lXe7eyhrfdZVeglLa1/QWgKpXniI789B
 HAxGs08DHk0k/6CjSIl/UI3AL8aKnY8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-_excqipuNdWJfh1rnWNcFA-1; Mon, 31 Aug 2026 09:52:43 -0400
X-MC-Unique: _excqipuNdWJfh1rnWNcFA-1
X-Mimecast-MFC-AGG-ID: _excqipuNdWJfh1rnWNcFA_1788184362
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-499913d1a79so19535145e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788184362; x=1788789162; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KN20tbZuutJDgdlaY9S7sS/A8dOBAhXHQZ9ffbHxohc=;
 b=fMhidweCFcYtE1vnd/8wPatwC0Vad3Z18t53xXW9vIc9ku/Sb1aSPL/1zsiVAcf3Yo
 q+8kkLN47bW8eKHirkfPp8Z8XHZ0+TRIKFEzoOiFxC8lc/hRCK4llu/die2+OGxpB8Hr
 3ymOR04nCknDcXFIqY175dxo4x1LlB4ahA/6/2nb5uVJUJoWooZXwjwFHIaddj1hs1Lo
 Y6mEkoO1bac/RoTG1YZ9GzdfTN5MXPr5JjPZ+phLCEr/SyvY2as4jaMtxgmLw0t616A4
 IlCvLFYwrZocFbJMyHM2ggU+YjSP8L76rRlMtJLiwIXGXSdUlPkjYP37HSlsFnMuI904
 1aDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184362; x=1788789162;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KN20tbZuutJDgdlaY9S7sS/A8dOBAhXHQZ9ffbHxohc=;
 b=Q15YbA0E+hQRwyRpHHvuSNoqiTZJvZQDW8AxYQQ2czYrGgWhi7US5V4wjx+KUzhIim
 1VNqz8gJWJVWJr9iw05pCu5FEC03lx+AkpTokSGz8LU4w1Gi4z8JUzxZPJVs1diobR+L
 0Y+gGUaNb+oKJTUw8yDd41wAjoqTDVUJ7Xod2OWJTbk4LSQUb01i3oHidPTN9k6oQATO
 VRzba7ru+TH8NU1WkXXYkF0tieJsvGTzAFMCMoxnVam5VWFTU6h0oZ7ZeVdwx0wTzUib
 cgzcKfpW/VdjVad0fViDiKdgrTi9nBy1S5HFtlwX+LgChwq+gOJUmH+VExdrLbdMeQPK
 8cGA==
X-Gm-Message-State: AFuF++kBZUoaRkqpxHTsCEYed25iOi7rZw4psuYOjcl2oneYcOyKwfJM
 G3+CePcXlp3//xsxZBjxd1aKDKl3CUez1qq3iHfOngcgpG1TtQOGQoqbyb3W+srgNzg/pDKZir2
 8364De/h8Fm3EBSr5TmE7oReQctxUsl3PZEzHZ7CT6XTDN5Aj1+E7JiZD
X-Gm-Gg: AR+sD13OuWsBC/Rc9/2gWZ0sy6W+JYul4UMSAlmZAPloyAjVtcXXD5IXPmTCIkt69xr
 6UdZn9t8MTsx43f8gm96I9L+RmWDiLGcAE2QQeimIJD8ebBDYYwPockla5rb8GFR75IBDY8xgRP
 j8RwTsCax+HQBAAtIOsHTCZkezOm8VmS4f8aqwDHnI60rd0fzkdllDHtGhLgbtwbid+vA4NKWlS
 m0OBVWMNRNITZoP87etW1HPHlN4h0160f24PnMrjrk+f4V8AW21jkhKx1iLmH/gjlbzLpYWJ2n0
 UFcqAfv1kePTNVudRQqX0MHK9T5NByQYLeKYkLKhcCKcSq5HuFhrnAZZJ147bq+1dgFQ2a1gAdw
 osSzKWjn9Cbf599F1wl3rBMQ+YKbchUkDwetykEfybTQp+oaSndWymbI+WFU=
X-Received: by 2002:a05:600c:3b13:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-49cdc4332d4mr13504425e9.7.1788184361720; 
 Mon, 31 Aug 2026 06:52:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3b13:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-49cdc4332d4mr13503275e9.7.1788184361258; 
 Mon, 31 Aug 2026 06:52:41 -0700 (PDT)
Received: from localhost
 (p200300cfd72080187472d8ceb75e67b1.dip0.t-ipconnect.de.
 [2003:cf:d720:8018:7472:d8ce:b75e:67b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9266be71sm615958675e9.2.2026.08.31.06.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:52:38 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 7/9] block: Add delay-alert-ms property
Date: Mon, 31 Aug 2026 15:52:03 +0200
Message-ID: <20260831135206.126184-8-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831135206.126184-1-hreitz@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

This device property allows setting up an I/O latency threshold for when
to emit a delay QMP event.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/hw/block/block.h   |  5 ++++-
 blockdev.c                 | 16 +++++++++++++++-
 hw/block/block.c           |  4 +++-
 tests/qemu-iotests/172.out | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index df941df19f2..e7e401dd303 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -36,6 +36,7 @@ typedef struct BlockConf {
     BlockdevOnError werror;
     uint32_t num_stats_intervals;
     uint32_t *stats_intervals;
+    uint32_t delay_alert_ms;
 } BlockConf;
 
 static inline unsigned int get_physical_block_exp(BlockConf *conf)
@@ -83,7 +84,9 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
                             _conf.account_failed, ON_OFF_AUTO_AUTO),    \
     DEFINE_PROP_ARRAY("stats-intervals", _state,                        \
                      _conf.num_stats_intervals, _conf.stats_intervals,  \
-                     qdev_prop_uint32, uint32_t)
+                     qdev_prop_uint32, uint32_t),                       \
+    DEFINE_PROP_UINT32("delay-alert-ms", _state, _conf.delay_alert_ms,  \
+                       0)                                               \
 
 #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          \
     DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      \
diff --git a/blockdev.c b/blockdev.c
index 195bac8af01..9c76e89ef38 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -496,6 +496,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
     BlockdevDetectZeroesOptions detect_zeroes =
         BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF;
     const char *throttling_group = NULL;
+    uint64_t delay_alert_ns;
 
     /* Check common options by copying from bs_opts to opts, all other options
      * stay in bs_opts for processing by bdrv_open(). */
@@ -580,6 +581,14 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
 
     read_only = qemu_opt_get_bool(opts, BDRV_OPT_READ_ONLY, false);
 
+    delay_alert_ns = qemu_opt_get_number(opts, "delay-alert-ms", 0);
+    if (delay_alert_ns > (uint64_t)INT64_MAX / SCALE_MS) {
+        error_setg(errp, "delay-alert-ms must not exceed %" PRId64,
+                   INT64_MAX / SCALE_MS);
+        goto early_err;
+    }
+    delay_alert_ns *= SCALE_MS;
+
     /* init */
     if ((!file || !*file) && !qdict_size(bs_opts)) {
         BlockBackendRootState *blk_rs;
@@ -618,7 +627,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
         bs->detect_zeroes = detect_zeroes;
 
         block_acct_setup(blk_get_stats(blk), account_invalid, account_failed,
-                         NULL, 0, 0, NULL);
+                         NULL, 0, delay_alert_ns, NULL);
 
         if (!parse_stats_intervals(blk_get_stats(blk), interval_list, errp)) {
             blk_unref(blk);
@@ -3753,6 +3762,11 @@ QemuOptsList qemu_common_drive_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "whether to account for failed I/O operations "
                     "in the statistics",
+        },{
+            .name = "delay-alert-ms",
+            .type = QEMU_OPT_NUMBER,
+            .help = "threshold in ms when to emit an I/O operation "
+                    "delay QMP event",
         },
         { /* end of list */ }
     },
diff --git a/hw/block/block.c b/hw/block/block.c
index 19301c6f995..be0ea89cb79 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -207,6 +207,7 @@ bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
     BlockBackend *blk = conf->blk;
     BlockdevOnError rerror, werror;
     uint64_t perm, shared_perm;
+    uint64_t delay_alert_ns;
     bool wce;
     int ret;
 
@@ -249,9 +250,10 @@ bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
     blk_set_enable_write_cache(blk, wce);
     blk_set_on_error(blk, rerror, werror);
 
+    delay_alert_ns = (uint64_t)conf->delay_alert_ms * SCALE_MS;
     if (!block_acct_setup(blk_get_stats(blk), conf->account_invalid,
                           conf->account_failed, conf->stats_intervals,
-                          conf->num_stats_intervals, 0, errp)) {
+                          conf->num_stats_intervals, delay_alert_ns, errp)) {
         return false;
     }
     return true;
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index a023cd407de..ea6a1875eb3 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -31,6 +31,7 @@ Testing:
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "288"
 
 
@@ -61,6 +62,7 @@ Testing: -fda TEST_DIR/t.qcow2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -98,6 +100,7 @@ Testing: -fdb TEST_DIR/t.qcow2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -113,6 +116,7 @@ Testing: -fdb TEST_DIR/t.qcow2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "288"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -154,6 +158,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -169,6 +174,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -211,6 +217,7 @@ Testing: -fdb
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "288"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -226,6 +233,7 @@ Testing: -fdb
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "288"
 
 
@@ -256,6 +264,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -293,6 +302,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -308,6 +318,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "288"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -349,6 +360,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -364,6 +376,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -409,6 +422,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -446,6 +460,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -483,6 +498,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -498,6 +514,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -549,6 +566,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -564,6 +582,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -606,6 +625,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -621,6 +641,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -663,6 +684,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
@@ -678,6 +700,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -720,6 +743,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
@@ -735,6 +759,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -786,6 +811,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -801,6 +827,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -843,6 +870,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -858,6 +886,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -906,6 +935,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global floppy.drive=none0 -device
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -973,6 +1003,7 @@ Testing: -device floppy
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "288"
 
 Testing: -device floppy,drive-type=120
@@ -1000,6 +1031,7 @@ Testing: -device floppy,drive-type=120
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "120"
 
 Testing: -device floppy,drive-type=144
@@ -1027,6 +1059,7 @@ Testing: -device floppy,drive-type=144
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 
 Testing: -device floppy,drive-type=288
@@ -1054,6 +1087,7 @@ Testing: -device floppy,drive-type=288
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "288"
 
 
@@ -1084,6 +1118,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "120"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -1121,6 +1156,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "288"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -1161,6 +1197,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -1198,6 +1235,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                delay-alert-ms = 0 (0x0)
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
-- 
2.55.0


