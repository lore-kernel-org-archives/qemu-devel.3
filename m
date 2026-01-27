Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B69D2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCL-0003Z5-VQ; Tue, 27 Jan 2026 13:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBW-0002rR-MZ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBV-0000gA-7M
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yzQGZtVwGYdVu30qlQ1Yo9nfbVeeR0WqE9qJFYJ/6e0=;
 b=E5sDNbJDA+t5PBnTwS401Dp/3aDbHZTleWikHts5Shh6/hr0TKaijNdSWFgiNBlaw7rtpt
 YmhWA8XI3vBVY7BcRz3emTTeXVL9cVHu9MrBm7AAk2T5D7n6PdL9GBBW32IC+xqYPC3fIq
 LiHTjIxmC2KwqddCPiJ0EmUSQ7GFStc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-jM2dCNtqPT6eveP4VRcawA-1; Tue, 27 Jan 2026 13:53:03 -0500
X-MC-Unique: jM2dCNtqPT6eveP4VRcawA-1
X-Mimecast-MFC-AGG-ID: jM2dCNtqPT6eveP4VRcawA_1769539983
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5014ca48a56so270178411cf.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539982; x=1770144782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzQGZtVwGYdVu30qlQ1Yo9nfbVeeR0WqE9qJFYJ/6e0=;
 b=e+6ZOrUAUcs1jMwD9qBNahPulOGP/gppR9t57O7+AGh4HjR0lTjaqWAvtoBBIbqbBg
 ozqZbn+9BJ5GuzSTfrDk/txxRiPT4iokQA4mQn7WfE3tlQAMn0p6NfwndKHvx72S6xZA
 AhDB0HS9/2LrCaIgyBVv8irpYQ6jb0dkMDZuQPiZhS4Xb9e+573DghPzEp22Adzf2pB1
 ZviLPEBok9VKCwb0lvQJ6+1zNvGyyR7nORwsx6yv7lmJGO0kzXS9sLH9AO74ECqg7eHh
 MQ0JeNo6wJOkNh9qZ+Tok0rZTI01njfiJW4nrFuHHo2tcQa+hwSYMjvEwJ0RR+HV7Vq2
 b37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539982; x=1770144782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yzQGZtVwGYdVu30qlQ1Yo9nfbVeeR0WqE9qJFYJ/6e0=;
 b=Pipy59+Pil/+qmgudDgMUcwj7IgOJlhV2HawFENImR3oAmrGVNf4CjKLheFW7vjLfm
 FG4i+zJyqYvlm+pDlOTC7yDjBV1iEM61uyNWlyBBMFPJSvPSLwshibxobJDwzIi6jvZi
 lEYWKbFUrjaNluQl89eqGIq/Zyxa3T8w21CaGcPyF3HshU1kHF+i0MbMN24kcj2cbCp3
 xDC/wfNmYM2GkvcXC5Z/yc3ZVcfiAzB6kV1wX6h6bURsKJW13WXCHywlWZ6IJTgU2CKa
 wtNzivzBItPq8PtCANY+DpSRkcfpw1NidH820lROFhZGc6hqr5JmrodOHf0F/JCZuevA
 w8TQ==
X-Gm-Message-State: AOJu0YwNFfdDSrgotLs3rsF5F8xx+ZNaD2qdDbZtHCvU4boRSWSz8R4G
 VR4kLdSyjA3E5I44+uV8lnN7V+ylgbVZy1ambgrgbYgvrMut9HRxiffPVN7O6Xr8j0r0W4i6EdR
 mVAthlISQ78ePjhQRRtI13xxdhJ8fs1a6S/lmjyRLU76pPoV42EpPHQA9JbduZc8XJ583muLrWq
 Ehm4D0IjcPG6aJAWvpPsNvYRUSJN6NDSOnzgixTw==
X-Gm-Gg: AZuq6aIIulxq4zj4UeWjsd9nGrKrIhvsR6VPNvhoNV6J/m3RjxevECWkUDJH64PT+Bk
 3qw3AdE+LEmRSjnkmGl5kIjuCdoy7jG55R8jyI5DFwfzQH7wKZ/VbN7WZ5DH6pw5Xs5/GGc3ROE
 jV0e6jdzzcjuZOGbCjPTNYcQfbbvnANX4L7Lfg9bR0ibTLQjRmNoklbb4O1BAlwQZF/flbwi42k
 73/HSvi0/V/nOhA7cqDVcMwrq7kH9jWUMRkxrU89WTKHLjlnqxpVxSGUSkSZ/piKaGfrq1HdUPc
 MSS9mUidcooj2MQNe7XMcInEMXFwsC2k9NfpB96rVG8KS1FdYQy5DMoWvuSQS2KWcm9IL/iD8EB
 P
X-Received: by 2002:ac8:5e11:0:b0:501:19f9:3267 with SMTP id
 d75a77b69052e-5032f74b085mr36555801cf.6.1769539982408; 
 Tue, 27 Jan 2026 10:53:02 -0800 (PST)
X-Received: by 2002:ac8:5e11:0:b0:501:19f9:3267 with SMTP id
 d75a77b69052e-5032f74b085mr36555351cf.6.1769539981698; 
 Tue, 27 Jan 2026 10:53:01 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:00 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 04/24] migration/savevm: Remove SaveStateEntry.is_ram
Date: Tue, 27 Jan 2026 13:52:34 -0500
Message-ID: <20260127185254.3954634-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It's neither accurate nor necessary.  Use a proper helper to detect if it's
an iterable savevm state entry instead.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 61e873d90c..f1cd8c913d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -249,7 +249,6 @@ typedef struct SaveStateEntry {
     const VMStateDescription *vmsd;
     void *opaque;
     CompatEntry *compat;
-    int is_ram;
 } SaveStateEntry;
 
 typedef struct SaveState {
@@ -816,10 +815,6 @@ int register_savevm_live(const char *idstr,
     se->ops = ops;
     se->opaque = opaque;
     se->vmsd = NULL;
-    /* if this is a live_savem then set is_ram */
-    if (ops->save_setup != NULL) {
-        se->is_ram = 1;
-    }
 
     pstrcat(se->idstr, sizeof(se->idstr), idstr);
 
@@ -1866,6 +1861,12 @@ void qemu_savevm_live_state(QEMUFile *f)
     qemu_put_byte(f, QEMU_VM_EOF);
 }
 
+/* Is a save state entry iterable (e.g. RAM)? */
+static bool qemu_savevm_se_iterable(SaveStateEntry *se)
+{
+    return se->ops && se->ops->save_setup;
+}
+
 int qemu_save_device_state(QEMUFile *f)
 {
     Error *local_err = NULL;
@@ -1876,7 +1877,7 @@ int qemu_save_device_state(QEMUFile *f)
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         int ret;
 
-        if (se->is_ram) {
+        if (qemu_savevm_se_iterable(se)) {
             continue;
         }
         ret = vmstate_save(f, se, NULL, &local_err);
@@ -2648,7 +2649,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
     se->load_section_id = section_id;
 
     /* Validate if it is a device's state */
-    if (xen_enabled() && se->is_ram) {
+    if (xen_enabled() && qemu_savevm_se_iterable(se)) {
         error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
         return -EINVAL;
     }
-- 
2.50.1


