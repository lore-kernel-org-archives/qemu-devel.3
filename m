Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524ACCA9EBD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpsM-00038N-TF; Tue, 13 Oct 2026 23:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsI-0002pb-PI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:54 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsH-0001oC-90
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:54 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ab9268d90eso1792783a91.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949312; x=1792554112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CPWVywykmMjhY28EXkEn+o4MKqXIZACMUINLYzr0uVQ=;
 b=eKM/E7AmYFRi3kuSWwC4ZmefJS3FgfCYtowEmJI1nTUAVag5vOlqsq5DqDQjwzgjRA
 zmyoBLHL10x83efWkFKjvhBL6OSmtuVykWnKIkoWlkAvLEHjeJO0Nw5lM16qP5p9XcEQ
 +jlfWrd1KAZrNLBCTe0+XsT4OXgWl7oRyunouu8B6YwUde6b09c70TCvEpT5S9XjPW6r
 HiJZ0Eb9MyqCq1jpHOhpFIBEKja6FLat3Tmo/XFTFxEz4utd1k3PgjuEByWzcf62KmoQ
 cnSbQ1sL093pQT3PdVnLz6cCkM34TWgkkvqkTvd1OjGl/nXGjruf/2d5pZpLXgo8I63O
 ilHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949312; x=1792554112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CPWVywykmMjhY28EXkEn+o4MKqXIZACMUINLYzr0uVQ=;
 b=XmE0vkFsEUH/3z/vQwJfox9RNnwxwGuhzPwbe1YaQjVYo2JcdKCK37WqaENIq3LMKO
 +2uXTzbnumvcyHytRJLpmvQPCI1kitoPv/a8WlbqUYtNKVvKUU0YAsiHX/zbwX33Xqzs
 2BIi4wkRlktMr/7eWOq1Mly++64rhmYvoc3h6mGmG85wKXM9rj1Wc+pLMN/vjc625s71
 jQyN40xt/WrptLkAkQajz9v5tM25XSpOy7fqyLjS7DyjDUPUkMKZ/ZGdPrGMHIUw0Vvg
 eDiUZnffl4G3CI5i52oQ5LqtEVj6Q1CdWlSHrUWjbEbnX6Jz6WLEwAqKGrhI+r5ZIxEv
 Ts6g==
X-Gm-Message-State: AFq9FYJl5TSqveUYbVhRVazQvleY8lOh9KXrbXfS3hKuHn9Pom4gXnDO
 PkW7r85t9f9JklfetGruERhHlAmXPUceAp6xEGxpRVr0+s8WZ+AEiSYGE6wmRg==
X-Gm-Gg: AYBFou2OVq/IOhCkIf7z4IH6c/2z7TF4u8C+XEZcxVXbV8QgxReN4uaue8Vo3kdanGB
 aSrx0C86rE1VY3DfwT26S5hgffJZEaJ2kpWbZzlYR43+CHhqDHYMFnqP/8WhFaj5KR5e4Rse10X
 +H8ev1hMbJTPZPmH0bGZIxiSKJrQ7PPt7kqBE3vezQpsPYwPFlDxJ3XmCQZ6IdGeb60liKZjPLW
 u+8C2pmD9Vfjj3CHgqRV+liWrPal4MdqW6xQqkrr65Y6hHvz7MOHZqFfwuQxfxMbHA1PdfqyMZD
 mVB86tKJLv7TaE6BAFuA4L1V6JVE8uyA0mAd2rSkGp/YDJ4oRJek8xspz4xyTl7hDg/6raocKVR
 WjckbW0vc5GZFSoUujjTcH57TwePQMzeeCqUSfmMD9Sjv4BGRW96C1TFwSywno8OarmsV+4STet
 qDg3WSgb294Ibd/JJQPdNKQew4uXc5hir9UoDahNY6oOoNtTHu5d91jHFJ+d5D7egEi0D7Rc0lA
 zIKj4i7M9kp5v7e
X-Received: by 2002:a17:90b:4b92:b0:3a2:b038:c931 with SMTP id
 98e67ed59e1d1-3ab3acc7b09mr10409097a91.40.1791949311894; 
 Tue, 13 Oct 2026 20:41:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:41:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Rick Richard <rick@sloservers.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 47/52] hw/riscv/virt-acpi-build: Fix the UART register width in
 SPCR
Date: Wed, 14 Oct 2026 13:39:02 +1000
Message-ID: <20261014033907.3332383-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Rick Richard <rick@sloservers.com>

The riscv virt board uses a 16550 UART with an 8-bit register stride,
but the SPCR table reports 32, which looks to have been copied from
arm virt, whose PL011 has a 32-bit stride.  Change it to the correct
stride for a 16550.

Fixes: 3e6f1e61b4 ("hw/riscv/virt-acpi-build.c: Generate SPCR table")
Signed-off-by: Rick Richard <rick@sloservers.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20261005104008.214588-3-rick@sloservers.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 8e516ec114..0475dcb5c6 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -246,7 +246,7 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
     AcpiSpcrData serial = {
         .interface_type = 0x12,       /* 16550 compatible */
         .base_addr.id = AML_AS_SYSTEM_MEMORY,
-        .base_addr.width = 32,
+        .base_addr.width = 8,
         .base_addr.offset = 0,
         .base_addr.size = 1,
         .base_addr.addr = s->memmap[VIRT_UART0].base,
-- 
2.55.0


