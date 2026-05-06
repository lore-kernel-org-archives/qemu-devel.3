Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA837CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 06:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKVoj-00081O-Ot; Wed, 06 May 2026 02:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKVoh-000818-Om
 for qemu-devel@nongnu.org; Wed, 06 May 2026 02:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKVof-0005vD-Eg
 for qemu-devel@nongnu.org; Wed, 06 May 2026 02:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778049183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGYzp76QJlLwgZswCLGGg48C356UUUucvd3fSl9bdg8=;
 b=M+xrjMsDYrQzN60kbGVkPbgVTLHo2g3NlPmUenAkEGMcE2vt/afoCNCK5Mjk0Sc9nJ4OOo
 uBURPMUR6+nq1bwASNLFrzm/h8WQ/vYqPhFojZbSudK1M2yXLQFvTgSUkRJA96K0c77sVB
 O3ieM7MiCnxbVItJH4/saT1dGBvAhIc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-sdXG5kfqPWy318ufUMGNxw-1; Wed,
 06 May 2026 02:33:00 -0400
X-MC-Unique: sdXG5kfqPWy318ufUMGNxw-1
X-Mimecast-MFC-AGG-ID: sdXG5kfqPWy318ufUMGNxw_1778049179
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A21619560AA
 for <qemu-devel@nongnu.org>; Wed,  6 May 2026 06:32:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19F63180034E
 for <qemu-devel@nongnu.org>; Wed,  6 May 2026 06:32:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9694C21E6A01; Wed, 06 May 2026 08:32:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/7] qobject: switch JSON parser to push
In-Reply-To: <20260505064919.177855-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 5 May 2026 08:49:12 +0200")
References: <20260505064919.177855-1-pbonzini@redhat.com>
Date: Wed, 06 May 2026 08:32:56 +0200
Message-ID: <87tssldp47.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fails "make check" for me:

    >>> MESON_TEST_ITERATION=3D1 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./stora=
ge-daemon/qemu-storage-daemon RUST_BACKTRACE=3D1 MSAN_OPTIONS=3Dhalt_on_err=
or=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktrace=3D1 MALLOC_PER=
TURB_=3D51 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summa=
ry=3D1:print_stacktrace=3D1 G_TEST_DBUS_DAEMON=3D/work/armbru/qemu/tests/db=
us-daemon.sh QTEST_QEMU_BINARY=3D./qemu-system-x86_64 PYTHON=3D/work/armbru=
/qemu/bld-x86/pyvenv/bin/python3 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_=
error=3D1:print_summary=3D1 QTEST_QEMU_IMG=3D./qemu-img /work/armbru/qemu/b=
ld-x86/tests/qtest/migration-test --tap -k --full
    =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95
    stderr:
    Unexpected error in parse_error() at ../qobject/json-parser.c:166:
    /work/armbru/qemu/bld-x86/tests/qtest/migration-test: JSON parse error =
at line 1, column 54, key is not a string in object

    (test program exited with status code -6)

Backtrace:

    #0  0x00007f89d03c2735 in abort () from /lib64/libc.so.6
    #1  0x000056289af27c35 in error_handle (errp=3D0x56289b0cfc68 <error_ab=
ort>,=20
        err=3D0x5628c8f7cad0) at ../util/error.c:37
    #2  0x000056289af28b5d in error_propagate (
        dst_errp=3D0x56289b0cfc68 <error_abort>, local_err=3D0x5628c8f7cad0)
        at ../util/error.c:300
    #3  0x000056289af1a632 in qobject_from_jsonv (
        string=3D0x56289af87b60 "{ 'execute': 'migrate-set-parameters','arg=
uments': { %s: %lld } }", ap=3D0x7ffd1bd86550, errp=3D0x56289b0cfc68 <error=
_abort>)
        at ../qobject/qjson.c:76
    #4  0x000056289af1a6f3 in qobject_from_vjsonf_nofail (
        string=3D0x56289af87b60 "{ 'execute': 'migrate-set-parameters','arg=
uments': { %s: %lld } }", ap=3D0x7ffd1bd86770) at ../qobject/qjson.c:97
    #5  0x000056289aec789e in _qmp_fd_vsend_fds (fd=3D3, fds=3D0x0, fds_num=
=3D0,=20
        fmt=3D0x56289af87b60 "{ 'execute': 'migrate-set-parameters','argume=
nts': { %s: %lld } }", ap=3D0x7ffd1bd86770) at ../tests/qtest/libqmp.c:148
    #6  0x000056289aec7a8e in qmp_fd_vsend (fd=3D3,=20
        fmt=3D0x56289af87b60 "{ 'execute': 'migrate-set-parameters','argume=
nts': { %s: %lld } }", ap=3D0x7ffd1bd86770) at ../tests/qtest/libqmp.c:190
    #7  0x000056289aec24da in qtest_qmp_vsend (s=3D0x5628c8f3b6f0,=20
        fmt=3D0x56289af87b60 "{ 'execute': 'migrate-set-parameters','argume=
nts': { %s: %lld } }", ap=3D0x7ffd1bd86770) at ../tests/qtest/libqtest.c:872
    #8  0x000056289aec2569 in qtest_vqmp (s=3D0x5628c8f3b6f0,=20

Looks like interpolation broke.


