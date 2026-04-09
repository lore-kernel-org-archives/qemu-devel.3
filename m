Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD976EA3C21
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmJw-0004eN-Ds; Thu, 09 Apr 2026 06:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1wAmJq-0004aB-8A
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:09:03 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1wAmJl-0001dK-L7
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:09:01 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 423C34EE9F;
 Thu,  9 Apr 2026 10:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775729330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XbEA5OnMLUTPZDi3bwfwfipCn0lwtIzr4jW07Y9h90c=;
 b=CnCKGBTHHrg+kwaLzI03KktCPYvqQZvDIJJwMjVDb0o52LbZczORQpAT3h/PYR5VKBIZN1
 Im8O4wV4acgj7p37MHVl9pagE62BMGEql/k1rV4DTO9VHXelLkxVy1AZSlLW6hjrl86skA
 soosJ9gGCXJDynA3wIF0d/BTnnN+tls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775729330;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XbEA5OnMLUTPZDi3bwfwfipCn0lwtIzr4jW07Y9h90c=;
 b=3vY4u5HVF+0sQpong4wwXKJFkAmRxePnHYooeP2Xr0v/UMyZe3bkmDnNekk4mI6+PYm4rs
 nKuG9cEX75gbspAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775729330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XbEA5OnMLUTPZDi3bwfwfipCn0lwtIzr4jW07Y9h90c=;
 b=CnCKGBTHHrg+kwaLzI03KktCPYvqQZvDIJJwMjVDb0o52LbZczORQpAT3h/PYR5VKBIZN1
 Im8O4wV4acgj7p37MHVl9pagE62BMGEql/k1rV4DTO9VHXelLkxVy1AZSlLW6hjrl86skA
 soosJ9gGCXJDynA3wIF0d/BTnnN+tls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775729330;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XbEA5OnMLUTPZDi3bwfwfipCn0lwtIzr4jW07Y9h90c=;
 b=3vY4u5HVF+0sQpong4wwXKJFkAmRxePnHYooeP2Xr0v/UMyZe3bkmDnNekk4mI6+PYm4rs
 nKuG9cEX75gbspAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDE664A0B3;
 Thu,  9 Apr 2026 10:08:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id idBNM7F612kBegAAD6G6ig
 (envelope-from <cfontana@suse.de>); Thu, 09 Apr 2026 10:08:49 +0000
Message-ID: <5f29c2dd-95eb-44c6-b22e-1909f7453cdf@suse.de>
Date: Thu, 9 Apr 2026 12:08:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] migration: include timing and RAM stats on
 destination when query-migrate
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org,
 Jim Fehlig <jfehlig@suse.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260405152612.93027-1-viking4@gmail.com>
 <878qb05gq7.fsf@suse.de> <ada038hgmY9hNqPK@x1.local>
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <ada038hgmY9hNqPK@x1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org,suse.com,redhat.com];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
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

On 4/8/26 22:04, Peter Xu wrote:
> On Mon, Apr 06, 2026 at 11:02:56AM -0300, Fabiano Rosas wrote:
>> Trieu Huynh <vikingtc4@gmail.com> writes:
>>
>>> From: Trieu Huynh <vikingtc4@gmail.com>
>>>
>>> When query-migrate is called on the *destination* QEMU after a precopy
>>> migration completes it returns only {"status": "completed"} — no timing,
>>> no RAM statistics.  The source correctly returns total-time, downtime,
>>> setup-time, and full ram stats.
>>>
>>> This series fixes the gap in two commits:
>>>
>>> * commit 1: Track start/end timestamps and per-page-type counters in
>>>   MigrationIncomingState, recorded in the receive path.
>>>
>>> * commit 2: Make source-only MigrationStats fields optional in the QAPI
>>>   schema so the destination can populate info->ram with only the fields
>>>   that are meaningful on the receive side.  Fields computed from tracked
>>>   counters (transferred, normal, duplicate, mbps, pages-per-second) are
>>>   shown; source-only fields (dirty-sync-count, precopy-bytes, etc.) are
>>>   absent.
>>>
>>> The QAPI change (commit 2) is ABI-compatible: optional fields that are
>>> not set are simply absent from the output.  Source-side callers are
>>> unaffected because populate_ram_info() sets all optional fields via
>>> has_* setters, so the source output is identical to before.
>>>
>>> On dst, {"execute":"query-migrate"}
>>> * As-is:
>>> {
>>>     "return": {
>>>         "status": "completed"
>>> }
>>> * To-be:
>>> {
>>>     "return": {
>>>         "status": "completed",
>>>         "total-time": 94,
>>>         "ram": {
>>>             "total": 554508288,
>>>             "pages-per-second": 1440234,
>>>             "page-size": 4096,
>>>             "remaining": 0,
>>>             "mbps": 97.955404255319152,
>>>             "transferred": 1150976,
>>>             "duplicate": 135101,
>>>             "normal-bytes": 1150976,
>>>             "normal": 281
>>>         }
>>>     }
>>> }
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3151
>>>
>>> Trieu Huynh (2):
>>>   migration: track timing and received pages in MigrationIncomingState
>>>   migration: expose RAM stats and timing on destination via
>>>     query-migrate
>>>
>>>  migration/migration.c | 37 +++++++++++++++++++++++++++++++++++++
>>>  migration/migration.h | 17 +++++++++++++++++
>>>  migration/ram.c       |  3 +++
>>>  qapi/migration.json   | 14 +++++++-------
>>>  4 files changed, 64 insertions(+), 7 deletions(-)
>>
>> Hi, remember to copy the interested people in your series. Using
>> get_maintainers is correct, but when there's already a discussion about
>> the topic it's good to add some CCs manually.
>>
>> +CC Daniel and Claudio
> 
> The request is a valid one.  Said that, redo accounting on both sides seem
> to be a duplicated work and overkill to me, if src has everything.
> 
> Is there a way we can make Libvirt always query the results before src dies
> and report it somewhere?  I recall these info were captured somewhere, do
> we at least dump them into logs?
> 
> Thanks,
> 

I am interested in the outcome, but I think the approach shown here is fine, the amount of duplication seems minimal to me.

That said if we _have_ to keep libvirt in the picture, I think I see a possible alternative, but then the feature is not available to anyone that does not use libvirt. At the same time, if libvirt is not used, one is free to keep source QEMU alive and query the stats, like I think Proxmox does.

So with libvirt, I think we need a way to tell libvirt to keep the source QEMU alive before the actual switchover and the source QEMU is destroyed,
so that we can do everything that needs to be done from the platform layer before the source QEMU is lost.
It might go beyond querying for stats using QEMU and libvirt.

Something similar to (and potentially combined with) virDomainMigrateFlags VIR_MIGRATE_PAUSE, for example:

VIR_MIGRATE_NO_SOURCE_SHUTOFF

So one might say:

flags = VIR_MIGRATE_LIVE | VIR_MIGRATE_PERSIST_DEST | VIR_MIGRATE_UNDEFINE_SOURCE | VIR_MIGRATE_PAUSE | VIR_MIGRATE_NO_SOURCE_SHUTOFF
new_domain = virDomainMigrate3(old_domain, conn, params, nparams, flags)

and then we could do everything that needs to be done from the platform layer,
then issue a virDomainResume to start the domain on destination,
and maybe a virDomainDestroyFlags on the original domain to terminate it on the source.

But I would still favor the simplicity and the overall applicability of this series from Trieu Huynh.

Thanks,

Claudio

