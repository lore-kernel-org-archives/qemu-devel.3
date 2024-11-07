Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD1ED43356
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t91MG-00077R-EK; Thu, 07 Nov 2024 07:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t91MB-000777-55
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:11:23 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t91M8-0005A9-Vr
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:11:22 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DFFBA1F8CC;
 Thu,  7 Nov 2024 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730981478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0a/PVwf8mT84SctdYRE/NRCSd06QWazrC3sTRrW+jbA=;
 b=knPidv8CB7xzol53dOZS0QOwM8beFUOQJWz2WHWAF09XN7t+V3ylBDm/k0vDp22kDwym1f
 63CBQxrVmEOuIfoS1wwIYo6h1e1tewvr6hPuHVGPy6WctBvUG62U9PxkVIvLMDUqR7rjGr
 HLLmkfn25w7IrJGUAowaJBF2MG6mPjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730981478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0a/PVwf8mT84SctdYRE/NRCSd06QWazrC3sTRrW+jbA=;
 b=6uURWQ+QX1ABE/wyBjHF45qftZvoB8OYLkotBWxM7CQ1TejYo2phWuXJOVfmaDl0I6DuBF
 QReVDWI9fpmjR0Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nzb6om7V;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=m+kfWf8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730981477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0a/PVwf8mT84SctdYRE/NRCSd06QWazrC3sTRrW+jbA=;
 b=nzb6om7VbZh0q+K1QKuChsoPTAQbomEJMC2Xg+KHFApDWrTG0xdhxczsgsSZhzk1b/cChB
 vzOLX2npKzsFgM6wL3LjshqxHv+WTZYinEv1Valeb1eWWoTlmIBvDxsSk12XIsDVTKpANc
 C0RANztwrzVFI8JQPrm618JLiNd51oY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730981477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0a/PVwf8mT84SctdYRE/NRCSd06QWazrC3sTRrW+jbA=;
 b=m+kfWf8Fmc+F9I6ZvhT8hEmAXGV/5oocj1zoFoWvITNSKQ6s0sGpPa5pBSFpc8SC/Yr5NK
 kTma2a6r/9gZNiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6072E1394A;
 Thu,  7 Nov 2024 12:11:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id twQHCmWuLGdiLAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 07 Nov 2024 12:11:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
In-Reply-To: <CAE8KmOwM2wjkyUZL5v=3gjkUNa8VhA6oick35KMX-FO2-BidaQ@mail.gmail.com>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-3-ppandit@redhat.com> <ZyTnBwpOwXcHGGPJ@x1n>
 <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
 <ZyoW3ue3WTQ3Di1d@x1n>
 <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
 <87ldxw1p8k.fsf@suse.de>
 <CAE8KmOwM2wjkyUZL5v=3gjkUNa8VhA6oick35KMX-FO2-BidaQ@mail.gmail.com>
Date: Thu, 07 Nov 2024 09:11:14 -0300
Message-ID: <87ttcj2qhp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: DFFBA1F8CC
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Wed, 6 Nov 2024 at 18:41, Fabiano Rosas <farosas@suse.de> wrote:
>> What we're thinking is having an initial exchange of information between
>> src & dst as soon as migration starts and that would sync the
>> capabilities and parameters between both sides. Which would then be
>> followed by a channel establishment phase that would open each necessary
>> channel (according to caps) in order, removing the current ambiguity.
>>
>
> * Isn't that how it works? IIUC, libvirtd(8) sends migration command
> options to the destination and based on that the destination prepares
> for the multifd and/or postcopy migration. In case of 'Postcopy' the
> source sends 'postcopy advise' to the destination to indicate that
> postcopy might follow at the end of precopy. Also, in the discussion
> above Peter mentioned that libvirtd(8) may exchange list of features
> between source and destination to facilitate QMP clients.
>
> * What is the handshake doing differently? (just trying to understand)

The handshake will be a QEMU-only feature. Libvirt will then only start
the migration on src and QEMU will do the capabilities handling.

>
> Thank you.
> ---
>   - Prasad

