Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20E1E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 14:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL0nz-0007BK-J1; Tue, 10 Dec 2024 09:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL0nn-0007AY-9v
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:01:28 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL0nl-00071u-UM
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:01:27 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385e3621518so3722556f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 06:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733839284; x=1734444084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnZbIdfz/4S6ZbGmWDUcJ7Nrg8We4vqiGKMyKWE/kZs=;
 b=dkVP6XDZjdI/p4m2hsZo6LecxgcseMj2r4SlqDiZM5U35qtRE7gTsX1GeCXy2n4fuG
 IseWBO5JM3TmlQZKr8rlLG39uF0SUGp9gicA1XGJUBRWxCqzsJto7PstH596fQNE83eP
 2mU3c+w0/PlNwEGtXGu0mQXz7XCcmMwSb4E3hvvQ30LH9fdlEShugHxFnJzh+manR3E6
 5hToJZrKfHfHYZ+5mur2ZwIGo0TkA5FGXb+DpWKIlBBE8CYcK+2WtXkeefD1gpQi8PsN
 emB4JBVUPc3o9gcOsLNrjV+7iTun8OKplvwX7Y5Mc1iCEDZQsbzu97mapFbLgJPMuA/r
 okVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733839284; x=1734444084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnZbIdfz/4S6ZbGmWDUcJ7Nrg8We4vqiGKMyKWE/kZs=;
 b=ls5g1Hz1E7DeS475TlXpmcvrngfs3yaMDhhQ2mnoabyH932VsUTY9EeWxraj8CA7N2
 DTUb9BE0/SrbtNzHgGmEjU7Q1Jee653pMAGUsPRRBvTRIOVSIncF0HWb+0cP981vK9OD
 t5qAsH3O/H/b8s7VDUuCp9Xkz5Kr4l4/51M+d9YIoyzp2eRlZjoeB+Vql+3nwtqFNGW2
 QElCYXlE3icoycNfUzbk20ylYTBZdGWYWJwgPgdQU/+7z5gwu3OiwgL7GuAaPYyj32vo
 UwTa3Ol27KVSvYg9GDbRY5xoXX6ERgg60QmbeeEd+SkaJJNX318MWJv0SDcwjXTVgxxJ
 r1hA==
X-Gm-Message-State: AOJu0YwioFHKpYVjXPROoU2AWmKzQXK3jLQQ/1mJ4R6/whJmNE80h7Pz
 f8h8sAcqQVa5GYt9OPb5BhUPKYwI27bKEJzXRnh50Zwv4TJPkgK5qcqNZpAMRBNmZfpf3qTW5Jc
 spk8=
X-Gm-Gg: ASbGncugf0HJROAHlntzGXl+jrZL9PkQFZ9f6dORpgm+GP0ix7pSy0JPrk9RyjQVxfi
 p093yxIPgxoC7pNppCk0Bxtz27MVnmxezJWxA1bPi7e6yzZ2w4K4V/W0At2RWUMdIXJopA2yWLy
 0ZtTMqrcuOCxL/WwAKsgMh3nHQcWaVs+r6KQakO402oqyuzNKY2Rrl7yhY8WOAfJAnwB++tGwJk
 g26VsZCj1p03yPukVlkibQL3MGhY8Zn19G0L/MLtWMIYUR3uRVrqlcnZ/aBAAp88cY5dsoSI7WV
 4j2yPMGuWqjWzJyt2Biwaz0U
X-Google-Smtp-Source: AGHT+IFfa0u32tYqc0Lqf8SJVmEqmaQs6hS6iM+vKU/WUJqpOrWNLBnMNpoegpXfdJJsi79dAM2p6w==
X-Received: by 2002:a5d:47ac:0:b0:386:3dad:8147 with SMTP id
 ffacd0b85a97d-3863dad8743mr7140299f8f.32.1733839283633; 
 Tue, 10 Dec 2024 06:01:23 -0800 (PST)
Received: from localhost.localdomain (223.132.22.93.rev.sfr.net.
 [93.22.132.223]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862c611242sm12939627f8f.36.2024.12.10.06.01.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Dec 2024 06:01:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] dump/dump: Include missing 'exec/memory.h' header
Date: Tue, 10 Dec 2024 15:01:10 +0100
Message-ID: <20241210140112.43313-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210140112.43313-1-philmd@linaro.org>
References: <20241210140112.43313-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

dump.c calls address_space_read() which is declared
in "exec/memory.h". Include it explicitly to avoid
when refactoring unrelated headers:

  dump/dump.c:1892:13: error: call to undeclared function 'address_space_read'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   1892 |             address_space_read(&address_space_memory, addr,
        |             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 dump/dump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dump/dump.c b/dump/dump.c
index 45e84428aea..58c57d4e4f5 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -15,6 +15,7 @@
 #include "qemu/cutils.h"
 #include "elf.h"
 #include "qemu/bswap.h"
+#include "exec/memory.h"
 #include "exec/target_page.h"
 #include "monitor/monitor.h"
 #include "sysemu/dump.h"
-- 
2.45.2


