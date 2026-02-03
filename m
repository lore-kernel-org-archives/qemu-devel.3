Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116C5E87829
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 13:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnGqI-0000vh-1T; Tue, 03 Feb 2026 08:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vnGqF-0000vX-6w
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:53:19 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vnGqD-0007gr-Ir
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:53:18 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1255C5BCC9;
 Tue,  3 Feb 2026 13:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770126794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7STOBMSdHGv9gwGYmmyMUjwc2cEK+3n6vJZ81oyGqQ=;
 b=xDJiqIIpB7B6jUs+Kw2Z9EwGeWoLqeznjgyVxOmmkMdkLfp8LY5cl/oyyIt2oH3qUpoVOu
 QqXv7/V2TuZ/VKPO1+bab8h5W79jUv0ts7Cys1lvSqkez7EWqEVupcrnZ009G35rFJyfmj
 dkoGpueTtapez9SFgwUq3JXDxbqgDjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770126794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7STOBMSdHGv9gwGYmmyMUjwc2cEK+3n6vJZ81oyGqQ=;
 b=KRQlPQrGG4R1psqbbESSf80BVezbisSvUu3kRklHTUqIyThF9BUWtHm39mm/zlB0+draqJ
 YK2dw+6AyF0QOrBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770126794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7STOBMSdHGv9gwGYmmyMUjwc2cEK+3n6vJZ81oyGqQ=;
 b=xDJiqIIpB7B6jUs+Kw2Z9EwGeWoLqeznjgyVxOmmkMdkLfp8LY5cl/oyyIt2oH3qUpoVOu
 QqXv7/V2TuZ/VKPO1+bab8h5W79jUv0ts7Cys1lvSqkez7EWqEVupcrnZ009G35rFJyfmj
 dkoGpueTtapez9SFgwUq3JXDxbqgDjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770126794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7STOBMSdHGv9gwGYmmyMUjwc2cEK+3n6vJZ81oyGqQ=;
 b=KRQlPQrGG4R1psqbbESSf80BVezbisSvUu3kRklHTUqIyThF9BUWtHm39mm/zlB0+draqJ
 YK2dw+6AyF0QOrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75C763EA62;
 Tue,  3 Feb 2026 13:53:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id em5lDcn9gWmCagAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Feb 2026 13:53:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: openSUSE container failure
In-Reply-To: <aYHJPoaFEfs2G3kI@redhat.com>
References: <74094b25-73bc-4e76-a7d6-d41e2a22c6b9@linaro.org>
 <aYHJPoaFEfs2G3kI@redhat.com>
Date: Tue, 03 Feb 2026 10:53:10 -0300
Message-ID: <87ms1qq6gp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_THREE(0.00)[4]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Feb 03, 2026 at 10:47:46AM +1000, Richard Henderson wrote:
>> E.g. https://gitlab.com/qemu-project/qemu/-/jobs/12960514743
>>=20
>> Annoyingly, the gitlab pipeline drops some critical lines that show the
>> error.  Thankfully I can reproduce locally:
>>=20
>> > Resolving package dependencies...
>> >=20
>> > Problem: 1: nothing provides 'rust1.93' needed by the to be installed =
rust-1.93.0-150500.27.62.1.x86_64
>> >  Solution 1: do not install rust-1.93.0-150500.27.62.1.x86_64
>> >  Solution 2: break rust-1.93.0-150500.27.62.1.x86_64 by ignoring some =
of its dependencies
>> >=20
>> > Choose from above solutions by number or cancel [1/2/c/d/?] (c): c
>>=20
>> It does appear that there's no rust package available anymore?
>> Should we just drop rust from this image for now?
>
> It appears opensuse repos have pushed broken the Rust packages.  "rust" is
> available, but it has a dep on "rust1.93" which is NOT published, the
> newest is "rust1.92".=20
>

Yes, there's some issue with the repositories, I'll ping someone
internally who can fix this.

> With regards,
> Daniel

