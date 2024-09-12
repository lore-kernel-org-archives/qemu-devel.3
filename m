Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56499EE6451
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodhk-0007X2-Qg; Thu, 12 Sep 2024 02:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhe-00078h-Ot
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhd-0003Tl-51
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cde6b5094so3337575e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726123995; x=1726728795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CgFUNHEs52jLsHHSU5YLFjyTmIMNSfp3u0OOxY3dyBs=;
 b=iFHcYUeFWMfxm8Lrvr83A9DQOl4TIW1jzGERRCNxE3or2PV7L675SYnnrWN+lpM5oy
 ZvcvugUSEJgFzBmRofubOQZ+NxaR34PtGAQnrgEb7tfAGQu+ohME34PJ3ojuNhVMGp3o
 HSOzVInmMW3zPkfKrl8jQgicpuDVJiC58Fkgp5FIz7j7UAJUpQgHHPmUKpW7bEJyTlrP
 Lymf3qpAqCMlX4noJIi/ClAHF//RxWSxL2ftdcTPgy4SdLEN82+9jxgEpKEzPXDBZUXH
 NIFpqH0qYe+S9c3ieRMNz1ZulxZIF+QixlUs2oMcY1ygrDE2rw0051VPAS4zmkugTfO8
 sq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726123995; x=1726728795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CgFUNHEs52jLsHHSU5YLFjyTmIMNSfp3u0OOxY3dyBs=;
 b=LdpceVzOyNt9FaSXgLYIsOkGe1ksQBVSvS4jg5EQJmUYtEk0YoYQeSIzus4NssAqSS
 oQjUiLJ2gdbWrLER8NVSmxg+mtc9icYTl+S1E+zOakl0G7g9a4eerIutH9vaNt7hyQTo
 4SeYdHudG9RIcckMa53tNaaXiQ21N/PocynmnF3aYkWVxc8BefdDdgyTo3wRQFQ8M8Ll
 59M89tjy0jAi6ACTJlHLQ3bHRbKZqbDKS1DnElJ9XN8TcQk9vxSxVIV4L0hv8Z3bK4J/
 lpVMFHRD6nBGxytEBQP2kmf6Wl9SVZbZWKl0w4kNsoa+ALRTKsn8UEa3PhZBQQWYBENC
 UH+A==
X-Gm-Message-State: AOJu0YxLdm5yzveRSh7SEWTTaZ3mwQXaF46uJnfmA1LgcdqwT/lEti52
 0nmXabjr+TrlIoHwK0UgH7pACZsU56M0ab/XhhcuKXxHmWMtzcRCDzB9AQoUNX04VEchSQnCr1k
 i
X-Google-Smtp-Source: AGHT+IG6KFnpvcmHCUORhHVyEP+YT/oUOjOwMrAxNQEYpzPT0LGJEcx7hPolPmZ6xp/TZ/bfFFJeGw==
X-Received: by 2002:a05:600c:45cf:b0:42c:bdb0:c61e with SMTP id
 5b1f17b1804b1-42cdb547f05mr13201675e9.13.1726123995352; 
 Wed, 11 Sep 2024 23:53:15 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb21cdfsm161707405e9.10.2024.09.11.23.53.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:53:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 53/61] hw/watchdog: replace assert(0) with
 g_assert_not_reached()
Date: Thu, 12 Sep 2024 08:52:22 +0200
Message-ID: <20240912065227.67848-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
References: <20240912065227.67848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Message-ID: <20240910221606.1817478-8-pierrick.bouvier@linaro.org>
[PMD: Add description suggested by Eric Blake]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/watchdog/watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 955046161b..d0ce3c4ac5 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -85,7 +85,7 @@ void watchdog_perform_action(void)
         break;
 
     default:
-        assert(0);
+        g_assert_not_reached();
     }
 }
 
-- 
2.45.2


