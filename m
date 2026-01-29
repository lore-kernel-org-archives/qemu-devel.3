Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BA1D358FD
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 11:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlPuz-00054J-SE; Thu, 29 Jan 2026 06:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vlPul-0004uC-CD
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:10:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vlPuj-0001mU-Kd
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769685017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YIQVwOXDCHDhYmBr10vNY+a4rvqiuUdxtT1SruNRqfY=;
 b=NdOFp6lERUV1iYz+bepQrYDNZwfhOUVjUh7JyWtd3Q9eqfnSdqXjHt7GqpdTFbCxon9ue4
 HbYvBT2GqThNTT9amh0L9ruK/sc54gHgbwH3vSeeVKX+c42PDPYgTQYnkTuIsbYbQQRZhd
 TncrJwPK5IuVggJoocfmY+pexLBk+zs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-5EDkjd0KOwmj7wUcfOLkiw-1; Thu, 29 Jan 2026 06:10:13 -0500
X-MC-Unique: 5EDkjd0KOwmj7wUcfOLkiw-1
X-Mimecast-MFC-AGG-ID: 5EDkjd0KOwmj7wUcfOLkiw_1769685012
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4325b182e3cso580520f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 03:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769685012; x=1770289812; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YIQVwOXDCHDhYmBr10vNY+a4rvqiuUdxtT1SruNRqfY=;
 b=M+hfSRIZjO7sGuttiH010ibRifdpOYQyF34f06xdioVh1w+iZCaYHP6XLNQQRPhUYr
 qJBEc6L4cFHloBWeuHrY0xGF7YBykMelezPP2eUST34QsyueLg14JDuqfl2YdKOg4cQS
 sXQL0qHl5w793/C+SCKH+2By/2nxwZE/AQsnQJ46kDiLee8A4iERZjm53x8gBvkqslMb
 99pDpbnI6ZKnN3LPe8Rsx6vtaSa36cFsqiPgAEdR2XEQwSdPZ/V7hd60wy5HdJOt+Vz3
 KfPjGJ3E1oEKLwaNxSxEAYFfTYmxMJji3j3QTobxeIisBYZUovPyipHvjaJNFFwYp9j8
 X3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769685012; x=1770289812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YIQVwOXDCHDhYmBr10vNY+a4rvqiuUdxtT1SruNRqfY=;
 b=r69eAw6Bev/wHMQ6dc4ANW+IMYCjz4EHkGd5+ER1mHKBmHCDgZ5PKD8FgJjsAe1DqG
 lYX9e03amIzekKQCsLhiUdujFQzKe01YSAdnaJnBKtgfck6YXkO/lXv8AxWTF2pH2Ed9
 bBCzGSa6o1TpV3hsFapy6v2U+DD5FJPVyZgSvVqmTcRVmVQHYDhtc3d8dq09SFh2Vp7N
 CTJhQNXZXKMpQzAIHEfL6yk9PnDyFU2I2LoFPkaLatXhSH4pJ6p533GiH0W6yfq302+N
 xDI6CqbsgmflPrMZrFatg1nJasIYGLWlo8sHt/VV3f7T7BpnUyp5tHTSnGKrEV6+G3Zr
 aHZA==
X-Gm-Message-State: AOJu0Yz0VcfZ//pUkr0/BQshQmNRngKZp8pyBQStHSuWErwsRwMu0A8t
 ao+/L1NDFwsddx+nM/PLxngBaeQJSrg5BFOOy7mo8Q4FWOGFVgTF2y4dd4+C+sn9mQipDRNwVQb
 0WmxoocuvCzakqSbcWMJjkeq2nZ+wHYIcCTHBIfEYrbTWTFpRrcZUkuKw
