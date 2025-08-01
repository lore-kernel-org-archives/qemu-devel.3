Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FA9C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 20:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhwRZ-00023L-0x; Fri, 01 Aug 2025 16:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhv8S-0006aT-Kx
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 15:09:44 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhv8P-0006WH-OX
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 15:09:44 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A1D7921AC6;
 Fri,  1 Aug 2025 19:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754075378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZB/Na23cCVsXYbab+X2ZcHY+rERWj8Imn8GWQzypAs=;
 b=qPIiPiPaAx2eU0ZJbixD0hNcGFcuanOoovgLx5UBMES6VAgtytdXuq+p7Owa9w9pS1Fei9
 Fidag1BnUy9ODFb9UMxaMM4Xuin0W6eEU6u7r+eg0oycNYe2pMGrLMAZGYmKZZ/rSoa8CF
 wCTE8LNRQVRSH/OwuB3aFR3Fj2xmQRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754075378;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZB/Na23cCVsXYbab+X2ZcHY+rERWj8Imn8GWQzypAs=;
 b=LG//4UiAbVJuL2JS2I8/6gsa3JoUkZD9mtUGa7bpQK7l0tpQj5U1FgazJlIGGm+GFUcU8X
 weB5xe82nixb0gBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754075377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZB/Na23cCVsXYbab+X2ZcHY+rERWj8Imn8GWQzypAs=;
 b=QWIfZFhOufhigF+pE4z14niNzQDGOvi+i2MGtGG0s3U3fEdB2OGLFFVD3xMF+jZaH835yA
 zm5IcRl8UZksFLU2mHGNT/rMMqcIF3T3hh6iJRGSAWNKzOHgaaxLxxYg7Q2dkgts4GBuo6
 iVK4ziykIV+9AG5NmDZOxlvR2ZDgEVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754075377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZB/Na23cCVsXYbab+X2ZcHY+rERWj8Imn8GWQzypAs=;
 b=dtjyhmAQGyWoTwIYxkbSUFaD7spS1AgBuB2rY4mwc4fRnu2TOXsLgYiKC+io/pceU0QnZd
 hEaIqALqxlIP0lAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2141113876;
 Fri,  1 Aug 2025 19:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R8F0NfAQjWgkbgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 01 Aug 2025 19:09:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Martin
 Kletzander <mkletzan@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-rust@nongnu.org, Hanna Reitz <hreitz@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 2/2] tests/qemu-iotests: Indent expected error messages
In-Reply-To: <aIzhtcg-TNZE0zH8@redhat.com>
References: <cover.1754060086.git.mkletzan@redhat.com>
 <f5be6d407c105fa199d10867f5de48bbd25c008c.1754060086.git.mkletzan@redhat.com>
 <aIzhtcg-TNZE0zH8@redhat.com>
Date: Fri, 01 Aug 2025 16:09:34 -0300
Message-ID: <87v7n63lld.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Aug 01, 2025 at 04:59:50PM +0200, Martin Kletzander wrote:
>> From: Martin Kletzander <mkletzan@redhat.com>
>>=20
>> When running all tests the expected "killed" messages are indented
>> differently than the actual ones, by three more spaces.  Change it so
>> that the messages match and tests pass.
>
> This would break the tests on my system and CI too.
>
> What distro are you seeing this on ?
>
> I'm guessing this is a different in either valgrind or C library ?
>

It's bash, we have an open issue about it:

https://gitlab.com/qemu-project/qemu/-/issues/3050


