Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ADA109C046
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RM4-0004pr-Ff; Wed, 25 Mar 2026 12:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RM2-0004pP-L0
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RM1-0004dC-1x
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUWLt5gqzfgVe+YfJCx/5uk9foGdupZQ9zjYEXh0nyM=;
 b=gi90qzWNSlZaATDpZuNJm3zfNA3I6BG84YFt6ijVOM0a9upzIEZ+edzP/+r0vTlyEwWqDi
 uVMLAFwT1q5/sSfnua8Att2N2VFDIphyE0weNwfeYJCyyhrY+n0ziv6tiUql0GbzKRetH2
 8fb0pp6kLZPdY1OGudTPQWu9YF8DIVw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-Ix2kJx2LNlKR3ulHWB6gSw-1; Wed, 25 Mar 2026 12:45:11 -0400
X-MC-Unique: Ix2kJx2LNlKR3ulHWB6gSw-1
X-Mimecast-MFC-AGG-ID: Ix2kJx2LNlKR3ulHWB6gSw_1774457110
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43b3d3d2d22so16292f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457109; x=1775061909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUWLt5gqzfgVe+YfJCx/5uk9foGdupZQ9zjYEXh0nyM=;
 b=Wj5OKtT5TZE3OT+zSw34PW9d22UkL9OqqjDGxYwg3WH/GJXF6gs2gkgrmy/QoKSm4E
 o7fW8mp5Yhwe9bOOUGnlEtuAape8gbcqBh1Tg4wdEX8CtycZwYsVrcQ1jR8dyPGJRGHX
 1WWkDVAzI5Wl+H51RKodBUmEOxMio7q9Obr/zH018mXbPHM+328xYcGa5r6ekmdOiWEA
 ssdVef4gvKD01Fv8yNrLLSSAAO6rlg7KRQgPw/9gzXqCOIjCV5mctNy5Y1JnAv1o4shP
 2G+eyo58a2Af7he8LUDBfukL5oHO4u9Buda6x0OOD5zSYcCWYzTOj9FtLucXng7H1gZl
 aOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457109; x=1775061909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uUWLt5gqzfgVe+YfJCx/5uk9foGdupZQ9zjYEXh0nyM=;
 b=HWVBluv5PyWoui/yR7OxbHnoTMLUNY+o5r1qIvolWyUitftLy+jSq1wZA5/G2+AAhi
 ANliws+xqt1U/Sc5zu7Y8oYKzjwINnRqEZmPe3kMK/pcN57hh8Bra/d1hmQjst3xUBGk
 SKnKq0/k6QKchgxOnU0dSPT7nsKSdTAvtucXz0N1lRNiLshuVRXRjTcqlxjIKuh0n8bl
 ZDh1G26n0lrLnQhqDiC/wHuts8eni8QKtothu5BLLFxJfFEjBQVHFp/RSKXOOJbuoGrz
 6OeAyYHgkRosExt+6YzDsmRI9G+WpCPi9AE8bklAnvqXwn19s+YUlMcOfxcOYlv4FQ7P
 QLlA==
X-Gm-Message-State: AOJu0YwTMJA+T4tNcGEwyrnVVAqXN7tPV/WdYNNQyHzRWSWxuEaXCAjh
 eqf18iDP7eEL0G9daL13mlpMee8p1d7dIGpU6b6hODm1rbwM4o8hFHUlKNzMcc7CXR4b12LVOeL
 4sdIZUrt1gNzSSlDzgBQ0T8fi2Y3TG9T8Il/Ey9LcKjJmNZTvl2Yk69ODBwvm1xexnEPxlgZr/+
 HtmkTM1NbPtksk16lekgbI7aGaVBSbd+O5TiQ4DVFv
X-Gm-Gg: ATEYQzzU1CU4GbKYzgO8q8nRToDpBG5OCUmrMqXAdts73MPdz6krRn+iUD1RLfnLIQN
 6jKaubADPtpYI4ckgOEl5veeXz2hOm0GgV575wF4FKTZBCcq0q3x0Fd0OSDB0ivk/bCMN36EPH/
 aeAxfDQM9cuNksbd5+q+1RXAWOfSlyhOkN9pMFdh7+rh1N3n/PEo+o2pfmeuvcYJsUjxYF61GjV
 a5RUIhMxoVQkjGb58ETbfvN89YuDIjPZS8rg7oCVkkOHCgl5GqdHQPssmX/kmeReLy/OWM4np75
 Hv6Q8i3f9F/fIGUTMfpammfOPf0N/O02GnTkfm1CjoIKUoYgsLQrBkCWSeU8uuTg+SVqxmden7R
 LCN2EoA68mCCLBTxf/rkr3HjFXqzLXz0nwRg9X6m2E6JweGdbrdyc8qYFLFuBxVptllH1E89hEG
 0dABrOcQ/rWDt25Gqlpc32w6Nd
X-Received: by 2002:a05:6000:310b:b0:43b:4c6b:754a with SMTP id
 ffacd0b85a97d-43b88a0d163mr6314870f8f.53.1774457109225; 
 Wed, 25 Mar 2026 09:45:09 -0700 (PDT)
X-Received: by 2002:a05:6000:310b:b0:43b:4c6b:754a with SMTP id
 ffacd0b85a97d-43b88a0d163mr6314807f8f.53.1774457108531; 
 Wed, 25 Mar 2026 09:45:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919e708asm823510f8f.36.2026.03.25.09.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 07/19] whpx: i386: skip XCRs read for MMIO exits
Date: Wed, 25 Mar 2026 17:44:41 +0100
Message-ID: <20260325164453.72127-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

The XCR0 value isn't currently needed for vmexit processing.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324151323.74473-5-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index ac03445d9da..c0c7ba91772 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -689,7 +689,9 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
      * Extended control registers needs to be handled separately depending
      * on whether xsave is supported/enabled or not.
      */
-    whpx_get_xcrs(cpu);
+    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE) {
+        whpx_get_xcrs(cpu);
+    }
 
     /* 16 XMM registers */
     assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
-- 
2.53.0


