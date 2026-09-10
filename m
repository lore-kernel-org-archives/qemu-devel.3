Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC7FC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dxI-00012y-Au; Thu, 10 Sep 2026 08:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x4dxG-00012Z-UK; Thu, 10 Sep 2026 08:32:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x4dxF-000171-By; Thu, 10 Sep 2026 08:32:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2484F1FCBA;
 Thu, 10 Sep 2026 12:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789043551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQVGQlF8rQ4sg9rOVG5qovdMdx4uhpBfVXoGIh4QTSU=;
 b=n/oEKnP103ia5jtcvgntNQxfWY9WWiqm+J/qCQ9Ns7yYmg9tRFvkBD2xSJiP5xybRuTCCB
 8WbPjcd8LG/Ith61tNgcVE90nF2vmBqzXV2dJC3D80NjT2JO5uaPBgI16yBW+YfyvL7OmM
 PhYsk16LKl90qcdzhQSchESkjWzgM8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789043551;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQVGQlF8rQ4sg9rOVG5qovdMdx4uhpBfVXoGIh4QTSU=;
 b=zzrvcB7NketC518PZ6+rKakec8ws/2XnKfUb719/t1xM6bicKnbHiQo8MH1cnNKL9sKhxJ
 qiGfWSmT1rI+MaCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789043547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQVGQlF8rQ4sg9rOVG5qovdMdx4uhpBfVXoGIh4QTSU=;
 b=VxI5uUP+l72d8+dROXCwvNt0T2IM9ywR983nx5PrA2Q4u4ClTT0P77vnejbFj7FuBIZt7k
 cXVKVqFEJLBZbNsqkIArKd4dZNMzSUeji/oLmDE3GznfJtO0U930jybCcVLu2PmHQl0taN
 2ehRUR4cjmTLb8xxomXqaazIYAEDU5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789043547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQVGQlF8rQ4sg9rOVG5qovdMdx4uhpBfVXoGIh4QTSU=;
 b=slNa4yrz/vBhzb4LStxR9hkwGwkcUL72dxL2ErlulgGp9icB5mrmeqV4vLy7Xm7IkfENAp
 eAvFHejZGH/VA0Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70EA313955;
 Thu, 10 Sep 2026 12:32:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D4y9EFqjomqzUwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Sep 2026 12:32:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Subject: Re: [PATCH 1/1] tests/qtest/ahci: fix a racy deadlock in the engine
 stop test
In-Reply-To: <9adc681f-f20c-4ef7-8e04-2da290827a28@virtuozzo.com>
References: <20260830183534.104435-1-den@openvz.org> <87fqzi6nxz.fsf@suse.de>
 <9adc681f-f20c-4ef7-8e04-2da290827a28@virtuozzo.com>
Date: Thu, 10 Sep 2026 09:32:20 -0300
Message-ID: <874ifxuw17.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

"Denis V. Lunev" <den@virtuozzo.com> writes:

> On 9/10/26 00:48, Fabiano Rosas wrote:
>> "Denis V. Lunev" <den@openvz.org> writes:
>>
>>> From: Denis V. Lunev <den@openvz.org>
>>>
>>> test_write_engine_stop_in_flight() resumes the suspended backend write
>>> and goes straight on to restart the command engine and read the second
>>> sector back. Whether the write has retired by then is a race. While it
>>> is still outstanding the drive is busy, and handle_cmd() drops a
>>> command that arrives in that state instead of queueing it. Nothing
>>> retries the drop, so the PxCI slot stays set and no D2H FIS is posted.
>>> ahci_command_wait() polls both with no timeout, so the test deadlocks
>>> until the harness kills it.
>>>
>>> Drain the port before issuing the read, so the abandoned write has
>>> retired and the engine is idle. Host load stretches the gap between the
>>> resume and the write completing, which is why the deadlock only shows
>>> up on a loaded machine.
>>>
>>> Fixes: d05ae87e7a6a ("tests/qtest/ahci: regression test for a PIO write=
 vs. engine stop")
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> ---
>>>  tests/qtest/ahci-test.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
>>> index b143862ce7..2552fa39f1 100644
>>> --- a/tests/qtest/ahci-test.c
>>> +++ b/tests/qtest/ahci-test.c
>>> @@ -1914,6 +1914,12 @@ static void test_write_engine_stop_in_flight(voi=
d)
>>>=20=20
>>>      g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"resume wr\""=
));
>>>=20=20
>>> +    /*
>>> +     * Retire the abandoned write. handle_cmd() drops a command that a=
rrives
>>> +     * while the drive is still busy and nothing retries it.
>>> +     */
>>> +    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"aio_flush\""=
));
>>> +
>>>      /* Round-trip through the device to confirm qemu is still alive. */
>>>      ahci_px_rreg(ahci, port, AHCI_PX_TFD);
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Hi, Fabiano!
>
> Would you mind to get this patch through test tree?
> I do not have enough IDE material except this patch
> for now.
>
> Thank you in advance,
> =C2=A0 =C2=A0 Den

Yep, no worries. I'm just waiting for my leak fixes series to be ready
and I'll send a PR.

