Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B29EA3C5D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wApGZ-0003AA-Hu; Thu, 09 Apr 2026 09:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1wApGY-00039o-0y
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:17:50 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1wApGV-0006Ks-V0
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:17:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 47A295BD26;
 Thu,  9 Apr 2026 13:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775740666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GcJ6Ha2tz+LOYbozpN6+iSJS4+XhkXs1K34YJC//NHs=;
 b=u8bC9b4E98pHhKGEP6I54N/2g4nWMKlh4APArpQavvEAzImc8M7ES6yuTx20vyw4GQ5LVP
 vjYDM0vaeTJO1ycGH8w4cmTMeI3dJxacNdTl6eBQe/PKT71BU3BAiC52RDs/xM9z+NDiG/
 5mbbYDWQFJ1GHbWWQfqMvMrwctJm03c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775740666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GcJ6Ha2tz+LOYbozpN6+iSJS4+XhkXs1K34YJC//NHs=;
 b=J7djs8cudFbYUL+FrMcxO781cxkWx2YR6g+jmfkSUZE3cb1GWiP85A7KDVmwj6BBfTjBAo
 ZhzoCRCekiXsNZCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u8bC9b4E;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J7djs8cu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775740666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GcJ6Ha2tz+LOYbozpN6+iSJS4+XhkXs1K34YJC//NHs=;
 b=u8bC9b4E98pHhKGEP6I54N/2g4nWMKlh4APArpQavvEAzImc8M7ES6yuTx20vyw4GQ5LVP
 vjYDM0vaeTJO1ycGH8w4cmTMeI3dJxacNdTl6eBQe/PKT71BU3BAiC52RDs/xM9z+NDiG/
 5mbbYDWQFJ1GHbWWQfqMvMrwctJm03c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775740666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GcJ6Ha2tz+LOYbozpN6+iSJS4+XhkXs1K34YJC//NHs=;
 b=J7djs8cudFbYUL+FrMcxO781cxkWx2YR6g+jmfkSUZE3cb1GWiP85A7KDVmwj6BBfTjBAo
 ZhzoCRCekiXsNZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C51264A0B3;
 Thu,  9 Apr 2026 13:17:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JldLLfmm12nFNgAAD6G6ig
 (envelope-from <cfontana@suse.de>); Thu, 09 Apr 2026 13:17:45 +0000
Message-ID: <e51e574b-d743-4010-be16-782fa6233711@suse.de>
Date: Thu, 9 Apr 2026 15:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] migration: include timing and RAM stats on
 destination when query-migrate
To: =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jim Fehlig <jfehlig@suse.com>, qemu-devel@nongnu.org,
 Trieu Huynh <vikingtc4@gmail.com>, Fiona Ebner <f.ebner@proxmox.com>
References: <20260405152612.93027-1-viking4@gmail.com>
 <878qb05gq7.fsf@suse.de> <ada038hgmY9hNqPK@x1.local>
 <5f29c2dd-95eb-44c6-b22e-1909f7453cdf@suse.de>
 <1775739757.quazquvuzm.astroid@yuna.none>
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <1775739757.quazquvuzm.astroid@yuna.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,proxmox.com:url];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,suse.com,nongnu.org,gmail.com,proxmox.com];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid]
X-Rspamd-Queue-Id: 47A295BD26
Received-SPF: pass client-ip=195.135.223.131; envelope-from=cfontana@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 4/9/26 15:08, Fabian Grünbichler wrote:
> On April 9, 2026 12:08 pm, Claudio Fontana wrote:
>> On 4/8/26 22:04, Peter Xu wrote:
>>> On Mon, Apr 06, 2026 at 11:02:56AM -0300, Fabiano Rosas wrote:
>>>> Trieu Huynh <vikingtc4@gmail.com> writes:
>>>>
>>>>> From: Trieu Huynh <vikingtc4@gmail.com>
>>>>>
>>>>> When query-migrate is called on the *destination* QEMU after a precopy
>>>>> migration completes it returns only {"status": "completed"} — no timing,
>>>>> no RAM statistics.  The source correctly returns total-time, downtime,
>>>>> setup-time, and full ram stats.
> 
>>>>> [..]
>>>>>
>>>>
>>>> Hi, remember to copy the interested people in your series. Using
>>>> get_maintainers is correct, but when there's already a discussion about
>>>> the topic it's good to add some CCs manually.
>>>>
>>>> +CC Daniel and Claudio
>>>
>>> The request is a valid one.  Said that, redo accounting on both sides seem
>>> to be a duplicated work and overkill to me, if src has everything.
>>>
>>> Is there a way we can make Libvirt always query the results before src dies
>>> and report it somewhere?  I recall these info were captured somewhere, do
>>> we at least dump them into logs?
>>>
>>> Thanks,
>>>
>>
>> I am interested in the outcome, but I think the approach shown here is fine, the amount of duplication seems minimal to me.
>>
>> That said if we _have_ to keep libvirt in the picture, I think I see a possible alternative, but then the feature is not available to anyone that does not use libvirt. At the same time, if libvirt is not used, one is free to keep source QEMU alive and query the stats, like I think Proxmox does.
> 
> that is correct, we call query-migrate in a loop while migrating both to
> log progress and to manage migration parameters, and manually switch
> execution and ownership over to the target node once the migration has
> converged:
> 
> https://git.proxmox.com/?p=qemu-server.git;a=blob;f=src/PVE/QemuMigrate.pm;h=f7ec322770a47dcc8b89109ecfa6f15ea140f30f;hb=HEAD#l1423

Hello Fabian, thanks for the confirmation,
would it simplify your code if you had the stats already carried over by QEMU to the new QEMU instance?

I suspect you don't want to touch that code without a very compelling reason, but at least in principle it should make things easier?

> 
>> So with libvirt, I think we need a way to tell libvirt to keep the source QEMU alive before the actual switchover and the source QEMU is destroyed,
>> so that we can do everything that needs to be done from the platform layer before the source QEMU is lost.
>> It might go beyond querying for stats using QEMU and libvirt.
>>
>> Something similar to (and potentially combined with) virDomainMigrateFlags VIR_MIGRATE_PAUSE, for example:
>>
>> VIR_MIGRATE_NO_SOURCE_SHUTOFF
>>
>> So one might say:
>>
>> flags = VIR_MIGRATE_LIVE | VIR_MIGRATE_PERSIST_DEST | VIR_MIGRATE_UNDEFINE_SOURCE | VIR_MIGRATE_PAUSE | VIR_MIGRATE_NO_SOURCE_SHUTOFF
>> new_domain = virDomainMigrate3(old_domain, conn, params, nparams, flags)
>>
>> and then we could do everything that needs to be done from the platform layer,
>> then issue a virDomainResume to start the domain on destination,
>> and maybe a virDomainDestroyFlags on the original domain to terminate it on the source.
>>
>> But I would still favor the simplicity and the overall applicability of this series from Trieu Huynh.
>>
>> Thanks,
>>
>> Claudio
>>
>>
>>
> 


