Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC41BC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY2ud-0006Rd-Az; Wed, 15 Jan 2025 07:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tY2uM-0005s5-CT
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:54:06 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tY2uK-0007GR-Fd
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:54:06 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C5DF41F8C2;
 Wed, 15 Jan 2025 12:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736945642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YyWU+tiSKU6OqllNostVH0O7PF7OrwseIKQ4+DkX0Hw=;
 b=H+JxCFGA3ZDsJaPp9pW4p+94t5cIFcSHP/n72XHCI/hVRp2JZHepVbS1MpdZFhHSGX2aBl
 3bbSG5mzkHx8FmhLOpki0567xN33Srd86p41O1sL06HcauZWLUA4EAX0vOcurc0dCz2fD6
 hz4H6dzl0Mpqp/BIh1bzoieym13BtNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736945642;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YyWU+tiSKU6OqllNostVH0O7PF7OrwseIKQ4+DkX0Hw=;
 b=h/GFdDW2D2tmqHOMi7rvIimygftc2rdHxWYCMXqZ9Nqus1HNdEgiqXUmGvpUv29mJpaolE
 EnssX+D0bI0kFYDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=H+JxCFGA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="h/GFdDW2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736945642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YyWU+tiSKU6OqllNostVH0O7PF7OrwseIKQ4+DkX0Hw=;
 b=H+JxCFGA3ZDsJaPp9pW4p+94t5cIFcSHP/n72XHCI/hVRp2JZHepVbS1MpdZFhHSGX2aBl
 3bbSG5mzkHx8FmhLOpki0567xN33Srd86p41O1sL06HcauZWLUA4EAX0vOcurc0dCz2fD6
 hz4H6dzl0Mpqp/BIh1bzoieym13BtNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736945642;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YyWU+tiSKU6OqllNostVH0O7PF7OrwseIKQ4+DkX0Hw=;
 b=h/GFdDW2D2tmqHOMi7rvIimygftc2rdHxWYCMXqZ9Nqus1HNdEgiqXUmGvpUv29mJpaolE
 EnssX+D0bI0kFYDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4970C13A6F;
 Wed, 15 Jan 2025 12:54:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BfwOBOqvh2daVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 15 Jan 2025 12:54:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH] tests/qtest/migration: Add cpu hotplug test
In-Reply-To: <20250115112451.021e6aa2@imammedo.users.ipa.redhat.com>
References: <20250113210833.1712-1-farosas@suse.de>
 <20250115112451.021e6aa2@imammedo.users.ipa.redhat.com>
Date: Wed, 15 Jan 2025 09:53:59 -0300
Message-ID: <87msfsfdaw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C5DF41F8C2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Igor Mammedov <imammedo@redhat.com> writes:

> On Mon, 13 Jan 2025 18:08:33 -0300
> Fabiano Rosas <farosas@suse.de> wrote:
>
>> Bug #2594 is about a failure during migration after a cpu hotplug. Add
>> a test that covers that scenario. Start the source with -smp 2 and
>> destination with -smp 3, plug one extra cpu to match and migrate.
>
> -smp on target should be the same as on source.
> Instead use '-device hotplugged_cpu' with the same args as
> in used device_add on target, to account for an extra cpu

Thanks, I've seen your suggestion in the RHEL bug and recommended that
to be used in the upstream bug. The reporter confirms it works.


