Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C58C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZARL-0004cv-PX; Wed, 31 Jul 2024 10:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARE-0004Q4-1i
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARB-0002dr-Q9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so36152345e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722436579; x=1723041379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/NRApmVNAaLyyg+o5au71Qdmh5VzyMeuC289IBc2d8=;
 b=SVOx+D2rLsj2MpTsOItsfhDCFQSbOJYPlJy700gyDVG0/FnHCVTJBwfDPalwpgMY+u
 P4Rp2tEUV8XxPshxn/ppqtWniau6FSpayYCPLyl/QQo0yX+HjurXe5HuAZSyzFYK7gH0
 ZHFPU/Ymog4taYR52LLCS2Mh8ngfJJ8w1bdbjBZnHJ7GkGh1nDcb08m4INAGb+/pJ84G
 Gfpp9rKMFLj2SzjN0q20V7DfzQ2P9dM+cNjXINb/fsNrYMUGv6P2wmLfAJwVGaA6wSje
 TAAHgpJGX2EzLET4/Wr1BFDLbitS04K2S90ml3rE3sFr7EmDmogdI6QSLnSUuDjG/JlS
 ESMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436579; x=1723041379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S/NRApmVNAaLyyg+o5au71Qdmh5VzyMeuC289IBc2d8=;
 b=VKGSrMsEjDglL24AZ6OtEvQKQJIgqL8i28JwLBzPN2aQ1BjH/X6plFZKzW59muniJS
 gSq/znrZRzzQ3Kk273YuvwmQzv79ujz5C8gABLd+ukwtMsV6SRCyNGH1aV+yoqhWcgev
 1VDPtj2UDijxdRylPW+C65CLBFIAV+rUvqfIpj5jfzn3Z9EuMLREfKl3sSxnlmTWRzzC
 wwvKMl0CCNwoeMxR/L1dX/mk23gwt3lu+70GSAC8wjlPMziCpowb39U1MKxB9BY9d5tQ
 EbI5qFz67bJPgLfFJu5j4wCd2hNruPGsP7ap4xjmummSkfCmFFSbqduKCoh1I7TRwi2u
 8JfQ==
X-Gm-Message-State: AOJu0Yy0Z2VGoWdzaswMRH5It6BKp5qQA/CtLs4+inJyYbVLR7Y4nd1w
 1v4bj6av9C7WpX2b/db4Axz9rvfzeaSTAqf+Pq1Jr9V01OdmwsKPhDhofzzIhL/jGxmUo9cit6+
 I
X-Google-Smtp-Source: AGHT+IGFB0T0NVU5JuujtyxV8t2Oa9Mcxpkc8yrpbx3F/UcybVtKJhQTOnyCci+ilFJ/gh2T/0RzUA==
X-Received: by 2002:a05:600c:4ec6:b0:428:1eff:78ec with SMTP id
 5b1f17b1804b1-4281eff7a44mr69278435e9.18.1722436579541; 
 Wed, 31 Jul 2024 07:36:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89a86dsm23976025e9.1.2024.07.31.07.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:36:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 1/7] block/vdi.c: Avoid potential overflow when calculating
 size of write
Date: Wed, 31 Jul 2024 15:36:11 +0100
Message-Id: <20240731143617.3391947-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731143617.3391947-1-peter.maydell@linaro.org>
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In vdi_co_pwritev() we multiply a sector count by SECTOR_SIZE to
get the size to write in bytes. Coverity notes that this means that
we do the multiply as a 32x32->32 multiply before converting to
64 bits, which has the potential to overflow.

This is very unlikely to happen, since the block map has 4 bytes per
block and the maximum number of blocks in the image must fit into a
32-bit integer.  But we can keep Coverity happy by including a cast
so we do a 64-bit multiply here.

Resolves: Coverity CID 1508076
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/vdi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vdi.c b/block/vdi.c
index 6363da08cee..27c60ba18d0 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -728,7 +728,7 @@ nonallocating_write:
         logout("will write %u block map sectors starting from entry %u\n",
                n_sectors, bmap_first);
         ret = bdrv_co_pwrite(bs->file, bmap_offset * SECTOR_SIZE,
-                             n_sectors * SECTOR_SIZE, base, 0);
+                             n_sectors * (uint64_t)SECTOR_SIZE, base, 0);
     }
 
     return ret;
-- 
2.34.1


