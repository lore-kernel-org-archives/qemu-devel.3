Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD65E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 17:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKhoG-0007xZ-Tf; Mon, 09 Dec 2024 12:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKhoF-0007x8-8X
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 12:44:39 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKhoD-0000Bw-73
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 12:44:39 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 28787210F8;
 Mon,  9 Dec 2024 17:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733766275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5KGeNeaI0KVS1Xyfh99a8GZiQ4zHX1t1AA7DqG6LbM=;
 b=jQt9N33b8uW4yL3La+qDECUwzZBfODAefOKNKi/GiqCy2Mqtdm5f98HMujtnm4VtzBj7VD
 +vbgWDT9CfEd2aKf0EMIUiqbqSHPoPFaZkbguSohF6//Fam4QTLWGTEUBGDRTYUkaOK+gD
 rqwtjFHvWdUCKiXmbKX5wu/Gql6btJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733766275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5KGeNeaI0KVS1Xyfh99a8GZiQ4zHX1t1AA7DqG6LbM=;
 b=9oLvozVZBmzemRMDjCGaawaiAiqeOWuXPPUcUCp+Jdn799Ss0/hcQJ9uhQ9K5w0p/Pl1zo
 PoDzGbFmCC26DbCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733766275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5KGeNeaI0KVS1Xyfh99a8GZiQ4zHX1t1AA7DqG6LbM=;
 b=jQt9N33b8uW4yL3La+qDECUwzZBfODAefOKNKi/GiqCy2Mqtdm5f98HMujtnm4VtzBj7VD
 +vbgWDT9CfEd2aKf0EMIUiqbqSHPoPFaZkbguSohF6//Fam4QTLWGTEUBGDRTYUkaOK+gD
 rqwtjFHvWdUCKiXmbKX5wu/Gql6btJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733766275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5KGeNeaI0KVS1Xyfh99a8GZiQ4zHX1t1AA7DqG6LbM=;
 b=9oLvozVZBmzemRMDjCGaawaiAiqeOWuXPPUcUCp+Jdn799Ss0/hcQJ9uhQ9K5w0p/Pl1zo
 PoDzGbFmCC26DbCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 902D3138D2;
 Mon,  9 Dec 2024 17:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RZZZFYIsV2f5PgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Dec 2024 17:44:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Pierrick
 Bouvier
 <pierrick.bouvier@linaro.org>, =?utf-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0Ls=?=
 =?utf-8?B?0L7Qsg==?= <frolov@swemel.ru>, =?utf-8?Q?Daniel_P=2E_Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>
Cc: lvivier@redhat.com, sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest: add TIMEOUT_MULTIPLIER
In-Reply-To: <cfa1c780-012b-4c4d-975a-e08068706607@linaro.org>
References: <20241113094342.282676-2-frolov@swemel.ru>
 <Z0YUMoPr0oyQhqqK@redhat.com>
 <04edda40-32d2-43e0-8ade-a4b2a3e06eab@swemel.ru>
 <49cc1e5e-dd62-475e-b483-c2897c829529@linaro.org>
 <cfa1c780-012b-4c4d-975a-e08068706607@linaro.org>
Date: Mon, 09 Dec 2024 14:42:22 -0300
Message-ID: <8734iwbvnl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.986]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, linaro.org:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 27/11/24 19:44, Pierrick Bouvier wrote:
>> On 11/26/24 23:40, =D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D0=B9 =D0=A4=D1=
=80=D0=BE=D0=BB=D0=BE=D0=B2 wrote:
>>> Hello, Daniel
>>>
>>> On 26.11.2024 21:32, Daniel P. Berrang=C3=A9 wrote:
>>>> On Wed, Nov 13, 2024 at 12:43:40PM +0300, Dmitry Frolov wrote:
>>>>> Some tests need more time when qemu is built with
>>>>> "--enable-asan --enable-ubsan"
>>>>>
>>>>> As was discussed here:
>>>>> https://patchew.org/QEMU/20241112120100.176492-2-frolov@swemel.r/u
>>>>>
>>>>> TIMEOUT_MULTIPLIER enviroment variable will be
>>>>> a useful option, allowing non-invasive timeouts
>>>>> increasing for a specific build.
>>>>>
>>>>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
>>>>> ---
>>>>> =C2=A0=C2=A0 scripts/mtest2make.py | 2 ++
>>>>> =C2=A0=C2=A0 1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
>>>>> index eb01a05ddb..ff60b62724 100644
>>>>> --- a/scripts/mtest2make.py
>>>>> +++ b/scripts/mtest2make.py
>>>>> @@ -27,7 +27,9 @@ def names(self, base):
>>>>> =C2=A0=C2=A0 .speed.slow =3D $(foreach s,$(sort $(filter-out %-thorou=
gh, $1)),=20
>>>>> --suite $s)
>>>>> =C2=A0=C2=A0 .speed.thorough =3D $(foreach s,$(sort $1), --suite $s)
>>>>> +ifndef TIMEOUT_MULTIPLIER
>>>>> =C2=A0=C2=A0 TIMEOUT_MULTIPLIER =3D 1
>>>>> +endif
>>>> Can you explain what scenario this is needed for, as unless I'm
>>>> missing something this change has no purpose. This assignment is
>>>> merely defining the defalt value, which can already be overridden
>>>> at runtime without this 'ifndef'
>>>>
>>>> eg
>>>>
>>>> $ make check-unit TIMEOUT_MULTIPLIER=3D7
>>>>
>>>> In another shell:
>>>>
>>>> $ ps -axuwwf | grep 'meson test'
>>>> berrange 1931657=C2=A0 3.9=C2=A0 0.1 330904 99344 pts/1=C2=A0=C2=A0=C2=
=A0 S+=C2=A0=C2=A0 18:29=20=20=20
>>>> 0:00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \_=20
>>>> /var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3=20
>>>> /var/home/berrange/src/virt/qemu/build/pyvenv/bin/meson test=20
>>>> --no-rebuild -t 7 --num-processes 1 --print-errorlogs --suite unit
>>>>
>>>> shows TIMEOUT_MULTIPLIER being honoured
>>> Yeah... You are right!
>>> It is possible to set TIMEOUT_MULTIPLIER only to run tests.
>>> It is not necessary to set it for the whole build.
>>>
>>> Sorry, and thanks a lot!
>>>>
>>>>
>>>> With regards,
>>>> Daniel
>>> regards,
>>> Dmitry
>>>
>>=20
>> This patch is still useful if we want to set TIMEOUT_MULTIPLIER as=20
>> global env variable, and not explicitely on each make invocation.
>
> If so, I'd rather use conditional assignment [*]:
>
> - TIMEOUT_MULTIPLIER =3D 1
> + TIMEOUT_MULTIPLIER ?=3D 1
>
> [*]=20
> https://www.gnu.org/software/make/manual/html_node/Conditional-Assignment=
.html

I can fix that up in qtest-next, thanks.

