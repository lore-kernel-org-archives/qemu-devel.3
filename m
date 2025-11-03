Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A75CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1ly-00016V-Q5; Mon, 03 Nov 2025 16:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lv-00014u-4l
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lf-0005QS-DH
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=anCfRgq4fY1GZ9xyeHtt3Q7FEvb9Q1pOwKBw9dmSJoQ=;
 b=MPQfdc5eU7ImXNF0JPLREA6xx65OnHVfPVZ+bQM4RdKRbkB5Akuch45WxqxIHlnMT1IdMa
 U5rzwIqLzyJ0IgTFzyY3QVKiloPJzmrdIsAzV85g9allbumTMnUwThH6Ir3ZYFCkwhQ7cH
 ulMzmp5XEAIUW48AaUGgAgnqvRQRnBg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-KyOofikrPdqjqplr-xkWkg-1; Mon, 03 Nov 2025 16:07:08 -0500
X-MC-Unique: KyOofikrPdqjqplr-xkWkg-1
X-Mimecast-MFC-AGG-ID: KyOofikrPdqjqplr-xkWkg_1762204028
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4eb7853480dso142643341cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204028; x=1762808828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anCfRgq4fY1GZ9xyeHtt3Q7FEvb9Q1pOwKBw9dmSJoQ=;
 b=R4fCqfjgWqO23x/XqV6esuJFZDnNXiNo6U5BMl45tGBEE0eq/bNwoBvSEl+qiLZ3WD
 m3AMiSgx8BnPcY4hJ9G6mylsaSJWzmXrF/CIA5B5BBh0vH1g+9ASYWqdz3S7mlRfsTEi
 /aqpCnhNlnLRTJMPtjALMYN+n+E9Oh+dGMdKokbXcPIyAkAl9YaI+el+LiN/jvavKaPn
 xdJEd2YEyS7BIKvpHKjxcdmUCQ8rYXJMkht2uAz45oHQ1OxJDmt0w/Vdl3jw+HWZq3FJ
 HeH+ecbVusu2Ut8/ySBkMepPiTRzuRxCMSaC3LGbG4QcXAaFzZ6V/IC4nmZNZEzFXr8m
 bBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204028; x=1762808828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anCfRgq4fY1GZ9xyeHtt3Q7FEvb9Q1pOwKBw9dmSJoQ=;
 b=fBDXD1Am95YciFXQcS8mrG7MSs8kCxLOyM+aAss8wl+sWUmGYIRlh3NLDPDLTaVGnu
 FqGUwmQHBBvsFpX4uKSfahfwJn8d5LoGSCqAJjeIH7dWNHNG/dbHY6jdqw/sjnOOjkOz
 FjcuYeXrS6tz76QdMMGlH8dGTNDAqlJ83ZsB0U3VA+XsO7c8pQJHaFDEf9w0V/e5ZoD9
 GB9cQ/SusdYOei2nKMWW7aKO2yCxRnVdgwzHtw98JcgXnZuiMgwvMaEbuX/hKUeM9pq+
 HV9dQnuOn/K1de4neETQi81q1qdQxy/KIvZKPaFPFk7MG+v072q0ixMsKCraHp6UGZbL
 SkGg==
X-Gm-Message-State: AOJu0YyOwRSYkEgQ1lIT3o1HLyvLJhkE/6TnPERe+wf3Si2BU1/MqFBX
 UpwyMkiix7eRQc0Fvj8UMQzK1uMBPNaejcSPjIFR2SVOO2/GHf5QOnWSFo8roAeqzScHBUmOiQU
 4CfVAbVdPCNjf2Wr+CTpC4S5E/wWdaJAMRAZpyBA916iAnwcDCmLEiZ9timxUNYT0zhg18LYyXB
 G58UIMTIdSPBty41vTYY8Tfk3DPxJ990j8xNqDag==
X-Gm-Gg: ASbGncvr61V1I6u4Noc+y0lzRA19V9iVF0lcyLJZkb104FQ8WE2g1gD0jEWAvQ2vjZ7
 dlnp0QpoDJDS72WuiPKqvUA4INd187s8Z3bK0G5F0fHGvkEWjkRTY5YrSKgRzn54zglDM53on9V
 YJO55d7cIhx8a5HA4FFafK/fktk13kmZRuWMxvkQ6ENp7GbWSiW1SGyb2yDLU2HHtgK+RnzXgoz
 DrkJRYsFkkqMzSu/fAnJz8BngUeY42jTooaoZsy9CQ9fA5dB0JY2+h+UGifU4qkOt2sR/NTCTlh
 eJ2Cv13o8dUuU1Ti1V/wAV12YuqAiIhWdFXZgq9e4Eu2z+v1DZcS9o239+L2mnWX
X-Received: by 2002:ac8:5941:0:b0:4b7:ad88:45f9 with SMTP id
 d75a77b69052e-4ed30d923eemr167865031cf.7.1762204026863; 
 Mon, 03 Nov 2025 13:07:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFajemzavcqGNoDyJ+0rIu5BmKOncZwEnivsMn39JpffSkjto2VPslZvjLeWD3SAWSsVKnrfw==
