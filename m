Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CEECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOe-0004Bk-6l; Sat, 30 Aug 2025 11:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us156-0001uJ-Gn
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us14y-0000Ym-TE
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIZ/GEl4kDZnmqyRnHirJQEA0qTP8X+DRdscFCyUtVA=;
 b=FNcjlZioLMFxCTpr0mv4JM/KNc7jtd9j4W96FAIqOlj+YJMgPuK4NA8xBNPr/tsxAMRD7g
 goExU1QzT0gOaC2KvzO+fYh0pb+kf+9xGGhjrYULJ0uDgr6RwsDAuB3ggHp0ctI72OfC1I
 37mAF1p6cnVdzM9X6beOtl3fte784rs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-qwF_9CVeOBmi4zXSukoHhQ-1; Fri, 29 Aug 2025 11:31:49 -0400
X-MC-Unique: qwF_9CVeOBmi4zXSukoHhQ-1
X-Mimecast-MFC-AGG-ID: qwF_9CVeOBmi4zXSukoHhQ_1756481508
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b7c4c738cso7744605e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481507; x=1757086307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OIZ/GEl4kDZnmqyRnHirJQEA0qTP8X+DRdscFCyUtVA=;
 b=mC2kerPsz/kHKtH6YiW8QtvmJJbY2dDS51tBnl1BApUafPii4RhdA3elYAywCRzAJS
 Va2I2WWf3ZIqb7YFsxvRfetwiaUC7GWDKttOgnIzmaNHKfjeNvmPb4DS4lHECH/JWV+C
 /SHlFf06TwBxxqCattcl6tx8fOjge/BitKa7HPhKAdnMTZC4OCEVk9eXp7Dj0oQw2o96
 EdGKdZSlwMWzLePf0e9o4SR0uRHeIS2hJxPjc7Xsn/fvc35BDxAj3mnHcp5NZeI9i4IA
 vWHq/OtFQRdfM5YUOxh+Y8vvp5AWWV+qOlKzr4H0cSZ9f40+emCoXOM68cmjBIaXXFwu
 DyPw==
X-Gm-Message-State: AOJu0YzPN4MdCaqgLeZIQxyy8n1YjeIvc0PulBiY7aZo++6+IIxUpM9H
 Zr4zW8Xpk4YvTGjOTLBjW+D4LbpiU8h6EPM3KDS0sT3RWBqdwNNgXdOAsoKuCIdNA8El83FBHf8
 xr9xGo9we6eE2iunGMPs9oJ38WRqCSzLq7BoCzRj5goLc/FmXuYHT61GojBZWGSHyzOKOjC3CXX
 Tvhn0z3cgBx0i9AHLLrwwaYD5e1qoV9lGGDz/uMV+6
X-Gm-Gg: ASbGnct3/M+fXIgcVqWNElv2HhS6jQUvoUpOvUCgW8CzG5pSV3F1xFlj5H/pRpfvIIr
 9uyHVF/JYj36f1NE1vPcq+BR7dFYKKNChARFHBPVAJRnAfAdMtKvAxo73g2adndvgGYS6nlmQPS
 Y8i7kZ+GpVOuEUg79Rt0sfkiuS4GQPYHm9nv1vuk18UV0zcfeyt1OVAR0oUaB8MObC5wcnEacf9
 srrhVPouad9RGOW1ZhGDshyIPAZljgeTpGL4iyi70h2qXEpl8Cf8IjdtXnUUjB5lH+AFRQSQTMR
 Tg2Q++4MRv99muNOjUY6A49JI6hZ0vDeH14amX4dcJ8zOm4dvJa6JJxw1odSrq2LpJ8hlUXUUiw
 rw1yWqhZct+XCABiy0LXeT0BYa09Z5RgNRR/Z4sfYBLA=
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id
 5b1f17b1804b1-45b5179669dmr207493335e9.14.1756481507442; 
 Fri, 29 Aug 2025 08:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh04SToA6KYjoF4S/pMtkzcIwTEud5hYK9UbJmkplEPhrtexHOBlCZlpUS2Fp2EfJGvi8VKQ==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id
 5b1f17b1804b1-45b5179669dmr207493045e9.14.1756481507029; 
 Fri, 29 Aug 2025 08:31:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7d23ddsm42693385e9.4.2025.08.29.08.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:31:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/18] cpus: remove TCG-ism from cpu_exit()
Date: Fri, 29 Aug 2025 17:31:10 +0200
Message-ID: <20250829153115.1590048-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829152909.1589668-1-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now that TCG has its own kick function, make cpu_exit() do the right kick
for all accelerators.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/cpu-common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index ca00accd162..3fa9fa82228 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -76,9 +76,7 @@ void cpu_exit(CPUState *cpu)
 {
     /* Ensure cpu_exec will see the reason why the exit request was set.  */
     qatomic_store_release(&cpu->exit_request, true);
-    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
-    smp_wmb();
-    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+    qemu_cpu_kick(cpu);
 }
 
 static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
-- 
2.51.0


