Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790E4FEFB7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 19:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw3MC-0000lr-5Z; Fri, 27 Feb 2026 14:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw3M9-0000kT-R0
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:18:33 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vw3M8-0008W6-1F
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:18:33 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 65A5C3F8B0;
 Fri, 27 Feb 2026 19:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772219910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gg5uJXc4CER8q8XYYEpN647H7JzhFUto44D1xwGrBxU=;
 b=mOAKBTkeH7MImoOIRit1qC/rg8/CQLVVvVgeoErZCXQhYAj1RlswgcvmksOivt8lZFyOxP
 zJosELFJDX0ttz12VAFjtrdmhNpw1OKDCcl1I+ijYZ/GQtW2XPcHCUbeNORnYm2sUWBd47
 dDj/26C99xqhvXCIWjM4ccU4Sw6huDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772219910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gg5uJXc4CER8q8XYYEpN647H7JzhFUto44D1xwGrBxU=;
 b=4P8d0i6DseYFSevj3oD6dCWa2BaMTHkpB42c7FE25bdM1dZFmH+5gVTtErwvb0iKMmAfZE
 PQPu2sTvL4oMrfAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mOAKBTke;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4P8d0i6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772219910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gg5uJXc4CER8q8XYYEpN647H7JzhFUto44D1xwGrBxU=;
 b=mOAKBTkeH7MImoOIRit1qC/rg8/CQLVVvVgeoErZCXQhYAj1RlswgcvmksOivt8lZFyOxP
 zJosELFJDX0ttz12VAFjtrdmhNpw1OKDCcl1I+ijYZ/GQtW2XPcHCUbeNORnYm2sUWBd47
 dDj/26C99xqhvXCIWjM4ccU4Sw6huDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772219910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gg5uJXc4CER8q8XYYEpN647H7JzhFUto44D1xwGrBxU=;
 b=4P8d0i6DseYFSevj3oD6dCWa2BaMTHkpB42c7FE25bdM1dZFmH+5gVTtErwvb0iKMmAfZE
 PQPu2sTvL4oMrfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE1693EA69;
 Fri, 27 Feb 2026 19:18:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KMk9KAXuoWklJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Feb 2026 19:18:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/4] scripts/lsan_suppressions.txt: Add more leaks
In-Reply-To: <CAFEAcA9+GzKxWKLcWvT5e2voO0mRR5jaKfXk4JrhWU6jFGXpNA@mail.gmail.com>
References: <20260227135736.2280161-1-peter.maydell@linaro.org>
 <20260227135736.2280161-3-peter.maydell@linaro.org>
 <87ikbi580c.fsf@suse.de>
 <CAFEAcA9+GzKxWKLcWvT5e2voO0mRR5jaKfXk4JrhWU6jFGXpNA@mail.gmail.com>
Date: Fri, 27 Feb 2026 16:18:27 -0300
Message-ID: <87cy1q5724.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Queue-Id: 65A5C3F8B0
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 27 Feb 2026 at 18:57, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > Running "make check" with the clang leak sanitizer reveals some
>> > leak reports which are either not our problem or else not
>> > a leak which is worth our time to fix. Add some suppressions
>> > for these.
>> >
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>
>> FYI, mine has these. The first one is on my list to fix once I find some
>> time. The last two seem to be part of the stack for the ones you added
>> here.
>>
>> leak:qcrypto_tls_session_push
>> leak:gnutls_handshake
>> leak:memory_region_do_init
>> leak:qos_traverse_graph
>> leak:qdev_get_named_gpio_list
>
> qdev_get_named_gpio_list is definitely used in paths other than
> the qemu_irq_intercept_in one we want to hit.
>
> I think that recent memory region fixes ought to have fixed the
> ones you're suppressing with memory_region_do_init.
>
> I couldn't make any sense of the qos_traverse_graph/walk_path one:
> it seems to be related to the qtest "subprocess" functionality
> somehow and doesn't repro without that.
>

Ahh I remember this... Here, patch 5/6:

https://lore.kernel.org/r/20241209204427.17763-1-farosas@suse.de

> thanks
> -- PMM

