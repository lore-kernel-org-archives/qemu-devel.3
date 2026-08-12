Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E98DC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBKE-0007EA-0H; Wed, 12 Aug 2026 11:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuBJz-0007CO-C2
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:56:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuBJt-0005N1-FT
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:56:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49557167508so8604445e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786550202; x=1787155002; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c1fFJB0Iakhj/LbgbAF/f09z51LJNec8dSRHFCwHZrU=;
 b=ZtewRz+KxN+hclflI3s9xhoTkRhFVC/taMZC8VR0+LtOJ7L6CKoeyJvdus/uzfos+Z
 cuPKhXrVO0hnfJ1IwoVdGZJ+eS2QqFjHbcaW69bowwR3xV1GPEhGCfL04RGdwG0Iwc/P
 K/xplBAVXFLw+RL86JxkSBvfPifvYQuO/ngvuinyOyQ4dZ9OnRJjuH8LVk7A+8Qxmotm
 Ajy1Y83ipD1I4wKZM+/Xi4ociuX5SQ8UsIYyKtDb6BSXhJb2cIvMYVWOL8lhMdfT5gyL
 HYXmy41HlXqi29svZyfRMBUVm2vRNKD/ur417+C7jdePTFaWVAg1lX+cHBo4QKH7qihA
 BveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550202; x=1787155002;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c1fFJB0Iakhj/LbgbAF/f09z51LJNec8dSRHFCwHZrU=;
 b=GPIKzOc7wQwuuni6+Txn5UEsX/rQfkK8bIfTJJFvyJjlrKOWhNMlX7kZOhkMQdt9Y5
 1/UCaLxf1kV59Upb0IDkdo1dch/q8ypvlByZYUlk1FjZ10xzw9DnMLtac5+e8j+0aDJh
 2nA0pPPzDuBcf92WgF2T8ziw/EoZddAdX4ALT2ElhElFuP2dEZj2iqeSOiC9SWFTELOf
 x0nvdvWqUGEf8vitlyc4BlDJuKIbpRMtOyrUeif0Y5rt9B2bCIG/YfBjXo9gLZR3I/q+
 Nq3MSOV5OUxMbMqytLgPpWnssfElxKwhvuUTuhbmQhgtePHkA1XnQz0r+2X4R4HG/qdH
 SaNg==
X-Gm-Message-State: AOJu0YyWLNPI/AtL+nMOl08HHlMCeZSNPvY6Bqp1OPcQu/S38nzuzRT+
 5bi8V1tfg5YAJnJoH1S29BTjtwtm/RIHQOJMV/iK0KKokXrwzbewlKADCkh4FoB0cSQ=
X-Gm-Gg: AR+sD11HTYnP6MP883hrUGuslr+7AMX+a7UnReRs4hEHr3wwRwbv81uVN+A6cDKlrqw
 HTSVfya89fEcgUW8onW+H4hBa2g7Z6iktIJ4juUzXh+OY3VaoV6GTJX4sHXgxKrP//b88zYEaVH
 /ePrw15GknKBNIDmrlR28I3pxKU3OHtnuQzwMAo+SnWjclDyDBHLxmKU8o03kBh+xvIWhwsdRzk
 pOHMnNaynZWXqeb/trIVoMdDRz0yHaOxqvKm/WgepISPVKfwZKpKjWIcwbbCOhN4JgO/MA6JelN
 oNG1eYNkItlmz5X0vO9V6AX6aoNqVT257lMj6c8g3o/69CGZPjgfV1Kkl8/X2aZQeZQ8kC1fCBO
 ZB9FSQN83fSG2tFl56myTnoLMCMxiybf+Ad83W+4cbz4Vi1x92OBC7sfVcRlgz9HnkgkCMG+piX
 oLjPdAMPWZ6BUO8F0cfwUNmA/U4VvM0qnupxd4/98tCw1XHiHpKshSeHy+rLhq
X-Received: by 2002:a05:600c:c84:b0:499:7aa7:eaa7 with SMTP id
 5b1f17b1804b1-4997c130c54mr78689495e9.15.1786550202020; 
 Wed, 12 Aug 2026 08:56:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150c06ab7sm7836410f8f.10.2026.08.12.08.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:56:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C8A495F886;
 Wed, 12 Aug 2026 16:56:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH] scripts/feature_to_c.py: fix invalid escape
Date: Wed, 12 Aug 2026 16:56:35 +0100
Message-ID: <20260812155636.4158158-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

This leg of the python code is trying to emit literal octal values but
bodges the escape sequence. The newer python on my macOS box
complained:

  /Users/alex/lsrc/qemu.git/gdbstub/../scripts/feature_to_c.py:28: SyntaxWarning: "\{" is an invalid escape sequence. Such sequences will not work in the future. Did you mean "\\{"? A raw string is also an option.
    sys.stdout.write(f'\{c:03o}')

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/feature_to_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index a52cd2e9ec6..4275b758172 100644
--- a/scripts/feature_to_c.py
+++ b/scripts/feature_to_c.py
@@ -25,7 +25,7 @@ def writeliteral(indent, bytes):
         elif c >= 32 and c < 127:
             sys.stdout.write(c.to_bytes(1, 'big').decode())
         else:
-            sys.stdout.write(f'\{c:03o}')
+            sys.stdout.write(f'\\{c:03o}')
 
     if quoted:
         sys.stdout.write('"')
-- 
2.47.3


