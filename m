Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89782E9D834
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 13:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kOV-0008QA-0U; Mon, 06 Apr 2026 09:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w9kOT-0008Nc-Pq
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 09:53:33 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w9kOR-0002p7-NM
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 09:53:33 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E9D655BD83;
 Mon,  6 Apr 2026 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775483610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B/BDIEXwms1MmyfCOP+ti6+glHHoh4TDK5voKwhlUAo=;
 b=lYdQyTpvCSF3DMVmJqwSkpQFqhvZhWpzDeJ/pmNrThA9nhWW0oML6VgmpuXjZGqHsLYXiF
 c9rNH54BE+srY9NCaykPjhL369npzFIxPMmb0INkFpAQMc7/5QjzdSb6al4PxWUMudeUWN
 pfwCy5vbAkHV/Yh9LxDAa13VFqKM/KY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775483610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B/BDIEXwms1MmyfCOP+ti6+glHHoh4TDK5voKwhlUAo=;
 b=IURRBPJ8YDyHMN7R6f51B0V2wbIi8fhvhuTpGARV0DKXLxQbtrjIdMS14W7GPCX75B+gg8
 Yf9dq1ec39yKOmCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fRBLfheZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZVCaitUn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775483609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B/BDIEXwms1MmyfCOP+ti6+glHHoh4TDK5voKwhlUAo=;
 b=fRBLfheZRkD1I5UpJCi8guIObWqXGPSk8k5SJ5Hz0IDIuL3CgaoBadWWT8IfrUtN6SDXBi
 Cxph/BfF+CE9WmGAgbMFR2p466t+FJRAigobl+DXWSbLRX6g/Ud4REQtYulC/Nomkuqr5l
 yJoZGgZsLKYlhuZfGa41wCkc5Pbo+/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775483609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B/BDIEXwms1MmyfCOP+ti6+glHHoh4TDK5voKwhlUAo=;
 b=ZVCaitUnLQs8yDTWAanXSR1sY5p8NPaZ08E72ZkVxw58d+mvzqC+WzAdjftPkZ6TCb4bX8
 M3zeMJXegC0XJ/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D76C4A0B0;
 Mon,  6 Apr 2026 13:53:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 15xNDNm602lxUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 06 Apr 2026 13:53:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Trieu Huynh <vikingtc4@gmail.com>
Subject: Re: [PATCH v2] migration: validate page_size in mapped-ram header
 before use
In-Reply-To: <20260405094447.11347-1-viking4@gmail.com>
References: <20260405094447.11347-1-viking4@gmail.com>
Date: Mon, 06 Apr 2026 10:53:26 -0300
Message-ID: <87bjfw5h61.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E9D655BD83
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Trieu Huynh <vikingtc4@gmail.com> writes:

> From: Trieu Huynh <vikingtc4@gmail.com>
>
> mapped_ram_read_header() reads page_size from the migration stream and
> stores it in MappedRamHeader, but does not validate that the value is
> non-zero before it is later used in parse_ramblock_mapped_ram():
>
> num_pages = length / header.page_size;
>
> If a corrupted or malformed migration stream provides invalid, guest
> resumes either with corrupted memory or crashes unexpectedly (eg.
> page_size = 0)
>
> Add validation in mapped_ram_read_header() to reject invalid page_size
> values early and return an error instead of continuing with an invalid
> header.
>
> Steps to reproduce:
>
> Create a migration snapshot with mapped-ram enabled:
> (qemu) migrate_set_capability mapped-ram on
> (qemu) migrate file:/tmp/qemu-snapshots/snapshot.bin
> Modify the snapshot so that MappedRamHeader.page_size becomes diff with
> target psize. (0/512/8192/1GB).
> Restore the snapshot:
> (qemu) migrate_set_capability mapped-ram on
> (qemu) migrate_incoming file:/tmp/qemu-snapshots/snapshot.bin
>
> As-is:
> * [0]: Floating point exception (core dumped)
> * [512/8192]: Silent corruption
> * [1GB]: "post load hook failed for: kvm-tpr-opt" (EPERM)
> To-be:
> * All: qemu-system-x86_64: Migration mapped-ram header has invalid
>   page_size [val] (expected 4096)
>
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
> v2:
> - Replace == 0 check with != TARGET_PAGE_SIZE, which also catches
>   non-zero wrong values and matches the actual invariant of the
>   mapped-ram feature (suggested by Peter Xu)
> - Include actual and expected values in the error message
>
>  migration/ram.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 979751f61b..2046f16caa 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3088,6 +3088,12 @@ static bool mapped_ram_read_header(QEMUFile *file, MappedRamHeader *header,
>      }
>  
>      header->page_size = be64_to_cpu(header->page_size);
> +    if (header->page_size != TARGET_PAGE_SIZE) {
> +        error_setg(errp, "Migration mapped-ram header has invalid "
> +                   "page_size %" PRIu64 " (expected %d)",
> +                   header->page_size, TARGET_PAGE_SIZE);
> +        return false;
> +    }
>      header->bitmap_offset = be64_to_cpu(header->bitmap_offset);
>      header->pages_offset = be64_to_cpu(header->pages_offset);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

