Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C79FC48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 16:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgoeu-0001ji-Pv; Sun, 03 Mar 2024 11:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgoeZ-0001gs-P6
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 11:25:35 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgoeX-0002Cb-V1
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 11:25:31 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-42e8e85a969so20350091cf.2
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 08:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709483129; x=1710087929;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ze5xWJ90/UecUwJAtMbtPH74W/O9yEMNAIeoMAPeh+I=;
 b=bViDKBhJBICAAKgxNeghOQ7zYauzgLbEM2ipe5zb4eaxcFPio6AI+igQZrvKsKiIVf
 XflRR3wR3DAXOB495K1SP+d3ZDInLG+o7EO7E9nQEl7sTR19AieCvi/ZYQO/Z511evTa
 CrNo+OYnNgIgE+a4XH97KqTl4oKJqfSdraJMoaTDOETTw0nismNLrHJnQAakol1QhooO
 TccpNdcsT9Nzd9aLQHbK5AW7WLOl2MkNT2eRgbB41Pg8Ue5m2OSeWWtrqUPDN1Qwcvqy
 I6+yZzhnP6a5eAzgSfovcEd2ZO/9stCWLauNTOee7cBD8457MZ2Pl84o12Flo6NUaEkA
 o2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709483129; x=1710087929;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ze5xWJ90/UecUwJAtMbtPH74W/O9yEMNAIeoMAPeh+I=;
 b=S+YZb8ewZrAjfdCQXwUQED6OLISqyIziUmaILMz+V7HvxIi+cZhBgzzU9HhjrlX0Cn
 8Jusb7NocU9NL1qBffG6NJFxhtCaRwJ/VmX1IhxBpqSGNQN0Os7e97J7HYaiFnSDVHac
 CdU7CdTleqVxvFQgXKefsXyoT4H7brUT18kxpMWINNZ8AMvYW/RmThUsOs+iNiZfragD
 f6TUIrlpTNbx4DrcdF+o5GNltTcC9EuHKU+ZtsRNRUyrjiUx1qTmbz2YN6AkEodwbyn8
 NlKesw6e3XxzJyLpYnBZsbfWC0yZylUlqiZbwPnnnQ6atcQgPL8qO5RvInNoY07idLYT
 hDuw==
X-Gm-Message-State: AOJu0YyHn1b6phk+/BbeqjWDNURf69m/jlHOasqAunWUOh9dbQMQRgS0
 o0z3Y5XKOswHrYfFxchrrurv/1p/4upII2a56gBzpC3zQHfLN8RIM6YazvHmKpw=
X-Google-Smtp-Source: AGHT+IEsoTc8i6jJccoaGT27fOBAULAf7reipUal3ogRKXKfjoWxa9oHdkt0gGkl2WtxNRhagpCh2Q==
X-Received: by 2002:ac8:5d15:0:b0:42e:880f:2f75 with SMTP id
 f21-20020ac85d15000000b0042e880f2f75mr8032072qtx.21.1709483129051; 
 Sun, 03 Mar 2024 08:25:29 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 w12-20020ac84d0c000000b0042eea4d6088sm755564qtv.39.2024.03.03.08.25.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Mar 2024 08:25:28 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 04 Mar 2024 01:25:20 +0900
Subject: [PATCH] meson: Remove --warn-common ldflag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-common-v1-1-1a2005d1f350@daynix.com>
X-B4-Tracking: v=1; b=H4sIAG+k5GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwMT3eT83Nz8PN1EU8OUFENT0zQLQxMloOKCotS0zAqwQdGxtbUAixA
 bBVgAAAA=
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::830;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--warn-common ldflag causes warnings for multiple definitions of
___asan_globals_registered when enabling AddressSanitizer with clang.
The warning is somewhat obsolete so just remove it.

The common block is used to allow duplicate definitions of uninitialized
global variables. In the past, GCC and clang used to place such
variables in a common block by default, which prevented programmers for
noticing accidental duplicate definitions. Commit 49237acdb725 ("Enable
ld flag --warn-common") added --warn-common ldflag so that ld warns in
such a case.

Today, both of GCC and clang don't use common blocks by default[1][2] so
any remaining use of common blocks should be intentional. Remove
--warn-common ldflag to suppress warnings for intentional use of
common blocks.

[1]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85678
[2]: https://reviews.llvm.org/D75056

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/meson.build b/meson.build
index c1dc83e4c007..4bbd921e9fbd 100644
--- a/meson.build
+++ b/meson.build
@@ -476,11 +476,6 @@ if host_os == 'windows'
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--dynamicbase', '-Wl,--high-entropy-va')
 endif
 
-# Exclude --warn-common with TSan to suppress warnings from the TSan libraries.
-if host_os != 'sunos' and not get_option('tsan')
-  qemu_ldflags += cc.get_supported_link_arguments('-Wl,--warn-common')
-endif
-
 if get_option('fuzzing')
   # Specify a filter to only instrument code that is directly related to
   # virtual-devices.

---
base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
change-id: 20240304-common-a51dd155f814

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


