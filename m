Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F2FE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 21:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTon3-0006FQ-Cj; Fri, 03 Jan 2025 16:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTomn-00067r-7x
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 16:00:55 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTomk-0003Gr-5q
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 16:00:48 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8374A1F37C;
 Fri,  3 Jan 2025 21:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735938044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0aYCiFWWe1+b8QtL/MrNg1W7FkDRlX+vFNOdvZZJD+s=;
 b=yiJO6arYMMy2Ie2PFaRbJj8Iji378naoL8OtxcfsF4Ortln4V7Waio8uyNGgBeOv5fHJDw
 KGu38b7NvAx9azHe255+Unu0fWjrz7u0gnvqIYiXkNQgYVvfbb7syJjhDAklQgRomsiC7w
 KhSthVbiyZTCyBbWohf9wdS6FOdosg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735938044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0aYCiFWWe1+b8QtL/MrNg1W7FkDRlX+vFNOdvZZJD+s=;
 b=knxExjqlTm6oG3LG99AJ4nIMEU/zwlDvoyiycS+ADLPpRcWFYIQn7inAvVeOW7uc2hCwq7
 UStj24mmCdEw97Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735938043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0aYCiFWWe1+b8QtL/MrNg1W7FkDRlX+vFNOdvZZJD+s=;
 b=yTByTFVKFnU3OZbzoYNNmUmoK87v992vpKU0ypTfKCOsebuqWRDoluMk0JzFPwrwun8+az
 CVIx9OJbeUWDaffoxNXz9egmPLLLR4NNqFyzruwDUvrSdVoxo7spNShK2/CqOuWWC5UnU4
 x9QOu6Wq1wz8VczPouvLotJQM2596LQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735938043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0aYCiFWWe1+b8QtL/MrNg1W7FkDRlX+vFNOdvZZJD+s=;
 b=QO4s12xR5tmVjaj0lgHPc8VjbUguvXC9YaOb50ahhzWhw4z6nBj01rg35c1YZrL1Mya0xX
 6Ru88qB7PnZdxVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0560413418;
 Fri,  3 Jan 2025 21:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5x+5LvpPeGdePAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 Jan 2025 21:00:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] Migration patches for 2024-12-17
In-Reply-To: <CAJSP0QVxQf4neUewBha9f=n+6-f2eTD_o5f7v+1R2Wm2y07paA@mail.gmail.com>
References: <20241217174855.24971-1-farosas@suse.de>
 <20241219123213.GA692742@fedora> <87zfkrtsgt.fsf@suse.de>
 <Z2WbSZkEGSnA-BX9@x1n> <e5199fbb-e16e-4df0-a93d-5c0eecdc1ec7@redhat.com>
 <874j2f92cn.fsf@suse.de>
 <CAJSP0QVxQf4neUewBha9f=n+6-f2eTD_o5f7v+1R2Wm2y07paA@mail.gmail.com>
