Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE803E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 19:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUsit-0006SY-2V; Mon, 06 Jan 2025 14:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tUsiq-0006Qs-DB
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 14:25:08 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tUsik-00080D-P5
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 14:25:07 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED9F22116F;
 Mon,  6 Jan 2025 19:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736191498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcjpzwdfYpOYKfaEpoU+FCorLFN8NjI9QvtSYQ3UMSE=;
 b=062T5OxWJPNifw1oQnxS+ZopLmOmKpWmH35ETeQpalPrfS0+WTIsCPPsow7gGF9S4xNk/I
 tBYCSDxYupYudXOqbatN8NZFrnS6WrQgxWsf7MPZYjjIdFeXumOQgZ402ujiOL/1Bt4yxN
 dwrE1Bp/JBwCY0v6ksIp+JiJpmiRm48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736191498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcjpzwdfYpOYKfaEpoU+FCorLFN8NjI9QvtSYQ3UMSE=;
 b=NPeB30ASQWP6rAymRiMwiK7rvx0vBpsRJiXEVjZPiY1bG4eUEweS83h+HKM2kXVzeM8rEf
 PgtBRxcGHiFnCSAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736191496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcjpzwdfYpOYKfaEpoU+FCorLFN8NjI9QvtSYQ3UMSE=;
 b=jfB5vVBK3opkCrPYs4K0ZSGfSYnwwqWmayuaBbw+4RBiY0dBWIv6E49/bpyuzz9jQuoAcW
 z/Tmogyg2jQnE5oZB27uyS5WxFwkSi3iZcbyOkuM5alrpWO4qIWTzHMggekW1J22H5z/jd
 Ka8VmCYKdSCwe0s4xv46nYtZXVOHctI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736191496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcjpzwdfYpOYKfaEpoU+FCorLFN8NjI9QvtSYQ3UMSE=;
 b=6jKfWZOadwBZG1syeiAchtqhJfkRDvQ/da+HWqYW52MAKguEHG6HEmeXj9DZQrhnsAzjXa
 /XrUrB43Glmj2eBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 672DF139AB;
 Mon,  6 Jan 2025 19:24:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7m9YCwgufGffBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 06 Jan 2025 19:24:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] Migration patches for 2024-12-17
In-Reply-To: <Z3wk4GRH6E4kfNma@x1n>
References: <20241217174855.24971-1-farosas@suse.de>
 <20241219123213.GA692742@fedora> <87zfkrtsgt.fsf@suse.de>
 <Z2WbSZkEGSnA-BX9@x1n> <e5199fbb-e16e-4df0-a93d-5c0eecdc1ec7@redhat.com>
 <874j2f92cn.fsf@suse.de>
 <CAJSP0QVxQf4neUewBha9f=n+6-f2eTD_o5f7v+1R2Wm2y07paA@mail.gmail.com>
 <87sepz7guf.fsf@suse.de> <87pll37cin.fsf@suse.de> <Z3wk4GRH6E4kfNma@x1n>
Date: Mon, 06 Jan 2025 16:24:53 -0300
Message-ID: <87ldvn7nju.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,nongnu.org];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jan 03, 2025 at 07:34:08PM -0300, Fabiano Rosas wrote:
>> Fabiano Rosas <farosas@suse.de> writes:
>>=20
>> > Stefan Hajnoczi <stefanha@gmail.com> writes:
>> >
>> >> On Fri, 3 Jan 2025 at 13:32, Fabiano Rosas <farosas@suse.de> wrote:
>> >>>
>> >>> Thomas Huth <thuth@redhat.com> writes:
>> >>>
>> >>> > On 20/12/2024 17.28, Peter Xu wrote:
>> >>> >> On Thu, Dec 19, 2024 at 03:53:22PM -0300, Fabiano Rosas wrote:
>> >>> >>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>> >>> >>>
>> >>> >>>> Hi Fabiano,
>> >>> >>>> Please take a look at this CI failure:
>> >>> >>>>
>> >>> >>>>>>> MALLOC_PERTURB_=3D61 QTEST_QEMU_BINARY=3D./qemu-system-s390x=
 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:pri=
