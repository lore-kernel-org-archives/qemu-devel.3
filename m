Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A6ACD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWG-0007lS-36; Wed, 06 May 2026 22:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVl-0007Wd-Oe
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:54 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVf-0000ZS-TD
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:46 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dcc9b506d9so312573a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121042; x=1778725842;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxPzwDdNP8oDpYmA2hO0L7kRJDxaNQN6DWWEtCBD4Fo=;
 b=MBf3m4K9QtQiTULs6WyljpSbBWYXTmmHiKJkXY89tkRNzLrV/1uLCuuZgGwDDhuRQ+
 iQXyt5/WmBbDyktVRUuLb3mKW18Nass/bIcm56/0scv2HEPYdSKrENPLJRB4q/2wtoQl
 QIwcyav7DalRJjcoW3WNLFJ0iosPX3Nzn6R+KxAd5vad44LG6hwDn26N890cT18HT8cG
 l7eXQEPqIti2xAlfFkNRfIbmsS2CKm+I5V/ebffy0zGf6pVltohIQXuL+tYw4br9dyDi
 9ze7dN8oFM8RzVOvk5YavgcZg+91aVL1gruMIF/YdPz4BVke54zc1CC8si9HKU5yXAxs
 a2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121042; x=1778725842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KxPzwDdNP8oDpYmA2hO0L7kRJDxaNQN6DWWEtCBD4Fo=;
 b=MMmHpoAagw+WSOeoO30XO+2PDhG1B+jpB4LU0aDApMNzCFe0/IbO4TTSsRanloFyQe
 2t1Og0Fq9LgmaPhjprwSkP65WDDxL7NdU23/Svk3NbQpzBst+9yQTSEG+v4YZpZ4hd6X
 mFMJvdD0DCjjYzXntdlLjmFu7guEHxIXajpi7CtUM3IzI+3PtjJp1wTv5/1JvDpz/oL0
 ahZkXlF7hpN/sUPxUKRE5qH/nJ9mnvtADwHjOKhozlMk5XAN/lN9XqqzHgSiUocTyCbi
 8gy0lqli9nQ3+R+NHa1Dj4Dz3VJHFPX//bmlDkJXcy6z9atN7RadX5Dw59OAgA4o69Fs
 dVSA==
X-Gm-Message-State: AOJu0YwtderuZ1Isa93t8p/zp0eRO4LFUKJ5nwJjJXB7n8XTqvnvvSIe
 cSxkMXZ+RtqEX4iYPlqXEQ/Otqy1M5aPmSlvZApiwqL6nATfejAtIJGuayiPYEYXk1Rq3ZNdxN6
 /9zTyqqQ=
X-Gm-Gg: AeBDies7DKRtzPIRy14PVAyF/TZZbl2MBS32vUru2nJOexy+phtt3Hm+K9+T3J1pSsH
 79F8pMA2znvhSoVBqHqV8LYBeqzowfpTzoECe8bsWEk9+Gaz4nd33ViulgYt0EAOk1A6XW7j6LA
 d4qqajEjQIRo++00xKtdPOfhfwoug9hG4qN+LlTPdKWGiVhMCvdbGrniKRwAjCaWiLUmrA1clE0
 4ViweBsBe/LjaiTr3QHSnDuUv7GBMneGfCxjF2DqT0HJwgf5dq7PZcrUiE4WWNWyr5ml3CIm/Nt
 bzdMchzRMqchaBfp1oFQ0TEkIb7hNdvqlDVXGliH32lZ8JYYarvmoNPI1sN1QRc9ulmcL78wRuH
 9Ov/LE8z9sk41Dko3mOBRXtZzX8xQ9PARMgnAn5a/E9oEvXxPFl7YW6qXzGzyIe273eG8CDwkNn
 sTZJVuHNZYrUoWFkum4DJz
X-Received: by 2002:a05:6830:82cb:b0:7d9:b0d7:ffda with SMTP id
 46e09a7af769-7e1def7a851mr3880774a34.11.1778121042212; 
 Wed, 06 May 2026 19:30:42 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:41 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 20/25] bsd-user: Add do_ioctl_unsupported function
Date: Wed,  6 May 2026 20:28:22 -0600
Message-ID: <20260507022827.44499-21-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add handler function for unsupported ioctl commands that returns
TARGET_ENXIO.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 2d84adce71..69d1ea1718 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -241,3 +241,11 @@ static void log_unsupported_ioctl(unsigned long cmd)
     gemu_log(" '%c' %3d %lu\n", (char)IOCGROUP(cmd), (int)(cmd & 0xff),
              IOCPARM_LEN(cmd));
 }
+
+static abi_long do_ioctl_unsupported(__unused const IOCTLEntry *ie,
+                                     __unused uint8_t *buf_temp,
+                                     __unused int fd, __unused abi_long cmd,
+                                     __unused abi_long arg)
+{
+    return -TARGET_ENXIO;
+}
-- 
2.52.0