Date: Fri, 03 Jan 2025 18:00:40 -0300
Message-ID: <87sepz7guf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-0.999];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Fri, 3 Jan 2025 at 13:32, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>> > On 20/12/2024 17.28, Peter Xu wrote:
>> >> On Thu, Dec 19, 2024 at 03:53:22PM -0300, Fabiano Rosas wrote:
>> >>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>> >>>
>> >>>> Hi Fabiano,
>> >>>> Please take a look at this CI failure:
>> >>>>
>> >>>>>>> MALLOC_PERTURB_=3D61 QTEST_QEMU_BINARY=3D./qemu-system-s390x UBS=
AN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_s=
tacktrace=3D1 QTEST_QEMU_IMG=3D./qemu-img MESON_TEST_ITERATION=3D1 MSAN_OPT=
IONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktr=
ace=3D1 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
=3D1 PYTHON=3D/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build=
/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qem=
u-storage-daemon G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/4S3awx_3/0=
/qemu-project/qemu/tests/dbus-vmstate-daemon.sh /home/gitlab-runner/builds/=
4S3awx_3/0/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
>> >>>> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95
>> >>>> stderr:
>> >>>> Traceback (most recent call last):
>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/bu=
ild/scripts/analyze-migration.py", line 688, in <module>
>> >>>>      dump.read(dump_memory =3D args.memory)
>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/bu=
ild/scripts/analyze-migration.py", line 625, in read
>> >>>>      section.read()
>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/bu=
ild/scripts/analyze-migration.py", line 461, in read
>> >>>>      field['data'] =3D reader(field, self.file)
>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/bu=
ild/scripts/analyze-migration.py", line 434, in __init__
>> >>>>      for field in self.desc['struct']['fields']:
>> >>>> KeyError: 'fields'
>> >>>
>> >>> This is the command line that runs only this specific test:
>> >>>
>> >>> PYTHON=3D/usr/bin/python3.11 QTEST_QEMU_BINARY=3D./qemu-system-s390x
>> >>> ./tests/qtest/migration-test -p /s390x/migration/analyze-script
>> >>>
>> >>> I cannot reproduce in migration-next nor in the detached HEAD that t=
he
>> >>> pipeline ran in (had to download the tarball from gitlab).
>> >>>
>> >>> The only s390 patch in this PR is one that I can test just fine with
>> >>> TCG, so there shouldn't be any difference from KVM (i.e. there shoul=
d be
>> >>> no state being migrated with KVM that is not already migrated with T=
CG).
>> >>>
>> >>>> warning: fd: migration to a file is deprecated. Use file: instead.
>> >>>> warning: fd: migration to a file is deprecated. Use file: instead.
>> >>>
>> >>> This is harmless.
>> >>>
>> >>>> **
>> >>>> ERROR:../tests/qtest/migration-test.c:36:main: assertion failed (re=
t =3D=3D 0): (1 =3D=3D 0)
>> >>>> (test program exited with status code -6)
>> >>>
>> >>> This is the assert at the end of the tests, irrelevant.
>> >>>
>> >>>>
>> >>>> https://gitlab.com/qemu-project/qemu/-/jobs/8681858344#L8190
>> >>>>
>> >>>> If you find this pull request caused the failure, please send a new
>> >>>> revision. Otherwise please let me know so we can continue to
>> >>>> investigate.
>> >>>
>> >>> I don't have an s390x host at hand so the only thing I can to is to =
drop
>> >>> that patch and hope that resolves the problem. @Peter, @Thomas, any
>> >>> other ideas? Can you verify this on your end?
>> >>
>> >> Cannot reproduce either here, x86_64 host only.  The report was from =
s390
>> >> host, though.  I'm not familiar with the s390 patch, I wonder if any =
of you
>> >> could use plain brain power to figure more things out.
>> >>
>> >> We could wait for 1-2 more days to see whether Thomas can figure it o=
ut,
>> >> hopefully easily reproduceable on s390.. or we can also leave that for
>> >> later.  And if the current issue on such fix is s390-host-only, might=
 be
>> >> easier to be picked up by s390 tree, perhaps?
>> >
>> > I tested migration-20241217-pull-request on a s390x (RHEL) host, but I
>> > cannot reproduce the issue there - make check-qtest works without any
>> > problems. Is it maybe related to that specific Ubuntu installation?
>> >
>>
>> Since we cannot reproduce outside of the staging CI, could we run that
>> job again with a diagnostic patch? Here's the rebased PR with the patch:
>>
>> https://gitlab.com/farosas/qemu/-/commits/migration-next
>>
>> (fork CI run: https://gitlab.com/farosas/qemu/-/pipelines/1610691202)
>>
>> Or should I just send a v2 of this PR with the debug patch?
>
> Here is the staging CI pipeline for your migration-next tree:
> https://gitlab.com/qemu-project/qemu/-/pipelines/1610836485

Great, thanks! Let's find out what is going on...

>
> Stefan

