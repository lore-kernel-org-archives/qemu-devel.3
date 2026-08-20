Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09051C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yS-00040Z-Ke; Thu, 20 Aug 2026 12:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yQ-0003zJ-6i
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yO-0005RM-BR
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uM0ZoYWXf7Gdf3T4sWd5qAAdJiegNs4H/is+TXuEkmA=;
 b=Kj8yB5ZQ4XWIw5NYJrCskxbCfvCIldyZbB/f6L01ziLB9OrQ7Y3vL++DV775VjOhU7s+RH
 RV7+/XnXnoMtkYdlpu1bBwpNp3+GLx7UHQdmgtLRFVIi3FtprCLNr+pV0FUJSQh2hNvzVZ
 a6BfGCYLupUWQrqdh+LImbcoRL4Jhgs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-6Z8eYeECPh2FINRgCag_XQ-1; Thu, 20 Aug 2026 12:50:33 -0400
X-MC-Unique: 6Z8eYeECPh2FINRgCag_XQ-1
X-Mimecast-MFC-AGG-ID: 6Z8eYeECPh2FINRgCag_XQ_1787244631
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493bfc3b84aso174755e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244631; x=1787849431; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uM0ZoYWXf7Gdf3T4sWd5qAAdJiegNs4H/is+TXuEkmA=;
 b=AicKHeDesyRm3A6P6oZkp5DnWSq1BkfD4RpNqxtXioaulwDE1laSOzYWN2gPCuLsE5
 VUkDsCLqPOvVqS8Emhl6hSdvR3JsPLI6xGjA7pr0B2RDLPnoKRym2axrRyJFklNOJRa9
 7kBS7O0UEjHCtWomJ17DOrxaX/apreHVghVAAw1dvPgMI5wIfAK5t8oANndAVoCHIJRZ
 AH/7uFegFUywQ27NGqXz07T/vpgBanEUcgeHQKZbaWqCOkGXf4tMtzvo78rwNJ1rtYMj
 JUeARZu6zTB6L0elkwJnXmwXzeWVIvBkg1gxBJddwVvySGQ7bE+rKwmPZeZALN4xF8oX
 n5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244631; x=1787849431;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uM0ZoYWXf7Gdf3T4sWd5qAAdJiegNs4H/is+TXuEkmA=;
 b=GgJA8Um0AgSjmTT0p4oXAGW0u3VcTbgyr+HeA9PenURM+Bl5hnIONh+yOE7r3aEG1l
 SE4w/Dz3fqgS1qq2TSdT+6O5xoFk6CDMepq6Fk4LL+oxVC6P1X1xTYQi1yKpFJdMoqyp
 CU8b40l7bYr8qg+ecvT23ej+BrODljlLdzc09gt0BPcpICEx1XWKAzibaEiOUOgfR0lW
 e6a7tYbzs0SQK2ZrTXzC+uJHZA1InMnEkbkCnmZLDod+1rGrlifcYoQM0BRyOvKTBgsn
 ly30Hyz7vGSHgoO0MG8Z9Ea3ZBj6MdGya2W/LSUjGgHhIZGFzXsrwkOaX96H6C6c4WpB
 T4hQ==
X-Gm-Message-State: AOJu0Yw+6vzANu7QpGTBbE0xiJzDgbJ7X4TmZ9R2Ny36ISYY0D9rwobl
 VxgiUbeGumzsAEHed46br7c+pjN3UrVSANGJxwMWQKxfanMabFeZKFhfSbYTe6UkJTl6hnLtKMw
 0CQCeJ/YrA4qz9i8xANAKMCHjWWCbkICNE2iP75gI5lax4uAG55VsTcvQau+Gx+nnvHGNkaGaRf
 bO0Ty4oX3jHZzOEQQmHepqESFGC0Q+JiVpvA5bTUqP
X-Gm-Gg: AR+sD11mpcJCI/tj/KE2HzkTqYcHhAHy2mpOIietFL7qlBvUn5xCGgRgHblSVYK39GK
 xyEQTpduGzUEmcWC3N/XzwXiYBmkzOLIn4tQzkmJtgmasGyk1i3ToEF7JioLbSS2WoZqzFIqdsY
 Jhy/NWYJSRZqGraWXe9xwevUGmxbdwzQ/gd5MAvn8JmYLa/D1MUa+6wXzRNTIoV75Rxj8nE4Dfw
 DfUve1ShlIH+c0T92Qoc+Il6737NGC5dbpo1F46OC/X7iM6exfSqE2XUaMUHTR7kZ4nCUzONa/Y
 AIdj/v6SU0KhE7X/fcNb/a7Fofm7xwAIeIQkLKc/1Gffdc8XUrIMYHMYdJE4uzZkYfkebVmGye9
 wAA/46uVXies92jcDLkErpAPYNJIqElYeJ7W/79de1od1VBM4C75z136OGGB+prE/0spGpfmvxt
 hKJIo=
X-Received: by 2002:a05:600c:1548:b0:499:841c:2016 with SMTP id
 5b1f17b1804b1-499b8273456mr7304215e9.0.1787244630890; 
 Thu, 20 Aug 2026 09:50:30 -0700 (PDT)
X-Received: by 2002:a05:600c:1548:b0:499:841c:2016 with SMTP id
 5b1f17b1804b1-499b8273456mr7302995e9.0.1787244630386; 
 Thu, 20 Aug 2026 09:50:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e8b700sm157579845e9.6.2026.08.20.09.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 10/53] accel/mshv: introduce SaveVMHandler
Date: Thu, 20 Aug 2026 18:49:13 +0200
Message-ID: <20260820164957.1895963-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

This mechanism is used to handle more imperative partition-wide steps
that have to be taken as part of a migration routine. Currently it's
just a skeleton.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260710101534.664604-3-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/mshv/mshv-all.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 5e8756ede22..b34fb34d053 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -39,6 +39,8 @@
 #include "system/mshv.h"
 #include "system/mshv_int.h"
 #include "system/reset.h"
+#include "migration/qemu-file-types.h"
+#include "migration/register.h"
 #include "trace.h"
 #include <err.h>
 #include <sys/ioctl.h>
@@ -544,6 +546,9 @@ static int mshv_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+static SaveVMHandlers savevm_mshv = {
+};
+
 static int mshv_init(AccelState *as, MachineState *ms)
 {
     MshvState *s;
@@ -599,6 +604,8 @@ static int mshv_init(AccelState *as, MachineState *ms)
                                   0, "mshv-memory");
     memory_listener_register(&mshv_io_listener, &address_space_io);
 
+    register_savevm_live("mshv", 0, 1, &savevm_mshv, s);
+
     return 0;
 }
 
-- 
2.55.0


