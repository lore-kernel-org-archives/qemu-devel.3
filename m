Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAB6C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcNT-0000W5-KB; Thu, 15 May 2025 13:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcNA-0000Bg-OF
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:57 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcN5-00027n-QY
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:54 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-741b3e37a1eso1432910b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747330070; x=1747934870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ojs5C/HJLX1uGWQpBATdc+qvG3d9Q0HejjDzFBL3jg=;
 b=uLG6GfnjlkAocwlyXKcZ+QFIldqd29TWCUx2m/L2o40UTEmGgqxlUQsfupo2Ss6vTA
 Tr5HXKW12r4dDx1nqhIwQiBXgl8CSw3tepYKj41CXQukUWVkA0A6wwt99m+D1NOjyNeY
 QJyCi8mWDJbe41tbYfZTChhf3NKPYoMCoZu6E93XKnWS4zx2xAuKu80gHQZeUpbajmp9
 N40GM/kl9R7WoLx5tQqQ1JaPt8YyJZ/A4l0Njdj4NxCqp6KCLgJ7Qi/tYMDBH+aUw09d
 aJndFGyRvCdb8HSqCVhdbY5V1A3VAT4ZAujjjb0OJXL1Q5pXYpk+F1YfQ/4z4sErDweE
 ldRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747330070; x=1747934870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Ojs5C/HJLX1uGWQpBATdc+qvG3d9Q0HejjDzFBL3jg=;
 b=m2sbNk9eEDo+oVCOHXJrvXj9MyVO1sfhSEbMPij2A8HWmK279WCJLbfFKRUoaLcXX4
 OIHNPgEskfYKieP5znwyqsLUnB+Rp3La6Qnrx3BFBIZ8ezcWrfJI/lmbvmfvG83HdKTS
 hQxfuGC0RiU8b5bCkIDHkRLvwquBMhKah03TxQH1wc/oT1+PsJW7OdFQyVEd6PPnH0SW
 cjilZp5OQg3xZ0Z5qc1McIvAw8Z0x1WWdHhK3gbkzugrMDxtrFmWZkgS4bDlJoAZVQQT
 iszIzPjnaWM6BobfIGW7h9UcoNy1ciUoudIgiR73H7WnkWppVoBZFe1Kf4BMC5RhpLVn
 c84g==
X-Gm-Message-State: AOJu0Yx/3d312k/qb7P8zB8e4ipKA3tovtcRhNlhDoO29tJs+4Vcc1D/
 MeIQ6IF2O2iO1ejoki3SLnV26AJyNT6RmgeY+qgzuRurk2ukAUVZ6YAERhnVhTFnIyrc9CZTwBa
 o6/Yf
X-Gm-Gg: ASbGnctiryh1nq3Qe8RGYX9XSIDC7SwjgdEfZeW2rNJ7DnGOFWlCmWqY2zX/1okdyOB
 GVampgH8EgJbU0gE22LGez+3neVR6+/ZW4w6u3AZPRPM0etX0THjy4r8S/TsMe01p1fGI2JFcVA
 /lkplxj00daQIaETU0Zu+t6SwoxMFROY+5my+iSnJwSDn5SO9U90BgnceJHA3PB9/39YjXbhK/U
 /E76CSfbGGlRIdKcLEndWJJrFMGjkCzS5zV71InbYISm8SWHrafa0JFlSXCUzcTn17V1pj2lGFy
 MWCbbjtsVk5PajpVuX/7qma2zcWkZb292DmTjQBSGNXXI6CrbjNkps1JDNDPCg==
X-Google-Smtp-Source: AGHT+IGQ8OXe9xZV1/kYL3AUPoBlJ3ORUa6zrwfPm0FNzjKDvXpHgEUpUvhCD/6k0bK25/pRxA3K1w==
X-Received: by 2002:a05:6a00:9186:b0:742:4770:bfbb with SMTP id
 d2e1a72fcca58-742a98a3213mr266688b3a.18.1747330070291; 
 Thu, 15 May 2025 10:27:50 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96dfa9dsm79730b3a.10.2025.05.15.10.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 10:27:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 12/12] qapi: make all generated files common
Date: Thu, 15 May 2025 10:27:32 -0700
Message-ID: <20250515172732.3992504-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index 7582c2b5bcf..6cc3afce721 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -140,6 +140,6 @@ foreach output : qapi_nonmodule_outputs
   if output.endswith('.trace-events')
     qapi_trace_events += qapi_files[i]
   endif
-  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
+  system_ss.add(if_true: qapi_files[i])
   i = i + 1
 endforeach
-- 
2.47.2


