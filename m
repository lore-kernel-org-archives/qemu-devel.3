Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E52410AB822
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5sWY-0006T9-0G; Thu, 26 Mar 2026 17:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5sWW-0006Sw-O0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:45:52 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5sWU-0005xI-J7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:45:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D711221132;
 Thu, 26 Mar 2026 21:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774561549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3PY49rqrb3gZsoCVQ26efIKByZsntJlPggvKJ/pYdtU=;
 b=JdnBQaPWKe0rUXosPDFNP/QipJLr7QTsvneU05AHiFoC6Yvs1jEfMtPJBNwiQhoYUU3AzQ
 jUGJgF4qV6XolE8VsHWeiZcQ1ZLFYDkKBfKGyJzRvqyjG/ECOCRMqKIoBNyr7N33uUy97M
 o4UrlGUaBLv2amlzpTlM8xlSOsMNTkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774561549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3PY49rqrb3gZsoCVQ26efIKByZsntJlPggvKJ/pYdtU=;
 b=l92uuPw4+3kBw6fKdR/E1jWjEhKjQ0A+i26jSNGLEe/si9f6fpciCqnoppwu08PT42vZCy
 gSj74P99Wscjp8Ag==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qISt25N6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SXOtTtDp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774561548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3PY49rqrb3gZsoCVQ26efIKByZsntJlPggvKJ/pYdtU=;
 b=qISt25N6WkJ+g5EdEod5UAlN57l60qnSIdIaNslWjakprDLJkqe/ZIti0Vb0Ups5dZaj1i
 2rnIPclyKC+U0Z8d3bKvuzWpfdiZwO570nsRo2uVPPpv4DIXTsgFablgrnJa/cyvv16K+i
 XDlEbz1Lcoc6qfQTNPe3PwIffBd2zBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774561548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3PY49rqrb3gZsoCVQ26efIKByZsntJlPggvKJ/pYdtU=;
 b=SXOtTtDpQx4Vg7eB4xuC8nzkb3hACV8C7+MrA+78a/gRrYh1vTE9BvLRONhPAWxOQYoSfh
 Bp7Vil+5RjcartDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 757A44A0A3;
 Thu, 26 Mar 2026 21:45:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IFNwEQypxWnJZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 26 Mar 2026 21:45:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [RFC PATCH v1 12/17] vmstate: Introduce vmstate_next
In-Reply-To: <acVARwOjj5gJlmhr@x1.local>
References: <20260324194333.30004-1-farosas@suse.de>
 <20260324194333.30004-13-farosas@suse.de> <acVARwOjj5gJlmhr@x1.local>
Date: Thu, 26 Mar 2026 18:45:46 -0300
Message-ID: <871ph6jmd1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D711221132
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Mar 24, 2026 at 04:43:27PM -0300, Fabiano Rosas wrote:
>> Similarly to vmstate_first(), introduce a vmstate_next(), which does
>> the necessary dereferencing of pointers to get to the leaf element. On
>> the load side, allow the caller to pass a flag indicating whether
>> allocation is expected and call the allocation function if so.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/vmstate.c | 84 +++++++++++++++++++++------------------------
>>  1 file changed, 39 insertions(+), 45 deletions(-)
>> 
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index ab7c6fa4ab..c1ad0ef9a5 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -127,24 +127,51 @@ static void *vmstate_first(void *opaque, const VMStateField *field,
>>      return first;
>>  }
>>  
>> -static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
>> -                                    Error **errp)
>> +static void *vmstate_next(void **first, const VMStateField *field,
>> +                          int size, int i, bool alloc)
>>  {
>> -    int byte = qemu_get_byte(f);
>> +    void **array_elem;
>> +    void *next;
>> +
>> +    if (!(field->flags & VMS_ARRAY_OF_POINTER)) {
>> +        next = (void *)first + size * i;
>> +        return next;
>> +    }
>> +
>> +    array_elem = first + i;
>> +    next = *array_elem;
>> +
>> +    if (alloc) {
>> +        if (!next || field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
>> +            /*
>> +             * NOTE: do not use vmstate_size() here, because we
>> +             * need the object size, not entry size of the
>> +             * array.
>> +             */
>> +            next = vmstate_handle_alloc(array_elem, field->size, 1);
>> +        }
>> +    }
>> +    return next;
>> +}
>> +
>> +static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field)
>> +{
>> +    int byte = qemu_peek_byte(f, 0);
>
> Here, peeking the marker for ...
>
>>  
>>      if (byte == VMS_MARKER_PTR_NULL) {
>>          /* When it's a null ptr marker, do not continue the load */
>>          *load_field = false;
>> +        qemu_file_skip(f, 1);
>>          return true;
>>      }
>>  
>>      if (byte == VMS_MARKER_PTR_VALID) {
>>          /* We need to load this field right after the marker */
>>          *load_field = true;
>> +        qemu_file_skip(f, 1);
>>          return true;
>>      }
>>  
>> -    error_setg(errp, "Unexpected ptr marker: %d", byte);
>>      return false;
>>  }
>>  
>> @@ -273,41 +300,13 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
>>                  void *curr_elem;
>>  
>>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>
> ... every VMS_ARRAY_OF_POINTER case makes me feel uneasy.
>

