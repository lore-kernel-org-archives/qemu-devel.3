Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE36C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 21:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRf1l-0004Sq-Fd; Wed, 10 Jul 2024 17:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sRf1Z-0004MM-6x; Wed, 10 Jul 2024 17:38:54 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sRf1O-00047o-Qc; Wed, 10 Jul 2024 17:38:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C55E621991;
 Wed, 10 Jul 2024 21:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720647510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Axj6GCY7rkHKt8FR3q6mmgasH01jh9aUBrNnSOVZ8tE=;
 b=WxJ1kzmEjdOIKPK2iTykTqGWA+D2+2yIVzGN/9qryLIQvbp2ul9Fam16Q4QC8UM1pIYQA6
 sH7vnjEj6aFO6U5ADt6hL6jo5D2n8od0/E109Z9hTxnicXwc1radM4mJMjUJo+2q8AiR3z
 ElQgsgHhGnNghVrepjLJwD3Xl9G+n8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720647510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Axj6GCY7rkHKt8FR3q6mmgasH01jh9aUBrNnSOVZ8tE=;
 b=T/wjpVPyANorcY8tqysIKhySE3VAsbqcg6mbHsn+uSYAsvWOnI/LohW8evtHfPX6LATw0E
 uYsmBVH6kT7fvNCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZZRY7TUE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VPjJNCCW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720647509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Axj6GCY7rkHKt8FR3q6mmgasH01jh9aUBrNnSOVZ8tE=;
 b=ZZRY7TUEyvWs67KYP9vRkvPYC3KIP93595mMFD/ywrIMgK4Y/u+q7gll/HypeU2xM1BAY+
 3X4pJZqFEEPWd48MvgZn59SWwwgJ188tl6n6mC1LXYQunTbgzIUPVEdS9KpfL4XPPLo+QW
 lpaqtDld3sTIAilqx1bc1mOfYVYQJtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720647509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Axj6GCY7rkHKt8FR3q6mmgasH01jh9aUBrNnSOVZ8tE=;
 b=VPjJNCCWeFcGL+ftxqY+tPCPyjnFxsNs1HT9OXdojQRxgKpo2Bj2LkI89sK+JsDzYI7T7R
 XTw5XRm5Z7iXA+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F417137D2;
 Wed, 10 Jul 2024 21:38:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WpgmAlX/jmaINAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Jul 2024 21:38:29 +0000
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
In-Reply-To: <Zo7rCXtap2lWd4IB@x1n>
References: <20240627162232.80428-1-philmd@linaro.org>
 <20240627162232.80428-7-philmd@linaro.org> <87cynmfggx.fsf@suse.de>
 <Zo2lLLAwcZ8bBvO2@x1n> <87a5ipfigb.fsf@suse.de> <Zo6iZjc8YpI1_9dW@x1n>
 <874j8xfc9s.fsf@suse.de> <Zo7dcF8OKfH92RlR@x1n> <871q41f2pk.fsf@suse.de>
 <Zo7rCXtap2lWd4IB@x1n>
Date: Wed, 10 Jul 2024 18:38:26 -0300
Message-ID: <87ttgxdj1p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C55E621991
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

> On Wed, Jul 10, 2024 at 04:48:23PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Wed, Jul 10, 2024 at 01:21:51PM -0300, Fabiano Rosas wrote:
>> >> It's not about trust, we simply don't support migrations other than
>> >> n->n+1 and (maybe) n->n-1. So QEMU from 2016 is certainly not included.
>> >
>> > Where does it come from?  I thought we suppport that..
>> 
>> I'm taking that from:
>> 
>> docs/devel/migration/main.rst:
>>   "In general QEMU tries to maintain forward migration compatibility
>>   (i.e. migrating from QEMU n->n+1) and there are users who benefit from
>>   backward compatibility as well."
>> 
>> But of course it doesn't say whether that comes with a transitive rule
>> allowing n->n+2 migrations.
>
> I'd say that "i.e." implies n->n+1 is not the only forward migration we
> would support.
>
> I _think_ we should support all forward migration as long as the machine
> type matches.
>
>> 
>> >
>> > The same question would be: are we requesting an OpenStack cluster to
>> > always upgrade QEMU with +1 versions, otherwise migration will fail?
>> 
>> Will an OpenStack cluster be using upstream QEMU? If not, then that's a
>
> It's an example to show what I meant! :) Nothing else. Definitely not
> saying that everyone should use an upstream released QEMU (but in reality,
> it's not a problem, I think, and I do feel like people use them, perhaps
> more with the stable releases).
>
>> question for the distro. In a very practical sense, we're not requesting
>> anything. We barely test n->n+1/n->n-1, even if we had a strong support
>> statement I wouldn't be confident saying migration from QEMU 2.7 -> QEMU
>> 9.1 should succeed.
>
> No matter what we test in CI, I don't think we should break that for >1
> versions..  I hope 2.7->9.1 keeps working, otherwise I think it's legal to
> file a bug by anyone.
>
> For example, I randomly fetched a bug report:
>
> https://gitlab.com/qemu-project/qemu/-/issues/1937
>
> QEMU version:                6.2 and 7.2.5
>
> And I believe that's the common case even for upstream.  If we don't do
> that right for upstream, it can be impossible tasks for downstream and for
> all of us to maintain.

But do we do that right currently? I have no idea. Have we ever done
it? And we're here discussing a hypothetical 2.7->9.1 ...

So we cannot reuse the UNUSED field because QEMU from 2016 might send
their data and QEMU from 2024 would interpret it wrong.

How do we proceed? Add a subsection. And make the code survive when
receiving 0.

@Peter is that it? What about backwards-compat? We'll need a property as
well it seems.

