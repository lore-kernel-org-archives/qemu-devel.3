Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E21C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qpi-00081u-TC; Wed, 23 Sep 2026 13:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnv-0006md-G5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnr-0003i6-Mi
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cqtuBjrcUX78UlQ0M+D2gdtFekrOzzmNKWyMGboaw7g=;
 b=VvqzCFaEC+kLaDnp7eB2Vb2vjgbrbnFh3Atr9xblrXfqGETBjWrVWjgT6f9WJxmmSYQudF
 og8WahTSiYHLFLjE/ZUrrH/Wmpjz3ENDNYGXDAhxt0tFSqpJD8E8SlKTf14fDccRHMv7Da
 1pAhVhlPk2UCRUKfUNrKdo8YTP8NTU8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-1gjITVC7MTyuPWkSt_ZADg-1; Wed, 23 Sep 2026 13:30:39 -0400
X-MC-Unique: 1gjITVC7MTyuPWkSt_ZADg-1
X-Mimecast-MFC-AGG-ID: 1gjITVC7MTyuPWkSt_ZADg_1790184638
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4870eda3782so978336f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184638; x=1790789438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cqtuBjrcUX78UlQ0M+D2gdtFekrOzzmNKWyMGboaw7g=;
 b=r2PHlVeE3SDUauknSmVJezl1jHUuqOGMh91UBJxzV57evlefC/VBFN+hNTQMH7KMak
 FH4wjoM3ly88Mcz8+5pVZ7roL5rUINRwWrul1dz5H79rDHlefVNIa3H6hliZbfmF/ybw
 Z+WtIB50sBNBmWtbMxPyt6SF4WT5ptkzkXmp2ptzj5f6kHVo46FCqA1uicHygf9D7PKb
 Jt2EgzMJvVaZ9XMMHOELhyscACfdzxojCMkCwMEvrHd6o5HeJeSFjBjdIExiCgyIV8hl
 WfmNvRqQRpVHaDOgb7zPCSPMk6mu5qNQ8Y1B6BUjeJ3fNQRb4uMEy6drlCwCLXRQQiYV
 rjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184638; x=1790789438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cqtuBjrcUX78UlQ0M+D2gdtFekrOzzmNKWyMGboaw7g=;
 b=Tv28SfZDHuhS3fjA2H3C2y2vVTWEdkSvgOjS7BLmpph14zv2a+fHJtOC9bKMu2zPVh
 n7xNE31o6gUFY4btcwjEwkY7pQwCAh08ddxRRRuAYsCu8N1wdaD1/yewy7I+wCkrrbA0
 xdZSZl/4lKDVqHPFtxQ7YWDcBdL2dzfTCbWUsasfDkCoF1ylJg1Oy8639wiX63mlRtY5
 OXOihbr5SjFPE9gpeSSwALbj1P7OpQEbn0meie9gjgTR6TXef9hSUgTs85cIAINvUpve
 9egVuQzJp+/0Wb71aBo3V3h2ajFA61IkVy3bd101RjzW4Il+Ry1urPFoDAZz2v/Xz2JR
 C2IA==
X-Gm-Message-State: AFuF++mxsQqHY/qFveqFly6xUdjMZbXJ350/py60nrSXo0KVvaFSb5gr
 3PxpcF8iWb7mkjXvYzapDlxMjqoce5YI7WCBZEG+JxdFoDGgBrTEJKWSCk3rFUts+d5YXFwYKqj
 6J8gg3wEUZy8sKDgjEXQ0cc5wKnWZG6qXdirWV/M5Dz4gPOy6yknmVTPruxqNHwiWXNCPi/RIyi
 vhUMnRZHpXddpjDxyOHeCDj481qhvvAbVmArypBsjw
X-Gm-Gg: AYBFou1KELFIuLdQ71ZYygr5IPOO1HjWBqx50mhFftUBfW7q0zUmilQMRnLx7ET9ShP
 pZs8XP5xkaE+eGVWs+LnhUh0fZzT/KsJtZYLP6lTDPGXmIpN8g9e1kDFW9zCw7oJfC5Q+fdEcgR
 LtssknX+6Ioc02JJmkYkH2Hq/SbOtrIGcnDVNjKHHjBTvyPaz+cFhRxOU/yNhWDW3bJg6lG8pDb
 l7chRETf5kPmbaSZkahkrHrTkyIgQxTltvaWacL2jf9Eg0Q63wSp9mhAZVu2Yh7EKpofYekdYTs
 0eqr9We1dMRlGvNPrnnrp/kNlD/A0p21v4e6O6H5xQeGi77UGdm3MjK6iskNxe4mXTgyuBAk/eK
 anDDK1CEyLKK1+vRhknOv7wsXwT5DiBywdPVRbfkE44guKkHiIHsLGf+d6HGJVHPeScYXh928FV
 zvjmHW6VolMpVKaLs=
X-Received: by 2002:a05:6000:471e:b0:487:9a9:6d24 with SMTP id
 ffacd0b85a97d-48867073d75mr6296982f8f.19.1790184637729; 
 Wed, 23 Sep 2026 10:30:37 -0700 (PDT)
X-Received: by 2002:a05:6000:471e:b0:487:9a9:6d24 with SMTP id
 ffacd0b85a97d-48867073d75mr6296940f8f.19.1790184637318; 
 Wed, 23 Sep 2026 10:30:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877a2d5sm8312196f8f.27.2026.09.23.10.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:30:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 06/17] target/i386/tcg: add definition for REX2 prefix
Date: Wed, 23 Sep 2026 19:30:10 +0200
Message-ID: <20260923173021.317809-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923173021.317809-1-pbonzini@redhat.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3cdc458f95b..b8e8991163f 100644
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
2.55.0


