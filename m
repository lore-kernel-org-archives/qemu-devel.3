Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1F4C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrN4-0008L1-RV; Wed, 19 Feb 2025 16:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tkrN2-0008Ce-0R
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:12:40 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tkrMz-0000d9-Us
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:12:39 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 01B281F871;
 Wed, 19 Feb 2025 21:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739999555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g+7dqrnqSXfHeavwbe5UtsiRiDkzWdTQHfyhnu8ESsU=;
 b=Cfniukb9D19TYll86AA5sLa6IqQF4/ohUdAwPnzMxw96mSzNfeFhsn9TaILtxWIgM5tl1Q
 jQX5bKElGbBEuZpwnFvB/MnI2VvwesrG6s4V3tOfI7UNuMlIEtUuZC4E9xfwGQDtZ/82bM
 OL/OEfg+SyfvAHyQRQDmespQlpT5BDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739999555;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g+7dqrnqSXfHeavwbe5UtsiRiDkzWdTQHfyhnu8ESsU=;
 b=Z9Ilz/dpDNkMTlPX/wjyUQqdTppfCUkx15g4N64ePmp+7whRIvifZ/do3sn9OZ1MB40iUZ
 uutMqtMl+b33xeDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739999555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g+7dqrnqSXfHeavwbe5UtsiRiDkzWdTQHfyhnu8ESsU=;
 b=Cfniukb9D19TYll86AA5sLa6IqQF4/ohUdAwPnzMxw96mSzNfeFhsn9TaILtxWIgM5tl1Q
 jQX5bKElGbBEuZpwnFvB/MnI2VvwesrG6s4V3tOfI7UNuMlIEtUuZC4E9xfwGQDtZ/82bM
 OL/OEfg+SyfvAHyQRQDmespQlpT5BDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739999555;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g+7dqrnqSXfHeavwbe5UtsiRiDkzWdTQHfyhnu8ESsU=;
 b=Z9Ilz/dpDNkMTlPX/wjyUQqdTppfCUkx15g4N64ePmp+7whRIvifZ/do3sn9OZ1MB40iUZ
 uutMqtMl+b33xeDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D4961366F;
 Wed, 19 Feb 2025 21:12:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id voXNCkJJtmcFIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Feb 2025 21:12:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Chaney, Ben" <bchaney@akamai.com>, "steven.sistare@oracle.com"
 <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Cc: "peterx@redhat.com" <peterx@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "Glasgall, Anna" <aglasgal@akamai.com>, "Hunt,
 Joshua" <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>
Subject: Re: Live update: q35 and pc-i440fx support (vapic)
In-Reply-To: <6290683B-76B5-42E1-AA17-1F3AC58FE9D7@akamai.com>
References: <6290683B-76B5-42E1-AA17-1F3AC58FE9D7@akamai.com>
Date: Wed, 19 Feb 2025 18:12:31 -0300
Message-ID: <87mseh8wqo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
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

"Chaney, Ben" <bchaney@akamai.com> writes:

> Hello Steve,
>
> Thank you for posting the qemu cpr-transfer patches on qemu-devel. I am experimenting with them, and I noticed that cpr-transfer is failing on some qemu machine types. cpr-transfer is working for me on the microvm machine type but failing on q35 and pc-i440fx. When running in those configurations I get the following error on the new qemu process:
>
>
>     qemu-system-x86_64: error while loading state for instance 0x0 of device 'kvm-tpr-opt'
>     2025-02-18T14:46:52.550319Z qemu-system-x86_64: load of migration failed: Operation not permitted
>
> The issue occurs when initializing the vapic device in the new qemu process. In vapic_map_rom_writable, rom_size is set to zero. This causes the following condition to be triggered:
>
>     ram = memory_region_get_ram_ptr(section.mr);
>     rom_size = ram[rom_paddr + 2] * ROM_BLOCK_SIZE;
>     if (rom_size == 0) {
>     return -1;
>     }

Good job debugging the most opaque error message the migration code can emit.

>
> This occurs on the qemu master branch (tested on commit 9736ee382e95ead06a838fe0b0498e0cb3845270) with the following qemu command line options:
>
> Terminal 1:
>
>     /opt/qemu-build/bin/qemu-system-x86_64 -nographic -cpu host,migratable=yes,-vmx,-svm,invpcid=off -display vnc=unix:/opt/bchaney-tmp/vnc.socket -enable-kvm -name bchaney_test1,debug-threads=on -smp 4 -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m 4G -machine aux-ram-share=on -rtc clock=vm -no-user-config -nodefaults -msg timestamp=on -bios /opt/linode-seabios/roms/bios.bin -machine q35,accel=kvm -cdrom /opt/bchaney-tmp/ubuntu-24.04.1-live-server-amd64.iso -qmp stdio

You're missing an option that tells QEMU to actually make use of the
shared memory backend:

-machine memory-backend=ram0

You might be looking at an older version of the documentation. We've
fixed that and Steve is working on a better error message for it.

>
> Terminal 2:
>
>     /opt/qemu-build/bin/qemu-system-x86_64 -nographic -cpu host,migratable=yes,-vmx,-svm,invpcid=off -display vnc=unix:/opt/bchaney-tmp/vnc.socket -enable-kvm -name bchaney_test1,debug-threads=on -smp 4 -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m 4G -machine aux-ram-share=on -rtc clock=vm -no-user-config -nodefaults -msg timestamp=on -bios /opt/linode-seabios/roms/bios.bin -machine q35,accel=kvm -cdrom /opt/bchaney-tmp/ubuntu-24.04.1-live-server-amd64.iso -incoming '{"channel-type": "main", "addr": { "transport": "socket", "type": "unix", "path": "/opt/bchaney-tmp/main.sock"}}' -incoming '{"channel-type": "cpr", "addr": { "transport": "socket", "type": "unix", "path": "/opt/bchaney-tmp/cpr.sock"}}' -monitor stdio
>
> Qmp commands executed (in Terminal 1):
>
>     {"execute":"qmp_capabilities"}
>     {"execute": "query-status"}
>     {"execute":"migrate-set-parameters",
>        "arguments":{"mode":"cpr-transfer"}}
>     {"execute": "migrate", "arguments": { "channels": [
>         {"channel-type": "main", "addr": { "transport": "socket", "type": "unix",
>                    "path": "/opt/bchaney-tmp/main.sock"}},          
>     {"channel-type": "cpr",
>          "addr": { "transport": "socket", "type": "unix",
>                     "path": "/opt/bchaney-tmp/cpr.sock"}}]}}
>     {"execute": "query-status"}
>
> Is this a hardware configuration that is currently intended to be supported? If not, will it be supported in the future?
>
> Thank you,
> Ben Chaney

