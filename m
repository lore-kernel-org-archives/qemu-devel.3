Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448ABC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 21:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Ryz-0001hE-Kv; Tue, 07 May 2024 17:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4Ryw-0001aa-EK
 for qemu-devel@nongnu.org; Tue, 07 May 2024 17:04:14 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4Ryi-0003jh-U9
 for qemu-devel@nongnu.org; Tue, 07 May 2024 17:04:14 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 376055BD38;
 Tue,  7 May 2024 21:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715115839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rRqkJbti4o/uw7dESQcGbPAnBlfMo4z2G6mt5iHvOPI=;
 b=A3tHKV2468S7CUNQ7U5BSLdj8aH0nZ1inLs1wvm/67xG2B69E5tRxOwIv/plfsOwBZTO1K
 3095Ue1TTwsO1Let0CiJdq7N+A9WaOefFQtESYRPeLoRNVUDsxdlTHfjAsb653oMfaZ0AK
 qzS34Tj04jZ88fXzIbeUdUgjPqD5SRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715115839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rRqkJbti4o/uw7dESQcGbPAnBlfMo4z2G6mt5iHvOPI=;
 b=v4vElHvAYyIz+iBWsjb7fgG3i/kSsAnQm3C/5vBbgbOWMNAHV7NeBukiiIV3vxKbMdrJLR
 3RdcjDbAGs4ZfnDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A3tHKV24;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v4vElHvA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715115839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rRqkJbti4o/uw7dESQcGbPAnBlfMo4z2G6mt5iHvOPI=;
 b=A3tHKV2468S7CUNQ7U5BSLdj8aH0nZ1inLs1wvm/67xG2B69E5tRxOwIv/plfsOwBZTO1K
 3095Ue1TTwsO1Let0CiJdq7N+A9WaOefFQtESYRPeLoRNVUDsxdlTHfjAsb653oMfaZ0AK
 qzS34Tj04jZ88fXzIbeUdUgjPqD5SRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715115839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rRqkJbti4o/uw7dESQcGbPAnBlfMo4z2G6mt5iHvOPI=;
 b=v4vElHvAYyIz+iBWsjb7fgG3i/kSsAnQm3C/5vBbgbOWMNAHV7NeBukiiIV3vxKbMdrJLR
 3RdcjDbAGs4ZfnDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5F64139CB;
 Tue,  7 May 2024 21:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IyMDHz6XOmZePQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 07 May 2024 21:03:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 07/26] migration: VMStateId
In-Reply-To: <1714406135-451286-8-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-8-git-send-email-steven.sistare@oracle.com>
Date: Tue, 07 May 2024 18:03:56 -0300
Message-ID: <87o79hl4g3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.99 / 50.00]; BAYES_HAM(-2.98)[99.92%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org,oracle.com];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWELVE(0.00)[12];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 376055BD38
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Define a type for the 256 byte id string to guarantee the same length is
> used and enforced everywhere.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

