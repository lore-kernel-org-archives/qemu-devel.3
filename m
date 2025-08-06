Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA96C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 12:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujcpm-0001hf-4q; Wed, 06 Aug 2025 08:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <werner@suse.de>) id 1ujY3J-0002Cm-Kw
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 02:55:09 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <werner@suse.de>) id 1ujY3H-0006Jl-4r
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 02:55:09 -0400
Received: from mydomainname.com (unknown
 [IPv6:2a07:de40:a101:3:21c:c0ff:fea4:1c14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0B9C52124C;
 Wed,  6 Aug 2025 06:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754463303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7BS65gToqlPi6L/SjsAGQaiV1rK5D2jqZBp1sOPGaH8=;
 b=i/EHIRTB03Oa+W2SP6wU7vi1VeBzGMudwOt0FHd81FHOBMIhCqBeFImCwwFcer0qBVQ5ho
 78ngizzbos0osqdWNzpNpOVA4gNKKKWIXW9KV++/jARq9gDiImZo/n9wq0S8pW8mobxOAE
 x7cOerC+eeR1LEnl/uzES6lktd1QVZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754463303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7BS65gToqlPi6L/SjsAGQaiV1rK5D2jqZBp1sOPGaH8=;
 b=R6kTvoiUq4WtruJHyMrVOYxFnp9zzDijPizSJhNqJCuY4JnQwhDDALxK7TTY+wzGceKIz+
 l0vZxvwtxu0excDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="i/EHIRTB";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=R6kTvoiU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754463303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7BS65gToqlPi6L/SjsAGQaiV1rK5D2jqZBp1sOPGaH8=;
 b=i/EHIRTB03Oa+W2SP6wU7vi1VeBzGMudwOt0FHd81FHOBMIhCqBeFImCwwFcer0qBVQ5ho
 78ngizzbos0osqdWNzpNpOVA4gNKKKWIXW9KV++/jARq9gDiImZo/n9wq0S8pW8mobxOAE
 x7cOerC+eeR1LEnl/uzES6lktd1QVZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754463303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7BS65gToqlPi6L/SjsAGQaiV1rK5D2jqZBp1sOPGaH8=;
 b=R6kTvoiUq4WtruJHyMrVOYxFnp9zzDijPizSJhNqJCuY4JnQwhDDALxK7TTY+wzGceKIz+
 l0vZxvwtxu0excDQ==
Received: from boole.nue2.suse.org (localhost [127.0.0.1])
 by mydomainname.com (8.18.1/8.18.1/SUSE Linux 0.8) with ESMTPS id
 5766t0cN007292
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 6 Aug 2025 08:55:02 +0200
Received: (from werner@localhost)
 by boole.nue2.suse.org (8.18.1/8.18.1/Submit) id 5766t0JS007291;
 Wed, 6 Aug 2025 08:55:00 +0200
Date: Wed, 6 Aug 2025 08:54:51 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Martin Kletzander <mkletzan@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/2] tests/qemu-iotests: Indent expected error messages
Message-ID: <aJL8RH8ePPNEteMg@boole.nue2.suse.org>
References: <cover.1754060086.git.mkletzan@redhat.com>
 <f5be6d407c105fa199d10867f5de48bbd25c008c.1754060086.git.mkletzan@redhat.com>
 <aIzhtcg-TNZE0zH8@redhat.com> <87v7n63lld.fsf@suse.de>
 <aJCaoULvGgKjEL16@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mKVQr9wRQYJ9X9GZ"
Content-Disposition: inline
In-Reply-To: <aJCaoULvGgKjEL16@redhat.com>
X-GPG-Fingerprint: 1B06 BF5A 3829 90FB CBA2  75BE 50E9 0D55 1DC1 6B2E
X-MS-Reactions: disallow
X-Spamd-Result: default: False [-1.11 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 SIGNED_PGP(-2.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 FROM_NAME_HAS_TITLE(1.00)[dr];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain,text/x-patch];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MX_GOOD(-0.01)[];
 RCVD_TLS_LAST(0.00)[]; MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; HAS_ATTACHMENT(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[10];
 DNSWL_BLOCKED(0.00)[2a07:de40:a101:3:21c:c0ff:fea4:1c14:from];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Queue-Id: 0B9C52124C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=werner@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Aug 2025 08:01:12 -0400
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


--mKVQr9wRQYJ9X9GZ
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="uH/Fd1FsaV0ujoTj"
Content-Disposition: inline
Date: Wed, 6 Aug 2025 08:54:51 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
	Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
	Martin Kletzander <mkletzan@redhat.com>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
	Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/2] tests/qemu-iotests: Indent expected error messages


--uH/Fd1FsaV0ujoTj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025/08/04 13:33:53 +0200, Kevin Wolf wrote:
> Am 01.08.2025 um 21:09 hat Fabiano Rosas geschrieben:
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >=20
> > > On Fri, Aug 01, 2025 at 04:59:50PM +0200, Martin Kletzander wrote:
> > >> From: Martin Kletzander <mkletzan@redhat.com>
> > >>=20
> > >> When running all tests the expected "killed" messages are indented
> > >> differently than the actual ones, by three more spaces.  Change it so
> > >> that the messages match and tests pass.
> > >
> > > This would break the tests on my system and CI too.
> > >
> > > What distro are you seeing this on ?
> > >
> > > I'm guessing this is a different in either valgrind or C library ?
> >=20
> > It's bash, we have an open issue about it:
> >=20
> > https://gitlab.com/qemu-project/qemu/-/issues/3050
>=20
> I see a patch has been posted to that bug, the most important part of
> which is this added filtering:
>=20
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter  2025-07-25 11:39:22.419665788 +00=
00
> @@ -75,7 +75,7 @@ _filter_qemu_io()
>      _filter_win32 | \
>      gsed -e "s/[0-9]* ops\; [0-9/:. sec]* ([0-9/.inf]* [EPTGMKiBbytes]*\=
/sec and [0-9/.inf]* ops\/sec)/X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops=
\/sec)/" \
>          -e "s/: line [0-9][0-9]*:  *[0-9][0-9]*\( Aborted\| Killed\)/:\1=
/" \
> -        -e "s/qemu-io> //g"
> +        -e "s/qemu-io> //g" -e '/Killed/{ s/ \{2,\}/ /}'
>  }
>=20
>  # replace occurrences of QEMU_PROG with "qemu"
>=20
> This approach makes sense to me, though I would have kept each sed
> expression on a separate line.
>=20
> And given that the context line above includes "Aborted" as well, maybe
> have it here, too, though none of the actual test outputs have an
> Aborted message any more since commit 3f39447. Or we could have a
> cleanup patch first that removes the unused "Abort" above, just to keep
> things consistent.
>=20
> Either way, please post this as a proper patch on the mailing list.

