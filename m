Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C0CC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TTv-0004ID-8z; Fri, 04 Sep 2026 08:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x2TTt-0004Hz-ST
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x2TTr-0001cV-NP
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788526638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YmjAaYn+OOapKZaImf2kUmV4iOMjTHpFPpOIwUUUtL8=;
 b=Pkr0OR0TfW+DJUmdGo8Xpf0S1ZO0acrlzL+qHcYvBGnOmddw63zrj0zdjHOgaD+CS9y9Xt
 ylKduCBc/K+5P4ALY6r4jexz/PyLXs643reow0E0x2cm+NS8zPkj+Skf9GEWcB6GTFJcQn
 YxiF8CGhy+KO161QvrHqS2ZjV/ec5Fs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-FC1sw9oyNhu854mjoGDE0w-1; Fri, 04 Sep 2026 08:57:17 -0400
X-MC-Unique: FC1sw9oyNhu854mjoGDE0w-1
X-Mimecast-MFC-AGG-ID: FC1sw9oyNhu854mjoGDE0w_1788526636
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-484362cb000so685534f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788526636; x=1789131436; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YmjAaYn+OOapKZaImf2kUmV4iOMjTHpFPpOIwUUUtL8=;
 b=blcCMf0o4z1MxJGgwQTBymKh0kPoE8mOM/yXun8t7jquC+HqI7l0CkfSl2Ivo1re4Z
 C2yH4l24mQEoFerHS9CQl20IkltoZdMtJWt0WAuPgUrSusuRo2ybTnQB9pZjxC2ISssH
 J7rmNYJ3l1GDwiy3CMZynKYM6q1ZGqHjicQeoEGkiT5rIZ+fTDub+1NpwCvLbVW53TyN
 zLEYmM1lfUeB7la1gsrmgI2Xn5934S/sr9OANSxdbNuoAjUZInDoNbceRugJNCmk+Fkm
 /9IB8ER8Bx4mz/g4qZJVPZVnJprnuCwXxf1hfrXgnlJFvkSI6xCmJbunqR3s/yv6DIAO
 +3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526636; x=1789131436;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YmjAaYn+OOapKZaImf2kUmV4iOMjTHpFPpOIwUUUtL8=;
 b=mwDNh9DwXZir2IwuSUTEu3WUTB9FxX0cR4fyft8/RAMnQYmdI9esZHivAvu8XYwXej
 Apn86smojBEBZoEZr2iU7JKd1AOgeVkp2eJzXiqXuhwLldl8uOHSlKGP91jT0i/B/KMH
 cI+IaFp5Ww2yinxMlsiq6j5OkHM+dOEQbCiotIo3199Si/v5UoeDBmfDZJ4tkyjAmer4
 4sLgMyoX2s8f+2BM+rBrBCA0SrcMEmo0bd28snkeUsyNeYOoF8atUo9lusOJS5WqEdcG
 JU1G1shnLGLim6KDk8cG7CY4lVmHWbF14ICmVbF0s9ctM495uECoVbaeOv74u3zqUKre
 SCmg==
X-Gm-Message-State: AFuF++nDCDqEthkwPj0pKrsadrShKkAUKfXcwOnus9PXf308HmiAm/LA
 s7DmTNWP4XKWoG7vLn1kXNUWVxxtQiQWwuOjUQ2mfrfd4LDW9BrslcOaik/m9JyN8gmm+t9XBaP
 0yFIZynOogQaG3ALAbngaHfeDRkwgjhO/Y0QLhQfyUa4KrHrYle7F2AnE
X-Gm-Gg: AYBFou0stRXbbgkPnm812NAAxKqVBJmTiNuEVc6v/kekgNMKJef9CQmjMNPvSj68ZEP
 5RJTqPmeLkwTkfWcbL5uxGLRMfbIeo3AGhDLYxGCpB6L3CYMqzIuxusNIc5bvtbucsQF17T+zlv
 aOI/iPM7W9lPr6B3R5HHKaVwn/jw8lAnIRb8QdQ+n56OeO1ropLHol7avVcJ58cFw1qfjXmdFTN
 eGFwFvbri6DIhIm093DdLfWH0o2WbBNjcGEAqyC5qQBiP/YUpRamE3GofCpeOrxiFeg9d0d0100
 8py+8h8av5FfphXg0GsqDmjcbt6GUWuDnC6fNhT+VyczA66TrPNgapYJSKKG0l82RWUJMWfNoBw
 CkVRNwuYzsZEf4856wM49HsFzWH+A8F0nmFp9Whvflka2gw==
X-Received: by 2002:adf:e18e:0:b0:485:82c0:190d with SMTP id
 ffacd0b85a97d-4858922dbc1mr5145992f8f.20.1788526635901; 
 Fri, 04 Sep 2026 05:57:15 -0700 (PDT)
X-Received: by 2002:adf:e18e:0:b0:485:82c0:190d with SMTP id
 ffacd0b85a97d-4858922dbc1mr5145934f8f.20.1788526635316; 
 Fri, 04 Sep 2026 05:57:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885b7bfasm6335304f8f.29.2026.09.04.05.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:57:14 -0700 (PDT)
Date: Fri, 4 Sep 2026 14:55:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 1/2] igvm: validate byte_offset before using it in
 parameter directives
Message-ID: <apq2Wp3cDbLQm2Ab@sgarzare-redhat>
References: <20260904-fix_offset-v2-0-f5bb4cf6d4b0@redhat.com>
 <20260904-fix_offset-v2-1-f5bb4cf6d4b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260904-fix_offset-v2-1-f5bb4cf6d4b0@redhat.com>
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

