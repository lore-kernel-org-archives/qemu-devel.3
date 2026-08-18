Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9306EC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNUg-0002XV-Eq; Tue, 18 Aug 2026 13:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUV-0002Ox-OW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUQ-0001lo-BB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787073641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJ6HOzO2VSd9g5MHqxs911rUNYp09m1J0f+4TZ6YmZ4=;
 b=T48qfJCTOpsRA2tEmN9OC2knwwpdwo3TlToeCubSq6PMnRemXGGKv49o2ruHidBUSZPHl6
 X/uvzxRHCfZ2tWR9Z4MmaKWDUyz9QGhO8FG6K26AWXlaXhwwK1KQtL7useqRTw7g1AsU3X
 4kds2+u+FHCejBQJsZuP1PyOShFrBdQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-f9EUjtTIPkmd21PQ5MZaYg-1; Tue, 18 Aug 2026 13:20:39 -0400
X-MC-Unique: f9EUjtTIPkmd21PQ5MZaYg-1
X-Mimecast-MFC-AGG-ID: f9EUjtTIPkmd21PQ5MZaYg_1787073639
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e820609d9so16533485a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787073639; x=1787678439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lJ6HOzO2VSd9g5MHqxs911rUNYp09m1J0f+4TZ6YmZ4=;
 b=DTfuflsClU8K43ueEYnDUhIqlsP5H0POf/kusjUe+TFbvs7oy7W8l4Ah9Rj/rLr5qu
 PGbnvZP3+AtbrPkkoyHLKiIEW5/fIVqw3f61wC8ceW9vQbJHSfTKkY/6DivwNhFYdRQv
 r5fQwGivW23WsaeVrsbPFzKRfni91Qeo5+la4VOyh8LTHl+41+jQZr+7HeRfvrRrN2bF
 XA9n20fnmqiKA8Nq5gPvJqWJN1r/qRU5ksG8MxOGjnA3LRdyyulplwBa6eZ+wh+skpOb
 c/u4wbgxiN27VcIGGdxOBNgWie1g50jxSrNrLQq5k6IK8Svl4R+VWNwhweJbsk8qgQrB
 zo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787073639; x=1787678439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lJ6HOzO2VSd9g5MHqxs911rUNYp09m1J0f+4TZ6YmZ4=;
 b=DHqNGdU0KOpmoBNbCTGBDmXfiNeSfkf8KS+5Nmle5Fp5WfWsTZwKcvr48aEK+yQIy7
 CjLl1yHDDNY1JH9C8oAR6dNDt7d3olKxNUUBNePKfOkuUVIdL2ot/Oe03vl2Qgc1/6PC
 tJ9hmhqpTn740TE1S7G4Nbcz+UMai0wTdWVUyVw0YTzQ2Fp28od3hG9cwQyQpJJdCRDe
 Gu4WJgXKa0TQSssUDTZKeOWmSS3txPuq6KPlDn7i7reKSHRXSRNEFNxOBAGNkbt9pSp1
 jWrzIycGgCBlxuEycaarWHRP4EEGwKBZuP8EC9jaZKuDfMmHcCDgIuTUsobKVD0HVRfY
 YUUg==
X-Gm-Message-State: AOJu0YzUwh9v5KflMK1nyvaxRJM2iRixBI5fyN3OzHMoLWP1LDNTIKcv
 YtinxzT+6iHRqttCMOuw9VweT0NPnYSnlRrwD6JxSPkRcaoQ5VB581Zod608KHx193EzHG9bia1
 9tR9rFrO3D1ueu+IA5wMKLRn01F3RhNNuRMxVQ279EIOBATJ+FsSo7ZVdcYLzcbyEMwfd8X+iOD
 /Ehx9W0GaxiYJ6H+tuaEexSefvHhxpDJm2oRihZQ==
X-Gm-Gg: AR+sD12pCFdoZpluxhoV2MjcZeTye4wY9lyw2Qk3MjfSV8mMHNrlPgNfCoZ73wH/eCM
 nQ2r5lnA7RHGNpo1sN7WGEYt/zAug59YIOAL96g+F/qI1FaXtvF3MulSEKS3rqsqlmUzhbN8is/
 1roV3UZSiPxXWB8p7JhzCDfsm7D0ofZdWY/yqMQ1dmxYQ3QXWek17A5ESF+m9ywui4pZxO7ZxWO
 yHvXeGVnwpJkklAG493QH1Tute6gtAv/AA4h/ftfQCl30d1kXXAvSVd9/kzWuXUuQ263clIUbVT
 A4qcGRnL7Wyn2BPKcSpRzuZVaGXu1JVEUp3r8IM832qf7D9lLZczlgYrezrmd+2L4yBeooxmGx1
 dhO553sn6zvP60vZ/XLt/3FL5mt5g9w8CsyBDbbMB8Bl9wS2goyKxFS6c
X-Received: by 2002:a05:620a:1985:b0:937:1995:227b with SMTP id
 af79cd13be357-937199535dbmr111823885a.0.1787073639022; 
 Tue, 18 Aug 2026 10:20:39 -0700 (PDT)
X-Received: by 2002:a05:620a:1985:b0:937:1995:227b with SMTP id
 af79cd13be357-937199535dbmr111814285a.0.1787073638379; 
 Tue, 18 Aug 2026 10:20:38 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4584418bsm36560896d6.17.2026.08.18.10.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:20:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 8/9] hw/arm/raspi4b: Drop board_rev for 32bit hosts
Date: Tue, 18 Aug 2026 13:20:11 -0400
Message-ID: <20260818172012.3052821-9-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818172012.3052821-1-peterx@redhat.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/arm/raspi4b.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index e1595a875f..5f7abbb4c4 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -111,11 +111,7 @@ static void raspi4b_machine_class_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
-#if HOST_LONG_BITS == 32
-    rmc->board_rev = 0xa03111; /* Revision 1.1, 1 Gb RAM */
-#else
     rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
-#endif
     raspi_machine_class_common_init(mc, rmc->board_rev);
     mc->auto_create_sdcard = true;
     mc->init = raspi4b_machine_init;
-- 
2.54.0


