Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1003C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 04:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubXGR-0005Vf-ET; Tue, 15 Jul 2025 00:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ubXG4-0005Ti-3S
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:27:12 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ubXG0-0004qx-AM
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:27:11 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ae0bc7aa21bso1047567466b.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 21:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752553627; x=1753158427; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDZf6iu4IUJAIKxbC7Y/+dloO1D1y0oy12y7FJbvdUI=;
 b=SuAjIBvL7ZAjIFf2hNCeZfB0FJynP7A4npLWkqybm3CP5iuaYP3P9bsSUTHZov/v4V
 4TPg+v+5IsxKAUC6uGwBUfY6LKgZZbtIaIpoM/EgsZNSCeAZsxMUieGQIfXwAFd7FNaH
 sJ9Ddxxv4uBdyBpfOjqWf4s7oNwTxnDdXf9X0zGqHYE/PE5vAxxy8pcWTc8aoDpQHdbw
 pAe4yzLK/JT4Nbq+kSV3HuN0XDrh5180HE9g22WtiIP1t/hOXdt7fUHPLSYNV1LXl9FI
 x1phGsE1eSJGpAufwzAFO5KILkOzPXlNJFnTvovHoH9bwfYxdrGZHwQxmvYb5iPbGlXj
 XQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752553627; x=1753158427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDZf6iu4IUJAIKxbC7Y/+dloO1D1y0oy12y7FJbvdUI=;
 b=qrJiPebuHZ2LwjksHEMKFSB59zv7Q+WhWF3bwG0N8k+MHqFOQi4zTlbO4HafWFftBt
 2YaGhXv14MpdCNSD+Cff3V6w5tKbaIQVXOBZKHACQ9shhizZj6eVTCm64kmPQVS9SqRi
 7LA0Y25jX+3OYQqsoPiIAKnVmUjCidMnwh2Yi8JgT1EtOLAtPXFTNXRb4HZOvkOHbJMd
 S054udghN6oouFjYJ3M1BHP3vzOCK7d66GhbcUQ0WCaBvH2FpEfV8qbFr+0OEzXea+bK
 FidnFb2C3+Bnm7U1zLgAKUXLVv9ZlaXlgpSNYBYtko/n+83zxkP3qVIah8WP06ZHZ6tN
 DGbQ==
X-Gm-Message-State: AOJu0YwRW5xHWC1SCBLmsqUnYN3t849ZHXVNp5xDDBfXzPl4P/iDGrfk
 amnSMeQl8r6gSKYeA5aLHroZZbuC50hzQ7AgLXI3TO3Ckz55uzRfjAnTFn5n4r5eB2ObhNe2N82
 H7lJnSaZMkY09taQsvW34xk7MhED56og=
X-Gm-Gg: ASbGnctrlfyPIDfU1W7T18wXVgGCE4RJwYPSBY2jRGQ9Py16vGu3gAkhffntSXnTjg6
 78H8eRBMXODb8hMJob8+lPmFVUQrfjZfEzwSZPPM/Gx1KJ8+hA3xI+brZ6ymsZUq4PdjrRzNGiz
 C45qzDZU14QCogMa55G0+07E7HEXmpHnJqn24K950dxxZhERuIlGAlFUuFofuru7rZN7JiGtJrK
 Oc=
X-Google-Smtp-Source: AGHT+IGYzI43oxseZ2Wdm0KPtdjKfQLGJboEbYXuPebYXwGDIWaZX6oxasCjgye2/ri6M/cY8d/yRhY5PPdhq9Mqzas=
X-Received: by 2002:a17:906:6a1d:b0:ae3:cc60:8ce7 with SMTP id
 a640c23a62f3a-ae6fca5120bmr1688184566b.19.1752553626417; Mon, 14 Jul 2025
 21:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250714134458.2991097-1-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 15 Jul 2025 00:26:53 -0400
X-Gm-Features: Ac12FXxSrYiOUrQqBhZ736AfqgWQfFRVhIGYIxsrYA8BANoJV9wy2q5kxKWCE_s
Message-ID: <CAJSP0QV7OS5z65M-5pYdRrj4e-5xmBH=nqHtrrMJAnDcm=Yf8A@mail.gmail.com>
Subject: Re: [PULL 00/32] QAPI patches patches for 2025-07-14
To: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62a.google.com
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

