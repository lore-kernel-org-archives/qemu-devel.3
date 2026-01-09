Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD0CD232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve65o-00020e-Vm; Fri, 09 Jan 2026 01:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve65k-0001zb-Vx
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:35:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve65j-0007N0-7O
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:35:24 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so42376655e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767940521; x=1768545321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQ54xeTTUwy0II+XoXo3E3Wu99SLAlkeuwkAgFVFUYo=;
 b=lhEq3zTw9FgUU243fL/cqZRr852mudNITbnurmkT0pt5hfWA5iK/OmoXEp44TCnXmE
 W7BT/AoAmSTAxhPNn1qcQIWY47cnV8gW46XIQxuYHD2lJN5DMiAlgvMXGHPo0nPEC+lb
 Pyb4CcAF1VCm+omA5IvjX/yN8Ohkm7IKU4VzvOFCFrlyQZTZ/0WZZ4JLaEjl/eNuCwl3
 yvKHAeE/3rhTcY7DZJFGkunPxy0qTH++CFyV8DXMshzzCRdx8cwtEa7PaCpNyTsECyqi
 cb0EBf/bmLdCya4jnuLPqDXYo5ChEktJc9R4zY3G2eU+TRWv9oumDl9jltJp+Mu+YivP
 1sEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767940521; x=1768545321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SQ54xeTTUwy0II+XoXo3E3Wu99SLAlkeuwkAgFVFUYo=;
 b=vrbHX7qTasvhVRw/9ZjmTTRbhxAO9c8hJUTNck4FIdu8CDsT7OeIYZssXof0qKMhPx
 pp4BH7t+XwuPDNVG/s/ZNOrEW8Z/++MKexif5EdJwYGpCY3NvuLXUzsFATxn1ERLg2mi
 d8JuqCVU5I3aJQ+pv1oSswKmHFN+NXvU1ccZagWJXXPPK1oaNQBm1INOBTjeUnFVCmcA
 neLlw+FZ7rZ2Zb+/s4oHLJ3ogbwToeq4hFvC6o6qcmp1ub9GCApzMhhb96eIRk7pzuMK
 F8md0hO7fXEchNh/RM+mgta5Ri5+z1l5g3KEuhUSC3UQTwF4fPu9OJq6trsr0kCTWeo0
 e34Q==
X-Gm-Message-State: AOJu0Ywl21KjdTN7UrEnSk7awoExuQZRSzFlbEMPp0dqMpJUS0eRArm6
 KvLbnVkXeZiJ03X+f53VEYSi1uMgdKsZdzr6WEMlyctyJGYW0PG5jXX2/tkvZ1PbmLvezM44IPR
 GTI9VSzI=
X-Gm-Gg: AY/fxX7JSYBAy5Mij4zrYR4BC3MfYGQ6k+M30sifqHxakDRKu2iR4pjuJ6sth0W6/Yu
 iWMFACo54jzjJUZpXhP3cDhqRzYUHYDfoKzcEeY4we9Zy04A2llYkY6cgAq3DNhggGACGF5eHu3
 yWyarjgup5RpHVm3AwBLppLCjftsvEnlH4tW3FL72w91/CT4YGcwxmKRVRzAd3qxxpI05XuO4ub
 tPLNYGAi6hckrEeCEje6EsuFJsml2QPhaEHsyKdzO1fOwD6RniX8PBeM4c+sEvKfDCFjCLb90Z/
 /RhLlJPf82Vr5IwBnfM2fFmz6Z3R9f6z8V1a9BbSI24e9t2gYdwkQoU366QevRBGghi7UKFTxhN
 rr7taLRTX0jKdiu2wagvJkjcL+kUd4k833yAZ8CifH7+krXu2+EF2TA3C/H8f1mlRtHMcqdLPf+
 ABY31yY/LjnqBVBVlLqXlAqpxSY7+RypSEZqkg5DM+Adnq/IPd1bVWE8z8xAa1
X-Google-Smtp-Source: AGHT+IGeZ/56Kw0pYVv8+CnEg/77ax55wBWg9bL/NuFDuvt1iPfufw8e5f5Vblw9CSOVruXL3ibjCQ==
X-Received: by 2002:a05:600c:1e85:b0:471:13dd:bae7 with SMTP id
 5b1f17b1804b1-47d84b38604mr106952265e9.30.1767940521304; 
 Thu, 08 Jan 2026 22:35:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f390a69sm189717435e9.0.2026.01.08.22.35.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jan 2026 22:35:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/4] docs/devel/loads-stores: Fix ld/stn_*_p() regexp
Date: Fri,  9 Jan 2026 07:35:02 +0100
Message-ID: <20260109063504.71576-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109063504.71576-1-philmd@linaro.org>
References: <20260109063504.71576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Fixes: afa4f6653dc ("bswap: Add stn_*_p() and ldn_*_p() functions")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/loads-stores.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index fc78def0612..3582814c580 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -52,12 +52,12 @@ files which are built per-target.
 
 There are also functions which take the size as an argument:
 
-load: ``ldn{endian}_p(ptr, sz)``
+load: ``ldn_{endian}_p(ptr, sz)``
 
 which performs an unsigned load of ``sz`` bytes from ``ptr``
 as an ``{endian}`` order value and returns it in a uint64_t.
 
-store: ``stn{endian}_p(ptr, sz, val)``
+store: ``stn_{endian}_p(ptr, sz, val)``
 
 which stores ``val`` to ``ptr`` as an ``{endian}`` order value
 of size ``sz`` bytes.
@@ -67,8 +67,8 @@ Regexes for git grep -G:
  - ``\<ld[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
  - ``\<st[bwlq]\(_[hbl]e\)\?_p\>``
  - ``\<st24\(_[hbl]e\)\?_p\>``
- - ``\<ldn_\([hbl]e\)\?_p\>``
- - ``\<stn_\([hbl]e\)\?_p\>``
+ - ``\<ldn\(_[hbl]e\)\?_p\>``
+ - ``\<stn\(_[hbl]e\)\?_p\>``
 
 ``cpu_{ld,st}*_mmu``
 ~~~~~~~~~~~~~~~~~~~~
-- 
2.52.0


