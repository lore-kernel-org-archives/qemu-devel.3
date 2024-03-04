Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B42C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh84Z-0002v8-98; Mon, 04 Mar 2024 08:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rh84V-0002uO-BN
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:09:36 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rh84T-0002qc-H2
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:09:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C02664E682;
 Mon,  4 Mar 2024 13:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709557768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UifR1e7mpMgMBnoPG3VQTWtcj+7k0+N9LrJoEXZs44=;
 b=HYWQrydZQmJ/ai3kMgjjXEDUluVB9WRnXFO6oDRkflJ8/OUJcnNy86PUVk0yHYFKKKtQlD
 9nXx+pyHp4+W7aK0lQmpVQvSfbf21cEDw+JMyQ1Q+dL3Di6aIR94mBHeNNRkTf4QVgJLJN
 aP4mBnwQ71Dt3gKJrEYotgXXtoy+trA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709557768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UifR1e7mpMgMBnoPG3VQTWtcj+7k0+N9LrJoEXZs44=;
 b=+epAawF3ezP1DvSoSbzSFSgaVyt1fjH8ibBvV8Yjw3EM66FpOgPTzl0NrOi5Lcd3wNNP5K
 wkd7HzZRKXe4rYBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709557768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UifR1e7mpMgMBnoPG3VQTWtcj+7k0+N9LrJoEXZs44=;
 b=HYWQrydZQmJ/ai3kMgjjXEDUluVB9WRnXFO6oDRkflJ8/OUJcnNy86PUVk0yHYFKKKtQlD
 9nXx+pyHp4+W7aK0lQmpVQvSfbf21cEDw+JMyQ1Q+dL3Di6aIR94mBHeNNRkTf4QVgJLJN
 aP4mBnwQ71Dt3gKJrEYotgXXtoy+trA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709557768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UifR1e7mpMgMBnoPG3VQTWtcj+7k0+N9LrJoEXZs44=;
 b=+epAawF3ezP1DvSoSbzSFSgaVyt1fjH8ibBvV8Yjw3EM66FpOgPTzl0NrOi5Lcd3wNNP5K
 wkd7HzZRKXe4rYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B55D13A5B;
 Mon,  4 Mar 2024 13:09:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 79sYBQjI5WUBQQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 Mar 2024 13:09:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Claudio Fontana
 <cfontana@suse.de>
Subject: Re: [PATCH v6 00/23] migration: File based migration with multifd
 and mapped-ram
In-Reply-To: <ZeXBsR0ctl4evdYb@redhat.com>
References: <20240229153017.2221-1-farosas@suse.de> <ZeXAGEVFWt4Z8QeN@x1n>
 <ZeXBsR0ctl4evdYb@redhat.com>
Date: Mon, 04 Mar 2024 10:09:25 -0300
Message-ID: <87bk7unny2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.24 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.04)[57.57%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.11)[-0.538];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Mar 04, 2024 at 08:35:36PM +0800, Peter Xu wrote:
>> Fabiano,
>>=20
>> On Thu, Feb 29, 2024 at 12:29:54PM -0300, Fabiano Rosas wrote:
>> > =3D> guest: 128 GB RAM - 120 GB dirty - 1 vcpu in tight loop dirtying =
memory
>>=20
>> I'm curious normally how much time does it take to do the final fdatasyn=
c()
>> for you when you did this test.

I haven't looked at the fdatasync() in isolation. I'll do some
measurements soon.

>>=20
>> I finally got a relatively large system today and gave it a quick shot o=
ver
>> 128G (100G busy dirty) mapped-ram snapshot with 8 multifd channels.  The
>> migration save/load does all fine, so I don't think there's anything wro=
ng
>> with the patchset, however when save completes (I'll need to stop the
>> workload as my disk isn't fast enough I guess..) I'll always hit a super
>> long hang of QEMU on fdatasync() on XFS during which the main thread is =
in
>> UNINTERRUPTIBLE state.

> That isn't very surprising. If you don't have O_DIRECT enabled, then
> all that disk I/O from the migrate is going to be in RAM, and thus the
> fdatasync() is likely to trigger writing out alot of data.
>
> Blocking the main QEMU thread though is pretty unhelpful. That suggests
> the data sync needs to be moved to a non-main thread.

Perhaps if we move the fsync to the same spot as the multifd thread sync
instead of having a big one at the end? Not sure how that looks with
concurrency in the mix.

I'll have to experiment a bit.


