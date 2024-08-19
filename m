Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF78BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgAmL-00025l-3R; Mon, 19 Aug 2024 18:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sgAmJ-00024W-Bd
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:23:07 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sgAmH-0005bS-9C
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:23:07 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7a975fb47eso561214166b.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724106183; x=1724710983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VI+nxXyCKVLEluhDmwkL3g/pWrHRcLRYBPqi6sU+5Gk=;
 b=fTH6zBhHf79Vq/hYSdYUJnkMJ8AOepxNBc6ivyExiniJdlm4h5xAFLjNXK28VGx3eY
 3iZUjWT1LQV/BQhXKaoRxkZNBLJ/kwKRLd9VG2f5HElWz5hJ0oi1Esuh1C0mOBDnpqr4
 DQPmEG4y2irA1ep8pYxMGEyeZZkJIHaRYs2AeyU+XwiSqwdFynTr9UtEnbvOsPZjJqF6
 oxe3P7Nc7FIMjWIND37B7GVYJC/RPfTHkR/6CN3gRw1WLotGGv4bPuGZRcZW+QCiFJqW
 dzSgywYmXk8lzAxD7KAgKm3c8zgEQ0eTvPd3vdmixiaZ7i4ZG9LKTdaKsP93CYiDgKKY
 QRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724106183; x=1724710983;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VI+nxXyCKVLEluhDmwkL3g/pWrHRcLRYBPqi6sU+5Gk=;
 b=rD2xMe0Dt153Gp35mEYCVP1v/0QifBAP8Rr747Sj6qTL5S3p3zv3nati2eXppzbkpK
 QEJOTXMlwBqGVZQviJGOvWKWpDlstHpccnnBYlzCq6JuE9sBvUo7w4KGa2Uuqc7JPAN+
 g7NxjCwHF8nGtkTwqUJQnio3xojWUIvL+z4f26AnSRd3C/Sibbw6PPJTi3+Mtf5HfTFv
 o0Mia+eKtIQoe4C4qSUecaVD42j2j/EEciKEnC7CRS9jNCCDWZ460Io72JRAcDpS0gCC
 Tk7zz5zMmsrm5dFDSZtynOWvMBHuo8Qk4C/shgOZY8Ma+g7ChPe3KvIFBB0+CYy4cIqF
 SURA==
X-Gm-Message-State: AOJu0YwhIT0ziWlFg2JM71uMqM52liy9aoA82vkKxfGi2Ztvs5/F2PW9
 usOo9VMzmJoOW2ffg/9pEm4KrOOsZkQmOgCLlRaY6vKig36o0Y/gUly4mbyn5PU=
X-Google-Smtp-Source: AGHT+IEbN5g+ry2GOWYchYa2yW34Yf1ll48aU565fJReGbq+oUKREXuaWwcr8arp8qcwO6VsgFp6cg==
X-Received: by 2002:a17:907:f79f:b0:a7a:b18a:66 with SMTP id
 a640c23a62f3a-a839292f125mr859178266b.16.1724106182499; 
 Mon, 19 Aug 2024 15:23:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383947123sm690192866b.178.2024.08.19.15.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 15:23:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 331FF5F88E;
 Mon, 19 Aug 2024 23:23:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] scripts/lsan-suppressions: Add a LeakSanitizer
 suppressions file
In-Reply-To: <20240819170700.61844-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 19 Aug 2024 18:07:00 +0100")
References: <20240819170700.61844-1-peter.maydell@linaro.org>
Date: Mon, 19 Aug 2024 23:23:01 +0100
Message-ID: <87sev0m9tm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> Add a LeakSanitizer suppressions file that documents and suppresses
> known false-positive leaks in either QEMU or its dependencies.
> To use it you'll need to set
>   LSAN_OPTIONS=3D"suppressions=3D/path/to/scripts/lsan-suppressions.txt"
> when running a QEMU built with the leak-sanitizer.
>
> The first and currently only entry is for a deliberate leak in glib's
> g_set_user_dirs() that otherwise causes false positive leak reports
> in the qga-ssh-test because of its use of G_TEST_OPTION_ISOLATE_DIRS:

Shame we can't share with scripts/oss-fuzz/lsan_supressions.tct:

# The tcmalloc on Fedora37 confuses things
leak:/lib64/libtcmalloc_minimal.so.4

# libxkbcommon also leaks in qemu-keymap
leak:/lib64/libxkbcommon.so.0

