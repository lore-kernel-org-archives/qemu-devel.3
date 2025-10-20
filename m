Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC75CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmW9-0007A4-En; Mon, 20 Oct 2025 05:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmW6-000790-CW
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:49:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmW2-0001eM-K3
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:49:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so25021745e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 02:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760953760; x=1761558560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCybBwF6V8sY1v6Bxh03dNHepbxx2PYShng4zrkVJvs=;
 b=EtcEuUTJ7kgXLnv6cn+9KRRZz/YSE+8zZgoh5kH7zyEDWc2rhpADD6Pg3pMYRv8FVX
 HbrjSbiD+DKKls+m+mFWc1chZSYPqMZzbkMUAyX+f4K+Yrx9u7QalhhO0AP55Y5OjdST
 QGmlBSf1isi4eoaYj7Spg/kyME+TG/F4CVtxQovkVfZXY2hZiPIspse3dwMrBlsWDYLg
 y89sN4K07gYxS4ScOpDSPPntoH0s9qrdBJWfWVQdySb9kDS/YHbrtBMuxCeXJo3sTjrt
 xWtn5jR/a7XUhNNPDRwbZm1iPiiaDPFd9mYeJu8ikiKc+PHq44r+ZB4wD+2RJHhSkRtR
 ZjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760953760; x=1761558560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gCybBwF6V8sY1v6Bxh03dNHepbxx2PYShng4zrkVJvs=;
 b=qGWJ7pJWDo+B5+xrcq2xdJBRx/mJQnMjHBS+tmPg9B9x+I66E+30yMZti4c/96oCVt
 zF5Zew0YCnZWPHCkSXpJlZ0IJCzqlzbB/NdrEIRGlqDajJTJYONVN5qdoFa8v+bqldTF
 hn/wO3RteYYQ1S5fNIDlwWnHr99tfEB5WcWb22HyO+J+kj5SC9IS60VkJxw/eiLf4vxT
 pZdh2aKCYjPHsnY0B+p3Bq/W290ZaDklOocObyRWWDGDvarxE8tHcewRUCXuEhgl1Tb2
 QYmeBxd9cUzIIY+okUpw6NBEOlX54qT732K79ia4AZ0L3A1x0mj2aYvzjKJHh36FWCMz
 x6nA==
X-Gm-Message-State: AOJu0Yz4ncwmnq5t0H5YSXEw9XrM+n5+o4v3cOR0tPvlgJTcR+KCG+Y4
 E8lzcyTb6b41Fr/lAPgvNNRjKaJ0E432vKpn2s/oTUk10yWZ4tlUOFBkwyx9H6Y1cYPq+X+/MfB
 PUwurLgk=
X-Gm-Gg: ASbGncsrb4Kl7rR5B8+LfmaIYPHWpBqqYfM5N2e9qH8J7PG2gr+uO/GsqIFlu23MaHR
 WRH7ScNmDC1U+QjaOA+onCJ92TLtgL5zoeXNHA11m1ZHnk3Z+1ERX47YEdf6fYi8cQWLffObYFX
 nalfgx80P2RaBN862Js83wf8EixOt52vU/JsE8HppgUx6211MsID9aGN5G+lRwTLKwh78oP5L+6
 XWLm4i2Uq2GtHvnJyxhtQwYxaf1XIJuF5p5BBp1gNTrYFk3bksgn7FYzf88DiA8LfKRFDO4rjtp
 a37+0te5Mqvcpo9LOvdzCZ7LHy4jwdD2MsoQDsMvkqnEAU6SjGL6mjsb+3Tr8Bfn+3r2O5RRcb/
 ICizT6Bpiin3PQKaRhm/43/QBWrzNbt+TKMwCqMe47mawYO4OBUxNZaQXSO+ljbZVMq3HnrL2Fs
 5cMUL4KeDcKZ8zVm46bgwzzBDXNkXNWKo2MvyGdJRVj27dmvIDhw==
X-Google-Smtp-Source: AGHT+IEHmXNWtmKp5QRazYaA2cfTtkPfZw5w99KPEkQAtn0TsqccJptgUBHKv2uxNZwNf306A88feA==
X-Received: by 2002:a05:600c:4e89:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-471178a236cmr87010555e9.10.1760953760193; 
 Mon, 20 Oct 2025 02:49:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce3aesm14650950f8f.48.2025.10.20.02.49.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 02:49:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 3/3] hw/core/machine: Remove MachineClass::fixup_ram_size
 callback
Date: Mon, 20 Oct 2025 11:49:02 +0200
Message-ID: <20251020094903.72182-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020094903.72182-1-philmd@linaro.org>
References: <20251020094903.72182-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The MachineClass::fixup_ram_size callback, which was added
in commit 5c30ef937f5 ("vl/s390x: fixup ram sizes for compat
machines"), was only used by the s390-ccw-virtio-4.2 machine,
which got removed. Remove it as now unused.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 7 -------
 hw/core/machine.c   | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 665b6201214..d0a69cd490b 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -250,12 +250,6 @@ typedef struct {
  *    It also will be used as a way to option into "-m" option support.
  *    If it's not set by board, '-m' will be ignored and generic code will
  *    not create default RAM MemoryRegion.
- * @fixup_ram_size:
- *    Amends user provided ram size (with -m option) using machine
- *    specific algorithm. To be used by old machine types for compat
- *    purposes only.
- *    Applies only to default memory backend, i.e., explicit memory backend
- *    wasn't used.
  * @smbios_memory_device_size:
  *    Default size of memory device,
  *    SMBIOS 3.1.0 "7.18 Memory Device (Type 17)"
@@ -325,7 +319,6 @@ struct MachineClass {
                                                          unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
-    ram_addr_t (*fixup_ram_size)(ram_addr_t size);
     uint64_t smbios_memory_device_size;
     bool (*create_default_memdev)(MachineState *ms, const char *path,
                                   Error **errp);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 681adbb7ac5..7aec3916e80 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -648,9 +648,6 @@ static void machine_set_mem(Object *obj, Visitor *v, const char *name,
         mem->size = mc->default_ram_size;
     }
     mem->size = QEMU_ALIGN_UP(mem->size, 8192);
-    if (mc->fixup_ram_size) {
-        mem->size = mc->fixup_ram_size(mem->size);
-    }
     if ((ram_addr_t)mem->size != mem->size) {
         error_setg(errp, "ram size %llu exceeds permitted maximum %llu",
                    (unsigned long long)mem->size,
-- 
2.51.0