On Mon, Jul 14, 2025 at 11:14=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b5433=
36:
>
>   Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into s=
taging (2025-07-13 01:46:04 -0400)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-07-14
>
> for you to fetch changes up to 07273ca0ce3af397071f7a6c11abdab649ff25e1:
>
>   tests/qtest/qom-test: unit test for qom-list-get (2025-07-14 15:25:12 +=
0200)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2025-07-14
>
> ----------------------------------------------------------------
> John Snow (27):
>       docs/sphinx: adjust qapidoc to cope with same-line error sections
>       docs/sphinx: parse @references in freeform text
>       docs/sphinx: remove legacy QAPI manual generator
>       docs/sphinx: remove special parsing for freeform sections
>       qapi: lift restriction on using '=3D' in doc blocks
>       docs/qapi-domain: add return-nodesc
>       qapi: Fix undocumented return values by generating something
>       qapi: remove trivial "Returns:" sections
>       qapi: rephrase return docs to avoid type name
>       qapi: add cross-references to acpi.json
>       qapi: add cross-references to authz.json
>       qapi: add cross-references to block layer
>       qapi: add cross-references to crypto.json
>       qapi: add cross-references to dump.json
>       qapi: add cross-references to job.json
>       qapi: add cross-references to Machine core
>       qapi: add cross-references to migration.json
>       qapi: add cross-references to net.json
>       qapi: add cross-references to pci.json
>       qapi: add cross-references to QOM
>       qapi: add cross-references to replay.json
>       qapi: add cross-references to run-state.json
>       qapi: add cross-references to sockets.json
>       qapi: add cross-references to ui.json
>       qapi: add cross-references to virtio.json
>       qapi: add cross-references to yank.json
>       qapi: add cross-references to misc modules
>
> Markus Armbruster (2):
>       qapi: Clean up "This command will do ..." command descriptions
>       qapi: Clean up a few Errors: sections
>
> Steve Sistare (3):
>       qom: qom-list-get
>       python: use qom-list-get
>       tests/qtest/qom-test: unit test for qom-list-get

The check-python-minreqs CI job is failing:

qemu/utils/qom.py:35:1: F401 'qemu.qmp.ExecuteError' imported but unused
qemu/utils/qom.py:241:34: E201 whitespace after '['
qemu/utils/qom.py:241:56: E202 whitespace before ']'
qemu/utils/qom.py:244:30: E711 comparison to None should be 'if cond is Non=
e:'
qemu/utils/qom.py:245:33: F541 f-string is missing placeholders
qemu/utils/qom.py:254:5: E303 too many blank lines (2)
Log file "stderr" content for test "01-tests/flake8.sh" (FAIL):
Log file "stdout" content for test "05-tests/mypy.sh" (FAIL):
qemu/utils/qom_common.py:96: error: Function is missing a type
annotation [no-untyped-def]
qemu/utils/qom_common.py:192: error: Function is missing a type
annotation for one or more arguments [no-untyped-def]
qemu/utils/qom.py:227: error: Bracketed expression "[...]" is not
valid as a type [valid-type]
qemu/utils/qom.py:227: note: Did you mean "List[...]"?
Found 3 errors in 2 files (checked 22 source files)
Log file "stderr" content for test "05-tests/mypy.sh" (FAIL):
Log file "stdout" content for test "33-tests/pylint.sh" (FAIL):
************* Module /builds/qemu-project/qemu/python/setup.cfg
setup.cfg:1:0: W0012: Unknown option value for '--disable', expected a
valid pylint message and got 'too-many-positional-arguments'
(unknown-option-value)
************* Module utils.qom
qemu/utils/qom.py:244:23: C0121: Comparison 'value =3D=3D None' should be
'value is None' (singleton-comparison)
qemu/utils/qom.py:245:32: W1309: Using an f-string that does not have
any interpolated variables (f-string-without-interpolation)
qemu/utils/qom.py:35:0: W0611: Unused ExecuteError imported from
qemu.qmp (unused-import)
************* Module utils.qom_common
qemu/utils/qom_common.py:92:0: R0903: Too few public methods (1/2)
(too-few-public-methods)

https://gitlab.com/qemu-project/qemu/-/jobs/10682353448

