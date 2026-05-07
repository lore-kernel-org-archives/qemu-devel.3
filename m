Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B96CD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 04:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKqX0-0000e5-TJ; Thu, 07 May 2026 00:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqWz-0000db-JI
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:40:13 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqWx-00047V-Tz
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:40:13 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36535998b71so207598a91.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 21:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778128810; x=1778733610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=My2S6d1QZcXh6qabXNMTSl35HL9fJpY/xbsHbQJU1s8=;
 b=i6W/lzTY77KRTQL6FNPnhLPRU+CXFAYGnTfgekFggQQ1EPuLH6GsY7RmgcKQZbl4Ok
 yp3A6xmAPVRKHQIna5jAJwwaQkqtUrEQiFN0bW9Ji4Fuc+uv7cZw/CJqotpT01ijiyex
 zETHFGyJs/eRu7JvgCk4fnScga3B4XVdyxkbSy7/qodMGYtkhTmrDXIDy8c1ZE/550bu
 2zNuBod4QYBzVpxhxpQZfhlJlVDv9LxVD9f7cyhAk0ajWay7ic9SJhP9qqfQWFrlymkz
 g6OqOEsigYgt7Acluh1gq2nzLTY1jjP4j3PDR8fCLm+mMC3T7nnHY6xDqfjPX83KTdxw
 WrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778128810; x=1778733610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=My2S6d1QZcXh6qabXNMTSl35HL9fJpY/xbsHbQJU1s8=;
 b=pl6mDbTNqcFJPB21fswYlNFfoTXl4GR5cnjh8bmqaMuEs03jaaiRsfVxmwnRYQ3sJ3
 3lcOwvf6ogXc/iLSXZYcwGoqzbJlFuSiAwFRC5zQymfPh2G8A+hwkygSfuzzBkSEbeay
 OiHYn4DiYtlaTZ0EBvhCKMhtaUMhj9FXXIWQrt2Fob31MnHDly9wl5lC4IuqQwD+NMxd
 ZqIfb2EUivFKHPxQch1bxxSc4SiHD9LQzyerOZXdRmH5B1v0w8I0UxAUJOSkmxUZ6Wcc
 9ODNc7rCTAiLRkFw6FdhxfA9red846FmSx8lIFFwiEdRdC0he28BMvLXuNk/RMoyzce+
 7R5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ89MsVzEe1xtXXDTgP5nQH8jBK1AVy3R7auRx/lDpYKys4RJZNiuv2L1RDQzwbL3WvGK4Kw9ymctSA5@nongnu.org
X-Gm-Message-State: AOJu0Yy/o9F6T8FHvCMf8Hk2uD5gZ4H21swRbtr8sVa9oEWqOqGGCOUR
 kii7DH2r7oTtVdWPqFglHEoqfUh1J0WUlwcxYFk/AuKwex7gNCQC+rQS
X-Gm-Gg: AeBDies/MqR140f1cVu/XfApLEC2tQ0n8kzKlZzOFhyXS9HhNgMmfJ7JK22n9dIitsv
 fRUvM8n7XpmvKQXGvhrWmbuAAh+UtbpfzJOTcT3b1h2XuWiLh9FQFIckMinvRMWSLfKhw7N6EB6
 tYX6iX6MxmvZKc6MS6YoS7VvkqISnDvc1rMwHzj378w2YVuDqbAGQnAzlJ9kmmT2N3gCUNuhK3U
 SJna0C4tRC3XfzqKXbm3mH60XHJ5Rv8wZmG3Psygb7KHmoijTWPzSBQlb+Dv4KdBAlchcWNQwHA
 Dlw8J2N2kmF+LqAtR2UnLt9FuEbAp+6gA9cI5wsJnu12gSRZgRn1Bi30ea3Srzy0QdhQShED8gq
 Ldp8Q++Ioi2tpVyMjDHnXVlvQ/4dKVJqXx0vfug7elltTsfv349LJN0tMHyoI/mjh6kLZ94Op08
 x3F3DuQuCTs/ZwBbHrgUfNkIhBo0q1qZ3RkN1rts0botica9tmTGg+LsliedJwcKnFogliWOjQP
 g5Zwv4a
X-Received: by 2002:a17:90b:5486:b0:35f:b230:5889 with SMTP id
 98e67ed59e1d1-366053e90a9mr1128822a91.6.1778128810475; 
 Wed, 06 May 2026 21:40:10 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4c87678sm6018505a91.12.2026.05.06.21.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 21:40:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v5 6/9] target/riscv: tt-ascalon: Enable Svadu by removing
 Svade
Date: Thu,  7 May 2026 14:38:34 +1000
Message-ID: <20260507043838.45652-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507043838.45652-1-npiggin@gmail.com>
References: <20260507043838.45652-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Ascalon supports Svadu (hardware A/D bit updates).

QEMU makes Svadu and Svade mutually exclusive, remove Svade so
Ascalon comes up with Svadu working.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 69649462dd..97e3567264 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3204,7 +3204,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_ssaia = true,
         .cfg.ext_sscofpmf = true,
         .cfg.ext_sstc = true,
-        .cfg.ext_svade = true,
         .cfg.ext_svinval = true,
         .cfg.ext_svnapot = true,
         .cfg.ext_svpbmt = true,
-- 
2.53.0


