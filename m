Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F89C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 11:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSx8S-0005dk-4q; Sun, 14 Jul 2024 07:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx8P-0005Rl-15
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx8N-00028l-Jw
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720955475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h1MZ+bkr2S4w1UHUKLxqB+jeJD0WXRw8G5s2UmrXHqY=;
 b=bnFXzFFgYPNQAESV8YVyUKjHaGNUPhagIDTjFUikcV0wPp1KqhUh8727ubMgPgI2bYQVX+
 9hb2zmfRMOiwIec4hXsXwJ9yubqFI1RsVcGDFPyVdmLftCJfNc12qGWiaa6WZNeLkLCbCY
 B3FAQuHtUbUprBCakbtGpOusdQZELcU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-2Am5PLzNOCmKVLzTFKRlFQ-1; Sun, 14 Jul 2024 07:11:12 -0400
X-MC-Unique: 2Am5PLzNOCmKVLzTFKRlFQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3678e549a1eso1778246f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 04:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720955470; x=1721560270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1MZ+bkr2S4w1UHUKLxqB+jeJD0WXRw8G5s2UmrXHqY=;
 b=S0NXfe2lafNDIrxd64X0NecYOaOxIzcDsjq2E0c/Iyn629FTNj1eolAHWrB4uIJOW0
 vsNwA/atRY3QJ3I8zYDFc9PphmYLC3p9iJ4fh7KhKj9d8aNK1jr7LXw1HRRq4Yc/MfSd
 BBxrDo1BvjquGiZBaMb+dt0NqRnlb8+86J9rHbmW5pvT/57Opp/Q/srdaCVqXRRhUHda
 vbeHmNDhtEh2MZ0NfyDqribvObYzc10mCr7twEjMn3SHNOru86GcGl/WilgwSzWL6iah
 xhmZHYcxmAGHpE1QAsfbs0aLmw9PMg11hTUmneqqsIrcswFyAB8Zqs7p+/Vk2XmOrZNu
 XDCg==
X-Gm-Message-State: AOJu0Yy4kspljz1cKTQTxsW/lumaC4Ee7G87k9lL9FAt2uczZ5nA0mzS
 1L/8Yq6T5ayClPWuksc7kmj4Suu3C8JlOEKl/L2T7FMLH0YixlO44/hY/HD687ik9WJ5P6nG3pi
 60ngwFo/8myze6Bu+BKhvjU8cBRmBwEUoajpevnfNb3uPxh0NjCOe0b9Lz5IOFVBgevdejWbqZ+
 8S4WuFTe5rHWXjvWqx+DkVGVysEsBznMmOMmIZ
X-Received: by 2002:a5d:61cb:0:b0:368:4c5:1697 with SMTP id
 ffacd0b85a97d-36804fec68amr4152891f8f.36.1720955470192; 
 Sun, 14 Jul 2024 04:11:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWfJpnWBr9IiXDeAClNnjM7WB+R+NZ6Au0q0kiBiLn8Sa9ntWWTzUVyiCuJWwDccZCjKS7LA==
X-Received: by 2002:a5d:61cb:0:b0:368:4c5:1697 with SMTP id
 ffacd0b85a97d-36804fec68amr4152884f8f.36.1720955469892; 
 Sun, 14 Jul 2024 04:11:09 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb991sm3629295f8f.79.2024.07.14.04.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 04:11:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/13] target/i386/tcg: check for correct busy state before
 switching to a new task
Date: Sun, 14 Jul 2024 13:10:39 +0200
Message-ID: <20240714111043.14132-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714111043.14132-1-pbonzini@redhat.com>
References: <20240714111043.14132-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This step is listed in the Intel manual: "Checks that the new task is available
(call, jump, exception, or interrupt) or busy (IRET return)".

The AMD manual lists the same operation under the "Preventing recursion"
paragraph of "12.3.4 Nesting Tasks", though it is not clear if the processor
checks the busy bit in the IRET case.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 809ee3d9833..0242f9d8b58 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -369,6 +369,11 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
         old_tss_limit_max = 43;
     }
 
+    /* new TSS must be busy iff the source is an IRET instruction  */
+    if (!!(e2 & DESC_TSS_BUSY_MASK) != (source == SWITCH_TSS_IRET)) {
+        raise_exception_err_ra(env, EXCP0A_TSS, tss_selector & 0xfffc, retaddr);
+    }
+
     /* read all the registers from the new TSS */
     if (type & 8) {
         /* 32 bit */
-- 
2.45.2


