Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64B9C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJy7-00069X-A3; Wed, 29 May 2024 10:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJy5-000693-G7
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:07:53 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sCJy1-0005iQ-W4
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:07:51 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52965199234so2436505e87.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716991667; x=1717596467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hr4mFL3kawAtq0YtjNZv8OoJ6UbTTaozHsbwpoCpDok=;
 b=Q0H34wob6VM4kG+P/XwD8BbaKAaj25w/0srjppHvTkCnTzqv54M9E2h13Q3/C7DaKJ
 /1TDo7bheZy/L+TQNGDwBCC5QqbzfJrX6+v16/oBf3KLmkz3y9dQKpRAzt4yPPBmMdDj
 7nxzTl9lfPbj0MAEQhJ5v/Yt+2bOmAlAPqHpmY+sGZJWD3Q8c62otugJHChC881udyf9
 qQzQnqnShZpwLmLxtSIgqu3Jbf8vqlSWucQ86KCWRIRjd7QawxqcgIthd3c7kZEoOFUQ
 3QotCn0xFvd6KXo/NtoZ6sFl215OzRfgvnrwLXI/yNVjM3V/9hIjSu1Vm4zI0xK8/5cx
 m77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716991667; x=1717596467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hr4mFL3kawAtq0YtjNZv8OoJ6UbTTaozHsbwpoCpDok=;
 b=lZMgovMa2sw2J8NS38xzuS4t/H80bURZCMKEAF5ulb6gEHRJK0yE6GoLclK0KmoaAy
 Prir1v6blfmIzaazqytuqhRncZ0BBGcrp2H+dCDG+nwcvUUOKbBzjGeSp/dB0AivVTS2
 R8xUtN1uPCclDf89xneLmPHG39lpgO7nQB8FtMl07LlvtxWoB0/uI5XfdUP/KTZSZTEi
 VS5EJSqcg/J2WuZzbzQMnoqijA/M8W4YoJweq71woDBzZMFPwZUaSEllvToQFNX5pi4s
 1LsvDcXHuNvHYziJo2pWaPu+l6FnML1rbYn9KGcBQ6RgmVFyI0ScgzB9fKo0oifhvliD
 V0ww==
X-Gm-Message-State: AOJu0YwrSFJR7USNv3pMIIIEYNzmkbFgRUmqvnwRwtt7a6jJuoIeR3C7
 7rfwhBlqywsjVljiflvedvxFJP3mFPZLbAOHZxcct4ZOlXsVTRij+V7m4aDS
X-Google-Smtp-Source: AGHT+IH9B7AZIAG90ZOr1k/ksFm4b+SQrRsyHOJxQbtt8ZnW8UBVgSGPmeSXeGuGgTHmga7DV2BHDA==
X-Received: by 2002:ac2:4e88:0:b0:52b:4f30:9cac with SMTP id
 2adb3069b0e04-52b4f309d2emr865486e87.56.1716991667136; 
 Wed, 29 May 2024 07:07:47 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-529c0a78ecdsm314588e87.228.2024.05.29.07.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:07:46 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 4/8] softmmu: xen: Always pass offset + addr to
 xen_map_cache
Date: Wed, 29 May 2024 16:07:35 +0200
Message-Id: <20240529140739.1387692-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
References: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Always pass address with offset to xen_map_cache().
This is in preparation for support for grant mappings.

Since this is within a block that checks for offset == 0,
this has no functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 system/physmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 342b7a8fd4..5e6257ef65 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2230,7 +2230,8 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * In that case just map the requested area.
          */
         if (block->offset == 0) {
-            return xen_map_cache(block->mr, addr, len, lock, lock,
+            return xen_map_cache(block->mr, block->offset + addr,
+                                 len, lock, lock,
                                  is_write);
         }
 
-- 
2.40.1


