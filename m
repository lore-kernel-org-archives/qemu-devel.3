Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04952C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfT-0004t9-T7; Wed, 26 Aug 2026 07:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfR-0004hE-7h
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:41 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfO-0005nG-8e
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:40 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a422090b2fso1142604a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743177; x=1788347977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZaviRMEZTGypIQA7N5P6+n+kL0KfH+GkmP5oLcPBN3A=;
 b=KM9tiJvZrlu4O618529GTFnt9njIIlGk4Beo/ytXThlHl7glMMUtdh7+cJ3GVXAhnR
 qRcZ5RwelmItUTaHopQx3CnNsY+lipGPUjbwgeSM9EziaLwobzTAeq39x3bihskSyHWU
 +34hJnQk1K7fEHGGvji8IoOBER2bfdFVGo8/GktpU0lwKiNLzN+Q5jZXzg/BHzsV3pAC
 Nj/zR5tMBqfNVnIV+yG6xs+pCvxHR84myE2BHtgRqC+pLDHdVxHEmfCcVgRaGKRQrFGs
 P/xxuVvfMczZlHwDcjbo9UZK7bqyd+e8WLTEJ9bcwZDMZCrTC6v7qwl9ivmak3cBFOkm
 5L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743177; x=1788347977;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZaviRMEZTGypIQA7N5P6+n+kL0KfH+GkmP5oLcPBN3A=;
 b=DMZWID2vWRRZfUeLZNuHa/Yxdd93uup1sLQU16zDCV6TABPx+6LCAluu4dF3Tk8u3w
 rqljmOmOSpf4marSKzSgqQetnZCIeCrzqFbbJvROmMGWkclWXB+zR7BSvHcxmnUJcPjb
 Ichza0yjMyaRZuOBq5/h0jBo5ym6P/aPAjjYlimRR30Y73Uq3qA6NdC2Di5YnscMdrxS
 NU7vf5qsDTGTjnHlWU72LNqsNcPZWIOeTMp0eL9XFwLKuktGH5ZdTEy8IWoWshQQZbCy
 SveMUneW5PNXRZtdUwN1QKcE92yl48Azvwk6Ac3kzt6jHooSNlSiJjFkaEa1I2HZyYpN
 5l4A==
X-Gm-Message-State: AFuF++lvzZYIHsG66pGuakKjd0dCPrbtNnc7ahysGX3xOfRqEya0wsnq
 ifz3BVgDhOMderxeKMCpGP8tLwtvKkM3eqVF3ZJ6La1Ca936DmSEn7w52xBk+wAKl89rm8pFuAq
 s8xL9
X-Gm-Gg: AR+sD130o4w3jMCdhqIXfwzF9QI3WQhaI5b0v9TU+JvML6vGIHh7BMg4c5lZiDv2XRe
 rKH1kW7gCIEm6D9XMexwQQCxxKo1avvt1efhA+A6OJdyYZ9y9nOF/Ajyb8mHOSa/uq1qUEWAoG/
 wXknb2hzBb/2N4NYVDDBR5hJ6ouc06hDlxM4e03y42HrGSiUWJhYDvODM0851ZC4kZoleTwvWyL
 Bhz1IE7zB1xXKgKXNrSh92qldpLZclSx8VEvFrzcDDPCJ3RvR1vcH3SDZI5yiahJRhOURq+zk9T
 lECmX/k3ZM1binurmEV8ozxSz6gobQDslYll4uvsOskeuNE6guzmLuO1rPtASq1Uu30nhC5WGvn
 vaIZORKmlQWGzufmh3dKKFRN2AkKRss/WpPujTZqON+oh7NOOGYxaTRyLAlwVdU77V6NlgI8/aA
 HtlsSFzhHCzM+cfezJCoLrsONpkYraKJ5vlyRjHtqHJmqyD/Lk5yql9lL2Tvk=
X-Received: by 2002:a05:6402:a0c4:b0:6a5:ded5:ddee with SMTP id
 4fb4d7f45d1cf-6a5df62a737mr7909610a12.12.1787743176778; 
 Wed, 26 Aug 2026 04:19:36 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:36 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 23/28] hw/ide/ahci: treat a failed PRDT walk as a PIO transfer
 failure
Date: Wed, 26 Aug 2026 13:19:10 +0200
Message-ID: <20260826111915.3387926-14-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=den@openvz.org; helo=mail-ed1-x534.google.com
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

From: Denis V. Lunev <den@openvz.org>

ahci_dma_prepare_buf() returns -1 when it cannot build a scatter-gather
list, the PRDTL of zero case among them. ahci_pio_transfer() tests the
result for truth, so a failure sets has_sglist and the transfer goes
ahead against whatever s->sg holds. AHCI 1.3.1 is explicit about the
zero case: "If this field is '0', then no data transfer shall occur
with the command."

Test for a positive byte count instead. A successful walk that yields
nothing to transfer is already handled by the size check below.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4043
Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 4c138b0c51..436a0eaab6 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1428,7 +1428,7 @@ static bool ahci_pio_transfer(const IDEDMA *dma)
         goto out;
     }
 
-    if (ahci_dma_prepare_buf(dma, size)) {
+    if (ahci_dma_prepare_buf(dma, size) > 0) {
         has_sglist = 1;
     }
 
-- 
2.53.0


