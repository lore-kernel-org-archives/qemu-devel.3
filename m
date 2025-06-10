Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B908EC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP33A-0007V4-Hi; Tue, 10 Jun 2025 13:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uP336-0007Uo-O0
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:46:12 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uP333-00008R-MH
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:46:12 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C4E3C1F88B;
 Tue, 10 Jun 2025 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749577563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7GaY2Yg/LmvKKE3HD4z3El4Czk7+nxv0l09c/j3MPo=;
 b=DWL4fOxRnkMKLx2eOcOGftlLWHbcYAzJLmY+ns2MUT3enIb68XYTlny/3RHSQvECl7QqCI
 DAj47edJWHY1hixlEgMDwV8HeU4jztl1BisYjLqhbDNUUbDZM0zaWn0Y+NeOfcuHy91rPE
 9l36ZpMPWF7kHR5wi/D4XM7JiQmyUrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749577563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7GaY2Yg/LmvKKE3HD4z3El4Czk7+nxv0l09c/j3MPo=;
 b=FgBcD+NacIZfOonVwN2CEq7ivdHAfCw7zUwblHuxRypsjKbYOt/4W1AkQgUIPbRzVHxNn6
 6jyQrQ1MhjlIrGCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749577563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7GaY2Yg/LmvKKE3HD4z3El4Czk7+nxv0l09c/j3MPo=;
 b=DWL4fOxRnkMKLx2eOcOGftlLWHbcYAzJLmY+ns2MUT3enIb68XYTlny/3RHSQvECl7QqCI
 DAj47edJWHY1hixlEgMDwV8HeU4jztl1BisYjLqhbDNUUbDZM0zaWn0Y+NeOfcuHy91rPE
 9l36ZpMPWF7kHR5wi/D4XM7JiQmyUrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749577563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7GaY2Yg/LmvKKE3HD4z3El4Czk7+nxv0l09c/j3MPo=;
 b=FgBcD+NacIZfOonVwN2CEq7ivdHAfCw7zUwblHuxRypsjKbYOt/4W1AkQgUIPbRzVHxNn6
 6jyQrQ1MhjlIrGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38C2A13964;
 Tue, 10 Jun 2025 17:46:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 98+FOVpvSGj9eAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Jun 2025 17:46:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com, "Dr. David Alan
 Gilbert" <dave@treblig.org>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] migration/postcopy: Add latency distribution report for
 blocktime
In-Reply-To: <20250609223607.34387-1-peterx@redhat.com>
References: <20250609223607.34387-1-peterx@redhat.com>
Date: Tue, 10 Jun 2025 14:46:00 -0300
Message-ID: <87msafv6av.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> Add the latency distribution too for blocktime, using order-of-two buckets.
> It accounts for all the faults, from either vCPU or non-vCPU threads.  With
> prior rework, it's very easy to achieve by adding an array to account for
> faults in each buckets.
>
> Sample output for HMP (while for QMP it's simply an array):
>
> Postcopy Latency Distribution:
>   [     1 us -     2 us ]:          0
>   [     2 us -     4 us ]:          0
>   [     4 us -     8 us ]:          1
>   [     8 us -    16 us ]:          2
>   [    16 us -    32 us ]:          2
>   [    32 us -    64 us ]:          3
>   [    64 us -   128 us ]:      10169
>   [   128 us -   256 us ]:      50151
>   [   256 us -   512 us ]:      12876
>   [   512 us -     1 ms ]:         97
>   [     1 ms -     2 ms ]:         42
>   [     2 ms -     4 ms ]:         44
>   [     4 ms -     8 ms ]:         93
>   [     8 ms -    16 ms ]:        138
>   [    16 ms -    32 ms ]:          0
>   [    32 ms -    65 ms ]:          0
>   [    65 ms -   131 ms ]:          0
>   [   131 ms -   262 ms ]:          0
>   [   262 ms -   524 ms ]:          0
>   [   524 ms -    1 sec ]:          0
>   [    1 sec -    2 sec ]:          0
>   [    2 sec -    4 sec ]:          0
>   [    4 sec -    8 sec ]:          0
>   [    8 sec -   16 sec ]:          0
>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

