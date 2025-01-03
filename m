Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D484DE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 18:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTmRu-0005Si-JL; Fri, 03 Jan 2025 13:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTmRo-0005SG-J4
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 13:31:03 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTmRm-0002SW-3F
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 13:31:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B7CC1F37C;
 Fri,  3 Jan 2025 18:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735929052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKV8zZScHhU+FTwpnsd79XkSMFHf6NrWuyhUUGV5ubg=;
 b=jYlv8/bIEkp/dqwJNI7LtnQHV+FAhwOCjDWnlh+30Z6/ffhlfW6P6xSI0q5pQigWne/1jH
 EPueXMV9DdXk7hqdQ5jQLPqh7dEcrFXOUqtgaN2kz2T263APdodanwJkRSYKxwzy0T4Bdv
 oalSLG+ePd5uoirG/YnepGiukGLfSAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735929052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKV8zZScHhU+FTwpnsd79XkSMFHf6NrWuyhUUGV5ubg=;
 b=BMq5THW5ncAvEaDk52W9tVGbkuL5r+D5MBEPIoR3A0oaEm8O4w+Q5hCLdRybG2oIeUfQAo
 Z5mjeu8nIRLNyMAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="jYlv8/bI";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BMq5THW5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735929052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKV8zZScHhU+FTwpnsd79XkSMFHf6NrWuyhUUGV5ubg=;
 b=jYlv8/bIEkp/dqwJNI7LtnQHV+FAhwOCjDWnlh+30Z6/ffhlfW6P6xSI0q5pQigWne/1jH
 EPueXMV9DdXk7hqdQ5jQLPqh7dEcrFXOUqtgaN2kz2T263APdodanwJkRSYKxwzy0T4Bdv
 oalSLG+ePd5uoirG/YnepGiukGLfSAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735929052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKV8zZScHhU+FTwpnsd79XkSMFHf6NrWuyhUUGV5ubg=;
 b=BMq5THW5ncAvEaDk52W9tVGbkuL5r+D5MBEPIoR3A0oaEm8O4w+Q5hCLdRybG2oIeUfQAo
 Z5mjeu8nIRLNyMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B312134E4;
 Fri,  3 Jan 2025 18:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BLELMNsseGeBGwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 Jan 2025 18:30:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] Migration patches for 2024-12-17
In-Reply-To: <e5199fbb-e16e-4df0-a93d-5c0eecdc1ec7@redhat.com>
References: <20241217174855.24971-1-farosas@suse.de>
 <20241219123213.GA692742@fedora> <87zfkrtsgt.fsf@suse.de>
 <Z2WbSZkEGSnA-BX9@x1n> <e5199fbb-e16e-4df0-a93d-5c0eecdc1ec7@redhat.com>
Date: Fri, 03 Jan 2025 15:30:48 -0300
Message-ID: <874j2f92cn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8B7CC1F37C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
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

Thomas Huth <thuth@redhat.com> writes:

> On 20/12/2024 17.28, Peter Xu wrote:
>> On Thu, Dec 19, 2024 at 03:53:22PM -0300, Fabiano Rosas wrote:
>>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>>
>>>> Hi Fabiano,
>>>> Please take a look at this CI failure:
>>>>
>>>>>>> MALLOC_PERTURB_=3D61 QTEST_QEMU_BINARY=3D./qemu-system-s390x UBSAN_=
OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stac=
ktrace=3D1 QTEST_QEMU_IMG=3D./qemu-img MESON_TEST_ITERATION=3D1 MSAN_OPTION=
S=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktrace=
=3D1 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 =
PYTHON=3D/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/pyve=
nv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-sto=
rage-daemon G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/4S3awx_3/0/qemu=
-project/qemu/tests/dbus-vmstate-daemon.sh /home/gitlab-runner/builds/4S3aw=
x_3/0/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
>>>> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95
>>>> stderr:
>>>> Traceback (most recent call last):
>>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build=
/scripts/analyze-migration.py", line 688, in <module>
>>>>      dump.read(dump_memory =3D args.memory)
>>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build=
/scripts/analyze-migration.py", line 625, in read
>>>>      section.read()
>>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build=
/scripts/analyze-migration.py", line 461, in read
>>>>      field['data'] =3D reader(field, self.file)
>>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build=
/scripts/analyze-migration.py", line 434, in __init__
>>>>      for field in self.desc['struct']['fields']:
>>>> KeyError: 'fields'
>>>
>>> This is the command line that runs only this specific test:
>>>
>>> PYTHON=3D/usr/bin/python3.11 QTEST_QEMU_BINARY=3D./qemu-system-s390x
>>> ./tests/qtest/migration-test -p /s390x/migration/analyze-script
>>>
>>> I cannot reproduce in migration-next nor in the detached HEAD that the
>>> pipeline ran in (had to download the tarball from gitlab).
>>>
>>> The only s390 patch in this PR is one that I can test just fine with
>>> TCG, so there shouldn't be any difference from KVM (i.e. there should be
>>> no state being migrated with KVM that is not already migrated with TCG).
>>>
>>>> warning: fd: migration to a file is deprecated. Use file: instead.
>>>> warning: fd: migration to a file is deprecated. Use file: instead.
>>>
>>> This is harmless.
>>>
>>>> **
>>>> ERROR:../tests/qtest/migration-test.c:36:main: assertion failed (ret =
=3D=3D 0): (1 =3D=3D 0)
>>>> (test program exited with status code -6)
>>>
>>> This is the assert at the end of the tests, irrelevant.
>>>
>>>>
>>>> https://gitlab.com/qemu-project/qemu/-/jobs/8681858344#L8190
>>>>
>>>> If you find this pull request caused the failure, please send a new
>>>> revision. Otherwise please let me know so we can continue to
>>>> investigate.
>>>
>>> I don't have an s390x host at hand so the only thing I can to is to drop
>>> that patch and hope that resolves the problem. @Peter, @Thomas, any
>>> other ideas? Can you verify this on your end?
>>=20
>> Cannot reproduce either here, x86_64 host only.  The report was from s390
>> host, though.  I'm not familiar with the s390 patch, I wonder if any of =
you
>> could use plain brain power to figure more things out.
>>=20
>> We could wait for 1-2 more days to see whether Thomas can figure it out,
>> hopefully easily reproduceable on s390.. or we can also leave that for
>> later.  And if the current issue on such fix is s390-host-only, might be
>> easier to be picked up by s390 tree, perhaps?
>
> I tested migration-20241217-pull-request on a s390x (RHEL) host, but I=20
> cannot reproduce the issue there - make check-qtest works without any=20
> problems. Is it maybe related to that specific Ubuntu installation?
>

Since we cannot reproduce outside of the staging CI, could we run that
job again with a diagnostic patch? Here's the rebased PR with the patch:

https://gitlab.com/farosas/qemu/-/commits/migration-next

(fork CI run: https://gitlab.com/farosas/qemu/-/pipelines/1610691202)

Or should I just send a v2 of this PR with the debug patch?

