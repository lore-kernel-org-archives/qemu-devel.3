Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61690E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhE-0006V6-S6; Sun, 29 Dec 2024 02:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnh2-0006T3-EB
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:34 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnh1-000270-0Z
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:32 -0500
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-aa6a618981eso1397254266b.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457189; x=1736061989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPB4XNLstlc0AegxJ7G/7FURT7P2TWUfnqz8PPlgcsA=;
 b=YCN+NZKbC6O1x6tQNfVcZXjw3lGz4sNZa1oIyVvEHB3Y6GStRFf1wsqaiV+0ERu5tN
 ojWyIau1/I/NwloEylbHjwEmVuW4lC5DvX1ZuH1faR+4R6L4aAucpkSI0rcbbgCIzcmd
 sMdXH/YCZoeWuWsbrLHTMofPUo2UVqC1XC9JqWMMxprqaXUAcKYGBzX4HYzRlANZkyzP
 rJSNogZBiryDO2/B6COaYyhuFei8SeThqYyfA0BN2YqrCGloFibkjoRwyfUVxTJbmAdH
 i+KXS1G+TdH3FMCXY9cn5mPVByErhy43cRCOvRhTZ4LdpqbjypqWCiiI6Bghm6DmTSni
 vWLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu4CWAQp+VPLXQsE89ZNJyCt3SAtQq+GyIfsfmxb3Lfq086a9CHDeiAsz45hEchDbg21OBa2/KtjCp@nongnu.org
X-Gm-Message-State: AOJu0YzYO987byMqSGBobUI95/T+ZDeHZIozbR1W8p8XqyE68CnZmI5l
 JFl11jiBoc6t4w5b6eABeJjT2yCDgkHNlHdCY07pkqyQFKwk4wfEx0f9VQ==
X-Gm-Gg: ASbGnculaIfuhGRtBp3UEguf9JUCjCZ4+psLyxLgmB1c4BcOtO6+nubWTuW71JgzFVg
 of8z+KsmNVAu4y8AOscw0hrfMZm8B5m31MtuCnY7FmSh0nGYfUqj7kle8/2ByersxnhJfZHt6OA
 alFR6lzD8J3f543RK5TakAEdtJeQH/qAi8eA/LZLON1aP0SG13IEVyAsTAJyELmoYeXZH9Z5MQk
 /elcIkrClusbfbh48Syob1/Z/tLOdaGQRCrekhiUXnyjOUgYO+Kt3cTxTxZcqbd9m4Eusv3XoN4
 7dU=
X-Google-Smtp-Source: AGHT+IHR62IazP+nCv4oXviE1FM/RuaTGZMYXnrLfj9foh+YjVn9q84bHyoYMbj/6NLuxqRewktS5Q==
X-Received: by 2002:a17:907:2d1e:b0:aa6:aedb:6030 with SMTP id
 a640c23a62f3a-aac33666079mr2549158866b.52.1735457188769; 
 Sat, 28 Dec 2024 23:26:28 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:27 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 02/35] hw/m68k/next-cube: Disable the default CD-ROM drive
Date: Sun, 29 Dec 2024 08:24:53 +0100
Message-ID: <20241229072526.166555-3-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.46; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f46.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The NeXT-Cube does not have a CD-ROM drive by default, and the
kernel does not seem to deal with the empty drive very well, so
let's disable the CD-ROM drive for this machine.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20241214091720.49779-1-huth@tuxfamily.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 0ecdcea823..94d56b4654 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1067,6 +1067,7 @@ static void next_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = RAM_SIZE;
     mc->default_ram_id = "next.ram";
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
+    mc->no_cdrom = true;
 }
 
 static const TypeInfo next_typeinfo = {
-- 
2.47.1


