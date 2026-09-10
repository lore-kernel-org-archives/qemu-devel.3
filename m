Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E01C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4bC5-0007xM-C5; Thu, 10 Sep 2026 05:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x4bC3-0007x4-QH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 05:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x4bC1-0007Vq-Ad
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 05:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789032939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WX8zjQhoellC02REAikwQGwN2XVGhconckvs5aFntbo=;
 b=dxgtuzVUyCU7zsqjKF0b9nr5Knl1cmXzd6NGGhAYNcFGyfT+ROZPO/kBioy4/Jy5U7+nEd
 8IolmxXnR8c6N1ZqrvrvqOxJhJSxzLFnSAR2aHjcVJhc6IllBQ1s7+VFubQykeUia811kj
 RdNDiOon1AKCsuPoFdH5uumytbV6T5Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-TbNAebqaOyiDpmuTFeC4tw-1; Thu, 10 Sep 2026 05:35:37 -0400
X-MC-Unique: TbNAebqaOyiDpmuTFeC4tw-1
X-Mimecast-MFC-AGG-ID: TbNAebqaOyiDpmuTFeC4tw_1789032937
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48597bbd963so4795223f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789032936; x=1789637736; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WX8zjQhoellC02REAikwQGwN2XVGhconckvs5aFntbo=;
 b=kPOwRl7xP2AhGYtGoI0OtsoFjixkN3ccyrD9DwUoV72B2vEQUGjGz/DAHBjVWqCR67
 8U9FomNDDNurd1pYVb0sO490HSQUeebi8cfHGmqrxY6MrSsUmC/Vyc10NVJsGfVujltl
 3CLYk7Y+ru1N2Mw/cxwc8hsXvoygGhB/Z8npW47TNN8mZTQOsLoM0oXxYgGJ4npgHJEq
 euTd372XUVxLDnDtcxqDtJsfFoudGH2jSqZbdm7NxloaJMllqDfMEpJCRtVJYprf6ZjD
 H9WvAHGmVKZQH9WrtQPjwyeOMuKR1j8hghpZuHGbUR8i4ulTO6HTDLcTdQ/Ec9g4jYSR
 ld8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789032936; x=1789637736;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WX8zjQhoellC02REAikwQGwN2XVGhconckvs5aFntbo=;
 b=iYPuDkjuMMAatJzM9meGWruoAlw+9AyNkQUC1V855q5JypKw8Swo++JDffY3sfxg+a
 oOXydTUHeg5hZ896PR1cjynaULnupo7yjnqNOL8HhXpX5ptR1YVG4Eqcgth/1WOE/HB5
 i5lmXgVRJ/0Ju6P9kBCcJnmYGnI3j8chg60U+s/JhEyya+nOTUaLzUe2XzTRuQ/cC7rg
 w8Nq/uNu6BQgWipBnXvwVksHf/HRVrGGU55jvVG8H/fkzCj25yfmrSZIKOFo1M+fU07o
 IZrBI26pzG891MfRo63NMERRz6k/ZSTHU8fAH8ItQPCa39doCi9hZbP+vwcHok252wqs
 JvCw==
X-Gm-Message-State: AFuF++kUD3RrgTN+JqifITKo2Y6KA+mWJ9b0foWhEWhive4MM5MlgCMh
 5zuwT8EuRkIddIUaZx7Y6oVTFi04ASxJPZiWbLYM72i/31OviKGu2W7TrjT5UUeSyGd5SfgdfDI
 Nt3ZiG0HB1QYzUeKwbsHu33cENNpKikoHLL09yCOkzdPXj7PVmCyruFTB
X-Gm-Gg: AYBFou2zbTi5UhkJ4Yt9hNYlA6iaz4RtWCV3mop4gUxfVl12FwuI59tM8E2DBjMFu1m
 vQWjJX5PMTdMj5ypKPooZp0KuSjXfOlZFngNek1z12LobmhyqtdQKJxK2R7r1sWrYcTcUaCf5FP
 wPDEqiE+qMWcEnl1YrWQ9ZteyC/Y9fn7OqTyE/l2JoIDipggjS+rg0yS4zYz6jHo27irM9OkZY/
 mc5pKnUi8kb+FqfEngK9tjWSpKlah61OTNHDKLgumB1Zj8tNeMBFFDzZY/wR/GeJCg4RQnwdpfE
 pXWjVVU4ToxUV7zyTQsh2yxtv0ixzD/2fkjfEzAKwtSGrhjs71uzRQtj72pchTFk/Hh8jFrUxAG
 q2uHRmZEncBCg1VGPfttpsQa7XTyPSd6Bvw9nEXTCw99yzw==
X-Received: by 2002:a05:6000:2dc5:b0:485:afd8:3e42 with SMTP id
 ffacd0b85a97d-485c23ec07cmr12977188f8f.22.1789032936484; 
 Thu, 10 Sep 2026 02:35:36 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc5:b0:485:afd8:3e42 with SMTP id
 ffacd0b85a97d-485c23ec07cmr12977083f8f.22.1789032935977; 
 Thu, 10 Sep 2026 02:35:35 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885b7bfasm50112572f8f.29.2026.09.10.02.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 02:35:35 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:35:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v3 1/2] igvm: validate byte_offset before using it in
 parameter directives
Message-ID: <aqJ3PFF1a8yexOAz@sgarzare-redhat>
References: <20260907-fix_offset-v3-0-bcffcefc0985@redhat.com>
 <20260907-fix_offset-v3-1-bcffcefc0985@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260907-fix_offset-v3-1-bcffcefc0985@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 07, 2026 at 04:58:55PM +0200, Luigi Leonardi wrote:
