Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F51E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkV2-0006By-2Y; Mon, 09 Dec 2024 15:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkUy-0006Bf-IC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:36:56 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkUx-0003CF-1q
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:36:56 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B5DA1F45B;
 Mon,  9 Dec 2024 20:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733776613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1hM5J2rCpQDAxVBVQ5ByfARUe1Y1Jo3D9HyX797uqU=;
 b=SDgRuQ+5ec/vT3P5ckMt14mM0uarqMAoviN/EKzO8R6dQhrK0qfDkuf72s6O3WLivyAiKA
 WhXHhJznxtguFntIqxXFRUIA8Cm7wilYwMm53mIOCJU1U8BqgDTm9VyKMWjT32KQkIQSYm
 gNeuOcAb/vF7ygObOqu/AC4vQpL73ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733776613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1hM5J2rCpQDAxVBVQ5ByfARUe1Y1Jo3D9HyX797uqU=;
 b=7NLhOO/+4IKEYSt+Ze00UkmeIz68osyl/tqKDaL2+LYjVDnbedESCJpGBydQ+lMeRfRI7a
 wUYwf0iMvGRZRjAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733776613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1hM5J2rCpQDAxVBVQ5ByfARUe1Y1Jo3D9HyX797uqU=;
 b=SDgRuQ+5ec/vT3P5ckMt14mM0uarqMAoviN/EKzO8R6dQhrK0qfDkuf72s6O3WLivyAiKA
 WhXHhJznxtguFntIqxXFRUIA8Cm7wilYwMm53mIOCJU1U8BqgDTm9VyKMWjT32KQkIQSYm
 gNeuOcAb/vF7ygObOqu/AC4vQpL73ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733776613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1hM5J2rCpQDAxVBVQ5ByfARUe1Y1Jo3D9HyX797uqU=;
 b=7NLhOO/+4IKEYSt+Ze00UkmeIz68osyl/tqKDaL2+LYjVDnbedESCJpGBydQ+lMeRfRI7a
 wUYwf0iMvGRZRjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA69C138D2;
 Mon,  9 Dec 2024 20:36:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id C9V9J+RUV2fYbQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Dec 2024 20:36:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>, Richard
 Henderson <richard.henderson@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH-for-10.0] system/qtest: Access memory using
 cpu_physical_memory_rw() API
In-Reply-To: <878qsobx78.fsf@suse.de>
References: <20241127191914.34146-1-philmd@linaro.org> <878qsobx78.fsf@suse.de>
Date: Mon, 09 Dec 2024 17:34:37 -0300
Message-ID: <87zfl4a942.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, linaro.org:email]
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

Fabiano Rosas <farosas@suse.de> writes:

> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
>> There is no vCPU within the QTest accelerator (well, they
>> are stubs doing nothing, see dummy_cpu_thread_fn).
>> Directly use the cpu_physical_memory_rw() API -- which
>> amusingly prefixed 'cpu_' does not use vCPU -- to access
>> memory. This reduces accesses to the global 'first_cpu'.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Queued, thanks!

Scratch that, I see some tests failing:

QTEST_QEMU_BINARY=3D../build/qemu-system-arm ./tests/qtest/sse-timer-test
# random seed: R02S7b4a25dac8a32a86ee016342d60e78ec
# starting QEMU: exec ../build/qemu-system-arm -qtest unix:/tmp/qtest-7386.=
sock -qtest-log /dev/fd/2 -chardev socket,path=3D/tmp/qtest-7386.qmp,id=3Dc=
har0 -mon chardev=3Dchar0,mode=3Dcontrol -display
 none -audio none -machine mps3-an547 -accel qtest
[I 0.000000] OPENED
[R +0.033524] endianness
[S +0.033533] OK little
{"QMP": {"version": {"qemu": {"micro": 93, "minor": 1, "major": 9}, "packag=
e": "v9.2.0-rc3-23-g3fe88295e8"}, "capabilities": ["oob"]}}
{"execute": "qmp_capabilities"}

{"return": {}}
1..3
# Start of arm tests
# Start of sse-timer tests
[R +0.035240] writel 0x58100000 0x0
[S +0.035250] OK
[R +0.035263] writel 0x4800002c 0x0
[S +0.035265] OK
[R +0.035275] writel 0x4800004c 0x0
[S +0.035278] OK
[R +0.035287] writel 0x58100008 0x0
[S +0.035289] OK
[R +0.035296] writel 0x5810000c 0x0
[S +0.035299] OK
[R +0.035308] clock_step 3125
[S +0.035312] OK 3125
[R +0.035323] readl 0x58100008
[S +0.035326] OK 0x0000000000000000
[R +0.035334] readl 0x5810000c
[S +0.035337] OK 0x0000000000000000
[R +0.035344] writel 0x58100000 0x1
[S +0.035346] OK
[R +0.035354] clock_step 3125
[S +0.035357] OK 6250
[R +0.035364] readl 0x58100008
[S +0.035367] OK 0x0000000000000000
**
ERROR:../tests/qtest/sse-timer-test.c:91:test_counter: assertion failed (re=
adl(COUNTER_BASE + CNTCV_LO) =3D=3D 100): (0 =3D=3D 100)
Bail out! ERROR:../tests/qtest/sse-timer-test.c:91:test_counter:
assertion failed (readl(COUNTER_BASE + CNTCV_LO) =3D=3D 100): (0 =3D=3D 100)

