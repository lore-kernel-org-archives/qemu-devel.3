Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804DFC55838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqxNO-0008Oc-3F; Mon, 03 Aug 2026 14:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wqxNF-0008NZ-JK
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 14:26:55 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wqxNB-0004gf-CD
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 14:26:52 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a0ed034947so2236543a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 11:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785781608; cv=none;
 d=google.com; s=arc-20260327;
 b=oC+BKwBL51ZcX5PJCG7JB2jCmyOOoXa2TCXBOMOXoJUyySKRViqi6cYs/ffoh0RU0l
 1nLw1MdZcwccW7OipEKKe0PGdVg0ojDgn4DYdu0LfUsBkHoiz/wVXwao/Sac+qojlzYo
 i7pH/zQEE9w++YD9aqhJH0MZRWnD/ZK7rAq/mFp1+pR+sKEv7VeuUY3skhdQjrmb3nVu
 ci8pY/y8c3ql12JSqCuXGO5hkslcX5mSeOLm4BqdTasvGeDOF+3wmrXtipRJmDHwyJbR
 w7MYu27j+FVlQuMAywjvmqzJhevD63Y7p67/I+SBHRpYxIsTqJCeLkm3/l8Pa+nrZ62B
 Qngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QEjPKU4HZBGH/Oc9mDqEaZ8wd0TP442/45E1X9r7Y9w=;
 fh=TRyg5hw6T48qQHDinJW7gNxLF+rjoOcQR3jmqz5910c=;
 b=NEX3ahlhot1WAyhZOzSQa5R44EfkT7Y0FHbUHIWazM/7MYauHLxiYqvceaS9tic1Ti
 sxpugo/qVZEwtyxIoxAKxDTSJrNp2FAqbvdVtoDoVe60qXfwYx9U4yB1aCVf0bzX844R
 QY2CYs6iw81h1EQ5KJab9njTIWrrddAQ+AZz6x+V9wa3F1Fi7NfAejODMovPzXazRBFu
 08s7ObfA7DDTU8Zdgl4YR6FIhhFZ5pUUy+KUU7JNFEU77Fi0drvpFkpG1/fDPxqJcdCP
 S6zi7zzuEkeiDGYJyGsVr+SS0TNYMylw1ZxvczSjUFUpssSqYBrEtKdwhCiReiFH0Z6R
 exuQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785781608; x=1786386408; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QEjPKU4HZBGH/Oc9mDqEaZ8wd0TP442/45E1X9r7Y9w=;
 b=sqHMmnzy7VEK69pVXlBg1M7IsqXeXhTPmkI5ZfCMfv2uSVJG+JHFd/YZwiAIG6npB6
 /j+82q+4zTf4atj87FKonW6rXOejZzFITLlM5k3IQcVQz8kI0AjPa39FVdveA7ychrAf
 4gS9rT63rVnpMPO6+g7u+6fxGT1y9d0e3O2UEX9EZ13Mdb5XnyGXw7417+xfOPRw6Vww
 +6CgUQc8FRwQ7z01VlDyqTQvMUtVA1I0yFh8bu5fdyR5qUzeDhRY0AKjeUatnn4Y8Xp7
 geyDFld5Fj4CYXnX5Kw8riqKWGTMpot92vVN/BIYLQC6taoKsRQ+eRqS/btwLCN+27xS
 e2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785781608; x=1786386408;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QEjPKU4HZBGH/Oc9mDqEaZ8wd0TP442/45E1X9r7Y9w=;
 b=LElHYGycViWzzvph1SlhIeREcpBC5P8IbvpASswVC+NJ3vfVBbHSr9PH/ezkRVC3SC
 tFMadNUjr1LNfZ1lY0xd5vyyL1K941vJYRGZUuihdSmppryGd5mrcOaNVFLEHKq7y3WG
 hs/VQ9OJHA5d7An3DMPMXmMwXhlg/O3LWxGOjeiGt8EQZ74Bv1wKr7Z5zy4STH69uXMb
 nbjKIH6AnvNV+ICmyrpk1udXpLgc/c+xSQFLtY/wBIdXjonSebXaX3Tz13C9zv65Usin
 E16dhx5FnDWbxQPJhk/JKRLWkb+HTwV/YJOOsui9vumzXD0zvvROQpME+XAEkS95JKTL
 Jrjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCTFSMUVcPkTf28pYCQurk+gaQxXb0v4c1DYlUewjiidVtcvZw29kd6bCPsqLPHHZYL4zqd3jIKFGX@nongnu.org
