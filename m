Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F774CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 02:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPATa-0002Mr-SY; Mon, 18 May 2026 22:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wPAT9-0002KM-4h; Mon, 18 May 2026 22:46:07 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wPAT7-0000Vr-1n; Mon, 18 May 2026 22:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779158765; x=1810694765;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=66BiGKeoqPdzkWk01n+msDTW9G8fXVqqceNjf47lShQ=;
 b=BgeIlBbLOL5F8PSqGxDm8AJu9Mm8GXVqPOUeMw7LBWpbSWbbX1yzEoAD
 JF96RAvPkkCi6tJZDDxE/029PXcreG3i66OOIZEkcL8eLziA+bthxj0RK
 laNq+7K+w1KEiFydhT+5iQ73xxCBMYSnxyTIVFimLUw9RXJL300RU2n7s
 fzF9v2DGaPRiSnCJZVgYb8i4I+Tj7hxa4h9L0KnmxJXPMCP9k0ZljTS3N
 PIeA/UwHKsH5fBR9hhUxaSeo4Z4jSeOeQxc4F2gTLjrE4BXHmGYhgZbVB
 kPO7ZYthn7rqCXVL6jyK/+Npu3mE1u0ESAbQhzIt9hkBTkcTmVZ5wTU1h g==;
X-CSE-ConnectionGUID: yahjz80mR0ehPwU7yRz/wA==
X-CSE-MsgGUID: 0CCXOCklTxawe54qAubs4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79878355"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="79878355"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 19:46:03 -0700
X-CSE-ConnectionGUID: kYA+vntRS2qDfcMJHbz6YQ==
X-CSE-MsgGUID: KlLYzBt1QqGx1iilXrz82g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="239879565"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 19:46:01 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, chad@jablonski.xyz, philmd@linaro.org, bea1e@proton.me,
 qemu-stable@nongnu.org, junjie.cao@intel.com
Subject: [PATCH v2 1/2] hw/display/ati: reset host_data.next in write handler
 after flush
Date: Tue, 19 May 2026 10:39:36 +0800
Message-ID: <20260519023937.439077-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519023937.439077-1-junjie.cao@intel.com>
References: <20260519023937.439077-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

ati_host_data_flush() resets host_data.next only on its success path.
When it returns early (unsupported bpp, direction, src_source, or
src_datatype), next remains stale at >= 4. The next HOST_DATA write
then stores a guest-controlled dword at acc[4+], overflowing the
4-element accumulator array.

Fix this by resetting next unconditionally in the write handler after
calling ati_host_data_flush() or ati_host_data_finish(), and removing
the reset from inside ati_host_data_flush(). This ensures the write
handler owns the full lifecycle of the accumulator index regardless of
flush success or failure.

Reported-by: Feifan Qian <bea1e@proton.me>
Resolves: https://lore.kernel.org/qemu-devel/Czyl6yVfL6sHl_o1kRk8N_LpwXMMRVhO9vgz1qCVJFagn9D4nHSKuiux39iOLty0Q3acxQq_FeovPhTQvSKus2htwjI9lTajLZmqovr0Wxs=@proton.me/
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/display/ati.c    | 2 ++
 hw/display/ati_2d.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index d77589df67..db7e08a462 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1034,8 +1034,10 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->host_data.acc[s->host_data.next++] = data;
         if (addr == HOST_DATA_LAST) {
             ati_host_data_finish(s);
+            s->host_data.next = 0;
         } else if (s->host_data.next >= 4) {
             ati_host_data_flush(s);
+            s->host_data.next = 0;
         }
         break;
     default:
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 48498677c7..8ef82bb87f 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -452,7 +452,6 @@ bool ati_host_data_flush(ATIVGAState *s)
     }
 
     /* Track state of the overall blit for use by the next flush */
-    s->host_data.next = 0;
     s->host_data.row = row;
     s->host_data.col = col;
     if (s->host_data.row >= ctx.dst.height) {
-- 
2.43.0


