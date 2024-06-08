Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2520C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXw-0000xR-Du; Sat, 08 Jun 2024 04:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXs-0000s6-6G
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXq-0000AG-I2
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9TjUEq0joBz5wLfn12Dg1452CoJ3K5pICZa2UoRjeA=;
 b=Q+yCrxjj/+rjTsd78vY0/T8ojZ+6qG/XdDOpXJWwFr21vAIyOLET5DoviOsNH+vo82g4hU
 VEP+jL45jg++XtEqFlaYR2JJ8d4UhisnlzrbIN/AMjwz7PilzRveFnphnBfGTQKcW/e0Mq
 GaWtXzOcRzyq0MjTzYTCN9NRyNUdoJ0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-cPJEAcgOM62xQIpD3RhQBw-1; Sat, 08 Jun 2024 04:35:21 -0400
X-MC-Unique: cPJEAcgOM62xQIpD3RhQBw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6e8aa42033so63906866b.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835720; x=1718440520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9TjUEq0joBz5wLfn12Dg1452CoJ3K5pICZa2UoRjeA=;
 b=nzaXVJDTqLDAeFmeuQ//ylTPfXK4qRWjUFHHKYcTqVOX2xNSQa/PGqwYWx9StXW2nm
 +C4CxGP+q80aRYHD6orhLgHPqQ5enSzxNd7tPTeCimLGtsOogqWjkQZABKlVlsdW9DJt
 VmM0eMb6AoXqFLfdDHbeukztZ6dthMDHQGTSWLnKti+0VYl9UulrZtMvFnmOfhA9Maqz
 qe+BZNCLUN9ysPJ1G2MTTG2PGn3kyZSKFwsfGN36SpQsUg86oMewK/pS3cTvAaU8B8Xl
 IkG9Bjx3gDVT5eYt/x9agt6a10qf6PdyBBg/LtT4g4OcHtf/1viN0WPjcY/m6aikFX7x
 yfjg==
X-Gm-Message-State: AOJu0YxgB370T83ZQj4ROB4LqWvewlUxI8yuYHSPwVALQKJeXeoJPg01
 1zyMJjkB8tpUJ5+psEsNpNMwHxwyaX+spr01jZ/c3hUiW0PWna9m2JdnabtdRTWA5NQNZPlF2AF
 vphmtUaJ/Nz/Y6EZ/uhLN5dKOx7Ay6MI8ag9XpSY/Jtw3X0072Ooka3vFsjBrWTx7XjzzyvIUmS
 3gl0BPCDSyR1QWG3INsrYAv9FL0VsmTa8ZZ5on
X-Received: by 2002:a17:906:eea:b0:a68:e7df:350b with SMTP id
 a640c23a62f3a-a6cd7891b58mr311926866b.35.1717835720110; 
 Sat, 08 Jun 2024 01:35:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYMa1WMhCFuDmAr/ZKXEx2+ncMD2uIdClLErdaMyFtnkT+15WK2fs7xG56Ekt1/dagzh/y3g==
X-Received: by 2002:a17:906:eea:b0:a68:e7df:350b with SMTP id
 a640c23a62f3a-a6cd7891b58mr311924966b.35.1717835719506; 
 Sat, 08 Jun 2024 01:35:19 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805ca8c6sm354481366b.61.2024.06.08.01.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
	Peter Krempa <pkrempa@redhat.com>
Subject: [PULL 23/42] scsi-disk: Don't silently truncate serial number
Date: Sat,  8 Jun 2024 10:33:56 +0200
Message-ID: <20240608083415.2769160-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

Before this commit, scsi-disk accepts a string of arbitrary length for
its "serial" property. However, the value visible on the guest is
actually truncated to 36 characters. This limitation doesn't come from
the SCSI specification, it is an arbitrary limit that was initially
picked as 20 and later bumped to 36 by commit 48b62063.

Similarly, device_id was introduced as a copy of the serial number,
limited to 20 characters, but commit 48b62063 forgot to actually bump
it.

As long as we silently truncate the given string, extending the limit is
actually not a harmless change, but break the guest ABI. This is the
most important reason why commit 48b62063 was really wrong (and it's
also why we can't change device_id to be in sync with the serial number
again and use 36 characters now, it would be another guest ABI
breakage).

In order to avoid future breakage, don't silently truncate the serial
number string any more, but just error out if it would be truncated.

Buglink: https://issues.redhat.com/browse/RHEL-3542
Suggested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240604161755.63448-1-kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 4bd7af9d0c2..5f55ae54e42 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -58,6 +58,9 @@
 
 #define TYPE_SCSI_DISK_BASE         "scsi-disk-base"
 
+#define MAX_SERIAL_LEN              36
+#define MAX_SERIAL_LEN_FOR_DEVID    20
+
 OBJECT_DECLARE_TYPE(SCSIDiskState, SCSIDiskClass, SCSI_DISK_BASE)
 
 struct SCSIDiskClass {
@@ -648,8 +651,8 @@ static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
         }
 
         l = strlen(s->serial);
-        if (l > 36) {
-            l = 36;
+        if (l > MAX_SERIAL_LEN) {
+            l = MAX_SERIAL_LEN;
         }
 
         trace_scsi_disk_emulate_vpd_page_80(req->cmd.xfer);
@@ -2501,9 +2504,20 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     if (!s->vendor) {
         s->vendor = g_strdup("QEMU");
     }
+    if (s->serial && strlen(s->serial) > MAX_SERIAL_LEN) {
+        error_setg(errp, "The serial number can't be longer than %d characters",
+                   MAX_SERIAL_LEN);
+        return;
+    }
     if (!s->device_id) {
         if (s->serial) {
-            s->device_id = g_strdup_printf("%.20s", s->serial);
+            if (strlen(s->serial) > MAX_SERIAL_LEN_FOR_DEVID) {
+                error_setg(errp, "The serial number can't be longer than %d "
+                           "characters when it is also used as the default for "
+                           "device_id", MAX_SERIAL_LEN_FOR_DEVID);
+                return;
+            }
+            s->device_id = g_strdup(s->serial);
         } else {
             const char *str = blk_name(s->qdev.conf.blk);
             if (str && *str) {
-- 
2.45.1


