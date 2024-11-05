Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C11D1CA19
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 03:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ATZ-0002c5-Co; Mon, 04 Nov 2024 22:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1t8ATY-0002bh-8y
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:43:28 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1t8ATW-00010N-Ry
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:43:28 -0500
Received: by mail-il1-x144.google.com with SMTP id
 e9e14a558f8ab-3a4c303206eso17309735ab.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 19:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1730778205; x=1731383005;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jo91p9Lq7o7wujm4a8/ClY5doXjvtmdnC3dXQPZG4wk=;
 b=NgAdW4S9TFqQISfYEStbo2jLLXNrGWPbdTTJ8RmKHObx4H/Am3ZUb+zCkmeVi5CO6h
 KZRSp5PJrQ21WJUOW/4oG2qME1jFT0pE+6HAmZLVacP/d5PrR/SQXzY+fsvSBYhZl+uY
 EZQyOJg4jUDT64WgET+5ShBoclFS5MXZy2qZIDKhPeWll/+9e8l92j1l5H+qc7BhEJM9
 QN60Ukylrl+x/jDHvSB5Vdkg+MjiAvqe4gei8eh14OQJg0UfaiAIAsMuW3137cUdGbPO
 EJe25hs9U8GIesneRfEiQmfXRQmoGH+2mqbmEvfp0KOF7IsDsbN2vVyk3eZd3iD05SHP
 zDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730778205; x=1731383005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jo91p9Lq7o7wujm4a8/ClY5doXjvtmdnC3dXQPZG4wk=;
 b=fXU1oL0jekUhED3+OJKx4bObAAXnkcQ/f8KhPmHuvuQwzYEGt7/GNgB7AXAKeCIBA7
 lD7HayYPAUiypnSGXCJYw0p+DWGHtkR6do7B4gJmfk3t8w1eMmex03ghwG6VM9wSjTXU
 BpEk0BCOe45+7Y6tjKIavkfIEh2KLZFu+mtiyOL88HVhlExsFcQpo1Ft41aFFOoEe4H8
 NKuLk/lXKtDCBvRZ3YVFTDYO0AyrOkOqKPOPhclGfG1IdZyB7dBBgCp/RylWoVVeZoM/
 rt6QoEsryPZMhjAQkkumh5FokV1EVZEGL7pkSYR0yf8aEUkne6PjWysciA7jZ6uD+AKP
 zG4w==
X-Gm-Message-State: AOJu0Yw3o22N2E/p3f/i4MD0twPJIQfBRUisq5ln/w9Qji2lm7tPiSKA
 Gmz++Lt+1MTToSNdhidJpoCiypDlJ3l7L5kHM+M+qku7UkvHTdLCqAqfWGEFoljbYkmVnD4Auv3
 dQba/I0YK
X-Google-Smtp-Source: AGHT+IET7Xn/m7FvBXt6a8PFNDoASQW8hDS/v2cpCtnpgPT4iOV1MwTFG6MSVMpTgQc6TL0zEm9Ipg==
X-Received: by 2002:a05:6e02:1c82:b0:3a0:9c99:32d6 with SMTP id
 e9e14a558f8ab-3a6b03cce83mr165094575ab.24.1730778205548; 
 Mon, 04 Nov 2024 19:43:25 -0800 (PST)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6bddcdcd8sm17162665ab.37.2024.11.04.19.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 19:43:24 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PULL 3/3] bsd-user: Set TaskState ts_tid for initial threads
Date: Mon,  4 Nov 2024 20:40:39 -0700
Message-ID: <20241105034039.31143-4-imp@bsdimp.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105034039.31143-1-imp@bsdimp.com>
References: <20241105034039.31143-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::144;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x144.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Jessica Clarke <jrtc27@jrtc27.com>

Currently we only set it on fork.

Note: Upstream (blitz) commit also did new threads, but that code isn't
in qemu project repo yet.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Pull-Request: https://github.com/qemu-bsd-user/qemu-bsd-user/pull/52
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 7c230b0c7a5..61ca73c4781 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -610,6 +610,7 @@ int main(int argc, char **argv)
     init_task_state(ts);
     ts->info = info;
     ts->bprm = &bprm;
+    ts->ts_tid = qemu_get_thread_id();
     cpu->opaque = ts;
 
     target_set_brk(info->brk);
-- 
2.46.1