>None of the directive handlers that place data at a byte_offset within
>a parameter area validated that byte_offset actually falls within the
>parameter area's size. A malformed IGVM file with byte_offset > size would
>underflow the "size - byte_offset" computation used to determine
>remaining space, wrapping to a huge value and defeating the size
>check, then write out of bounds through param_entry->data +
>byte_offset.
>
>Add qigvm_get_param_data(), which looks up the parameter area,
>checks byte_offset against its size, and returns the offset-adjusted
>data pointer directly (NULL on failure), with the remaining space
>returned via an output parameter, instead of the raw
>QIgvmParameterData entry. This keeps the byte_offset arithmetic in
>one place instead of repeating param_entry->data + byte_offset and
>param_entry->size - byte_offset at every call site.
>
>Use it in the vp-count and environment-info handlers, adding an
>explicit check that the fixed-size write fits in the remaining space.
>

Should we add a Fixes tag?

>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c                | 70 +++++++++++++++++++++++++++++++++++-------
> include/system/igvm-internal.h |  6 ++++
> 2 files changed, 65 insertions(+), 11 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 7b7bdc72b7..a8340d7d55 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -101,6 +101,39 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
>     return NULL;
> }
>
>+/*
>+ * Look up a parameter area and check that param->byte_offset falls within
>+ * it, in one step. On success, returns the offset-adjusted write location
>+ * within the parameter area and sets *param_size to the remaining space
>+ * there, so callers never need to touch param->byte_offset themselves.
>+ * Returns NULL on failure.
>+ */

How about something a little more concise and straight to the point?

/*
  * Get parameter area data at byte_offset with bounds validation.
  * On success, returns offset-adjusted data pointer and sets param_size
  * to remaining space.
  * Returns NULL on failure.
  */

>+uint8_t *
>+qigvm_get_param_data(QIgvm *igvm, uint32_t parameter_area_index,

IIUC all callers are just passing param->parameter_area_index, since we 
have `param`, can we avoid passsing `parameter_area_index` as parameter?

>+                     const IGVM_VHS_PARAMETER *param,
>+                     uint32_t *param_size,
>+                     Error **errp)
>+{
>+    QIgvmParameterData *param_entry;
>+
>+    assert(param_size);
>+
>+    param_entry = qigvm_find_param_entry(igvm, parameter_area_index, errp);
>+    if (!param_entry) {
>+        return NULL;
>+    }
>+
>+    if (param->byte_offset > param_entry->size) {
>+        error_setg(errp,
>+                   "IGVM: byte_offset 0x%x exceeds parameter area size 0x%x",
>+                   param->byte_offset, param_entry->size);
>+        return NULL;
>+    }
>+
>+    *param_size = param_entry->size - param->byte_offset;
>+    return param_entry->data + param->byte_offset;
>+}
>+
> static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
>                                      Error **errp);
> static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
>@@ -682,17 +715,25 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
>                                     Error **errp)
> {
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>-    QIgvmParameterData *param_entry;
>+    uint8_t *param_data;
>+    uint32_t param_size;
>     uint32_t *vp_count;
>     CPUState *cpu;
>
>-    param_entry = qigvm_find_param_entry(ctx,
>-                                         param->parameter_area_index, errp);
>-    if (param_entry == NULL) {
>+    param_data = qigvm_get_param_data(ctx, param->parameter_area_index,

Can we avoid `param_data` at all and assing it directly to `vp_count` ?

>+                                       param, &param_size, errp);
>+    if (!param_data) {
>         return -1;
>     }
>
>-    vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
>+    if (sizeof(*vp_count) > param_size) {
>+        error_setg(errp,
>+                   "IGVM: vp-count parameter exceeds parameter area "
>+                   "defined in IGVM file");
>+        return -1;
>+    }
>+
>+    vp_count = (uint32_t *)param_data;
>     *vp_count = 0;
>     CPU_FOREACH(cpu)
>     {
>@@ -707,17 +748,24 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
>                                             Error **errp)
> {
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>-    QIgvmParameterData *param_entry;
>+    uint8_t *param_data;
>+    uint32_t param_size;
>     IgvmEnvironmentInfo *environmental_state;
>
>-    param_entry = qigvm_find_param_entry(ctx,
>-                                         param->parameter_area_index, errp);
>-    if (param_entry == NULL) {
>+    param_data = qigvm_get_param_data(ctx, param->parameter_area_index,
>+                                       param, &param_size, errp);

Ditto.

>+    if (!param_data) {
>+        return -1;
>+    }
>+
>+    if (sizeof(*environmental_state) > param_size) {
>+        error_setg(errp,
>+                   "IGVM: environment-info parameter exceeds parameter area "
>+                   "defined in IGVM file");
>         return -1;
>     }
>
>-    environmental_state =
>-        (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
>+    environmental_state = (IgvmEnvironmentInfo *)param_data;
>     environmental_state->memory_is_shared = 1;
>
>     return 0;
>diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
>index 9e9fa1d9af..f5ee2d5b1b 100644
>--- a/include/system/igvm-internal.h
>+++ b/include/system/igvm-internal.h
>@@ -81,4 +81,10 @@ QIgvmParameterData*
> qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
>                        Error **errp);
>
>+uint8_t *
>+qigvm_get_param_data(QIgvm *igvm, uint32_t parameter_area_index,
>+                     const IGVM_VHS_PARAMETER *param,
>+                     uint32_t *param_size,
>+                     Error **errp);
>+
> #endif
>
>-- 
>2.55.0
>


