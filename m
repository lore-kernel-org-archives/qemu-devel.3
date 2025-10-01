Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ECDCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s8B-0001oI-Oj; Wed, 01 Oct 2025 04:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s7R-00015G-0n
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:23:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s6o-0005vV-Kj
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:23:24 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so980845e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306954; x=1759911754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDgeo2zJE06h8QgA17T0RsOYYTnGmADPzWOfZYKLdkw=;
 b=Sg7tOPHDxRXshVYupcVo4jWUezTSywE+5bKFizMAFqnN5Y/eq27BAHF9zeQiWeQm5s
 MLYCwbpGUnD9MuGgai9Tsj0dIp66JCDIXSpxhTrOq6qxo4sFxWU9jJ/Cuahn43lAB1p4
 0t1yc9Yto+GwqKurc54iXc/4S4WzipiCqoafr8VARy+QswSjX7qZX4A/pIM74TjvaWr0
 QHkD5uAtoJUh+dyfsGODShYhMuqVjhhPV/xHpSyBWqAb6NYRu3Ko9/cYR7SZU01lTuut
 QXDO9n+KrN60OKM+XKWGA4TylCXWPyunQSfsUKy8JERoP1NsZFMQC9dfkzOikvAtal2z
 uNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306954; x=1759911754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDgeo2zJE06h8QgA17T0RsOYYTnGmADPzWOfZYKLdkw=;
 b=X/AjX51ggVCeAhW+WKw4Kdisw0Aw2HACZqoaO+zhALStZE39i01Cr5pf6Z9KphJO4T
 JQzmiXTXZZJ61ECAbFEvVBvKE1WoRqF58y2NU9s5ZaKfKLQ6yiJ5Ebqiitha7BNoSyw6
 oETpbtIcI7jwuwtxWpVDPzvOGiXYIcmQoZnbYCyHNjmm5uyzEKhALo5wyNpIbs28ICc5
 E4Rh8st5sH8yaV5KUELWDuiYU+zK9iypcg7bpCRY9SY+jPxXucE/HqJdk1u9o6Ek5v4v
 pdvoC5ga65nxzMOZdAf5z3tnE5k/oBDbJYwjAHws8hedruKp+B1zifKJ82pTs7sqsmax
 jVdw==
X-Gm-Message-State: AOJu0Yw6hHRpO3XpsxCI4rNSAGeh6w3EcR+C3IsLaO3iei38RzMIDOW9
 +cF13qfoBoVPz3KabYu6yBGlDqSbWv99g3KC4fzAytSYEc2wwMYFKZjrGJsxxirvzJRQOHY4+pv
 GAQODEHr7PA==
X-Gm-Gg: ASbGncvehAzxAZTCnSFObgdFLZxhNt37/J88PiF0KZUqf5EfVmsb3jz3T9QotyMT4s5
 XWIwnFiEBqVZ55kKOfsMLJSVo2v6wGRY9qhW0q0T0FZ0qacE+mL6wIZuW4bIR44+KoUSFCEQikA
 otzl0mIiMuR+w1d1IbRVaxFdMzXf5vsFNW1EUff068qzjZ1Y7LRegFu9ETfACYVQo+tB5sPlwIw
 r8qDxuNvxje7MKaH+QjXWUlJp0LY+q8PtIp3+1tclpgpP9r3amfhWP8Pgd1VQt15SKaTNGBpYG/
 ryJ3Z8peRgZ/vRKTAJrm2QQ8RRZxyFt4J+Lyrow/Kg1sCvwHLzKPkcm4+XDwIH2pAAXSJQplFuO
 2dfswYex0qiIOjqB20J/dXp4JKLVxAgJOLRzqr3YPHlstqMbbtDtvyBKFZACYi7d9h9Hurxutxc
 ksOsqbeBhFsHUAXheBusIu
X-Google-Smtp-Source: AGHT+IHvBo+V8oomdTfosMLuI0EpMsA23PUCxfHTKlB72ocxI/viBCxHR6lbgB29b5WbCh/EkkRIww==
X-Received: by 2002:a05:600c:a30b:b0:46c:adf8:cd82 with SMTP id
 5b1f17b1804b1-46e58aac99cmr48828895e9.3.1759306954128; 
 Wed, 01 Oct 2025 01:22:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6111c1f4sm17544135e9.0.2025.10.01.01.22.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:22:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 12/25] system/physmem: Rename @start argument of
 physical_memory_all_dirty()
Date: Wed,  1 Oct 2025 10:21:12 +0200
Message-ID: <20251001082127.65741-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Generally we want to clarify terminology and avoid confusions,
prefering @start with (exclusive) @end, and base @addr with
@length (for inclusive range).

Here as cpu_physical_memory_all_dirty() operates on a range,
rename @start as @addr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ram_addr.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index cdf25c315be..7a9e8f86be0 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -142,7 +142,7 @@ static inline void qemu_ram_block_writeback(RAMBlock *block)
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
 
-static inline bool cpu_physical_memory_all_dirty(ram_addr_t start,
+static inline bool cpu_physical_memory_all_dirty(ram_addr_t addr,
                                                  ram_addr_t length,
                                                  unsigned client)
 {
@@ -153,8 +153,8 @@ static inline bool cpu_physical_memory_all_dirty(ram_addr_t start,
 
     assert(client < DIRTY_MEMORY_NUM);
 
-    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    page = start >> TARGET_PAGE_BITS;
+    end = TARGET_PAGE_ALIGN(addr + length) >> TARGET_PAGE_BITS;
+    page = addr >> TARGET_PAGE_BITS;
 
     RCU_READ_LOCK_GUARD();
 
-- 
2.51.0


