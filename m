Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED17C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKGMM-0006RH-PY; Wed, 28 May 2025 08:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uKGLu-0006PU-HD
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:57:51 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uKGLs-0001wJ-2Y
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:57:50 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D75C41F7A3;
 Wed, 28 May 2025 12:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748437066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pp6QIvVKvAnaPmCv5k7DZzg1V5GmKdOOss9Jq+9Aw9c=;
 b=JOd4ohYE7ZdZavWVs6wv7dxWaWzCj4BG2ZVsJbkiXllue1xSDKZvqAshTJX26208kYu5VE
 zlfakRRN+/xNE+b/J+xYS1AVIp1rNaH40O0pkfx6ORJpvLPstO3KGwj4D6pRMRnzUH/M7E
 TmJqJJMHig6BedR+WuKXZfbwx+/0Iks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748437066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pp6QIvVKvAnaPmCv5k7DZzg1V5GmKdOOss9Jq+9Aw9c=;
 b=eGhw/sv29IfiHZ+SDfp4lYWFfYT86cvfCOXyFfb0rfGfjS67rQ2aS+DLmDv4LIuZ/Rioq9
 0xNZutk4vb4w5LAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748437065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pp6QIvVKvAnaPmCv5k7DZzg1V5GmKdOOss9Jq+9Aw9c=;
 b=mBYm1QVAle+uvyq4ofO+GJdCViuwK7BTiGnUv956R9PdUdi2f6IxcpFBqGfhbCEl9+sokm
 zS1rUpk45O5vwzhNS8auSxleGIbKCT/ZKo8k8H89mahBi1mW60GTScqHypkevcKqXxIzok
 CiW0/c9WXb6LOM4vXPPGS/VaLKQSssM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748437065;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pp6QIvVKvAnaPmCv5k7DZzg1V5GmKdOOss9Jq+9Aw9c=;
 b=5EEeeiz0y7SKj9CsPlR4fCE9PMnAhLVm9IhiG5u0Pw1qYLMv/NXsepKHZDAkTZ5XbNKd+I
 lyDRQ3I5bh74BGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E3CC136E0;
 Wed, 28 May 2025 12:57:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 59duA0kIN2g5MAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 May 2025 12:57:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nikita Shubin <nikita.shubin@maquefel.me>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>, Laurent Vivier
 <lvivier@redhat.com>, Ilya Chichkov <i.chichkov@yadro.com>, Nikita Shubin
 <n.shubin@yadro.com>
Subject: Re: [PATCH v2 3/3] tests/qtest: add qtests for STM32 DMA
In-Reply-To: <20250523113647.4388-4-nikita.shubin@maquefel.me>
References: <20250523113647.4388-1-nikita.shubin@maquefel.me>
 <20250523113647.4388-4-nikita.shubin@maquefel.me>
Date: Wed, 28 May 2025 09:57:42 -0300
Message-ID: <87wma099kp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Nikita Shubin <nikita.shubin@maquefel.me> writes:

> From: Nikita Shubin <n.shubin@yadro.com>
>
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>

Acked-by: Fabiano Rosas <farosas@suse.de>

