Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A3CC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7WxO-0000pq-Us; Fri, 18 Sep 2026 07:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WxK-0000em-Mu
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WxI-0001uK-HP
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789731635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BuuoV/RtDVXCu0xt5LIWVsLTHx3UsyTgDjBv1wuZ3To=;
 b=Qu0nZiT4tGnLjs4rbdfflgOMIw0xlqRGCWdZ+IO1Spb4PeLt0/xGXPp62glLuRckUmoLEU
 EC0YEsPIskac51/xKKsVEslEQ3lbBMhUgIvmUvM7EmHV8Yl6eaLV9p8Qb+6T/P3maj238Q
 Wtn1vlq3+Rtf5ngNY+pR8+SV76bTacs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-Md_aPixpPJ2FeRPgsylj4Q-1; Fri, 18 Sep 2026 07:40:34 -0400
X-MC-Unique: Md_aPixpPJ2FeRPgsylj4Q-1
X-Mimecast-MFC-AGG-ID: Md_aPixpPJ2FeRPgsylj4Q_1789731634
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90c8da50f8dso17586696d6.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789731634; x=1790336434; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BuuoV/RtDVXCu0xt5LIWVsLTHx3UsyTgDjBv1wuZ3To=;
 b=sRD1VHuM9LK/F4FrXwPAcDuZk5shPZYYrSw1Aq/XdPdPCJgJGh0cluSYCLPxp3lAdU
 lUGLOZakQGuGeyuN121xM7hmA6PBdSX4SMdBzOxmX0D0lcZEMSTcaTQE07iNN0tKR/9k
 6EvsmnCU8g49v+DBawVxoMrbPJOOqf1WeeKHEzI16Ss1RuJakSllDdDTUg0qKsnVWBZR
 eKVs7ck3udq+mr+SGUfw+Do4UIGlfe7F04SYzIJKK6L+dq9rRLWmDjAkGP4Fm4vEFG3u
 8x/CL4BeqGnW0B5USa2FJAI94IYRNl5OGgH3KErxT7wIictLcz9bD3ov5o05HdFA1Hzp
 8Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731634; x=1790336434;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BuuoV/RtDVXCu0xt5LIWVsLTHx3UsyTgDjBv1wuZ3To=;
 b=wXNl2VFXw/GcELSzu6Ayd1UZLKDOQMkK91bhHT5CCqDf65y/TbaDC8Rn3COByAbScl
 btVzz0M4I2ldfE2tmEp6xIMk71ioKwI+nAHYXAyqcANGVnWQeUPStTvlKOhu7KOJQ2Ky
 rsG+x8kZ9KUYUv39S+WX2yX9r75oPrqwLVhfSavN5JYO8t9RpnaInysYStykKhhkFoY4
 PkNnMtXU8gmwAn1nUWvTp5QobxmxzcrJIyuld1rtMEUHC65gxBbf6YzxsnmIRPx3xz8n
 4YQXFIbeACCEOoUoLK84lsrdSkwOnooOHZwLzGrzus6LH9yRdr73pWlEwZd/6q3Sduvz
 qw/w==
X-Gm-Message-State: AFuF++lGkIP2uhCDQhjlIQ5XVIsuZmgQjp9apYw9rEfH/szjz0eBzWHS
 Sp52EgpJyyoDwRXzRj64WYamnxLetOx7roCLA5B4sPYn34yck+HPrQ8J1oeiqHBLTRNKYuNZRb6
 /9WkMhdV5alvq1eFmoJdqOM2YNqfeboeB4eDSo+vipCh5CWe9quP15Ef5wljXBRPeI+shDa88uL
 AuBXbjS2gLhktcefpoJxIi4hwh4Cs+DleMrdKmaB/M
X-Gm-Gg: AYBFou24f5R0dprBBVDaVBbPDM+yLqIxipHfrhAIUaOYI+hrtN2dNWXaUWfjcF4Xn/m
 0zb16gdBvzNJ7DtA0h2Ddfr+1sV2DNe+/vNimQPtHKfixaCA/CJTMsI/QMhEZn5leMfDZVZp/Tz
 POG7+iFZIUH1fFvsU3Lfutg9fRqW42zyaK6LF/+tyQPUr0V2hB6wK58b7uBP6JpiyDjmZmKeCSA
 ZTdgYAOehcVCRVcXDAgbYyT7RFBUDNBgg3fR3Me3A1rZvxqmcgiq5IErwcXbI3vA4aXDqh+DoL+
 IU18cYB6nBXxLlRBL8Do9S33I3bKqGYVo6rVycUywqd1Ed1jWaUdxYtVl0tNRzdehKoezkUqlzQ
 Gfxu6Jph95GYvwO2Cze+T/Nl3Li7s83uTroGMhrtarql8LlN0TwTwP17LQ6w=
X-Received: by 2002:a05:6214:2588:b0:912:518e:d0a4 with SMTP id
 6a1803df08f44-91254ca41famr33606726d6.60.1789731634013; 
 Fri, 18 Sep 2026 04:40:34 -0700 (PDT)
X-Received: by 2002:a05:6214:2588:b0:912:518e:d0a4 with SMTP id
 6a1803df08f44-91254ca41famr33606246d6.60.1789731633223; 
 Fri, 18 Sep 2026 04:40:33 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91258057e41sm10416946d6.34.2026.09.18.04.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:40:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 10/11] system/physmem: Improve guest memory allocation failure
 error message
Date: Fri, 18 Sep 2026 07:39:25 -0400
Message-ID: <20260918113926.831204-11-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918113926.831204-1-peterx@redhat.com>
References: <20260918113926.831204-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When Linux refuses to overcommit a seriously wild allocation we get:

  $ qemu-system-i386 -m 40000000
  qemu-system-i386: cannot set up guest memory 'pc.ram':
  Cannot allocate memory

Slightly improve the error message, displaying the memory size
requested (in case the user didn't expect unspecified memory size
unit is in MiB):

  $ qemu-system-i386 -m 40000000
  qemu-system-i386: Cannot set up 38.1 TiB of guest memory 'pc.ram':
  Cannot allocate memory

Reported-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Link: https://lore.kernel.org/r/20260822122710.3731595-2-bin.meng@processmission.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@mailo.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index a4a6a4710c..bd5f41cb02 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2171,8 +2171,10 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                                                   &new_block->mr->align,
                                                   shared, noreserve);
             if (!new_block->host) {
+                g_autofree char *size_s = size_to_str(new_block->max_length);
                 error_setg_errno(errp, errno,
-                                 "cannot set up guest memory '%s'",
+                                 "Cannot set up %s of guest memory '%s'",
+                                 size_s,
                                  memory_region_name(new_block->mr));
                 qemu_mutex_unlock_ramlist();
                 return;
-- 
2.55.0


