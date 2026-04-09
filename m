Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176BFEA3C5E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAp1I-0006Yy-4S; Thu, 09 Apr 2026 09:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wAp1B-0006Xn-E0
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:01:57 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wAp19-0001Gl-Qm
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:01:57 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C54686A7CC;
 Thu,  9 Apr 2026 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775739710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nw4bv4HCC0b1u7UIB6a6YYq+wepQnD3SGB7wXKl7euk=;
 b=2Ljk0I43O0rB3jwttD7hrK3SAJL/OB/c1Fi/18P6zC8NO94tnWXTRsikIk1lgqW7gU7rRZ
 RFvgbTu2ezk+h0nFsjx9btmdi8LndwVDjhZP5SA//5wuNwpm3RkhtmuEPDiMkBLBAGS9+E
 Xbffqu0S0fetzMUS78uZ3EeJ8Z8/LwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775739710;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nw4bv4HCC0b1u7UIB6a6YYq+wepQnD3SGB7wXKl7euk=;
 b=0sO+btA8PPKG+90GjdP1z5rL4kayilsaqM/TTx/UTkLeakbzi6xaC6IiEix1kPQtiq7ilc
 yRDCg3nYQyixUUBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=M5cfSYo0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rhkd5Jj3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775739705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nw4bv4HCC0b1u7UIB6a6YYq+wepQnD3SGB7wXKl7euk=;
 b=M5cfSYo0kosMy80gqPGw94w7ZMYcrxHuEFqzfP7ZhlFzkDdRdBPFnhso9mp72Z0VeOphP7
 9/nNRtULsZ0kqNxdNpV/F4puNHpYtLW2FD4Ww6dBjRXIMLXbDaCFKNZIRCO3PO0vJKlQwX
 YvHeodFWxCOgudjBfN8yF33lUy6Hh34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775739705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nw4bv4HCC0b1u7UIB6a6YYq+wepQnD3SGB7wXKl7euk=;
 b=rhkd5Jj3A9TLXzunzH9YTYujg15bIslkST5sO+jairkTB1DEfk9Czvluisy88xiuD7+Zii
 ebBEPIRzE1BBpxBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 581204A0B3;
 Thu,  9 Apr 2026 13:01:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oAc5CTmj12krJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Apr 2026 13:01:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Christian Brauner <brauner@kernel.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 4/5] tests/qtest: add tests for dynamic monitor
 add/remove
In-Reply-To: <20260409-work-qmp-monitor-hotplug-v4-4-89c4fdf69df1@kernel.org>
References: <20260409-work-qmp-monitor-hotplug-v4-0-89c4fdf69df1@kernel.org>
 <20260409-work-qmp-monitor-hotplug-v4-4-89c4fdf69df1@kernel.org>
Date: Thu, 09 Apr 2026 10:01:43 -0300
Message-ID: <875x605lu0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.96 / 50.00]; BAYES_HAM(-2.95)[99.81%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10]; TAGGED_RCPT(0.00)[qemu];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C54686A7CC
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

Christian Brauner <brauner@kernel.org> writes:

> Test the monitor-add, monitor-remove, and query-monitors QMP commands:
>
> - Basic lifecycle: chardev-add -> monitor-add -> query-monitors ->
>   monitor-remove -> chardev-remove
> - Error: duplicate monitor id
> - Error: monitor-remove on nonexistent id
> - Error: monitor-add with nonexistent chardev
> - Error: second monitor on same chardev (chardev already in use)
> - Removal of CLI-created QMP monitor succeeds
> - Error: monitor-remove on HMP monitor
> - Re-add after remove: same id and chardev reusable after removal
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