There's 32k bytes in the buffer, this is likely to be just a
dereference. But fair enough.

> Note that we only have two use cases that both of them are certain on the
> upcoming byte to come:
>
> (1) for the null-only pointer, which is before this series introduced, both
> src/dst qemu knows 100% which ptr is NULL, so dest QEMU expects that 0x30
> for each null pointer.
>
> (2) for the new _AUTO_ALLOC introduced here, we also know exactly either
> 0x30 or 0x31 will come, and one of them must come before the real field
> dump.
>
> I think we may shoot us in the foot if we see 0x30 but in reality it's just
> the 1st byte of some array field's binary stream.
>

Yeah, that's a good point...

If you can put up with passing QEMUFile into vmstate_next(), we could
get the byte only when we're expecting it. Something like:

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 25fd9e52bc..16d9c1753f 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -137,7 +137,7 @@ static void *vmstate_first(void *opaque, const VMStateField *field,
 }
 
 static void *vmstate_next(void **first, const VMStateField *field,
-                          int size, int i, bool alloc)
+                          int size, int i, QEMUFile *f)
 {
     void **array_elem;
     void *next;
@@ -150,8 +150,11 @@ static void *vmstate_next(void **first, const VMStateField *field,
     array_elem = first + i;
     next = *array_elem;
 
-    if (alloc) {
-        if (!next || field->flags & VMS_ALLOC) {
+    if (f && (!next || field->flags & VMS_ALLOC)) {
+        bool alloc, ok;
+
+        ok = vmstate_ptr_marker_load(f, &alloc);
+        if (ok & alloc) {
             /*
              * NOTE: do not use vmstate_size() here, because we
              * need the object size, not entry size of the
@@ -315,18 +318,11 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                              !(field->flags & VMS_ARRAY_OF_POINTER));
 
         for (i = 0; i < n_elems; i++) {
-            /* If we will process the load of field? */
-            bool load_field = true;
             void *curr_elem;
 
-            if (field->flags & VMS_ARRAY_OF_POINTER) {
-                /* Peek a possible pointer marker instead of VMSD first */
-                ok = vmstate_ptr_marker_load(f, &load_field);
-            }
-
-            curr_elem = vmstate_next(head, field, size, i, load_field && ok);
+            curr_elem = vmstate_next(head, field, size, i, f);
 
-            if (load_field) {
+            if (curr_elem) {
                 ok = vmstate_load_field(f, curr_elem, size, field, errp);
             }
 
@@ -673,7 +669,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
 
         for (i = 0; i < n_elems; i++) {
             bool save_field = true;
-            void *curr_elem = vmstate_next(head, field, size, i, false);
+            void *curr_elem = vmstate_next(head, field, size, i, NULL);
             int max_elems = n_elems - i;
 
             if (field->flags & VMS_ARRAY_OF_POINTER) {
@@ -711,8 +707,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                         use_vmdesc = true;
 
                         for (int j = i + 1; j < n_elems; j++) {
-                            void *elem = vmstate_next(head, field, size, j,
-                                                      false);
+                            void *elem = vmstate_next(head, field, size, j, NULL);
                             bool elem_is_null = !elem;
 
                             if (is_null != elem_is_null) {
-- 
2.51.0