On Fri, Sep 04, 2026 at 01:42:55PM +0200, Luigi Leonardi wrote:
>None of the directive handlers that place data at a byte_offset within
>a parameter area validated that byte_offset actually falls within the
>parameter area's size. A malformed IGVM file with byte_offset > size would
>underflow the "size - byte_offset" computation used to determine
>remaining space, wrapping to a huge value and defeating the size
>check, then write out of bounds through param_entry->data +
>byte_offset.
>
>Add qigvm_find_param_validate(), which looks up the parameter area,
>checks byte_offset against its size, and returns the offset-adjusted
>data pointer and remaining size via output parameters instead of the
>raw QIgvmParameterData entry. This keeps the byte_offset arithmetic in
>one place instead of repeating param_entry->data + byte_offset and
>param_entry->size - byte_offset at every call site.
>
>Use it in the vp-count and environment-info handlers, adding an
>explicit check that the fixed-size write fits in the remaining space.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c                | 68 +++++++++++++++++++++++++++++++++++-------
> include/system/igvm-internal.h |  6 ++++
> 2 files changed, 63 insertions(+), 11 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 7b7bdc72b7..8c07f2ce5e 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -101,6 +101,39 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
>     return NULL;
> }
>
>+/*
>+ * Look up a parameter area and check that param->byte_offset falls within
>+ * it, in one step. On success, *data and *size are set to the
>+ * offset-adjusted write location and remaining space within the parameter
>+ * area, so callers never need to touch param->byte_offset themselves.
>+ */
>+bool
>+qigvm_find_param_validate(QIgvm *igvm, uint32_t parameter_area_index,

I'm not sure about the name, but I don't have anything better to
suggest, maybe qigvm_get_param_data() ?

>+                          const IGVM_VHS_PARAMETER *param,
>+                          uint8_t **data, uint32_t *size,
>+                          Error **errp)
>+{
>+    QIgvmParameterData *param_entry;
>+
>+    assert(data && size);
>+
>+    param_entry = qigvm_find_param_entry(igvm, parameter_area_index, errp);
>+    if (!param_entry) {
>+        return false;
>+    }

All others qigvm_* functions returns 0 on success and != 0 on failure,
should we be consistent ?

Or maybe we can return the data pointer (with NULL as error).

>+
>+    if (param->byte_offset > param_entry->size) {
>+        error_setg(errp,
>+                   "IGVM: byte_offset 0x%x exceeds parameter area size 0x%x",
>+                   param->byte_offset, param_entry->size);
>+        return false;
>+    }
>+
>+    *data = param_entry->data + param->byte_offset;
>+    *size = param_entry->size - param->byte_offset;
>+    return true;
>+}
>+
> static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
>                                      Error **errp);
> static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
>@@ -682,17 +715,24 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
>                                     Error **errp)
> {
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>-    QIgvmParameterData *param_entry;
>+    uint8_t *data;
>+    uint32_t size;

nit: following the previous param_entry, maybe we can call them
param_data and param_size all over the place.

>     uint32_t *vp_count;
>     CPUState *cpu;
>
>-    param_entry = qigvm_find_param_entry(ctx,
>-                                         param->parameter_area_index, errp);
>-    if (param_entry == NULL) {
>+    if (!qigvm_find_param_validate(ctx, param->parameter_area_index, param,
>+                                   &data, &size, errp)) {
>+        return -1;
>+    }
>+
>+    if (sizeof(*vp_count) > size) {
>+        error_setg(errp,
>+                   "IGVM: vp-count parameter exceeds parameter area "
>+                   "defined in IGVM file");
>         return -1;
>     }
>
>-    vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
>+    vp_count = (uint32_t *)data;
>     *vp_count = 0;
>     CPU_FOREACH(cpu)
>     {
>@@ -707,17 +747,23 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
>                                             Error **errp)
> {
>     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>-    QIgvmParameterData *param_entry;
>+    uint8_t *data;
>+    uint32_t size;
>     IgvmEnvironmentInfo *environmental_state;
>
>-    param_entry = qigvm_find_param_entry(ctx,
>-                                         param->parameter_area_index, errp);
>-    if (param_entry == NULL) {
>+    if (!qigvm_find_param_validate(ctx, param->parameter_area_index, param,
>+                                   &data, &size, errp)) {
>+        return -1;
>+    }
>+
>+    if (sizeof(*environmental_state) > size) {
>+        error_setg(errp,
>+                   "IGVM: environment-info parameter exceeds parameter area "
>+                   "defined in IGVM file");
>         return -1;
>     }
>
>-    environmental_state =
>-        (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
>+    environmental_state = (IgvmEnvironmentInfo *)data;
>     environmental_state->memory_is_shared = 1;
>
>     return 0;
>diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
>index 9e9fa1d9af..6526b5055c 100644
>--- a/include/system/igvm-internal.h
>+++ b/include/system/igvm-internal.h
>@@ -81,4 +81,10 @@ QIgvmParameterData*
> qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
>                        Error **errp);
>
>+bool
>+qigvm_find_param_validate(QIgvm *igvm, uint32_t parameter_area_index,
>+                          const IGVM_VHS_PARAMETER *param,
>+                          uint8_t **data, uint32_t *size,
>+                          Error **errp);
>+
> #endif
>
>-- 
>2.55.0
>


