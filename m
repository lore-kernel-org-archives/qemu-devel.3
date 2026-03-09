Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14929FCA187
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPF-0004ik-J4; Mon, 09 Mar 2026 16:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP9-0004gR-Kv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP7-0007me-9I
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KURqW3GBA7wyjpfqN4oG+8IbN7+6HherEsvu+QG0MLg=;
 b=cC9Wyf0wL+OXq+1aQASV9osXpYipj9uIvY7spZDPhO9A53Ma8zMGONHJT6FCcJ6W3XwFpZ
 hGrWhkrLmdC7REEvmDtMj07ousg9U64VVDgNj2hZQUetMT+N4qkvX+GPqCQK9mjxhdm7RM
 9hqJZdojp8SzBe1Uw+cN9uVu6VxHQ8c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-fdu1QbKtOku44SoFeaduTQ-1; Mon, 09 Mar 2026 16:40:38 -0400
X-MC-Unique: fdu1QbKtOku44SoFeaduTQ-1
X-Mimecast-MFC-AGG-ID: fdu1QbKtOku44SoFeaduTQ_1773088838
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd7fc27cf7so1033447085a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088837; x=1773693637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KURqW3GBA7wyjpfqN4oG+8IbN7+6HherEsvu+QG0MLg=;
 b=J39H9vBPVTVsvW1SG02pwn5ApIQlaKDUAm6901CwLToRsuNZD+7tk/eKfWMgsgLgqj
 VqXWBomaNJEZD8dKFmTYxVONqIKMxaOGrhwB33nIPpZnI8QaOzIX6pLioCfGyzSIPJOv
 7gH8Pve3xItphVD14cHyK70ukZ2tpMac1PNfBGE9BfRcYm8rOSJYvEb/pkmAF8S2vH+S
 RqDQRvyXRQ7JkrD1OEuifYFeK1g4dwpN+4p2Do2fGkeEULYXd24HuPLQkpR0i0bzKrAc
 HMgO32lNW0RAdMHLdfCr2HCUFSaGFxu1+SS++vnZ51b3SEA6M+qYZuX5m+bgOIlFpd/f
 C03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088837; x=1773693637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KURqW3GBA7wyjpfqN4oG+8IbN7+6HherEsvu+QG0MLg=;
 b=S/ZlWd3gwUqYpAGD9Q+jIXuq0NUbBNUhvL9AGlzrYN8SmRKk8Z/he6VFdxM3AthiBC
 i6sdhl24zFBRxAkWKbM4zaMdxvx3k3j3aAIYZqNmETmECVQvSVa1SzuXQWi3senBKwMP
 r+1Oi6j5KUBCJt1HktGGcRrJ2IvF3e+fn6XWbs3dW/9RJWGc7rSfuhcuc0PEls4P9jSs
 Vfb7W4x4BF50bUdw45sGweOFqlMkDpoA7Czhcp12dnx/ba4s7yph2j4ue7FToScuhUMt
 ZEaeSbeuMNpPg/rkaNknFPFS9/1o2whPxXTz+mNvZdQup+c5R1Edvf/e/sllspxaNKHZ
 eOQA==
X-Gm-Message-State: AOJu0YzXG0sRjtDG/HlwP1avwDujWBbFmn3lNrsjS+TNmOMZtpqZowBu
 R5VLAAl+EgcUBfdnyXjj4weuNpr+Lz1KdYWIlNGJEOnHK1zIUhlkY5/jXM51F/IwQ7O//fNCOsU
 scFwPrxiu1yBiU2FhmeppyaNfbrVe8UqcLqyWyUUTe+0tiqhyIhJ+RHzZw9Cvm7vJYqF13l+Mq+
 kLc/DwJvVrGmhBMfixyO4xGL24TZLrEL8NyABJqw==
X-Gm-Gg: ATEYQzwDc3HaLx/5cHju5hPrZZsPv9S5IpG3Bb+4jleNlOwFnAuVS7WZAow2RkHQNM3
 SPnpSLW9DFs0nxb2yO1x2fGXbvb7RsdYlbXv0lozsE+mqOsHIUNaqxsYdWISjlUHFyUAJFcYy0n
 prrqPDFCxNXyzpWPr0I8/MIrwgO+C4RSMY9Oe11+d4Hgt02vpYSg1Wmz/N7LLRv/EgzfLw2Kvde
 xW2aKtvXyXTGkqAryaezZL50+/7Ux69vnHHgY+pQbnfYKVYAdzXokrtT6Y4hGrX90Dh9FKQz9zN
 Eebnw2Jwq6DiDKAf0mJc7hbukt0HA5s3D9VVfoRVIF6s3GXNV3reYpAybgO5cmmawKIn46KUXFr
 io0hz8OadEuDNnh9AU0xaOFLc++EGPAm4AEiQhpI79UQxG/ZS+L+ZO6A6ufJXEn9SvFiOrrkLMZ
 0R0W18DQ==
X-Received: by 2002:a05:620a:44d2:b0:8cd:80f1:f468 with SMTP id
 af79cd13be357-8cd80f1fa47mr953985885a.41.1773088837584; 
 Mon, 09 Mar 2026 13:40:37 -0700 (PDT)
X-Received: by 2002:a05:620a:44d2:b0:8cd:80f1:f468 with SMTP id
 af79cd13be357-8cd80f1fa47mr953980485a.41.1773088837029; 
 Mon, 09 Mar 2026 13:40:37 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PULL 14/18] kvm: replace RamDicardManager by the RamBlockAttribute
Date: Mon,  9 Mar 2026 16:40:03 -0400
Message-ID: <20260309204007.1709441-15-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

No need to cast through the RamDiscardManager interface, use the
RamBlock already retrieved. Makes it more direct and readable, and allow
further refactoring to make RamDiscardManager an aggregator object in
the following patches.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Chenyi Qiang <chenyi.qiang@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260226140001.3622334-6-marcandre.lureau@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ebd721c3d6..984db97779 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3404,7 +3404,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     addr = memory_region_get_ram_ptr(mr) + section.offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
 
-    ret = ram_block_attributes_state_change(RAM_BLOCK_ATTRIBUTES(mr->rdm),
+    ret = ram_block_attributes_state_change(rb->attributes,
                                             offset, size, to_private);
     if (ret) {
         error_report("Failed to notify the listener the state change of "
-- 
2.50.1


