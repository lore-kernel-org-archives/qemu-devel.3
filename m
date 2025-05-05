Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4D6C3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57F-0006UL-Sq; Mon, 05 May 2025 19:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57B-0006Qf-HQ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:49 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC578-0003dW-Pk
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:49 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af5085f7861so3449605a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487245; x=1747092045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3Dpv/gYklKxQ6NcaNjklM8os0pkN4N34WBJsdRDY08=;
 b=ixEZnfVw53pF0SZsRdQb5ASglf9OKH98h6OEgi92uN3/h31ibzRj65blbEnHp+mB8Q
 pyNwEauB4HfryhMxl8BgVc3CJN8iojh0llNPu4eCO1dnuU5hk0JiDEnCcenRP/kC7Jfv
 EFfYp8a0O57iE6qsvA2n13zHau3SyFh3ITsTqbzRplN4qNAIwnyNhiJvsfXeDXsFftq6
 XmX4csCQadiyeo11vh+SDxUg6hZCNbQKUdKJAIKstkRafCu5MYTXOsdJv9lYK6HeTV+4
 E2lW2DsmeEHvjZ2gjij2wqxZw7r/vQCfkkro0vP1bJClzgzVra5grDH4yalDFSHdZpdG
 ga9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487245; x=1747092045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3Dpv/gYklKxQ6NcaNjklM8os0pkN4N34WBJsdRDY08=;
 b=ZKb3k0QjpKcbnk/e7+Zm0BX7aKELgov83Wm+6jaC3hVjTfb7Z4QL4+ooxJHUV937kn
 ArdR+pdKlJ4H6vb2kOxrXDbQWlY2PEvcNl5CMhkD4pqyQWGJhcKQCxOV/cb8qrOvxCNj
 f10EeE2TDutc6Z1qTpzfOQZzESyEu2B/Jruumo4PGfHtQ50LdJuEShvnuiiqTN31TzGK
 O4PD/vC2f5w69bD8+SngRMSTRL1sGOKuoqTdn0dsfWmSq+BqpTV5khAH002PQe7oD4He
 0NK7yn+RaM08E5oPTf744NRbiZBmO/nynop2fJ3QLDq0NQIUgSDHy4RjU3i3kuLXEj4S
 86Zg==
X-Gm-Message-State: AOJu0YybmuTNSOE2T+I+RkRAa7JtOoFRDSV40B+6mcW4SHpxOJSfn44Q
 xKPH7mSNa5XT376o/9lXoH1v6FVxfPOrnNTxWWgimPQQHFAXuhku7vRWXwHNVbqnP4JMcpRPna/
 uMJ8=
X-Gm-Gg: ASbGncvhdxt5aKe+vlRQM4kWP5u0chNZVzwNxPuIQJ6Oozv+7R8tomfu5cFnhfikWXj
 zEwtCnS6oVJiKD6Vv/7S9b53C/5HOmH/z5SUm9GUPnqWmG6cT/jmgrJe/mkyjUcoEfm+O9/S4pc
 1OuaZGjIe8jG7KoyyZ3yUsKzx6zY+Gt/wwW/JUK7/y5zE/r9m1YOKewKq6rqct7d0RVhXsxWwTC
 dIjzKKBbBmqDZJ2TdBRYuLvvVQXGp7kraq+i+/isQYQHqpCo1GM/spukziZ9bP4NLqF3NyTiCTs
 ooeqyEzc4Ciw3XAzNUIsVoLkQ8Gp7KBp3KTW71TzVpRrAp8seFA=
X-Google-Smtp-Source: AGHT+IFWk5AXwcjBNUYuo0qo4bKVRD9ScvDTBj0++wYSaqbR7Xj3yAofodCIxA1kzM4MSYlJ50aRUA==
X-Received: by 2002:a17:902:db0e:b0:224:1c95:451e with SMTP id
 d9443c01a7336-22e32eff604mr17816945ad.33.1746487245422; 
 Mon, 05 May 2025 16:20:45 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 28/50] target/arm/arch_dump: compile file once (system)
Date: Mon,  5 May 2025 16:19:53 -0700
Message-ID: <20250505232015.130990-29-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 06d479570e2..95a2b077dd6 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arch_dump.c',
   'arm-powerctl.c',
   'arm-qmp-cmds.c',
   'cortex-regs.c',
@@ -38,6 +37,7 @@ arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
+  'arch_dump.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


