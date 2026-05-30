Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194F6CD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 19:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTPmm-00047g-Ki; Sat, 30 May 2026 15:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <boudewijn@delta-utec.com>)
 id 1wTNyP-0002kt-UI
 for qemu-devel@nongnu.org; Sat, 30 May 2026 13:59:49 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <boudewijn@delta-utec.com>)
 id 1wTNyN-0002gO-Mr
 for qemu-devel@nongnu.org; Sat, 30 May 2026 13:59:49 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-68d232ed3f9so66709a12.0
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=delta-utec-com.20251104.gappssmtp.com; s=20251104; t=1780163985; x=1780768785;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Qq4YwfARPlOW9viqyChETMuwznTjciLLUPiLAEnbBw=;
 b=b1Q8Pa90AR0DnUyWKa6iMBW9wD85S5Nmk132C5yI/udm4GsL+FcheAT+3Q9+PCIP6X
 OEyaiJ+urUbgPBi38tVFarQLWxl8XqPREvQ/BbL+QvnFvwcINPRDHW5oVJvFEOUe6qoS
 pyabyR2hkopsNvYog5Q8NuGchX62Rw9kecT1ighPjmjz70QjVP0YpQ6Fcs9lp40uzMyk
 GAje5Soe8ibi/T0cZSJp0RIBwAEhSc0434VSuv646eaXj5yRgC4vKExsG7mC6ZaNrcUW
 srMuaDbUUWkc+bnr4gPFwzxg+OvisnXKS0ZN5BTiY3VAAu5dF3WVhFLqS1eCyiPvIUvW
 DZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780163985; x=1780768785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Qq4YwfARPlOW9viqyChETMuwznTjciLLUPiLAEnbBw=;
 b=DFybn9MiENtI+7WxMi/qYMlkl+IgXYdEbDqYfeS1qOt1X2xqelNP71lh3q0X8t51Ax
 fsgy30P6F3Q22jK8aSlu/SZewYDfyB5/5Ei85RA/DxQELI13EwlA5hT72YaHn0aJa622
 l4mhRSLs+EHJZTEmaZ9xfKyMdOFv/klkVePQBxIJwlICtCVhtrVddA1GaVEv6qR5mTAk
 6/a0/YcgP89uKA68P5sCcGjWWnSE17XXH8L7n+wpxEmOAiLtUviSzszHJB6vWi+MoV/9
 Xw98qjEFy+1udS3vCsdXlvBW5y1cxDD0OwH6kjc40H7kwobKs+8D5RgAlpex5TW1rnqL
 oxpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GHhnOyGGpdvDV+aMaeSpOO/9AheIu8kWxJyUBRTagOF+KtcJp8c2mNHstlYOkV5YGQPSY/b/j42v1@nongnu.org
X-Gm-Message-State: AOJu0Yz/NghNM5Tj43TPxCWLRQveoICIfJgPtC7cb/GX6vaWQdwMNwxP
 VyPI4BM7gIxL/1/o0MWJT6jb/R1TXPJK2OTG0m5QWGlJGc6z8GJZGKlDjWHYo9bZiA==
X-Gm-Gg: Acq92OFQJISkus47Ehq4gDziXaklTF5QjvW6V9RCJcF7X/C5iIHQOgMPwcQHCDEOmFa
 AVJz50ij8lFYYL9Y/jGvYi4n2V6lzxLXHT0F57ym+flHLtDrbeiHQzpiCCHe/4xfuwSKpTWhDGH
 /+X1WhbxlGuLuqKjpYkTYLGfF4sYDdZdxUFr6BkymmNqKXnl2H5jO9tBdnNuD9JEgIkGqZ82D7W
 q/pw7slgRAjTcdjAB8c1kPShes03hWlB27i9lJ6dxMJcSJ8N73AuZ9pG3NShZEIpDlXPL7E1aSf
 o3fPijRZuKJMAAhK8E6oUdmA74x3qWB2kT04hZa8FpRfHX79ZEL1l+2sWA4sQdiwaiMTtFopm7l
 n+Gy1Dff0atxKvYQTModREWlPdFiS+5M1siG3MBF6Ci0qs+4jBmCHWvPIUcemsR9tkkHAsBwG/b
 f74RgI9YJ5ozZla3sFtalKgGx50TuURnEbn/BeGOK7c404+b1yxEHy+TOra3HjKAd6hUDLUmE7S
 K3HLEyQ3L+ZpIQuxprSrZ5p9CxqC4yivTrji/G71V6t1rofv86/TyLCrgDXXchaTThplK1t