X-Gm-Gg: AZuq6aKlOKuykTz8IK/ZwMWvb3QUoYLz9sMGpJw6WsAkBla+KNXTSdIsscdqkXb1wt0
 9UjII3ATHRXwWGdPDgJrB3fFDify92CA2MFIhBDW9DiElG87yQj5vyVdA1fTzce1uPBmikeAp5t
 06VsRygoppptfLXB7xOXaYo97qaX9TIXUTaFn+uV+ClnaEoRwxZ0Hor8HLoOGCw5zImK8yaz2H+
 i9UW7d5AmHcXO8fFMNBWEVTpIay66Xr9Nkz9bV58TZg1xwBKrXS8m9YoWKbIb1FSuYY1ftNfYaJ
 flo3q9ap/oZ4rEDJRYBWR1sVPckVXEGAhzuTMJA28A2m+5w78JGeRPiV7RZhhsGngedDXJ7tZv1
 LlS26InEHE2KUaQ==
X-Received: by 2002:a05:600c:e40b:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-4806a5bef0fmr83006775e9.36.1769685012023; 
 Thu, 29 Jan 2026 03:10:12 -0800 (PST)
X-Received: by 2002:a05:600c:e40b:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-4806a5bef0fmr83006315e9.36.1769685011546; 
 Thu, 29 Jan 2026 03:10:11 -0800 (PST)
Received: from leonardi-redhat ([176.206.38.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4762sm13396916f8f.6.2026.01.29.03.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 03:10:11 -0800 (PST)
Date: Thu, 29 Jan 2026 12:10:08 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH v5 4/6] igvm: Refactor qigvm_parameter_insert
Message-ID: <aXtAAzNeJxr9usOo@leonardi-redhat>
References: <20260127100257.1074104-1-osteffen@redhat.com>
 <20260127100257.1074104-5-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260127100257.1074104-5-osteffen@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
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

On Tue, Jan 27, 2026 at 11:02:55AM +0100, Oliver Steffen wrote:
>Use qigvm_find_param_entry() also in qigvm_parameter_insert().
>This changes behavior: Processing now stops after the first parameter
>entry found. That is OK, because we expect only one matching entry
>anyway.
>
>Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>---
> backends/igvm.c | 50 ++++++++++++++++++++++++-------------------------
> 1 file changed, 25 insertions(+), 25 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 213c9d337e..0a0092fb55 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -513,31 +513,31 @@ static int qigvm_directive_parameter_insert(QIgvm *ctx,
>         return 0;
>     }
>
>-    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
>-    {
>-        if (param_entry->index == param->parameter_area_index) {
>-            region = qigvm_prepare_memory(ctx, param->gpa, param_entry->size,
>-                                          ctx->current_header_index, errp);
>-            if (!region) {
>-                return -1;
>-            }
>-            memcpy(region, param_entry->data, param_entry->size);
>-            g_free(param_entry->data);
>-            param_entry->data = NULL;
>-
>-            /*
>-             * If a confidential guest support object is provided then use it to
>-             * set the guest state.
>-             */
>-            if (ctx->cgs) {
>-                result = ctx->cgsc->set_guest_state(param->gpa, region,
>-                                                    param_entry->size,
>-                                                    CGS_PAGE_TYPE_UNMEASURED, 0,
>-                                                    errp);
>-                if (result < 0) {
>-                    return -1;
>-                }
>-            }
>+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
>+    if (param_entry == NULL) {
>+        return 0;
>+    }
>+
>+    region = qigvm_prepare_memory(ctx, param->gpa, param_entry->size,
>+                                    ctx->current_header_index, errp);
>+    if (!region) {
>+        return -1;
>+    }
>+    memcpy(region, param_entry->data, param_entry->size);
>+    g_free(param_entry->data);
>+    param_entry->data = NULL;
>+
>+    /*
>+     * If a confidential guest support object is provided then use it to
>+     * set the guest state.
>+     */
>+    if (ctx->cgs) {
>+        result = ctx->cgsc->set_guest_state(param->gpa, region,
>+                                            param_entry->size,
>+                                            CGS_PAGE_TYPE_UNMEASURED, 0,
>+                                            errp);
>+        if (result < 0) {
>+            return -1;
>         }
>     }
>     return 0;
>-- 
>2.52.0
>

LGTM

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


