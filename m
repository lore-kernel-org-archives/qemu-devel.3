Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49261FF8864
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 07:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGuIG-0000cC-JT; Sun, 26 Apr 2026 03:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGuIB-0000bb-8k
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 03:52:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGuI9-0006My-J4
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 03:52:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891f625344so79844185e9.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777189955; x=1777794755; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k/XWABLefJ/zOywTqvBRGITa8xb5xBgFrteNQQ066Ds=;
 b=YHv88G4uyRIxS3hbMV0Lnyt4sABnKWC0qEaGDME5Nk6evMyzgfD2JEaImpUixw3VOA
 ClHdVsUOWrcJVavCfElUnkx1TGuV9iiQybVufLHmqSgQO3vOYTTLhZrtcthUJwrnlrF6
 NGzJukUm+HqC7mS9xCPete/8bcs/knYMOGAS4TaihRa6+rVCAO8jlfkj591hEYXA8lJd
 Qt1hNDQST81sHm1HfFaz2iaEP6RSZTnbZ8R0XjJW9SVAMT6utFSKUpaQT0FUzk+HahC4
 2qsfhKH0o3AenlRxyEAfYyJnJ91fIGrdKVMGo9guvUcnkarUEqSyx59NMjsYkahWuHSD
 UoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777189955; x=1777794755;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/XWABLefJ/zOywTqvBRGITa8xb5xBgFrteNQQ066Ds=;
 b=KKRjHFxQrIGn/ut5XOcsAdFIfizpUyMD3CtskKkkiuAEKSRz/F5ja1LpgHq4pZQnLQ
 hBWLQgIFlhPMX+LFAlDoLZmwBYisJe4PJ8CXEpifiIT5/lQzPyeQ88Z3VDaWe9Nh8c/b
 bfLgAg5Xdv8LA1/xCBe6gCadechK03PDuJdDzej7USUMglhoOlFXlxiTewiBkNXbZIK1
 UYwdJavnPy5uoJQHidkJiP6vLB9ld9JEszkQq75/j2M/A8e1kLMNVrnnLrnLK+w3A5Ff
 VfgaBXmKIOOC3n3iq6Ry6g7Bbmgc8qiDR0/OvagZV7AuqtiUoo2KbedH1wCOoDjEC4Yg
 8omQ==
X-Gm-Message-State: AOJu0YyNLPp8fO9NUzaR2cPKXXz8+11wJvTps5fqAtoXBB4ElXYZ3oKf
 eD88SfxGuzj6282XtGw+k6GH8NqMT0OrEJEDgMZt9AN5rxsUgxTkwlLtV9w6muxF
X-Gm-Gg: AeBDietgO1j2XIfvSnVhz2Te7nkR9Zufp29k2H3iv9bV5OgzwkjZhSp/rafbNVSNiX1
 czkPi8ikuZgpzRor9GPvG8dvilG6IJdgeEU+ZdSfyO8ac4xU8SEo55ZOsO6WUKzsO4tbNM3tnI0
 YvcQ5n6zcL+4KIe4t5rMv0IRanFkIISt1MRoIJJ8LyqJpLXtISWJXTp8ZZvzOXVpJl29upI8ri9
 ggNSmUO/MXNQ0tJ0ZC8OZMVJErsXv4B2rLcSPpoT7V7UdH1rdFYK7kLNnwGfcK28sxaPh/NRME6
 FGGG9YWmUWVriBulA8bfrR2x2XdmBJjMYz+1O3td/ZYIp8MOnC2AcKrS1iBFE55qd3QREssDtAy
 mz/M+vvzQymleNqg66Ceal0T18ganHXw3SezzloVSIoYBT74KaePfwDARxaluKeN0toTN8n4yzO
 sFlVg+gfIchaNuzr2ecTsEFvBOvnK0T/BAeNC1IZM=
X-Received: by 2002:a05:600c:4e0c:b0:489:1d7a:4537 with SMTP id
 5b1f17b1804b1-4891d7a463emr395572105e9.3.1777189955347; 
 Sun, 26 Apr 2026 00:52:35 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb74c68asm224080045e9.3.2026.04.26.00.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 00:52:34 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Subject: [PATCH v3 0/2] Fix and re-enable GTK clipboard
Date: Sun, 26 Apr 2026 09:52:32 +0200
Message-Id: <20260426-gtk-clipboard-v3-0-09555aaeda34@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEDE7WkC/32MsQ6DIBQAf8UwlwbQWnHqfzQd4AH6UhUDhrQx/
 nvRqUs73iV3K4k2oI2kLVYSbMKIfspQngoCvZo6S9FkJoKJmlXiQrvlSWHAWXsVDHXGSWk0LxU
 wkps5WIev43d/ZO4xLj68j33iu/11SpwyWmsjpb2yxvLq1o0KhzP4keynJP7WIteaycaV4GoJ8
 F1v2/YBZXYpB+gAAAA=
X-Change-ID: 20260425-gtk-clipboard-fdf99db13ac0
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=makovick@gmail.com; helo=mail-wm1-x329.google.com
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
 ui/gtk-clipboard.c | 52 +++++++++++++++++++++++++++++++++++++++-------------
 ui/gtk.c           |  2 --
 ui/meson.build     |  4 +---
 5 files changed, 40 insertions(+), 29 deletions(-)
---
base-commit: aa15257174da180c6a8a9d58f87319cfe61c5520
change-id: 20260425-gtk-clipboard-fdf99db13ac0

Best regards,
-- 
Jindrich Makovicka