X-Gm-Message-State: AOJu0YzKdsyqYVD1VIwU8tkgdyKAmQwpMv8aNcE0EMD8mGQ9gNsrkcF6
 ujxWx+gE9UqQLTqlvmfMfnb3y3RxU26adgfuiz8np0JJXfWMdh8UGMSHJxy9O8HvvX5SnudhOJX
 oiH3MS6m3FiCaN9yQIQBv8dXPFE4ATcE=
X-Gm-Gg: AR+sD136i7FBlyx9Vb0ljBJhl0xF/kC3LESdm1M4MiDbHSFI4+RXhAwUuxWrM/N5kXt
 UUR1nPmNcl1+p8AdvCefut/jQ+IlOuimYgTAhz1V45AvFwxzR3IFnB+Z8eE8EDy6y8MShjE/T4A
 RqowjyFtwmvJ/Fx4FaethVepp3bgAfRCUdLcY14noS2/7lucc95OcQGmeke1XLGVmN7etzXj8mt
 ZNdWsdThaCahV3nizK0HFEkKbpmLyHrGZCPew96PUg7LOKkKrVXjaX46BvEQGpRSC0f4xaQSes+
 rWG7G9jv0RjlV/A+JLRQneWVDLrYgbwc02RbdRfewhbrCeJwsIV2zB1kRyFxSVMzxWxlM7dhacj
 TF822j0wL2isF
X-Received: by 2002:a05:6402:21c4:b0:698:1973:1daa with SMTP id
 4fb4d7f45d1cf-6a0a7ca8530mr9130992a12.18.1785781607652; Mon, 03 Aug 2026
 11:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260803084754.20803-1-kwolf@redhat.com>
In-Reply-To: <20260803084754.20803-1-kwolf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 3 Aug 2026 14:26:35 -0400
X-Gm-Features: AUfX_myBkzz0obbkA-rYtP6Hbzjdg1UsKsV4itJv1Nn07aCGNwlyIq62a9Ofzkc
Message-ID: <CAJSP0QVrxBadH3YCwnd+wv5Pf+rWR1dzrvcPr5Kb8CkY6-2EFw@mail.gmail.com>
Subject: Re: [PULL v3 00/17] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 3, 2026 at 4:48=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit b428fe036233cbd15d37e3c027ab6ca4d3661a=
80:
>
>   Merge tag 'pull-target-arm-20260731' of https://gitlab.com/pm215/qemu i=
nto staging (2026-07-31 16:19:04 -0400)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git for-upstream
>
> for you to fetch changes up to 52227e25712629406c89c4902b39962f8b9b6f2c:
>
>   iotests: increase timeouts for tests to 5 minutes (2026-08-03 10:42:29 =
+0200)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - Fix missing locking in latency histogram setters
> - coroutine: fix lost wakeup in qemu_co_sleep_wake()
> - floppy: Fix READ/WRITE/FORMAT/READ ID behaviour with missing medium
> - qcow2: Fix crash on closing a read-only image with dirty bit set
> - cloop: fix integer overflow in total_sectors calculation
> - dmg: Fix out of bounds accesses (CVE-2026-65929, CVE-2026-65928)
> - FUSE export: fix regression with O_TRUNC when export is not growable

The check-python-minreqs job is still failing:

tests/fuse-truncate:43: error: invalid syntax [syntax]
...
tests/fuse-truncate:43:19: E0001: Parsing failed: 'invalid syntax
(<unknown>, line 43)' (syntax-error)

https://gitlab.com/qemu-project/qemu/-/jobs/15683823681#L217

You can run the job locally like this:

$ make docker-image-python
$ podman run --rm -i -v $PWD:/usr/src/qemu:z qemu/python /bin/bash -c
"cd /usr/src/qemu && make -C python check-minreqs"

The invalid syntax also prevents the fuse-truncate test from running
successfully:

