Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F15BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weY0Z-0001v6-RN; Tue, 30 Jun 2026 08:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1weY0M-0001pu-6B
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 08:55:59 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1weY0K-0007jW-Jk
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 08:55:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17C8F71740;
 Tue, 30 Jun 2026 12:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782824152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/GRPIYfgHrUE/A4WM0JqKRRV2/8oe7CdCE6JiMa17BE=;
 b=KnSzowWdrCaH52EDQvfM5VNL03kLWyK65zGB4a7UtNDmfVOBK/dAqGbpdYTsETtEiD6DQS
 UPrLm/t3ALqlnzQWU9OVkP5Tz4YBHFI8skpu/MsRUfA1JD5PkC/bWah/79MMMX0hdC+Kyj
 ZeXzAuDidgt+k3o++WJc1uYgRK59T/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782824152;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/GRPIYfgHrUE/A4WM0JqKRRV2/8oe7CdCE6JiMa17BE=;
 b=YsTBH/IVP339oT5kzEfG6bFosRAGAjyD1hPgIRsXNUybuVnnMU+qwp49rnphbQaVdj+cJi
 F3PZOJ1q02u4oZCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782824151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/GRPIYfgHrUE/A4WM0JqKRRV2/8oe7CdCE6JiMa17BE=;
 b=XlzUbMh6ndpe4MLwmEfPNFd+UTB/I9cofof1Va5vn9plP4Rza3HaXv4c/401HBVv8FcsaK
 lum9AR3T9G3wLGPfMPgcLjhoFiPDWRnUYZZH1mba5Wz3GZou9/d6DcQfOtSJwae9vQY7UT
 XPhQDadKbjA9KQVBaA/16wxHp0OhE9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782824151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/GRPIYfgHrUE/A4WM0JqKRRV2/8oe7CdCE6JiMa17BE=;
 b=EL5iJC8A5sPLbScQS/ZPqQttWMpy7C5f/l+RzJhaB5k8qsdsh1ZCGVv4LJy7vxDzEYFmZ9
 AnLgC4s3BdZOUyBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC277779A8;
 Tue, 30 Jun 2026 12:55:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uWsqH9a8Q2riIgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 30 Jun 2026 12:55:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: yujun <yujun@kylinos.cn>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix invalid %ud format and trace arg typo
In-Reply-To: <20260630031324.43453-1-yujun@kylinos.cn>
References: <20260630031324.43453-1-yujun@kylinos.cn>
Date: Tue, 30 Jun 2026 09:55:40 -0300
Message-ID: <8733y4ur03.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

yujun <yujun@kylinos.cn> writes:

> Standard printf has no %ud conversion; glibc treats it as %u followed
> by a literal 'd', so postcopy userfaultfd error messages printed event
> values like "5d" instead of "5".  The same typo existed in two postcopy
> discard trace format strings.
>
> Also rename the misspelled ram_save_iterate_big_wait() trace argument
> milliconds to milliseconds.
>
> Fixes: 00fa4fc85b ("postcopy: Allow registering of fd handler")
> Signed-off-by: yujun <yujun@kylinos.cn>
> ---
>  migration/postcopy-ram.c | 4 ++--
>  migration/trace-events   | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index f5ef93f193..980b938a4c 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1368,7 +1368,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
>                  }
>              }
>              if (msg.event != UFFD_EVENT_PAGEFAULT) {
> -                error_report("%s: Read unexpected event %ud from userfaultfd",
> +                error_report("%s: Read unexpected event %u from userfaultfd",
>                               __func__, msg.event);
>                  continue; /* It's not a page fault, shouldn't happen */
>              }
> @@ -1443,7 +1443,7 @@ retry:
>                      }
>                  }
>                  if (msg.event != UFFD_EVENT_PAGEFAULT) {
> -                    error_report("%s: Read unexpected event %ud "
> +                    error_report("%s: Read unexpected event %u "
>                                   "from userfaultfd (shared)",
>                                   __func__, msg.event);
>                      continue; /* It's not a page fault, shouldn't happen */
> diff --git a/migration/trace-events b/migration/trace-events
> index de99d976ab..3b1258c3bf 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -21,14 +21,14 @@ loadvm_postcopy_handle_run(void) ""
>  loadvm_postcopy_handle_resume(void) ""
>  loadvm_postcopy_ram_handle_discard(void) ""
>  loadvm_postcopy_ram_handle_discard_end(void) ""
> -loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
> +loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %u"
>  loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
>  loadvm_process_command_ping(uint32_t val) "0x%x"
>  loadvm_approve_switchover(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>  postcopy_ram_listen_thread_exit(void) ""
>  postcopy_ram_listen_thread_start(void) ""
>  qemu_savevm_send_postcopy_advise(void) ""
> -qemu_savevm_send_postcopy_ram_discard(const char *id, uint16_t len) "%s: %ud"
> +qemu_savevm_send_postcopy_ram_discard(const char *id, uint16_t len) "%s: %u"
>  savevm_command_send(uint16_t command, uint16_t len) "com=0x%x len=%d"
>  savevm_section_start(const char *id, unsigned int section_id) "%s, section_id %u"
>  savevm_section_end(const char *id, unsigned int section_id, int ret) "%s, section_id %u -> %d"
> @@ -119,7 +119,7 @@ colo_flush_ram_cache_begin(uint64_t dirty_pages) "dirty_pages %" PRIu64
>  colo_flush_ram_cache_end(void) ""
>  save_xbzrle_page_skipping(void) ""
>  save_xbzrle_page_overflow(void) ""
> -ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
> +ram_save_iterate_big_wait(uint64_t milliseconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
>  ram_load_start(void) ""
>  ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
>  ram_write_tracking_ramblock_start(const char *block_id, size_t page_size, void *addr, size_t length) "%s: page_size: %zu addr: %p length: %zu"

Reviewed-by: Fabiano Rosas <farosas@suse.de>