nt_stacktrace=3D1 QTEST_QEMU_IMG=3D./qemu-img MESON_TEST_ITERATION=3D1 MSAN=
_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_sta=
cktrace=3D1 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summa=
ry=3D1 PYTHON=3D/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/bui=
ld/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/q=
emu-storage-daemon G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/4S3awx_3=
/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh /home/gitlab-runner/build=
s/4S3awx_3/0/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
>> >>> >>>> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95
>> >>> >>>> stderr:
>> >>> >>>> Traceback (most recent call last):
>> >>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qem=
u/build/scripts/analyze-migration.py", line 688, in <module>
>> >>> >>>>      dump.read(dump_memory =3D args.memory)
>> >>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qem=
u/build/scripts/analyze-migration.py", line 625, in read
>> >>> >>>>      section.read()
>> >>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qem=
u/build/scripts/analyze-migration.py", line 461, in read
>> >>> >>>>      field['data'] =3D reader(field, self.file)
>> >>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qem=
u/build/scripts/analyze-migration.py", line 434, in __init__
>> >>> >>>>      for field in self.desc['struct']['fields']:
>> >>> >>>> KeyError: 'fields'
>> >>> >>>
>> >>> >>> This is the command line that runs only this specific test:
>> >>> >>>
>> >>> >>> PYTHON=3D/usr/bin/python3.11 QTEST_QEMU_BINARY=3D./qemu-system-s=
390x
>> >>> >>> ./tests/qtest/migration-test -p /s390x/migration/analyze-script
>> >>> >>>
>> >>> >>> I cannot reproduce in migration-next nor in the detached HEAD th=
at the
>> >>> >>> pipeline ran in (had to download the tarball from gitlab).
>> >>> >>>
>> >>> >>> The only s390 patch in this PR is one that I can test just fine =
with
>> >>> >>> TCG, so there shouldn't be any difference from KVM (i.e. there s=
hould be
>> >>> >>> no state being migrated with KVM that is not already migrated wi=
th TCG).
>> >>> >>>
>> >>> >>>> warning: fd: migration to a file is deprecated. Use file: inste=
ad.
>> >>> >>>> warning: fd: migration to a file is deprecated. Use file: inste=
ad.
>> >>> >>>
>> >>> >>> This is harmless.
>> >>> >>>
>> >>> >>>> **
>> >>> >>>> ERROR:../tests/qtest/migration-test.c:36:main: assertion failed=
 (ret =3D=3D 0): (1 =3D=3D 0)
>> >>> >>>> (test program exited with status code -6)
>> >>> >>>
>> >>> >>> This is the assert at the end of the tests, irrelevant.
>> >>> >>>
>> >>> >>>>
>> >>> >>>> https://gitlab.com/qemu-project/qemu/-/jobs/8681858344#L8190
>> >>> >>>>
>> >>> >>>> If you find this pull request caused the failure, please send a=
 new
>> >>> >>>> revision. Otherwise please let me know so we can continue to
>> >>> >>>> investigate.
>> >>> >>>
>> >>> >>> I don't have an s390x host at hand so the only thing I can to is=
 to drop
