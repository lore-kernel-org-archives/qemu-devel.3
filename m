Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1655C4829D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 04:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra7Hq-0001Gq-9E; Tue, 13 Feb 2024 23:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ra7Ho-0001Gf-0v
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:54:20 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ra7Hm-0003Ix-Fv
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:54:19 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5d3912c9a83so1194433a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 20:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707886457; x=1708491257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lIw0HHLdL2NvcxZjQjlv25wKknGxFlW0JytLKiI4Hg4=;
 b=D2Qh9p+Co/RcTofJ1tTj01Rkymwp390GXOI+esGur0lBaYsL3P9P5EtReMCGAvZ7M4
 uwPKEy4UVMHn6WLZHe559XQiCMKVzaNk6hPhcL1Du2YQ2jfFKEa6fOOdZG3AiT+vdgmO
 76YcHWQCGrf97DYmJbGdyvEdSKAsNZTGtKwIQZJAlJGTE9B2etFsbZARuvYOYwXcK1C3
 IVjdRsTL5Rw6hMWUA83F1ykQ0Z/waI2dOKCFGqOY2FX1jub2KG2aUaWZBxYO8+pqhGoz
 rUV8W+hBzc/0piTzryWsqlxmEVYlGNFnK6nTM16AtWS6EV083Pfjx66raEE+Tuw7k7nM
 Ux7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707886457; x=1708491257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lIw0HHLdL2NvcxZjQjlv25wKknGxFlW0JytLKiI4Hg4=;
 b=AEUkJNzAgCOEbqf2vdGQ/Wuzo7uC9nml8hQvALgUs/eaWanHjJezUMcqQ1oiJ810bY
 WFtA8xvoRQng20UtaYiM1hg50Eo/RIaSrapTbDIJWGjC24EccNWG0qdB64EIKKhrt/zY
 r2sJAyphCj5LjGX+QFhvU7JVsZoNRtV4OCMOiGHGSoopWVu9oklIj6MxVG+fruZuYq7m
 bLny4Vc7bCSIEaE2SKqXoVUlAvIiylXuuN/EJQpZy7boKHL7R+CQJcqSRJ1x7xFsEkCi
 03n/PaCmJNH9L4C0Ska7Y/vkeY40YRdZ4MjF5OuNpRz8Eq2zFmSoDJe1YPkE1nso4GyL
 V6vA==
X-Gm-Message-State: AOJu0YxGxSsjIRgubV480zbchv05yx7huUVLZiDjrn8I21PFI72bZ3R4
 +4WeP5SDPrLGFEpI5MZ087/WD3k9LgC6MjheM3ynl5ueQKGIcQjONayramB85m57Yei1TEbmn8i
 r
X-Google-Smtp-Source: AGHT+IFKiH70Ks5V98n5229QD/JiBZ4mOP7E1OCdTfLgzIgKWEGB2zICGdCWVK6weKlODPDMaxaRrw==
X-Received: by 2002:a17:90b:ec7:b0:296:4177:6404 with SMTP id
 gz7-20020a17090b0ec700b0029641776404mr1483067pjb.11.1707886456687; 
 Tue, 13 Feb 2024 20:54:16 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 jx13-20020a17090b46cd00b00298c5ee3159sm387339pjb.49.2024.02.13.20.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 20:54:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH] linux-user: Remove pgb_dynamic alignment assertion
Date: Tue, 13 Feb 2024 18:54:13 -1000
Message-Id: <20240214045413.541677-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The assertion was never correct, because the alignment is a composite
of the image alignment and SHMLBA.  Even if the alignment didn't match
the image an assertion would not be correct -- more appropriate would
be an error message about an ill formed image.  But the image cannot
be held to SHMLBA under any circumstances.

Fixes: ee94743034b ("linux-user: completely re-write init_guest_space")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2157
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f3f1ab4f69..d92d66ca1e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3022,8 +3022,6 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
     uintptr_t brk, ret;
     PGBAddrs ga;
 
-    assert(QEMU_IS_ALIGNED(guest_loaddr, align));
-
     /* Try the identity map first. */
     if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
         brk = (uintptr_t)sbrk(0);
-- 
2.34.1


