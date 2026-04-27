Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C9BFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRnn-0007UC-UD; Mon, 27 Apr 2026 15:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHRna-0007T9-0D
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:39:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHRnY-0006s2-B0
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:39:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48374014a77so138188515e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777318754; x=1777923554; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ehYuxSK3XJt2mwUWPI4Wu2zWpX5Z88Nk/i6gWmV53tQ=;
 b=FO/+pK+vhNr9BQNnEsyZghFiO5oPjGvzC/NBX0bpooEyNAM1f+Exkdm2XBgx6PQQIa
 vHwK1G+jTCw5Z39T8/LAqmz+6RHmQOC5IfD7bo9oQz7zNZEG+5uDuh4BmOe6RCLD/VA7
 XqoJcSbIdMpc5J+C5YDxzYXn42adN9fEVEaRIm9mOtoaaIzZSfZkzj8YtQNC9V3pmCO1
 Aoi4fXA4TtwgUBlJGkUT7FBX3SFUO9tuNWvhpdFCcQvLXrfyyCjhjz5wrDvKngdt2Fo+
 /UgIUf7SWBXhKjqbpHnIHV90lBXnkEE3WbvGWcmANrFLMXZ2UAm9jr4GtOI8RUyvfR9O
 Bsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777318754; x=1777923554;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehYuxSK3XJt2mwUWPI4Wu2zWpX5Z88Nk/i6gWmV53tQ=;
 b=js4RmJ3bui5wT2+DAHdhO+DsGgv8Su9e1As+P8RNXBGRC81PP9mySI2xYG8znyiS0b
 Y4u9FF763sjVXpjTq0aWOarLnAxr0ClmGsmflkSQtT5wW3ldxt82brVwp70UG+0HF6Xn
 qCArS5BNasKpb1jWHgqc92iriRPNUDoqNUuxBKzLfJFY8RWRH5P93yjmt8iO7FB84QzW
 MiMo/EQ8LJOEWpxra+ELnccM0pn/whC7hUd9j6nNEOq/0qA52//CadddyS+0b3K9pOYD
 hDf2W0pvmAaLlYW6FO8GBOwwaYP2uebEEuXbmOLxY1tcPHTMzNtXleWGnXSfnjbsT+ez
 IjAA==
X-Gm-Message-State: AOJu0YwpofuTOXJbrHHvDvjRkb7rL8mbfKRgmq8J8/w2I/OXBJ5W7ogD
 xJioz0j9fePp62Pargv+2LD2UkLSbdpp+DjE54YDk20yNm9ASNkxgHrB
X-Gm-Gg: AeBDies/3/jdYYnafO4dDQOILuNydua14JWG+U8thINmBL4VuvZGljvY1umGyi9ma1O
 j4QCtieJRmLWqgfRZhF9VRk2fQVkUp3JDI+TAgY3pvf0j0ZUp735lMY/KqcW8DyRpkdp0QB4Ecr
 /KsZh+7NeUUcDyO6NsxG3G1GCjIFHbfaQGFiILw91Uf779gHI8xi592g5zZ8gFktir18/hrJV2b
 pG40Tp0664tclUvPUtpIlqDI0h+hI2M2cPkTgGIZg2jAdVjJPfmSwfY8n37MrzAJ30uugtuOHqG
 0h56qQAtwVlikNTFhJwtT0+P2HNAqA3o76SyEcEb3ie9/1S33HIcvasi/WSm6/sfv8WA3LycBTp
 eRWH0sFqpweAYjgkdqH6DAPfIrYquAEsm2INoKw/yWXQSaH4v6rJbE3qAxBMrcJhEj6dxZ+VTnw
 nYPqbNFyYk+z7xJHeWqVXPLsvga+jh2axxCFlMCqY=
X-Received: by 2002:a05:600c:3b8a:b0:48a:56de:d640 with SMTP id
 5b1f17b1804b1-48a77b0a367mr1074745e9.16.1777318753965; 
 Mon, 27 Apr 2026 12:39:13 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773e70c2sm8281035e9.10.2026.04.27.12.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:39:13 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Subject: [PATCH v4 0/2] Fix and re-enable GTK clipboard
Date: Mon, 27 Apr 2026 21:39:09 +0200
Message-Id: <20260427-gtk-clipboard-v4-0-176ad9919931@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF2772kC/33NSw6CMBSF4a2Yjq3pg1bqyH0YB31CI1DSkkZD2
 LuFkZLo8Nzk++8Mko3eJnA5zCDa7JMPQxnV8QB0K4fGQm/KBgQRjirCYDM9oO78qIKMBjrjhDA
 KU6kRKGaM1vnn1rvdy259mkJ8bfmM1+uvUsYQQa6MEPaMaoura9NL35106MFayuSvJkUrJGpHt
 eNC672mn5rvNS0aCcaYlNZI+vV7WZY3FFknfiYBAAA=
X-Change-ID: 20260425-gtk-clipboard-fdf99db13ac0
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=makovick@gmail.com; helo=mail-wm1-x32e.google.com
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

The following patches change blocking clipboard retrieval function
calls in gtk-clipboard.c to non-blocking variants using callbacks to
avoid UI lockup. It is a follow-up to the patch proposed in the GitLab
issue

https://gitlab.com/qemu-project/qemu/-/work_items/1150

This version adds a similar change to gd_clipboard_request that also
uses the blocking clipboard API.

The second patch removes the gtk-clipboard flag, keeping the GTK
clipboard always enabled.

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
Changes in v4:
- Replace gtk_clipboard_request_contents with
  gtk_clipboard_request_targets which can utilize GTK's target cache
- Link to v3: https://lore.kernel.org/qemu-devel/20260426-gtk-clipboard-v3-0-09555aaeda34@gmail.com

Changes in v3:
- Use gtk_clipboard_request_contents to avoid text conversion
  when we only need to check if the text is available.
- Link to v2: https://lore.kernel.org/qemu-devel/20260425-gtk-clipboard-v2-0-b098f3cf69cc@gmail.com

Changes in v2:
- Removed forgotten gtk-clipboard comment in meson_options.txt
- Link to v1: https://lore.kernel.org/qemu-devel/20260425-gtk-clipboard-v1-0-6bd99e708e14@gmail.com

---
Jindřich Makovička (2):
      ui/gtk: Use non-blocking clipboard retrieval
      ui/gtk: Keep GTK clipboard enabled

 meson.build        |  4 ----
 meson_options.txt  |  7 -------
 ui/gtk-clipboard.c | 53 ++++++++++++++++++++++++++++++++++++++++-------------
 ui/gtk.c           |  2 --
 ui/meson.build     |  4 +---
 5 files changed, 41 insertions(+), 29 deletions(-)
---
base-commit: aa15257174da180c6a8a9d58f87319cfe61c5520
change-id: 20260425-gtk-clipboard-fdf99db13ac0

Best regards,
-- 
Jindrich Makovicka


