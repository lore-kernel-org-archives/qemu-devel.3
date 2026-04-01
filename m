Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73F910FCACE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82BS-0004LW-EX; Wed, 01 Apr 2026 16:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BN-0004Iq-7n
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BL-00038L-L3
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775075334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IOjsPMjPyjOOz0u/cqBKLuI7wgBm8OXlBH7YynEYGUs=;
 b=BrglIskrPlem+KXA7YI8Z5hB7vqkedFQxk4EkUViWRXTkLPRAqsjNve9s9glti0IeGDNtD
 r0wZGmM1ZX68KhK2X5b8KA5CNQH5QbqA9UAMYtEzM/gqESgbyCov/b0QZqkWA7Izw846dN
 q1VxQJfB7siL/hWXSX+NHfB67l6QEo4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-v5t523EJNPyF4FZnUh1riw-1; Wed, 01 Apr 2026 16:28:53 -0400
X-MC-Unique: v5t523EJNPyF4FZnUh1riw-1
X-Mimecast-MFC-AGG-ID: v5t523EJNPyF4FZnUh1riw_1775075333
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd7c4ab845so46079685a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775075332; x=1775680132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOjsPMjPyjOOz0u/cqBKLuI7wgBm8OXlBH7YynEYGUs=;
 b=nVniMVfhIEW+OlLuxUfRc5GDXv8FRi6KmO51EoBibumEeAoCui2wGyokv2KLa1SGm3
 IJlphZ9zbq6CrwHPETkcDfSBRGmnEjQYCxqYCTv+nh40LgpwVaR6Gj3sgweq6FFrIWyQ
 2I8ENmhqHzwarrb1IT/VwxqkFDKwE0g74cHRInxNpzEN1zqjdot0ktZk5z9q1ZZ2y4d5
 xOtq4MVs/RZu/8jDB48IXlZAOIxhfgqYiO23Mf5ot7eT3xlLpvEGLrIMwJ7I7T5kxPk4
 f+Uf8C9L2FE29Jwe5pOrMtjZE02EZdZPcyTHm7OlOaVD6mJ4OsVdDX/ozTHswMurReCX
 BJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075332; x=1775680132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IOjsPMjPyjOOz0u/cqBKLuI7wgBm8OXlBH7YynEYGUs=;
 b=FjYChUxmePp0642ch49Fl+64r4rFfHvsyWDY0ur1EArDnlXHB7rDYH9HC4ss3wS8+L
 2wzHoLaM6Woaqc5EpuTF61dZVtU5NI5M9j/NgezbYqqNZH4XHbP4eW2vL/S32n36ZjYz
 cQyXhQGmM/cmfDagtXKWCguppg8yxIXtv2pk2US5DvRFBc8udj/fER3yTvLWYdMLmbHc
 CgBI4LjRZU1iYshkLnVtU5JP7QsG3Uv7eiQHLKoOb+O1vLdkkdmeTC2QHX/KLLh1yaQW
 w/N34QXMX6Ts6uCYTgEYrIV3db1bHXvx+bH7AFhBVA9VnsB8OHdXA6C1rEN+pi5F91WK
 d3gw==
X-Gm-Message-State: AOJu0YxOLWlwWTAUO5wDObADPuqI3kD4SFY8xaGb7c8VVeFoQma9oLni
 8cOuucTw4OCAAgLR9iq1W4sLtBey2WUDtea296xv9kQxNVrdxkpqQvlWSxKRuKw12S7ueuOx5To
 14FXmoXi7voguzvNt0GpHGGAu3dIfFGsyfRRUOycUCEFm43gfZsJdX1LrUTSzcLjco1BW3VuUjT
 QKfNoyAS+tRgMPVyr+ZaFSIUHl1OnouFThgLiVLw==
X-Gm-Gg: ATEYQzxlv4GCemclOiRxUUAdRygDtnC0sZ0wy3JbJZ9igNH7wwou9Gu9P3dFI/0cLyk
 fBYlQv7ZpppLIBgZ9Fnav0GJ5Q6p577n3yamDlVGPZAdy8Ql4H7wHnshmviqLFfCivj5KTzSQLL
 m2MbaVQLRI7hY+kn8u3N991B+9uNEy0482tApV/qbu5g4knb7kwd3LZphjapK1P7ph2S+jPzqLL
 7MX3fXayoscItalvdpQGq1yeUpBSsVhM6PINyIsECo5o0b76K61L9Oi5gGNjKsa4K4BFixfOIVx
 ewXOSSKORpXRAwhfiIHjJAk1sIn8AxFbk4l+NXFI5irY961sfZDUlB832sxpQ+0ctjr3bPE6SGN
 czpeItyCx6mXBWk5wXnYzxdEpeFHAxFzc4jYIEfdCqbw=
X-Received: by 2002:a05:620a:2844:b0:8cf:e0fe:f227 with SMTP id
 af79cd13be357-8d2aa3b805fmr145170285a.26.1775075332419; 
 Wed, 01 Apr 2026 13:28:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2844:b0:8cf:e0fe:f227 with SMTP id
 af79cd13be357-8d2aa3b805fmr145165085a.26.1775075331771; 
 Wed, 01 Apr 2026 13:28:51 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a548a4efsm68194085a.8.2026.04.01.13.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:28:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 04/11] vmstate: Update max_elems early and check field
 compressable once
Date: Wed,  1 Apr 2026 16:28:37 -0400
Message-ID: <20260401202844.673494-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401202844.673494-1-peterx@redhat.com>
References: <20260401202844.673494-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

QEMU has a trick in vmstate_save_vmsd_v(), where it will try to compress
multiple JSON entries into one with a count to avoid duplicated entries.

That only applies to the cases where vmsd_can_compress() should return
true.  For example, vmsd_desc_field_start() later (who will take the
updated max_elems as the last parameter) will ignore the value passed in
when vmsd_can_compress() returns false.

Do that check once at the start of loop, and use it to update max_elems, so
that max_elems keeps 1 for uncompressable VMSD fields, which is more
straightforward.

This also paves way to make this counter work for ptr marker VMSD fields
too.

No functional change intended in this patch alone.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index e29a8c3f49..05badef42f 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -556,7 +556,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
                 bool is_null;
-                int max_elems = n_elems - i;
+                /* maximum number of elements to compress in the JSON blob */
+                int max_elems = vmsd_can_compress(field) ? (n_elems - i) : 1;
 
                 old_offset = qemu_file_transferred(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
@@ -587,7 +588,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                  * vs. nullptr). Search ahead for the next null/non-null element
                  * and start a new compressed array if found.
                  */
-                if (vmdesc && (field->flags & VMS_ARRAY_OF_POINTER) &&
+                if (vmdesc && max_elems > 1 &&
+                    (field->flags & VMS_ARRAY_OF_POINTER) &&
                     is_null != is_prev_null) {
 
                     is_prev_null = is_null;
@@ -626,7 +628,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 /* Compressed arrays only care about the first element */
-                if (vmdesc_loop && vmsd_can_compress(field)) {
+                if (vmdesc_loop && max_elems > 1) {
                     vmdesc_loop = NULL;
                 }
             }
-- 
2.50.1


