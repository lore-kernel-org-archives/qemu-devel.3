Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931A8C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7sW-00062p-Q7; Mon, 18 Mar 2024 03:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7sV-00061g-8C
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:57:51 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7sS-0000ji-Tg
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:57:51 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dddad37712so38458205ad.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710748667; x=1711353467;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cVs7WwcQJDh8Ok+AUw7pFOFNfDPqsJnTku4KwUANzlI=;
 b=werqyhIxS5s3h1orgm0E+NFodEkqMIiVcwqzvGWS9+jIyXx+iY69Fv4BhbVyDqbhdI
 +ZWkSUzQeqYVQNwGaJI+iBjxKNeXm5VwEtwMovQdN6W+5/U52oN6g8pu5gdfs2FD5aFX
 iedsrS4a/toGu7w66kW8zM3jAjxWw4H0JrqeMZO9V+hYCTz5xyVW92OhnuDUgIWN3M4I
 jMgo9FPRoJBkHJThbejMng4iHczsHe4fiGb2iLiXLT9w0rUQpbN7HybJYvw1HUHzC5H+
 GTM1w7zh0BEhkgTXD+HML7dCphkPQ4adpu7OuNCkBZStJ4o2ij3oqu+loRe8Fm5mDRhG
 weBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710748667; x=1711353467;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cVs7WwcQJDh8Ok+AUw7pFOFNfDPqsJnTku4KwUANzlI=;
 b=D1TZD/YS2dM61nBvM0OBeHIOGV4VidykGrTsiaQqzPHmuqM5ImyPZ8cEmiQEjCW4hl
 2nNrz9F56cQ4PiguuxMBOZrhtPxg45Un8ALBgm9lEKF9BeVoKUABNHh4o5TWa8fFF5vi
 LDKiNgdEyJO/0K1Lf60j8DlvGTe3moD21lW9ohrGDJwM4cRyBLoCU0+Ekb2cnmsbWMRd
 MwePAHZhD6OaIm84XluEjcRo0u7pk0zadVAaXoZEU5dEkcAvDqpsBm0NeepMaz/hWHTq
 juCrT1VnELlQtQ+UaEmE7P2VfH2U+hEIor4t9TmD8jeDyCoadPNbbX3BkB8griLPNPpe
 Y8Dg==
X-Gm-Message-State: AOJu0Yy57+QIjLFcLU6aMLibO1QsqTv1lVLplENxFFqbCYl2RZ4DViKx
 +oQE3+zQQIayuIBWMOU/cbm9Un+WUtKg4nHHo6L/JW3wJzQj/whJLJq3UOiPEqU=
X-Google-Smtp-Source: AGHT+IG7+F9yBZ3/Z0eOXipfZfGQJ7VvVh0/3btKQkOPNnsxgb7uO5aaMlGs4SfzUPI+Rjb6m1AWAg==
X-Received: by 2002:a17:903:2306:b0:1e0:1bff:59e2 with SMTP id
 d6-20020a170903230600b001e01bff59e2mr3637166plh.39.1710748667300; 
 Mon, 18 Mar 2024 00:57:47 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 kt7-20020a170903088700b001dd0d090954sm8587802plb.269.2024.03.18.00.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 00:57:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/4] ui/console: Remove console_select()
Date: Mon, 18 Mar 2024 16:57:41 +0900
Message-Id: <20240318-console-v1-0-f4efbfa71253@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPXz92UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0Nz3eT8vOL8nFRdM3MTkxSTxCSLpEQzJaDqgqLUtMwKsEnRsbW1AMi
 vhINZAAAA
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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

ui/console has a concept of "active" console; the active console is used
when NULL is set for DisplayListener::con, and console_select() updates
the active console state. However, the global nature of the state cause
odd behaviors, and replacing NULL with the active console also resulted
in extra code. Remove it to solve these problems.

The active console state is shared, so if there are two displays
referring to the active console, switching the console for one will also
affect the other. All displays that use the active console state,
namely cocoa, curses, and vnc, need to reset some of its state before
switching the console, and such a reset operation cannot be performed if
the console is switched by another display. This can result in stuck
keys, for example.

While the active console state is shared, displays other than cocoa,
curses, and vnc don't update the state. A chardev-vc inherits the
size of the active console, but it does not make sense for such a
display.

This series removes the shared "active" console state from ui/console.
curses, cocoa, and vnc will hold the reference to the console currently
shown with DisplayListener::con. This also eliminates the need to
replace NULL with the active console and save code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (4):
      ui/vc: Do not inherit the size of active console
      ui/vnc: Do not use console_select()
      ui/cocoa: Do not use console_select()
      ui/curses: Do not use console_select()

 include/ui/console.h   |   2 +-
 include/ui/kbd-state.h |  11 ++++
 ui/console-priv.h      |   2 +-
 ui/console-vc-stubs.c  |   2 +-
 ui/console-vc.c        |   7 ++-
 ui/console.c           | 133 ++++++++++++-------------------------------------
 ui/curses.c            |  48 ++++++++++--------
 ui/kbd-state.c         |   6 +++
 ui/vnc.c               |  14 ++++--
 ui/cocoa.m             |  37 ++++++++++----
 10 files changed, 118 insertions(+), 144 deletions(-)
---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240317-console-6744d4ab8ba6

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


