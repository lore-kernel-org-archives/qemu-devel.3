Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAFECAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 07:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v77Dk-0001b8-8u; Fri, 10 Oct 2025 03:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77Di-0001aJ-53
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77Dd-0007wD-Hi
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so10993005e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 00:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760080029; x=1760684829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVb3aMnHodhOx3mpiCDcdapvdpvFoNzXZdFelJ9Oang=;
 b=I+RxmWslWUlGm/7/FeC3s+DErOd5494y2lEfeUe8G74NnwRssRk53K4WQpLHwUDocl
 ZLyAIbBXO32MRi4qF7b7l6gRhOKfPso0YTkThueSYR3mFs/nr/cV4zP8Ygg+qVjPib+l
 Rq0Wu2zdu0XXdycoibGcxpXg/BFDHoXFfadOmzr76PYmp+yq80twyyLObN4KqioxN48F
 l50hGWVU96H5PWPjlccq4nhhPx9rLf6RkpwRPHpmmXzSvsGyKvsDvjvH6YTd5dUHSmML
 ROKd15KeyjFBSggF1KxuV4W7g0GBmpQyp+7P9eW36IPeLwlR2RFcJopGA2oTSsBYHqRE
 Iykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760080029; x=1760684829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FVb3aMnHodhOx3mpiCDcdapvdpvFoNzXZdFelJ9Oang=;
 b=wl7XrRu9sNmIcM19MWUZh8WW2TMGhSVt/KLZFUb84cnp8tUTfw77ZafaWcgJ6m2Z4v
 f8VjZ3TyeurJTuZF1HXOhb1jxfD0ALDs18H+O84D654NmFcymt89xHuOILG7wz/gDMML
 6pdZIy0Olc+NmXyOFYxR5hmL57hBG9VGUeawqXcQPluZFvrGHyQfg3AIhjrTpfsBlvjW
 XiluC3BegXLwZ8BcK2TlFZhti77K4ZWqV+3mcb87B8yYXBgVAhsxyt+EIgdlaG4RMLa0
 RNR5F/N4VCy9j+exkTFi9CUkQ2f6+ILxZUFE2Qnll4nM/arMv3cHMQ6tLI9U/5yLvF1+
 9+nw==
X-Gm-Message-State: AOJu0Yy7Bna0eGtb+TBrddFwAfhymVa7T2ZBdRAjZpDDDYkU5zBO2z5j
 XnRgoaJYJHX3onAClk7SRwP7uXZPekpsjL/4PN1/0Zrip7xKMXy8KLSf70F9AtXkVihJMKGBXYa
 Ne6nyftbTFw==
X-Gm-Gg: ASbGnctB+fqMAxSuUufBUMzWBLnHRmFp4BMGHRo/b/59wYsly8CsL83Nap2kmEQbqIh
 hLHqgksPTKU2EUAaBNzy5HtzlFxIb9iaGaej6dAmZTaYBdFw/w5bg1VJQQ7pCk/Q3VIJMHVXpvz
 BI1kbnsDCAgDp2FZ5izS7ypkxHLe/84bwSVoI3/Msqyd2Id9INjkazXModHxbgVo9rW5FtaIIFp
 tCr5bYfuuGTn0XpG/qX9J/aT2nQ22MuINikHcZ5VQggslaUpbfpI6l/EiZ/rUvJ5/9MePQGT5y/
 foaiRqWV343hjojSMG3NFS82dCK5841BPVWqMcXadZFv3s+mMzTcs2st1s5ZBAiPVNWpMPTjbd/
 /C6hdIgzRl9S40yXtnxS0PPBqIKatz5FLbJOoJuWEPXuN7VX8QvzP6vs/qaPbZNHDQe7CaRAVGF
 2YvxvRsqPGxP8Im+d1mX6xq59M
X-Google-Smtp-Source: AGHT+IGl7vWcLyjhDRqCBUzsSKadWYhbRjWcuS1ysqrXLlHN2VmyOgnRPd2/0t9oAyVvc96tB02saA==
X-Received: by 2002:a05:600d:4301:b0:46f:aa8a:d2e7 with SMTP id
 5b1f17b1804b1-46faa8ad4bamr44608945e9.4.1760080029343; 
 Fri, 10 Oct 2025 00:07:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab3d2c1asm53511785e9.1.2025.10.10.00.07.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 00:07:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/13] target/openrisc: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT32()
Date: Fri, 10 Oct 2025 09:06:49 +0200
Message-ID: <20251010070702.51484-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010070702.51484-1-philmd@linaro.org>
References: <20251010070702.51484-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Both OpenRISCTLBEntry fields are of uint32_t type. Use the
appropriate VMSTATE_UINT32() macro.

There is no functional change (the migration stream is not
modified), because the OpenRISC targets are only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/or1k-*
  configs/targets/or1k-linux-user.mak:5:TARGET_LONG_BITS=32
  configs/targets/or1k-softmmu.mak:5:TARGET_LONG_BITS=32

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 081c706d02c..fa054e528bd 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -26,8 +26,8 @@ static const VMStateDescription vmstate_tlb_entry = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(mr, OpenRISCTLBEntry),
-        VMSTATE_UINTTL(tr, OpenRISCTLBEntry),
+        VMSTATE_UINT32(mr, OpenRISCTLBEntry),
+        VMSTATE_UINT32(tr, OpenRISCTLBEntry),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.51.0


