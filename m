Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6398ED116EA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 18:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP36t-00031S-0s; Fri, 28 Nov 2025 13:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP36k-0002z9-7z
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:22:15 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP36h-0003A8-KK
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:22:13 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso11753015e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 10:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764354123; x=1764958923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esgdSOmxvxoM6dFXZTRW1Fb4sqxSg/3cnp175TBjiD8=;
 b=FARoRGXVly9U2u0fWqbwJJOXg3NfIJYKggCnVzqK3M0eIELLOWPGZDSvgXLirOOHIX
 Q6oThUbXWjS/C6ChkRnUZm/RdWTIP6VmOKmEDALhCpBGXAAjCyqqK3q/NWX8X46MYooj
 P37snoTdfuzXG7ULamCSdqe1ABpbNlBY8dOx9K3eFvbxH1edNwcpFt4xTI/xW+lIHHEq
 qHayo2l+3Sw59yjADRqEu4ab4l7dVqCM2AaJxomVYyQQ3c6QsVDqBncIl+aFrMq26To3
 gUtPF67oHAp9+ZrmhcrQ6ZbZ/tSRW0shyCWkqyGBwJnwcvnEmVghHMtMG+6RVB3bQyPa
 YvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764354123; x=1764958923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=esgdSOmxvxoM6dFXZTRW1Fb4sqxSg/3cnp175TBjiD8=;
 b=QKLrCUBggK4Dlaq9ruGKbWN3pPuI0w9xNJXw6MwgE8Q3wnT8ryIDABpIgbY7qi9WZw
 mhbvp+IwqBWZJfm0r0gjkwHDrk0Bs1n0lRUS00N+2UvJmUQxEb3vQLcmL8Xjp4XgCY90
 rzfXsfrrptKabiJHjYeyZRhEj4cXuL7Q5XBZxK/dEe//+NndaWPB8pbmHuAOUR8wCNKG
 hMIwcMP56bZtk70mNld6Kgb0nJDZLjqLxffJYyi5U8AjmDb1i/FgiBTMtlYRYmllbbka
 W4MkpmLdOzYmQdCCNSDfZt4xSpD8d0eGk8ZSceOMu3IZvzmR3oyUStDlqe1T+04j4Mt6
 O2Mg==
X-Gm-Message-State: AOJu0Yz8jvhI+1/exqkluI0HG78qoFdxd7ehYr0hqd99rQk47JK+V4+e
 4rcxaS4vz/bJQxrgxpbeo0uKQI6+2m1ko+qVzvbFTzd4Gu8ygDQpI9JnoWoD4vvc2rM=
X-Gm-Gg: ASbGncsW3xDxydIo3b+jxfOG7uMZmoy87E7AnUgalumJwH9QlvZo3P9z1rYdkXL1AG7
 n2P+d0YD0+yldX4ZG+5cyrlPvVP0K/dVugvNgE1C384mKWbkaFH2LKp35VfW8wFMqh+e1Vav14x
 rN7ATWDBjVSnId8UOa1AS8Vwnasn/pQ6VeTfbmQDA3i6If0W07x1CLHvYk2hswNWhClW5AGw30X
 3NCujD9MVT9w9KDRr8RjsDpPNPIHoHsMUKvOsgT8p0E/olXpYkr5+ipAGXB761/umuv3u4/9u3N
 zgxzHOn3a9m7rvcEc5jK0D+dP+b5mWT5eK6LabiuoiTAVBnuqyP4elbA3TmoyYSEjIMOZWZo+uL
 kS/hlHhC+CM2rZFTuU8kIZpxaca4iFol4X/FtpYnWfxQmiidaCwWXE0Mo38pfqjYZI5yiCDRQir
 Wwjk8ciVT23p8=
X-Google-Smtp-Source: AGHT+IEElwhQapHzhGkC4j6s5mIyKJ1Fs4Zxn7EqlQSunWLgsytllkXPRt2s+YweeXiXIXwic5P2dQ==
X-Received: by 2002:a05:600c:1f0f:b0:477:8b2e:aa7d with SMTP id
 5b1f17b1804b1-477c1132bf2mr293186825e9.30.1764354123161; 
 Fri, 28 Nov 2025 10:22:03 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d6277sm10790714f8f.17.2025.11.28.10.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 10:22:01 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3C47E5F901;
 Fri, 28 Nov 2025 18:21:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Ganz <neither@nut.email>
Subject: [PATCH 5/5] plugins/core: allow reading of registers during discon
 events
Date: Fri, 28 Nov 2025 18:21:57 +0000
Message-ID: <20251128182157.4125745-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128182157.4125745-1-alex.bennee@linaro.org>
References: <20251128182157.4125745-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

We have protections that prevent callbacks that didn't declare
themselves as wanting to access registers. However for discontinuities
the system state is fully rectified so they should always be able to
read the register values.

a1688bc86ce (plugins: add hooks for new discontinuity related callbacks)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Julian Ganz <neither@nut.email>
---
 plugins/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/core.c b/plugins/core.c
index 8f8bc7219c2..b4b783008f7 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -119,6 +119,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
     struct qemu_plugin_cb *cb, *next;
     uint64_t to = cpu->cc->get_pc(cpu);
 
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
     if (cpu->cpu_index < plugin.num_vcpus) {
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
@@ -127,6 +128,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
             func(cb->ctx->id, cpu->cpu_index, type, from, to);
         }
     }
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
 }
 
 /*
-- 
2.47.3


