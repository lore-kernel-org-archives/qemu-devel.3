Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EB9CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 07:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v77Dr-0001bY-1N; Fri, 10 Oct 2025 03:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77Dm-0001bE-Tn
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:23 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77Dg-0007wZ-Sn
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so10034345e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 00:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760080034; x=1760684834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qp4IO4MFNoh8safLEazorH+hzpRk3IlrvyISmNX81AI=;
 b=G698n+sZdTWJN5UXeRx1sMB9VG1i3JTUmeqhhbeK7ovEvVDkb+9Gwc8slJrRMzn2Ir
 4G0mRhbj9icZSH7Uh2vzg0G0w3MTNLPMZWAplyhIRG565k197xh9I8cRb/7USJ5yvi7X
 kXWP+R8iaeff27Dq18VrVHIrBKcjXJUtmIh67UQkRnexwOhsD/dsRBMIMvafrTEBjx3F
 RT7Ko9NncjVy7ITTgGB2VHpUIPij6KkcHH5vT2ULVxBk9EJ+G7nSZVVMjNv+t76UtwX1
 kXBYmu4V/D9v8k0qDgCoJ9HGk/+dYHbqUBtOPm3hb8MSQEEh4LW3drBLbXvOHD9QcaP0
 s8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760080034; x=1760684834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qp4IO4MFNoh8safLEazorH+hzpRk3IlrvyISmNX81AI=;
 b=M9XHBbPp52g/01CC88c7jNebdUxgag/c+2Suj9xrEmnnGYi0T02uEmL9EMWZnlceix
 N1Q4aw+ryErpt7wxrXMJvt44lhXrN3swe0DDYEOEVUaFUjFXLZ6zzJ4++VgOausqtwle
 U0qlEVmxxrZ/CGDl2l4QZlZ9o/iKgY+aAclXGutEwSGOX8+i79/yEuNrf7FIxkQzzOQD
 eGODdNb1CO1qDUj33FsRVBpw/GxVJOsw9NhkdAvBHTxbP+9JNUuJsfR9HzAbHHuGOSRu
 0Cn+m3u2J02rOr5XyHOUUVBVbx+OJnf0eCtrSaeADIjM9+ADTWJgQegfZClmgknmbD1I
 sgRQ==
X-Gm-Message-State: AOJu0Yyx2ZjEQjOnKNfFEOVDD0dUh4FdN19+g4YnS/hLUkSdAOJIWj1w
 AZkDZUQClL84ijA+ueBvkahUXX8PKa0nFG7kbzDiG5qmfQFr79XY3KOz8DfMmv7cBG25UBWKwOl
 z551Rgdxbvg==
X-Gm-Gg: ASbGncuJSLGiHrXXkYO7Z13LmhXSCbhAA0QiuLBRUax74zH5rPOtVti4WtLz4diebKA
 nrpe5xB3BDNILSghQMMZNJzjZVYZ0ZSYMNxhP9zl1+jcEbg+AhHAzjZaK4a3rQfQCkfjiiBK8Jb
 Nl77rfQQmQnkJW/Ge7lxcAOctKQNQGz/+LgAddqaWAJlVihSptL3kbM7vmtZrB1Sy8GO35AxuZ+
 c9rrZB3sY5QywvoLvxXI2CGcc/aSnGn8U0Rama0g7QfmdSLJiGtL6mn7aohBbf0B6nVUtR7shQQ
 VRuH5xfwWGwqh3WVLPBM19UOE36VfkKBmt6naTMP6kQ1kxqzcBfB/GXyDcG1yRhdewjvzUQStts
 tvHWEQQLR5brglQtuVqU1C/2QLGq6KpV6O2/2eZrEWOeb9YtJ5FH3T17DsvJSIuhHuxJzyd86Wb
 dSTmkPzBJiqjyZPcJzIEbuEg1r
X-Google-Smtp-Source: AGHT+IFn9BOwxrC0nGDtgMvTgEkZXqcgg4RsYESr/yLaNlqfF+kmIcJMmwmrUctq9qpf8cXyEDvyPw==
X-Received: by 2002:a05:600c:3e18:b0:46e:3c29:ce9d with SMTP id
 5b1f17b1804b1-46fa9b018d6mr71477555e9.32.1760080033920; 
 Fri, 10 Oct 2025 00:07:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49c3eeasm30036845e9.14.2025.10.10.00.07.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 00:07:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/13] target/openrisc: Do not use target_ulong for @mr in
 MTSPR helper
Date: Fri, 10 Oct 2025 09:06:50 +0200
Message-ID: <20251010070702.51484-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010070702.51484-1-philmd@linaro.org>
References: <20251010070702.51484-1-philmd@linaro.org>
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

OpenRISCTLBEntry::@mr field is a uint32_t type since its
introduction in commit 726fe045720 ("target-or32: Add MMU support").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/sys_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index b091a9c6685..ad59939db3b 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -45,7 +45,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     OpenRISCCPU *cpu = env_archcpu(env);
 #ifndef CONFIG_USER_ONLY
     CPUState *cs = env_cpu(env);
-    target_ulong mr;
+    uint32_t mr;
     int idx;
 #endif
 
-- 
2.51.0


