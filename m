Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE5BC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 12:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9lOr-0001Nx-5X; Wed, 22 May 2024 08:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9lOo-0001Jr-PS; Wed, 22 May 2024 08:48:54 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9lOn-000156-4t; Wed, 22 May 2024 08:48:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 39A1034D15;
 Wed, 22 May 2024 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716382129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=meJmNfuoNnRW9HA8JS5nGFDPHWuK2zA62R8+Ms+dsBc=;
 b=RKANH9n1DhlivM4YklIJ1bRsjDGgnmDBj9YQ9Y48c+ZZTVuhK1knfOxXhOv52DcYUdkuIk
 fPGid0fDDMX8mDtqFi7Z1ljK+2B8r1xFKrSJ2XYPb3oISyUhMPpuQQ8kGHcgW6WowDffjA
 YKkwjPdMjQHHHICeDMlzO0bb1X5CIJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716382129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=meJmNfuoNnRW9HA8JS5nGFDPHWuK2zA62R8+Ms+dsBc=;
 b=Db1Fo97XDMbzuCOHMl5akFz/O90Xfwzg0Wzvhy4/XfNqRnbTdbphWull73wEHV4RL9oGLr
 Iaq9AdAEcJfjWaBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716382129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=meJmNfuoNnRW9HA8JS5nGFDPHWuK2zA62R8+Ms+dsBc=;
 b=RKANH9n1DhlivM4YklIJ1bRsjDGgnmDBj9YQ9Y48c+ZZTVuhK1knfOxXhOv52DcYUdkuIk
 fPGid0fDDMX8mDtqFi7Z1ljK+2B8r1xFKrSJ2XYPb3oISyUhMPpuQQ8kGHcgW6WowDffjA
 YKkwjPdMjQHHHICeDMlzO0bb1X5CIJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716382129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=meJmNfuoNnRW9HA8JS5nGFDPHWuK2zA62R8+Ms+dsBc=;
 b=Db1Fo97XDMbzuCOHMl5akFz/O90Xfwzg0Wzvhy4/XfNqRnbTdbphWull73wEHV4RL9oGLr
 Iaq9AdAEcJfjWaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1D9E13A6B;
 Wed, 22 May 2024 12:48:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b2unHbDpTWaYfgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 May 2024 12:48:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Markus Armbruster <armbru@redhat.com>, Peter
 Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng
 <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian
 <lizhijian@fujitsu.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 10/38] tests/qtest/migration: Add a test for the
 analyze-migration script
In-Reply-To: <3d437c79-89c0-4268-941f-0f97eb6d05b2@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
 <20231017083003.15951-11-quintela@redhat.com>
 <87wmnnic86.fsf@draig.linaro.org> <87bk4zjpt2.fsf@suse.de>
 <3d437c79-89c0-4268-941f-0f97eb6d05b2@redhat.com>
Date: Wed, 22 May 2024 09:48:46 -0300
Message-ID: <8734qahv0x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[18]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Thomas Huth <thuth@redhat.com> writes:

> On 21/05/2024 14.46, Fabiano Rosas wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>=20
>>> Juan Quintela <quintela@redhat.com> writes:
>>>
>>>> From: Fabiano Rosas <farosas@suse.de>
>>>>
>>>> Add a smoke test that migrates to a file and gives it to the
>>>> script. It should catch the most annoying errors such as changes in
>>>> the ram flags.
>>>>
>>>> After code has been merged it becomes way harder to figure out what is
>>>> causing the script to fail, the person making the change is the most
>>>> likely to know right away what the problem is.
>>>>
>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>> Acked-by: Thomas Huth <thuth@redhat.com>
>>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>> Message-ID: <20231009184326.15777-7-farosas@suse.de>
>>>
>>> I bisected the failures I'm seeing on s390x to the introduction of this
>>> script. I don't know if its simply a timeout on a relatively slow VM:
>>=20
>> What's the range of your bisect? That test has been disabled and then
>> reenabled on s390x. It could be tripping the bisect.
>>=20
>> 04131e0009 ("tests/qtest/migration-test: Disable the analyze-migration.p=
y test on s390x")
>> 81c2c9dd5d ("tests/qtest/migration-test: Fix analyze-migration.py for s3=
90x")
>>=20
>> I don't think that test itself could be timing out. It's a very simple
>> test. It runs a migration and then uses the output to validate the
>> script.
>
> Agreed, the analyze-migration.py is unlikely to be the issue - especially=
=20
> since it seems to have been disabled again in commit 6f0771de903b ...
> Fabiano, why did you disable it here again? The reason is not mentioned i=
n=20
> the commit description.

Your patch 81c2c9dd5d was merged between my v1 and v2 on the list and I
didn't notice so I messed up the rebase. I'll send a patch soon to fix
that.

