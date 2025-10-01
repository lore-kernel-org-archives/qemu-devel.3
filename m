Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D01ACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v414H-0003Cx-Br; Wed, 01 Oct 2025 13:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v414A-00036s-HY
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:56:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v413Z-0001AZ-T0
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:56:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so801915e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341356; x=1759946156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DlChLU8Sv66u34cuVfj2m981SsQ1riJ99O+cWJLK7Og=;
 b=RQeWcW61Zr447L8khS+L2dNr9h0CbH7PLQ4QtHDIMcb0PloHleY/6WEBSmX0a+fuAm
 xCN/3JIIbezfaNd3TCboNOHzFVOZctLZPwJRWnUoJcy62Lonp1vkCqESMAmwkQaXwLAk
 WOjrxs5j70OVxLewm4Mt950Sfkf7Ca0DOFDEOzsizp+fbCnjvJXP0UVTWplI8TTYAa7H
 Ta8WSzz+YOXxwPjkxdEKJZQyGbfLUtxn10hSjswpWHyD8NPPja/PIER4wOb4wJ+1ZwZQ
 Hla/qriNBdKz+RQExYIb8UbV8hWJSoHr+RUSJDeUeQoZj1jLPaWHA6iuMr94kGbajVO2
 XfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341356; x=1759946156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DlChLU8Sv66u34cuVfj2m981SsQ1riJ99O+cWJLK7Og=;
 b=ByMeWQ8vfKuGeWNasxNI1Q28OpgjU7ojs9s5RgNFNepYGt4c/Jj27N/7kv1RUz9ef2
 Nle7HZD7dKz0cS4nSBHcofXQcWP9XMk8F79KdO6b6RlMH5uo8KPej+oEGsLmEhO8fRmM
 s+gxA1ERsh66lLgPjW6ax5GAlEFuX0UcGYk23Rmn/b+toLrM9HhWyEZRmlednEo9teM9
 Tb6e070xLNPY/+udzGFSj62h/JY+OgjAcMHKhL7z8zI187xCmc3vpWO7Q7hU9c3j7MEf
 EgVpbJDelZ3jsVsORBml7KDrm47ZA9qQoER5K6G3O190MTpudNa0NqtBiTUYMfhVzCmf
 8j5w==
X-Gm-Message-State: AOJu0Yypr16NlSqBKiVfh7CgYS+Z3vlnIifezC0UoMe03SShn8wztUR2
 HMtG7/U+y/p4JLSSscH4TxIxjDchBqi5uVK7xwqSK+GFG5JHzPSnZy8Hyq3xs20CyHtWK4eysLh
 HMAOgyC0IKw==
X-Gm-Gg: ASbGncsEh4IwupjDevwu77t/T0VJFiQdGrOtRfb1VTdsS4yw0ipuAoVSaYEtPUYwZEB
 7LQxHlMjww9f6qSGwr/6zBJj15pAq95xtrFNpnBnFnE8HM1ewxnXoHUKZNMn3jFykt0P/qbKjZa
 +MxnJkeJ1fib14/GipYETzMWSS/9R8OLP8eAlnvoIR5vVCGF0N0a6tatFM7+FRtxyPoxGIyd73Z
 B9glZa1uRmubNZAXsZQGsWpVmYfKn/I7wJ18Dst4L+jp2lMqUc64yShgU31ZBiJgLXqLkPeKBPh
 a3PftChuYPsNj02WQTzJbssuSWlczNqyjrzZa2whXhPHi3DI3sgOuYyjk1TGcqO2DNCSCK1LorG
 qEHSSKcPX+HvwS3Nfj7ZU6omItK0SjdO9w6R617KX1jH2BDrtV54AVVr7XXfb1i30B/z3dEfpfN
 riT3xzmPXeHBoWdMzwS8LvNEdnBA==
X-Google-Smtp-Source: AGHT+IHfeO7OH/QdtcggUnA5uGklDQpIabKZxQPr/EBAMEwVNTVFueen9PGLslG1prHgPOf0O5ib5g==
X-Received: by 2002:a05:6000:288b:b0:3e0:e23f:c6d9 with SMTP id
 ffacd0b85a97d-425577f3550mr2999587f8f.17.1759341355760; 
 Wed, 01 Oct 2025 10:55:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6e1bsm144312f8f.8.2025.10.01.10.55.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:55:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 12/18] system/physmem: Remove _WIN32 #ifdef'ry
Date: Wed,  1 Oct 2025 19:54:41 +0200
Message-ID: <20251001175448.18933-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
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

Commit fb3ecb7ea40 ("exec: Exclude non portable function for
MinGW") guarded cpu_physical_memory_set_dirty_lebitmap() within
_WIN32 #ifdef'ry because of the non-portable ffsl() call, which
was later replaced for the same reason by commit 7224f66ec3c
("exec: replace ffsl with ctzl"); we don't need that anymore.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ram_addr.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index ca5ae842442..fbf57a05b2a 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -155,8 +155,6 @@ void cpu_physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
 void cpu_physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
                                          uint8_t mask);
 
-#if !defined(_WIN32)
-
 /*
  * Contrary to cpu_physical_memory_sync_dirty_bitmap() this function returns
  * the number of dirty pages in @bitmap passed as argument. On the other hand,
@@ -265,7 +263,6 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 
     return num_dirty;
 }
-#endif /* not _WIN32 */
 
 static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
                                                           ram_addr_t length)
-- 
2.51.0


