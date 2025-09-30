Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09142CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VeF-0000dM-EL; Tue, 30 Sep 2025 04:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vdx-0000Nf-RX
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vd1-000138-6n
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so57979025e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220544; x=1759825344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbEYNZgIU6LqvkF49qge8kIj2C3i6K2S813tsyxbWwg=;
 b=S9B/JSOT6cQ0bUUtvtegSZls5Elu4+Y3uDHtJypldq/v2AtHDO5BB5dzQ1Dv8WeBG2
 GonIzetgG5kiI41qpVfl7oEzJ7uYi48LNTy1wWDdJhzzhkerEeje0ra6PmJoXZfgiTVC
 LL6xfiQEVdJh5yfRN5mlHeS9svYB/4VGRh/MXdW79RMFQwArqMTkvhngNMxkBWDWVgxU
 qbLz99YebYsgI8ItEsFM4Q5lgafi6M56cQUV0Hx2w4ckuBeBenBP8B2sWAGPfPuAOOL6
 fFxfX80b3wi14aVDoO227Hd86q1Z25LudgH8asgok9z0FwO1FRxjYxlkW5HjPBr++sPv
 mcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220544; x=1759825344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbEYNZgIU6LqvkF49qge8kIj2C3i6K2S813tsyxbWwg=;
 b=TwtwwspyvCWigo8ex+12IWdXIOzryppQbLQUVV0G7hUVpBk8L+7c5HXUDbwSOlRHKJ
 QBqvT09ssFcNezS9uhuW0Ukoain7nxJZsov6jflpOXS3nw7Zo6LNp9AJWwRZuon70bgy
 bO1buQtQ1DTTSIBRZ5oGj+hGzMUJlUGzIdLT89gR5MnW6gLn40CpWC6/QHOKJldjw75Q
 e+Uyy1cccc0JfhOuScTZrJf/zHeIoOXWfkJneQxcekmAIBMrSM+tmnz7341jYIFKNB+1
 dcGpf+G7DS515H4UrF8I00a+PwVg5GR2+AU20sLWO4mXq0OKvZRHHw8jJ9/767yyjMg1
 OwLA==
X-Gm-Message-State: AOJu0YwhINuDVDqsUKazj35ltUYEYRHH78kppzRnLB6G2FuIyKoPyOHT
 6gDLkHIaIryVK9chBqX+QsPXdOLGV5b+31hYg3wp4nrTDyOiuNyjUa8JJ/KuFNMw9FIOcFc8AT2
 L1f85XpO3Pw==
X-Gm-Gg: ASbGnctA/2imjOwbPx+iJxSOBB4nPIqygTYX25kzn87gcW2iccDbkzlQS/SlAn7+U/D
 85YCj/BFYkLRdtFOhwhuS5h8TvuQAS1QacLCW0aQxvoeATZ5HWOvMdABX/5kJ8UGR+xIB1Z3V/T
 udB4cmbywk8nyMVsQbF9aKuI/s/VGB+PNcPlq7fv2AFLhBu9f79NEOhfELAEn9T/nVJ8O2L+u2G
 3aZh+b4zIFtuiHAVArS0trDaYFVJh+cbwIk6vaQPzgf38krW1I4rGPB7bB/cSQy/iY+WhI4sdMC
 Pu5QiM+CIp6HJNWdtNnOqmjIRzAIW04fl+sPd/O94mPEwQIGhX5OdqgLeh4S/WUf4t2jAa4gWbR
 uWipm64jE3xXfuUIZ9BUT973G81TeZMj2Kbx5SV5UPqRdykwo60RjLmBJl1pQlhysc/QiBNMdGE
 3VG6+dRyHCxCRb73HZkkMBltp6kgE5Kbg=
X-Google-Smtp-Source: AGHT+IHMDbDhZ1qtfUqSvwy3OGcigy6OI6LXsB/syBvCuQ6w6sDdxi+R3qorHEXGNas+XOrL9i5DRg==
X-Received: by 2002:a05:600c:4fca:b0:46e:4ac4:b7b8 with SMTP id
 5b1f17b1804b1-46e4ac4ba51mr119307915e9.25.1759220543603; 
 Tue, 30 Sep 2025 01:22:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab31e97sm259738545e9.14.2025.09.30.01.22.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:22:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 10/18] target/i386/whpx: Replace legacy
 cpu_physical_memory_rw() call
Date: Tue, 30 Sep 2025 10:21:17 +0200
Message-ID: <20250930082126.28618-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Get the vCPU address space and convert the legacy
cpu_physical_memory_rw() by address_space_rw().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2a85168ed51..82ba177c4a5 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -788,8 +788,11 @@ static HRESULT CALLBACK whpx_emu_mmio_callback(
     void *ctx,
     WHV_EMULATOR_MEMORY_ACCESS_INFO *ma)
 {
-    cpu_physical_memory_rw(ma->GpaAddress, ma->Data, ma->AccessSize,
-                           ma->Direction);
+    CPUState *cpu = (CPUState *)ctx;
+    AddressSpace *as = cpu_addressspace(cs, MEMTXATTRS_UNSPECIFIED);
+
+    address_space_rw(as, ma->GpaAddress, MEMTXATTRS_UNSPECIFIED,
+                     ma->Data, ma->AccessSize, ma->Direction);
     return S_OK;
 }
 
-- 
2.51.0


