Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DE9CCA472
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WSp-0006zO-5M; Thu, 02 Oct 2025 23:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSl-0006y9-Bd
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:07 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSa-0001Af-4e
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:05 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so1458358b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462065; x=1760066865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=549xD0FIECX3W+z8z4ISC2P5+4gK7alChONN2FSd+Tw=;
 b=nXhO7gJx1YCnYy5UJ2JQFTXuv1gBSsFBisKorUeY8wTwg/jW5Evuid67AMQk30v+OB
 AQmjBk4aKaeE08jRoGinWB+3EuGd9yJ+aLeVgiIZJ8DCAmn+YS4BjYAVqix+UKDeOLAe
 LrIJlWjzoNd8NCUCkM9AZe+qfagOM/qmHJn/BNJyFspJlTDMBX8W7914Bj5rRiMhlmof
 0b0vR3UJ5kZOsNBOG0mYvw3kgX8VliPou+gRE4laT/xt7H6DsU8dKaofQ4bTojHFWAeY
 u7sboArr3M6dUyf2slNSncUvp5Vyieo2Z9y7nsUjgBILi2k/A2RBt7Z24ZsnlUXTh4oT
 CdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462065; x=1760066865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=549xD0FIECX3W+z8z4ISC2P5+4gK7alChONN2FSd+Tw=;
 b=RQAVFxjTR5VzUt+XvJxaOH1kPxPbO9+cY3zTcNmUbL3EGovR/67+CPk7LbwCYZyWY+
 Nf8kzGeIh5JGLi8+7ZZ8l98nPXGJjF+jlXFhwgy9nPjUQcZntlcJ+PxzwTXONSB5aNJR
 lAM3OXUSbvu2C8TbQ3y84W/0VqByvFQ4y7v0OAm4C2ksijONKOr4od4LHApEEi3DSbAI
 Kc151uKIzmxDxBEu5ZXe76nNBG9VoDUEAlQNfFezqrGRPnCpFxiWdekZFtUb9nZzO/n9
 gNeL1TDg48BvFUVgsa25OQdwO0pe7c957uXBgiEqSsn7RMl07PRKMOXswv+Pp8PHLqjQ
 ewZg==
X-Gm-Message-State: AOJu0YzVUuEl2MCdtzQGhtcmZ4qCrsjFnoqDAPdZGxki2Mr0vpZUs0Xf
 T60mRzrR5dBsPOAifuoBVW6pHQz7LFBopRbiWaC0E2k/CbKV6+TYCv8T0tw2yQ==
X-Gm-Gg: ASbGnctBf6CXTP4KBm3wYssOsJD5vSgIval2dCweVx755KC6HQVPrLJ7rB0i6lL3gJu
 m8w8rGFLrNoM+/BJ/mnhH9msl/ifNXWgqGeTGHjOoDNYW3HQ7E+wl8jLC4TAwH8gjQiUanA6kCF
 ZHTfSX5saNTruTWbOdYr6wG0pP6avZinJUAt2PNCYwvfeA5Qx54ZU3Oqr8A2xKkHqCnPyEF7sRB
 dXhqTMHq8Zg146QW9rIiRFXn2CgWb4UfHQYskWsU3zp+kQk6HyPens833aQScxiMoIzr8jDrmUh
 zgXe3NULDAhV90RTJNkLD+ROVMgeNBxaG2Srt4YJSbdsNa3hWaHYrbBVsiHNpRyh4mzIqhVxmkV
 D5c6wt/W55UyHo1JXpDW7+plqd1XJYbQaeO8TpDR47aevxJ/Q1I4ucUnjQ/KRwZK6jGDVjrZs9X
 ZdCRNsln8DgGh5Ej+wTLUfLqybsZaMYLharqDKzzYH+8vidbiocQPl
X-Google-Smtp-Source: AGHT+IHekvoN0ZMvB7rV88EudanPA8KUeT5pGbbu/qvaiIFM++PPlmiscaSsptZZ+NRR1yin8fUfuQ==
X-Received: by 2002:a05:6a20:729c:b0:2da:f4be:c8c2 with SMTP id
 adf61e73a8af0-32b61dde689mr2024181637.31.1759462064982; 
 Thu, 02 Oct 2025 20:27:44 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:27:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrea Bolognani <abologna@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/26] docs/interop/firmware: Add riscv64 to
 FirmwareArchitecture
Date: Fri,  3 Oct 2025 13:26:54 +1000
Message-ID: <20251003032718.1324734-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Andrea Bolognani <abologna@redhat.com>

Descriptors using this value have been shipped for years
by distros, so we just need to update the spec to match
reality.

Signed-off-by: Andrea Bolognani <abologna@redhat.com>
Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20250910121501.676219-1-abologna@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/interop/firmware.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 6bbe2cce0a..ccbfaf828d 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -85,12 +85,14 @@
 #
 # @loongarch64: 64-bit LoongArch. (since: 7.1)
 #
+# @riscv64: 64-bit RISC-V.
+#
 # @x86_64: 64-bit x86.
 #
 # Since: 3.0
 ##
 { 'enum' : 'FirmwareArchitecture',
-  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'x86_64' ] }
+  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'riscv64', 'x86_64' ] }
 
 ##
 # @FirmwareTarget:
-- 
2.51.0


