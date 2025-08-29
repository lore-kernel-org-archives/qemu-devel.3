Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F43DCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN7p-0000Kq-CA; Sat, 30 Aug 2025 11:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtnT-0001ny-PX
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:45:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtnQ-0005Cg-NM
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:45:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b7e69570bso4403145e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756453513; x=1757058313; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LAj9Iz2NA3K7h9ZrEZS5jY9f71C/30q8F4KTv008cPs=;
 b=N6Ai2RaLV+wyQk6KEAn5hK4UD0MNr4S0YM78WJMf5OrqBwlaqn5XTiMKNJdViMMBBL
 GVooISd18UK2drMxiguu57E90cNBxE5QLQBAc+W/s8ERnHBT6vzv3sjbnUbwSRz/MKNv
 fvjCnG/VYUpZbMPArCzvMHpboZ+EBryc1K0jr3I3MpUIkqvpPWi/JlAG/gl+nGfBJr9A
 XmLtY1DPxOo3GCXCb4kCd77iO+AwKjyaadoNM1eMUHQO7Tqd19w72kM2yvY6UDbQrNBK
 PIhi1Wehbq0/hi1mfGvGu4q2ru1xeNmj3CaPvcf174daHouTr3mnpAs+cWZ5QSNg/rGl
 URwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756453514; x=1757058314;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAj9Iz2NA3K7h9ZrEZS5jY9f71C/30q8F4KTv008cPs=;
 b=wAqP4tuzH2M/B5h9Um/5WHUBpntHPRwvgk3bCpd2Ay97FTVUlT2ZvQVkYjLjZJDEW+
 EmtPelmswcPrZYqpBYTBNlCLKUwVlubjoCoxEXWli09vQ3TBdhlmQiLmB8/Hvpn0nZWz
 IE2qJjYS2+bFtAsMIebDXX4jQWkObYAuFc5PvnH+xcG3YFcQR1IZQMVNfL4KKaBmu0EP
 tw5RvFdRf/ExgdYMU37XPFFOy/nIoq8Qe21u5YE9NdqrQ3WYC75gAFkYmX9mhwi6t/zx
 DzOJ7t7TmBbH3XRaq9+XiB44N0yL0ckdhitBQaLrCp1r6hK5oZQzBt4ehppGrnBak4LU
 Lb1w==
X-Gm-Message-State: AOJu0Yw0OPkV/ajZxsEnB7roFVZBj8I1iF6vxBEcuITPplw0g9AGhjPw
 PdhxreInFC3Q7cGCwAH/BKiQzgKhgJKjJhWs5G+9idunqU0+/PnyKt9YnQMMfhGjyezUMh0Lky4
 NeIy+ME8=
X-Gm-Gg: ASbGncst0LNwh9Gfe/Q+amH5WCArLTALlwOf/4jYwuXUgRTopCUTFGHGKq+wqhNJdOg
 VgdJNx29cJTXDjva3pvvRapKj1kYC8XMegF1eEml8UW+NwlUzwlcknnag2bx1ML4fNP7i6+1+3g
 fYjGfqnFPszlKBCgp3UQp3TXos461LuFZYWHMO4FO2De6L4f8N5/VYbUhZt+CKxp5rfZ2hdt/Xj
 xS/tTXpgy0P/zU/vRzrd/4CqKieD+AU+u5jaYvQ8PyB466jlUmNE7scbGpvJCWvkYvkY5/Q7pFn
 WU6B7Z9zYLkWThGIZCMv58LD5XcJzszuog5Hekumm7Vm2Yuq1u/v9BABhpGcAM0Fwqq8k3s9/jN
 29AQYquNksPDXB1WGNM+Smr2n7VNWVbqoNxJ9YlpV2HFV0M+ISeuOVfYP7ieVcqDausQ+MSVo
X-Google-Smtp-Source: AGHT+IFnHouCyTKVxYsgeydDcjUvfdTbX7ziFQida3Lpj/H2xCKMDGOrHC69b2+4bZ4qhTLs+OhqyA==
X-Received: by 2002:a05:600c:4451:b0:45b:43cc:e558 with SMTP id
 5b1f17b1804b1-45b517cba3bmr219703705e9.35.1756453513513; 
 Fri, 29 Aug 2025 00:45:13 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7d23b7sm26550515e9.1.2025.08.29.00.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 00:45:13 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:44:31 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] linux-user: Drop deprecated -p option
