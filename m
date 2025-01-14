Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3839E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 14:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXhi5-00079N-48; Tue, 14 Jan 2025 09:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tXhhu-00078q-1G
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:15:53 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tXhhm-0006HH-6H
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:15:48 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A3E421137;
 Tue, 14 Jan 2025 14:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736864133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dV6fCmyqw6D8KZpxXAl7+msYVFKso5sJ4WUPxcERKLg=;
 b=SxVto9G1onFLJxIq4grxN5m3ttU4QPCphzT7BoT0qZ0MmM6wPaGn4Zn6ZssndgDoO44//B
 2mnE7CaWkGVLtRjOHQCjZ054Joj9uHW9wnK9avfYblJTffyh06tGJXlHKdAAochQDbCI7Q
 GO3sRHJM7M8nlQjYZMPauNhEQ80367c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736864133;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dV6fCmyqw6D8KZpxXAl7+msYVFKso5sJ4WUPxcERKLg=;
 b=186btulvQKLpz1RSapw6BkfIlctVzaQYVib8MWDwHNjp/6O3w4vpmh1QtWACo8i+M90eHj
 Oa1Ug4gbdBHl9lCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736864133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dV6fCmyqw6D8KZpxXAl7+msYVFKso5sJ4WUPxcERKLg=;
 b=SxVto9G1onFLJxIq4grxN5m3ttU4QPCphzT7BoT0qZ0MmM6wPaGn4Zn6ZssndgDoO44//B
 2mnE7CaWkGVLtRjOHQCjZ054Joj9uHW9wnK9avfYblJTffyh06tGJXlHKdAAochQDbCI7Q
 GO3sRHJM7M8nlQjYZMPauNhEQ80367c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736864133;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dV6fCmyqw6D8KZpxXAl7+msYVFKso5sJ4WUPxcERKLg=;
 b=186btulvQKLpz1RSapw6BkfIlctVzaQYVib8MWDwHNjp/6O3w4vpmh1QtWACo8i+M90eHj
 Oa1Ug4gbdBHl9lCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFC85139CB;
 Tue, 14 Jan 2025 14:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JcGiLIRxhme5WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 Jan 2025 14:15:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH] tests/qtest/migration: Add cpu hotplug test
In-Reply-To: <CAJSP0QWe+0_rjchH0hCszU-4r_PF+ZgZgWb+cgg6UZzZiYeTQA@mail.gmail.com>
References: <20250113210833.1712-1-farosas@suse.de>
 <CAJSP0QWe+0_rjchH0hCszU-4r_PF+ZgZgWb+cgg6UZzZiYeTQA@mail.gmail.com>
Date: Tue, 14 Jan 2025 11:15:30 -0300
Message-ID: <8734hlh471.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Mon, 13 Jan 2025 at 16:09, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Bug #2594 is about a failure during migration after a cpu hotplug. Add
>> a test that covers that scenario. Start the source with -smp 2 and
>> destination with -smp 3, plug one extra cpu to match and migrate.
>>
>> The issue seems to be a mismatch in the number of virtqueues between
>> the source and destination due to the hotplug not changing the
>> num_queues:
>>
>>   get_pci_config_device: Bad config data: i=0x9a read: 4 device: 5
>>   cmask: ff wmask: 0 w1cmask:0
>>
>> Usage:
>> $ QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>>   ./tests/qtest/migration-test -p /x86_64/migration/hotplug/cpu
>>
>> References: https://gitlab.com/qemu-project/qemu/-/issues/2594
>> References: https://issues.redhat.com/browse/RHEL-68302
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> As you can see there's no fix attached to this. I haven't reached that
>> part yet, suggestions welcome =). Posting the test case if anyone
>> wants to play with this.
>>
>> (if someone at RH is already working on this, that's fine. I'm just
>> trying to get some upstream bugs to move)
>
> The management tool should set num_queues on the destination to ensure
> migration compatibility.
>

I'm not sure that's feasible. The default num-queues seem like an
implementation detail that the management application would not have a
way to query. Unless it starts the source with a fixed number that
already accounts for all hotplug/unplug operations during the VM
lifetime, which would be wasteful in terms of resources allocated
upfront.

That would also make the destination run with a suboptimal (< #vcpus)
number of queues, although that's already the case in the source after
the hotplug. Do we have any definition on what should happen durgin
hotplug? If one plugs 100 vcpus, should num-queues remain as 2?


