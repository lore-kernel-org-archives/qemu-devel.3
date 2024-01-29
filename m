Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA06C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 20:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUYg1-0002nI-7g; Mon, 29 Jan 2024 15:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rUYfu-0002ln-9j; Mon, 29 Jan 2024 15:56:14 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rUYfs-000701-JH; Mon, 29 Jan 2024 15:56:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2EAC02224F;
 Mon, 29 Jan 2024 20:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706561770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jJtnQkJYXBREBe2NIIyvv1D5f/rKi7mv/SfR4pH5Qvs=;
 b=1XEKg1yMZAA3vWNRFwdI5bxOeaca7sO/i2V/gPtZIF1JAQN4ASAWVwx/ioEtUaR7J2wodD
 c4YrFXMJuZsHNJKErJeCY5DYXhry0yNUEwAX7ZPE2e15ECYkkCZOYhdC7VWs609nqdA561
 y4Kwf+I7Uyid4HqqlBhXKWc1MfxtX8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706561770;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jJtnQkJYXBREBe2NIIyvv1D5f/rKi7mv/SfR4pH5Qvs=;
 b=GEsMauAzNFmthdB63rN6hMTRQjtrZ3oug3/0BnMDCx0nnEC4UONWgJNCNogDjQH34/g1zc
 eJzwQq0LT0MSvKCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706561768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jJtnQkJYXBREBe2NIIyvv1D5f/rKi7mv/SfR4pH5Qvs=;
 b=OxlLPEfWmA8sXkUTlc2egwiHRqRb4aKdV0MwGVaD3kHqTVEjNmKzLkjparmFwdN4MZjohi
 GFwjYYjK+VMEmOO9/VOe89HiLUXmZ9kCmWAaFxaA94eXY/4/vtdmBVsZ/91PaG91PxUGqn
 2gOdNsRqFyGUFGfrQS9oquc2oEGlpT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706561768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jJtnQkJYXBREBe2NIIyvv1D5f/rKi7mv/SfR4pH5Qvs=;
 b=icfYJQ9uC3+j+ZBqeOOzadkydas6F1MWUQ5kx8v1kQJf+vwvQIKbNves4iRpMoAzpjtNaH
 Srwf1SyXoH2PD/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A587312FF7;
 Mon, 29 Jan 2024 20:56:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K89MG+cQuGVUDwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Jan 2024 20:56:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, Het Gala <het.gala@nutanix.com>,
 qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, armbru@redhat.com, qemu-stable
 <qemu-stable@nongnu.org>
Subject: Re: [PATCH] Make 'uri' optional for migrate QAPI
In-Reply-To: <1023dde3-4de0-4ec1-85a6-238ed8e16454@tls.msk.ru>
References: <20240123064219.40514-1-het.gala@nutanix.com>
 <1023dde3-4de0-4ec1-85a6-238ed8e16454@tls.msk.ru>
Date: Mon, 29 Jan 2024 17:56:05 -0300
Message-ID: <871q9zq2oq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.21 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.11)[66.45%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 23.01.2024 09:42, Het Gala:
>> 'uri' argument should be optional, as 'uri' and 'channels'
>> arguments are mutally exclusive in nature.
>> 
>> Fixes: 074dbce5fcce (migration: New migrate and
>> migrate-incoming argument 'channels')
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> ---
>>   qapi/migration.json | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index eb2f883513..197d3faa43 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1757,7 +1757,7 @@
>>   #
>>   ##
>>   { 'command': 'migrate',
>> -  'data': {'uri': 'str',
>> +  'data': {'*uri': 'str',
>>              '*channels': [ 'MigrationChannel' ],
>>              '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
>>              '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
>
> This seems like a stable material too, - please let me know if it is not.
>

Yes, those API changes went into 8.2.

Thanks