User-Agent: meli/0.8.12
References: <20250828162012.3307647-1-peter.maydell@linaro.org>
In-Reply-To: <20250828162012.3307647-1-peter.maydell@linaro.org>
Message-ID: <t1qw7c.221yk652cxq5o@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 28 Aug 2025 19:20, Peter Maydell <peter.maydell@linaro.org> wrote:
>The user-mode '-p' option has been deprecated since 9.0 and
>doesn't do anything except emit a warning. We are well past
>our minimum deprecation period, so drop the option.
>
>Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>---
> docs/about/deprecated.rst       | 10 ----------
> docs/about/removed-features.rst |  8 ++++++++
> bsd-user/main.c                 |  8 --------
> linux-user/main.c               | 12 ------------
> 4 files changed, 8 insertions(+), 30 deletions(-)

What about docs/user/main.rst?

>
>diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>index 58bce715f9c..dfb7882e3da 100644
>--- a/docs/about/deprecated.rst
>+++ b/docs/about/deprecated.rst
>@@ -68,16 +68,6 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
> marked deprecated since 9.0, users have to ensure that all the topology members
> described with -smp are supported by the target machine.
> 
>-User-mode emulator command line arguments
>------------------------------------------
>-
>-``-p`` (since 9.0)
>-''''''''''''''''''
>-
>-The ``-p`` option pretends to control the host page size.  However,
>-it is not possible to change the host page size, and using the
>-option only causes failures.
>-
> QEMU Machine Protocol (QMP) commands
> ------------------------------------
> 
>diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
>index b1b3d1b1b3f..06f186991ac 100644
>--- a/docs/about/removed-features.rst
>+++ b/docs/about/removed-features.rst
>@@ -583,6 +583,14 @@ The ``-singlestep`` option has been given a name that better reflects
> what it actually does. For both linux-user and bsd-user, use the
> ``-one-insn-per-tb`` option instead.
> 
>+``-p`` (removed in 10.2)
>+''''''''''''''''''''''''
>+
>+The ``-p`` option pretends to control the host page size.  However,
>+it is not possible to change the host page size; we stopped trying
>+to do anything with the option except print a warning from 9.0,
>+and now the option is removed entirely.
>+
> 
> QEMU Machine Protocol (QMP) commands
> ------------------------------------
>diff --git a/bsd-user/main.c b/bsd-user/main.c
>index 7e5d4bbce09..9ba69642f50 100644
>--- a/bsd-user/main.c
>+++ b/bsd-user/main.c
>@@ -367,14 +367,6 @@ int main(int argc, char **argv)
>             }
>         } else if (!strcmp(r, "L")) {
>             interp_prefix = argv[optind++];
>-        } else if (!strcmp(r, "p")) {
>-            unsigned size, want = qemu_real_host_page_size();
>-
>-            r = argv[optind++];
>-            if (qemu_strtoui(r, NULL, 10, &size) || size != want) {
>-                warn_report("Deprecated page size option cannot "
>-                            "change host page size (%u)", want);
>-            }
>         } else if (!strcmp(r, "g")) {
>             gdbstub = g_strdup(argv[optind++]);
>         } else if (!strcmp(r, "r")) {
>diff --git a/linux-user/main.c b/linux-user/main.c
>index 6edeeecef38..7b0ccb6fd60 100644
>--- a/linux-user/main.c
>+++ b/linux-user/main.c
>@@ -340,16 +340,6 @@ static void handle_arg_ld_prefix(const char *arg)
>     interp_prefix = strdup(arg);
> }
> 
>-static void handle_arg_pagesize(const char *arg)
>-{
>-    unsigned size, want = qemu_real_host_page_size();
>-
>-    if (qemu_strtoui(arg, NULL, 10, &size) || size != want) {
>-        warn_report("Deprecated page size option cannot "
>-                    "change host page size (%u)", want);
>-    }
>-}
>-
> static void handle_arg_seed(const char *arg)
> {
>     seed_optarg = arg;
>@@ -522,8 +512,6 @@ static const struct qemu_argument arg_table[] = {
>      "range[,...]","filter logging based on address range"},
>     {"D",          "QEMU_LOG_FILENAME", true, handle_arg_log_filename,
>      "logfile",     "write logs to 'logfile' (default stderr)"},
>-    {"p",          "QEMU_PAGESIZE",    true,  handle_arg_pagesize,
>-     "pagesize",   "deprecated change to host page size"},
>     {"one-insn-per-tb",
>                    "QEMU_ONE_INSN_PER_TB",  false, handle_arg_one_insn_per_tb,
>      "",           "run with one guest instruction per emulated TB"},
>-- 
>2.43.0
>
>

