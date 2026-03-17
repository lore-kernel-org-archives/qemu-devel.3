Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F36FF6E9D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dlR-0003yj-9U; Tue, 17 Mar 2026 19:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlP-0003yG-KC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlO-0006TD-3C
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773789829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4VIfJwVvQOqSfZotFMcnTmIgI+32r03PnWffChaegzo=;
 b=HjR4qz2WF4LHnee9t+E0fnux/CL2K83CK+OgOU8b45a0B1iUhvlHvyi9eMmLG+XqjWXgbK
 ajXpahQa+koN3bp4vBaLLNL8isKIFyXgYv5pAif/qFeIlxsETsaFCefv4d4zKUYEVDDul7
 j9ZF1uoLRJW2yMHcBVZRFcNUiUt82PU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-ZMTcE3RUPkWeuGF17uVYbw-1; Tue, 17 Mar 2026 19:23:48 -0400
X-MC-Unique: ZMTcE3RUPkWeuGF17uVYbw-1
X-Mimecast-MFC-AGG-ID: ZMTcE3RUPkWeuGF17uVYbw_1773789828
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5092033798eso237515481cf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773789827; x=1774394627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VIfJwVvQOqSfZotFMcnTmIgI+32r03PnWffChaegzo=;
 b=rPkuunHKf6dN8l1BlGe/TXzcqPbJ5IPv4FCsLcYigjgcqLURvxbNres6BbrkfCBYMH
 20ea774Tek0mpiGZIJ6+O/PpRkJiB+oDzBZdjqZiTgwBIs8X42ecihds+F49SOWSb4Wk
 Bg8GK+nYgo0sSpGbFvt5fXSIPsY77QwaQZU7FrdlDoXTQAQdYfpgY7qELUmqeVzHv+nv
 GbxX7R3sZPrfcDFJCrIV5Zjgc/EeO6iFT20/evkRxS3Wfw1cnwk9c60hS6hV2a10mxb3
 uv1IGQmKEcIlOeVrbL5T8l5Kjqdu+Z3HWYv4T377sQl4UMwdsLWd1+SDcuFmrtIpMKvR
 MCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789827; x=1774394627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4VIfJwVvQOqSfZotFMcnTmIgI+32r03PnWffChaegzo=;
 b=rGJwkTdbVRfIaFKokhmRe2OafW6mPmaCcT0R/Jm+eeX20T1hrfuT6ivPc1kRkWu013
 LIuIn9lJ0wSrvCxEX6d5ehfBeNQXacEDLMlXgK5pzpjNIgwS3oAxsongvLmjuD7kOxeR
 Eqpew7pV2ZzMvy3TBhQXOc7qHac2bnOs71Yl/hmg4Fq8FezU5HpLdre1cRjI5EhHf97t
 ZuID6C6O8VZeXvThhSf3rfcA5n82UAX8BJYNGpS/i+9zDxDf69zAH1wJvx3kEwsbjmYN
 zpTUuSTQ1rmMHNYi3Mx+pKO4D8plv42ignttKYHC4sJpjMTtphemD9LIlGlawxT+yKTZ
 IpnQ==
X-Gm-Message-State: AOJu0Yz160zvRLZZ1EJhM1k5sMEyaBxZLCCCtEkMGMdvyGuWcorEiiZz
 nY7UGzU3Z+O+0RHtCqykit4z5IrUkh0sdS/nIFyta5igYVzIlgr/9hNvKYbAIQvHWxeLAoCGwmb
 WQelUBcu2JueBwqL4Tn0rycvZViwCJpx0/ab+7NjpDHH7gAdM3Rlu45Te96w5XrPOLKsEVmZ306
 ZJUHMArVpxrIEDhLrMKoh5QaUD9Eh0l/FI0o0MaQ==
X-Gm-Gg: ATEYQzwuRYWZDd9STulXPOJ6/Q+iYErNV63Jww5T4RXefb1ehmnYUkQjLtaLMRTpw+X
 3tJy2hg0CM9WyLElbSmWSGyElCtsEo4lKY+K+Yvg9GyOc1WfUNERO/hkJ5hIbv+Ws+C+0srV4Pi
 E0IIq1O7QHlCbEvI0rFIlfW2StekCcZ/Qr2kpOl4P3UPwtXFu0W3dUbvDgnS9Yz19BbDPOckPHJ
 rJvj7vwFfiRu31d3LcqRXwMrwXojyHkVQ6x1xMrXFTT/CcL+lak5ky8g8jQT9tGXXFz3wfTBMbL
 wuzOkbHuLZ/BALG0BhBL7U07cZtY57TSC3zyYEDS1PJD85R9nv5+Q/kGqS2x1B/lt+rTl0dRDsp
 hvVSkpTAiYc+Zqw==
