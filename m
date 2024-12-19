Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13400E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOLeT-0002sE-OV; Thu, 19 Dec 2024 13:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tOLeR-0002s1-EZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:53:35 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tOLeL-0005Vo-H9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:53:34 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC2FA1F460;
 Thu, 19 Dec 2024 18:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734634406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSEINbWH7JBpLBFW/Wi1my6rhCBjVygh6iwG/VAhums=;
 b=o+xf5MbBVQvgbnKhhXpKpwrJ66+5DopedHEjlyPmqOFNvtTciN9mnLy4DncWAjkD9hGDUk
 qulgbt//XAe6WjcFJizoYm+1nUI0pTRdzD8y5C/SAOJ/cT6QKj0yydmtr9EEI/aUb3VaRv
 zmCVUE9jGkx71/PU8F83sDe4Sv9ShbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734634406;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSEINbWH7JBpLBFW/Wi1my6rhCBjVygh6iwG/VAhums=;
 b=/+6lRWD5Ttsw4j+UXGRpqbhXLohqNJC/hvhCpWr+38+bew+FPCS4QB5/XgJekUfJs8BsGY
 MCIZDhZN6GZlTABQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734634405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSEINbWH7JBpLBFW/Wi1my6rhCBjVygh6iwG/VAhums=;
 b=ufdA4xszq3iRUgVTFQ058KHoZ1xzQ4k2kOxYMUt/J5iC//bThBECYRliDYdt4PUD0AgiKN
 TK/RPlTtNk663rNFayZMVmD72Wa+zPBchR8PIhhtdMNQBIf4WqHvckAW+QtaKkXrivUPpH
 FxRG4UDmXsF6rLxvogNTLtBLdVU/lAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734634405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSEINbWH7JBpLBFW/Wi1my6rhCBjVygh6iwG/VAhums=;
 b=4r8JKgWTNCtzJIW15wEvt4AZeA5O+vAeZKzY/adzBKLZZfNa40Lj5MxYp6Oev88H7FFiO3
 u3i0iUZwTcoqNjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 711D913A32;
 Thu, 19 Dec 2024 18:53:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8ksADqVrZGdTdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 19 Dec 2024 18:53:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PULL 00/17] Migration patches for 2024-12-17
In-Reply-To: <20241219123213.GA692742@fedora>
References: <20241217174855.24971-1-farosas@suse.de>
 <20241219123213.GA692742@fedora>
Date: Thu, 19 Dec 2024 15:53:22 -0300
Message-ID: <87zfkrtsgt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Hi Fabiano,
> Please take a look at this CI failure:
>
>>>> MALLOC_PERTURB_=3D61 QTEST_QEMU_BINARY=3D./qemu-system-s390x UBSAN_OPT=
IONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktr=
ace=3D1 QTEST_QEMU_IMG=3D./qemu-img MESON_TEST_ITERATION=3D1 MSAN_OPTIONS=
=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktrace=
=3D1 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 =
PYTHON=3D/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/pyve=
nv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-sto=
rage-daemon G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/4S3awx_3/0/qemu=
-project/qemu/tests/dbus-vmstate-daemon.sh /home/gitlab-runner/builds/4S3aw=
x_3/0/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95
> stderr:
> Traceback (most recent call last):
>   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scr=
ipts/analyze-migration.py", line 688, in <module>
>     dump.read(dump_memory =3D args.memory)
>   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scr=
ipts/analyze-migration.py", line 625, in read
>     section.read()
>   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scr=
ipts/analyze-migration.py", line 461, in read
>     field['data'] =3D reader(field, self.file)
>   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scr=
ipts/analyze-migration.py", line 434, in __init__
>     for field in self.desc['struct']['fields']:
> KeyError: 'fields'

This is the command line that runs only this specific test:

PYTHON=3D/usr/bin/python3.11 QTEST_QEMU_BINARY=3D./qemu-system-s390x
./tests/qtest/migration-test -p /s390x/migration/analyze-script

I cannot reproduce in migration-next nor in the detached HEAD that the
pipeline ran in (had to download the tarball from gitlab).

The only s390 patch in this PR is one that I can test just fine with
TCG, so there shouldn't be any difference from KVM (i.e. there should be
no state being migrated with KVM that is not already migrated with TCG).

> warning: fd: migration to a file is deprecated. Use file: instead.
> warning: fd: migration to a file is deprecated. Use file: instead.

This is harmless.

> **
> ERROR:../tests/qtest/migration-test.c:36:main: assertion failed (ret =3D=
=3D 0): (1 =3D=3D 0)
> (test program exited with status code -6)

This is the assert at the end of the tests, irrelevant.

>
> https://gitlab.com/qemu-project/qemu/-/jobs/8681858344#L8190
>
> If you find this pull request caused the failure, please send a new
> revision. Otherwise please let me know so we can continue to
> investigate.

I don't have an s390x host at hand so the only thing I can to is to drop
that patch and hope that resolves the problem. @Peter, @Thomas, any
other ideas? Can you verify this on your end?

