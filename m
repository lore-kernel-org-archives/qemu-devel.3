Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405FEC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRv1v-00033U-DI; Thu, 11 Jul 2024 10:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sRv1t-0002tL-9x; Thu, 11 Jul 2024 10:44:17 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sRv1r-0007se-JW; Thu, 11 Jul 2024 10:44:16 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8385D1F8D6;
 Thu, 11 Jul 2024 14:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720709051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3yyCv5UtypusuYzRWHLk5yrBATs5Wh5xA+D+frGEZB0=;
 b=JYw+PSNY3CNKwo1i0uk2Mr7CtrxFbYQJ3ZTzmwDVZvKpbmsMwMR1JxlyeanVJ8IVTzndP2
 ppbjQfs6XDebo1bhnKnmjT+Ar3DXcEzAsgGr6GtiMJT5OQ9a3L8D1vkwn9YywcwEDj8s9C
 5Lt8op5pGmet0ghHqmAR95javGtn2qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720709051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3yyCv5UtypusuYzRWHLk5yrBATs5Wh5xA+D+frGEZB0=;
 b=9uPqraKFFl0Aoj57hRfmayoWScCMyJW7naeoe7GvIY+pl2KVfo/45bDudVdcloq2dz9f//
 2IFNxZJ4XRd1USCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JYw+PSNY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9uPqraKF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720709051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3yyCv5UtypusuYzRWHLk5yrBATs5Wh5xA+D+frGEZB0=;
 b=JYw+PSNY3CNKwo1i0uk2Mr7CtrxFbYQJ3ZTzmwDVZvKpbmsMwMR1JxlyeanVJ8IVTzndP2
 ppbjQfs6XDebo1bhnKnmjT+Ar3DXcEzAsgGr6GtiMJT5OQ9a3L8D1vkwn9YywcwEDj8s9C
 5Lt8op5pGmet0ghHqmAR95javGtn2qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720709051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3yyCv5UtypusuYzRWHLk5yrBATs5Wh5xA+D+frGEZB0=;
 b=9uPqraKFFl0Aoj57hRfmayoWScCMyJW7naeoe7GvIY+pl2KVfo/45bDudVdcloq2dz9f//
 2IFNxZJ4XRd1USCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00D3F136AF;
 Thu, 11 Jul 2024 14:44:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /ut4Lrrvj2biFQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 11 Jul 2024 14:44:10 +0000
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
In-Reply-To: <Zo_n39Vusyy-O_48@x1n>
References: <Zo2lLLAwcZ8bBvO2@x1n> <87a5ipfigb.fsf@suse.de>
 <Zo6iZjc8YpI1_9dW@x1n> <874j8xfc9s.fsf@suse.de> <Zo7dcF8OKfH92RlR@x1n>
 <871q41f2pk.fsf@suse.de> <Zo7rCXtap2lWd4IB@x1n> <87ttgxdj1p.fsf@suse.de>
 <Zo8F4Gq4f7SawaDc@x1n> <87plrkdpd7.fsf@suse.de> <Zo_n39Vusyy-O_48@x1n>
Date: Thu, 11 Jul 2024 11:44:08 -0300
Message-ID: <87h6cwdm4n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 8385D1F8D6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00]; SUSPICIOUS_RECIPS(1.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWELVE(0.00)[18];
 FREEMAIL_CC(0.00)[linaro.org,nongnu.org,redhat.com,nuvoton.com,gmail.com,google.com,amd.com,kaod.org,jms.id.au,lists.libvirt.org];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spamd-Bar: /
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On Thu, Jul 11, 2024 at 10:34:12AM -0300, Fabiano Rosas wrote:
>> Is there an easy way to look at a field and tell in which machine type's
>> timeframe it was introduced?
>
> I am not aware of any.
>
>> If the machine type of that era has been removed, then the field is free
>> to go as well. I'd prefer if we had a hard link instead of just counting
>> years. Maybe we should to that mapping at the machine deprecation time?
>> As in, "look at the unused fields introduced in that timeframe and mark
>> them free".
>
> We can do that, but depending on how easy it would be. That can be an
> overkill to me if it's non-trivial.  When it becomes complicated, I'd
> rather make machine compat property easier to use so we always stick with
> that.  Currently it's not as easy to use.
>
> Maybe we shouldn't make it a common rule to let people reuse the UNUSED
> fields, even if in this case it's probably fine?
>
> E.g. I don't think it's a huge deal to keep all UNUSED fields forever -
> sending 512B zeros for only one specific device isn't an issue even if kept
> forever.
>
> If "over 6 years" would be okay and simple enough, then maybe we can stick
> with that (and only if people would like to reuse a field and ask; that's
> after all not required..).  If more than that I doubt whether we should
> spend time working on covering all the fields.

I'm fine with a simple rule.

But of course, that means we cannot claim to support all kinds of
forward migrations anymore. Only those in the 6 year period.

