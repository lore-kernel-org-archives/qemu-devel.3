Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B458CD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 18:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrMNl-0004ls-81; Mon, 01 Apr 2024 14:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rrMNj-0004lO-M4
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:27:43 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rrMNi-0002tw-01
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:27:43 -0400
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5EF292053A;
 Mon,  1 Apr 2024 18:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711996060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=F6XTXe7DjAH5FOtIiLnFOKnUim310rbHgWkhKk0yhgk=;
 b=0bDBwfgD/N1tSQpje/26uvqQKV0AKVFlJj3GDozARg96g5duMbHct9MvkRj1N4lZV2zhWB
 52/fel1eZxa1XBfmJetYrBy/1kiZUk6kStReNBCTWwWbvOQYFLWHPC/C+dfWMXm5Zn7lKS
 eAM2Q26sw5kj6DEEuYv8v/RGpzNG7lY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711996060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=F6XTXe7DjAH5FOtIiLnFOKnUim310rbHgWkhKk0yhgk=;
 b=qSIG3kT+zvsStHd0YczcdXl6Bv2cb/P+uHXjfsviWq82T7yW0+zv/7VEuE7J45Myc4REOF
 wjKA+lxsxAoor0Cw==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DEBC9139BE;
 Mon,  1 Apr 2024 18:27:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id CL3lKJv8CmbSewAAn2gu4w
 (envelope-from <farosas@suse.de>); Mon, 01 Apr 2024 18:27:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Advice on block QMP command coroutines
Date: Mon, 01 Apr 2024 15:27:37 -0300
Message-ID: <87bk6trl9i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi, I'm working on a v3 of my query-block series [1] and I'm a bit
confused about how to convert a QMP command into a coroutine.

In case you miss the context:

 In that series I'm turning query-block into a coroutine so we can avoid
 holding the BQL for too long in the case of a misbehaving (slow)
 syscall at the end of the call chain (get_allocated_file_size -> fstat
 in my case).

The issue:

After converting qmp_query_block into a coroutine, I'm hitting the
assert(false) bug at qcow2_get_specific_info() which was already fixed
for non-coroutines [2]. The bug was caused by qmp_query_block() running
during bdrv_activate_all():

bdrv_activate_all
  ...
  bdrv_invalidate_cache
    bdrv_poll_co
    |-> aio_co_enter
    |   ...
    |   qcow2_co_invalidate_cache
    |     memset(s, 0, ...)
    |     qcow2_do_open
    |       blk_co_pread
    |  	    ...
    |       qemu_coroutine_yield
    |-> AIO_WAIT_WHILE
    |   aio_poll
    |     reschedule of qmp_dispatch
    |     qmp_query_block
    |     ...
    |     qcow2_get_specific_info
    |       sees s->qcow_version == 0
    |       assert(false)
  
So my question is how do we expect to be able to convert a QMP command
into a coroutine if we're rescheduling all coroutines into
qemu_aio_context (at qmp_dispatch). I don't see how to avoid any
random aio_poll causing a dispatch of the coroutine in the middle of
something else.

If I keep the QMP command in the iohandler context, then the bug never
happens. Rescheduling back into the iohandler would also work, were it
not for the HMP path which only polls on qemu_aio_context and causes a
deadlock.

What's the recommended approach here?

Thank you

1- https://lore.kernel.org/r/20230609201910.12100-1-farosas@suse.de
2- https://gitlab.com/qemu-project/qemu/-/issues/1933

