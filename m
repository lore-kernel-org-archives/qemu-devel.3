Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6610CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiA3n-0002g5-CD; Fri, 10 Jul 2026 08:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wiA3g-0002fP-BU
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 08:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wiA3d-00013T-Es
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 08:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783685414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mCqGvjTdYAPwQZXU79Llq+J5rZ14mj/V0IHI/p9isFY=;
 b=cvkPyo5vuxCr3XznzL7YRkxMYQsb4BdsCDLd5waPhgqxt/uw9u2f5Zkx6K5SRgzjsllUvP
 Ff0xHM6hRtxzgPvd1xyT7X56DRACzg8K3r6zbaoZcRv5Mq7ZBl1AfjN9Z3djs09eeX5ZXX
 ZISUAIYKq5ChsoTJsQJc5EjwIHE5jFk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-hVu8F6RUMwScBIDcrbxnYg-1; Fri, 10 Jul 2026 08:10:12 -0400
X-MC-Unique: hVu8F6RUMwScBIDcrbxnYg-1
X-Mimecast-MFC-AGG-ID: hVu8F6RUMwScBIDcrbxnYg_1783685412
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c33f48ee4so9319551cf.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783685412; x=1784290212; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mCqGvjTdYAPwQZXU79Llq+J5rZ14mj/V0IHI/p9isFY=;
 b=jcDqJV7l9h+zYGtyFRD/4zF0AqHqMuQv6YIzQB3cUEzUCCJW0YaVhAKdFo9JIGw9Co
 gsS4CxAAkdJ7DOs80aihFF9fNnuxVWpbhYZzOiIu9OS3iuCB9ECmEbOt7GQsWMQ2gEhF
 PDAxv21JWh1NXuNSyPGt2Zu2kI85u13KGJnxiVRXsX39T8Z82L4FmWJIr0zobihyb8b3
 ojVhR5opnF7pSALUyBZl+UqTV5165HzwCJtd2wTfD6hDcpEoDiVyUpH/MDTBqIwCxO7t
 YNSrWfeRnbOa6yX4Mz8+pazFyWLuclpmLNvvuhMiYi6K6Ea3kCPDbVw446MMkjhhf8oe
 4bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783685412; x=1784290212;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mCqGvjTdYAPwQZXU79Llq+J5rZ14mj/V0IHI/p9isFY=;
 b=o1xQMbAJgcwwZaJn7m6M+ikO5kSZksi9uruhfEWPpKUZ4FKnepaYKOeMUQHL4LrAh9
 btpKEqCwvqNzLx8q3DP0+aHtWmfgLhU2b1AAbvpbS2KH9H1hllaT7DXD3UW6IIFyI9nx
 IJexN6VJ84XRHW3y4aWgMQmIlm+0RdMCRf0L7ugtl8aR3NBGC9pOzJ9j2m0GSiowfCGX
 dqCE6/ugZy5nfPCBUGSPsdcSvi0cOgUNUUKw6gISlXBAQccmA7Sd5oddpSmG6W16aNR5
 ruJicYWdEcTHupP/N/txwvYSTtJ6h5vFRwBbjWF4I0x88fdgiZOJmTak9R5t7+BMPEK/
 EUcw==
X-Gm-Message-State: AOJu0YzeSpR+xGMKnEhWfWmeAbWlMSfqGgCC+b62pMAiaW81zKR/rk+4
 NHlZ4flcQsKtVL/PE5/vj/WSNRzIrYZ6VuLBlQDnrMuonfJxow7+lzjtyhdVAoldNUMCkqmFXq4
 fyWlDQF/9jD5lJA6hlaZxwWd9DEweEacC/rmrMGTzPcvU9gXMrsdreiZn
X-Gm-Gg: AfdE7clsVe9UVfgRdu1Cq5cHOdmIrBNn6sLbgkPLL/bhzOBLhUhug3a6WeACrbtvy0i
 bxzs1W3epnjtOZ4VPG5pUyZNuE01BRfjpX3aRdlVB4IPJnN6ksvl919R93r66xC5sG7AHKlHZrM
 zwFRxc05ptr3CjZgUHprt03JWuCmsT1Ttl5pg8R7ApAHpQ9aSmXbY1Zeyeqk7aihM5KE1otEDjc
 3DJoE8aR0ev/K3HEqBUzOahNViM6B9C5Nq3M1BKb1ODb4ytsPGT81iHU6xRXW1aieysg7aUdOfG
 rkIFcdjx7n1MmbPpQwGqz+QJfV13BVrHvryyDId5WkNWU0FaOlQYjceP+pZLPtN4ma81uvp2pE4
 aPDrT8HJdxfC+Gm6MstbCxBiMKRFnLn+HNa1a2unE/Hmmp4Y=