>> >>> >>> that patch and hope that resolves the problem. @Peter, @Thomas, =
any
>> >>> >>> other ideas? Can you verify this on your end?
>> >>> >>
>> >>> >> Cannot reproduce either here, x86_64 host only.  The report was f=
rom s390
>> >>> >> host, though.  I'm not familiar with the s390 patch, I wonder if =
any of you
>> >>> >> could use plain brain power to figure more things out.
>> >>> >>
>> >>> >> We could wait for 1-2 more days to see whether Thomas can figure =
it out,
>> >>> >> hopefully easily reproduceable on s390.. or we can also leave tha=
t for
>> >>> >> later.  And if the current issue on such fix is s390-host-only, m=
ight be
>> >>> >> easier to be picked up by s390 tree, perhaps?
>> >>> >
>> >>> > I tested migration-20241217-pull-request on a s390x (RHEL) host, b=
ut I
>> >>> > cannot reproduce the issue there - make check-qtest works without =
any
>> >>> > problems. Is it maybe related to that specific Ubuntu installation?
>> >>> >
>> >>>
>> >>> Since we cannot reproduce outside of the staging CI, could we run th=
at
>> >>> job again with a diagnostic patch? Here's the rebased PR with the pa=
tch:
>> >>>
>> >>> https://gitlab.com/farosas/qemu/-/commits/migration-next
>> >>>
>> >>> (fork CI run: https://gitlab.com/farosas/qemu/-/pipelines/1610691202)
>> >>>
>> >>> Or should I just send a v2 of this PR with the debug patch?
>> >>
>> >> Here is the staging CI pipeline for your migration-next tree:
>> >> https://gitlab.com/qemu-project/qemu/-/pipelines/1610836485
>> >
>> > Great, thanks! Let's find out what is going on...
>> >
>>=20
>> It seems the issue is here:
>>=20
>> {"name": "css", "array_len": 256, "type": "struct", "struct": {}, "size"=
: 1}
>>                                                               ^
>> And in QEMU:
>>=20
>> static const VMStateDescription vmstate_css =3D {
>>     .name =3D "s390_css",
>>     ...
>> ->      VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(css, ChannelSubSys, MAX_CSSID=
 + 1,
>>                 0, vmstate_css_img, CssImage),
>>=20
>> Is it legal to have an empty array? I would assume so. Are we maybe
>> missing a .needed?
>
> I guess we can always decide to dump things even if it's empty.
>
> When I was looking at this, I saw a trick we played in vmstate dump, see
> 07d4e69147 ("migration/vmstate: fix array of ptr with nullptrs").  I am
> guessing we hit a nullptr (or a bunch of..) here so the JSON part is
> ignored.
>
>>=20
>> Comparing with another similar vmstate spapr_llan/rx_pools in ppc
>> (-device spapr-vlan), what I see is:
>>=20
>> {"name": "rx_pool", "array_len": 5, "type": "struct", "struct":
>> {"vmsd_name": "spapr_llan/rx_buffer_pool", ... }, "size": 32776}
>>=20
>> So for CSS I'd expect:
>>=20
>> -{"name": "css", "array_len": 256, "type": "struct", "struct": {}, "size=
": 1}
>> +{"name": "css", "array_len": 256, "type": "struct", "struct": {"vmsd_na=
me": "s390_css_img", ...}, "size": 1}
>>=20
>> What is weird is that in my TCG run it also shows the empty struct and
>> the script doesn't seem to care. For some reason, in the CI job it
>> parses further into the JSON.
>>=20
>> If anyone spots something, let me know. I'll get back to this on Monday
>> with a fresh mind.
>

Hi, Peter

We already spoke on IRC, but so everyone is in the same page:

The analyze-migration.py script is broken for s390x even in
master. That's why* we cannot reproduce this issue in our local
setups. The s390-storage_attributes section is failing to parse the last
STATTR_FLAG_EOS, which is a u64 0x1 that the generic code then reads a
byte from and sees 0x0 =3D=3D QEMU_VM_EOF.

*- yes, this doesn't account for the s390 host that Thomas used
   which didn't reproduce the issue, but still...

The patch is here and I'll include it at the end of the email as well:

https://gitlab.com/farosas/qemu/-/commit/5bcad03aad85556a7b72f79d3574e246a9=
9432c3.patch

> So I thought about a solution; it's not easy to do it clean in a small
> change.  So here it is, not so small but not huge either.  This is the
> cleanest I can come up with.. attached at the end.
>
> If it works, we're 100% lucky.  I hope VMSDFieldGeneric in the script will
> already work for the nullptrs.  If not, hopefully this provides some
> insight so you can move further..
>
> =3D=3D=3D8<=3D=3D=3D
> From e5339d55f71df2d96d99dbd7eb845f06da0e68aa Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Mon, 6 Jan 2025 13:18:25 -0500
> Subject: [PATCH] migration: Dump correct JSON format for nullptr replacem=
ent
>
> QEMU plays a trick with null pointers inside an array of pointers in a VM=
SD
> field.  See 07d4e69147 ("migration/vmstate: fix array of ptr with
> nullptrs") for more details on why.  The idea makes sense in general, but
> it may overlooked the JSON writer where it could write nothing in a
> "struct" in the JSON hints section.

Interesting, I didn't know about that. I'm indeed seeing some stray "48"
('0') now in the stream. I'll give your patch a try.

Here's the fix for the pre-existing issue in the script:

-- 8< --
From 5bcad03aad85556a7b72f79d3574e246a99432c3 Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Mon, 6 Jan 2025 15:05:31 -0300
Subject: [PATCH 1/2] migration: Fix parsing of s390 stream

The parsing for the S390StorageAttributes section is currently leaving
an unconsumed token that is later interpreted by the generic code as
QEMU_VM_EOF, cutting the parsing short.

The migration will issue a STATTR_FLAG_DONE between iterations, but
there's a final STATTR_FLAG_EOS at .save_complete.

Fixes: 81c2c9dd5d ("tests/qtest/migration-test: Fix analyze-migration.py fo=
r s390x")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/analyze-migration.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index f2457b1dde..2a2160cbf7 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -65,6 +65,9 @@ def readvar(self, size =3D None):
     def tell(self):
         return self.file.tell()
=20
+    def seek(self, a, b):
+        return self.file.seek(a, b)
+
     # The VMSD description is at the end of the file, after EOF. Look for
     # the last NULL byte, then for the beginning brace of JSON.
     def read_migration_debug_json(self):
@@ -272,11 +275,24 @@ def __init__(self, file, version_id, device, section_=
key):
         self.section_key =3D section_key
=20
     def read(self):
+        pos =3D 0
         while True:
             addr_flags =3D self.file.read64()
             flags =3D addr_flags & 0xfff
-            if (flags & (self.STATTR_FLAG_DONE | self.STATTR_FLAG_EOS)):
+
+            if flags & self.STATTR_FLAG_DONE:
+                pos =3D self.file.tell()
+                continue
+            elif flags & self.STATTR_FLAG_EOS:
                 return
+            else:
+                # No EOS came after DONE, that's OK, but rewind the
+                # stream because this is not our data.
+                if pos:
+                    self.file.seek(pos, 0)
+                    return
+                raise Exception("Unknown flags %x", flags)
+
             if (flags & self.STATTR_FLAG_ERROR):
                 raise Exception("Error in migration stream")
             count =3D self.file.read64()
--=20
2.35.3


