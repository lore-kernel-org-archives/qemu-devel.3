Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0217BC83F2D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 14:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjgOn-0006C3-Fc; Thu, 29 Aug 2024 10:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1sjgOl-00066F-VJ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 10:45:20 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1sjgOk-0002st-6S
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 10:45:19 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a86cc0d10aaso88133766b.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 07:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724942714; x=1725547514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XwDmN/K7nV94plS0806AzBe+Yb9a5WidSgtTa+uDpgE=;
 b=h4r5fT4bkPT/bpDkj2pP/Niu0Jy2qkLJ3xrKbgsZMCWYu8qFxLX8lpHG5FmbLLxnAc
 K02UqeW0pEVj6s3hxm2+JmPREmkjqWF1Gjn6Sofwm3oS/nYtt+uE44zRhuUtkehyQl8x
 E0HJ9u4q99Zi+PJPAc9lxmEg0nxbOzL/RX2Tcv8tKUDljOgjgPjZ6/e5rHUvqnq5UqbC
 0HRAVe7WhNI2V+jVHTELcp63jk7QMaFnsDq5NKqTEkIg0ZVeep2niAwYo3sriN+2JwU6
 EiQW5AP0lrraHLv5T0yu2IoSIrbMByK0WmrA3Bo/Doj42o9UHAAbxezNCwEzaQZSLov3
 yjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724942714; x=1725547514;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XwDmN/K7nV94plS0806AzBe+Yb9a5WidSgtTa+uDpgE=;
 b=kKMgeCpogpByCQ463+BznaY7v1rKZnteulNCwVNxYn1dUsnEoh4chTvuSudwGjRzBy
 mvwtA5rpgVa+7w+ttx0Qu69mkFLDpYivM1DbL1js35QXihnQ1uAnjQKJbNi8MmUmrMb1
 UuxJ9mhiywojrNKTuq2F3btIfMir2OZJoMBYGK4k+RppRKAOGo7b/vu/J2KX7A2scdB5
 jehRAvkQcwn1UGDl//JTSXFMjzxmNJMyBoOxuGClg6k6+2H1PHGZRBPyi5/H6alREGlZ
 qIYiS/qIo41LxsKHQnoty8ifqqC+dh+NE4VHt8mKQCLe/Ag0KWnz6onTcY2JE3IiKMfy
 noiQ==
X-Gm-Message-State: AOJu0Yy1w3xarCIZW2Y36YUtdU4dP4lhTiFGKdrz5aYoTHQrNaIHCQi9
 Z7NTSqr0aoNgl5Mp44YCz4IohATfZhRBSo8pUaeQKNJfjYtxaX/Pb0dHFZ7F
X-Google-Smtp-Source: AGHT+IHO6XXkzFmElICUh5hWb1nAmWOqrbj1oA5iRwG6SZAPOJ46BElHus8IgKPN8qR6mNmnp4GosQ==
X-Received: by 2002:a17:906:6a28:b0:a80:f6f2:e070 with SMTP id
 a640c23a62f3a-a897f789241mr245259066b.3.1724942713645; 
 Thu, 29 Aug 2024 07:45:13 -0700 (PDT)
Received: from top.fritz.box (p4fd6b0d7.dip0.t-ipconnect.de. [79.214.176.215])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8989035f80sm87313166b.78.2024.08.29.07.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:45:13 -0700 (PDT)
From: Michael Vogt <michael.vogt@gmail.com>
X-Google-Original-From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v2 0/1] linux-user: add openat2 support in linux-user
Date: Thu, 29 Aug 2024 16:44:13 +0200
Message-ID: <20240829144413.6942-2-mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=michael.vogt@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

This is v2 of the openat2 support in linux-user. Thanks for the
excellent feedback from Richard Henderson. I reworked/updated the
patch and (hopefully) addressed all comments/suggestions. Extracting
the helper made it much clearer indeed.

The patch still requires openat2.h from the host, But I added a
qemu_log_mask(LOG_UNIMP) when the passed "size" is bigger than our
defined target_open_how size. This should allow us to catch structure
changes (as we then also need to update our code that build the
open_how from target_open_how). But maybe I'm missing something (if so
my apologies!), I'm also happy always define "struct open_how" locally
if you prefer that.

Any feedback welcome!

v1 -> v2:
- do not include <sys/syscall.h>
- drop do_guest_openat2 from qemu.h and make static
- drop "safe" from do_guest_openat2
- ensure maybe_do_fake_open() is correct about when the result should
  be used or not
- Extract do_openat2() helper from do_syscall1()
- Call user_unlock* if a lock call fails
- Fix silly incorrect use of "target_open_how" when "open_how" is required
- Fix coding style comments
- Fix validation of arg4 in openat2
- Fix missing zero initialization of open_how
- Define target_open_how with abi_* types
- Warn about unimplemented size if "size" of openat2 is bigger than
  target_open_how

Thanks for Richard Henderson and Florian Schueller for their
feedback.

Michael Vogt (1):
  linux-user: add openat2 support in linux-user

 linux-user/syscall.c      | 98 +++++++++++++++++++++++++++++++++++++--
 linux-user/syscall_defs.h |  7 +++
 meson.build               |  1 +
 3 files changed, 102 insertions(+), 4 deletions(-)

-- 
2.45.2


