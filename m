Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D43C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwg68-0004CM-Kx; Wed, 19 Aug 2026 09:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwg67-0004CD-F5
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:12:51 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwg65-0003nj-N2
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:12:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97EBC84B3A;
 Wed, 19 Aug 2026 13:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787145163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ri0Rh3WhDPgW7ABwgfGjUXneayUteg6CVLpeP3t73wI=;
 b=Czl7JpkKPtQwT05oMLTqxIj9GHDvWHhNQmPiyqQqGW9naNe76NyFV/e2czNLjnioH0XJor
 3nVKtlQ9zyOpR8U4loLls+P8rN+ZrdXHt7vjXuzMcTNuShVI1Xi4mwHry8ClMv9OHG2lgr
 YIj1jnxEh5AZ2PXPhCV3dXRx2pQmBOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787145163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ri0Rh3WhDPgW7ABwgfGjUXneayUteg6CVLpeP3t73wI=;
 b=Xg2aVf3LasusGF5uksKO8pImgWZLtfRfXeNVt/puIwQRozBBGI2mrs1mZsIO9tjkAA0u3u
 eGfoxjZvQR8NFpBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787145159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ri0Rh3WhDPgW7ABwgfGjUXneayUteg6CVLpeP3t73wI=;
 b=zEtp86SRhZ7eyEL0gJaWGnjw6r/mLLbZiCrzh/hVOhgXTsTTAJ9awchA4+BhCQSE/H+nGV
 HddH2DH4yqcue4W+0jKqSbLD43jRPmBp7hNSItmxiOoLfopW8jLyEAPjG0as0ahx+LfG6q
 eSkqvqK5E+Y18w+dF7gfBgzchwFvY0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787145159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ri0Rh3WhDPgW7ABwgfGjUXneayUteg6CVLpeP3t73wI=;
 b=psS1RMoTJTFYf5iFOfJhHQeulbP/UcxEZ6irkFfZAEa171sUGSpHt5slcFXFsRFsTzZlLf
 IgmQXB3jtaspOlAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37288362E;
 Wed, 19 Aug 2026 13:12:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dOmoAserhWrKOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Aug 2026 13:12:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Rohitashv Kumar <rohit.kuma1313@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Rohitashv Kumar <roohiit@amazon.de>
Subject: Re: [PATCH 0/3] tests/qtest: make PCI tests resilient to a
 compiled-out i440fx/pc machine
In-Reply-To: <20260717081845.2439849-1-rohit.kuma1313@gmail.com>
References: <20260717081845.2439849-1-rohit.kuma1313@gmail.com>
Date: Wed, 19 Aug 2026 10:12:32 -0300
Message-ID: <8733wameyn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, amazon.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Rohitashv Kumar <rohit.kuma1313@gmail.com> writes:

> From: Rohitashv Kumar <roohiit@amazon.de>
>
> QEMU can be built with the i440fx/pc machine type compiled out (for
> example via a custom --with-devices-<arch> configuration that only keeps
> the q35 machine). In that configuration a few qtests fail because they
> hard-code "-machine pc" instead of checking whether the machine is
> available.
>
> This series makes the affected tests skip the pc-specific paths when the
> "pc" machine is not compiled in, using the existing qtest_has_machine()
> helper. There is intentionally NO behaviour change for a normal build
> that includes i440fx/pc: the guards only take effect when "pc" is absent,
> so existing CI coverage is unchanged.
>
> For device-plug-test and drive_del-test the guard is placed inside the
> x86-only branch that adds "-machine pc", so coverage on other
> architectures (which use the default machine) is preserved, and x86
> coverage is still provided by the existing q35 variants. For pxe-test the
> per-row check mirrors the existing per-row qtest_has_device() guard, so
> q35 rows keep running when pc is gone.
>
> Tested by building QEMU with and without the i440fx/pc machine: with it
> present all affected tests run as before; with CONFIG_I440FX=n the pc
> cases skip instead of failing.
>
> Rohitashv Kumar (3):
>   tests/qtest/device-plug-test: skip pc tests when 'pc' machine is
>     unavailable
>   tests/qtest/drive_del-test: skip pc tests when 'pc' machine is
>     unavailable
>   tests/qtest/pxe-test: skip per-row cases whose machine is unavailable
>
>  tests/qtest/device-plug-test.c |  8 ++++++++
>  tests/qtest/drive_del-test.c   | 16 ++++++++++++++++
>  tests/qtest/pxe-test.c         |  4 ++++
>  3 files changed, 28 insertions(+)

Queued, thanks!

