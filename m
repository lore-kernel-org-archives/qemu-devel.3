Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6078EC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mBv-0001xf-Os; Wed, 02 Sep 2026 10:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x1mBr-0001ud-My
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x1mBq-0002I2-7D
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788360228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9MF2xUKT7BqaIFJZGRPTncoqwLMVPXGiP5ImEgxPJBY=;
 b=R64u+XBcW3IYjZ2HysV5DwYtdHfVRnnAM1VqD6Od2K621bKFPmRVT05xYvgnkGhvoVpbFH
 YmlCe2lJaq9yqOsKQjunlLLkNnoESsf4OV4W6wQVFXuHFm3VYDUl7IAR8N5IBgfC6s3goT
 KI2qCbd+/4YfJeaWUpF96eWDN1wZLes=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-o38Z5ePOMsmEsScMBFwxrA-1; Wed, 02 Sep 2026 10:43:47 -0400
X-MC-Unique: o38Z5ePOMsmEsScMBFwxrA-1
X-Mimecast-MFC-AGG-ID: o38Z5ePOMsmEsScMBFwxrA_1788360226
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso10008725e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788360226; x=1788965026; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9MF2xUKT7BqaIFJZGRPTncoqwLMVPXGiP5ImEgxPJBY=;
 b=McM27O2r9usP56NjyhIqHVVMf3tzPmwamIY+yYLbeA1idRsIOSHdPtZDSbALMHR3iF
 WYmicl8AXgN5bv61YCPCp1k9RSJ66YLdK+EaFbpb3LVi5lvniNH0vn3Xvfvn7q3GMMZl
 0doZEVCHI2kTFV0/VEWP5CUGy1cfDhufbe0nzP5TYj3NZOg9s+PWzUv09MwRBuTtStWF
 OwLO4r7S8OADiGL1qEr45nig5Fr7kLU7Aqmwo1BU3lj30J6a99jYPOD/VNPSasa2SQ3A
 tt8krZrbocK/wtRMV8RvhMfcnhZ9eNPtKlDIcPXMzsIG3ueWD0f0lhYVsUdRjpUlCoGm
 B2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788360226; x=1788965026;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9MF2xUKT7BqaIFJZGRPTncoqwLMVPXGiP5ImEgxPJBY=;
 b=Q2XjknXeFsrkr8+uHR7id9a6OK/T39DcLiEtLBZDrwBQmj0sgh5EAy4+b6XPyD0Dw1
 QQhF7t+vo4UmJzmw+BGHN5HwDhfmAMnD1nv9jjhJ9877x3IeywNSHmTytK56yl4MNaKN
 jr/pcAutLtXr5xaeSmzQcrc+iu9WOP7F8BJ27OdgFKspNdMCnBIWjHpxQPCAEXNLewsE
 WSgrgMrj1RMOh4eem34qyMkYJXiQnI3hkWELksaQ+HnTc993ueKMiP/052fM03eHdNNP
 FLTliVLTxFuNMrVU7WO/E3vv9F79+GeNKxD1jcn8CKXRW26a0Lsr1ohwO05dlux2kNl4
 jO/A==
X-Gm-Message-State: AFuF++kl3rYptzoFi8GZJMTJEV/2hdW6HHzUbLmFsO9K/B4z8X58NDq/
 4YYW2LHc//vG0ffEd9uo6+4cFTqdltG6Es4vUR4M7cBbsr5mzJRF0o2Gkk72lDHNfUu2Z+finl7
 Bx4TTYLaafhFx2bTxMpj8/Uw9qwJ+bSDofgfin7uEFvaA8iL6Bp2NnOW8