Just next try in tha attached patch with a fixed version of
the sed command.

Werner

--=20
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr

--uH/Fd1FsaV0ujoTj
Content-Type: text/x-patch; charset=utf-8
Content-Description: padding.patch
Content-Disposition: attachment; filename=padding.patch
Content-Transfer-Encoding: quoted-printable

=46rom: Werner Fink <werner@suse.de>
Date: Fri, 08 Aug 06:41:23 +0000
Subject: [PATCH 1/1] Avoid dependency on padding on signal messages

New bash 5.3 uses a different padding for reporting job status.

Resolves: boo#1246830
Signed-off-by: Werner Fink <werner@suse.de>
---
 tests/qemu-iotests/039.out       |   10 +++++-----
 tests/qemu-iotests/061.out       |    4 ++--
 tests/qemu-iotests/137.out       |    2 +-
 tests/qemu-iotests/common.filter |    2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out	2025-07-25 11:36:51.949026116 +0000
@@ -11,7 +11,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO=
}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"=
 )
+./common.rc: Killed ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO}" _qemu_proc_exe=
c "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     [0]
 ERROR cluster 5 refcount=3D0 reference=3D1
 ERROR OFLAG_COPIED data cluster: l2_entry=3D8000000000050000 refcount=3D0
@@ -46,7 +46,7 @@ read 512/512 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO=
}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"=
 )
+./common.rc: Killed ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO}" _qemu_proc_exe=
c "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     [0]
 ERROR cluster 5 refcount=3D0 reference=3D1
 Rebuilding refcount structure
@@ -60,7 +60,7 @@ incompatible_features     []
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO=
}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"=
 )
+./common.rc: Killed ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO}" _qemu_proc_exe=
c "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     []
 No errors were found on the image.
