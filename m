Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69804C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 17:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgSaH-0002i0-Ge; Fri, 07 Feb 2025 12:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgSaF-0002hY-Jr
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:56:07 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgSaA-0004cm-Hq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:56:07 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C9AC21164;
 Fri,  7 Feb 2025 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738950960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MlAiqJJ2rOwjubIGJB7FVYhveiDyLM/NAnrHP5fu4Hk=;
 b=NsqVa0EcLtiaFPvUUC9N/mj5ZlE6u6JdOvacUwxlXnY7jz0k25yJSeWNUcrABRQx1gImMz
 xycJBOII4L4xo4KIjrQVLDeNjPLfojd2lrgWOzrBYS6NSRlPj5e671uijXxGiiXw+fLUgk
 MLmvFAvgKs0oE0JFFNytd98jEtvzbug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738950960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MlAiqJJ2rOwjubIGJB7FVYhveiDyLM/NAnrHP5fu4Hk=;
 b=V2ND6cqD+gwnESZrS6CUFy7+XUUC7IE386L2DbzGSzS8OxStktefKDct+FYHRc/2vSH26F
 pW4eS3pOFzK2zjBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NsqVa0Ec;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V2ND6cqD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738950960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MlAiqJJ2rOwjubIGJB7FVYhveiDyLM/NAnrHP5fu4Hk=;
 b=NsqVa0EcLtiaFPvUUC9N/mj5ZlE6u6JdOvacUwxlXnY7jz0k25yJSeWNUcrABRQx1gImMz
 xycJBOII4L4xo4KIjrQVLDeNjPLfojd2lrgWOzrBYS6NSRlPj5e671uijXxGiiXw+fLUgk
 MLmvFAvgKs0oE0JFFNytd98jEtvzbug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738950960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MlAiqJJ2rOwjubIGJB7FVYhveiDyLM/NAnrHP5fu4Hk=;
 b=V2ND6cqD+gwnESZrS6CUFy7+XUUC7IE386L2DbzGSzS8OxStktefKDct+FYHRc/2vSH26F
 pW4eS3pOFzK2zjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F30C513694;
 Fri,  7 Feb 2025 17:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZGL0Ki9JpmcSeAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 17:55:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [RFC PATCH v2 1/8] crypto: Allow gracefully ending the TLS session
In-Reply-To: <Z6ZBLjToT9bRoyhI@x1.local>
References: <20250207142758.6936-1-farosas@suse.de>
 <20250207142758.6936-2-farosas@suse.de> <Z6ZBLjToT9bRoyhI@x1.local>
Date: Fri, 07 Feb 2025 14:55:57 -0300
Message-ID: <874j15myfm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 8C9AC21164
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Feb 07, 2025 at 11:27:51AM -0300, Fabiano Rosas wrote:
>> QEMU's TLS session code provides no way to call gnutls_bye() to
>> terminate a TLS session. Callers of qcrypto_tls_session_read() can
>> choose to ignore a GNUTLS_E_PREMATURE_TERMINATION error by setting the
>> gracefulTermination argument.
>> 
>> The QIOChannelTLS ignores the premature termination error whenever
>> shutdown() has already been issued. This is not enough anymore for the
>> migration code due to changes [1] in the synchronization between
>> migration source and destination.
>
> This sentence seems to say commit [1] changed something on the tls
> condition, but IMHO fundamentally the issue is multifd recv thread model
> that relies on blocking readv() rather than request-based (like what src
> multifd does).
>
> Now src uses either shutdown() or close() to kick dest multifd recv threads
> out from readv().  That has nothing to do with what we do during complete()
> with those sync messages.. referencing it is ok, but we'll need to
> reference also the other commit to be clear pre-9.0 can also be prone to
> this.  To me, it's more important to mention the root cause on the multifd
> recv thread model, which requires explicit tls terminations.
>

I didn't want to go into too much detail in a commit for crypto/. The
motivation for *this* patch is just: migration needs it. What about:

 The QIOChannelTLS ignores the premature termination error whenever
 shutdown() has already been issued. This was found to be not enough for
 the migration code because shutdown() might not have been issued before
 the connection is terminated.


>> 
>> Add support for calling gnutls_bye() in the tlssession layer so users
>> of QIOChannelTLS can clearly identify the end of a TLS session.
>> 
>> 1- 1d457daf86 ("migration/multifd: Further remove the SYNC on complete")
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>