X-Gm-Gg: AR+sD106a9CSlCHS6/D+gONPb2F1KRTgM9lJDdjh5DtBecR6gnrEDsXBNt8PG7AsxDx
 gCDh9eg5z/tfwUSEbLIm9pf6yMHsUIEtZIOaJkv5I+5IfE94fdov1xkFEVUzRcEILFqttLgC2Xx
 FdpcHreYAoNj1eoMt81sd0DlavkrAxPbMwiPagYnTP5ejs1rKkgVua9HOgcTVah4RXCDcq2IlPO
 IIg/61EQgAVmnfOL1Ao2diUviGNFwLDqU3WG3AkGfdRBAV3OSATP4Yez965hgK7ROxmrjUM33SY
 KCgQnjvekok7DWJ5Gj9t895VlHol6D/keGkmVaNOnKB8rDcx6ykVpQKGoeD+/DyGhtltBrdcxzF
 xH4u6LQI5Cz36MmCfKU4pexFGt3on9d0nmgMi1hM/BiTKaw==
X-Received: by 2002:a05:600c:1395:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-49ce5812c52mr82105365e9.10.1788360225921; 
 Wed, 02 Sep 2026 07:43:45 -0700 (PDT)
X-Received: by 2002:a05:600c:1395:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-49ce5812c52mr82103425e9.10.1788360225025; 
 Wed, 02 Sep 2026 07:43:45 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4776131sm82024145e9.11.2026.09.02.07.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:43:44 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:43:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH 1/2] igvm: honor byte_offset when writing memory map,
 MADT and device tree
Message-ID: <apg0vDnAiCLSJDSI@sgarzare-redhat>
References: <20260902-fix_offset-v1-0-04b18f7595b2@redhat.com>
 <20260902-fix_offset-v1-1-04b18f7595b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260902-fix_offset-v1-1-04b18f7595b2@redhat.com>
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

On Wed, Sep 02, 2026 at 04:21:58PM +0200, Luigi Leonardi wrote:
>qigvm_directive_memory_map(), qigvm_directive_madt() and
>qigvm_directive_device_tree() all wrote their data unconditionally at
>the start of the parameter area's buffer, ignoring param->byte_offset
>from the IGVM_VHS_PARAMETER header. This is harmless when a
>directive's offset happens to be 0, but breaks for IGVM files that pack
>multiple parameters into a single shared parameter area at different
>offsets: a later directive would overwrite the data written by an earlier
>one at the start of the buffer, corrupting it.
>
>Use param_entry->data + param->byte_offset as the write location and
>size the bounds checks against the remaining space in the buffer
>rather than its full size.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c    | 10 ++++++----
> target/i386/igvm.c |  4 ++--
> 2 files changed, 8 insertions(+), 6 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 7b7bdc72b7..a6e3a58022 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -632,8 +632,10 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>         return -1;
>     }
>
>-    max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>-    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
>+    max_entry_count = (param_entry->size - param->byte_offset) /

Should we validate that byte_offset >= size to avoid underflows?

>+                      sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
>+    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)(param_entry->data +
>+                                              param->byte_offset);

Would it be better to add some helpers that return the size and the 
pointer (with validations as well)?

That way, we can avoid having to do this everywhere and also prevent 
future issues.

Stefano

>
>     retval = get_mem_map_entry(entry, &cgmm_entry, errp);
>     while (retval == 0) {
>@@ -837,14 +839,14 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>     }
>
>     fdt_size = fdt_totalsize(fdt_packed);
>-    if (fdt_size > param_entry->size) {
>+    if (fdt_size > param_entry->size - param->byte_offset) {
>         error_setg(errp,
>                    "IGVM: device tree size exceeds parameter area"
>                    " defined in IGVM file");
>         return -1;
>     }
>
>-    memcpy(param_entry->data, fdt_packed, fdt_size);
>+    memcpy(param_entry->data + param->byte_offset, fdt_packed, fdt_size);
>
>     return 0;
> }
>diff --git a/target/i386/igvm.c b/target/i386/igvm.c
>index ad9bf87761..4d9d97385a 100644
>--- a/target/i386/igvm.c
>+++ b/target/i386/igvm.c
>@@ -199,8 +199,8 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
>
>     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
>
>-    if (madt->len <= param_entry->size) {
>-        memcpy(param_entry->data, madt->data, madt->len);
>+    if (madt->len <= param_entry->size - param->byte_offset) {
>+        memcpy(param_entry->data + param->byte_offset, madt->data, madt->len);
>     } else {
>         error_setg(
>             errp,
>
>-- 
>2.55.0
>


