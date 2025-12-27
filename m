Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EF9E8FDD4
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQv-0005P8-3t; Sat, 27 Dec 2025 04:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQs-0005O0-3q
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQq-0003Mq-Ha
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Saf9PETHsvdIuPhzv3hNmYIifKozrOKriQHb+ziBQiU=;
 b=goJEhM4X5HEYERcdHyhKo7DYw0oOdMJnBgw+mnoxQ3siG6IbthnQivcRMRwhKGqdqVCCw4
 1D1/ml5MMuakTcqwmW1JN9ve5+8hyfGdnSBR+3scoD9joSTtdscqkCmdgARTBQCsMSuXfB
 eiTUNjoweI08ZpOhfy7xbXRwthlqCnE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-m-WjB_NaPVO6xIhky76RKg-1; Sat, 27 Dec 2025 04:17:50 -0500
X-MC-Unique: m-WjB_NaPVO6xIhky76RKg-1
X-Mimecast-MFC-AGG-ID: m-WjB_NaPVO6xIhky76RKg_1766827069
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430f527f5easo4791414f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827068; x=1767431868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Saf9PETHsvdIuPhzv3hNmYIifKozrOKriQHb+ziBQiU=;
 b=b3AzFjEcJhNZ7IrRCdVsFhZBU5yIohVT82O8IuvsmJ+ycCqtPUxLfL3Lq4tbEUhL9a
 YDQYGNtr25aKDEWI0w3sDmfaRgZBandVV3djN/1JtQb8Dh9pgR8+nyfqxrrs4x5mnM26
 qPCfewyrJ0axLV1Z1IH/v9gG5Ps3TNsSCDqw4mrulsvzOU/lZYhvlv+U9Io4lTwAkGJL
 JHHT1SKbp1897BGByorbe8VPzuqH0oubg0s8ft4Pcjp5v/Feb2ivxVcWj3RbLy53Ek++
 vgHwJfaifqzx650JbR8sBjPqOEAk9pocSaRmey59JYkJiax4N1rith/QiG2DvU5zsQh7
 yxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827068; x=1767431868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Saf9PETHsvdIuPhzv3hNmYIifKozrOKriQHb+ziBQiU=;
 b=U+ACRvjED/JTp+DF50TEkwwT2ARy7wkPj6U/iISfgt4LClr24gWkWBnzarSJn/Mrt7
 xX/ol6rmR25tsvfd2UYMaacPQLdJCcqmpMuY+VQI1W97Ku5DMjvxK16Kl4O391lND8It
 sKgSOLvKAs5ztcWR2D+TTmit+5GFVTjlsqMLVgZ9MR34Q55nCp4by7BCm2SPI6tmFyQl
 8sNoP6dVagXG6dzxtLA9HOUDXzBLM8vDKwjeQHNukrYuGe65kp4121c/ZNB378zKWshA
 GNKZRG0tPBHvKI2NjYnhPpaP2oiYIcQthKrYTqP/6tVuHMtQa4VsjWcU7iAUce8ApAfC
 CReg==
X-Gm-Message-State: AOJu0YydNQyevH32N8S+M/6KnHBycfOjLUI4R0uhmjGuf3XfiPOt9D18
 FBHvwaIDVG/wPWn84e4olvPHooNtgV5xpe09gRxRsU4eSbtrhRWENXfWAFcIjza96zOQFApnATK
 JjBR7Q1C+npat5aaCRZl6S78YNLXMBmpExOrxmg2IoPb7eWWUGPetAOMNVp1xdjEAvkB27ohlEb
 k9kst0PcSAh+1xJtYFq5VvDe7z//2zi9GGLhDPAa5j
X-Gm-Gg: AY/fxX5A3ByN/LlW73+0kMzUJx2jJoKZwwyYvxwycqpWKf55V3l0uJXCTEdzjVHWW0B
 pH3v1hXt2gXBIUyGK0M+FavhVxIs0NGB/2gS0b0Qjdb21ALbY/4nJhKEQwwJQmBZ6lOP0M4m4Au
 SNXRRaKv9VPp1qEABYVTJm/Iv8bHK9c3ju+18M8EGRo14Gl/JuvTfjTRqY94AvCtlOBB8xbegjb
 7yObZwg8tdaJJk8+QE4FDlQhAR1dAWzztbRdMwpcdneMNFIhEe5PQqej/15hzJopbmmicfbKtwB
 ZcX6l87FZZATasbJr8J9cSmwL5orh4ZrWUI3c+/U4VCeFuW5Wb2a+0GkMwY6uvcc3D1Dh/t+L91
 DD3j62u6nnm+c0RdQTXaslrHZPr2PgDFukCqkoC4oJhUmTfYJGKw8AujTnghZaulX0H9MzdYXxj
 GgxcfDuvTK/tBukXs=
X-Received: by 2002:a05:600c:4f08:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-47d18b83218mr273763375e9.1.1766827068126; 
 Sat, 27 Dec 2025 01:17:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf36DEy3WgmEV+PRop4O1VCaEYDnttE/4kNKkHZerpkgnFKSo475+eyM2AGyHovOYeR1fMIg==
X-Received: by 2002:a05:600c:4f08:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-47d18b83218mr273763095e9.1.1766827067629; 
 Sat, 27 Dec 2025 01:17:47 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be279d6d8sm483811885e9.10.2025.12.27.01.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 045/153] hpet: remove unused trace events
Date: Sat, 27 Dec 2025 10:14:32 +0100
Message-ID: <20251227091622.20725-46-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/20251106215606.36598-2-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/trace-events | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 2bb51f95ea8..f3fca6fc9b1 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -112,7 +112,6 @@ sh_timer_write(uint64_t offset, uint64_t value) "tmu012_write 0x%" PRIx64 " 0x%0
 
 # hpet.c
 hpet_timer_id_out_of_range(uint8_t timer_id) "timer id out of range: 0x%" PRIx8
-hpet_invalid_hpet_cfg(uint8_t reg_off) "invalid HPET_CFG + %u" PRIx8
 hpet_ram_read(uint64_t addr) "enter hpet_ram_readl at 0x%" PRIx64
 hpet_ram_read_reading_counter(uint8_t reg_off, uint64_t cur_tick) "reading counter + %" PRIu8 " = 0x%" PRIx64
 hpet_ram_read_invalid(void) "invalid hpet_ram_readl"
@@ -123,4 +122,3 @@ hpet_ram_write_tn_cmp(uint8_t reg_off) "hpet_ram_writel HPET_TN_CMP + %" PRIu8
 hpet_ram_write_invalid_tn_cmp(void) "invalid HPET_TN_CMP + 4 write"
 hpet_ram_write_invalid(void) "invalid hpet_ram_writel"
 hpet_ram_write_counter_write_while_enabled(void) "Writing counter while HPET enabled!"
-hpet_ram_write_counter_written(uint8_t reg_off, uint64_t value, uint64_t counter) "HPET counter + %" PRIu8 "written. crt = 0x%" PRIx64 " -> 0x%" PRIx64
-- 
2.52.0


