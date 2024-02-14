Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4992C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 13:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raFIl-0005m4-Lk; Wed, 14 Feb 2024 08:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1raFIf-0005fZ-3a; Wed, 14 Feb 2024 08:27:46 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1raFId-00065V-DV; Wed, 14 Feb 2024 08:27:44 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 92B3021D01;
 Wed, 14 Feb 2024 13:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707917258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLNYed6YGue1/3jBKykHxWEXJjubzhdHkZatfNJgpOY=;
 b=B8Fx5xBKDBwlRrFv4RCYkrZamXvJKNLYksczrJ8sdh/u9HiqqNGkB/ZzIGyDOgNukpvffE
 28w1BGeicizFWYR7dhFb9vsnth4Wz6dUUtB6CozKlBezFm9uVQDn2cPZAy8G9a9b6VmRKD
 SgZ4YkuLtzwQ+7niajYYrT71tM0thZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707917258;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLNYed6YGue1/3jBKykHxWEXJjubzhdHkZatfNJgpOY=;
 b=YGsxxKtcVgaNgIc8MT4mxCGdUUjV2HnfJY/AevThpSvMT7zB5/wL8nd6060lq1ofLYJHKN
 9T5l2pFJwqoIEFCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707917258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLNYed6YGue1/3jBKykHxWEXJjubzhdHkZatfNJgpOY=;
 b=B8Fx5xBKDBwlRrFv4RCYkrZamXvJKNLYksczrJ8sdh/u9HiqqNGkB/ZzIGyDOgNukpvffE
 28w1BGeicizFWYR7dhFb9vsnth4Wz6dUUtB6CozKlBezFm9uVQDn2cPZAy8G9a9b6VmRKD
 SgZ4YkuLtzwQ+7niajYYrT71tM0thZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707917258;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLNYed6YGue1/3jBKykHxWEXJjubzhdHkZatfNJgpOY=;
 b=YGsxxKtcVgaNgIc8MT4mxCGdUUjV2HnfJY/AevThpSvMT7zB5/wL8nd6060lq1ofLYJHKN
 9T5l2pFJwqoIEFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CA8C13A6D;
 Wed, 14 Feb 2024 13:27:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UVfxNMm/zGXzeQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Feb 2024 13:27:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, peterx@redhat.com, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 26/34] migration/multifd: Join the TLS thread
In-Reply-To: <0e5720f4-63c1-4f71-ab6b-26c07614ba33@tls.msk.ru>
References: <20240208030528.368214-1-peterx@redhat.com>
 <20240208030528.368214-27-peterx@redhat.com>
 <d60ddc11-b4b4-4fee-b9c0-08bea513f8d3@tls.msk.ru>
 <0e5720f4-63c1-4f71-ab6b-26c07614ba33@tls.msk.ru>
Date: Wed, 14 Feb 2024 10:27:35 -0300
Message-ID: <8734tvqipk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=B8Fx5xBK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YGsxxKtc
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.14 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-2.63)[98.35%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 92B3021D01
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 10.02.2024 12:18, Michael Tokarev:
>> 08.02.2024 06:05, peterx@redhat.com :
>>> From: Fabiano Rosas <farosas@suse.de>
>>>
>>> We're currently leaking the resources of the TLS thread by not joining
>>> it and also overwriting the p->thread pointer altogether.
>>>
>>> Fixes: a1af605bd5 ("migration/multifd: fix hangup with TLS-Multifd due =
to blocking handshake")
>>> Cc: qemu-stable <qemu-stable@nongnu.org>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> Link: https://lore.kernel.org/r/20240206215118.6171-2-farosas@suse.de
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>=20
>> This change, which is suggested for -stable, while simple by its own, se=
ems
>> to depend on the previous changes in this series, which are not for -sta=
ble.
>> In particular, whole "Finally recycle all the threads" loop in multifd_s=
end_terminate_threads()
>> (to which the join is being added by this change) is moved from elsewher=
e by
>> 12808db3b8 "migration/multifd: Cleanup multifd_save_cleanup()" (patch 24=
 in
>> this same series).
>>=20
> We can probably add the missing join right into the previous location of =
this
> loop (before 12808db3b8).=C2=A0 I did this in the attached variant for 8.=
2, is
> this correct?

It should work. This was originally developed without the rest of the
changes on this PR.

>
> And this does not pass even the basic tests, so it's not that simple :)

Do you have a log of what failed?

Anyway, I could prepare a backport on top of 8.2 for you.

>
> The following patch (27/34) is more questionable than this one.
>
> Thanks!
>
> /mjt