>>> LD_LIBRARY_PATH=3D/builds/qemu-project/qemu/build/subprojects/libvfio-u=
ser/lib MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
=3D1:print_stacktrace=3D1 PYTHON=3D/builds/qemu-project/qemu/build/pyvenv/b=
in/python3 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summar=
y=3D1 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D=
1:print_stacktrace=3D1 RUST_BACKTRACE=3D1 MESON_TEST_ITERATION=3D1 MALLOC_P=
ERTURB_=3D36 /builds/qemu-project/qemu/build/pyvenv/bin/python3 /builds/qem=
u-project/qemu/build/../tests/qemu-iotests/check -tap -nbd fuse-truncate --=
source-dir /builds/qemu-project/qemu/tests/qemu-iotests --build-dir /builds=
/qemu-project/qemu/build/tests/qemu-iotests
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
--- /builds/qemu-project/qemu/tests/qemu-iotests/tests/fuse-truncate.out
+++ /builds/qemu-project/qemu/build/scratch/raw-nbd-fuse-truncate/fuse-trun=
cate.out.bad
@@ -1,5 +1,4 @@
-...
-----------------------------------------------------------------------
-Ran 3 tests
-
-OK
+ File "/builds/qemu-project/qemu/tests/qemu-iotests/tests/fuse-truncate",
line 43
+ except OSError, subprocess.CalledProcessError:
+ ^
+SyntaxError: invalid syntax
(test program exited with status code 1)

https://gitlab.com/qemu-project/qemu/-/jobs/15683823663#L179

Stefan

> - iotests: Various small fixes
>
> ----------------------------------------------------------------
> Christian Quante (2):
>       hw/block/fdc: select the drive named by the READ ID command
>       hw/block/fdc: report a missing address mark on an empty drive
>
> Daniel P. Berrang=C3=A9 (1):
>       iotests: increase timeouts for tests to 5 minutes
>
> Denis V. Lunev (8):
>       block/accounting: take stats->lock in latency histogram setters
>       block/qapi: take stats->lock when reading BlockAcctStats for query-=
blockstats
>       tests/unit: add reproducer for BlockAcctStats histogram locking rac=
e
>       qcow2: do not try to clear the dirty bit on a read-only node
>       iotests: run the test pool with the 'fork' start method
>       iotests: skip FUSE tests when FUSE is not usable
>       iotests/migrate-bitmaps-postcopy-test: replace the timing assertion=
 with a content check
>       coroutine: fix lost wakeup in qemu_co_sleep_wake()
>
> Fiona Ebner (2):
>       block/export/fuse: fix regression with O_TRUNC when export is not g=
rowable
>       iotests: test O_TRUNC behavior for fuse exports
>
> Stefan Hajnoczi (3):
>       dmg: fix out-of-bounds load in search_chunk() (CVE-2026-65929)
>       dmg: refuse to open files with no chunks
>       dmg: reject inconsistent UDRW chunk sector count and length (CVE-20=
26-65928)
>
> malike (1):
>       block/cloop: fix integer overflow in total_sectors calculation
>
>  include/block/accounting.h                         |   1 +
>  include/qemu/coroutine.h                           |  17 +-
>  block/accounting.c                                 |  11 +-
>  block/cloop.c                                      |   3 +-
>  block/dmg.c                                        |  36 ++++-
>  block/export/fuse.c                                |  12 ++
>  block/qapi.c                                       |   3 +
>  block/qcow2.c                                      |   6 +-
>  hw/block/fdc.c                                     |  55 ++++++-
>  tests/qtest/fdc-test.c                             |  70 ++++++++-
>  tests/unit/test-block-accounting.c                 | 115 ++++++++++++++
>  tests/unit/test-coroutine.c                        |  53 +++++++
>  util/qemu-coroutine-sleep.c                        |  53 +++++--
>  tests/qemu-iotests/testrunner.py                   |   4 +-
>  tests/qemu-iotests/039                             |  11 ++
>  tests/qemu-iotests/039.out                         |   3 +
>  tests/qemu-iotests/common.rc                       |  14 ++
>  tests/qemu-iotests/meson.build                     |  15 +-
>  tests/qemu-iotests/tests/file-io-error             |   4 +-
>  tests/qemu-iotests/tests/fuse-allow-other          |   2 +
>  tests/qemu-iotests/tests/fuse-mmap-shared          |   9 +-
>  tests/qemu-iotests/tests/fuse-truncate             | 171 +++++++++++++++=
++++++
>  tests/qemu-iotests/tests/fuse-truncate.out         |   5 +
>  .../tests/migrate-bitmaps-postcopy-test            |  15 +-
>  tests/unit/meson.build                             |   1 +
>  25 files changed, 633 insertions(+), 56 deletions(-)
>  create mode 100644 tests/unit/test-block-accounting.c
>  create mode 100755 tests/qemu-iotests/tests/fuse-truncate
>  create mode 100644 tests/qemu-iotests/tests/fuse-truncate.out
>
>

