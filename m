Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006EDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 17:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg665-0007EP-By; Mon, 19 Aug 2024 13:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg663-0007Du-T6
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 13:23:12 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg661-0000F8-WA
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 13:23:11 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5bb85e90ad5so3313486a12.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724088187; x=1724692987; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8t2wODgRPHWtklHdIMaPj80QRwSAgFqLthXgkbDO+Kk=;
 b=bXS2X2wWWTUD6em8bWqqx+n5RdQzjSJsUSqP6VoLfWpzdot8G6w+y9/WVrF7hllown
 VSnuOu7uwtNcwwhOOYAOBXYqklkFGG83UAFfwjsnluhxs/8dbDCwy97r+Z7hQM8ekq6I
 CHwX7NrdWIemntISI8hX/NovlGshFBcRUpu+KVnQundTm/LKyfjNM6czoGN/JNXuSx35
 ImvwJB0uGa2UKVAuxNNzqt9XGFJ9fiqE40JHJuKZsUwvw3qApIiG7EWZ9hn9CZBLnveM
 BY4U0zvWL3p4WhYqCrv+SrwFjSl7+lgDFzSITPsJodK8oFhhi3fMe3mOB9kAfWuBKF/o
 x6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724088187; x=1724692987;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8t2wODgRPHWtklHdIMaPj80QRwSAgFqLthXgkbDO+Kk=;
 b=uGSDzboLWbH9A2S/H/IgJOob0o/hM8oBtbhIakLvcT/X8kj2H5BKYLeXU/O29+AKLS
 xO8DZ34fUyAdT4bedlizh9HB2zTFNwJD2z1sPVuSu3JuH5DGYRYr22PzI42/kZWQ3GZB
 E/Q2aO314RRnWP4WRax2GUXjSH6EYwkWnN31LhS+NhyKLgFGXzrmKxzBdEgKeoL6UFfv
 g4Hi7c6NPfsuktmFzCjQdEfYwrt/uJeO4URqEmuKM8sJnhzIPPjDDd3jSWtPVZY57QqP
 sv0GZctV3API159Px3dzSiizXmY5TP71WBgJzeakY39Pj9Sr1JxSVyUltGRc8cGbbcUS
 zyQQ==
X-Gm-Message-State: AOJu0Yyf21V0tUWm1zNP4t4iGyPqScTcoOoGOGzMS/fbGOTUrhSO5iq6
 F1HMkloynzIGdUek9t8mFuIW2WIF3Y0irNfpMNG+o/ICUFUoHgnTc4/VG+zSb+5vpmdO+bTK0uR
 gJ1txd792FTJ/anNkSXwwvwE1cVGQjpR8GeZteG3OaOeiWDTw
X-Google-Smtp-Source: AGHT+IGJ2fQRPwP0VM0gubssTtMvSE02Wn70RijV+h42dlSlZKDOIfGI0DnZ0vlVlQZ+wZ04QYZg4xljVCiyPydUQ48=
X-Received: by 2002:a05:6402:42c1:b0:5a7:464a:ac7 with SMTP id
 4fb4d7f45d1cf-5beca7ab156mr7949036a12.28.1724088187393; Mon, 19 Aug 2024
 10:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240819170700.61844-1-peter.maydell@linaro.org>
In-Reply-To: <20240819170700.61844-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2024 18:22:55 +0100
Message-ID: <CAFEAcA-_OzjHo06kHzat6ugh_Y5R8=oo808cChGEzucnfHRsLw@mail.gmail.com>
Subject: Re: [RFC PATCH] scripts/lsan-suppressions: Add a LeakSanitizer
 suppressions file
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 19 Aug 2024 at 18:07, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Add a LeakSanitizer suppressions file that documents and suppresses
> known false-positive leaks in either QEMU or its dependencies.
> To use it you'll need to set
>   LSAN_OPTIONS="suppressions=/path/to/scripts/lsan-suppressions.txt"
> when running a QEMU built with the leak-sanitizer.
>
> The first and currently only entry is for a deliberate leak in glib's
> g_set_user_dirs() that otherwise causes false positive leak reports
> in the qga-ssh-test because of its use of G_TEST_OPTION_ISOLATE_DIRS:
>
> Direct leak of 321 byte(s) in 5 object(s) allocated from:
>     #0 0x5555dd8abd1e in __interceptor_malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qga/qga-ssh-test+0x19cd1e) (BuildId: 7991a166007e8206c51bee401722a8335e7990bb)
>     #1 0x7fb5bc724738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
>     #2 0x7fb5bc739583 in g_strdup debian/build/deb/../../../glib/gstrfuncs.c:361:17
>     #3 0x7fb5bc757a29 in set_str_if_different debian/build/deb/../../../glib/gutils.c:1659:21
>     #4 0x7fb5bc757a29 in set_str_if_different debian/build/deb/../../../glib/gutils.c:1647:1
>     #5 0x7fb5bc757a29 in g_set_user_dirs debian/build/deb/../../../glib/gutils.c:1743:9
>     #6 0x7fb5bc743d78 in test_do_isolate_dirs debian/build/deb/../../../glib/gtestutils.c:1486:3
>     #7 0x7fb5bc743d78 in test_case_run debian/build/deb/../../../glib/gtestutils.c:2917:16
>     #8 0x7fb5bc743d78 in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3018:16
>     #9 0x7fb5bc74380a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
>     #10 0x7fb5bc74380a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
>     #11 0x7fb5bc743fe9 in g_test_run_suite debian/build/deb/../../../glib/gtestutils.c:3112:13
>     #12 0x7fb5bc744055 in g_test_run debian/build/deb/../../../glib/gtestutils.c:2231:7
>     #13 0x7fb5bc744055 in g_test_run debian/build/deb/../../../glib/gtestutils.c:2218:1
>     #14 0x5555dd9293b1 in main qga/commands-posix-ssh.c:439:12
>     #15 0x7fb5bc3dfd8f in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #16 0x7fb5bc3dfe3f in __libc_start_main csu/../csu/libc-start.c:392:3
>     #17 0x5555dd828ed4 in _start (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qga/qga-ssh-test+0x119ed4) (BuildId: 7991a166007e8206c51bee401722a8335e7990bb)
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
> sanitizer settings" (ASAN_OPTIONS="fast_unwind_on_malloc=0 is
> pretty much required to get useful backtraces, for instance), but
> I'm not sure there's a neat way to do that.

On the "no" end of the argument: it looks like from glib 2.79
or thereabouts there was support added to glib to make it
dynamically detect whether it's running in a binary that was
built with LSan and explicitly tell lsan to ignore these
deliberate leaks. That fix is less than a year old, though,
and at least my dev machine is still running 2.72.

https://github.com/GNOME/glib/commit/fb58d55187dfe1565d10c0c0ffdbaa85376cf0b8

-- PMM

