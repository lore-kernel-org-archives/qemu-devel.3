Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744FAD6EC0B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 13:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH1I2-0005tz-0Z; Fri, 29 Nov 2024 08:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tH1Hy-0005tn-Tj
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:44:06 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tH1Hw-0007cK-Rb
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:44:06 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5BA0521187;
 Fri, 29 Nov 2024 13:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732887843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QF/FaeBVFhhUEjylOBvmOTxgpJIPpzdx+nf4LVkH1OQ=;
 b=MccAaFbwDbsPliSL756O288abaIuphG5hl33CBdKEFbys0hxwswhaH2a/mV1YjvSHQ7b4x
 geIrfEFgfZl5RpyVfjP2i4THXahSk843Clw7xN3LYdj3bE9JWz+vpauq1oHXNzTxPiITE7
 /pBcuUfHY4jMrab595kORd8KaOs0V6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732887843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QF/FaeBVFhhUEjylOBvmOTxgpJIPpzdx+nf4LVkH1OQ=;
 b=t2YcXUL1KLMVeSBuB/WUA2hFIBEPXlZev+BQc+/vIWfYbOk8CyrlgGkeE6jcXSN/0l3p1C
 tKfp7ipfoCKo7HBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732887843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QF/FaeBVFhhUEjylOBvmOTxgpJIPpzdx+nf4LVkH1OQ=;
 b=MccAaFbwDbsPliSL756O288abaIuphG5hl33CBdKEFbys0hxwswhaH2a/mV1YjvSHQ7b4x
 geIrfEFgfZl5RpyVfjP2i4THXahSk843Clw7xN3LYdj3bE9JWz+vpauq1oHXNzTxPiITE7
 /pBcuUfHY4jMrab595kORd8KaOs0V6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732887843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QF/FaeBVFhhUEjylOBvmOTxgpJIPpzdx+nf4LVkH1OQ=;
 b=t2YcXUL1KLMVeSBuB/WUA2hFIBEPXlZev+BQc+/vIWfYbOk8CyrlgGkeE6jcXSN/0l3p1C
 tKfp7ipfoCKo7HBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2019133F3;
 Fri, 29 Nov 2024 13:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x81tJSLFSWflJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 29 Nov 2024 13:44:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
In-Reply-To: <87v7w6jkc9.fsf@suse.de>
References: <cover.1729562974.git.yong.huang@smartx.com>
 <87sesmdfl4.fsf@suse.de>
 <CAK9dgmZvj4W2EBxp1_TcdYs3q2aqaRZGZCAk=FRJk-PaB9y_fw@mail.gmail.com>
 <87v7w6jkc9.fsf@suse.de>
Date: Fri, 29 Nov 2024 10:44:00 -0300
Message-ID: <87plmejgtb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Fabiano Rosas <farosas@suse.de> writes:

> Yong Huang <yong.huang@smartx.com> writes:
>
>> On Wed, Oct 23, 2024 at 11:06=E2=80=AFPM Fabiano Rosas <farosas@suse.de>=
 wrote:
>>
>>> yong.huang@smartx.com writes:
>>>
>>> > From: Hyman Huang <yong.huang@smartx.com>
>>> >
>>> > v3:
>>> > 1. Remove the two redundant assignments in [PATCH v2 2/5] suggested by
>>> Daniel
>>> >
>>> > Please review, thanks
>>> > Yong
>>> >
>>> > v2:
>>> > 1. Update the MAINTAINERS section suggested by Fabiano Rosas
>>> > 2. Ensure the dependencies when build the initrd-stress.img suggested=
 by
