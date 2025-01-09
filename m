Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD861E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVsoU-0005Kk-CY; Thu, 09 Jan 2025 08:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVsoS-0005KF-Ob
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:43:04 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVsoO-0003Te-Hn
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:43:04 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3925E210F6;
 Thu,  9 Jan 2025 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736430176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DuMouE5rNiX0kTkjkQyLyWMFDmQLBv2AGIMLyXxh1Y=;
 b=MUy7jln/92ZkfDkSjmAIAyUU34+yueHIdUQebSyGIw21DRQi+Qu2+YD1cf2AWS6aTV8L3r
 nihmWNA7yDeqXiGDuCWCBdiQDt/KES2vmVUX0d0tBU8/HReOB+TLb5kFjxA0rAHASSe0QJ
 SJtoBP+Hw4R0BqU3uuVFXnkiTqPeh+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736430176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DuMouE5rNiX0kTkjkQyLyWMFDmQLBv2AGIMLyXxh1Y=;
 b=/ZAyDvc0GbM//Uchy9OhDaWyGRv4MFGpe281US78T8wgi0dcTOlkPLh6x+4WOW1ZEbLnVe
 qkS3fvXroFpVlqBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="MUy7jln/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/ZAyDvc0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736430176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DuMouE5rNiX0kTkjkQyLyWMFDmQLBv2AGIMLyXxh1Y=;
 b=MUy7jln/92ZkfDkSjmAIAyUU34+yueHIdUQebSyGIw21DRQi+Qu2+YD1cf2AWS6aTV8L3r
 nihmWNA7yDeqXiGDuCWCBdiQDt/KES2vmVUX0d0tBU8/HReOB+TLb5kFjxA0rAHASSe0QJ
 SJtoBP+Hw4R0BqU3uuVFXnkiTqPeh+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736430176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2DuMouE5rNiX0kTkjkQyLyWMFDmQLBv2AGIMLyXxh1Y=;
 b=/ZAyDvc0GbM//Uchy9OhDaWyGRv4MFGpe281US78T8wgi0dcTOlkPLh6x+4WOW1ZEbLnVe
 qkS3fvXroFpVlqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3B9813876;
 Thu,  9 Jan 2025 13:42:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SrAiHl/Sf2dmUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Jan 2025 13:42:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Helge
 Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 0/2] tests: Add functional tests for HPPA machines
In-Reply-To: <a7eb9e91-8feb-456c-8ce8-f2b7e940118a@linaro.org>
References: <20250102100340.43014-1-philmd@linaro.org>
 <a7eb9e91-8feb-456c-8ce8-f2b7e940118a@linaro.org>
Date: Thu, 09 Jan 2025 10:42:53 -0300
Message-ID: <8734hs3xya.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3925E210F6
X-Spamd-Result: default: False [-3.69 / 50.00]; BAYES_HAM(-2.18)[96.11%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; URIBL_BLOCKED(0.00)[linaro.org:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmx.de]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,gmx.de];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,linaro.org:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 2/1/25 11:03, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since v5:
>> - Correct boot-serial-test machine name for stable (th_huth)
>>=20
>> Philippe Mathieu-Daud=C3=A9 (2):
>>    tests/qtest/boot-serial-test: Correct HPPA machine name
>>    tests: Add functional tests for HPPA machines
>
> Fabiano, if you don't object, I'm queuing this via my hw-misc tree.
>

Sure, go ahead, thanks!

> Regards,
>
> Phil.

