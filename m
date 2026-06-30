Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAB8C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaEW-0006OE-Oy; Tue, 30 Jun 2026 11:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1weaEU-0006Nk-Vo
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1weaET-000148-98
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782832720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPm5t748LvbZi5wUvGdZcwUQBvE1+Ss5EozAkANqm9Q=;
 b=Vz7376rClsvaEScoj93jxuAm7ORrybYvhkAB7jIqghim8s5I+1M3OoduVEqzfHqWVQFVQM
 PSIuY8jQqDdXA+5cnS+E+EMSR7Tj3rfS3XoDL2bnumm0Onm+g3+E4Su3RrXlPUtyFbYi/n
 yZtPO9pijMca0uHa5sk0EQt4Xo3WdDU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-5BAaCyV2NA63ktx1mNmpJw-1; Tue, 30 Jun 2026 11:18:38 -0400
X-MC-Unique: 5BAaCyV2NA63ktx1mNmpJw-1
X-Mimecast-MFC-AGG-ID: 5BAaCyV2NA63ktx1mNmpJw_1782832718
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493ba771d1bso10454585e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782832717; x=1783437517; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PPm5t748LvbZi5wUvGdZcwUQBvE1+Ss5EozAkANqm9Q=;
 b=APrPshWHZtRrUOsj5GXIhYVrFvWYwJC8iwQ3lg4toAHQsrs90OD5OzLTeZfd8SAHid
 4Nb3asZJc8mnWSSosNN4g6184hrmXO9G5R+UVENCArvJ43w3WcGJOLGs6JZW1myfr34n
 1pRfhHE91L+MvIbpej2GZJRQfV+u8R8MvLIG723+AdAYQBcQaWC5xKs6ysAoEi4tCZyW
 sNSWRjx0qgzJT4CEykyd0/gaGrBBmD/1a9P7dqGzwS5mGqY4Uh8Te1n19auJX1zmHKVF
 qno3gKDBgDFJsBGxko4fY/Ckww+2P0BSCi5+nxQxKJ5O98HrM3YvKUSt7+lmmUtXXBWU
 Kb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782832717; x=1783437517;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PPm5t748LvbZi5wUvGdZcwUQBvE1+Ss5EozAkANqm9Q=;
 b=onU0GjlOzB/mv5MC19wBIbFMYT9slJKIycp4ahh8nU5hxL8RXcknmuD5KBWj+Qd26p
 NLqEip4+DCroLs7495aiOPKQb8qZ8gz/OuYP1P/+6Qg31872EW56rnN466EabqvwfrFq
 mDRnh3aNjdobqKkqyQntwZQAQNIXzBB0CxMGjbi4WniD9HRs8hkzkoWBokCB5yhqrLFs
 MFUwSbFdL7pWitwqWocSuTUyhCdkTxVVsy9L9CZBSMGZW+ReHSPNcr2B/klv5Fk+VulU
 H/SM9BBXOAZ8Yn2Hle26gg0zR3fMpjFQI9ULwgluxGocyjB6LgfLco8OPzEYVXFZl/4E
 tfnA==
X-Gm-Message-State: AOJu0YweOlvUpTIi/7wKDF6kOHsWw7XSlUYhfYbW2Hogi2+Blzsb4eO5
 K0e4YJInqpD4tA81BECLQHg9Spib4K1JB0P4TxbePYgw3v7HCMW2OQZhn6p3c4yrEprnt5IU1UF
 LsXFKDA7EFqBLTS2SW0t3Ba76a4wEP2b5YvQTGV1cGITCQojUOGd4+qcg
X-Gm-Gg: AfdE7ckaVkgi2wrScTyi63uTbp8cXoQrJQep0joT6xKj1xm6HxWqzGhfxJ9cMP4bQ7i
 XA5v0AffwxtMxlTBnrvc4bXUQjto7zK/fUMDq1VcFidJsuwFl+BvxwbfJVKgbQDkagtHq4ezp/F
 wnaSLdD4hm7OoFnurhIRkwyXUoWT1DCpPH6cpkaqIPjA5ef0CCzL3bDexSvEbNmmf3II2jBM/Dr
 kBVtinEl2cSpYW5nREHICWrwzs3sAP0eVzpqPUn+Rijbp6IzDoHvTUW8BTpkx+fTuX2tdByk2YG
 isXdTIvi1kIok/rYFsV6Y2JoI4aFs8Jvn0ZTJps/qKEQksWEY2yNtt6HfsxGTnefODVSdKH+X5q
 CPOb1B5vI5R7IIF2aBkm57wMLQoOS+EK4mdxuvcpnP3XT494ot/uAwJlsYNZn
