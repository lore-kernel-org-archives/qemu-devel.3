Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123A5CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hu2-0004qV-NQ; Fri, 03 Oct 2025 11:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htO-0004jL-6n
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htA-0007a5-8m
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKCVQ3pZe2HNt0PqEVTV3Z1mxHwK6jBevkFo6zZP+M0=;
 b=U1n10SL/go1pA4zDqlFFuo8hDzzfJzGSV2UxKR/YX6vh1/oPhPORUADv6n+W3Y70Ng9L0G
 WLLXB9zr7PS5S11zOtHUo9A+oJFmL+IX/u5f/vd76HpUkR+cT6+4ljZfnq1ZK9Q+cqkjiC
 F5VIDDJZETZzBtEw/nPi0rcQHeo70Ww=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-x4wdz4OWOCS7T5mEjIV53g-1; Fri, 03 Oct 2025 11:40:03 -0400
X-MC-Unique: x4wdz4OWOCS7T5mEjIV53g-1
X-Mimecast-MFC-AGG-ID: x4wdz4OWOCS7T5mEjIV53g_1759506002
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-79e48b76f68so67121176d6.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506002; x=1760110802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKCVQ3pZe2HNt0PqEVTV3Z1mxHwK6jBevkFo6zZP+M0=;
 b=Nd24Rp1aEKgSSyXxpCO+Q3fc7amQgKPgJ//O+7TOIoyFql3/M+TV2ncM6ZKLM2NgCz
 aYTmOOqNzDB0IgzEGJrBq/ukPSRKzavtcSyhioW1OxZbiIBavIhOzKhDpPAK1MrV9OvP
 T255gCzerS/m/41I8BjAoFqOrc0QaouofCZ2F7umjwrd0zL6p9Ox3gdyNKbYU0VzZNZt
 xU6SSeGw4nank4L51kEIX86O8oU9IqcDI3GfcP1JEhRI5F/7DaqTMaznxr9+XrubibsP
 +rG1DVgtD1oK4y8SDICgtJVpuf/29mpqdR1UrUpwnzSHH1aOwJC/wWtSN1RzRxn+8dki
 fqSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6yVFEQ4sr7mf6bn6ThRT+JWyNHsKhkQWqXYPMg8y96WzZxp7dxhUVTn+BcsHIIJNKOt1T+xwB8u3p@nongnu.org
X-Gm-Message-State: AOJu0YzKBeLQ3xxWXvI5j7e8Q/oBaQFu5sx06Dar8A77+3kHSjT8hhpt
 gkpfFqctcYev8w2SWjIZU9btgYvXfXsPAEYfqwrq0UeZuAn743A7/Hy0A2kA+dzMqrsX8qEMg6d
 XX0OsNM+zH+IkSxoeewOIHT/e2DagD90bSYXi0TG85fN3BFjJazAEjQYlQkKMz1CO
X-Gm-Gg: ASbGncsNCsAP58IK93PZjlwdSihn71QksDu2uxBZEUbrdq34XaslED7nVWE3OsGxWl6
 Sy9wi9KJ9nb+hnr/p6MoN4YWG2AnK4YE6Ufx91PqlRfgIzXNZ3UEibKkhqBlEx/zcQD9vlNCBir
 QtySVpjssKdsXrZpKzphB/16tmqGSb27TVzv0s+hFLuZCNGQ1Eh7dbk1/vyCsrw8f7kz+x/W/Wk
 B9nq5Pq7RetB/KhwFqMnq0FmlCFU6cU7xqyIIoG3fDCgHqUS5Lr6BNhgQKDYnxzpRTjZVDPK+xh
 9cQuqCRVGAjL/5E1CYvNAxZHa7u0W59ZzmRKSg==
X-Received: by 2002:a05:6214:484:b0:81b:23d:55a8 with SMTP id
 6a1803df08f44-879dc87ee1amr42708646d6.59.1759506001702; 
 Fri, 03 Oct 2025 08:40:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY07Hgid9eWizq610OleJ8bKKinbJlufwNYIT077mYrNjAFCNUpFpj2WKRkPGslekRcPok0w==
X-Received: by 2002:a05:6214:484:b0:81b:23d:55a8 with SMTP id
 6a1803df08f44-879dc87ee1amr42707876d6.59.1759506001203; 
 Fri, 03 Oct 2025 08:40:01 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 06/45] migration: push Error **errp into
 loadvm_handle_cmd_packaged()
Date: Fri,  3 Oct 2025 11:39:09 -0400
Message-ID: <20251003153948.1304776-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_handle_cmd_packaged() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-6-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d1ed2e1cde..5e54651652 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2405,7 +2405,7 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  * Returns: Negative values on error
  *
  */
-static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
+static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
 {
     int ret;
     size_t length;
@@ -2415,7 +2415,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     trace_loadvm_handle_cmd_packaged(length);
 
     if (length > MAX_VM_CMD_PACKAGED_SIZE) {
-        error_report("Unreasonably large packaged state: %zu", length);
+        error_setg(errp, "Unreasonably large packaged state: %zu", length);
         return -1;
     }
 
@@ -2426,8 +2426,8 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
                           length);
     if (ret != length) {
         object_unref(OBJECT(bioc));
-        error_report("CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
-                     ret, length);
+        error_setg(errp, "CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
+                   ret, length);
         return (ret < 0) ? ret : -EAGAIN;
     }
     bioc->usage += length;
@@ -2457,6 +2457,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     } while (1);
 
     ret = qemu_loadvm_state_main(packf, mis);
+    if (ret < 0) {
+        error_setg(errp, "VM state load failed: %d", ret);
+    }
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
@@ -2620,11 +2623,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         break;
 
     case MIG_CMD_PACKAGED:
-        ret = loadvm_handle_cmd_packaged(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
         ret = loadvm_postcopy_handle_advise(mis, len);
-- 
2.50.1