Or does fuzzing make some things easier to hit?

>
> Direct leak of 321 byte(s) in 5 object(s) allocated from:
>     #0 0x5555dd8abd1e in __interceptor_malloc (/mnt/nvmedisk/linaro/qemu-=
from-laptop/qemu/build/asan/qga/qga-ssh-test+0x19cd1e) (BuildId: 7991a16600=
7e8206c51bee401722a8335e7990bb)
>     #1 0x7fb5bc724738 in g_malloc debian/build/deb/../../../glib/gmem.c:1=
28:13
>     #2 0x7fb5bc739583 in g_strdup debian/build/deb/../../../glib/gstrfunc=
s.c:361:17
>     #3 0x7fb5bc757a29 in set_str_if_different debian/build/deb/../../../g=
lib/gutils.c:1659:21
>     #4 0x7fb5bc757a29 in set_str_if_different debian/build/deb/../../../g=
lib/gutils.c:1647:1
>     #5 0x7fb5bc757a29 in g_set_user_dirs debian/build/deb/../../../glib/g=
utils.c:1743:9
>     #6 0x7fb5bc743d78 in test_do_isolate_dirs debian/build/deb/../../../g=
lib/gtestutils.c:1486:3
>     #7 0x7fb5bc743d78 in test_case_run debian/build/deb/../../../glib/gte=
stutils.c:2917:16
>     #8 0x7fb5bc743d78 in g_test_run_suite_internal debian/build/deb/../..=
/../glib/gtestutils.c:3018:16
>     #9 0x7fb5bc74380a in g_test_run_suite_internal debian/build/deb/../..=
/../glib/gtestutils.c:3035:18
>     #10 0x7fb5bc74380a in g_test_run_suite_internal debian/build/deb/../.=
./../glib/gtestutils.c:3035:18
>     #11 0x7fb5bc743fe9 in g_test_run_suite debian/build/deb/../../../glib=
/gtestutils.c:3112:13
>     #12 0x7fb5bc744055 in g_test_run debian/build/deb/../../../glib/gtest=
utils.c:2231:7
>     #13 0x7fb5bc744055 in g_test_run debian/build/deb/../../../glib/gtest=
utils.c:2218:1
>     #14 0x5555dd9293b1 in main qga/commands-posix-ssh.c:439:12
>     #15 0x7fb5bc3dfd8f in __libc_start_call_main csu/../sysdeps/nptl/libc=
_start_call_main.h:58:16
>     #16 0x7fb5bc3dfe3f in __libc_start_main csu/../csu/libc-start.c:392:3
>     #17 0x5555dd828ed4 in _start (/mnt/nvmedisk/linaro/qemu-from-laptop/q=
emu/build/asan/qga/qga-ssh-test+0x119ed4) (BuildId: 7991a166007e8206c51bee4=
01722a8335e7990bb)
>
> (Strictly speaking, this is a genuine leak, it's just a deliberate
> one by glib; they document it in their valgrind-format suppression
> file upstream.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Does this seem like a good idea?  It gives us a place to document
> things like this and to suppress them so we could in theory get a
> complete clean 'make check' run with the leak sanitizer on.  It might
> be nice if there was an easy way to enable all our "recommended
> sanitizer settings" (ASAN_OPTIONS=3D"fast_unwind_on_malloc=3D0 is
> pretty much required to get useful backtraces, for instance), but
> I'm not sure there's a neat way to do that.
>
>  scripts/lsan-suppressions.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 scripts/lsan-suppressions.txt
>
> diff --git a/scripts/lsan-suppressions.txt b/scripts/lsan-suppressions.txt
> new file mode 100644
> index 00000000000..5c3cffaa5a0
> --- /dev/null
> +++ b/scripts/lsan-suppressions.txt
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2024 Linaro Limited
> +
> +# This is a set of suppressions for LeakSanitizer; you can use it
> +# by setting
> +#   LSAN_OPTIONS=3D"suppressions=3D/path/to/scripts/lsan-suppressions.tx=
t"
> +# when running a QEMU built with the leak-sanitizer.
> +
> +# g_set_user_dirs() deliberately leaks the previous cached g_get_user_*
> +# values. This is documented in upstream glib's valgrind-format
> +# suppression file:
> +# https://github.com/GNOME/glib/blob/main/tools/glib.supp
> +# This avoids false positive leak reports for the qga-ssh-test.
> +leak:g_set_user_dirs

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

