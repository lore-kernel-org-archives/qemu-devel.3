Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8FDCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RkJ-0001Zo-1m; Tue, 30 Sep 2025 00:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RkF-0001Z2-IN
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:13:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RkA-0000ec-QZ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:13:43 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso36006205e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205615; x=1759810415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6r7ywVdtgg6puBO7GNeh9QBn+ePwbPPQeAATrRMKjs=;
 b=ai4BE7uuSDnRX/1XL7A3GHTDWSpAcKPUOAcI6GuU96yWduVBnY6K7A/MXaTjdPUcHL
 VFc7/XElPoD8l4uIKJJXYRrejN7TGcgog7ASUXDqktrc2iJawujHcWz5QOPbnpNzAAVq
 4MCmxq+5xLch3H0FbmsCtfDGPiPmvkgw2HKbxlaiocqdotIBeD4EMIOrF/i2jrVc+8g3
 ixFa5caLHRBNzfJ/yVw1oBoupl5BwbnLiEmKUpx6uaLbgZLLn1evjfd9x5m/2bnOFf8U
 DyLa6jhemM2JzpTzsAb5MbqSfHsewZhqBopOdUteW5Uvi7GuVrX3Cxd9XiNsQqBJ0ndK
 zbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205615; x=1759810415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6r7ywVdtgg6puBO7GNeh9QBn+ePwbPPQeAATrRMKjs=;
 b=Xnn8Z2nrnexn2HOWrCRy5nGh5DDfjvAyFIVwxTMh2Z1N8Zg2AR4jp5XxtBk5FpLFO4
 gKIBNoGdsVtDImc04wuSuErvmggNS0S+gIT4blKxRqEiyzeDWxqpSm7LXsuxmfTfsDPF
 T32eyLv4IcYp3hwh3IXwvtBs7Wv4XASiOsoYwS3+e3ZlWWfNp+meGYQWAqPGHY3qcK6t
 JAxvFUY0q7GkQcnZinlVXE039N/FnrSWoawlNDulFPV8aDUBnhmU2vAi7dPEtu8CMzQo
 SnAxiiYgKTqNrXKT6hNHyHwRcb5fItVroenchWItTcot5gLMoWfwguFa9dNI+ybuR3J4
 cwyg==
X-Gm-Message-State: AOJu0YzspMb0rsvBp7SA5cDEuyVLmqXpuCiWrPvSFH/Zx/VwO8MjhTCX
 tUN03WeUEjCM3B2PcfL+82DHu3kewC8EwnkbIn8GLLaA8hmR6lcPzlAoGOcHXrg1uV0b8P8ng8N
 wwNyX+fu1tA==
X-Gm-Gg: ASbGnctZWYui0Qc4u1rDBczm4CtQnk2eugNdyCrJXnkWtEI4Vo8qtbHhsu6D0YeJmVQ
 8HqZhCCi4C92XeaWCaoBseGrAEfrIkX53m2KeUj7ymSxYH/7Hy2v1Bco6qM3MRLvS2NQLRD1pxv
 5KXANDanb5mah4RCTvNlYszNYabao8ldSK3aYy9wPw88wrgA+sEHfJaa/05jlmaMqgJ26MBlGoZ
 0mSAytcnYtbg+tdKnpmYagGozVgWvZApunklfYnjFNUg4b1stYuyayS469WdGx5Tyiwh4bwpmh0
 RPiSfR5rS+0C6Oy4Uhg44Z+sFiZR8r1CtleVqKiMvK6eV6iIYR5oCj795UqHW1X0xrWtINCFGRB
 HXTJJjoRzgiblYr6E7fM3IJlp6QFXchlaLno2YXyTNJuYxtB2qLwMm9p6FCHs9U6c7nn74W97C1
 +/d26iTDRdSCMgJM4UAElTNrLzN9jUO1M=
X-Google-Smtp-Source: AGHT+IGBpgGcnWw+C0SOcyJxraGAzm/jw0VAg2sebXTPvNY3JrfVFmYx+CN+ELmzscd2IQVrEVRZAA==
X-Received: by 2002:a5d:5f54:0:b0:403:4b6f:546e with SMTP id
 ffacd0b85a97d-40e47ee04bfmr14022629f8f.30.1759205614864; 
 Mon, 29 Sep 2025 21:13:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb89065b5sm20717307f8f.17.2025.09.29.21.13.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:13:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 01/17] docs/devel/loads-stores: Stop mentioning
 cpu_physical_memory_write_rom()
Date: Tue, 30 Sep 2025 06:13:09 +0200
Message-ID: <20250930041326.6448-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
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

Update the documentation after commit 3c8133f9737 ("Rename
cpu_physical_memory_write_rom() to address_space_write_rom()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/loads-stores.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 9471bac8599..f9b565da57a 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -474,7 +474,7 @@ This function is intended for use by the GDB stub and similar code.
 It takes a virtual address, converts it to a physical address via
 an MMU lookup using the current settings of the specified CPU,
 and then performs the access (using ``address_space_rw`` for
-reads or ``cpu_physical_memory_write_rom`` for writes).
+reads or ``address_space_write_rom`` for writes).
 This means that if the access is a write to a ROM then this
 function will modify the contents (whereas a normal guest CPU access
 would ignore the write attempt).
-- 
2.51.0