X-Received: by 2002:a05:600c:4e14:b0:490:e913:656a with SMTP id
 5b1f17b1804b1-493b82b8db4mr62620425e9.27.1782832717502; 
 Tue, 30 Jun 2026 08:18:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4e14:b0:490:e913:656a with SMTP id
 5b1f17b1804b1-493b82b8db4mr62619855e9.27.1782832716985; 
 Tue, 30 Jun 2026 08:18:36 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it.
 [79.34.22.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4eee27sm1943945e9.12.2026.06.30.08.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:18:36 -0700 (PDT)
Date: Tue, 30 Jun 2026 17:18:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Oliver Steffen <osteffen@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 1/3] igvm: Report error on missing parameter area in
 directive handlers
Message-ID: <akPePr4_0RsvOR0f@sgarzare-redhat>
References: <20260626-microvm_device_tree-v6-0-9cd13cf057e2@redhat.com>
 <20260626-microvm_device_tree-v6-1-9cd13cf057e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626-microvm_device_tree-v6-1-9cd13cf057e2@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 26, 2026 at 12:04:01PM +0200, Luigi Leonardi wrote:
>Parameter areas are how an IGVM file tells QEMU to allocate buffers
>for runtime information the guest needs — VP count, memory map,
>MADT and so on. Usage directives reference a parameter area by index
>to tell QEMU where to write each piece of data. If the index doesn't
>match any declared parameter area, the data has nowhere to go and
>should be treated as an error.
>
>The directive handlers that look up a parameter area all return 0
>(success) when `qigvm_find_param_entry()` can't find it. Therefore,
>the load succeeds but the guest never gets the expected parameters.
>
>Note that the IGVM library already validates parameter area indices
>when the file is loaded, so this path should only be reachable with
>a malformed file that bypassed library validation. This is defensive
>programming against that case.
>
>Report the error with error_setg() and return -1 instead.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c                | 26 ++++++++++++++++----------
> include/system/igvm-internal.h |  3 ++-
> target/i386/igvm.c             |  5 +++--
> 3 files changed, 21 insertions(+), 13 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 3f4b97a5d4..a5a2a4eccc 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -81,7 +81,8 @@ struct QEMU_PACKED sev_id_authentication {
> #define IGVM_SEV_ID_BLOCK_VERSION 1
>
> QIgvmParameterData*
>-qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
>+qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
>+                       Error **errp)
> {
>     QIgvmParameterData *param_entry;
>     QTAILQ_FOREACH(param_entry, &igvm->parameter_data, next)
>@@ -90,7 +91,8 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
>             return param_entry;
>         }
>     }
>-    warn_report("IGVM: No parameter area for index %u", parameter_area_index);
>+    error_setg(errp, "IGVM: parameter area index %u not found",
>+                   parameter_area_index);
>     return NULL;
> }
>
>@@ -528,9 +530,10 @@ static int qigvm_directive_parameter_insert(QIgvm *ctx,
>         return 0;
>     }
>
>-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
>+    param_entry = qigvm_find_param_entry(ctx,
>+                                         param->parameter_area_index, errp);
>     if (param_entry == NULL) {
>-        return 0;
>+        return -1;
>     }
>
>     region = qigvm_prepare_memory(ctx, param->gpa, param_entry->size,
>@@ -601,9 +604,10 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>     }
>
>     /* Find the parameter area that should hold the memory map */
>-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
>+    param_entry = qigvm_find_param_entry(ctx,
>+                                         param->parameter_area_index, errp);
>     if (param_entry == NULL) {
>-        return 0;
>+        return -1;
>     }
>
>     max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>@@ -660,9 +664,10 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
>     uint32_t *vp_count;
>     CPUState *cpu;
>
>-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
>+    param_entry = qigvm_find_param_entry(ctx,
>+                                         param->parameter_area_index, errp);
>     if (param_entry == NULL) {
>-        return 0;
>+        return -1;
>     }
>
>     vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
>@@ -683,9 +688,10 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
>     QIgvmParameterData *param_entry;
>     IgvmEnvironmentInfo *environmental_state;
>
>-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
>+    param_entry = qigvm_find_param_entry(ctx,
>+                                         param->parameter_area_index, errp);
>     if (param_entry == NULL) {
>-        return 0;
>+        return -1;
>     }
>
>     environmental_state =
>diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
>index 7f131c4d03..7eb3792ed8 100644
>--- a/include/system/igvm-internal.h
>+++ b/include/system/igvm-internal.h
>@@ -72,6 +72,7 @@ struct QIgvm {
> IgvmHandle qigvm_file_init(char *filename, Error **errp);
>
> QIgvmParameterData*
>-qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index);
>+qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
>+                       Error **errp);
>
> #endif
>diff --git a/target/i386/igvm.c b/target/i386/igvm.c
>index f41b498b89..ad9bf87761 100644
>--- a/target/i386/igvm.c
>+++ b/target/i386/igvm.c
>@@ -191,9 +191,10 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
>     int result = 0;
>
>     /* Find the parameter area that should hold the MADT data */
>-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
>+    param_entry = qigvm_find_param_entry(ctx,
>+                                         param->parameter_area_index, errp);
>     if (param_entry == NULL) {
>-        return 0;
>+        return -1;
>     }
>
>     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
>
>-- 
>2.54.0
>


