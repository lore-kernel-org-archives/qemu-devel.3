Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225DE112584F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0M5R-0004Je-P4; Wed, 11 Mar 2026 12:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M5D-00041v-2U
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M59-0005nr-7R
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773245204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ej3dg4x6Sc8xzmx7tFlBTNb/I2tXgDJk9O874jd/4hc=;
 b=QZkw/QoCiCRnOzZRdPZcyDAl9OnYDJ8xPtqRoL6XNG+HbWHoDGF4ep03ke8i9P0l85DkbE
 uPHln8ftkmmHJ0U6gNmWcJRopb22yc/BOiCO70vkrE4mWgUEP0nwvnxoFX30ssw/gyDwMu
 IE9ZHkAj87q7fPxE6ng72Dx9aE5+new=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-Ie4uJB7EPxqUDlgv0VwRXg-1; Wed, 11 Mar 2026 12:06:43 -0400
X-MC-Unique: Ie4uJB7EPxqUDlgv0VwRXg-1
X-Mimecast-MFC-AGG-ID: Ie4uJB7EPxqUDlgv0VwRXg_1773245202
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4853b0af42aso304685e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773245201; x=1773850001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ej3dg4x6Sc8xzmx7tFlBTNb/I2tXgDJk9O874jd/4hc=;
 b=Ox10FB/AG8lty/YPHMCwlyh757YWH9tT4py1DPiewDYBKhmxnY2MMZHMAB28pBLVPL
 sRMGvbRZRPNSTcb/LBMSHzlxZSgQUX1CncFz2JAvFK2PNejsVttkSDGr+liYBIvjVLyP
 UsT5UdEY+9uiaXVH6Cu97d4QH5ZA9iWRxaRXmQ2Mc4GV5zeHkdgk3Jj8CirB0WAwmxKl
 sO+4Hb5dz23HVTJWwf2yAcY3Ay7jWJOmqS8fJZyLgKZTmVMa9uxebLiDmstbBY11ifWa
 AFHCmR7p7GzAXeSp5elgZoyIUDnQmDCoMU4RPzsfWgCd/M+iqfWfwCOLjVEhVLmFCnw1
 WvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245201; x=1773850001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ej3dg4x6Sc8xzmx7tFlBTNb/I2tXgDJk9O874jd/4hc=;
 b=fkEVaGOw/pgMEwW+0vDKA3tAdmkozNSkCwxEE9ra1b60/EbpqRLvMZM+Up3e+R4aD8
 +XOYCPOEEAQctNaahcgfM9vzODW4XvbUVJ4cD0eMw0il1oIzQ2DFsU+7KPqycL5SgZYl
 DF9gp0Jn09tnEKVKrggTaVczsr2tEKSjdc2lrvBFJeD1PZ+o17T8Kt4qCDO8Xpdny3yv
 NEfXPckhObJqVKWIqFgvMeJQdYAaMfQdPNUnQWHQE8/m2OS6lRsE6L+vnoYew5rmLTfi
 q39lMA2SJBivTcV5/EGqIar820fxEbvnyuPNhx5wTmEM/D33DqvN+2Rd0QLuUCk22+K9
 KVLA==
X-Gm-Message-State: AOJu0YxjGISHbmOhuAOpW13U71kHzf7ilxXLU5dgwFikvjc64NcWj1+d
 0btHBPYavgXRtWcrh6VTVmIsJoOVuJpC9BqblCYHPf6cuiyzc3LqkgZ42GTiEvhGBv2nbQvUEYa
 mfp/QQt/CgpYAHl1s67W7/6YLfR9Qst2IDE17h/+bDZrNIygXKBZVNd5I8HiExHtJ
X-Gm-Gg: ATEYQzyVVniOeAOVaac130n1wpTjyR8PEkaak6TQwQb6OkPeA/8cPyX4C4V0G91KcIH
 WSlGHmKZzZyL8EtUE6uQ45a45L5vHbtVQYSJeZvwmrMKAf3GwHO9O7+kn33CuL5bw+JjMDQIei5
 R99TeTxLCtJXZpnfjiO4qIHPWRINoY/5L6jupBqMJmDgHH9aHSPmBS8HqzwNHrWo0J4WLw8V7s6
 OzArph6d6trbXKp+DW3jRLnIyyZP9rkEFV4g8DlPK0G4mNjXgGEd9Ejdoylp3zsQa1Ux4C0CgHD
 S0BwOPfwb4V/WmasfFAwS1yoevPp4TAfg8Lmm78wRLL98k2Hl+cYyNDurq8Z3P5j8xyWmsmPq16
 EihHyrk1psJU3ilUbl8amGngkdQmgvqHBhCuVqY802bG38WPGkcmGgU3t6R/d/PGWWz2N/R2PW+
 nmFEsx
X-Received: by 2002:a05:600c:1988:b0:485:3e6c:aacb with SMTP id
 5b1f17b1804b1-4854b0a527cmr51655645e9.4.1773245200754; 
 Wed, 11 Mar 2026 09:06:40 -0700 (PDT)
X-Received: by 2002:a05:600c:1988:b0:485:3e6c:aacb with SMTP id
 5b1f17b1804b1-4854b0a527cmr51654875e9.4.1773245200229; 
 Wed, 11 Mar 2026 09:06:40 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0216f12b1cbc4c9e6fd.dip0.t-ipconnect.de.
 [2003:cf:d737:d021:6f12:b1cb:c4c9:e6fd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aac28bsm153600955e9.1.2026.03.11.09.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:06:38 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 2/6] qcow2: Always attach data-file given by node name
Date: Wed, 11 Mar 2026 17:06:24 +0100
Message-ID: <20260311160628.344838-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311160628.344838-1-hreitz@redhat.com>
References: <20260311160628.344838-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

With BDRV_O_NO_IO, we suppress opening data-file to prevent opening
unchecked paths through `qemu-img info`.  However, a future commit will
make qcow2_co_create() pass BDRV_O_NO_IO for the new image if possible,
and then we need data-file attached to be able to query its size.

qcow2_co_create() already has the data-file open, so it specifies it by
node name; and if we get the data-file by node name, there is no
security risk attaching it because it is already open.

So check whether the data-file option is a string, i.e. a node name, and
if so, allow attaching it despite BDRV_O_NO_IO.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index cf9189b829..edf18630f6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1410,6 +1410,7 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     uint64_t ext_end;
     uint64_t l1_vm_state_index;
     bool update_header = false;
+    bool suppress_data_file = false;
 
     ret = bdrv_co_pread(bs->file, 0, sizeof(header), &header, 0);
     if (ret < 0) {
@@ -1719,14 +1720,23 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    if (open_data_file && (flags & BDRV_O_NO_IO)) {
-        /*
-         * Don't open the data file for 'qemu-img info' so that it can be used
-         * to verify that an untrusted qcow2 image doesn't refer to external
-         * files.
-         *
-         * Note: This still makes has_data_file() return true.
-         */
+    /*
+     * Don't open the data file for 'qemu-img info' so that it can be used
+     * to verify that an untrusted qcow2 image doesn't refer to external
+     * files.
+     *
+     * Exception: If the data-file option is a node name, attaching that
+     * node will not open a new file, so cannot pose a security risk.
+     *
+     * Note: This still makes has_data_file() return true.
+     */
+    if (flags & BDRV_O_NO_IO) {
+        QObject *data_file = qdict_get(options, "data-file");
+        suppress_data_file =
+            !data_file || qobject_type(data_file) != QTYPE_QSTRING;
+    }
+
+    if (open_data_file && suppress_data_file) {
         if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
             s->data_file = NULL;
         } else {
-- 
2.53.0


