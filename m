Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B52C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVB8-0006x2-9Z; Mon, 12 May 2025 11:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uEVA2-0005Jm-Rj
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:48 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uEVA0-0006oG-Q6
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AF7E01F38A;
 Mon, 12 May 2025 15:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747064022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+2Hwodhp35T11MPXcJZli19P+KVAl/XPeRthO1NKrko=;
 b=Ddue1M/V2xZGsoJYa+/af8B6avPrRoYSwXH5pNMeSNmC3R88IgBegh8SthzuXiGUHQre/3
 yipv04zx9gzVD1HgzbTx/Xd4m8QUpInYT9OWjLl0jxfTC5/QfNEgPOU/3/jqWHYF3V7Jnr
 HLBWDAfwuCDZo82IGFg/KvVVnfgvlbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747064022;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+2Hwodhp35T11MPXcJZli19P+KVAl/XPeRthO1NKrko=;
 b=bKlao+h5LEzH67Af3Nkg3urW9Rdj2qvAg0brOnlWSvSb+5ya+uD1wfUlZ39c60m7wU6OPv
 b1NZtrkDy6hTlFDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Ddue1M/V";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bKlao+h5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747064022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+2Hwodhp35T11MPXcJZli19P+KVAl/XPeRthO1NKrko=;
 b=Ddue1M/V2xZGsoJYa+/af8B6avPrRoYSwXH5pNMeSNmC3R88IgBegh8SthzuXiGUHQre/3
 yipv04zx9gzVD1HgzbTx/Xd4m8QUpInYT9OWjLl0jxfTC5/QfNEgPOU/3/jqWHYF3V7Jnr
 HLBWDAfwuCDZo82IGFg/KvVVnfgvlbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747064022;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+2Hwodhp35T11MPXcJZli19P+KVAl/XPeRthO1NKrko=;
 b=bKlao+h5LEzH67Af3Nkg3urW9Rdj2qvAg0brOnlWSvSb+5ya+uD1wfUlZ39c60m7wU6OPv
 b1NZtrkDy6hTlFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 223E0137D2;
 Mon, 12 May 2025 15:33:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id csIHNdUUImhXUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 12 May 2025 15:33:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Bernhard Beschow <shentey@gmail.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 00/22] usb/xhci and usb/msd improvements and tests
In-Reply-To: <CAFEAcA_giWU5xC8GqjbvQUV7K-M_1iKrKoQBvB9Xj3qtLRZtxg@mail.gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
 <D9NUVWSVJKHN.3T7M6OPALIGYC@gmail.com> <aBh-tXqR6RqXvx9D@redhat.com>
 <CAFEAcA_giWU5xC8GqjbvQUV7K-M_1iKrKoQBvB9Xj3qtLRZtxg@mail.gmail.com>
Date: Mon, 12 May 2025 12:33:39 -0300
Message-ID: <87v7q5etd8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AF7E01F38A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,nongnu.org,philjordan.eu,linaro.org];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 5 May 2025 at 10:03, Kevin Wolf <kwolf@redhat.com> wrote:
>>
>> Am 05.05.2025 um 04:03 hat Nicholas Piggin geschrieben:
>> > I would like to get this series merged, but I realize the mass storage
>> > change to relax packet ordering of a command particularly is quite
>> > complicated and under-reviewed.
>>
>> I can try to find the time to have a look at the series, but given that
>> I'll have to familiarise myself with the specs again, it might take a
>> while.
>>
>> > Would there be objection if I made a pull request for Guenter's
>> > patches, the hcd stuff, the qtests, and some of the easier / reviewed
>> > bits of msd?
>>
>> That makes sense to me. I suppose I can also give a quick review for the
>> initial part of the msd patches, at lot of which seems to be more or
>> less just refactoring.
>
> I've now reviewed the hw/usb/xhci patches, so I think you
> now have reviews for everything here except the tests/qtest/
> patches (3, 4, 5, 7, 8, 21).
>

I'll get to them this week. It'd be nice to see the new version of the
pending dependency series that's mentioned in the cover letter. For
these subsystems I'm not familiar with, most of my qtest review will
rely on putting the series through asan and tests on a loaded
machine. If there's latent bugs in qtest, it gets super confusing.

