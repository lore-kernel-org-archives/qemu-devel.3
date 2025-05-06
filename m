Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FF7C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 12:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHrU-0003Rd-Ll; Tue, 06 May 2025 08:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrS-0003P2-2G
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:26 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrO-0003qQ-QR
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:25 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5f63ac6ef0fso7906144a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536240; x=1747141040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elY/IXRnQQgsjOfPo4J8YHl+Bpt9unCMzIzNNjW7sw4=;
 b=Sp0VoX+VAzNE+wndinF3z2amtQoaDpnwvg5t2i+uDyHmaBlwAvKAbwg1mtpg+hI/FA
 Xy6rPY9GMpMTx5h4Va9iD0uJMllHA57rhDM4S+5Jau3y0/EVuYP+15e+hSMbap7uGOOw
 RA+zib1bEQwMtPS/dlEF5SXKCzr4SkKsvFh5e5wE+RSA9PFQk02t93Pe0mW+LrV3GKYp
 Hl+zbyqFQJVsHRxBhcVtBjYmzJDUsCqgACGBwTEW/ttqynuB3osHe8u50GARzXFaD3jk
 5mvT09gyvpboDLD05mSLRQ3R7m/B9vtB16QlLZ7N2KqyATqZX7NLQWMcFD3UT/P2bN2W
 GOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536240; x=1747141040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=elY/IXRnQQgsjOfPo4J8YHl+Bpt9unCMzIzNNjW7sw4=;
 b=bUy4iwUO607kFACYBdUcvvPHX2atmDkzo+P2dsYhaPJLVhmwtfe3ZSjgC03nwYNo02
 AL5o/M/JooYDJ9Y/K7zEUyjmdLKT3N1cdodItgQGuRV4FGL8RFXGMrFbHcgqQTEjron9
 xbDQuZw0n1rEVaJcJH1ly7aLvPM1t08BzqiZcImG4wMHwBbJ6CsRLxU/Ufydoo3SxrH9
 ngik8NAfIkEoODfS2bmvcoEtI8S17M8Rd24o2p0dRUmCVgmunRinIPrDsF6NBpF6RrZN
 Wlg899By+B0d0y5caC5Sa+oVFNpM3k8S78sFqajVWZyPwHaJxM3sEwFRmfHbdRfLId7p
 A/eg==
X-Gm-Message-State: AOJu0Yw19Ga5TbQFBktyCtKbUB2O3Wswrt0ktWYEsw3oCcZj+G3nrAtC
 uKFeBtYmBVqGTjEeBUgfSdEoM4uFma2yFKCNKL1r85u7V2aJIu2YSACsPJ7tNqw=
X-Gm-Gg: ASbGncsKxNr9EdE32m+ZoGZdQHF4ZRdHWp3Ws8XxgwcP/2zXSLhYOVV9GIZdUBMxVd9
 b+KQEiPXV3sbVkNDLwm5LpHR9uSozpZQ4kI/n+oyVcPpX4lBqvnr1aOzmeKgWILszoujUAighQU
 GSaOx3D4T2AXBbU8amlfOvjKfoe/vPlga8+yvxiNzK5wwbzzwkac+OEKc3m8EDLcX2QPYbjzoA8
 bVTbd01XlI9zTJA4KUCuJ8ZYWV7kyfj3nHUhgeSIzl7+makP2jS5dcbbZrEE1bWM3+R9h0B4LYI
 gAz6/oXc1TkJbuf+SRhdoQlX9zXBvV0CWWmDa2dTrY4=
X-Google-Smtp-Source: AGHT+IGNIMawvVPpjXSW7cpUD0vKkShkTsFUBsIaH6JbfaFN2B8vj3TChzXA5i1vqQX9yWgUnCCRYw==
X-Received: by 2002:a05:6402:1288:b0:5fb:181c:232b with SMTP id
 4fb4d7f45d1cf-5fb615240c1mr2390371a12.6.1746536240418; 
 Tue, 06 May 2025 05:57:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa77bf3f01sm7499100a12.70.2025.05.06.05.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF7165FAC7;
 Tue,  6 May 2025 13:57:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 08/14] MAINTAINERS: add Akihiko and Dmitry as reviewers
Date: Tue,  6 May 2025 13:57:09 +0100
Message-Id: <20250506125715.232872-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506125715.232872-1-alex.bennee@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thanks for volunteering to help.

Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d11f8ac18c..2df6c09894 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2645,6 +2645,8 @@ F: include/hw/display/ramfb.h
 
 virtio-gpu
 M: Alex Bennée <alex.bennee@linaro.org>
+R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Dmitry Osipenko <dmitry.osipenko@collabora.com>
 S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
-- 
2.39.5


