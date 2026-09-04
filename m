Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963EBC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TZp-0006LA-1D; Fri, 04 Sep 2026 09:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x2TZl-0006I6-Mp
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x2TZj-00032k-NG
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uk2rJ+DusDw+blnWhuuRKNBRvzysrXD8mtxFKv2Vyms=;
 b=KF0CQ3oBiqFMzetcRYZiglRbSLwyFn7n5gCXyD8mepQEAj6a6pxEeYn6S1o9CIPxccaq2C
 Vk8iT2u6xi1a46Lic1oV0EVAW70P0DXun/H6SL/pbOOkpirNqZ5DWW4wF1VCSGwPCOmWdR
 PA/K1n7cFMBWuEyUAWDNyVcvztllNfg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-iWVuJlGsPV2ij0w_A7bkeQ-1; Fri, 04 Sep 2026 09:03:19 -0400
X-MC-Unique: iWVuJlGsPV2ij0w_A7bkeQ-1
X-Mimecast-MFC-AGG-ID: iWVuJlGsPV2ij0w_A7bkeQ_1788526998
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6a60c4a94e9so887886a12.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788526998; x=1789131798; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uk2rJ+DusDw+blnWhuuRKNBRvzysrXD8mtxFKv2Vyms=;
 b=ffbhm6ByYWdj8Mv4Pv3O7jdiojHXsz7+HXw3QES2OIM+nFa8+56CGzUKf/oWkPU/Q5
 oLYSO5Hcp2l00R3w7IF513KUh3mFEo+JBMFvzOr4NB7Fc5TlcKBAKhO3yZJlWfBjS1a8
 1UYF/fAw0Vvagv7c76/wxe7bGxvheeQshYF+8g1XaddicBIaxf/4KdqYfXSzdq1+f4jj
 ZKLyAcwUsk0qOAskaPZev9A2nMZwEofTMkKiwQnxAHhx66fvCaYmX1khDN8wxayn5bPk
 T7HpJcIP1qAhgzNsiWIzBpUaEpXqFyfbuewLjawzCiPrOAnK5jLmKex7pjsfStQ2leAX
 9zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526998; x=1789131798;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uk2rJ+DusDw+blnWhuuRKNBRvzysrXD8mtxFKv2Vyms=;
 b=DIZeen0IMkoLSqcqRm9igP49l5ykIVpPMtmOUtW4vyDl1ihrGBlYRAi500qIM9tGGh
 cd5tipi2VZIe5X4XplpjY3/xXYnPPvtDq2xhL0LqGyIGUGBz8u+/1cRy0qSdkbSpkvA5
 fT/yfWd+ggvOO7HZF84DRvDfpVBv4QAlEHJmI14sggWCKvMN0+peRyemD5moRzayYlgZ
 mm358dD3ZY39tv/CKGIO8nJdBk+qbquaeZhCqAHSimydn+T5ozuZxgWmA+/CU+AlAWxK
 +Cy+hHl45B7Ydze22c8CU1LBNCfL2Yfeb72oHHjFH4Z/8JL1aHohsm5WQiZdPnPo0Tb9
 W4JQ==
X-Gm-Message-State: AFuF++mgun27e0n2KAPhbhTkKgrr9IFc4MFXMuIh9yFyn5JW6R+TF+HH
 XObQVg1DiStJiUINh3/QexeTc524hyq87QeOIP9oX1W5XoTfMEbSaCE0+HmLKAcuVkNZPnDxIEw
 fGjNt127pOB3EBkUNErNPMJXbnfp1o4UnGeWmIpku3Duv7AdwJM2nwD9p
X-Gm-Gg: AYBFou1LsiLRa9DIWGtczBiKoVZpxz6ruPONQRVtH8JX0cgdFzMCMAH3EVqNBtz7i9I
 fnMNaDJi3MIcdFQCmLjRtD5A/6YUssNxMC2Wcwie+qZpES43Bd1MmFYbErWEWM5++xZmMP4Cj2l
 qobEmZ+bb30QuklOpE2CmsdFdJii2J5MuCEFT7/31CXx6JwRSuAgu6Dkp/q6tdHAUNcwvnvuyip
 ypZY+QdzRRy6TTS8PI9DPecVxI7KnLbbWNQTHIB9fj2xroq9/lxo1wSWd3aH30+cjhjoKTN4Gf9
 CEa+WbGKTttm5RmE8H3XrL8Aal9OTkEy7gKLqt6vEIbigXcRVATIgZ2wWgLG5jN7gomdeeT/2Gu
 2RuMTTjzKiNBIuVs+7ur4YdsX1aXfm7dtUkePnjbbbPFD5w==
X-Received: by 2002:a05:6402:a0cc:b0:6a6:32f5:5572 with SMTP id
 4fb4d7f45d1cf-6a7e8f94ad0mr2196233a12.20.1788526998028; 
 Fri, 04 Sep 2026 06:03:18 -0700 (PDT)
