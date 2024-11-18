Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC9CD49219
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1Ba-0006Wv-Rw; Mon, 18 Nov 2024 07:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1BB-0004c0-3I
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:48:37 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1Az-0005Rs-56
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:48:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so34219485e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934085; x=1732538885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Imru/ZUlyc0vwa6lGwgvhqK0h2OrYCXvH3UhgPN1YaY=;
 b=ul6KecDMMCUlCu1h5BcA/gCzcaGqJc+zYcJvQvXUEynJjDj+tmybmzxhbMLkZhxVpU
 CAVaK4iflU2QmrSvMdqoEdzggZUiYT0EP9CJiPiu1kTah+aR9+tDG2dAWhIrG9HbQq3M
 YnDhXpsaTIBADwqoz2JcgeMGYnEP50GKTP/3pY9aJt2R1QsrL81Paiww2Fq2AjInlcVN
 wISgGA4kLzE8klHgeJEF7u80WMsRq+6VLt9Q4yej79b9pyEWoTxSQHUN+/540pt/uTlk
 TTiUPK2emhQhPYDNFsYKtv+uSmN5BiqBxlofdyb/t9fIPv4jjDrZZqAu7prlZus7FU5j
 0WkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934085; x=1732538885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Imru/ZUlyc0vwa6lGwgvhqK0h2OrYCXvH3UhgPN1YaY=;
 b=fQtcXqQ8tOyaV2uI02yq8xfJBjGkaB2skyMe7eK4gS9cWIDerMhfJIc8nJE8P8ssOP
 lJQ9LjhZzxmlQEiDHVfqp5WZbjYZwCvsuE/SUUodxnd8xBOmeULGMVOiPnIqJIs83GaU
 zZIs8gKpe804stHyPW+L0E3La0HxdRIGc8+VuPKT3bEhV7VuJwXEXn5KuLeiHCHbOkUs
 cA1Z+QxqXyzhvFti61spCiJTuxxCuV/C0htD9n1hrCskBHOYjL1kTaK+CZ7aEgSgxkAh
 5VTwW7Xv79Wpu3m37Fp3v7PsC8dijpMIXmO303q7x4aWeCtk7KTKED2OUhlmwCjV7OII
 RWcg==
X-Gm-Message-State: AOJu0YzhxXKzf34DSUyqTfT+9Ex6HYg/JIKdM384DOAxt8ZKw/MIc1jN
 iUD8YfrBzVHyWqzOsZJX/eJHBMvPbQEaT5mwlXZ1cvM9md8xJHt9S1MW/u1TuJzoM54bi7oH+97
 i
X-Google-Smtp-Source: AGHT+IEWCCUlyMcimPNU7anHnu8XpmnyGwClGKjSup9I94AA0iZGPXcqmIerMVh4OpiXovD0o1Q+YA==
X-Received: by 2002:a05:600c:1d90:b0:42c:a905:9384 with SMTP id
 5b1f17b1804b1-432df791f39mr93347075e9.20.1731934085128; 
 Mon, 18 Nov 2024 04:48:05 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab72141sm154245905e9.1.2024.11.18.04.48.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:48:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/15] net: mark struct ip_header as QEMU_PACKED
Date: Mon, 18 Nov 2024 13:46:41 +0100
Message-ID: <20241118124643.6958-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The ip_header is not actually guaranteed to be aligned. We attempt to
deal with this in some places such as net_checksum_calculate() by
using stw_be_p and so on to access the fields, but this is not
sufficient to be correct, because even accessing a byte member
within an unaligned struct is undefined behaviour. The clang
sanitizer will emit warnings like these if net_checksum_calculate()
is called:

     Stopping network: ../../net/checksum.c:106:9: runtime error: member access within misaligned address 0x556aad9b502e for type 'struct ip_header', which requires 4 byte alignment
    0x556aad9b502e: note: pointer points here
     34 56 08 00 45 00  01 48 a5 09 40 00 40 11  7c 8b 0a 00 02 0f 0a 00  02 02 00 44 00 43 01 34  19 56
                 ^
    SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../net/checksum.c:106:9 in
    ../../net/checksum.c:106:9: runtime error: load of misaligned address 0x556aad9b502e for type 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
    0x556aad9b502e: note: pointer points here
     34 56 08 00 45 00  01 48 a5 09 40 00 40 11  7c 8b 0a 00 02 0f 0a 00  02 02 00 44 00 43 01 34  19 56
                 ^

Fix this by marking the ip_header struct as QEMU_PACKED, so that
the compiler knows that it might be unaligned and will generate
the right code for accessing fields.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241114141619.806652-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/net/eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 3b80b6e07f..14c34f530f 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -56,7 +56,7 @@ struct ip_header {
     uint8_t  ip_p;           /* protocol */
     uint16_t ip_sum;         /* checksum */
     uint32_t ip_src, ip_dst; /* source and destination address */
-};
+} QEMU_PACKED;
 
 typedef struct tcp_header {
     uint16_t th_sport;          /* source port */
-- 
2.45.2