X-Received: by 2002:ac8:5941:0:b0:4b7:ad88:45f9 with SMTP id
 d75a77b69052e-4ed30d923eemr167863361cf.7.1762204025049; 
 Mon, 03 Nov 2025 13:07:05 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:07:04 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 26/36] migration: vmsd errp handlers: return bool
Date: Mon,  3 Nov 2025 16:06:15 -0500
Message-ID: <20251103210625.3689448-27-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

No code actually depend on specific errno values returned by
vmstate_load_state. The only use of it is to check for success,
and sometimes inject numeric error values into error messages
in migration code. The latter is not a stopper for gradual
conversion to "errp + bool return value" APIs.

Big analysis of vmstate_load_state() callers, showing that
specific errno values are not actually used, is done by Peter
here:

https://lore.kernel.org/qemu-devel/aQDdRn8t0B8oE3gf@x1.local/

Converting of vmstate_load_state() itself will follow in
another series.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Link: https://lore.kernel.org/r/20251028170926.77219-2-vsementsov@yandex-team.ru
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/main.rst |  6 +++---
 include/migration/vmstate.h   |  6 +++---
 backends/tpm/tpm_emulator.c   | 10 ++++------
 migration/vmstate.c           | 11 +++++------
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 1afe7b9689..234d280249 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -446,15 +446,15 @@ The functions to do that are inside a vmstate definition, and are called:
 
 Following are the errp variants of these functions.
 
-- ``int (*pre_load_errp)(void *opaque, Error **errp);``
+- ``bool (*pre_load_errp)(void *opaque, Error **errp);``
 
   This function is called before we load the state of one device.
 
-- ``int (*post_load_errp)(void *opaque, int version_id, Error **errp);``
+- ``bool (*post_load_errp)(void *opaque, int version_id, Error **errp);``
 
   This function is called after we load the state of one device.
 
-- ``int (*pre_save_errp)(void *opaque, Error **errp);``
+- ``bool (*pre_save_errp)(void *opaque, Error **errp);``
 
   This function is called before we save the state of one device.
 
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 09f1eefcfb..df57e6550a 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -218,11 +218,11 @@ struct VMStateDescription {
     int minimum_version_id;
     MigrationPriority priority;
     int (*pre_load)(void *opaque);
-    int (*pre_load_errp)(void *opaque, Error **errp);
+    bool (*pre_load_errp)(void *opaque, Error **errp);
     int (*post_load)(void *opaque, int version_id);
-    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
+    bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
     int (*pre_save)(void *opaque);
-    int (*pre_save_errp)(void *opaque, Error **errp);
+    bool (*pre_save_errp)(void *opaque, Error **errp);
     int (*post_save)(void *opaque);
     bool (*needed)(void *opaque);
     bool (*dev_unplug_pending)(void *opaque);
diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index da9c1056ed..f10b9074fb 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -962,24 +962,22 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
 
 /*
  * Load the TPM state blobs into the TPM.
- *
- * Returns negative errno codes in case of error.
  */
-static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
+static bool tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
 {
     TPMBackend *tb = opaque;
     int ret;
 
     ret = tpm_emulator_set_state_blobs(tb, errp);
     if (ret < 0) {
-        return ret;
+        return false;
     }
 
     if (tpm_emulator_startup_tpm_resume(tb, 0, true, errp) < 0) {
-        return -EIO;
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 static const VMStateDescription vmstate_tpm_emulator = {
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 677e56c84a..4d28364f7b 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -154,13 +154,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         return -EINVAL;
     }
     if (vmsd->pre_load_errp) {
-        ret = vmsd->pre_load_errp(opaque, errp);
-        if (ret < 0) {
+        if (!vmsd->pre_load_errp(opaque, errp)) {
             error_prepend(errp, "pre load hook failed for: '%s', "
                           "version_id: %d, minimum version_id: %d: ",
                           vmsd->name, vmsd->version_id,
                           vmsd->minimum_version_id);
-            return ret;
+            return -EINVAL;
         }
     } else if (vmsd->pre_load) {
         ret = vmsd->pre_load(opaque);
@@ -256,11 +255,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         return ret;
     }
     if (vmsd->post_load_errp) {
-        ret = vmsd->post_load_errp(opaque, version_id, errp);
-        if (ret < 0) {
+        if (!vmsd->post_load_errp(opaque, version_id, errp)) {
             error_prepend(errp, "post load hook failed for: %s, version_id: "
                           "%d, minimum_version: %d: ", vmsd->name,
                           vmsd->version_id, vmsd->minimum_version_id);
+            ret = -EINVAL;
         }
     } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
@@ -438,7 +437,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
     trace_vmstate_save_state_top(vmsd->name);
 
     if (vmsd->pre_save_errp) {
-        ret = vmsd->pre_save_errp(opaque, errp);
+        ret = vmsd->pre_save_errp(opaque, errp) ? 0 : -EINVAL;
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret < 0) {
             error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
-- 
2.50.1


