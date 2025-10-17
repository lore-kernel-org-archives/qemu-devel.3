Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899E5CCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9j7e-0006KH-Ci; Fri, 17 Oct 2025 07:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v9j7Z-0006Hc-QS
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:59:46 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v9j7T-0001B1-8m
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:59:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-427060bc0f5so353753f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760702372; x=1761307172; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HZ7aHGXzKmSp76tqWN/Gn6F1iQDxql54TNPAGxCUlz4=;
 b=Qg6epLWmV3cE18lhYBvZFVw96OehefW/bK0IKbOwOZx74C/TzN5/YD5sAuQPSgWxgf
 0a1KN6qntiGz8NyTMP7u7qpSs24AWy8vKLhecoxrP9dqFbuBSk8H5rzbaDRv69tdXdi5
 36QOC5BL9abY7ufPOO28Tfp5+C2WzfhldQGYqBbLXsbGCj7kZtVtNTp9ResYYnasRtWo
 0z2FdlZ6XlN2TtTNKFwLKxw1BTyOTnzUWFYi0LFc+Sc4innT+tIPQIf6qTM5zrB5tAvM
 0XZmJxstWCWym8S8eqiuvyT9A0SfSryglSEyxv8StUJYUqNJRkBWeCGisdWhiYCkaazC
 6ViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760702372; x=1761307172;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HZ7aHGXzKmSp76tqWN/Gn6F1iQDxql54TNPAGxCUlz4=;
 b=ICm8Dw/ekEi+8CVKcknDm8MaebtQUvVZsgBtFilzn+U/5eqsezGjt3IuluvYnYO2aQ
 EvLj/LHk7YrFemgouMPutDMlBMwtBQFTH4rVJTooTTbYryGJOBbCOvpBAqMuledUlInx
 iBLDsmVF8ns0nSJu47K6dWZngUjoPUZJt9iEEmBGA32KE2h8ICJAq8SzaS2aUy/PpFfi
 z+TFbGqjFnc+cIZRAK+bfbIL5WwMEoHXagnX4fquUc9O0HO66nzi6hYoc/SkXDIIsVOC
 JqGipM/fVP402zbOzQ6sPqlNBJnHActpF6gGmG0QIW2xYZ+cTMuI8UKZ/yyGsONLKaHh
 C9xQ==
X-Gm-Message-State: AOJu0YzuotJbnjzxTE0mNi8gLXFxNZ2H2nUcDFyMVDBAtlp/+0KyXuW6
 sqErOeB3Id7ZASGjtpxOKi2LtwvqpYGlSV8Uoe9bRk2+eI0EwuogV5P+
X-Gm-Gg: ASbGncuU5lBamp6EjuGTYHzVbz5OsWfH4NX07FWurQ5MOcncz7Pyhpd1/llFMFUNV4b
 DBEFlycexYaYknfPVMolN+Hjs4rKVYvhsUSg9DpF3jOpvcMtgdGprJWQn3+OZfE5/AfpeAEJyA2
 SJVC9aBjV5oGTsptQicWkPeAJLFCV2JVs+dDCJd8IcfMvqWNDUm7DxA7BC5c8O04uJEKur5pwcS
 KMHlM7aQmEsXmrUUMm6YIGlIL3NouDCqaZZyU1ug5B4lWqoaZIE8x1oWiUvoRvtHt241eXYNwdK
 iMKKPdPR9ixFss9KOO2+ir5uKp/LCu9KbhWcWlhAtwDUYPB5nNyFfErgG2FsCxSJZ5Xy+bQuNNk
 HIsl7MxuJjWO76W/gK21E2R9Q+cmd41KtVCABFqvbHqbnhS2nQcbcpemggeroJ45GIWtY90w4dH
 MtN6T5az+pW1g6Kr3SJgMh++0noltxY/lgg9jtP/q4PuLh8TgInrX5h+RWrg3TQWZa0Q==
X-Google-Smtp-Source: AGHT+IGffcjLhn3ZQsduCvWxabPKRIT0pEX5murf0S4qGbXyaZg5n1Ztz0O+j2KwyqouGGiyWRNXNQ==
X-Received: by 2002:a05:6000:1849:b0:427:809:f00b with SMTP id
 ffacd0b85a97d-4270809f2a0mr1075359f8f.50.1760702371870; 
 Fri, 17 Oct 2025 04:59:31 -0700 (PDT)
Received: from GAL-PC.localdomain (bzq-79-177-159-123.red.bezeqint.net.
 [79.177.159.123]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42707b482b3sm3208493f8f.50.2025.10.17.04.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 04:59:30 -0700 (PDT)
From: Gal Horowitz <galush.horowitz@gmail.com>
Subject: [PATCH v4 0/2] tap-win32: fix multiple tap support
Date: Fri, 17 Oct 2025 14:59:01 +0300
Message-Id: <20251017-fix-win32-multiple-taps-v4-0-483415799ed8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIYv8mgC/4XNSw6CQAyA4auQWVszL0BceQ/jAmYKNOGVGUQN4
 e4OrIgJcfk37deZeXSEnl2jmTmcyFPfhdCniJk67yoEsqGZ5DLmmeRQ0hte1CkJ7bMZaWgQxnz
 wgFYkxmBZWJGycD04DKubfH+ErsmPvftsjyaxTv+bkwABBaIW1hgplL1VbU7N2fQtW81J7h117
 MjgWJ2lGOdG66T8ddTe0ceOAg6ZUrEtL0lihN47y7J8AShFG3FOAQAA
X-Change-ID: 20250920-fix-win32-multiple-taps-ed16ccefbd17
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Gal Horowitz <galush.horowitz@gmail.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=galush.horowitz@gmail.com; helo=mail-wr1-x42b.google.com
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

Currently when more than one tap is created on Windows, QEMU immediately
crashes with a null-deref since the code incorrectly uses a static global
for the tap state.

Instead, this series allocates a structure for each tap at startup.
We also take care of cleaning up when the tap device is close.

NOTE: Checkpatch has a false positive on the first commit, where it
mistakenly flags a cast before an address-of operator as a bitwise
and operator missing spaces.

Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
---
Changes in v4:
- Added commit descriptions
- Added check of CreateThread's return value
- Link to v3: https://lore.kernel.org/qemu-devel/20250924-fix-win32-multiple-taps-v3-0-9335df866c14@gmail.com

Changes in v3:
- Split to multiple commits
- Link to v2: https://lore.kernel.org/qemu-devel/20250923-fix-win32-multiple-taps-v2-1-d497e5ac446f@gmail.com

Changes in v2:
- Add cleanup of the structure fields
- Terminate the thread before freeing the structure
- Link to v1: https://lore.kernel.org/qemu-devel/20250920-fix-win32-multiple-taps-v1-1-bee41dcc213d@gmail.com

---
Gal Horowitz (2):
      tap-win32: cleanup leaked handles on tap close
      tap-win32: allocate separate tap state for each instance

 net/tap-win32.c | 51 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 11 deletions(-)
---
base-commit: 18f6f30b0089b470f3e737637a86dfb81ebd6eae
change-id: 20250920-fix-win32-multiple-taps-ed16ccefbd17

Best regards,
-- 
Gal Horowitz <galush.horowitz@gmail.com>


