Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DD7E68171
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 13:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsKnj-0004Yc-8R; Tue, 17 Feb 2026 08:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsKnh-0004YG-Ag
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 08:07:37 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsKnf-0003Ux-Fr
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 08:07:36 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC0A13E70B;
 Tue, 17 Feb 2026 13:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771333652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AcekFjMTaYaXiQIMq4+AFc1ry7354yp+rjxi27TamZs=;
 b=r7Dj/mh5B0fLC036AaKf0GyIrOMKD1cAcq8ezPXkDDku77C/LjZtTGgUUl8t2NHowG7UeA
 LHkwdMmtB3V+vVynDT6qGZXEAceXsK2773fa2tEhZq77yXZWBnjzImw4Ww258W15DPaXim
 Lnr9KLjH3/ihvlb6gqKQ0yuzXp9YpsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771333652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AcekFjMTaYaXiQIMq4+AFc1ry7354yp+rjxi27TamZs=;
 b=N0P4Hdd2SLDjitN+a1LexiNnW0TqcfigI1AjAJ1kl1B/JqMzLO2/Pm26XgsEp/9SO+vVnc
 7Wl/bPlH6sr0XoAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="r7Dj/mh5";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N0P4Hdd2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771333652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AcekFjMTaYaXiQIMq4+AFc1ry7354yp+rjxi27TamZs=;
 b=r7Dj/mh5B0fLC036AaKf0GyIrOMKD1cAcq8ezPXkDDku77C/LjZtTGgUUl8t2NHowG7UeA
 LHkwdMmtB3V+vVynDT6qGZXEAceXsK2773fa2tEhZq77yXZWBnjzImw4Ww258W15DPaXim
 Lnr9KLjH3/ihvlb6gqKQ0yuzXp9YpsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771333652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AcekFjMTaYaXiQIMq4+AFc1ry7354yp+rjxi27TamZs=;
 b=N0P4Hdd2SLDjitN+a1LexiNnW0TqcfigI1AjAJ1kl1B/JqMzLO2/Pm26XgsEp/9SO+vVnc
 7Wl/bPlH6sr0XoAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F58F3EA65;
 Tue, 17 Feb 2026 13:07:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0vOFBRRolGnsRQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 13:07:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Markus Armbruster <armbru@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v8 17/17] qemu-colo.rst: Simplify the block replication
 setup
In-Reply-To: <20260210-colo_unit_test_multifd-v8-17-7f9e5f7d082b@web.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
 <20260210-colo_unit_test_multifd-v8-17-7f9e5f7d082b@web.de>
Date: Tue, 17 Feb 2026 10:07:29 -0300
Message-ID: <87h5rfmsby.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.47 / 50.00]; BAYES_HAM(-2.96)[99.84%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[web.de,nongnu.org]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,xfusion.com,fujitsu.com,treblig.org,web.de];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[11]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim, suse.de:email]
X-Rspamd-Queue-Id: DC0A13E70B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Lukas Straub <lukasstraub2@web.de> writes:

> On the primary side we don't actually need the replication
> block driver, since it only passes trough all IO.
> So simplify the setup and also use 'blockdev-add' instead of
> 'human-monitor-command'.
>
> This is how my clients use colo in production.
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  docs/system/qemu-colo.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
> index 75abbd80298df79223cb8e70064a5dc83d70f4eb..f7d3b6439cf3401a58c412634239d1a43999a10e 100644
> --- a/docs/system/qemu-colo.rst
> +++ b/docs/system/qemu-colo.rst
> @@ -240,8 +240,8 @@ Note:
>  **4.** On Primary VM's QEMU monitor, issue command::
>  
>      {"execute":"qmp_capabilities"}
> -    {"execute": "human-monitor-command", "arguments": {"command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.2,file.port=9999,file.export=parent0,node-name=replication0"}}
> -    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0", "node": "replication0" } }
> +    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}, "export": "parent0", "detect-zeroes": "on"} }
> +    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0", "node": "nbd0" } }
>      {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "x-colo", "state": true } ] } }
>      {"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
>  
> @@ -269,7 +269,7 @@ Primary Failover
>  The Secondary died, resume on the Primary::
>  
>      {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "child": "children.1"} }
> -    {"execute": "human-monitor-command", "arguments":{ "command-line": "drive_del replication0" } }
> +    {"execute": "blockdev-del", "arguments": {"node-name": "nbd0"} }
>      {"execute": "object-del", "arguments":{ "id": "comp0" } }
>      {"execute": "object-del", "arguments":{ "id": "iothread1" } }
>      {"execute": "object-del", "arguments":{ "id": "m0" } }
> @@ -309,8 +309,8 @@ Wait until disk is synced, then::
>      {"execute": "stop"}
>      {"execute": "block-job-cancel", "arguments":{ "device": "resync"} }
>  
> -    {"execute": "human-monitor-command", "arguments":{ "command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.2,file.port=9999,file.export=parent0,node-name=replication0"}}
> -    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "node": "replication0" } }
> +    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}, "export": "parent0", "detect-zeroes": "on"} }
> +    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "node": "nbd0" } }
>  
>      {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", "id": "m0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
>      {"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", "id": "redire0", "netdev": "hn0", "queue": "rx", "indev": "compare_out" } }
> @@ -341,8 +341,8 @@ Wait until disk is synced, then::
>      {"execute": "stop"}
>      {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
>  
> -    {"execute": "human-monitor-command", "arguments":{ "command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.1,file.port=9999,file.export=parent0,node-name=replication0"}}
> -    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "node": "replication0" } }
> +    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name": "nbd0", "server": {"type": "inet", "host": "127.0.0.1", "port": "9999"}, "export": "parent0", "detect-zeroes": "on"} }
> +    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "node": "nbd0" } }
>  
>      {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", "id": "m0", "insert": "before", "position": "id=rew0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
>      {"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", "id": "redire0", "insert": "before", "position": "id=rew0", "netdev": "hn0", "queue": "rx", "indev": "compare_out" } }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

