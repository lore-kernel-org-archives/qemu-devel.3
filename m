Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E86BC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRXzi-0006qx-CL; Wed, 10 Jul 2024 10:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sRXzf-0006m0-V4; Wed, 10 Jul 2024 10:08:27 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sRXzd-0002Yp-Mz; Wed, 10 Jul 2024 10:08:27 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 703DF21BD4;
 Wed, 10 Jul 2024 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720620503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxBSaZMT0BEUWVwIq7OYkllCdR6/YSjPnnCo840jolM=;
 b=eSaS2UjISRAqdgslSA1Hh9oRwWLPxDx/0hrCnSnbbie5aP/Mzdf+xWFJBB0Cp50KlJ257K
 uzxSjnJ490MAiCP92oQbmZSd9o48xVhZCZYnae9LPKN6HZkC8IQ2yTqqscFhGK9EJHTRae
 2UB9bggK0tRqJRXEmWd23mdWQWhyHqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720620503;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxBSaZMT0BEUWVwIq7OYkllCdR6/YSjPnnCo840jolM=;
 b=a2tcPPtjL+ljN+4w1wknOlefGcDwB3XCeVU7DXLFy+ppoomUYTZbpcPBfUMUzzS6cvB9Ym
 OtmoLIPSE9VGbQCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eSaS2UjI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a2tcPPtj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720620503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxBSaZMT0BEUWVwIq7OYkllCdR6/YSjPnnCo840jolM=;
 b=eSaS2UjISRAqdgslSA1Hh9oRwWLPxDx/0hrCnSnbbie5aP/Mzdf+xWFJBB0Cp50KlJ257K
 uzxSjnJ490MAiCP92oQbmZSd9o48xVhZCZYnae9LPKN6HZkC8IQ2yTqqscFhGK9EJHTRae
 2UB9bggK0tRqJRXEmWd23mdWQWhyHqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720620503;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxBSaZMT0BEUWVwIq7OYkllCdR6/YSjPnnCo840jolM=;
 b=a2tcPPtjL+ljN+4w1wknOlefGcDwB3XCeVU7DXLFy+ppoomUYTZbpcPBfUMUzzS6cvB9Ym
 OtmoLIPSE9VGbQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5495137D2;
 Wed, 10 Jul 2024 14:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sU+OKtaVjmaRNQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Jul 2024 14:08:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Tyrone Ting
 <kfting@nuvoton.com>, Bin Meng <bmeng.cn@gmail.com>, Hao Wu
 <wuhaotsh@google.com>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-arm@nongnu.org, Joel
 Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>, =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 06/17] hw/sd/sdcard: Do not store vendor data on
 block drive (CMD56)
In-Reply-To: <Zo2lLLAwcZ8bBvO2@x1n>
References: <20240627162232.80428-1-philmd@linaro.org>
 <20240627162232.80428-7-philmd@linaro.org> <87cynmfggx.fsf@suse.de>
 <Zo2lLLAwcZ8bBvO2@x1n>
Date: Wed, 10 Jul 2024 11:08:20 -0300
Message-ID: <87a5ipfigb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 703DF21BD4
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[18];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[linaro.org,nongnu.org,redhat.com,nuvoton.com,gmail.com,google.com,amd.com,kaod.org,jms.id.au,lists.libvirt.org];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Tue, Jul 09, 2024 at 05:38:54PM -0300, Fabiano Rosas wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>> > "General command" (GEN_CMD, CMD56) is described as:
>> >
>> >   GEN_CMD is the same as the single block read or write
>> >   commands (CMD24 or CMD17). The difference is that [...]
>> >   the data block is not a memory payload data but has a
>> >   vendor specific format and meaning.
>> >
>> > Thus this block must not be stored overwriting data block
>> > on underlying storage drive. Keep it in a dedicated
>> > 'vendor_data[]' array.
>> >
>> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> > Tested-by: C=C3=A9dric Le Goater <clg@redhat.com>
>> > ---
>> > RFC: Is it safe to reuse VMSTATE_UNUSED_V() (which happens
>> > to be the same size)?
>>=20
>> Hi, sorry it took some time to get to this, I had just left for vacation
>> when you first posted.
>
> And I totally overlooked there's the email.. until you replied.  Welcome
> back.

Thanks!

>
>>=20
>> I think it's ok:
>>=20
>> {
>>   "field": "unused",
>>   "version_id": 1,
>>   "field_exists": false,
>>   "size": 512
>> },
>>=20
>> vs.
>>=20
>> {
>>   "field": "vendor_data",
>>   "version_id": 0,
>>   "field_exists": false,
>>   "num": 512,
>>   "size": 1
>> },
>>=20
>> The unused field was introduced in 2016 so there's no chance of
>> migrating a QEMU that old to/from 9.1.
>
> What happens if an old qemu 9.0 sends rubbish here to a new QEMU, while t=
he
> new QEMU would consider it meaningful data?

It will send zeros, no? The code will have to cope with that. The
alternative is to put the vendor_data in a subsection and the code will
also have to cope with the lack of data when the old QEMU doesn't send
it.

