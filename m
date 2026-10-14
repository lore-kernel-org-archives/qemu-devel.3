Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FBDC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3Dp-0006yq-Ao; Wed, 14 Oct 2026 13:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xH3Dn-0006yf-UX
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:57:00 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xH3Dm-0007pd-Ee
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:56:59 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 487641F7D2;
 Wed, 14 Oct 2026 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792000615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BcCMthuEwPuUz+5bclTzpOOOTl24Gd43RbgqKVBL4Yg=;
 b=ex725nZYxrVZsn0Qrnkt1o5JcjvT7fEMW1O8UktRBhLf1mhrQS7dl95/1o2xZjfbyyyWXE
 daOb+0IHCFme+qDHV65iVnxCgz2vq4FOrLhu2nsevYXmnsYrGiu/CR6D/6/omQ/2C+GWCF
 rCMV+KmHYaDsKCXSUtXFahA0wipwuHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792000615;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BcCMthuEwPuUz+5bclTzpOOOTl24Gd43RbgqKVBL4Yg=;
 b=T5hUXg3I25UvFzTHOVgsZNNUVBNb7AxoDoNb6PX3rclXh+Xa74M/YOi/e+cWn1oWcKZ05E
 iBqgHY3Krytgm0CA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=veLHhfns;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uTWqbgHG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792000614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BcCMthuEwPuUz+5bclTzpOOOTl24Gd43RbgqKVBL4Yg=;
 b=veLHhfnsgbdE0sEzvtngvPRV52tcUmNQF6rKoTZOt3CsafKnShxQMMtHGKFP34ppJT+Yck
 jL8BsyJXtMuwXdNtYqMrKyszWphRyQuIwbaHdb6Mt92/q6Lamchi+/qv2hdPSDTZpXo9zR
 bRsKKR4//7OU6O5pJGuWaYO7SzIRuKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792000614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BcCMthuEwPuUz+5bclTzpOOOTl24Gd43RbgqKVBL4Yg=;
 b=uTWqbgHGC0zwAWFNwHi7crOya1ncIh6zuPPbcLZYIVjPS8NJ5hoZmUQp7x+7Cb14tmwLSR
 E6aKp+j5eUqd7vDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48535133F1;
 Wed, 14 Oct 2026 17:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vssHNGTCz2plagAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Oct 2026 17:56:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mjt@tls.msk.ru
Subject: Re: [RFC] container images for migration-test
In-Reply-To: <asyX0JccFfG0ZMDp@redhat.com>
References: <8733vbtmge.fsf@suse.de> <asyX0JccFfG0ZMDp@redhat.com>
Date: Wed, 14 Oct 2026 14:56:46 -0300
Message-ID: <87jynkmaht.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 487641F7D2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Sep 14, 2026 at 08:58:09PM -0300, Fabiano Rosas wrote:
>> Hi, I just wanted to share and ask for feedback on some container images
>> I've been building as part of my testing of migration pull-requests.
>>=20
>> From a Dockerfile from ./tests/docker/dockerfiles/ I'm producing the
>> following:
>>=20
>> $ docker images
>> qemu-build-base:11.0.0                        b6efa198e93a        5.8GB
>> qemu-rootfs-base:11.0.0                       72bcb5418f4d       4.08GB
>> qemu:11.0.0                                   018a3f0f4dcc          2GB
>
> snip
>
>> 2) Neither the QEMU build nor the distro repos are reliable enough to
>> allow me to just "go back in time" and rebuild at any moment, I need to
>> keep the artifacts cached to avoid rebuilding. Otherwise it comes time
>> to send a PR and I discover that some python piece has changed or the
>> distro messed up the older repository.
>
> Yes, in general building old QEMU on new distros periodically
> hits trouble.  If building old QEMU, better reliability is
> achieved by using a distro release that was from the same
> timeframe as QEMU.  Is using containers targetting such old
> distro versions not an option ? The tests/docker/dockerfiles
> from the old QEMU branch ought to work ?
>

Yes, I'm doing just that. Some tweaks are needed still. For instance, my
script has something like this:

  dockerfile=3D"tests/docker/dockerfiles/opensuse-leap.docker"

  sed -i 's/ncurses-devel//' $dockerfile

  if [ "$tag" =3D "10.1.0" ]; then
      sed -i 's/libLLVM19//' $dockerfile
  fi

> Our stable release branches have the same needs, and their
> CI is using the container images from the old branches.
>
> How far back in time do you need/want to go for migration
> testing ?  Is it sufficient to merely target versions for
> which mjt is still doing active maint work, so we can
> expect the containers to still work.
>

I'm currently testing against the previous 3 releases. I think 2
releases is probably enough.

> With regards,
> Daniel