X-Received: by 2002:a05:6402:a0cc:b0:6a6:32f5:5572 with SMTP id
 4fb4d7f45d1cf-6a7e8f94ad0mr2196199a12.20.1788526997427; 
 Fri, 04 Sep 2026 06:03:17 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588133600sm6833352f8f.5.2026.09.04.06.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:16 -0700 (PDT)
Date: Fri, 4 Sep 2026 15:02:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 2/2] igvm: honor byte_offset when writing memory map,
 MADT and device tree
Message-ID: <aprBZ4XguYCgUyNN@sgarzare-redhat>
References: <20260904-fix_offset-v2-0-f5bb4cf6d4b0@redhat.com>
 <20260904-fix_offset-v2-2-f5bb4cf6d4b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260904-fix_offset-v2-2-f5bb4cf6d4b0@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Fri, Sep 04, 2026 at 01:42:56PM +0200, Luigi Leonardi wrote:
>qigvm_directive_memory_map(), qigvm_directive_madt() and
>qigvm_directive_device_tree() all wrote their data unconditionally at
>the start of the parameter area's buffer, ignoring param->byte_offset
>from the IGVM_VHS_PARAMETER header. This is harmless when a
>directive's offset happens to be 0, but breaks for IGVM files that pack
>multiple parameters into a single shared parameter area at different
>offsets: a later directive would overwrite the data written by an earlier
>one at the start of the buffer, corrupting it.
>
>Switch these handlers to qigvm_find_param_validate(), introduced in
>the previous patch, and use the offset-adjusted data pointer and
>remaining size it returns instead of writing at param_entry->data and
>sizing checks against param_entry->size directly. This both honors
>byte_offset and validates it against the parameter area size before
>it is used.

Do we need a Fixes tag?

The rest LGTM,
Stefano

>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c    | 24 ++++++++++++------------
> target/i386/igvm.c | 12 ++++++------
> 2 files changed, 18 insertions(+), 18 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 8c07f2ce5e..4d622eac6a 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -638,7 +638,8 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>     int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
>                              Error **errp) = NULL;
>-    QIgvmParameterData *param_entry;
>+    uint8_t *data;
>+    uint32_t size;
>     int max_entry_count;
>     int entry = 0;
>     IGVM_VHS_MEMORY_MAP_ENTRY *mm_entry;
>@@ -659,14 +660,13 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>     }
>
>     /* Find the parameter area that should hold the memory map */
>-    param_entry = qigvm_find_param_entry(ctx,
>-                                         param->parameter_area_index, errp);
>-    if (param_entry == NULL) {
>+    if (!qigvm_find_param_validate(ctx, param->parameter_area_index, param,
>+                                   &data, &size, errp)) {
>         return -1;
>     }
>
>-    max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>-    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
>+    max_entry_count = size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>+    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)data;
>
>     retval = get_mem_map_entry(entry, &cgmm_entry, errp);
>     while (retval == 0) {
>@@ -860,12 +860,12 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
> {
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>     g_autofree void *fdt_packed = NULL;
>-    QIgvmParameterData *param_entry;
>+    uint8_t *data;
>+    uint32_t size;
>     uint32_t fdt_size;
>
>-    param_entry = qigvm_find_param_entry(ctx,
>-                                         param->parameter_area_index, errp);
>-    if (param_entry == NULL) {
>+    if (!qigvm_find_param_validate(ctx, param->parameter_area_index, param,
>+                                   &data, &size, errp)) {
>         return -1;
>     }
>
>@@ -883,14 +883,14 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>     }
>
>     fdt_size = fdt_totalsize(fdt_packed);
>-    if (fdt_size > param_entry->size) {
>+    if (fdt_size > size) {
>         error_setg(errp,
>                    "IGVM: device tree size exceeds parameter area"
>                    " defined in IGVM file");
>         return -1;
>     }
>
>-    memcpy(param_entry->data, fdt_packed, fdt_size);
>+    memcpy(data, fdt_packed, fdt_size);
>
>     return 0;
> }
>diff --git a/target/i386/igvm.c b/target/i386/igvm.c
>index ad9bf87761..db365cb80e 100644
>--- a/target/i386/igvm.c
>+++ b/target/i386/igvm.c
>@@ -187,20 +187,20 @@ void qigvm_x86_bsp_reset(CPUX86State *env)
> int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
> {
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>-    QIgvmParameterData *param_entry;
>+    uint8_t *data;
>+    uint32_t size;
>     int result = 0;
>
>     /* Find the parameter area that should hold the MADT data */
>-    param_entry = qigvm_find_param_entry(ctx,
>-                                         param->parameter_area_index, errp);
>-    if (param_entry == NULL) {
>+    if (!qigvm_find_param_validate(ctx, param->parameter_area_index, param,
>+                                   &data, &size, errp)) {
>         return -1;
>     }
>
>     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
>
>-    if (madt->len <= param_entry->size) {
>-        memcpy(param_entry->data, madt->data, madt->len);
>+    if (madt->len <= size) {
>+        memcpy(data, madt->data, madt->len);
>     } else {
>         error_setg(
>             errp,
>
>-- 
>2.55.0
>