Please take a look and resend this pull request if fixes are necessary. Tha=
nks!

Stefan

>
>  docs/devel/qapi-code-gen.rst                 |  28 +-
>  docs/devel/qapi-domain.rst                   |  31 ++
>  docs/interop/firmware.json                   |   4 +-
>  docs/interop/qemu-ga-ref.rst                 |   1 -
>  docs/interop/qemu-qmp-ref.rst                |   1 -
>  docs/interop/qemu-storage-daemon-qmp-ref.rst |   1 -
>  docs/interop/vhost-user.json                 |   4 +-
>  docs/sphinx/qapi_domain.py                   |   8 +
>  docs/sphinx/qapidoc.py                       |  96 ++----
>  docs/sphinx/qapidoc_legacy.py                | 440 ---------------------=
------
>  qapi/acpi.json                               |   6 +-
>  qapi/audio.json                              |   6 +-
>  qapi/authz.json                              |   6 +-
>  qapi/block-core.json                         | 201 ++++++------
>  qapi/block-export.json                       |  41 +--
>  qapi/block.json                              |  23 +-
>  qapi/char.json                               |  12 +-
>  qapi/common.json                             |   4 +-
>  qapi/compat.json                             |   4 +-
>  qapi/control.json                            |  20 +-
>  qapi/crypto.json                             |   8 +-
>  qapi/cryptodev.json                          |   6 +-
>  qapi/cxl.json                                |   4 +-
>  qapi/dump.json                               |  19 +-
>  qapi/ebpf.json                               |   6 +-
>  qapi/error.json                              |   4 +-
>  qapi/introspect.json                         |  34 ++-
>  qapi/job.json                                |  62 ++--
>  qapi/machine-common.json                     |  24 +-
>  qapi/machine.json                            | 110 +++----
>  qapi/migration.json                          |  84 +++--
>  qapi/misc-arm.json                           |   4 +-
>  qapi/misc-i386.json                          |  32 +-
>  qapi/misc.json                               |  28 +-
>  qapi/net.json                                |  12 +-
>  qapi/pci.json                                |   8 +-
>  qapi/qapi-schema.json                        |   4 +-
>  qapi/qdev.json                               |  11 +-
>  qapi/qom.json                                |  89 ++++--
>  qapi/replay.json                             |  14 +-
>  qapi/rocker.json                             |   8 +-
>  qapi/run-state.json                          |  52 ++--
>  qapi/sockets.json                            |  10 +-
>  qapi/stats.json                              |  14 +-
>  qapi/tpm.json                                |   8 +-
>  qapi/trace.json                              |   6 +-
>  qapi/transaction.json                        |  16 +-
>  qapi/uefi.json                               |   4 +-
>  qapi/ui.json                                 |  58 ++--
>  qapi/vfio.json                               |   4 +-
>  qapi/virtio.json                             |  20 +-
>  qapi/yank.json                               |  22 +-
>  qom/qom-qmp-cmds.c                           |  53 ++++
>  tests/qtest/qom-test.c                       | 116 ++++++-
>  python/qemu/utils/qom.py                     |  43 +--
>  python/qemu/utils/qom_common.py              |  53 ++++
>  python/tests/qapi-isort.sh                   |   2 +-
>  scripts/qapi/parser.py                       |  48 ++-
>  scripts/qapi/schema.py                       |   3 +
>  storage-daemon/qapi/qapi-schema.json         |   8 +-
>  tests/qapi-schema/doc-bad-section.err        |   1 -
>  tests/qapi-schema/doc-bad-section.json       |  10 -
>  tests/qapi-schema/doc-bad-section.out        |   0
>  tests/qapi-schema/doc-good.json              |  10 +-
>  tests/qapi-schema/doc-good.out               |  10 +-
>  tests/qapi-schema/doc-good.txt               | 274 ++++++-----------
>  tests/qapi-schema/meson.build                |   1 -
>  67 files changed, 1053 insertions(+), 1301 deletions(-)
>  delete mode 100644 docs/sphinx/qapidoc_legacy.py
>  delete mode 100644 tests/qapi-schema/doc-bad-section.err
>  delete mode 100644 tests/qapi-schema/doc-bad-section.json
>  delete mode 100644 tests/qapi-schema/doc-bad-section.out
>
> --
> 2.49.0
>
>