X-Received: by 2002:a05:620a:4081:b0:8cd:98c1:762e with SMTP id
 af79cd13be357-8cfad38a797mr207316985a.63.1773789827233; 
 Tue, 17 Mar 2026 16:23:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4081:b0:8cd:98c1:762e with SMTP id
 af79cd13be357-8cfad38a797mr207314385a.63.1773789826783; 
 Tue, 17 Mar 2026 16:23:46 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ea39asm8203806d6.37.2026.03.17.16.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:23:46 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH RFC 08/10] vmstate: Implement load of ptr marker in vmstate
 core
Date: Tue, 17 Mar 2026 19:23:30 -0400
Message-ID: <20260317232332.15209-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260317232332.15209-1-peterx@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The loader side of ptr marker is pretty straightforward, instead of playing
the inner_field trick, just do the load manually assuming the marker layout
is a stable ABI (which it is true already).

This will remove some logic while loading VMSD, and hopefully it makes it
slightly easier to read.  Unfortunately, we still need to keep the sender
side because of the JSON blob we're maintaining..

This paves way for future processing of non-NULL markers as well.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate-types.c | 12 ++++--------
 migration/vmstate.c       | 40 ++++++++++++++++++++++++---------------
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index b31689fc3c..ae465c5c2c 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -363,14 +363,10 @@ static bool load_ptr_marker(QEMUFile *f, void *pv, size_t size,
                             const VMStateField *field, Error **errp)
 
 {
-    int byte = qemu_get_byte(f);
-
-    if (byte == VMS_MARKER_PTR_NULL || byte == VMS_MARKER_PTR_VALID) {
-        /* TODO: process PTR_VALID case */
-        return true;
-    }
-
-    error_setg(errp, "%s: unexpected ptr marker: %d", __func__, byte);
+    /*
+     * Load is done in vmstate core, see vmstate_ptr_marker_load().
+     */
+    g_assert_not_reached();
     return false;
 }
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index a3a5f25946..d65fc84dfa 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -142,6 +142,21 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
     }
 }
 
+static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
+                                    Error **errp)
+{
+    int byte = qemu_get_byte(f);
+
+    if (byte == VMS_MARKER_PTR_NULL) {
+        /* When it's a null ptr marker, do not continue the load */
+        *load_field = false;
+        return true;
+    }
+
+    error_setg(errp, "Unexpected ptr marker: %d", byte);
+    return false;
+}
+
 static bool vmstate_pre_load(const VMStateDescription *vmsd, void *opaque,
                              Error **errp)
 {
@@ -264,30 +279,25 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             }
 
             for (i = 0; i < n_elems; i++) {
-                bool ok;
+                /* If we will process the load of field? */
+                bool load_field = true;
+                bool ok = true;
                 void *curr_elem = first_elem + size * i;
-                const VMStateField *inner_field;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     curr_elem = *(void **)curr_elem;
                 }
 
                 if (!curr_elem && size) {
-                    /*
-                     * If null pointer found (which should only happen in
-                     * an array of pointers), use null placeholder and do
-                     * not follow.
-                     */
-                    inner_field = vmsd_create_ptr_marker_field(field);
-                } else {
-                    inner_field = field;
+                    /* Read the marker instead of VMSD itself */
+                    if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
+                        trace_vmstate_load_field_error(field->name, -EINVAL);
+                        return false;
+                    }
                 }
 
-                ok = vmstate_load_field(f, curr_elem, size, inner_field, errp);
-
-                /* If we used a fake temp field.. free it now */
-                if (inner_field != field) {
-                    g_clear_pointer((gpointer *)&inner_field, g_free);
+                if (load_field) {
+                    ok = vmstate_load_field(f, curr_elem, size, field, errp);
                 }
 
                 if (ok) {
-- 
2.50.1


