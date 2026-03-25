Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0471F109C045
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RMN-000593-VQ; Wed, 25 Mar 2026 12:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RMN-00056a-07
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RMK-0004gV-PZ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpNDy6y1w/fo9WvmajHhnQ/yfO8JE34pImny9o9u5IQ=;
 b=f6osi1MplqcKhCGPAC4xQiMw1M0WvpW8bbumFxmk0BWpG8ZRJqcIOiP9CEoAET2MT5CHk+
 SMphh7+MbQlxI2D+aHqJF2ha3pA+vPuqnQuq6ovYGSNIJj2GFm/l1dXABghq9Jz7m4Ty89
 FOM9N+FMgLipAKdgb+9IHsjqmhMFW4A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-EwkUZWCoMWuSZ8_nuOkdIg-1; Wed, 25 Mar 2026 12:45:29 -0400
X-MC-Unique: EwkUZWCoMWuSZ8_nuOkdIg-1
X-Mimecast-MFC-AGG-ID: EwkUZWCoMWuSZ8_nuOkdIg_1774457128
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48531e8ae62so1945765e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457128; x=1775061928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lpNDy6y1w/fo9WvmajHhnQ/yfO8JE34pImny9o9u5IQ=;
 b=gkq1c1mald2CR9VvyTfQRnwIZrEHtwufEyUveINWDO5R6phsWtUsgoTwCeeL5EKujj
 73VSyJA37d+lCam6UbVowgxOsKU2YIr2HhIYKDd32wb+mv4OX9JXFaZMdwx3azbOMPzj
 SzhBnMUmzdRJ4UGqW2zzcwuemCINpzOFM49UOkKaeR+C+WRXYwUw68L261GTyx6va5p/
 QXPlP68SzHx2xH5mAU3j7VN5zotJlFits0go+kxpoKcJAepqJZsOzFq044DpN6ZaVF+a
 XEpSXMz2y9s//YlILcWJFnhZMMkGOK2LqsZzA5vliXmtYVYr1aX0tiKp3e1WqHScXH7l
 6oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457128; x=1775061928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lpNDy6y1w/fo9WvmajHhnQ/yfO8JE34pImny9o9u5IQ=;
 b=go6l7KopTDcmXMBDCOyMj2UVVbmlHssNbTRKNIdKqGdTEFUTXF41jALs8d8hUQPdpb
 VIYiASmZdZdIMKLbnjJE8sbUVHMfJFFRFQJ7FQHovOL0ZSiNdcCt132wUUz8r5G2CC7f
 bL7x+xJ2w71LxH12y++jA1KrrhBf7wTjEdGFeS1Uu0ODrWufAtXWm+5ak7jOpj/v/UCr
 XGsr3ZfYu7yoh293V0Q7zRruAyqUV2ltZYJmIojbkEuN6apK6Wst9cFSCAetfKNHfU3v
 SwfktEpxbfxOpG04yb0Ma4vCdou1swMEcRULbvIVQePOVkoIXItu/UoKT4DruP3pJqfw
 OuzA==
X-Gm-Message-State: AOJu0YwLQvgHAdUCP0KnhiQF4UfTggi576hYWsxDhg6uanaixRl65qMu
 5qRlsAlQD56LlHCvEIm2SQRdzsGVLEaQuXe823WoV9HPzpGP8C4EUiKTJZYCeDOKx9lnXX9h/65
 rLmgXM0WnGZoJM/ZFXlH+ocJl93S0IGBchpkT1tIu8a/RshCQtNs30Pf+sIaz6LVHM43/+jNh+f
 L8czkJnhypXF7UvNKgrGV4D9+P1/MVXx0+ozlD9/g6
X-Gm-Gg: ATEYQzw/FxJUVwaJrlAPhYMDADL5+1gjQHtGSEdh/j/U0suW0+gZn99sbuyUcuFzc+v
 ZhrWRBApTS0R2L+Xg0JzMCL1GnoOTgyUx428E2YoNfCESWLnXlfUE/5rGjrVH/6wtKnW2IeZat4
 XAULMIl4rRhMDRsFZNxL4BfBsd5nkGKsm/ClTxATm9Aptz9wiN/ZP6smdO/e9PMymgEJLoAsd11
 iQKIieNeo39cWhjK4tYWTzSGKVv9ob31dW/B0WRope0qHhIXfYVEWIbSHfRM7gRyNXMAPaI+FMS
 TNs3ewy4ToULvBhlSzK7mNEcl8SWe5fkV29zu6fnxz+1goH8T5VzCjrQU8MMDJmSLb65iG1/mlJ
 lnI+SbLrirNWEZu0uLQoiajuGKlVvc2TBfj3O716zYEh60pE7l1DEOqVgTmcRuSeHs3szrVH5oN
 P4iLSap4MmV+whFmgMNrJP2g9E
X-Received: by 2002:a05:600c:1f8e:b0:485:3fa9:358c with SMTP id
 5b1f17b1804b1-4871605677amr66269625e9.17.1774457127613; 
 Wed, 25 Mar 2026 09:45:27 -0700 (PDT)
X-Received: by 2002:a05:600c:1f8e:b0:485:3fa9:358c with SMTP id
 5b1f17b1804b1-4871605677amr66268985e9.17.1774457126930; 
 Wed, 25 Mar 2026 09:45:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871e6e7c69sm6510875e9.15.2026.03.25.09.45.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/19] target/i386: expose AMD GMET feature
Date: Wed, 25 Mar 2026 17:44:51 +0100
Message-ID: <20260325164453.72127-18-pbonzini@redhat.com>
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

This is implemented entirely by the hypervisor, so only the bit has to be
exposed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5e483e8cd2..d02f6f0653e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1170,7 +1170,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "tsc-scale", "vmcb-clean",  "flushbyasid", "decodeassists",
             NULL, NULL, "pause-filter", NULL,
             "pfthreshold", "avic", NULL, "v-vmsave-vmload",
-            "vgif", NULL, NULL, NULL,
+            "vgif", "gmet", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, "vnmi", NULL, NULL,
             "svme-addr-chk", NULL, NULL, NULL,
-- 
2.53.0


