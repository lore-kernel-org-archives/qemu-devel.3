Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16144CD6E49
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScfN-0006t2-62; Thu, 28 May 2026 11:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wScfL-0006s2-5n
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:28:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wScfJ-0004SL-JY
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:28:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso12102645e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779982134; x=1780586934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TB2juBS3szLYOmffaCpBxbVMqRICIh6lQ8+XUMJHh6c=;
 b=unE6q8Gf9CiyK+nEYkNK0uDBHiz3F5Mw78M2qIaS7joStcddPUpxAilz2d6Fb5oea8
 rimb4YzzvQHgRjNcBq5stF2QiSLNPVDDU1AJpyywvQdM8Rdn1QhmxYGZgS5NM1b2QDJx
 usSNYuDhYH0KVXabejV8f5u25sr1uBWGOd9uV99X+qV/PPpVkg7Bc9ALDGhZAfl0reQp
 tXa+M8moU8Yyy0xUnbquIFG7tkL0u4+741c0gDBbKUjZGU3QvVTq+UaUQ3YI0G77vrwl
 HPKAB7UCk9fRW7jaSx2njKsYSxPAerIomLt8e5MZWGhs5ZO8eESSkqZC5gWW3o7PXzMU
 VawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779982134; x=1780586934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TB2juBS3szLYOmffaCpBxbVMqRICIh6lQ8+XUMJHh6c=;
 b=dT1olmhLGhS0PNS8xAEnVrS1QDgZGfBm2nGr/NI0hhlsL/WpgOYPiMuYpQBjTpwh+0
 67jlVYsGF7taVU3bqwzjy1J9lHQDEVQfSNjbUUhfekACJXGdbbcnWJ/HFo8rgdvHK0Om
 2tL8BQwu8q52snWTkym5O3mfsHVDtMxfS2nxVQ1rXT0h4qjumZeF7TRI4oMtrLgDWFa3
 E9zwgayJbj3zjEESKvsWyc8R5o0chhjEnAMZVKRhNF/NrR84UZf8aruRBxitijk9ukcn
 3OtQTR5wCHgXBT5ycUOzo6C7Ug6zYSPZsXELM73By4SuAIpH7dWA0Qw/ylUfCHdNbi5C
 z5+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UPKcTmCN2IAdXgquREfZa/000xk6KBqFSupRyXpSbpg3353aOx2xYyZpce3NygFXxFhmevWlpnHAk@nongnu.org
X-Gm-Message-State: AOJu0Yz3gKeQi/E3Zd2yo3+duAiAVGKlyfx3dYM2hq7iwg/N+ibgiqkZ
 /xhdIJi2A20rLOwBA11pvQ0TMy4gRa5/thSqz6f+FBQGoM0kqRLTCa9kPkP0lxCAxZk=
X-Gm-Gg: Acq92OEg1W1Z5uYzIWD9c7YUguvhqWmDtVIYecD3YrfPTUNK6wM4zs0s6bRzEtdnxbk
 WWBzVh7sMoSd8HnpgC/+KBvx/rAhVcdS0VleXCz9lBg4wg3lA52u+3/K8nZZLf0leTR3nYByF23
 bqKc4JB9b/gCY3x03g9eMFDtUfVS/mIxeXG98N/IJZf2YuuHQcIy48nmBYxy0j07MRT7W6e5y1P
 uVvEIgIsfNJwKcUbRYY9ND+bZak2ym10+w62z7jUYAN+LxYBDJihfLut3RbzO+L+GDI/63Wmk05
 X/lDF6ZBS8OH7XSuRWBa2huRc1HYjaYlWnkIbZVqXnLzM9rZ4mrD1etFFeGx1z3NTbn/K6SbI/y
 FRNtitStyuMn/frG1ALVXnrg6GCRQwYza3wF1ce4jnRCFTTcdSTym2lDnZn11a0UmPEJAn7hioZ
 6pl3H81q9QvXJtk7sla+hmw0bXsYEcLJRR0Zguip6E5xWf2HAbTOX1HCGb0mMb9jWRd7oMoS/wm
 WgJEN6JaM0Z4VkTUmKeRtFle/jq1Zy9byHrfsRD1Q==
X-Received: by 2002:a05:600c:c10b:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-490426ddc41mr360084755e9.25.1779982134354; 
 Thu, 28 May 2026 08:28:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908b7a70b9sm19116605e9.12.2026.05.28.08.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:28:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw/dma/omap_dma: Remove dead code, tidy up
Date: Thu, 28 May 2026 16:28:49 +0100
Message-ID: <20260528152852.3349928-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

This patchset is primarily the "hw/dma/omap_dma: Remove unused
ifdeffed out code" patch that was originally in my OMAP dead-code
series from the other week; everything else in that series is now in
upstream git. The patch itself has been reviewed, but the series does
the requested followup work of fixing the indent after the removal of
the ifdefs.

Patch 1: remove ifdefs; has been reviewed
Patch 2: fix coding style so checkpatch doesn't complain about patch 3
Patch 3: re-indent; whitespace change only

thanks
-- PMM

Peter Maydell (3):
  hw/dma/omap_dma: Remove unused ifdeffed out code
  hw/dma/omap_dma: Fix coding style in omap_dma_transfer_setup()
  hw/dma/omap_dma: Fix indentation after ifdef removal

 hw/dma/omap_dma.c | 247 ++++++++++++++++------------------------------
 1 file changed, 84 insertions(+), 163 deletions(-)

-- 
2.43.0


