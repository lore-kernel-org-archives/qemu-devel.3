Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2C8CCD194
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEF-0005hX-TA; Tue, 14 Oct 2025 09:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDr-0005ST-Ku
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDo-00013U-OC
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iA0bDEBxJgjEmhhlL5wXkh2D/VoTpIzJgtkxrAf3WUE=;
 b=Qn0EQO1Uul0YnKFOM0CzIE/vi/te9/EEHe03D72oOm8kRXaLnBqNTN8vD3Qc8z9mv56Nw5
 BNe8ygNqmUy9vKIoNvYPRCOY2eRcK7AE0CDbVYaVmIEvdxjIaYiTaO5NRSg+fsI1MeA0Ui
 /IELkDUXH5l/OH/OB8LDfG50wfHajCM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-WrITmq4bML-ACdWp-sraoA-1; Tue, 14 Oct 2025 09:37:45 -0400
X-MC-Unique: WrITmq4bML-ACdWp-sraoA-1
X-Mimecast-MFC-AGG-ID: WrITmq4bML-ACdWp-sraoA_1760449064
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e3a049abaso38646665e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449062; x=1761053862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iA0bDEBxJgjEmhhlL5wXkh2D/VoTpIzJgtkxrAf3WUE=;
 b=E/10Y3UclsrTPB48kpKaM6U+1j+f+Rc07Iwp7GtLQAgBo/frm/g4ZfIhmiOEfs8XqM
 QJfRD4fvOaCemgYbHJuUM80IXJ3SidaNUsk3euXM+yXKCRM/x8w9RTPrjMylTuRnTG3Q
 4UEjYx2dWhh1dxR1JfhBIPmi/yPSDFMrbAvxowiOelgbrVEzys++6+/t6FdE3o1WCSEd
 GN/mvPQ9cLEb63RQzeY5HMW7Dv9omWIgfhHZA/JyiRzC+EhLJTW7C2Frf70HjzrxLe8x
 eg1+c9pm+hlWb1I0O3UcfqZUfr7UqDQ5rUN1uncr84/LmeFb8BX4X+AFW9WPXYPgPwuk
 c4Dg==
X-Gm-Message-State: AOJu0Yz2wxZydGbnQvqhotGmEiHUvELD+OZfBaBf+qyzkuFYVCOBvQim
 nMuzmBRk3X2B178WPb753pFXBFaWDr2luoU2pJrD6bQ6EN4XZKB9xZMfTg14iEZ3q31kHWijnaL
 7ogfT5mkNU7epgztwVZfm6rKZTtElv+3kFsAgYY2mWxZwEBILs4Lzx8kZmCkdAdxSniDdTFjtzC
 ihMi4PEx4JNPa1eCBkF74j3SrpKtHGyuO1aQnZED21
X-Gm-Gg: ASbGncu6mZeyAF+Y9CrZkbJ8pfdaujmJ22qZvCnajjSYBwHj5HgyMIztGdjxh+Gumi5
 sa4uakdUvY6lr7mvUH5dY7CYbinGa1wV9sut6sbWPFs5ck3aoiIfqRygLdJoVkj+Kqh87lDBR64
 UqEPvlgD6tnRwmN+E7ohtmNvN7erjgPD5sxbSqsC+lWNRsS/IMTshkmqotSgg552Oorawo7pvJ/
 NC7Cb4IWQOeYNc6OgfhTjk3rURW27Hw/oH8J325UtkFgKV1jF8I0qhOvn4t25GCPbh2Z0UmuVWf
 VtJv8TDy9Csd0WBqn6PnJszX9ZFLj/7EyoA/hexHvc7Rl6xn5dpb8OHS+TIuf+FmKnVoKvBvD6S
 VSbJBcdM8nSBikRO2moDUn5O3Lb/Z9BAxzuRFQqkwhIA=
X-Received: by 2002:a05:600c:8b6a:b0:46f:b42e:ed88 with SMTP id
 5b1f17b1804b1-46fb42eee4fmr132671855e9.41.1760449062401; 
 Tue, 14 Oct 2025 06:37:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiyLGx/XOXKn7gRuHhlmN4j1M0MNnfyE1WU7UUmxZsiMQsjpqt43Gp8uHWcMVkis96pQUQVg==
X-Received: by 2002:a05:600c:8b6a:b0:46f:b42e:ed88 with SMTP id
 5b1f17b1804b1-46fb42eee4fmr132671605e9.41.1760449061913; 
 Tue, 14 Oct 2025 06:37:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb4989601sm236079775e9.9.2025.10.14.06.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Ogrisegg <tom-bugs-qemu@fnord.at>, qemu-stable@nongnu.org
Subject: [PULL 11/28] target/i386: fix x86_64 pushw op
Date: Tue, 14 Oct 2025 15:36:56 +0200
Message-ID: <20251014133713.1103695-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Ogrisegg <tom-bugs-qemu@fnord.at>

For x86_64 a 16 bit push op (pushw) of a memory address would generate
a 64 bit store on the stack instead of a 16 bit store.

For example:
        pushw (%rax)

behaves like
        pushq (%rax)

which is incorrect.

This patch fixes that.

Signed-off-by: Thomas Ogrisegg <tom-bugs-qemu@fnord.at>
Link: https://lore.kernel.org/r/20250715210307.GA1115@x1.fnord.at
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 51038657f0f..a50f57dbaab 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1541,7 +1541,7 @@ static void decode_group4_5(DisasContext *s, CPUX86State *env, X86OpEntry *entry
         [0x0b] = X86_OP_ENTRYr(CALLF_m, M,p),
         [0x0c] = X86_OP_ENTRYr(JMP_m,   E,f64,                         zextT0),
         [0x0d] = X86_OP_ENTRYr(JMPF_m,  M,p),
-        [0x0e] = X86_OP_ENTRYr(PUSH,    E,f64),
+        [0x0e] = X86_OP_ENTRYr(PUSH,    E,d64),
     };
 
     int w = (*b & 1);
-- 
2.51.0


