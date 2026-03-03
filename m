Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A680EB3641
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxERu-0000bb-74; Mon, 02 Mar 2026 20:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vxERn-0000ay-TS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:21:15 -0500
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vxERm-0000bq-9N
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:21:15 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 4858bf436de4266e41ad2c63a793c532f320b885a159d9bda3ce41d08056f6e0 with SMTP id
 69a63787a460b99e998d8677; Tue, 03 Mar 2026 01:21:11 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1772500870;
 bh=SMJ2+uZ9t8KOONtPyquvJBHu8/97x1OkjUugrAbHHsU=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=fJxq+BKHCgAIMBHr9G31PSk7R+ghkyyoExSw7sqsYY/DatDoLvNd8BtbJJ7LrpAqh
 ugqWtBNDESxZ+bDBTEhl7L8qSWYp0XoKB3/NndZV6brlCaQSjnzsGhgGG2JSuA8FLT
 0f/WkcY3QjzSRzcARqUgHsaMJmjUov7KoTRo3tS9FEjcSOxshG0k97OxnjbqTDPRk6
 RmcYN+/D4ptTrx0cKQqhBnhvpfkWLtbuUPgLQJ8Qru16mFJZWF9jHIazfu2LfQPoXc
 6jlDFcL2RBR1bM5b1rkCqss3cF/4+rYZ8fRWf+MID7h15Mh7AWASvytW25ydglvj/S
 iq4aDe5zlpB8w==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: "Yodel Eldar" <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Yodel Eldar <yodel.eldar@yodel.dev>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH v2] configure: Use clang for sanitizer builds or disable
 Werror
Date: Mon,  2 Mar 2026 19:20:54 -0600
Message-ID: <20260303012054.484837-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

Builds with --enable-{asan,tsan,safe-stack} fail under GCC, so use
clang if available, otherwise disable the treatment of warnings as
errors.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
Hi,

The previous version only disabled Werror whenever `--skip-meson` wasn't
used and the build occurred in a git repo, but this change should
probably apply to all types of builds. So, let's use meson_option_add
to globally disable Werror instead; IIUC (and according to my testing),
this will override the value in config-meson.cross.new.

I'm still not sure if we should be disabling Werror for ubsan, even
though it's not currently breaking builds with GCC; please let me know
what you think.

Special thanks to Peter for looking into the cause of the reports around
this, for sharing the findings, and suggesting approaches to resolve it.
I couldn't pick one over the other, so I went with using clang when
available with Werror disable as a fallback; please let me know if you
think this is an XOR kind of policy decision.

Link to RFCv1:
https://lore.kernel.org/qemu-devel/20260302210039.261325-1-yodel.eldar@yodel.dev/

Link to mentioned discussion:
https://lore.kernel.org/qemu-devel/CAFEAcA88hc4UsgpuPXBWpbeN0tW26159kPn7jx2J9erBA5DLBw@mail.gmail.com/

v2:
- Fix misnomer in commit message
- Simplify condition by using the same variable for all sanitizers
- Use meson_option_add to disable Werror

Thanks,
Yodel
---
 configure | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/configure b/configure
index 5e114acea2..e457e8a17d 100755
--- a/configure
+++ b/configure
@@ -762,6 +762,12 @@ for opt do
   ;;
   --wasm64-32bit-address-limit)
   ;;
+  --enable-asan) use_sanitizer="yes"
+  ;;
+  --enable-tsan) use_sanitizer="yes"
+  ;;
+  --enable-safe-stack) use_sanitizer="yes"
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -771,6 +777,18 @@ for opt do
   esac
 done
 
+if test "$use_sanitizer" = "yes"; then
+    if has clang; then
+        echo "Sanitizer requested: setting compiler suite to clang"
+        cc=clang
+        cxx=clang++
+        host_cc=clang
+    else
+        echo "Sanitizer requested: disabling Werror for non-clang compilers"
+        meson_option_add -Dwerror=false
+    fi
+fi
+
 if ! test -e "$source_path/.git"
 then
     git_submodules_action="validate"
-- 
2.53.0


