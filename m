Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E0BC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6upP-0007WB-Bj; Wed, 16 Sep 2026 14:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6uox-0007Cb-6H
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:57:29 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6uot-00068z-WB
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:57:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F62C1FF23;
 Wed, 16 Sep 2026 18:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789585037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oWxw4cgxCPEMKE9QZA2KQ5WqruOg+X6rJYpv+7DUpmg=;
 b=TzaucIK7okViw/sgQ6QB6OTUeamSHI35sKSYbhjO/0yfChT/ApXReHezUUrhKw4Ftou4no
 ILfJc+TNFUN5bGYowLdbBi2s4MrFEIywbGEBto/ZAGNFOYVQzH7lmp1ezwxh+xsp5/F6rY
 /oPVkTkYWcqN7MxvwaVgnFYanwgL2Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789585037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oWxw4cgxCPEMKE9QZA2KQ5WqruOg+X6rJYpv+7DUpmg=;
 b=aDoVDMLKhv3GGQAjbAqwtZn9x8TpI7aWZ98ViKwXM1sew26YBNJUPChXFWjFXmWVZQkY5+
 3aBdD0RuF78p81Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zDwIbWsl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0RGTdIKq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789585033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oWxw4cgxCPEMKE9QZA2KQ5WqruOg+X6rJYpv+7DUpmg=;
 b=zDwIbWslXjtMfxjh0Joem2Bc6+/3OnrmLQswOm4Mo3t1g8lYcNf3iJ/IGlKyku1tMC+aZF
 b4uNH+0uu7H+HWIfuLwAJE/kwdoUCbXHggcD6Gjy37TG6QrmcHspaug3e9YOYwoccNLBNg
 ZVcOITBdTxG5MiNudHwxAPuGdood258=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789585033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oWxw4cgxCPEMKE9QZA2KQ5WqruOg+X6rJYpv+7DUpmg=;
 b=0RGTdIKqoA1H2M6alHtRbSEcreRlNrQvuvnyicTAmhCXj5eAMzFGq/+XRKedGeoU7WQhk/
 Bt6Iho+KdtcDE9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3D821348F;
 Wed, 16 Sep 2026 18:57:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fn+1IYjmqmqiewAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 16 Sep 2026 18:57:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, "Maciej S. Szmigiero"
 <maciej.szmigiero@oracle.com>, Mark Kanda <mark.kanda@oracle.com>, Ben
 Chaney <bchaney@akamai.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH 1/1] migration/cpr: lock the cpr state
In-Reply-To: <aqrhPxFO7zHvZgs5@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260916132428.1628553-1-den@openvz.org>
 <aqrhPxFO7zHvZgs5@zhexu-thinkpadt14gen5.rmtcaon.csb>
Date: Wed, 16 Sep 2026 15:57:06 -0300
Message-ID: <87v785rpml.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6F62C1FF23
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[openvz.org:email,akamai.com:email,suse.de:dkim,suse.de:email,suse.de:mid,oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Sep 16, 2026 at 03:24:28PM +0200, Denis V. Lunev wrote:
>> From: Denis V. Lunev <den@openvz.org>
>> 
>> The cpr state is a process wide registry of the resources that have to
>> survive an exec. Entries are added and dropped from realize and teardown
>> paths all over the tree, and a caller has no way to tell which thread the
>> next caller will run in.
>> 
>> The state carries no serialization of its own. It is safe today only
>> because its callers happen to hold the BQL, and that is a property of
>> where those callers live rather than anything the interface promises or
>> checks. A caller that is correct within its own subsystem can therefore
>> break this one from a distance: two that overlap corrupt the registry,
>> and the next lookup walks an entry that has already been freed.
>> 
>> Give the state a lock of its own instead of relying on that. Entries
>> move when a device is realized, when a resource is handed over, and when
>> a migration starts, so none of this is on a hot path and an uncontended
>> mutex costs nothing.
>> 
>> Take the lock in every accessor and across the save and load walks.
>> Holding it over the walk callbacks is safe because none of them comes
>> back through this interface. State that is not reached through these
>> accessors, such as the VFIO device list that hw/vfio manipulates
>> directly, stays outside it.
>> 
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Fabiano Rosas <farosas@suse.de>
>> Cc: Mark Kanda <mark.kanda@oracle.com>
>> Cc: Ben Chaney <bchaney@akamai.com>
>> Cc: Steve Sistare <steven.sistare@oracle.com>
>
> Is there a real problem anywhere?
>
> My gut feeling is we shouldn't be randomly adding fds into cpr unless we're
> creating a new device or so, which should normally need bql already.
>
> To ask in another way, shall we simply assert bql_locked()?
>
> Thanks,

Fair questions, let's see what Denis says.

From my point of view, if the work is already done to use a lock, I'd
take it; one less place for us to bother when dealing with BQL issues.

(on the other hand, I'm not doing any active use or testing of cpr aside
from migration-test, so my opinion is the least important here)

