Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64152C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 17:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTPrw-0004mV-Iu; Mon, 15 Jul 2024 13:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sTPrv-0004lu-1Y
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:52:11 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sTPrt-0006ge-I2
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:52:10 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 705D91F833;
 Mon, 15 Jul 2024 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721065927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gvv6QsC05O0yRUOL9IwASKdXg5sghzQCpN10VgcYfRY=;
 b=KCX4prKkJEs/4g3A7trba/HEPnJMtZB1G40nTffRDHbxoAk7lbaQfLfQGThBaopDb0OGgr
 2ACe52zIaOJsUWmtNZfNscG/8Z4oVTvrkkehvmWp5LGHJ7o/gN+8aFDHCEqS7Y6PL2f/bv
 B+WoxXtmklh/bjiJC0sUNSUOTcArvVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721065927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gvv6QsC05O0yRUOL9IwASKdXg5sghzQCpN10VgcYfRY=;
 b=ZcwbjmkJVNxZXUkgX5Y+v0kVGvxxSpT4sBtaqffBuiULS0XHseoTtDcECuq0b275A5CM2f
 V38+qW0r4OtZHnBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721065926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gvv6QsC05O0yRUOL9IwASKdXg5sghzQCpN10VgcYfRY=;
 b=bLWbYwY5zYOFMwBdT7AHFGo58QQUjgoeALUaKDKxUp3GcFCQZ/KARJG2nnwGSFHmQVSM+j
 j+ukoCogEK/2lMarDZjDhwQfeYAkK/D99NLM1HFt/wjZxllo61l+onRslpVlsP8U97+X3J
 2ICEEq8f/9jPVgEUBf1epl5ZHw441O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721065926;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gvv6QsC05O0yRUOL9IwASKdXg5sghzQCpN10VgcYfRY=;
 b=UalqbPFt/ctrgDUV83OA36Whsz39NECTX0mFXSVfEmpwv2Sf8qDmBmu6ZEm0MChiTyRBzY
 Mv/t5FLtRckjLBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9AD6137EB;
 Mon, 15 Jul 2024 17:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V8BnK8VhlWZnKgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Jul 2024 17:52:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
In-Reply-To: <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
Date: Mon, 15 Jul 2024 14:52:03 -0300
Message-ID: <87r0buczlo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.60 / 50.00]; BAYES_HAM(-1.80)[93.81%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org,oracle.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, oracle.com:email,
 suse.de:email]
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
> on the value of the anon-alloc machine property.  This affects
> memory-backend-ram objects, guest RAM created with the global -m option
> but without an associated memory-backend object and without the -mem-path
> option, and various memory regions such as ROMs that are allocated when
> devices are created.  This option does not affect memory-backend-file,
> memory-backend-memfd, or memory-backend-epc objects.
>
> The memfd option is intended to support new migration modes, in which the
> memory region can be transferred in place to a new QEMU process, by sending
> the memfd file descriptor to the process.  Memory contents are preserved,
> and if the mode also transfers device descriptors, then pages that are
> locked in memory for DMA remain locked.  This behavior is a pre-requisite
> for supporting vfio, vdpa, and iommufd devices with the new modes.
>
> To access the same memory in the old and new QEMU processes, the memory
> must be mapped shared.  Therefore, the implementation always sets
> RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
> user must explicitly specify the share option.  In lieu of defining a new
> RAM flag, at the lowest level the implementation uses RAM_SHARED with fd=-1
> as the condition for calling memfd_create.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

The commit message is inconsistent with alloc-anon, anon-alloc.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

