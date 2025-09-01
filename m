Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BBDCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2tS-0002j3-8G; Mon, 01 Sep 2025 07:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2tN-0002df-Ke
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:40:09 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2tF-0000Ob-WE
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:40:08 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3d0dd9c9229so2171004f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756726799; x=1757331599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X64U6sCeRruJRvnWzmKI3XXP5jta6OlcIn4aGwWx2cg=;
 b=FxkDO0IbgaY/eth5ZoqjdLGzgru+W3iXsMezlNxatH9OR328S5fxSx2HTwTB5twxmI
 NNMDj294G7YArXsQid69eMtZ4pLfgww74XkVlVdbAeWP/iHZM8yQwc8debpb+a2+We6O
 gkts3iS3gP26BCoOCb4iQHg/wfD7YKr5D+weQ5r7Vdeoeh2Ztp7uPYjNPipvf40IX3gn
 nEUeKiVHOkuUL692sSWa7//S6WO2zns7q92MKKjuYUs161pIby2dmSNrXz18NQhellnX
 pFfDxxHVCtikkvpgyAwlp48YLxwUDtsuFmklFhQ2JrXWNQkcZfdjnR615xR4UMqSZDj4
 qIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756726799; x=1757331599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X64U6sCeRruJRvnWzmKI3XXP5jta6OlcIn4aGwWx2cg=;
 b=AX5gkvUgM7q09bLjgLj89hTs+LCaAiynqbwxhMWkfba5KQ21Dm+pKQ8WuQljMTsFvV
 Q6PKDPhNNkma/D6Ey9oisQfMgwsZXl5UtfcX8KimPGAxQVeOupW8PSAfjxSPwscATHg7
 4CXaMZkaPssCBnyJCp4xI3M5J9Kq+ImOUzsy/UOFCjLJT9EICXlEF36Fxwfzmi45/+eJ
 Z4pcZTRgwlFWX9j2YiWv2pN81Ev6+R3bStQjo7KwtVL5unKBCfRZ/IzMnVBFU2ezI8Yw
 WH0qVpq4oJyP40tSXKyYNa13YUbFJo7Z/ds1J1UjTVC3iRd1gDVfS4TWHOB+PPbinDFn
 Q4NQ==
X-Gm-Message-State: AOJu0Yy6yWiPynnifgQg4di9ozspkqjJ1nobpaNBmez5dV7fSR7DhBAw
 TSdhS7xr7G72FxJBcQ0LSIBnYGd3FfcFzNDOudjxDehbLxpcGFgYnMgcwYle4ITpzZt05wCd+NB
 j8bFI
X-Gm-Gg: ASbGncs/ghdfYxQ0LN+ons37RMnMf1XN51aXDK8c1F7pSIr3GUqMkN1l2GUDKUls88y
 qbXWhmWPKsjDHcNk0bfox+G+JDkixZ3S8VTti9xDpvBsHsM6FSVW25K7o92P5BhLtlHKrh5pfl/
 kLAm+vamRmRu3j+lm1B10ruUCLD2zm92zS0BvSTrXpxNY0+QsMmRisNxOGvxIpgKFfQUEWf+5kF
 IW2Wfewg47SsfrZwfTfbVzISJZwJL8dxDqtu22c7Ibc2P2jkCKw2L5QAdXvAVfY4iIbspX1Y0jM
 +AZnufsfqYxj97b3tZcuRKYdRWQyjZxeJ3EDNi3TkgYFNj1Y2by1D6wuo825/+xR5f63pB1EmgC
 vsHYZ0gKnyiQhXwfnNhe+gL8tIJsYCs8mMGqsG2De23MQCWIktUAS0ni+5TNw8QuB7rmBeizT
X-Google-Smtp-Source: AGHT+IFVk3WYTLhxY/zO/67OwqDHal3zKrrY3PNF8Z1smIwRKSbHHQrD08Zz7WW2K9pDDig78HRPGQ==
X-Received: by 2002:a5d:64ec:0:b0:3ce:c602:58b4 with SMTP id
 ffacd0b85a97d-3d1e06b02camr5609419f8f.54.1756726798643; 
 Mon, 01 Sep 2025 04:39:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fb9d37sm15143236f8f.49.2025.09.01.04.39.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Sep 2025 04:39:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] docs/about/removed-features: Clarify 'device_add' is removed
Date: Mon,  1 Sep 2025 13:39:56 +0200
Message-ID: <20250901113957.17113-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

All other titles in removed-features.rst mention when
the feature was removed using "removed in". Use that
instead of "since" which we use for when a feature is
deprecated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 25a904032c5..00e248de60b 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -730,8 +730,8 @@ Use ``multifd-channels`` instead.
 
 Use ``multifd-compression`` instead.
 
-Incorrectly typed ``device_add`` arguments (since 9.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''
+Incorrectly typed ``device_add`` arguments (removed in 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 Due to shortcomings in the internal implementation of ``device_add``,
 QEMU used to incorrectly accept certain invalid arguments. Any object
-- 
2.51.0


