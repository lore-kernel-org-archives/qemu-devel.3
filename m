Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8902ACA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 23:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPLL-0000ft-Om; Mon, 12 Oct 2026 19:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGPL9-0000f7-DH
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:21:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGPL7-0001oM-Q0
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:21:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4956869750eso18021495e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 16:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791847311; x=1792452111; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nlzCXTolSl023Xv5C60BTuYPqXaHQASvRafXs6WHTX0=;
 b=BJWgHR3PNfhonX/NK9cWMymB0UgTA+CicP0KBJ6w4I3FQjrVT1Mcj4GU+0pAkIymQL
 oZtWYLTiQi2Zobshxo4/qERRvyODHGujLdaR9ADup1LaAyuzaK9sQxW6Tl5+3v3nqK+F
 S90rn4lWxfiId7VWNVZPD3nIlS+G6dvkeejNGlR8ZDcvbGfSr6eXjLiNTUQcKPQxs2yN
 QdwgAFO3y0dBNxeMc3uj3KpUdnGkxr/dSpl/zYJIrtam/XTN0gurIkq5p75LTyBYKcS/
 jZe9q/u+/SQ7UbB0OuEYPGL6HyJkD8T45szW8/4KMcgdbXiS086+9l1xRPXpA2bjRRWi
 MlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791847311; x=1792452111;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nlzCXTolSl023Xv5C60BTuYPqXaHQASvRafXs6WHTX0=;
 b=ewHBLQD+L6q+/JeCr7pm0FwZ25VzygYs/VzKQ4xDelTJ7C2qIrbgvuN3dUNlqqVHKa
 BfnGoP84ScUePV45B6yv8rYiMBN/3qbYr+ndXggxfDyORAnKB5r/ghqOFb+nzNxCc3uo
 UPW9R8rB+wLUxsvN+hHbWgu0Wm275uPMGlCLgwy0BJG+Je9q9rKtmUYEBV/vAz1M0pWJ
 mCcpiAibGQqKc+w+d5aO9ewT8pXIZd1ICzvmXi+/9X6OkaCN6hu78vX/Dq5TW+0JoLcT
 dyzf7CIUuYFfTiBbD2JC9e9eA/K8JKXPDGULCTIMJi2AKZU+lAOjKGOCHe6XnU5SO9LJ
 wkaw==
X-Gm-Message-State: AFq9FYKNrhaW8CSiyF4HTJTZiVbItPd0N3+jHL+kXjX6QU/5XZuvcu9h
 27Beea1yUZUzUSEbiLxg47MOsxy+qrfMfrUqcPQ73srniT6qUKggnYguY21fmLZW
X-Gm-Gg: AYBFou3YIeHzhHVPtdGeZK1N4Y0vdly48t/Y8TmmM/0UDnVys4D8uNJao2SSrtWpl3I
 Q4g3+5Ud+ncK5cdjW0w+uob1rLfP8ajefST2eQABcOXMnPJkMToVT1kvHv/e5xaAGyVoaL1CyV3
 281gb+XeRgyiQ0zRw96Mq+ZnbVIp1Y4T3mop9v664BMiG2victFXCREILXj79FBa7+1cJWAjtkt
 vIwXwPVuR6QDR2LkQXvNIaWdO6MpTKjNFFod4QA5rTsILGv+yOIQkGYqsCh2u+o8vV+N1tSB1hs
 yxvjAB1r5oo2RZ/FbyBcR2v7bbo4XUjGq5d0shWBd5hWFsWQpa1G1X1ckyBuogy5pNuyrQma0UL
 J5OqkUyn8RHtWMdugUj0XBlLowjElhACVZ7rGt6G3RO80mf6NaMlSl/eY5V9UBe+XUWWwXKbe0o
 iHj4HtdT7LZs31dytmP8rm+aA7LihJhVeibe6a3f1mQst1SVyum65EF4YmK1e7KRdMQam06Fg8n
 dCGiYAx5vEy7TBZh9nhSxYDgAUqigj2PuDI0Q==
X-Received: by 2002:a05:600c:6207:b0:49f:ff73:9971 with SMTP id
 5b1f17b1804b1-4a18e4aff66mr201465545e9.18.1791847310952; 
 Mon, 12 Oct 2026 16:21:50 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1972eaed8sm207990055e9.1.2026.10.12.16.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 16:21:50 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Subject: [PATCH 0/2] io: make sure we don't close stdio fds
Date: Tue, 13 Oct 2026 01:21:36 +0200
Message-Id: <20261013-fix-stdio-close-v1-0-4ecfa416c7bc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Mj3bTMCt3ikpTMfN3knPziVF1LCwszEwNT0xQTc2MloK6ColSgErC
 J0bEQfnFpUlZqcgnIGKXaWgAhWyg4cwAAAA==
X-Change-ID: 20261012-fix-stdio-close-98864055d473
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791847309; l=1236;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=GoN8BNOHyN1xUjSPCbh2MA6I4XE8Dx/OeO8NJmz3SOo=;
 b=htt6lQMmQEa8QVXo+vbFsw1HuQvQWiC0A+HmOb/P+v868+PsLlCvcVQ2i8Lu6SkfT21NkopYW
 ydV/ZGpEx16A/HdeqdK5sWJENF42Y/wcdzN451uwm+is9xGDm9sHz4B
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x331.google.com
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

The stdio chardev currently closes the stdin and stdout fds when it is
destroyed. This means that, assuming char0 is a stdio chardev, invoking
the HMP command

    chardev-change char0 null

will cause QEMU to run with descriptors 0 and 1 closed. That's not a
great situation, as:
  - the stdio chardev cannot be recreated
  - code assuming fds 0 and 1 are open will misbehave
  - the fds 0 and 1 will get assigned to newly opened files, possibly
    causing them to be confused for actual stdin/stdout

The fist patch fixes the problem by duplicating the fds before they get
passed to qio_channel_file_new_fd(), the second patch adds a warning
that is printed when qio_channel_file_new_fd() is called with a stdio
fd.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
Filip Hejsek (2):
      char-stdio: avoid closing stdio fds
      io: report a warning when a file channel is created from a stdio fd

 chardev/char-stdio.c | 13 ++++++++++++-
 io/channel-file.c    |  6 ++++++
 2 files changed, 18 insertions(+), 1 deletion(-)
---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20261012-fix-stdio-close-98864055d473

Best regards,
--  
Filip Hejsek <filip.hejsek@gmail.com>


