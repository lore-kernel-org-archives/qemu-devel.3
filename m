Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4032BEE6452
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodiC-000197-V9; Thu, 12 Sep 2024 02:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodi1-0000lF-2t
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhz-0003Vl-7p
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-374c7e64b60so404020f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726124017; x=1726728817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jtNJDIJpUDW0bpRhizb3Cf8FodNOF9sdbTjBD++YWOI=;
 b=OOBjTxjRedfsg000zdCcywmC7wd+EohaoAPOteRVous/V4/87O7p9R9Y1rOP+iEF7/
 c+UrWcLX6evU6ft4k5xwe9suskHomuyhqlGsDv85tBueVXSC+yN145a/D0Bqx4nmJReT
 Jv1HTkw5Tj+qGskA+sK4SbiPCgdif3ljEDwb7QjnQRAzLbKie2rumMALzuV7R/ruV9HZ
 nQbQ7hofEpnY5tzRou5alk8GJCuPHKkq0g9Nxh1FJ82vZfvFAvSZOeB7Eq7oUJumBA5v
 B6lwER1gHRc4PHoSWfcr+eCXrH8KA6U3+CImgVLAl623nis6/P/QYIvP+Q3jPX/tul5D
 pMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726124017; x=1726728817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtNJDIJpUDW0bpRhizb3Cf8FodNOF9sdbTjBD++YWOI=;
 b=s5QfuWYy2m9Sa3YKW5OX3+4Yik0i1tAqPtzDQdYuUMBAaenb70AruHhuiiQ3DiU6GS
 mh3v1NcLIWIMy9p1V0CJyjIxhSAcI27+vfllBXpIlo41HTnyw8TbnacJzpu8hGXJYaFs
 68VpxxPV1XYsXhnmx0v0SX17o8cy5QYhnGo/d6qwAl06VksrWtUEd++USQ9DgJpBW+Li
 aBZIAm2iJM5VVRshn0JPXFZqVEnWiyl0Kh2yJbncrPXShqE9RUNXVU4EUBvhbj0MIZup
 9KuX7ZnC0fFS4v2DpLOspW7PPrnPnMcWN764K1QUYWNCdKA/nIdZ35lbfsUgyMgLe0NJ
 tUjg==
X-Gm-Message-State: AOJu0YwG8n+ZtrfugcQQKEWgvM0S2MFrmlyfWK4XMAGuIHbgfg0KH2Y3
 EErRhkOoi5jVgWqWONHJ9gnwqv09OZ9tZ5xwbeKEliN0bONBk5TGVnCWvIoE9kj3tcmAvKxvsid
 z
X-Google-Smtp-Source: AGHT+IGD98+6TkdrYZ0rUSNXLKOQzXDu2+sfauEnwsSqE7d4Jja2CrdaY3tQCZ3s/uXPo2nNXMDX3w==
X-Received: by 2002:a05:6000:ac4:b0:366:ee9b:847 with SMTP id
 ffacd0b85a97d-378c2d05d7emr900018f8f.14.1726124017186; 
 Wed, 11 Sep 2024 23:53:37 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956653f9sm13440159f8f.31.2024.09.11.23.53.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:53:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 57/61] system: replace assert(0) with g_assert_not_reached()
Date: Thu, 12 Sep 2024 08:52:26 +0200
Message-ID: <20240912065227.67848-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
References: <20240912065227.67848-1-philmd@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Use of assert(false) can trip spurious control flow warnings from
some versions of GCC (i.e. using -fsanitize=thread with gcc-12):

  error: control reaches end of non-void function [-Werror=return-type]
        default:
            assert(0);
      | }
      | ^

Solve that by unifying the code base on g_assert_not_reached() instead.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-11-pierrick.bouvier@linaro.org>
[PMD: Add description suggested by Eric Blake]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/rtc.c b/system/rtc.c
index dc44576686..216d2aee3a 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -62,7 +62,7 @@ static time_t qemu_ref_timedate(QEMUClockType clock)
         }
         break;
     default:
-        assert(0);
+        g_assert_not_reached();
     }
     return value;
 }
-- 
2.45.2


