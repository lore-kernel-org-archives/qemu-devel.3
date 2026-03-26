Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B84110A62CB
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5kVu-0007QK-9v; Thu, 26 Mar 2026 09:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5kVt-0007QC-HO
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:12:41 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5kVs-0008Vz-2Y
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:12:41 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 02E7F4D28D;
 Thu, 26 Mar 2026 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774530757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WwknhYiHos1CTbSQkw8NOQzVjWnrm3zKn5osbihUjek=;
 b=nFUWDCZ84yoK/FPYc+uFS5/n38bd27LX8llXJbOiChl8o9p9rMaQ4hvUR5SiFPg4FB/QCz
 USoJvDpKKlB9QGciAQdkalg1UBgs8KA7xaw6kZmBFlplzMl8fYxtJ0NMQMSTCbRp5WNA+B
 slAYv7jgQiIBz8Zd+zQcfSbn01T8dEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774530757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WwknhYiHos1CTbSQkw8NOQzVjWnrm3zKn5osbihUjek=;
 b=UfmkH4AY15T8WSkr/BK7OSFkrqgcUqROYWWK2xBwzMAUKOyBSHvSoAQC8nvuvsnUp8BeoJ
 Y4w6e5IrMh8r8NBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774530757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WwknhYiHos1CTbSQkw8NOQzVjWnrm3zKn5osbihUjek=;
 b=nFUWDCZ84yoK/FPYc+uFS5/n38bd27LX8llXJbOiChl8o9p9rMaQ4hvUR5SiFPg4FB/QCz
 USoJvDpKKlB9QGciAQdkalg1UBgs8KA7xaw6kZmBFlplzMl8fYxtJ0NMQMSTCbRp5WNA+B
 slAYv7jgQiIBz8Zd+zQcfSbn01T8dEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774530757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WwknhYiHos1CTbSQkw8NOQzVjWnrm3zKn5osbihUjek=;
 b=UfmkH4AY15T8WSkr/BK7OSFkrqgcUqROYWWK2xBwzMAUKOyBSHvSoAQC8nvuvsnUp8BeoJ
 Y4w6e5IrMh8r8NBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ADDB4A0A3;
 Thu, 26 Mar 2026 13:12:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X1BhFcQwxWmQVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 26 Mar 2026 13:12:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: Re: [PATCH 0/3] migration: Fix a few error messages and a bit of help
In-Reply-To: <20260326074247.188674-1-armbru@redhat.com>
References: <20260326074247.188674-1-armbru@redhat.com>
Date: Thu, 26 Mar 2026 10:12:33 -0300
Message-ID: <87fr5mka4e.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.24 / 50.00]; BAYES_HAM(-2.94)[99.75%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Markus Armbruster <armbru@redhat.com> writes:

> Markus Armbruster (3):
>   migration: Fix up error message for max-cpu-throttle
>   migration: Fix references to parameter names in error messages
>   migration: Tweak description of migration property multifd-compression
>
>  hw/core/qdev-properties-system.c |  2 +-
>  migration/options.c              | 36 ++++++++++++++++----------------
>  2 files changed, 19 insertions(+), 19 deletions(-)

Thanks!

Queued into migration-staging.

