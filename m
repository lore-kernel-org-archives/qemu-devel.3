Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B80E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJe1Y-0003BP-7v; Fri, 06 Dec 2024 14:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJe0s-0002rT-LW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:29:19 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJe0o-0005FX-9H
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:29:18 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-215936688aeso23084185ad.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733513352; x=1734118152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97w0wPWp6SUzaCB1TOeEg95vGLLrte4OzIrt9h4+KrY=;
 b=Z08mG0UkL4Z7bvBR4d1hmM2cnwkjkd6ZDx2U2EAAOxD+BF3pVeZecxFUKohCYWQ9UN
 7Lew9Rq6AbqvoWc7qwSCEi2oW8qZ6a/sdSeVGgia/kz/krXed4Yps/cOXgfwkyvwDQex
 5O00o3+7kKhrDNVRYTK+VSZ9c2UzUiNV5/bMw5c6KjaglcgemCnUgIiCSrSAe2o6xxyL
 Cv1BU9zB1sw/6hP3bt3bjOOevAHT9nN06ccbQfroIW7/H4VZkXs124GREYjnYi7M9vlK
 60/mo4eQ/M3pt6M5A6r/v1Ai7cKfkSFbqomjwzmBbpOws0P+CjpTg3TfYdOvy0Aeej/k
 La6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733513352; x=1734118152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97w0wPWp6SUzaCB1TOeEg95vGLLrte4OzIrt9h4+KrY=;
 b=KKIu1j8FE55WNb806lGGjSlllF5o526ZDrLqvRCdwVYmbEjZycuZ/wMCaYxXIh+x1j
 2/CfN5VF6C817w+fV3d1nr/0gNITfyuLhenyZrpDc5sF3l04FDpw3I3A14FYcnkxCT7m
 YNXpgdslvn0vbCFmECQCFDdZOYt+Sb+ALIMcF/u+tTgRq0zYXFBI3/9wVEOoGWzqGYQ7
 /RknsIq74WKVgW5j5noa3wscRVPR0qhN0ZroIjlD+Lg3nLw/QON3Qyjnr2DJo9V3u3Q5
 rLimWRcZ453r3AUk2CCbEb1IqE7aZUWWRNAFsYICYICHQ/E3jdvKjsGWuaFX5ELwEb/r
 ARFg==
X-Gm-Message-State: AOJu0YydUIVZP6r/A4AyKpGsl6rFWH2KvR5h07jrrg61F3eex5Rv5Yef
 ALY1+jLPNrZri4o2eV4ACyaVWfk4hP16MiiTQ5cey9rhlmqy2vT1fey+zVZ2fMH0/CTIYujxp60
 U2nc=
X-Gm-Gg: ASbGncsyO1KDA+vseeaTfGBCGWkq324x/My1N170HspZ4aG1N/Rn+kj9aaZa2J9Jtn9
 nf5tiS6BMuTAS7/z9II5zcHYzDEuZDecbaR9oEruecV9NPDLJhjx0Q8GTexX5dpA3axdCazHCIu
 cBuTrF+Co1LsfZNJqcgGTtJ/xWzSzN7/fwNa3/E+nOKf/4LZJbtbSxW20zw6iAuT0p5okJBfqSm
 4kHr34L9/DoCXrQ1owhlafCtSsQcN30FCabAC3q7jMwLYlb5kLh6omGcaRKkcslZjlgU9q9fE43
 3Z9syRiT
X-Google-Smtp-Source: AGHT+IHa0Y/Dxhv2xnIXn3gCj2NVW4p+ze0am4IQbPdvBV+gOCBF4RSnRzRWyYyqr8PfF/9cgWcsEw==
X-Received: by 2002:a17:903:98b:b0:215:9bce:2c98 with SMTP id
 d9443c01a7336-21614dcdcc6mr58945655ad.51.1733513351854; 
 Fri, 06 Dec 2024 11:29:11 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8ef9fcdsm32110205ad.146.2024.12.06.11.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 11:29:11 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eric Blake <eblake@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 manos.pitsidianakis@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 3/6] docs/devel: add b4 for patch retrieval
Date: Fri,  6 Dec 2024 11:28:57 -0800
Message-Id: <20241206192900.3893118-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206192900.3893118-1-pierrick.bouvier@linaro.org>
References: <20241206192900.3893118-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 69df7682c5e..1ef7d137320 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -433,6 +433,16 @@ For more details on how QEMU's stable process works, refer to the
 
 .. _participating_in_code_review:
 
+Retrieve an existing series
+---------------------------
+
+If you want to apply an existing series on top of your tree, you can simply use
+`b4 <https://github.com/mricon/b4>`__.
+
+::
+
+    b4 shazam $msg-id
+
 Participating in Code Review
 ----------------------------
 
-- 
2.39.5