>>> Daniel
>>> > 3. Fix some bugs
>>> >
>>> > v1:
>>> > The previous patchset:
>>> >
>>> https://lore.kernel.org/qemu-devel/cover.1722957352.git.yong.huang@smar=
tx.com/
>>> > does not made the necessary changes and tests for the upstream versio=
n.
>>> >
>>> > This patchset works for that:
>>> > 1. Move the guestperf to scripts directory suggested by Fabiano Rosas
>>> > 2. Make initrd-stress.img built by default suggested by Fabiano Rosas
>>> > 3. Make the necessary changes to adapt the latest multifd behavior
>>> > 4. A nitpick for multifd migration
>>> > 5. Support multifd compression option
>>> >
>>> > Hyman Huang (5):
>>> >   tests/migration: Move the guestperf tool to scripts directory
>>> >   tests/migration: Make initrd-stress.img built by default
>>> >   guestperf: Support deferred migration for multifd
>>> >   guestperf: Nitpick the inconsistent parameters
>>> >   guestperf: Introduce multifd compression option
>>> >
>>> >  MAINTAINERS                                   |  5 +++
>>> >  .../migration/guestperf-batch.py              |  0
>>> >  .../migration/guestperf-plot.py               |  0
>>> >  {tests =3D> scripts}/migration/guestperf.py     |  0
>>> >  .../migration/guestperf/__init__.py           |  0
>>> >  .../migration/guestperf/comparison.py         | 15 ++++++++-
>>> >  .../migration/guestperf/engine.py             | 33 ++++++++++++++++-=
--
>>> >  .../migration/guestperf/hardware.py           |  0
>>> >  .../migration/guestperf/plot.py               |  0
>>> >  .../migration/guestperf/progress.py           |  0
>>> >  .../migration/guestperf/report.py             |  0
>>> >  .../migration/guestperf/scenario.py           |  7 ++--
>>> >  .../migration/guestperf/shell.py              |  3 ++
>>> >  .../migration/guestperf/timings.py            |  0
>>> >  tests/migration/meson.build                   | 30 +++++++++--------
>>> >  15 files changed, 73 insertions(+), 20 deletions(-)
>>> >  rename {tests =3D> scripts}/migration/guestperf-batch.py (100%)
>>> >  rename {tests =3D> scripts}/migration/guestperf-plot.py (100%)
>>> >  rename {tests =3D> scripts}/migration/guestperf.py (100%)
>>> >  rename {tests =3D> scripts}/migration/guestperf/__init__.py (100%)
>>> >  rename {tests =3D> scripts}/migration/guestperf/comparison.py (89%)
>>> >  rename {tests =3D> scripts}/migration/guestperf/engine.py (93%)
>>> >  rename {tests =3D> scripts}/migration/guestperf/hardware.py (100%)
>>> >  rename {tests =3D> scripts}/migration/guestperf/plot.py (100%)
>>> >  rename {tests =3D> scripts}/migration/guestperf/progress.py (100%)
>>> >  rename {tests =3D> scripts}/migration/guestperf/report.py (100%)
>>> >  rename {tests =3D> scripts}/migration/guestperf/scenario.py (93%)
>>> >  rename {tests =3D> scripts}/migration/guestperf/shell.py (98%)
>>> >  rename {tests =3D> scripts}/migration/guestperf/timings.py (100%)
>>>
>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>>
>>>
>>> Thinking out loud a little bit, it's still somewhat obscure from which
>>> directory this script should be called. None of these invocations work:
>>>
>>> $ ./scripts/migration/guestperf.py
>>>
>>> $ ./build/scripts/migration/guestperf.py
>>>
>>> $ cd scripts/migration
>>> $ ./guestperf.py
>>>
>>> $ cd build/scripts/migration
>>> $ ./guestperf.py
>>>
>>> Failed to open file =E2=80=9Ctests/migration/initrd-stress.img=E2=80=9D=
: open() failed:
>>> No such file or directory
>>>
>>> This is the only one that works:
>>> $ cd build
>>> $ ./scripts/migration/guestperf.py
>>>
>>> Maybe we could improve that somehow in the future.
>>>
>>>
>> This patchset could be queued now,
>> Or after refining the documents mentioned above later?
>
> I think it's ok. Let me just rebase this on top of the other series that
> touches the tests/migration/ directory. I'll repost soon.

Well, not so fast, the CI doesn't like the addition of stress.c:

https://gitlab.com/farosas/qemu/-/jobs/8504697373
clang: error: argument unused during compilation: '-pie'

https://gitlab.com/farosas/qemu/-/jobs/8504697378
undefined reference to `_DYNAMIC'

