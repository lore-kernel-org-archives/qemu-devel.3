Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97627D2ECE9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 14:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viD4z-0001kU-Mp; Tue, 20 Jan 2026 09:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1viD4k-0001a7-Bg
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:51:30 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1viD4i-0000Ai-PG
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:51:22 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 32464337F3;
 Tue, 20 Jan 2026 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768920678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8ox7+URmHDrfbMJ+rF7MDlTMWSJm5CIw801jROnd9Q=;
 b=tfl4VGw/GYvRGACFVMPoZ1rlwEzi889bOhoOeNq6mnjM+tVsYIqh2aE7W6NQGb15Bq3iOd
 2CU2FY2OxxpH4LwqfStMfv3LbtSEC3sdVr1Lp0h1EnXQ7AKRUeGJkz3rfPipeXE4JrLC9K
 ZTR9wxAWaI4Mfeyw0kO5SZkvodILEKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768920678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8ox7+URmHDrfbMJ+rF7MDlTMWSJm5CIw801jROnd9Q=;
 b=LOL+uBgGZ6YbrQkMxMLGgeN/YHPJl0KFxyawOJg9rD6DgOUFLPD6zc+KTyHsVhoT4yvb4N
 gMFqH/338SCQcYDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="tfl4VGw/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LOL+uBgG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768920678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8ox7+URmHDrfbMJ+rF7MDlTMWSJm5CIw801jROnd9Q=;
 b=tfl4VGw/GYvRGACFVMPoZ1rlwEzi889bOhoOeNq6mnjM+tVsYIqh2aE7W6NQGb15Bq3iOd
 2CU2FY2OxxpH4LwqfStMfv3LbtSEC3sdVr1Lp0h1EnXQ7AKRUeGJkz3rfPipeXE4JrLC9K
 ZTR9wxAWaI4Mfeyw0kO5SZkvodILEKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768920678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8ox7+URmHDrfbMJ+rF7MDlTMWSJm5CIw801jROnd9Q=;
 b=LOL+uBgGZ6YbrQkMxMLGgeN/YHPJl0KFxyawOJg9rD6DgOUFLPD6zc+KTyHsVhoT4yvb4N
 gMFqH/338SCQcYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91B903EA63;
 Tue, 20 Jan 2026 14:51:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2tSDE2WWb2k6dgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Jan 2026 14:51:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com
Subject: Re: [PATCH v3 04/25] migration: Cleanup TLS handshake hostname passing
In-Reply-To: <CAE8KmOwdfWPkmV87DWGVvHj7=QEYEXoHJOsRV4+SW3M_-PXdCQ@mail.gmail.com>
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-5-farosas@suse.de>
 <CAE8KmOw66B0Za=KA=TyxyWMPYSjFK=GBq7XhREevkCO4Vs+HYQ@mail.gmail.com>
 <aW9ixg59R8a90FIs@redhat.com>
 <CAE8KmOwdfWPkmV87DWGVvHj7=QEYEXoHJOsRV4+SW3M_-PXdCQ@mail.gmail.com>
Date: Tue, 20 Jan 2026 11:51:14 -0300
Message-ID: <87qzrk8hi5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 32464337F3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hi,
>
> On Tue, 20 Jan 2026 at 16:41, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>> Normal default behaviour is that the hostname in the TLS certificate
>> MUST be validated against the hostname that is specified by the user
>> (or mgmt app) in the migration URI.
>>
>> The 'tls-hostname' migration parameter is an optional override that
>> replaces the hostname from the migration URI, to be used in scenarios
>> such as:
>>
>>  * The URI is a UNIX socket. eg the UNIX socket points to a proxy
>>    that is transporting data to the dest in some manner.  There is
>>    no way to know the hostname from the URI, so 'tls-hostname' must
>>    be provided
>>
>>  * The URI is pointing to a proxy that forwards to the real host.
>>    eg perhaps you setup an SSH tunnel from localhost, to the real
>>    target. QEMU must NOT validate the remote TLS cert against
>>    'localhost', so 'tls-hostname' must be provided by the user
>
> * I see, got it. Thank you for the explanation.
>
>> Whatever is usd to validate the TLS hostname, must be data that is
>> provided by the user in some manner.
>>
>> TL:DR: always use 'tls-hostname' if it is provided by the user,
>> otherwise always use the hostname from the migration URI,
>> otherwise do not provide a hostname.
>
> * So when 'tls-hostname' is not defined, it could be set to
> 's->hostname', then migration_tls_hostname() stays unchanged.
>

Setting the parameters.tls_hostname would expose the hostname in the
QAPI for the query commands. This is a change in behavior for this
series (and I don't think we'd want it either).

options.c contains the "internal API" that exposes the migration options
to the rest of the code. If there's somewhere to change the hostname
seen by the rest of the code, it's there.

> Thank you.
> ---
>   - Prasad

