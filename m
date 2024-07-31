Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C3DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZARQ-0004vG-22; Wed, 31 Jul 2024 10:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARH-0004VG-Ud
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARD-0002e8-NZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42816ca797fso33324295e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722436581; x=1723041381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MpfLEWhTNYsztTZUist4DkFQWGQUQxtEy7gAUiTdvXo=;
 b=Tq8FVuIZ4oEFqI6nBMVac+SJqystRDayQkDffmTxCqMlFGiatTFPaELmt4nbFhQgkI
 RHjYpIwECfIraswX7shyLQUNUkM49Ww/25ZZwzZjP3LJXWKYbUjDWbohFXjYHhdeBjPL
 jVLUUWPzUovcduuHDCr9rDk6Pij9ZfTCMHjqxtjJzIuYxCNxBXYfM+If+RbSsZVM6UOX
 R365xh+siLs0DE24jPRd+RdM4TqgjqcKCJqX4x6uHgklcqiX/oHqEHWv0s83zQlrv2Fi
 ntaT9tI7paUVCTDB2r756TDtQIaS3wjrxfziEZrVqtbYDhS7iJ4qgJT1z3O/e7GG31LN
 AT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436581; x=1723041381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MpfLEWhTNYsztTZUist4DkFQWGQUQxtEy7gAUiTdvXo=;
 b=YOOZ0O9U+0FJcotaER5DTrPcYW+kj99Z5H4JdGZ3wIBjDtSce5JR7MKqvfnr/u7LuC
 pANtvpqvQlj2sxkYqCWizX9i4ZUv8gjnhW11OsfGFZZu1PRgQy9qt/IfNWS/kGjFAhlA
 DHYhDNS1fvG0zIIfjAT2jNBSSZOdpKhJ6GB1mzkYrJOqz9ujqcMhA5ZYRdoAUkmRdl9+
 y1bJpAdCE7DkQiiRwVWw9QDe0WKeCF1Fix8+BErVGsDUqxYh/iMk/NrINl/UlpZzVu+f
 aEnJNfMV93TCWfISD8ZTQocBB8ixejbvL8JpwKdFwxM7r9GAxcDjkBJfOTeVGLwBXI1G
 rVTw==
X-Gm-Message-State: AOJu0Yyt7Iy1Na9KMYDt3eslY9IYVFnH0MAPjaJJNYkTpcVOyIsvvTj6
 kcATexxHL5lmM74pH/s0ANIOwZYOZGKyaxaZTYV6DznRgz2KaoXt4US8bZbzfsbVNThbvZP6WWf
 G
X-Google-Smtp-Source: AGHT+IHmzzgfr9U2EwF+QvpbK8GVpy0z//7VKbmXt4J4lQBmVSTAvucMG46AOZSU5g85OWpj+LLrQw==
X-Received: by 2002:a05:600c:1392:b0:426:5d37:67f0 with SMTP id
 5b1f17b1804b1-42811d8cc95mr101315565e9.13.1722436580664; 
 Wed, 31 Jul 2024 07:36:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89a86dsm23976025e9.1.2024.07.31.07.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:36:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 3/7] hw/block/pflash_cfi01: Don't decrement pfl->counter below
 0
Date: Wed, 31 Jul 2024 15:36:13 +0100
Message-Id: <20240731143617.3391947-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731143617.3391947-1-peter.maydell@linaro.org>
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

In pflash_write() Coverity points out that we can decrement the
unsigned pfl->counter below zero, which makes it wrap around.  In
fact this is harmless, because if pfl->counter is 0 at this point we
also increment pfl->wcycle to 3, and the wcycle == 3 handling doesn't
look at counter; the only way back into code which looks at the
counter value is via wcycle == 1, which will reinitialize the counter.
But it's arguably a little clearer to break early in the "counter ==
0" if(), to avoid the decrement-below-zero.

Resolves: Coverity CID 1547611
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/pflash_cfi01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index c8f1cf5a872..2f3d1dd509c 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -614,6 +614,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             if (!pfl->counter) {
                 trace_pflash_write(pfl->name, "block write finished");
                 pfl->wcycle++;
+                break;
             }
 
             pfl->counter--;
-- 
2.34.1


