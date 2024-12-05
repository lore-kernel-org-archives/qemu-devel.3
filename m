Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8160E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJKFP-0004eS-F2; Thu, 05 Dec 2024 17:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJKFM-0004Ww-G3
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:22:56 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJKFJ-00080c-Hu
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:22:56 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-215b13e9ccbso14212725ad.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733437372; x=1734042172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJU6LTkTBYM7iWtOHgTlgOKxjsUORD0kvMkrC1zUSAU=;
 b=j1E9Ur/Vv4D5T7aDlFJIjMeI7jHjhXK9ZfRDmjT4I32w2QK7TuiwVcZ8+i38vZZsTo
 +CERCxIWJNqu/JWDZ6JXAzdIPqFhAzaF4z/icsTT13o97idlPr+20eejUxzjeoZINI6h
 lKXeBvhUgbTvXmjJK38O9QKIBYAn2iCCBW6P2Ym0RV2zybCNkC/V8VbPRN5LlkBNwmYv
 g88hbbfrStTVE6VP9y/DMw0pQq7nFuPxjaNvUXR7PJ2JLqL9zP9TZyBrHeRjggruZfZ3
 P05DH9/0FVwo/7spv+NKZP9+eI29n0q8apScrKLY81VkfZjENFslUSoHE95VJCksT3fB
 xphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733437372; x=1734042172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VJU6LTkTBYM7iWtOHgTlgOKxjsUORD0kvMkrC1zUSAU=;
 b=NcTEs5buIb+ZuIckU73Dv4556BpSRHlh7cdScezIbCQ6AJPw/dnhLmWdW2b63rcJHf
 BrtYJaPu4YwyYiOt4Us7rFsJfJkoHQQg15SGI+OW9tfJeSLgrl9C8qH4kxmZZCyPnJC+
 ACWj6f0QYBWYrjy001xCOiFH3F6gzslkAKrOiimVP0LjWnHimbf+I0p0OYawjdM6Mg6p
 /cX7E1B73BcY46ZEWi0PhfhpTHUxBBApbVGf6/xhdQzdKbSFC/SUurAYnWVldJGMnhhj
 Ob2UCSdFxFaCAYDQpSvJG4f47/JJxQYebRMZ8GF18LB9+123WhECiwuh3aUQvU+k6+Dd
 08Fg==
X-Gm-Message-State: AOJu0YwvawUynC8gArVoHwl+BKfq//ePwjeIBOWPW3T8+n0C2ABmRCCd
 qBbAsJ/HJNtVHzyTqqX+FyXNbsyyXu2Hlncj8Ecwagzr1NUG3y8PMsoTcjinIh/SFklD5y/p+7t
 T/2c=
X-Gm-Gg: ASbGnctZKBUQTx2kU/YKbnsPRHcN1jxVGyx14Y2bInieAGD2h8OQgXAaTjjpooWavGk
 3Q2uUu5PrloKoVBIqLE8Q8G0PGK+ZZflW3F4m5vylWuIGsPLtgfOlLoJDM+mo5YbRqxS/YCDx7U
 1a6FlbPkT2si7KChMkHP+NCfO1dDJjbW6vjXMk1WdI0SIgze1RqJDCSM1r358WfkEBx3zDkzbYQ
 XVLOz+iTxrTaLfZRZtI666r4XbMe05nX7l6xPT+mlV+IAr3SIKULLhPyx3EyGYuI8gAoRPyPNFo
 3P9q/zgZ
X-Google-Smtp-Source: AGHT+IHFA6TZyZzj5zKebKMPbD5MvWXbAMQRgtvdNPIShavDxnpEu45VjwenpBR042wJxB4xGoJ5Ug==
X-Received: by 2002:a17:902:e5cd:b0:215:7ce4:57bc with SMTP id
 d9443c01a7336-21614d3b228mr9364535ad.16.1733437372098; 
 Thu, 05 Dec 2024 14:22:52 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f0b571sm17310435ad.183.2024.12.05.14.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 14:22:51 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 gustavo.romero@linaro.org, Andrew Melnychenko <andrew@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 3/6] docs/devel: add b4 for patch retrieval
Date: Thu,  5 Dec 2024 14:22:38 -0800
Message-Id: <20241205222241.3789437-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205222241.3789437-1-pierrick.bouvier@linaro.org>
References: <20241205222241.3789437-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index f8b7fc59544..99f14d4b44d 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -427,6 +427,16 @@ For more details on how QEMU's stable process works, refer to the
 
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