X-Received: by 2002:a05:622a:957:20b0:51c:7b12:6002 with SMTP id
 d75a77b69052e-51ca3a212aamr37374181cf.78.1783685411892; 
 Fri, 10 Jul 2026 05:10:11 -0700 (PDT)
X-Received: by 2002:a05:622a:957:20b0:51c:7b12:6002 with SMTP id
 d75a77b69052e-51ca3a212aamr37373851cf.78.1783685411447; 
 Fri, 10 Jul 2026 05:10:11 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caaf5f61csm13909151cf.22.2026.07.10.05.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 05:10:10 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:10:07 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, mcascell@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v3 5/5] hw/uefi: add post_load checks
Message-ID: <alDgAbyQ9zSsp3CR@leonardi-redhat>
References: <20260709104223.143594-1-kraxel@redhat.com>
 <20260709104223.143594-6-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260709104223.143594-6-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Thu, Jul 09, 2026 at 12:42:20PM +0200, Gerd Hoffmann wrote:
>Add sanity checks to uefi-vars state loaded from live migration data
>stream.  Fail migration if invalid data or inconsistencies are found.
>
>Fixes: CVE-2026-61404
>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3837
>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3838
>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3839
>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3885
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> hw/uefi/var-service-core.c   | 14 +++++++++++++-
> hw/uefi/var-service-json.c   |  5 +++++
> hw/uefi/var-service-policy.c | 28 +++++++++++++++++++++++-----
> hw/uefi/var-service-vars.c   | 15 +++++++++++++++
> 4 files changed, 56 insertions(+), 6 deletions(-)
>
>diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
>index 828d76007318..acecf7a8a9b1 100644
>--- a/hw/uefi/var-service-core.c
>+++ b/hw/uefi/var-service-core.c
>@@ -5,6 +5,7 @@
>  */
> #include "qemu/osdep.h"
> #include "qemu/crc32c.h"
>+#include "qemu/error-report.h"
> #include "system/dma.h"
> #include "migration/vmstate.h"
>
>@@ -28,9 +29,20 @@ static int uefi_vars_post_load(void *opaque, int version_id)
> {
>     uefi_vars_state *uv = opaque;
>
>+    if (uv->buf_size > MAX_BUFFER_SIZE) {
>+        error_report("invalid buffer size");
>+        return -1;
>+    }
>+    uv->buffer = g_malloc(uv->buf_size);
>+
>     uefi_vars_update_storage(uv);
>+    if (uv->used_storage > uv->max_storage) {
>+        error_report("out of variable memory (%ld > %ld)",

nit: what about replacing %ld with PRIu64?

>+                     uv->used_storage, uv->max_storage);
>+        return -1;
>+    }
>+
>     uefi_vars_json_save(uv);
>-    uv->buffer = g_malloc(uv->buf_size);
>     return 0;
> }
>
>diff --git a/hw/uefi/var-service-json.c b/hw/uefi/var-service-json.c
>index 8621b86c5c5f..f90deef79b76 100644
>--- a/hw/uefi/var-service-json.c
>+++ b/hw/uefi/var-service-json.c
>@@ -18,6 +18,7 @@
> #include "qobject/qobject.h"
> #include "qobject/qjson.h"
>
>+#include "qapi/error.h"
> #include "qapi/dealloc-visitor.h"
> #include "qapi/qobject-input-visitor.h"
> #include "qapi/qobject-output-visitor.h"
>@@ -249,6 +250,10 @@ void uefi_vars_json_load(uefi_vars_state *uv, Error **errp)
>     if (!(*errp)) {
>         uefi_vars_from_qapi(uv, vs);
>         uefi_vars_update_storage(uv);
>+        if (uv->used_storage > uv->max_storage) {
>+            error_setg(errp, "out of variable memory (%ld > %ld)",
>+                       uv->used_storage, uv->max_storage);
>+        }
>     }
>
>     qapi_free_UefiVarStore(vs);
>diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
>index 46c4ff2dacae..d43cc9b2500b 100644
>--- a/hw/uefi/var-service-policy.c
>+++ b/hw/uefi/var-service-policy.c
>@@ -7,6 +7,7 @@
>  * https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/VariablePolicyLib/ReadMe.md
>  */
> #include "qemu/osdep.h"
>+#include "qemu/error-report.h"
> #include "system/dma.h"
> #include "migration/vmstate.h"
>
>@@ -16,14 +17,18 @@
>
> #include "trace.h"
>
>-static void calc_policy(uefi_var_policy *pol);
>+static int check_calc_policy(uefi_var_policy *pol);
>
> static int uefi_var_policy_post_load(void *opaque, int version_id)
> {
>     uefi_var_policy *pol = opaque;
>+    int rc;
>
>-    calc_policy(pol);
>-    return 0;
>+    rc = check_calc_policy(pol);
>+    if (rc != 0) {
>+        error_report("invalid uefi variable policy");
>+    }
>+    return rc;
> }
>
> const VMStateDescription vmstate_uefi_var_policy = {
>@@ -80,32 +85,45 @@ static uefi_var_policy *wildcard_find_policy(uefi_vars_state *uv,
>     return NULL;
> }
>
>-static void calc_policy(uefi_var_policy *pol)
>+static int check_calc_policy(uefi_var_policy *pol)
> {
>     variable_policy_entry *pe = pol->entry;
>     unsigned int i;
>
>+    if (pol->entry_size != pe->size ||
>+        pe->offset_to_name >= pe->size) {
>+        return -1;
>+    }
>+
>     pol->name = (void *)pol->entry + pe->offset_to_name;
>     pol->name_size = pe->size - pe->offset_to_name;
>
>+    if (!uefi_str_is_valid(pol->name, pol->name_size, false)) {
>+        return -1;
>+    }
>+
>     for (i = 0; i < pol->name_size / 2; i++) {
>         if (pol->name[i] == '#') {
>             pol->hashmarks++;
>         }
>     }
>+
>+    return 0;
> }
>
> uefi_var_policy *uefi_vars_add_policy(uefi_vars_state *uv,
>                                       variable_policy_entry *pe)
> {
>     uefi_var_policy *pol, *p;
>+    int rc;
>
>     pol = g_new0(uefi_var_policy, 1);
>     pol->entry = g_malloc(pe->size);
>     memcpy(pol->entry, pe, pe->size);
>     pol->entry_size = pe->size;
>
>-    calc_policy(pol);
>+    rc = check_calc_policy(pol);
>+    g_assert(rc == 0);
>
>     /* keep list sorted by priority, add to tail of priority group */
>     QTAILQ_FOREACH(p, &uv->var_policies, next) {
>diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
>index fd07782f1e0d..e0ea3d532eb6 100644
>--- a/hw/uefi/var-service-vars.c
>+++ b/hw/uefi/var-service-vars.c
>@@ -47,6 +47,20 @@ static int uefi_vars_pre_load(void *opaque)
>     return 0;
> }
>
>+static int uefi_vars_post_load(void *opaque, int version_id)
>+{
>+    uefi_variable *var = opaque;
>+
>+    if (!uefi_str_is_valid(var->name, var->name_size, true) ||
>+        var->attributes & ~EFI_VARIABLE_ATTRIBUTE_SUPPORTED ||
>+        (var->digest_size != 0 &&
>+         var->digest_size != 32 /* AUTHVAR_DIGEST_SIZE */)) {

is it worth moving that define to a common header and using it here?

>+        error_report("invalid uefi variable");
>+        return -1;
>+    }
>+    return 0;
>+}
>+
> static bool uefi_vars_digest_is_needed(void *opaque)
> {
>     uefi_variable *var = opaque;
>@@ -72,6 +86,7 @@ const VMStateDescription vmstate_uefi_variable_digest = {
> const VMStateDescription vmstate_uefi_variable = {
>     .name = "uefi-variable",
>     .pre_load = uefi_vars_pre_load,
>+    .post_load = uefi_vars_post_load,
>     .fields = (VMStateField[]) {
>         VMSTATE_UINT8_ARRAY_V(guid.data, uefi_variable, sizeof(QemuUUID), 0),
>         VMSTATE_UINT32(name_size, uefi_variable),
>-- 
>2.55.0
>
>


