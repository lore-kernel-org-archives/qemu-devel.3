Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A87E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 22:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTqFF-000203-N2; Fri, 03 Jan 2025 17:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTqFE-0001zs-35
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 17:34:16 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTqFB-0006ci-29
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 17:34:15 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 237CB21120;
 Fri,  3 Jan 2025 22:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735943651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ilHycfNmrlL7cnUliVDRAnSbJoWbf569se2r6UlNHE=;
 b=npbuSGrH8IQ5K1sK1bq3TlRzrETRNmVnOdLRkV6WrW6RdGJZJG0nZpP7yERz0pIUCDlNm6
 YSu0JLIlsTPlSShjDOK/V7INBUCMTqTrtAxtt7vdR5IF5liz8aaUiPJZyB+OZx1NIp99Sn
 hndfrfE61/yJNguH0JInKX9go8cHL9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735943651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ilHycfNmrlL7cnUliVDRAnSbJoWbf569se2r6UlNHE=;
 b=bHFJPzRhDs1ANZGih+47QqgGHqHG3Zhtq7WR+fPDtbgULhd+3EXBJE5ITjSV4c1CL8oYPK
 lLuL2wANOGQKJhAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735943651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ilHycfNmrlL7cnUliVDRAnSbJoWbf569se2r6UlNHE=;
 b=npbuSGrH8IQ5K1sK1bq3TlRzrETRNmVnOdLRkV6WrW6RdGJZJG0nZpP7yERz0pIUCDlNm6
 YSu0JLIlsTPlSShjDOK/V7INBUCMTqTrtAxtt7vdR5IF5liz8aaUiPJZyB+OZx1NIp99Sn
 hndfrfE61/yJNguH0JInKX9go8cHL9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735943651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ilHycfNmrlL7cnUliVDRAnSbJoWbf569se2r6UlNHE=;
 b=bHFJPzRhDs1ANZGih+47QqgGHqHG3Zhtq7WR+fPDtbgULhd+3EXBJE5ITjSV4c1CL8oYPK
 lLuL2wANOGQKJhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B7D6134E4;
 Fri,  3 Jan 2025 22:34:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id euRGGOJleGd0UAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 Jan 2025 22:34:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] Migration patches for 2024-12-17
In-Reply-To: <87sepz7guf.fsf@suse.de>
References: <20241217174855.24971-1-farosas@suse.de>
 <20241219123213.GA692742@fedora> <87zfkrtsgt.fsf@suse.de>
 <Z2WbSZkEGSnA-BX9@x1n> <e5199fbb-e16e-4df0-a93d-5c0eecdc1ec7@redhat.com>
 <874j2f92cn.fsf@suse.de>
 <CAJSP0QVxQf4neUewBha9f=n+6-f2eTD_o5f7v+1R2Wm2y07paA@mail.gmail.com>
 <87sepz7guf.fsf@suse.de>
Date: Fri, 03 Jan 2025 19:34:08 -0300
Message-ID: <87pll37cin.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

Fabiano Rosas <farosas@suse.de> writes:

> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
>> On Fri, 3 Jan 2025 at 13:32, Fabiano Rosas <farosas@suse.de> wrote:
>>>
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>> > On 20/12/2024 17.28, Peter Xu wrote:
>>> >> On Thu, Dec 19, 2024 at 03:53:22PM -0300, Fabiano Rosas wrote:
>>> >>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>> >>>
>>> >>>> Hi Fabiano,
>>> >>>> Please take a look at this CI failure:
>>> >>>>
>>> >>>>>>> MALLOC_PERTURB_=3D61 QTEST_QEMU_BINARY=3D./qemu-system-s390x UB=
SAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_=
stacktrace=3D1 QTEST_QEMU_IMG=3D./qemu-img MESON_TEST_ITERATION=3D1 MSAN_OP=
TIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stackt=
race=3D1 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
=3D1 PYTHON=3D/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build=
/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qem=
u-storage-daemon G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/4S3awx_3/0=
/qemu-project/qemu/tests/dbus-vmstate-daemon.sh /home/gitlab-runner/builds/=
4S3awx_3/0/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
>>> >>>> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95
>>> >>>> stderr:
>>> >>>> Traceback (most recent call last):
>>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/b=
uild/scripts/analyze-migration.py", line 688, in <module>
>>> >>>>      dump.read(dump_memory =3D args.memory)
>>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/b=
uild/scripts/analyze-migration.py", line 625, in read
>>> >>>>      section.read()
>>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/b=
uild/scripts/analyze-migration.py", line 461, in read
>>> >>>>      field['data'] =3D reader(field, self.file)
>>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/b=
uild/scripts/analyze-migration.py", line 434, in __init__
>>> >>>>      for field in self.desc['struct']['fields']:
>>> >>>> KeyError: 'fields'
>>> >>>
>>> >>> This is the command line that runs only this specific test:
>>> >>>
>>> >>> PYTHON=3D/usr/bin/python3.11 QTEST_QEMU_BINARY=3D./qemu-system-s390x
>>> >>> ./tests/qtest/migration-test -p /s390x/migration/analyze-script
>>> >>>
>>> >>> I cannot reproduce in migration-next nor in the detached HEAD that =
the
>>> >>> pipeline ran in (had to download the tarball from gitlab).
>>> >>>
>>> >>> The only s390 patch in this PR is one that I can test just fine with
>>> >>> TCG, so there shouldn't be any difference from KVM (i.e. there shou=
ld be
>>> >>> no state being migrated with KVM that is not already migrated with =
TCG).
>>> >>>
>>> >>>> warning: fd: migration to a file is deprecated. Use file: instead.
>>> >>>> warning: fd: migration to a file is deprecated. Use file: instead.
>>> >>>
>>> >>> This is harmless.
>>> >>>
>>> >>>> **
>>> >>>> ERROR:../tests/qtest/migration-test.c:36:main: assertion failed (r=
et =3D=3D 0): (1 =3D=3D 0)
>>> >>>> (test program exited with status code -6)
>>> >>>
>>> >>> This is the assert at the end of the tests, irrelevant.
>>> >>>
>>> >>>>
>>> >>>> https://gitlab.com/qemu-project/qemu/-/jobs/8681858344#L8190
>>> >>>>
>>> >>>> If you find this pull request caused the failure, please send a new
>>> >>>> revision. Otherwise please let me know so we can continue to
>>> >>>> investigate.
>>> >>>
>>> >>> I don't have an s390x host at hand so the only thing I can to is to=
 drop
>>> >>> that patch and hope that resolves the problem. @Peter, @Thomas, any
>>> >>> other ideas? Can you verify this on your end?
>>> >>
>>> >> Cannot reproduce either here, x86_64 host only.  The report was from=
 s390
>>> >> host, though.  I'm not familiar with the s390 patch, I wonder if any=
 of you
>>> >> could use plain brain power to figure more things out.
>>> >>
>>> >> We could wait for 1-2 more days to see whether Thomas can figure it =
out,
>>> >> hopefully easily reproduceable on s390.. or we can also leave that f=
or
>>> >> later.  And if the current issue on such fix is s390-host-only, migh=
t be
>>> >> easier to be picked up by s390 tree, perhaps?
>>> >
>>> > I tested migration-20241217-pull-request on a s390x (RHEL) host, but I
>>> > cannot reproduce the issue there - make check-qtest works without any
>>> > problems. Is it maybe related to that specific Ubuntu installation?
>>> >
>>>
>>> Since we cannot reproduce outside of the staging CI, could we run that
>>> job again with a diagnostic patch? Here's the rebased PR with the patch:
>>>
>>> https://gitlab.com/farosas/qemu/-/commits/migration-next
>>>
>>> (fork CI run: https://gitlab.com/farosas/qemu/-/pipelines/1610691202)
>>>
>>> Or should I just send a v2 of this PR with the debug patch?
>>
>> Here is the staging CI pipeline for your migration-next tree:
>> https://gitlab.com/qemu-project/qemu/-/pipelines/1610836485
>
> Great, thanks! Let's find out what is going on...
>

It seems the issue is here:

{"name": "css", "array_len": 256, "type": "struct", "struct": {}, "size": 1}
                                                              ^
And in QEMU:

static const VMStateDescription vmstate_css =3D {
    .name =3D "s390_css",
    ...
->      VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(css, ChannelSubSys, MAX_CSSID + =
1,
                0, vmstate_css_img, CssImage),

Is it legal to have an empty array? I would assume so. Are we maybe
missing a .needed?

Comparing with another similar vmstate spapr_llan/rx_pools in ppc
(-device spapr-vlan), what I see is:

{"name": "rx_pool", "array_len": 5, "type": "struct", "struct":
{"vmsd_name": "spapr_llan/rx_buffer_pool", ... }, "size": 32776}

So for CSS I'd expect:

-{"name": "css", "array_len": 256, "type": "struct", "struct": {}, "size": =
1}
+{"name": "css", "array_len": 256, "type": "struct", "struct": {"vmsd_name"=
: "s390_css_img", ...}, "size": 1}

What is weird is that in my TCG run it also shows the empty struct and
the script doesn't seem to care. For some reason, in the CI job it
parses further into the JSON.

If anyone spots something, let me know. I'll get back to this on Monday
with a fresh mind.

