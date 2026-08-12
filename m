Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC5FC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4SF-0003DF-Mi; Wed, 12 Aug 2026 04:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu4SC-0003D7-Mw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:36:52 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu4SB-00064B-BM
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:36:52 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so569026f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 01:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786523810; x=1787128610; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E9/27h4GpKG3thi0thy85xMOyc1StiUQPFqu1vwl85o=;
 b=yQU38x971PqoKIju2Ux/huSNTYNup5faG6fyb2uSvF6ZrmRahnotGQBKmq7LXB/gkT
 ACQoxP1CAr87DEXgoERiDbCKj4fJ1DMK7AFGWCMSciegDupq93yXwz5TXzYeu822TB0/
 XuOjybGtCXqOiK+DmAEil5zlX6lvOpFpqXe49q9uNQp0U9TBIVW5K/kKQG8n5pQX5vWN
 4waG02EgS1L0g7aTC9dzVdaT1q+L9jBVU6CFq+4SKoDIF+nFEss3V6qWILuOsLbOVZeE
 gxYSpQqS3G2on1/ZL+EUqZXblfPYAxV3oWIa8nru3VP4JZavmo2OvdHtg8anP+Qqr/97
 BMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786523810; x=1787128610;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E9/27h4GpKG3thi0thy85xMOyc1StiUQPFqu1vwl85o=;
 b=fxgxa2KLJFRAu4hRPjL8WwdMpXnLtDvdVoT+xrGGLEWM5ocCy+rLaC1esDBUZFWAsv
 p0WS10/Xr2pLfqkPEy0mYSIcwu/Pa1vnxOeDfRSJRZkozBGHOM5S1oJnRKlCS/NHI5dC
 4IUV/Tk1wQUeuoed3VHpnAH8nr9W5sVyrwliytWljW+kfk59fGEKViNQcxS00EQ7fgc8
 FLzkPIdlWy6NwxZ+JsEVP7dkU53Wo9+nmmi9wYB69WFVEasZEJYKi6f7cB9ksMjJSH+D
 RnACpxyXudOeI4F+K3vVFRs9YIYdLa47ZcLkURwAp617LJlXXKt+OfPZn5wB6egOLOsh
 mdAg==
X-Gm-Message-State: AOJu0YziFd2DIa+6PAeDIxIOkJFnaS4zNAY0bqV5bMNxZ7xzw6LL2ivU
 2DTabd3w16e5l4dTOqD75f/n/+KEHEYKFGdFBlpgQveO5BVMybb+trPL7olZNFfbdHM=
X-Gm-Gg: AR+sD12hEvPFBoglG7wod3GvutZdRHYTM5BoSo8ygJpL7p/0ZZHN/NysWaejxmNM1Q9
 BgR2azDsnnIpdEJ5NYoqNMJDMNoSl7N7gEXan37u8fSVr/2iHJ8EI4uAVo6Yz0IE68+yz+AA/ZG
 1sMX18AJISG3rRLMxAr4DlpM4siKY1BO7oXR+xIiFetY8D8ZnG9ZPhVS4S0DCI/I370lKeFBYqZ
 WySEIahknkX6k9Wv8RGYaZrrmv3viUcPatwIgaXuMGNC8YCD+cp+8435cOGBEf3dxDxyg+RdOh1
 wgPC3VZDdyivXi20VoFyldIojNU/F84kdEQyU6FfK3LrMuxHob6hseE0gg2TEB/eJkagVNR+JzS
 yDDAg56Qj2szog4Y/TFjXnoqzDB0pHSQA7YYoI81JEp5jQBxT8AKF8H3HbwFAJ5ddJV1Qw8Iilv
 7wwyuUpRB8rNS4dDtE9fx3rABpl9bBST7o9FVnSpDpT41VzrH6iBqccSqel87k
X-Received: by 2002:a05:6000:2dc9:b0:47f:9486:810b with SMTP id
 ffacd0b85a97d-481528bfe01mr4233663f8f.7.1786523809707; 
 Wed, 12 Aug 2026 01:36:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150c088c9sm5561793f8f.13.2026.08.12.01.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 01:36:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8C3A25F886;
 Wed, 12 Aug 2026 09:36:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, thuth@redhat.com
Subject: [qemu-web PATCH] _posts: fix 11.1 release announcement
Date: Wed, 12 Aug 2026 09:36:45 +0100
Message-ID: <20260812083645.3830831-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 _posts/2026-08-11-qemu-11-1-0.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/_posts/2026-08-11-qemu-11-1-0.md b/_posts/2026-08-11-qemu-11-1-0.md
index e2fe788..5935b00 100644
--- a/_posts/2026-08-11-qemu-11-1-0.md
+++ b/_posts/2026-08-11-qemu-11-1-0.md
@@ -1,6 +1,6 @@
 ---
 layout: post
-title:  "QEMU version 11.0.0 released"
+title:  "QEMU version 11.1.0 released"
 date:   2026-08-11 18:56:00 -0500
 categories: [releases, 'qemu 11.1']
 ---
-- 
2.47.3