=20
@@ -79,7 +79,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO=
}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"=
 )
+./common.rc: Killed ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO}" _qemu_proc_exe=
c "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     [0]
 ERROR cluster 5 refcount=3D0 reference=3D1
 ERROR OFLAG_COPIED data cluster: l2_entry=3D8000000000050000 refcount=3D0
@@ -89,7 +89,7 @@ Data may be corrupted, or further writes
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO=
}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"=
 )
+./common.rc: Killed ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO}" _qemu_proc_exe=
c "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     []
 No errors were found on the image.
 *** done
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out	2025-07-25 11:36:51.949026116 +0000
@@ -118,7 +118,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO=
}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"=
 )
+./common.rc: Killed ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO}" _qemu_proc_exe=
c "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 magic                     0x514649fb
 version                   3
 backing_file_offset       0x0
@@ -304,7 +304,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO=
}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"=
 )
+./common.rc: Killed ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO}" _qemu_proc_exe=
c "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 magic                     0x514649fb
 version                   3
 backing_file_offset       0x0
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out	2025-07-25 11:36:51.949026116 +0000
@@ -35,7 +35,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGF
 qemu-io: Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allow=
ed are any of the following: none, constant, cached, all
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO=
}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"=
 )
+./common.rc: Killed ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO}" _qemu_proc_exe=
c "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 OK: Dirty bit not set
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter	2025-08-06 06:41:23.649980764 +0000
@@ -74,7 +74,7 @@ _filter_qemu_io()
 {
     _filter_win32 | \
     gsed -e "s/[0-9]* ops\; [0-9/:. sec]* ([0-9/.inf]* [EPTGMKiBbytes]*\/s=
ec and [0-9/.inf]* ops\/sec)/X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/=
sec)/" \
-        -e "s/: line [0-9][0-9]*:  *[0-9][0-9]*\( Aborted\| Killed\)/:\1/"=
 \
+        -e "s/: line [0-9][0-9]*:  *[0-9][0-9]*\( Aborted\| Killed\) \{2,\=
}/:\1 /" \
         -e "s/qemu-io> //g"
 }
=20

--uH/Fd1FsaV0ujoTj--

--mKVQr9wRQYJ9X9GZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJgBAABCABKFiEEGwa/WjgpkPvLonW+UOkNVR3Bay4FAmiS/DwsFIAAAAAAFQAO
cGthLWFkZHJlc3NAZ251cGcub3Jnd2VybmVyQHN1c2UuZGUACgkQUOkNVR3Bay7b
IA/+KQ9xsawXRwAl/aZfQiRV7jQbhjIqXeDhZGe6m882q46ZkZnY3sxbyAX2Yixi
blNfRSwoRP5fpeAYhkZiCHp2wZ6llSiNSXIoHBJHFVCQqZAAIei58mcjzOxu+RVe
YvZSHj/lBHkdt0anfieZMa+w4sZXFCQHyHQxKc9T0DZz1bknpAQF9skC/oZiydwT
k6QgJ5OfzonNPdDM4/Hq6k5miUMXjw/mt+kjjrTtGfZ/CF3kMUMxJHoZE3By2zIK
oBPwyAtL/BA1XMdqFUbAeMSUA3ZhCBBWbN3VSoVzJ6LHGKykEwwMAatXMi+he8Sk
Ka+q2ffk5enKgRZRrlpF7olq6iS1Qj7LavI/Sispwsv+B63Y9EuoTXFYqXFu6wZD
Rmlacl5gK8wyN0a5jsaB8Sur0vt/c6F2UZQLvwlh+xONjheY6KlzHOLSqNXnrcex
79S3iVkSfDRjz0e0JLg5e6S9nJfYSeonTERlEuFfzlD+HvXQh9VO6XW9EKlBjlSe
Mr6/twlYOlvdfA1GSXQ1pV1N3izWaNeNzccnogkDCyWFKDW/EEhAa8r2VathBMnU
Ody2JC67PC9TQ1mib+zfqxW1XlIDs6xMvbwQKSXeRaLSCZ7X7wWCLfdgeu0pDdcu
8WnWqDPTd9gxjn/Lb6XcJFR4Rgpg27ZWyYX4VAgAnd1stHs=
=yJGY
-----END PGP SIGNATURE-----

--mKVQr9wRQYJ9X9GZ--

