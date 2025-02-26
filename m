Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3F1C021BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 07:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnCKC-0007JZ-GN; Wed, 26 Feb 2025 02:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCKA-0007Gc-6Z
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:59:22 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCK8-0007fW-9H
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:59:21 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-abb7a6ee2deso989490666b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740556758; x=1741161558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TN+zJtVa97WCGM84JrOr0R92pWNVXsYwGjPIXCNOgOo=;
 b=m3MBVlLMxcffIcq/l/s46iJbKuRnTNIggT3eoybDmuLXC6zgNE4st39fYouWemf+P+
 bSgFEREYnxJIBmeqOibhgNTf9rzfz62UPsDD/rIrKag+VYRPP3A8OhM2PBLFkKenlKu8
 OfqKuIH52q0cGDUNno85GcyQ0XcHwBcgDSTL5ShbM6OwepIaV+kv/oOUEFZ0T2Bv4k9x
 xxyQFbCzPo3KPHDUOnjeNtSL2JR5VCEYBWTvkB9LV05lTdBZ7pB8xx6w5WF962CAuxva
 ucKdPjl4TPHN5XGrxvS9BQCOC+2LJSX75QVN6vGn9Ga3z8UHBRYzBhNhoGivbrh2I/Ui
 evcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740556758; x=1741161558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TN+zJtVa97WCGM84JrOr0R92pWNVXsYwGjPIXCNOgOo=;
 b=tPXkZ3NHnGhOh8VQ1W2KF0w3P1/LtHF5EFNElEpx4cQzwfII8ZmGnICj33ky6+FpEs
 gjrXiuFrh3DBVoMUei7Y41vxl0jxbIhbGAIF6khG2ujD1JHklXQHtRFQVn8/UXim9Pet
 W9Ax3PNjjxYrZ2Ry4SYIyBV2ngAcMBPZhTvW0arvIN8HGASGRkzvGtJDmdPwdFvU6Zwq
 uB/npLkcifwYK8v8UpPa+8flpwxDL0zIz+YAGWc4le/1U4TUFOpf/2A4AbLHBwiSyz5p
 FC8+vg04qazgYWRWLIV60pmHue2QW7dOlOU2BMnXLZEKTkmaKGPtTWZlvfnStplxppX+
 dPgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWfCNh5NkqvQqwiPiA0Q6IlxXqWE7C8IjINt/8Ra9RwQDSv66nQldm81LpicKxPgaLspfl4aswb6ig@nongnu.org
X-Gm-Message-State: AOJu0Yz3eGVlrCL5Qr2UgYtSq//qAKS5emCHFpUH6/Umjt7mr4YEtRDG
 t33yH5UC3yZG43ub1M/PyXgYkmL9SvrF37P8d4nE66P8dBaUko1A
X-Gm-Gg: ASbGncsl29gNMZBCtBDIFpC6fWdVNa83zg5zimfY+RCTeE5CBF+NEsm8DIDt4ADZjM5
 YPBBHNYHY/OkyI0TvAnQ8FGqw1juwQ/235q2NJ4NeUW4BuJMvSz/1YAupgjKhQZL7diCd50mAiT
 1bjQZtTYL7bEq3SjqM1ehZMV4i63FMg0DdKe3mbEyohIZc84axFq3UN0osT8Rt12wSHjXTvtkNL
 9MAXZaOWw23iWHJIh7N0h/fG8Ebnn4amPr/7DsOIJXwNZ5pgI6OYYj+KAZnEWnGo9cF3cKAsF7g
 z10GZkvl6sZHei6yivUjs5ajjh05lD+HJTY=
X-Google-Smtp-Source: AGHT+IFVa41NVXQ6cx8NEM9ugeGUXQAqA3eWUMyCGh80bBAyDBbdR9mZiEvldrzoSVVNdg+v4DVxOQ==
X-Received: by 2002:a17:907:6ea3:b0:ab3:9923:ef4e with SMTP id
 a640c23a62f3a-abeeed7132fmr201672666b.22.1740556757919; 
 Tue, 25 Feb 2025 23:59:17 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:c48e:2efa:cdfc:e268])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2013355sm280107866b.113.2025.02.25.23.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 23:59:17 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] ui/console-vc: various fixes and improvements
Date: Wed, 26 Feb 2025 08:59:06 +0100
Message-ID: <20250226075913.353676-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62c.google.com
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

This patch series brings several fixes and improvements to the QEMU
virtual console (VC), making it more usable and aligning it better
with VT100 spec. The updates include support for inserting and
deleting characters, better cursor handling and correct position
reporting. Without these changes, the console is hardly usable.

1. Support for DCH (delete) and ICH (insert) commands
  * Properly handles character deletion and insertion as per VT100
    specs.

2. Add support for cursor save/restore (ESC 7 and ESC 8)
  * Implements legacy DEC sequences for compatibility.
  * Ensures cursor attributes are also saved and restored.

3. Fix cursor position reporting
  * Reports cursor position relative to the screen instead of the
    scroll buffer.
  * Fixes issues with tools that rely on accurate cursor placement.

4. Ensure DSR (Device Status Report) responses go to applications
  * Stops terminal from rendering responses to the screen but instead
    send reports back to applications.

5. Handle `ESC ( <ch>` character set sequences
  * Makes `top` output look clean by handling the character set
    commands.

These changes improve the virtual console's compatibility with
terminal-based apps. Without them, the console is quite frustrating to
use.

v1 .. v2:

* The VT spec and ECMA-48 standard are somewhat vague about exactly
  what attributes should be set for the ICH (insert character),
  but various terminal implementations reset the character to the
  default state. Instead of inserting a "space" with the current
  attribute, call `vc_clear_xy()` for the inserted character.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

Roman Penyaev (5):
  ui/console-vc: introduce parsing of the 'ESC ( <ch>' sequence
  ui/console-vc: report to the application instead of screen rendering
  ui/console-vc: report cursor position in the screen not in the scroll
    buffer
  ui/console-vc: add support for cursor DECSC and DECRC commands
  ui/console-vc: implement DCH (delete) and ICH (insert) commands

 ui/console-vc.c | 154 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 142 insertions(+), 12 deletions(-)

-- 
2.43.0


