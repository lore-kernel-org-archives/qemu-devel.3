Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243C4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huT-0005A7-Bd; Fri, 03 Oct 2025 11:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htv-0004qY-7k
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htU-0007eh-Bn
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkZzARbYR1wt175RfkITZtQyNWUqBNWlPMQzaCStB48=;
 b=aoJzZ05HnY1K0wj+sMHwyN81fSv08XMims3qhyr6GtDjE5u4nMozCbwHNc0PBkk+WSlks+
 egL46Y3FBKwUqEUBWkKuyyOxQ1rVAeegvG5oxLI8JPdz72pAm4azPLtONlMTXP3MZnfj/a
 YjD+8mBH1t8sKWJmTeYZ9AmspIkmouw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-vKNG9w19M9qbFcfdDoCnmQ-1; Fri, 03 Oct 2025 11:40:21 -0400
X-MC-Unique: vKNG9w19M9qbFcfdDoCnmQ-1
X-Mimecast-MFC-AGG-ID: vKNG9w19M9qbFcfdDoCnmQ_1759506020
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-78ea15d3583so48501896d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506020; x=1760110820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkZzARbYR1wt175RfkITZtQyNWUqBNWlPMQzaCStB48=;
 b=hg9ZNYcRpdEBGdkj56mIkPUTEgGXfdJkvcNrmOtYAh3E9yZPrOr8Tbn85+nUsXFPIO
 b5G9moZKYHWHxiBfw/PiUOs+E6d1UQs9sZkoasrZKJ1KU9063Sp/mMqS9Kl5gvvNN/dv
 SF8Vny3L9CeQfJjO2eQ2rQL03QsYkqVNo4xQjj/YAsL61mlZWt0++UZjP0rzVJXXphD5
 quTb+y6yT/X8V52/+xsRtRo9srM2a7zlBVVVby2R317ge0bLM8gfc03/9pJ645TgwLHP
 97WM7rgP7imtav1fI8mgUArBK8JhMGv//jbZYRbpjqnW1c/6mcYg+I5W8BgPNuLGkkUh
 EPew==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6QVsn1pzQ/x716MBA4Am07KU4Cg1cQxtK4mZZa4mL7h4BGhamBvOx6gINRHmXRH1hiG3pawy5FNS0@nongnu.org
X-Gm-Message-State: AOJu0YzKzSTu6Y+sg4+kB60/kSos3aJH34KC0Jnx2zdKJl85XTfYfAxx
 9tCkOsL4a2nMIcooa7QehYYM1UoIzMf4aA8tD7qWEJuXft/D2VvaEA7Fmt4nphCD558JvwpW8rN
 tlC/Uz29SAzbBo5AVVN47ag+2VR4FBTqyK/lb4wxoY8R3y/7Qoo6RGAthn7y2zLVj
X-Gm-Gg: ASbGncsOxmFh5+GFKGkYlZgzLqNAWg1p+DSWtR7MdVxDytTCTjVo15wq9/KL7Mba9jT
 pP83bXwj/1bmaakByyFMe+dkIFk+7OmhfjzJ2sA224VUUfZj0lxq2p5CGKF1PY2CQiv0bkhlm/D
 91xdGsRFIKgkDABdjKFtxXdAQX9yBipCvGektWZaWF75yh5PM3CRV/15EOPSyKCt/sTkqF3qHiG
 Musr4bX1YnmpKyTFhuN6zfUZ0yLhlDkpzJdAyMyk1PALh8cuIxheppF7Dbflo6VWVl18HJBf88B
 1s2SguolI+ZQP4ky1Qy/SuI2ZXUcRoaMokX22Q==
X-Received: by 2002:a05:6214:19e1:b0:787:5934:697 with SMTP id
 6a1803df08f44-879dc7a4596mr43670116d6.8.1759506019705; 
 Fri, 03 Oct 2025 08:40:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXXJ0MLnVW+ea/nx6BUKSsgCc2vGo+FSye6jq4avxR1BW4FXIeHRSmGJp7GXWbS4DzE7Gxew==
X-Received: by 2002:a05:6214:19e1:b0:787:5934:697 with SMTP id
 6a1803df08f44-879dc7a4596mr43669696d6.8.1759506019196; 
 Fri, 03 Oct 2025 08:40:19 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:18 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 18/45] migration: push Error **errp into
 loadvm_postcopy_ram_handle_discard()
Date: Fri,  3 Oct 2025 11:39:21 -0400
Message-ID: <20251003153948.1304776-19-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
It is ensured that loadvm_postcopy_ram_handle_discard() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-18-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index f7947160fd..b80da04b47 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2004,7 +2004,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
  * There can be 0..many of these messages, each encoding multiple pages.
  */
 static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
-                                              uint16_t len)
+                                              uint16_t len, Error **errp)
 {
     int tmp;
     char ramid[256];
@@ -2017,6 +2017,7 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         /* 1st discard */
         tmp = postcopy_ram_prepare_discard(mis);
         if (tmp) {
+            error_setg(errp, "Failed to prepare for RAM discard: %d", tmp);
             return tmp;
         }
         break;
@@ -2026,8 +2027,9 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         break;
 
     default:
-        error_report("CMD_POSTCOPY_RAM_DISCARD in wrong postcopy state (%d)",
-                     ps);
+        error_setg(errp,
+                   "CMD_POSTCOPY_RAM_DISCARD in wrong postcopy state (%d)",
+                   ps);
         return -1;
     }
     /* We're expecting a
@@ -2036,29 +2038,30 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
      *    then at least 1 16 byte chunk
     */
     if (len < (1 + 1 + 1 + 1 + 2 * 8)) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
         return -1;
     }
 
     tmp = qemu_get_byte(mis->from_src_file);
     if (tmp != postcopy_ram_discard_version) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD invalid version (%d)", tmp);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid version (%d)", tmp);
         return -1;
     }
 
     if (!qemu_get_counted_string(mis->from_src_file, ramid)) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD Failed to read RAMBlock ID");
+        error_setg(errp,
+                   "CMD_POSTCOPY_RAM_DISCARD Failed to read RAMBlock ID");
         return -1;
     }
     tmp = qemu_get_byte(mis->from_src_file);
     if (tmp != 0) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD missing nil (%d)", tmp);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD missing nil (%d)", tmp);
         return -1;
     }
 
     len -= 3 + strlen(ramid);
     if (len % 16) {
-        error_report("CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
+        error_setg(errp, "CMD_POSTCOPY_RAM_DISCARD invalid length (%d)", len);
         return -1;
     }
     trace_loadvm_postcopy_ram_handle_discard_header(ramid, len);
@@ -2070,6 +2073,7 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
         len -= 16;
         int ret = ram_discard_range(ramid, start_addr, block_length);
         if (ret) {
+            error_setg(errp, "Failed to discard RAM range %s: %d", ramid, ret);
             return ret;
         }
     }
@@ -2629,11 +2633,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_run(mis, errp);
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
-        ret = loadvm_postcopy_ram_handle_discard(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_ram_handle_discard(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_RESUME:
         loadvm_postcopy_handle_resume(mis);
-- 
2.50.1


