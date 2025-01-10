Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA70E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDuo-0001YQ-Lv; Fri, 10 Jan 2025 07:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuk-0001XK-Is
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:58 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDui-0003OY-O6
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:58 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F74921176;
 Fri, 10 Jan 2025 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVDI45gdiEGtXAOMc3OL04fOkXME/7ISgZgarb4k/XY=;
 b=vsbc/vdBlgvJnKrbNiVVuQoniiUC+J/lvBT75nNf1OJo5y0nF/lHaIDImIu48oXwxjH0rQ
 t9wqG8Ofqf9b5vDgMhPRKpXRRmDx2cq+drclpP4CzgSpxNz1L94qRvuTZhTkaoHfPp4Z09
 M03WVEUAMjF/EuVCvrx65kCtRBk1l3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVDI45gdiEGtXAOMc3OL04fOkXME/7ISgZgarb4k/XY=;
 b=on8VgcCvKHqgriekeSkeDAZwxlNAQXOX/jNn9b3hyzBQHxoA6loP+gKRHgbxILMrmqO5j5
 FQWD4fnLlWYjtaBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVDI45gdiEGtXAOMc3OL04fOkXME/7ISgZgarb4k/XY=;
 b=vsbc/vdBlgvJnKrbNiVVuQoniiUC+J/lvBT75nNf1OJo5y0nF/lHaIDImIu48oXwxjH0rQ
 t9wqG8Ofqf9b5vDgMhPRKpXRRmDx2cq+drclpP4CzgSpxNz1L94qRvuTZhTkaoHfPp4Z09
 M03WVEUAMjF/EuVCvrx65kCtRBk1l3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVDI45gdiEGtXAOMc3OL04fOkXME/7ISgZgarb4k/XY=;
 b=on8VgcCvKHqgriekeSkeDAZwxlNAQXOX/jNn9b3hyzBQHxoA6loP+gKRHgbxILMrmqO5j5
 FQWD4fnLlWYjtaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 184DE13A86;
 Fri, 10 Jan 2025 12:14:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OIiOMzwPgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Yuan Liu <yuan1.liu@intel.com>,
 Jason Zeng <jason.zeng@intel.com>
Subject: [PULL 24/25] multifd: bugfix for incorrect migration data with QPL
 compression
Date: Fri, 10 Jan 2025 09:14:12 -0300
Message-Id: <20250110121413.12336-25-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yuan Liu <yuan1.liu@intel.com>

When QPL compression is enabled on the migration channel and the same
dirty page changes from a normal page to a zero page in the iterative
memory copy, the dirty page will not be updated to a zero page again
on the target side, resulting in incorrect memory data on the source
and target sides.

The root cause is that the target side does not record the normal pages
to the receivedmap.

The solution is to add ramblock_recv_bitmap_set_offset in target side
to record the normal pages.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Jason Zeng <jason.zeng@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20241218091413.140396-3-yuan1.liu@intel.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-qpl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index bbe466617f..88e2344af2 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -679,6 +679,7 @@ static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
         qpl->zlen[i] = be32_to_cpu(qpl->zlen[i]);
         assert(qpl->zlen[i] <= multifd_ram_page_size());
         zbuf_len += qpl->zlen[i];
+        ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
     }
 
     /* read compressed pages */
-- 
2.35.3


