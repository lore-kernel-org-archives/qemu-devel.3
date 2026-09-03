Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89092C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Aku-00089v-8r; Thu, 03 Sep 2026 12:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x2Aks-00089M-L5; Thu, 03 Sep 2026 12:57:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x2Akq-0001gd-Sd; Thu, 03 Sep 2026 12:57:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE0601FCF6;
 Thu,  3 Sep 2026 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788454650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VmjQCivKmURVXJpa2FBHGJpG/fmJb3szgzLCFZLjTQ=;
 b=NwtpCZ2YUkqC+50bK3gQ3lMbGwkuvAb+psaCrhMrzvy3216TBYxZ2UKWpMq7PO4O3YSdzM
 znovybVOe8puafWcspuZNSNYmngN9NkwW+fO5IUxzfkc+l2BG0qr8mtxMYzx7BdxSWC8Fi
 N8C+7nNOPiXAxNwyODHYuhxfxyRRMfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788454650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VmjQCivKmURVXJpa2FBHGJpG/fmJb3szgzLCFZLjTQ=;
 b=5BcupLuVqp2+xggP+J9U8B4dj610BCqay6b4UC6RrCBEbNE1A/volq9YbPNsaA4HtlCVyu
 Zeap5TynRcIlFABA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ERDTnlhW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GQ7QHYBJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788454646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VmjQCivKmURVXJpa2FBHGJpG/fmJb3szgzLCFZLjTQ=;
 b=ERDTnlhWQpwaeMBxA50AOS0YIv93XNkLv1snR5whTD5NxriZEDtujhMcVZsNzTXEzi5F9i
 iFpUoNbLtaiz+8XeVeAq9Js0VS6kSXWfm4w5zoEod/LycXe0b1Vnw7EgmSlHqqaDWdnhxv
 tAgVXXvc0taKMema/0lsCvU1VKKk1S4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788454646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VmjQCivKmURVXJpa2FBHGJpG/fmJb3szgzLCFZLjTQ=;
 b=GQ7QHYBJE+J/8FhjtaT02zNmiHV2Q6P5P8ivAZtVB/pH8N8fd2/q7ouBax4IY4IoVEnxie
 TI/ZDm/RCYorbxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3645C136E6;
 Thu,  3 Sep 2026 16:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sQVuAvammWoCKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Sep 2026 16:57:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Denis V. Lunev" <den@virtuozzo.com>, =?utf-8?Q?Daniel_P=2E_Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Reinoud Zandijk
 <reinoud@netbsd.org>
Subject: Re: [PATCH 0/7] tests/qtest: fix the disk tests on a host with a
 small /tmp
In-Reply-To: <8604eafa-c683-4d89-b180-5b26c56b7817@virtuozzo.com>
References: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
 <20260824200627.2180635-1-den@openvz.org>
 <a1a7cdc7-5458-4d1b-bf1e-9aa89502317b@redhat.com>
 <apAZaRwIdm1yLiLV@redhat.com>
 <8604eafa-c683-4d89-b180-5b26c56b7817@virtuozzo.com>
Date: Thu, 03 Sep 2026 13:57:23 -0300
Message-ID: <87jyp2gtn0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AE0601FCF6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DKIM_TRACE(0.00)[suse.de:+]
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

"Denis V. Lunev" <den@virtuozzo.com> writes:

> On 8/27/26 13:03, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, Aug 27, 2026 at 12:16:56PM +0200, Thomas Huth wrote:
>>>  Hi Denis!
>>>
>>> Please make sure to CC: the qtest maintainer (Fabiano Rosas) on series =
like
>>> this.
>>>
>>> On 24/08/2026 22.06, Denis V. Lunev wrote:
>>>> John reported ide-test dying at startup in the NetBSD VM:
>>>>
>>>>    ERROR:../src/tests/qtest/ide-test.c:1260:main: assertion failed:
>>>>    (ret =3D=3D 0)
>>>>
>>>> The hypothesys is that the ftruncate() of a 64 MiB scratch image. NetB=
SD
>>>> mounts /tmp as a tmpfs sized at 25% of RAM and charges a file its full
>>>> length themoment it is extended, so a sparse image is not free there a=
nd
>>>> the call returns ENOSPC. The assert dates to 2013, nothing regressed.
>>> Does NetBSD have another file like /var/tmp that might be friendlier to
>>> sparse files? If so, maybe that should be used instead?
>>>
>>> OTOH, our NetBSD VM in tests/vm/ uses 4G of RAM, so a temporary file wi=
th
>>> just 64 MiB should really not be a problem...?
>> Or this is a concurrency scaling problem, or racing with another test
>> that also uses stuff ?
>>
>> We hard code memory to 4 GB, but -smp we scale to "$NUM-CPUs / 2"
>> for the "make vm-build-DIST" commands.
>>
>> IOW, regardless of whether QEMU is launched with -smp 1 or -smp 20,
>> we only give it 4 GB to play with. We could be using a lot of RAM
>> for concurrent build jobs leaving almost nothing for the tmpfs for
>> the test.
>>
>> If we were that close to exhaustion I'd expected to see out of
>> memory errors, but I'm unclear what NetBSD's behaviour is in
>> this respect ?  Maybe normal RAM usage can be pushed to swap
>> (of which I see another 4 GB) while tmpfs can't be pushed
>> to swap ?
>>
>>
>>
>>
>> With regards,
>> Daniel
> Guys,
>
> will somebody take a look into what was done?
> This makes sense anyway - unified same class error tracking
> plus requirements reduction.
>

I cannot reproduce this. I also don't think ENOSPC on 64MB is something
worth the churn at all.

> Or if nobody care I could just push along with another
> test fix?
>
> Thank you in advance,
> =C2=A0 =C2=A0 Den

