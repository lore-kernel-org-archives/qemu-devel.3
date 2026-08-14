Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C181CC5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wus9a-0002I8-Pa; Fri, 14 Aug 2026 09:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wus9Z-0002Hk-Aq
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:40:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wus9X-0006nu-Ad
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786714854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bzp1EhukFi27JgrBy1H853NXVUvWuTaJNkGQUPS5i88=;
 b=VL4dbd6zQc8L4zb5S5FRyLiqz1mU1fx8T0x+ynjGDDBpPNV7TEtJ1LxMPy/AJcaYxJh7E5
 8Im9nRaDgRZRnzWL/MxuJFfTOHhkIoX2X7+nXFAhjw/sIY7rH4eJSbrduhWE4D1FJJsBfq
 4NqjW3rlhEUrmF7S3LXVgzwgOpNXLsc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-A_ZqFN2gM--LtgwytUsj3Q-1; Fri, 14 Aug 2026 09:40:41 -0400
X-MC-Unique: A_ZqFN2gM--LtgwytUsj3Q-1
X-Mimecast-MFC-AGG-ID: A_ZqFN2gM--LtgwytUsj3Q_1786714840
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9368f2b7b2bso108869985a.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786714840; x=1787319640; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bzp1EhukFi27JgrBy1H853NXVUvWuTaJNkGQUPS5i88=;
 b=pkWOcWDI8raY40X/NzhBx+xFTUF07A8aiSH7dMoyffKMA3A1Yhp8ThklVlrowXurCb
 +LHQozdrpkG2326eJjq6vEnjrXSb9ry5sxNH2XCs76sOIlND/wJfHASNEQ3Vu1JYnyjM
 EjvxPBrzLmIw5ht0CbvBYbYCnOqLChroTu2kdYwVzHy786rQY7RHE0gq0lnPgcP40n6h
 fz8U2mI0KOcNjGkNhdeAdKyzX1Ra7LaQIvVbDKRTIFTPKHSe0Xp4BrFNBq6lfLTrGJC9
 3RN+uFVKZzeGUkynAo8tTd/bWMxGx/nf3+mFKlUr8tYLI/fWIqO+KZUvDUJs/vY5EIvS
 uIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786714840; x=1787319640;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bzp1EhukFi27JgrBy1H853NXVUvWuTaJNkGQUPS5i88=;
 b=HCjt5O+AgB5hmPwfxBDAVxibOgVVcfm3OG5G5GVWwfSbDRJOVB1UMFcFgCE47Jc/kb
 ZvIjJIjGst7ErPl+xwJlgALykTReq+wQpEzU+6FtI/MXZz2yqvzjFNnRbrOVG6+YBrv6
 zd5muqBbiReIuSYGI/OC3/bfwjxs9YR2IcZxAW0+LtqGyeqiMAWYGQhk+kOp2+Tx8c/j
 GInPvPr8S1IbJH2qCMr1nRSN4jhSvtMfUoE21oo1FkqfX/j21jjDtJ6GjL7nsdOfTpz0
 hB7F2k/1eb4kmRWRaauJJVN0x4dQH13iXT4vmNDhoq1Rp+XR24bHmutenSC/7bZwQonG
 7Rxw==
X-Gm-Message-State: AOJu0Ywhl7Q02btIIEGZALu/igRxwLea26CwnSdPSp7/1JD45wR0eY9j
 sNQW+d/Ezl2wpSJoWW4uRfRVE2gAYIQWox8P+dFicluZUv9imCduZiJw7KT58FjI13GRKjkIgnt
 3HJyUvFbMBSmWdHDGZ+QrCo7aamYkxfdaOIg7ImpAL/ENGYjL1KfVgso1RS2ZJxH3r+5nCPewdR
 GKmevyoAWkeV+wLnkoTcPa4fCdsmwzIpo0NSR6XA==
X-Gm-Gg: AR+sD12WtXZlZYL+nP+eJEsxnh2sGz9TDtIQP7meU6wxvZSG+lJepmPm5B+XSXx3CDh
 lKgDNYxGESxMxAppyMB4cM9obfU8kjO07ZUGRH31sGedFvS7GcjbmN+D2VdH5oGehBAQYLtMPbC
 eGB5sjCoalYwnxsaZUy7JYY62q988h2gCjIylXw/acTN3hkkHBj8AioO9Ms7LdOFqCs6ut+Nf7i
 vHHuLmAIwp3M7+2So9kfC8vOegtXCj0yy2bv/IqtqGW5m5w7qXvTmjtQgQvDyqKFZnxrM9Qn787
 xeTrXmmRvUh6fIxAtvukwXk9YGaIW1X0G7FF9qn0mrDreVBDUu4F8uxxTkNRWlnukXNyu+s=
X-Received: by 2002:ac8:7fd2:0:b0:52d:825f:e53b with SMTP id
 d75a77b69052e-52d8557b1camr59398091cf.39.1786714840309; 
 Fri, 14 Aug 2026 06:40:40 -0700 (PDT)
X-Received: by 2002:ac8:7fd2:0:b0:52d:825f:e53b with SMTP id
 d75a77b69052e-52d8557b1camr59397111cf.39.1786714839544; 
 Fri, 14 Aug 2026 06:40:39 -0700 (PDT)
Received: from x1.local ([2605:8d80:6cc9:808c:c1d2:d82:943f:9e75])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d840e1559sm22119411cf.27.2026.08.14.06.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:40:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] system: Define ram_addr_t to be always uint64_t
Date: Fri, 14 Aug 2026 09:40:34 -0400
Message-ID: <20260814134035.2733355-1-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU's 32bit host support was deprecated since 10.0 and removed in 11.0, at
least the system emulation part.  Now it's safe to move ram_addr_t
completely over to uint64_t.

It should be almost the same as uintptr_t as before for !Xen, except that
on some systems (like MacOS) uintptr_t and uint64_t can be typed slightly
differently, causing unnecessary compiler warnings when use them in a
mixture way.

Hopefully, this change also makes it clear that ram_addr_t is never used as
a host pointer in any form, but only an internal QEMU integer based address
space for allocating ramblocks.

[1] https://lore.kernel.org/r/d7b2fbf6-f9fa-4b39-8f40-95b7d5d0d8fb@oss.qualcomm.com

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/ram_addr.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 129f6b8757..06caca1506 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -15,15 +15,9 @@
 #define RAM_ADDR_H
 
 /* address in the RAM (different from a physical address) */
-#if defined(CONFIG_XEN_BACKEND)
 typedef uint64_t ram_addr_t;
 #  define RAM_ADDR_MAX UINT64_MAX
 #  define RAM_ADDR_FMT "%" PRIx64
-#else
-typedef uintptr_t ram_addr_t;
-#  define RAM_ADDR_MAX UINTPTR_MAX
-#  define RAM_ADDR_FMT "%" PRIxPTR
-#endif
 
 #define DIRTY_MEMORY_VGA       0
 #define DIRTY_MEMORY_CODE      1
-- 
2.54.0


