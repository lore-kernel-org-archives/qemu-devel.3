Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C4BE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 19:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tShZn-0004Nc-Cj; Tue, 31 Dec 2024 14:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZl-0004Jo-Gs
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:45 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZj-00084f-Ox
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:44 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436341f575fso106631785e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 11:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735672002; x=1736276802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0vE3lYtWkiDZCwAWAKMF4/xKoT2gUVX19Q6TmVZnmQ=;
 b=l4IPgLdp+q7o8Y2luIwvninXPVSBfAHETdPVyQAVEW9G2PfYxSEi/79IYVgmfu7423
 oZwcrTVq/d+kn+LPnD6l399gnyiVTj33Mau3vuQbWqPLjEsaA3OY+1SnTo2UmIQOdg1W
 nDfxyq2hgJKTf8UdDo97gA1G68vWgf8DR23KVLIk6cxYDBoaDnmZmUrykM5jOXhXRvMp
 QHONqrKYL9OOGATCi62jdt7skFwRSaxi1eeW4e5z8WvNgbPc2CaBpYot6PrU3pIi/MgR
 I9DOFUFRVczzDsT38BuoVvIO+/T7RGlLz7IYRmTNKlh07DpueyxyjWp7w2u04ov2lEa5
 +5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735672002; x=1736276802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0vE3lYtWkiDZCwAWAKMF4/xKoT2gUVX19Q6TmVZnmQ=;
 b=BpG9qjiAbFiMR83aYYyo2dqEps/Pzip8eDrSeuKFR2J7stddwqtWR19oc0BGEXQYmP
 aQ/GXPbg0HUSNozvfd4GOVqw14SPxrxWC8q/w4RHrj061Ng/P8xhes1ixzXpqhaEoU7D
 Z2YE3NdQLZ/OuVd3giGRC7Jo8Zo4KATmaXt+i7fOobZ2tD6q6DKO1pJDIp7Pj9NDZr9S
 CUBtAKJ+wW72piESWT5G7H49TosHJWY70C3IdUU37y/Mk48LClFJMda0vUQSqZLK1Z8i
 RxTBbyRUTNFoqmWhioju/8lTKyPjv6wGp+v8tHakNyz5v+8ulPZIlKEJDiUqiSCH9IH5
 RpNQ==
X-Gm-Message-State: AOJu0YxkvEeT2T9YaFyerx4BT5yo7O3ermw0xY3AjkB7NA6Wyikjxe78
 yqZwglK4kFpaj2KhKvfSnC9ifGX5Fw8ZhLVtDJ+JMnAeWYpu7NTBzh57e0bT/xz1QpAXe5+2ww8
 W3/4=
X-Gm-Gg: ASbGnctWnoL7Lz/kpkJU4J9wyqb6BjBAp1ZbfKNDWvz5NcsQcr64RBN5n2KIpQeEnie
 JUAU0O2gHRn2tiy0iuxYW3/0FAxiPpxqyVUJS8XDyvFTnEpn0b8LILtNcMpp6h0uLRJWji4y5OS
 LrpxdfK9zbJ48MgcXvHeE2D7pGYNYXWNzxY/FAZJTMUxxfMcGNeXeyvjKrbSlgt73yd4HvhZQhR
 TOJALYkhgU5IcUE7uUcsNodq6AweWvXd5LbnV4mqWMOftvl4/zbrYrGFsS7Q9CuCUELQyQNFZau
 +dv/LqEZ0UYssNynpgcpHxPO0sNUhr0=
X-Google-Smtp-Source: AGHT+IHd8c6XmQg80mc67aEZG/kBUeERJgGwlAUWj5chRYlGx5De6mufXscNrCmGd2Oe4OsIc3oFKA==
X-Received: by 2002:a05:600c:1550:b0:431:4f29:9539 with SMTP id
 5b1f17b1804b1-43668b5f892mr299410015e9.32.1735672001843; 
 Tue, 31 Dec 2024 11:06:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c515sm398879245e9.30.2024.12.31.11.06.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 11:06:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 4/6] target/hppa: Only set PSW 'M' bit on reset
Date: Tue, 31 Dec 2024 20:06:18 +0100
Message-ID: <20241231190620.24442-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231190620.24442-1-philmd@linaro.org>
References: <20241231190620.24442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On reset:

  "All PSW bits except the M bit is reset. The M bit is set."

Commit 1a19da0da44 ("target/hppa: Fill in hppa_cpu_do_interrupt /
hppa_cpu_exec_interrupt") inadvertently set the W bit at RESET,
remove it and set the M bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 41538d39d62..dbd46842841 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -209,7 +209,7 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
     memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
 
     cpu_hppa_loaded_fr0(env);
-    cpu_hppa_put_psw(env, PSW_W);
+    cpu_hppa_put_psw(env, PSW_M);
 }
 
 static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
-- 
2.47.1


