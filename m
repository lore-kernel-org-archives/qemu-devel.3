Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F072C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JLt-00014A-Sp; Tue, 22 Apr 2025 15:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLZ-0000JB-Kg
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:57 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLX-0006bq-Qr
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-227cf12df27so2441545ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350314; x=1745955114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xdo84E1iLP/XqDwQy8oaphr3JsZ2BPpRKXEovDmduLc=;
 b=oXBfAYW8UITWP4AQQNeoBKHZ1EAnfHRXxVYmGoBYRisAd+qIiSJUxBJdr9NRDM9nRx
 3HG+fTVurrbIXGXlIk/u6sfyrLUsiRIBzqaj5UMFgobI6FyBFlQBVp+L7QiKa5jEGKX3
 KvN1tM1qmcvU2v8fsJVeRiGUMazlDEtcnkgLMkriDXIyv3J9agrZrP9YojEhRhX/ZP4D
 yIg64AIVxYG7Ub4XfY8h0Q9NDoqJG2kmCVKWEuseIxc/uve2vyNS85to8kb77gwNZhM6
 gAspCiE+NX8gW0TNLYZbvADuneTLuilPaf09/Z2yKVc2IRo2l0W7cI5EBTFJMUQbtqn5
 AyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350314; x=1745955114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xdo84E1iLP/XqDwQy8oaphr3JsZ2BPpRKXEovDmduLc=;
 b=jWg6XQ1/LuKT4sFStSxArCL6Bh9Oly9b6JE6K7cW5PQLly4sbH2NmWSxbpiPhqCTi/
 jcGB9fYYArPWq0su4x2UsQf4U7TnjMGjW7XpAJLRz5BQWA52bPsVWqEq289BBycziCuJ
 xj4+RJ5Qo59l3IxhiR8Km1fz6Nj0Vuhuutp4pwGCx4bWCZLgZA8Ov4D47rhPri2B09la
 iod4o/B1wiFsgtGFSvoaylnO3FxIWI1rVKPzSINli3Rw09Hp+xSneIfSwFlhP0BOS+ga
 c/brII4wqXMic3FyE84HERtT8QlayhMIPZ+NDRte6qsJD6lgx2MFaHOPrTmJ5IZ5lLQH
 ALnw==
X-Gm-Message-State: AOJu0YyncutulB+EMyZhM0hkeXMseTKuqudXJ22ebTTD/Z2punOdygbQ
 /zgSDlj9IOgH6yXhTmGEsAspu2iZKV2VbSOHNd+VIdQ1U16ugSPvHZ8s/Hv0KN0/62U6EuEgeQS
 s
X-Gm-Gg: ASbGncu054UPuOwcKU/vF0xN3h+WBKhZF0ER6GRO2k/CJgYaxdRF5TPwnd5sasiMt+z
 73nhKI1GLNvUVXd10cpPl57aeTcBnFbD2awU/K51Bu6XsySzjDxvf/H3awWg0h7d418Fa/A0lN9
 9Po24Lh1qFgSVsivVpZiTYbbTQfUt4ddyrGKuApA4gvuI+JkfZyVtee/3PjfzAUhpSfdHfAyDF6
 v46AjQ4Bnjx+NZqIRJ2LoSr5LBKjfZJTyms1s2r6d9LpzBpTNidaYd/ScfS5lATAJ7sHYCYxVVg
 iS4VYIte2WudWsgYPZDNtMrIHKbw8c4Gft3A/OqwqLCHAyI6a3PdrhQ2etpaSoYLCMjiwQwY118
 =
X-Google-Smtp-Source: AGHT+IFlnhGb/NDU2Um5UPBIeP5jr+vj4mpyY7ZgCmu/Sgh4mkkRS6LFQJw18TE2a8CqdfyQo9ImHQ==
X-Received: by 2002:a17:902:d485:b0:221:89e6:ccb6 with SMTP id
 d9443c01a7336-22da33725f2mr2888635ad.25.1745350314052; 
 Tue, 22 Apr 2025 12:31:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 050/147] system: Move most files to libsystem_ss
Date: Tue, 22 Apr 2025 12:26:39 -0700
Message-ID: <20250422192819.302784-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Some of the headers used require CONFIG_USER_ONLY.
Do not move vl.c, because it has other include dependencies
that are present in system_ss.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/meson.build | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/system/meson.build b/system/meson.build
index 063301c3ad..c2f0082766 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -4,6 +4,10 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
 )])
 
 system_ss.add(files(
+  'vl.c',
+), sdl, libpmem, libdaxctl)
+
+libsystem_ss.add(files(
   'balloon.c',
   'bootdevice.c',
   'cpus.c',
@@ -23,9 +27,8 @@ system_ss.add(files(
   'runstate-hmp-cmds.c',
   'runstate.c',
   'tpm-hmp-cmds.c',
-  'vl.c',
   'watchpoint.c',
-), sdl, libpmem, libdaxctl)
+))
 
 if have_tpm
   system_ss.add(files('tpm.c'))
-- 
2.43.0


