Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4B4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4htE-0004at-Qy; Fri, 03 Oct 2025 11:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htB-0004Yo-V0
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4ht4-0007Km-Jm
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759505995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaB8nDsp3Vv7lzPPF047N8zn8RD49+j3Amedp/WbNjQ=;
 b=SPtl3vzttjp0qL2tl8MAXZYzaTy8M24ynDJ2BOPvbGo8aJiLP4fkhG8IbE3hgayjQujODv
 OewQXohUcqk4sesSzRKe0rQ+RIV/r+NSvxbGH8FlLqQqbmct3h7qfOjL8A2zmcNnXpDZz+
 Soy7tn7hAvJszIG9U0+2UaZpULLhxi4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-fDgtApjPNuOUKvqtc3N3pg-1; Fri, 03 Oct 2025 11:39:54 -0400
X-MC-Unique: fDgtApjPNuOUKvqtc3N3pg-1
X-Mimecast-MFC-AGG-ID: fDgtApjPNuOUKvqtc3N3pg_1759505994
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-78ea15d3548so25815456d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759505994; x=1760110794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XaB8nDsp3Vv7lzPPF047N8zn8RD49+j3Amedp/WbNjQ=;
 b=IOCCaOw1IQRA6b/KtP1cA87I46aioGf8Oe1X6WXXDnuf77aLx36yCX0TaR++Jsb3iz
 73W/WT/1l5LJqs9bKpxxH2liz0oN6U18LKqdlsdOW3g6s8Hxrft0AZxT/lL3QJ3lwgAg
 +yb+1SqO0/WECUH89pZ0G6atMl3noUqXh4t3844MBs8iCWMaOiEq9Bw/wytizhYR+QYP
 Oindy/yAKw8rsirkIs4rGNWDFBtLsnIbvMorQYpaGaaLeyr2LlFZWOjTkCjHBtVku26S
 y47Flid4iTPp/PJrm4SEHZg9F4tSg3gizwYvH12QaB0bb+R37VdvjBb/BsVbBirrp3Gp
 6AuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIy2HRfLYq2ALrQNU22XuCjlmtEDEtyaLdo7ZSDBeqsm1859h7H037YntoXb5+ENIgEJGqhvMRcBVK@nongnu.org
X-Gm-Message-State: AOJu0YzkuAWjRW9Dyb3+ySndWTUOuIEFsU7ByrMhN1M07n+PNUP/xk6A
 D8GOw98JXAVvrZQ174aESjtrgnnOZ0UL2KMyR1DGeORdP6qH37HaxZAbKfunGghABgTKN7phHHX
 wk4GS/JVr9oL3zHJftmcMV+/aVdjIcW9bgDYp+ZpDMZkM3rLkwiOnfE10l2efsCei
X-Gm-Gg: ASbGnctbteUZfhZoKAINSfcIts4zjpjEyjuafcr/Jxs0aHA87y4KDALo0ZNARH7gfbG
 LVQD9GdZMmkfAvX469psTeVWecL1J7CKNrLkqwASHOTgBx5uD82lnkcDWtPjTUgYthns2L5Cb3l
 8bksuhHISyph6cHpCw+fYMVOKXHJGzHYeSeUTO7WVFkalcpj1Ed2NT8+rSh9y+9as0wmiC6qZrb
 uisYiPK7umafSwPuOOQCqXqVYTvQolCOiy3rohtvbSjQWmeftzVwEVLZDmVyPyDUqqatA1qg25m
 zfEEVM5RVNTAR7cx7UQ5PjvLa5tu6c4rpXJATQ==
X-Received: by 2002:a05:6214:202c:b0:86c:7f02:ac62 with SMTP id
 6a1803df08f44-879dc88761fmr54436396d6.54.1759505993572; 
 Fri, 03 Oct 2025 08:39:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIrM7K6wpvi841zGWv2lJffMD9UGG5gL/Px09yrnjeI6X+Dsulh/3dEc5QObo5DdaxKPNUWw==
X-Received: by 2002:a05:6214:202c:b0:86c:7f02:ac62 with SMTP id
 6a1803df08f44-879dc88761fmr54435836d6.54.1759505993028; 
 Fri, 03 Oct 2025 08:39:53 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:39:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 01/45] migration: push Error **errp into
 vmstate_subsection_load()
Date: Fri,  3 Oct 2025 11:39:04 -0400
Message-ID: <20251003153948.1304776-2-peterx@redhat.com>
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that vmstate_subsection_load() must report an error
in errp, in case of failure.

The errors are temporarily reported using error_report_err().
This is removed in the subsequent patches in this series,
when we are actually able to propagate the error to the calling
function using errp.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-1-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 5feaa3244d..08f2b562e3 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, JSONWriter *vmdesc,
                                    Error **errp);
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque);
+                                   void *opaque, Error **errp);
 
 /* Whether this field should exist for either save or load the VM? */
 static bool
@@ -136,6 +136,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 {
     const VMStateField *field = vmsd->fields;
     int ret = 0;
+    Error *local_err = NULL;
 
     trace_vmstate_load_state(vmsd->name, version_id);
     if (version_id > vmsd->version_id) {
@@ -225,9 +226,10 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         field++;
     }
     assert(field->flags == VMS_END);
-    ret = vmstate_subsection_load(f, vmsd, opaque);
+    ret = vmstate_subsection_load(f, vmsd, opaque, &local_err);
     if (ret != 0) {
         qemu_file_set_error(f, ret);
+        error_report_err(local_err);
         return ret;
     }
     if (vmsd->post_load) {
@@ -566,7 +568,7 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
 }
 
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque)
+                                   void *opaque, Error **errp)
 {
     trace_vmstate_subsection_load(vmsd->name);
 
@@ -598,6 +600,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
+            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
+                       idstr, vmsd->name);
             return -ENOENT;
         }
         qemu_file_skip(f, 1); /* subsection */
@@ -608,6 +612,9 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
         if (ret) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
+            error_setg(errp,
+                       "Loading VM subsection '%s' in '%s' failed: %d",
+                       idstr, vmsd->name, ret);
             return ret;
         }
     }
-- 
2.50.1


