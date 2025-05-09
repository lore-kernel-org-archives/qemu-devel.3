Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CEEC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 11:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDLaA-0007Pz-Kz; Fri, 09 May 2025 07:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uDLa8-0007Kn-0H
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:07:56 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uDLa5-0000jJ-PB
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:07:55 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-ae727e87c26so1323187a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 04:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746788872; x=1747393672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=reqG+HnTLrWadGCjBmFMEasTPlhnHQqMim/E/FT6daU=;
 b=Q6fZ6QH3VEYCxtEdTAO5mLny7BPyTqLJ2oj05uVhB13/S8TqKzg5KCt6lJsJh1R9ED
 7eWCQL+PS7+IrEkhh/rXcouabK8hgvp+pUUknC2R9Lia6dN6OtljmGvBQEi7yEFh1KlF
 +k5FMzkB1epRj0nxNXVUhIRpew8spEjYlMfW+iFZ0J9RXODz9sDCn/ifdf4AvnRQXFbH
 99eCuOD3U+V67ZLIHtbTeppkg92ZnpB/ysCZoQBXn7+Hf3gtX2RBipEke8SGR81b+ABt
 8QEzeZjTsqCR6bcN9j75iU44sWayARO0bldFi1Cfa85dz0V+F90MnV7cWIdT/XNWJsHp
 OlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746788872; x=1747393672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=reqG+HnTLrWadGCjBmFMEasTPlhnHQqMim/E/FT6daU=;
 b=mAxiZMda8yIugaP/IJ5+iOHuK7QDGpLEVPcxvZLZQsnl5sAYoLEhmzvdWJV+LCPt9E
 +JEEmKoLIdXTHi9jPLTD4ni1vKb05j+HtzADmeHrd0lcBJXGcjLmlDPmlrNRSizNIaGR
 v8wqLUDDopdzFQD66c7CNkfjP2K0Zmx5DNHZsAZNPfkyatXmCXp+jktILJRJS1MFGc5t
 iec5sDTNs7J3Mv2TTb5F4HTCq9F7OJmVX6HhvHlajZXgFbnH9cTm/DXThs1WIbFUeO2+
 9/xE9D9hrkMCZFlwwm7n6MgrC7D6Migrl0cQgh0NySWq9HGqBzZu3CLfSKfFLz3qmGkg
 JCVw==
X-Gm-Message-State: AOJu0YxqUaIabwCcXsFZ+SHmtnzjKvSnYzNkzLbeOJtUg3FnaPeKqqr+
 /gl1ikeMw7d4ee+eFboUI8DzKWv67mn5zU05DcczsTWqG3lLju3LhWRd0PPkh3I8DJX2TB2YoC2
 2Ed4=
X-Gm-Gg: ASbGncuKzYFyy4ynKLBLDxTQ9NStiQm5DonKalgoMIYpKEpP5xAgMXxTyIBOFhDNrTz
 BZ48BFshGrzOsmHQYBVzzqQ57NGOvv5DTCAKZeeCVZV1bajlonuR9ZemuRN3T0g+S/N6hhSVwJh
 iuIQ2pbjW5m0Wfbuv5FMkufLB1xx2s55zBIF6HyzlXYC44C23w9Ps0+2zllPkoi3bvgh395DEiY
 V5jdep5UTfIlTv6CRBq6j9pp4W4SU3zewbZzHXHbX4EkJZ7n7bbAdfaU4/284puIaC0ypQGPdH5
 dvQh4JWP+y2bNqh/JmqyfZvKO/XwRlxgGRaCF8lI/5+mPf5li3xvA/4QmuOG8w8f8rg8L9oyNxJ
 8VCJqcrbw5eNh56I=
X-Google-Smtp-Source: AGHT+IGYbd9wt4dta+vIQu4BAd/UgszgxGHEhF0L2eVTJj7OGbiCMXYHfT1TcZbvFgGWZ+FeFwlkFA==
X-Received: by 2002:a17:902:d48a:b0:220:ca39:d453 with SMTP id
 d9443c01a7336-22fc8b6131amr48451375ad.17.1746788871856; 
 Fri, 09 May 2025 04:07:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82c338fsm14574985ad.259.2025.05.09.04.07.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 May 2025 04:07:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] semihosting/uaccess: Compile once
Date: Fri,  9 May 2025 13:07:20 +0200
Message-ID: <20250509110721.90447-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250509110721.90447-1-philmd@linaro.org>
References: <20250509110721.90447-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 semihosting/meson.build | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index f3d38dda91d..d0819891bc3 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -3,9 +3,7 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'syscalls.c',
 ))
 
-specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
-  'uaccess.c',
-))
+system_ss.add(when: 'CONFIG_TCG', if_true: files('uaccess.c'))
 
 common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
 user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
-- 
2.47.1


