Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7F0D0C854
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcLS-00035n-O0; Tue, 13 Jan 2026 06:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLM-00032e-3L
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLI-0008Pn-DF
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768302823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5yk+7lehNHXmaDyA6TRaDnfLrvG1v0qyhVBj2t/x3e0=;
 b=FnM1mc4/Z3DG1FrIGBOGLWpNywT+Ke1bfXu6fu6Cm1P4GGqcZ9GGH5d4WRy0TbVGeuPGQW
 gwsR1lOmTUQbCU6iTEcj8D1afZv0o9ZGGvi5BZIUzs8kSnksbW47Cyk1Hy/yRienc4PnKW
 +zww93HW96TJJl+DRVr1hIPcXujWnL0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-9kbbLA5xMt6LfuUR5NGc_w-1; Tue, 13 Jan 2026 06:13:42 -0500
X-MC-Unique: 9kbbLA5xMt6LfuUR5NGc_w-1
X-Mimecast-MFC-AGG-ID: 9kbbLA5xMt6LfuUR5NGc_w_1768302821
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4792bd2c290so86164365e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768302820; x=1768907620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yk+7lehNHXmaDyA6TRaDnfLrvG1v0qyhVBj2t/x3e0=;
 b=kaMCr/OrftyUrypUsPIa3FOsLrqrdTCexA//FDffm0XPm+ZGt1EKP+DpacJOE2NyG4
 KIOshh5xI1mu1v9Brx2PUMJWovDzEX5HG5feLosYXDgep5F29rBYiknC4KZJtCX3zGYl
 8ASCTr7nsm7+inhASTdHX7FtqLOrDJ5OsaiDCBhjYHNBLr2GMPYVAktmL0dzFjl7FCRr
 IjgIoPS3/YVlmVshCUuicUvc0s+IYA90VyXsK65VK+8T1ZEGM18cst/Jb4PoL34GDYwj
 LVU6ENAA7EKYsMQKWKrc7ncttzvQmI72OjSNJFkTz0D+XoMc+1NUJyGuLUuOZV5k92iL
 ZgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768302820; x=1768907620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5yk+7lehNHXmaDyA6TRaDnfLrvG1v0qyhVBj2t/x3e0=;
 b=dGJwDsOGkkctFRCPsk2d4OHaAJqhl1hS51Y4mBkyi5wZ1w96CBUXsUi8c2jO65LR/e
 kgRVhdADbQPF7ULYd1FiiGGijbrelNO8Uc8Cj6SsmetbGo3lbX0/dptKmKxw74TMclkA
 dqWa5VZLIM+KpRzwbUpZRxOqun/Xvf9PMdPmHc5BHk23f9Bx6A6hNcMwGv+tjRf0kQuW
 QOOOhFfo8UX2RDgTitzOib/F0f/wNXu5Se+O86M1DUIzU7IlBiy26RXt0nvGuofzWrkq
 tTOKGZOcyd/VyVJVGw5Tt/kvhoFRnRJFRCLRMltlCwvMShC8DLlqwuBsWfBqMKhLIxqW
 IZcg==
X-Gm-Message-State: AOJu0Yw58JkSuZ3++/6Z0w08alopbw53mdPI63QKHq3a5GandTDj+mUL
 yAM5+HFIQikHe2BYyhsnwOiVl942TmjmnHJTGxQEVNEUWFl1jHzclGGlb6AZRWYKa1zUqNCr6Ht
 KzPjVNEiAiXdN7mimJuBuBIH6oejzqSyMu00eHsH8LgQ5odD3rLj2X08yg+5tsqn7V/x0XD92WS
 Jpq5VoyyBIi2icV+Kca16Suf1caaKjypXE2ryf7Cu/
X-Gm-Gg: AY/fxX4EHztVZuqWURk50WsEsHJXGmWJc0PlHOxs3xKIUR2ttl71cjSCxQiRZYRf2qK
 zG06DJLlpVPpHq5xW4PirwKSpUnl3l4l3+KZ9Plrnm/J8LEjkuxzD69vt9MvGfqsujFPWiqqe/H
 JVQJ8XeG7j7uiJTQHtC9M8pwEED2uVsrR4+g4V787NqBixhZQWukAO/lRsLK31zEsjdcJ0aQRPO
 f+SrpuEi+Z9tioC3B5Gg8Tc9nINk032kPbui3goMXduxvdQC6LCComLE0CWl7B2zJaY1ddz9hd1
 tPgAxpfIvyINBTYyZBrHI2IasQmpT0XjyEXgBgMPDvBViJN7L4IvXEbMhuXSIOJ938Xw9JgNTlY
 wCaQoI/SzWh5BFtCi/mGfvv0D1p06OGo5lQh8YL5G2qUIHmG+vuiD79/0L+aYSuFV/RSnTLk/x+
 WX20MbRiwSJtf59A==
X-Received: by 2002:a05:600c:8506:b0:477:9ce2:a0d8 with SMTP id
 5b1f17b1804b1-47d849bd201mr204796705e9.0.1768302820542; 
 Tue, 13 Jan 2026 03:13:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLCkwWY3sJY8VOKcBhBFJ7w8ldtb+BhmulQsxRbsWWK2uK+lOMFUMLH2fUudDP8qBSA7HJjA==
X-Received: by 2002:a05:600c:8506:b0:477:9ce2:a0d8 with SMTP id
 5b1f17b1804b1-47d849bd201mr204796385e9.0.1768302820156; 
 Tue, 13 Jan 2026 03:13:40 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184cbsm419522695e9.6.2026.01.13.03.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:13:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/7] target/i386/tcg: remove dead code
Date: Tue, 13 Jan 2026 12:13:28 +0100
Message-ID: <20260113111333.1138160-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113111333.1138160-1-pbonzini@redhat.com>
References: <20260113111333.1138160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Remove dead code; it arose when I noticed that, because 0x3? opcodes do
have a pop, case 0x32 works just fine as fcomp (even though 0x?2 is fcom):
there is no need to hack the op to 0x03.

Reported by Coverity as CID 1643922.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7c444d5006d..460848e4223 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2543,9 +2543,6 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 break;
             }
             break;
-            /* map to fcomp; op & 7 == 2 would not pop  */
-            op = 0x03;
-            /* fallthrough */
         case 0x00 ... 0x07: /* fxxx st, sti */
         case 0x22 ... 0x23: /* fcom2 and fcomp3, undocumented ops */
         case 0x32: /* fcomp5, undocumented op */
-- 
2.52.0


