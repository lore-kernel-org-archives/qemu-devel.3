Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B468CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Igf-00051a-I4; Mon, 29 Sep 2025 14:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IgU-0004zB-An
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IgM-00030K-UW
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so34191415e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170783; x=1759775583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8vf9ta3nqwm/Fyb5G7ZjHvxKsRPPnP+TTAqHaMFdKE=;
 b=p6PuFORvTLr1q1tX1oMiJFYqxudVyO45cSHEssUZgjVdlirIFerLVCYFU00VaFr9YI
 B1onTLI7Gs3gewHWfLMn/i7/s/xqAmvndhvLNqMO9C9TVFWkz25QSAWXeQGmNbhCBuoV
 WmReD4t991SZnxaznNeoDV51cJxhHVLCrpVnoOmPaZK8qAoCgeYTIi3YcvotieYM8aUA
 RlkdekApg6up/cXMwLT8CIVLTVpbF+qyLte24yHT4yOWlUOKmC5u4iHe53MtW6MppBvc
 OmLQnpy/jWlNdLhrKtxVr+v90sjm0AjoGiudqKBhSPfQGt3ZlJA+b4VYZT0sHLQbeiLq
 I/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170783; x=1759775583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8vf9ta3nqwm/Fyb5G7ZjHvxKsRPPnP+TTAqHaMFdKE=;
 b=qTkh3XN7xTBMH7sTUI04ifiuV09FcxXKYBpc+eCv99mCsqaXNtQjmMdDbS/6Y6z270
 CfgceV8BHzNEVnLzwi6zP0x0UQKh2AsdffmHh9Xmq3a6TVj1OM70PSW9XwRCwFYeMr8i
 pt+s4Nn2wc3OHh0I1v7Fn9E4lrtl0kFXCdd4VlhAVmxx7keUzq5vgaj+PNvDlmGwt3Ue
 ev1EHX7AUGWIqQ711KqhWOWHgYnlP1Xjk0+AYT4BwkjDQAA2v0gYwEog6yzJpTNp4615
 4X45eaEIqim7T8/zBvABmUoxpwdJ2WNF+y+0Fjil/zF7eJuuBdRNsAa06xa5u2w/iAnD
 jCSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgHCe7qRsS7K1UfCVk/KnuGintk5aqwu1t2LEF9IkZyI/RmhwpWLsLOE/j+wU2aQ8spPerKgaNcHZN@nongnu.org
X-Gm-Message-State: AOJu0YxFexjF2cQYDqCwD/FWapv+CdP1k0dOrANlFQ0QQKLg0Q0HWV9m
 2xyQvE7HNgXX9FeU6P5m75QcC0ur0cskcWr8D2ZAWHYdwgZmEzcM9Nuy1eCbKsO9LX8=
X-Gm-Gg: ASbGncvckLi12B4lOiVJWGA3t7vneQrLO+Rp5tZUYjN5jSC7k3LvUoylMh850hLKa9Y
 1VaUgqAjFIVUIiAj4EWmPpITNZz/h8nDIh10QKB+wb1HNtGh60s9NwBpjDep5SjVexhUX0EwzZr
 CClybo61rYqNS5ZAiuw6bV8zdLkOA/y/zGaEg68Xsk1owceRn3mCrbvjG4KoZXAlPwpmvSqQCY/
 0j7xAHB8VaL9ZcGEA031kHmIkh6KJ4KHaLiAyVx900DIb2tP88aOL20aGaTMBAGh/J8h24Ilv5x
 WJF7mThxdCxxYBqmvRgeiHDiYcEqxm5CXIoe8HUpCM03cW7ypBb5aG5uEIlUceRI7Q9CqsUtVxC
 /H/1SWa0JQBPFu4w8rmccoBEFYuZLWIDCt76Cj8ZuNzpD2pp0gfyfPjVko4ZdtS77NCsN3VXQmW
 0/lOtag3w=
X-Google-Smtp-Source: AGHT+IHvn5eYPMtDO5pcLQu1/TqV9ktVhW1E6kH/3j8sdOMbTO5qR8/yD6k9KVyFZbMuU0yLOSpWPQ==
X-Received: by 2002:a05:600c:1508:b0:458:c094:8ba5 with SMTP id
 5b1f17b1804b1-46e329b62bcmr112008465e9.12.1759170782675; 
 Mon, 29 Sep 2025 11:33:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc88b0779sm19057657f8f.58.2025.09.29.11.33.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:33:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 01/15] docs/devel/loads-stores: Stop mentioning
 cpu_physical_memory_write_rom()
Date: Mon, 29 Sep 2025 20:32:40 +0200
Message-ID: <20250929183254.85478-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