X-Received: by 2002:aa7:d98f:0:b0:680:ccda:55b9 with SMTP id
 4fb4d7f45d1cf-68c8c55ac8fmr1635492a12.16.1780163984921; 
 Sat, 30 May 2026 10:59:44 -0700 (PDT)
Received: from bou-desktop.arnhem.chello.nl
 (2001-1c00-3406-6b00-0ef0-9076-8e32-4758.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:3406:6b00:ef0:9076:8e32:4758])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68ceb6f98f8sm521699a12.0.2026.05.30.10.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 10:59:44 -0700 (PDT)
From: Boudewijn van der Heide <boudewijn@delta-utec.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com,
 Boudewijn van der Heide <boudewijn@delta-utec.com>
Subject: [PATCH] block: switch to co_wrapper_mixed for blk_lock_medium() and
 blk_eject()
Date: Sat, 30 May 2026 19:58:22 +0200
Message-ID: <20260530175822.10321-1-boudewijn@delta-utec.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::52e;
 envelope-from=boudewijn@delta-utec.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 30 May 2026 15:55:55 -0400
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

scsi_disk_emulate_command() can be called from a coroutine;
when req->cmd.buf[0] is ALLOW_MEDIUM_REMOVAL, the synchronous
blk_lock_medium() is called, which hits assert(!qemu_in_coroutine()),
and crashes:

	qemu-system-hppa: block/block-gen.c:1692: blk_lock_medium:
	Assertion `!qemu_in_coroutine()' failed.

blk_eject() has the same problem, it can be called from coroutine,
because the same vtable entry (SCSIReqOps.send_command,
scsi_disk_emulate_command() here) calls blk_eject when req->cmd.buf[0]
is START_STOP.

Fix by switching to co_wrapper_mixed for blk_lock_medium() and
blk_eject() instead of just co_wrapper.

Signed-off-by: Boudewijn van der Heide <boudewijn@delta-utec.com>
---
Observed crash on fedora qemu-10.1.5-1.fc43 on x86_64 host using qemu-system-hppa.

trace:

Thread 1 (...):
        # 5 __assert_fail (...) at assert.c
        # 6 blk_lock_medium (...) at block/block-gen.c
        # 7 scsi_disk_emulate_command (...) at ../hw/scsi/scsi-disk.c
        # 8 scsi_req_enqueue (...) at ../hw/scsi/scsi-bus.c
        # 9 lsi_do_command (...) at ../hw/scsi/lsi53c895a.c
        # 10 lsi_execute_script (...) at ../hw/scsi/lsi53c895a.c
        # 11 scsi_read_complete_noio (...) at ../hw/scsi/scsi-disk.c
        # 12 blk_aio_complete (...) at ../block/block-backend.c
        # 14 blk_aio_read_entry (...) at ../block/block-backend.c
        # 15 in coroutine_trampoline (...) at ../util/coroutine-ucontext.c

blk_eject() has the same path, but req->cmd.buf[0] is START_STOP instead
of ALLOW_MEDIUM_REMOVAL inside scsi_disk_emulate_command(),
so fix that aswell.
---
 include/system/block-backend-io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
index fd84723d9d..7368ad5c09 100644
--- a/include/system/block-backend-io.h
+++ b/include/system/block-backend-io.h
@@ -81,10 +81,10 @@ bool coroutine_fn GRAPH_RDLOCK blk_co_is_available(BlockBackend *blk);
 bool co_wrapper_mixed_bdrv_rdlock blk_is_available(BlockBackend *blk);
 
 void coroutine_fn blk_co_lock_medium(BlockBackend *blk, bool locked);
-void co_wrapper blk_lock_medium(BlockBackend *blk, bool locked);
+void co_wrapper_mixed blk_lock_medium(BlockBackend *blk, bool locked);
 
 void coroutine_fn blk_co_eject(BlockBackend *blk, bool eject_flag);
-void co_wrapper blk_eject(BlockBackend *blk, bool eject_flag);
+void co_wrapper_mixed blk_eject(BlockBackend *blk, bool eject_flag);
 
 int64_t coroutine_fn blk_co_getlength(BlockBackend *blk);
 int64_t co_wrapper_mixed blk_getlength(BlockBackend *blk);
-- 
2.54.0


