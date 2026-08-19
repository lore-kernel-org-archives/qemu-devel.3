Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A92C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwh4E-0005J4-0x; Wed, 19 Aug 2026 10:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1wwh4B-0005I9-Nf; Wed, 19 Aug 2026 10:14:55 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1wwh49-0007KI-Tz; Wed, 19 Aug 2026 10:14:55 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D7C884B74;
 Wed, 19 Aug 2026 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787148887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hIGQ+pPK66qoCA7Bb1aoYVCs+p/Y6Dgi4hxwPx+UmSI=;
 b=Y4RtZS1458eTwGAMu7554ZfOQaDRG+quCGGQHcFK3kkNCONx18nb003PxetuylLtyQQ2lP
 Tr40sx/ABLD0DAtuQes7VRpukM6WXDuaJp7d5jn2wbFzWgVQSOr/UyDz3J7hn0nqJp+5Wv
 bIUJqpBCpPmDBaHoGw/qtr2cdx/e7wU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787148887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hIGQ+pPK66qoCA7Bb1aoYVCs+p/Y6Dgi4hxwPx+UmSI=;
 b=sn8U4OMLrRIGn98yQsH8Z0+heN50AsYmB1sn4+ym/ycpAlWeV7ilX8OCD0AQIA9RHnK3Tq
 AZDZRx6JAx2Zx1Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787148883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hIGQ+pPK66qoCA7Bb1aoYVCs+p/Y6Dgi4hxwPx+UmSI=;
 b=i1T1uHDruQxzRDjww4xbreScPYKlVmOts/bKSymDGEMInOav7zUBcKCkhXTInSE2c6Z6LZ
 1421tz6WMQNOjfgvpEfk3u3BR2kuYzNDTHL5of2WxHdQQx+u4leBs4OlM4SOW/BFGIe7z6
 iybezBaF3x+IOTeuX/USX+FHFAT/XGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787148883;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hIGQ+pPK66qoCA7Bb1aoYVCs+p/Y6Dgi4hxwPx+UmSI=;
 b=5EH/UtBFjhrk4gB7j0eyARuMtwEFrb1hFrzGt+4MVwATjLQhOSyAw3erj1hKUOtTzD//br
 Fk5T5Zsp8MPC2vDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1BDA2F81;
 Wed, 19 Aug 2026 14:14:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vGFIKFK6hWoqeAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Aug 2026 14:14:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Tao Tang <tangtao1634@phytium.com.cn>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, Chen Baozi <chenbaozi@phytium.com.cn>, Chao
 Liu <chao.liu@processmission.com>, Jim MacArthur
 <jim.macarthur@linaro.org>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: Re: [RFC v5 4/5] tests/qtest: Add qtest-attrs-test for memory
 access attrs
In-Reply-To: <20260814035628.3924513-5-tangtao1634@phytium.com.cn>
References: <20260814035628.3924513-1-tangtao1634@phytium.com.cn>
 <20260814035628.3924513-5-tangtao1634@phytium.com.cn>
Date: Wed, 19 Aug 2026 11:14:40 -0300
Message-ID: <87tsoqkxin.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Tao Tang <tangtao1634@phytium.com.cn> writes:

> Add qtest-attrs-test to exercise qtest memory access commands with attrs
> on both aarch64 and x86.
>
> The test covers:
> - Arm virt,secure=on: scalar and bulk accesses across non-secure,
>   secure, and root spaces, plus negative coverage for realm and for
>   non-secure accesses into secure-only RAM
> - x86 q35: normal accesses
> - libqtest-single *_attrs shortcut wrappers
>
> Add reusable response assertion helpers and structured attrs failure
> helpers to libqtest.

Can't you re-order patch 3/5 before 2/5 and put these generic changes in
2/5 as well?

> Use the structured APIs for negative memory access
> tests, while retaining raw protocol commands for malformed command
> shapes that the typed APIs cannot express.
>
> On Arm, the test targets the virt machine's secure-only RAM window so
> that the requested attrs must select the correct address space.
>
> Also wire qtest-attrs-test into the aarch64 and i386/x86_64 qtest
> builds.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  tests/qtest/libqtest.c         | 156 +++++++++++++++++
>  tests/qtest/libqtest.h         | 111 ++++++++++++
>  tests/qtest/meson.build        |   7 +-
>  tests/qtest/qtest-attrs-test.c | 305 +++++++++++++++++++++++++++++++++
>  4 files changed, 577 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qtest/qtest-attrs-test.c
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 37aa69e1297..533b6f34599 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c

The repetition introduced in this part is annoying, but let's not suffer
because of it, we can clean it up later. We could probably unify the
attrs and non-attrs versions using variadic functions as with the qmp
helpers.

For libqtest:
Reviewed-by: Fabiano Rosas <farosas@suse.de>

