Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4F5FD0057
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi0C-0000HC-KT; Sun, 01 Mar 2026 09:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0A-0000Gv-U4
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi09-0005iK-Lm
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvGSKSAyjuBhpiPZe6uKq2THsYLV9ExqDaEl8KN7MjQ=;
 b=g0QYwarFuJkqkqnX+P6jrEy/bXI5kdf0Fl7lIk7XlYMD5J4u8oQCecuipv72mCJ2WY5iwD
 grekvHRiq69O/3F7zBRwmjkuukQyxKi7Gd0dl2KzlpF4q+QRZXMFT09Aq9tr/l+wWpLGVn
 Z2o9qL/39ge2Bvyd2SUD+J4T+WD1+nU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-FtTBC08ROa2GGFcD6oUWrw-1; Sun, 01 Mar 2026 09:42:31 -0500
X-MC-Unique: FtTBC08ROa2GGFcD6oUWrw-1
X-Mimecast-MFC-AGG-ID: FtTBC08ROa2GGFcD6oUWrw_1772376150
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4398f665747so3697624f8f.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376150; x=1772980950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NvGSKSAyjuBhpiPZe6uKq2THsYLV9ExqDaEl8KN7MjQ=;
 b=r3EVpNCeXSRx7klGTTM+AT2lGTE1wC5HwkLyf3MowvSE172wXwZTU2FxqfRGpxFNkI
 65bQTQvhmr7YCkhe0dK5O664d4K64+P9ybBJPeAbieXG9T4aTxAi/u2a8DgzhAbTkv4B
 GmoSGR0w88ELzz/9phB7DCUdw7bQf3nCxOvYwFoXvgfkRjTEkbzYTegxWIqoSLEXLEyu
 TxyG0oMF3rwsYVZU1J1/V9xKxueS8jIpEAL0WlMrt3KrYKtx11xfU6uDLddzfnCtLy9/
 N6Uc/XJoqciv9sP/HWuWAwsqlpPRZY+kiVARzeTfppvLqGenb7xRJou9uAgyHY+U4C2i
 u5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376150; x=1772980950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NvGSKSAyjuBhpiPZe6uKq2THsYLV9ExqDaEl8KN7MjQ=;
 b=dPO6EBamrsJKj/MIIXUg10LJ486D1KPJCmn4sNICcJNpmuKIDvtU82IVu0GsaBBedh
 jWzN+BbldvdAOqxztP2tvVoz7J4SC2qEu2eiJTtxMAlc0ZuPrF1mwFAdmPTtoyMVLix9
 7Xa+Z0o91q4nV1/VA8G+Y6ezShtpr2RhDmqj9wa/C/o6mqnVnHlvLgUMQTL2RdA9lylF
 Lf8MRvMiiLa3+zqxGZ1qosMoUwS6NtfGkVkUI6i3B7UYy0HcsKuGoxmmEpDvFHgIBPjH
 4ZuUEgau5D7WzMmSHVqMPOcC3BrxkuNh/kz+xqu0Tort7fu3v2XNNRZc0JiJx/N/fIUQ
 Jf1Q==
X-Gm-Message-State: AOJu0Yz7O/fQwi6Nuv6tWluk4/hYw6V5hxBhX/5OFjP25cP5gOS82Wc5
 o9lL0isDtTgQmarLsA2KMsjp/Gb0RBFiSBhnjHX2a2ylONbbeVZKuWtaFjCk9q/ly9Vy6yv0NkG
 8QRq1G0BaW3kpZplgXREtHHyyAj79MCXFRPPNASbtTpHZHYU8tUAPlVGLWTf74BOHlfvUVAIKF9
 iNS0aNhHB8VJCTWb5KWFHW9bHOi8GXzQ9kc9TG5Jxc
X-Gm-Gg: ATEYQzxiFz5yq1RIyCy88rqC7aa8OqxypiZgDCPdc8OS0T4lwUr7kxPq93lv0Yz3g8y
 KWmOgq8ba4ND1NeqFvqOOrbFPXFrnZCGr6qXs88ICeUGvJNKGjp0ooQfLld6fU+O5Zt5Pm3LujE
 uQEtv1ZxVSKKcK20Dnf/9C9XoBhfju8wcKsQuJ8bGZTMidCgCOrXOu6SRz9Vh752BLFG5vVyGP3
 je5+YARHjr+s67DJl3m0dlyGb/cVAZtiiieXF9X08O/K+RhXnW9Mk0OZUbQHkmoFpu866Rovich
 jFsHZy85RddLLQ/4bYdGe7bjNQsyaomMvFRprFG05HuROEdPzt1pmGXqpSpg7XhdkGebnTdBlRn
 iJGytCtXRwvf1gTMEOL5z+b6woFG/Lk6p5iTL7nl9TodhkxZ7+9Cdz4uY5e2JsOShujySgA4aTs
 BmNZ3l1u1oE0u8vF3JDe7DQrI0bt0=
X-Received: by 2002:a05:6000:1847:b0:439:b65a:fd35 with SMTP id
 ffacd0b85a97d-439b65affefmr1397849f8f.59.1772376149752; 
 Sun, 01 Mar 2026 06:42:29 -0800 (PST)
X-Received: by 2002:a05:6000:1847:b0:439:b65a:fd35 with SMTP id
 ffacd0b85a97d-439b65affefmr1397802f8f.59.1772376149208; 
 Sun, 01 Mar 2026 06:42:29 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b34b6252sm4869707f8f.10.2026.03.01.06.42.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/18] target/i386/tcg: add definition for REX2 prefix
Date: Sun,  1 Mar 2026 15:42:04 +0100
Message-ID: <20260301144218.458140-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 83b250056e1..061adcb7221 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -50,6 +50,7 @@
 #define PREFIX_ADR    0x10
 #define PREFIX_VEX    0x20
 #define PREFIX_REX    0x40
+#define PREFIX_REX2   0x80
 
 #ifdef TARGET_X86_64
 # define ctztl  ctz64
@@ -208,7 +209,7 @@ typedef struct DisasContext {
 #endif
 
 #ifdef TARGET_X86_64
-#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_VEX)) != 0)
+#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_REX2 | PREFIX_VEX)) != 0)
 #define REX_W(S)       ((S)->vex_w)
 #define REX_R(S)       ((S)->rex_r + 0)
 #define REX_X(S)       ((S)->rex_x + 0)
-- 
2.52.0


