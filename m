Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E58C982DC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7WxL-0000hl-ST; Fri, 18 Sep 2026 07:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WxH-0000YI-Ay
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WxF-0001tv-QM
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789731633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSWQgz5THc8C9jmZ5BauNB19MPOXmarbNtQHtbkVRKY=;
 b=N87cqvkwj7kZsVnHH8UjOfD0gz4HTFbuXqDZnXhEzZ6QCZwbuiaZhq/hWFW4cAeYakbOFf
 Sm0sBcvL7gPnBOvMvme5Wp7FDFfSuSacT9LQjYr4O6XRshNNEeFodbR5f40i0N74s/hHkd
 gBMTy1jlR5DXZsHy8ha9oD2yHmq8BNM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-Jl3Nw1CwNWyoYgKxU8SFEw-1; Fri, 18 Sep 2026 07:40:31 -0400
X-MC-Unique: Jl3Nw1CwNWyoYgKxU8SFEw-1
X-Mimecast-MFC-AGG-ID: Jl3Nw1CwNWyoYgKxU8SFEw_1789731631
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5328827bb8dso12667981cf.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789731631; x=1790336431; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pSWQgz5THc8C9jmZ5BauNB19MPOXmarbNtQHtbkVRKY=;
 b=m72Y2ylyTdUFcrepuyhyqQPn2+4se0OCh4qLABKx+PCKZI4AOoF09dFbmHg1tdYYF+
 4Nu1k6F/dbWqkxwDi9B9rQTInPu/1DmqXq+6NZAopqXfD2BMmdyBKKRY0M65jsiEaeuW
 MPp+ZTu6wgoosqDxyIXHwqVOFY5J2lHMbJDq5mu2g8xgP/Mnx4VicDoMEKU4mLnDT/oX
 zaJ8wilOX21D1zBNuilGUK04HSpIJ/esokvm64TS36n12Yk7zxMg8FBu+wiv4Me4w0/Z
 Yx2NUnvZ7rcvmF740xF+Faxqt3FMA2ru7Sh9Mbdp7MZsOCXeDf/NtG+astmFpPEc6NHw
 T6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731631; x=1790336431;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pSWQgz5THc8C9jmZ5BauNB19MPOXmarbNtQHtbkVRKY=;
 b=Q7PaKNantbXm81TEoB9N2C6ua9aroqNM40Y+2ZPPGJw5hIsnmHmSyipbtt/ygK7Q4t
 XwjNMEglH5gfYawwwWiJLK6Eg+JcEOXduOFj85hDVYiv5LK4hu3F8G72OKrQH1AzRM+c
 XIAlxMA19Q35dcLwiGr9ktyrTncWje5Tdg09wOYSniHaqdtpXqSFTod5bNf/eTaFr5tv
 3v7yN86p9OtC2YJna4o8qFmciIpI4cn9BnDXi4zAUr0ykkbq8Jx/7sQTP/PO6GzTGdbU
 XhMV+sw46s+13qFKDNxvUi//Lo8j/ykRSZNDoRQdJ/0uU6/ZE8xucyDP1f7i7mlR651j
 A2Hw==
X-Gm-Message-State: AFuF++mDfzkx7s6rmyxPZnaCjStLaNa2I3FWzi7bhpJqwpDixkkNHev3
 dtwuVID2jcrmUDG6a6mG7UdGRXiRfRFiOesI4JBGC/ugdPldulyhDT74/b8xqBwM3m93dJIftCf
 wvfpHqHX74ofvGHUDUeN8WFbQj/ncXXzbfT3n+jiMTebIkciyoAEHtcCHWxWEuWh3TNElyWPLR1
 9xIzCNfrmeVyH51GLzIvY9+hkc0iqLuWGQSV4dFksu
X-Gm-Gg: AYBFou3y+o4yeW3MVy8W5Fyw/uJvjS+bl4MAM//Rj5M6huErQjQ1ym4Ft8FQuPscxBG
 JfBFffZdAfo1gy8+MGiqKOVAQaurBGgvjFE7ldJxb78O6bnWeVl8dvDsIVjeT8nLmhrEFR4lsvn
 gkpPNF1L4AfvUOt/yILTmbJAXS2SUTpCE2EGXcRO/TeyDcVtU/zODB+ta62G/iwrJkzSQQiMlTD
 3NfytmCugTosviGx9UNIHt524/tc9DZwt8qB1nXyhMI/TIMlEg9kPSskr9a6IwaTpEBquiT2TRk
 c0xO1MPjRV3h9+l56cmGa4czjD05BDaKRAbry8gm0adfaZhLefhowtZCkjP96TCT39AetW0NdYb
 VYlXJkIqwz0V5E4K/+xjq40bmT56siMgoqUePUMnZU2jewHV7ltdCbF1M5x4=
X-Received: by 2002:a05:620a:3909:b0:939:ff85:8067 with SMTP id
 af79cd13be357-93bdc72b140mr291660485a.30.1789731631127; 
 Fri, 18 Sep 2026 04:40:31 -0700 (PDT)
X-Received: by 2002:a05:620a:3909:b0:939:ff85:8067 with SMTP id
 af79cd13be357-93bdc72b140mr291656085a.30.1789731630560; 
 Fri, 18 Sep 2026 04:40:30 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93be0ccabecsm119006285a.6.2026.09.18.04.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:40:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 09/11] machine: Remove 32bit limitation on ram size
Date: Fri, 18 Sep 2026 07:39:24 -0400
Message-ID: <20260918113926.831204-10-peterx@redhat.com>
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

QEMU has switched to 64bit-only hosts for all system/user emulations.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20260818172012.3052821-10-peterx@redhat.com
Cc: "Philippe Mathieu-Daudé" <philmd@mailo.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/machine.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8939ae1666..92f7be52a1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1626,14 +1626,6 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
        clock values from the log. */
     replay_checkpoint(CHECKPOINT_INIT);
 
-    if (!xen_enabled()) {
-        /* On 32-bit hosts, QEMU is limited by virtual address space */
-        if (machine->ram_size > (2047 << 20) && HOST_LONG_BITS == 32) {
-            error_setg(errp, "at most 2047 MB RAM can be simulated");
-            return;
-        }
-    }
-
     if (machine->memdev) {
         ram_addr_t backend_size = object_property_get_uint(OBJECT(machine->memdev),
                                                            "size",  &error_abort);
-- 
2.55.0


