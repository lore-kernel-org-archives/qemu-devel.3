Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5B5CE8D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 12:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srG1r-0000yn-3J; Thu, 19 Sep 2024 08:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1srG1i-0000xS-Ng
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:12:50 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1srG1f-0001vx-UN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:12:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D86B7208FE;
 Thu, 19 Sep 2024 12:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726747966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JeLJrCEIZqxB4WaioKG/nmlbbAvNA/mYV2Wlhns99u8=;
 b=KMfOG9gbkmRnFm05lJ3FYiesqU12j/uRKiTAlTewN+X1b580GAfdGMHTDk439NZX3O1qKB
 kZgrxnH56lIAbFr1c+PgMRQ+OrqyWWPxuWjWhkkd6eeNfiTGCoaOFa0L83bh+TvWX+bIZr
 a7M0EGW9nq+c4sLIwpNsdYveZjQimmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726747966;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JeLJrCEIZqxB4WaioKG/nmlbbAvNA/mYV2Wlhns99u8=;
 b=BvaqsEQ7WiCw2sDVtrh3bLnMcXee+ir0bHrJQymqpgkuILvl3rnTUB6h4o2DtkkzVR9oLd
 d9g/ZhHMctaOleDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CHKFWr+d;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fwv2q1QG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726747965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JeLJrCEIZqxB4WaioKG/nmlbbAvNA/mYV2Wlhns99u8=;
 b=CHKFWr+dhEsCt2seIlPDNM/pwx7lO6XPpAS7R28AE59ezGHaMSXmFW1E4W/0Z0/l8sWoPj
 R0shJ64jXIvrBqtr6REshYC7vf5aDNm9AjAz9IKK2AjlksH6+f4F+vVaKN6b8VcI5fC2Mz
 hDlioxX9M43ZbMmxuyyglSlMH9ETIfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726747965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JeLJrCEIZqxB4WaioKG/nmlbbAvNA/mYV2Wlhns99u8=;
 b=fwv2q1QGAivItpx7U+sxaXSGbDom+xJ40BNSFzPQkUBQfy1JgxzC6hBidyFpccCM+WmZaT
 /OCnm/ZwuT7A6QBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64C9813A5F;
 Thu, 19 Sep 2024 12:12:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iK1XCz0V7GYkJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 19 Sep 2024 12:12:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: dave@treblig.org, peterx@redhat.com, eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 3/3] migration: Remove unused
 socket_send_channel_create_sync
In-Reply-To: <20240918000207.182683-4-dave@treblig.org>
References: <20240918000207.182683-1-dave@treblig.org>
 <20240918000207.182683-4-dave@treblig.org>
Date: Thu, 19 Sep 2024 09:12:42 -0300
Message-ID: <87wmj7etad.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D86B7208FE
X-Spamd-Result: default: False [-5.81 / 50.00]; BAYES_HAM(-2.30)[96.71%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

dave@treblig.org writes:

> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
> socket_send_channel_create_sync only use was removed by
>   d0edb8a173 ("migration: Create the postcopy preempt channel asynchronously")
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

