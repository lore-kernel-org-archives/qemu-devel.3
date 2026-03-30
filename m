Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1415410D14AE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 12:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Bxp-0003X1-2R; Mon, 30 Mar 2026 08:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1w7Bxd-0003WC-AL
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1w7Bxa-0000He-S4
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774874594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gZcL+D6MVYJs6bUuhFAMif/UHwsuKpsbEXAkCXYB5OA=;
 b=WayCOX5wp+RK908GZuUSWUT0Sn4+VgQevetoxHIQU6OJz3cAf7aCU8s77w/gPmIIxcg17A
 GGD395zMqnW6rdCw8zPWbjISnQaVCxIH8UeF6z5LkqE/Z0pFOtapB2hHI2Cute7Dt/vzig
 5p8Fn5WY30JpZTzBpYE882YZPLOEM2w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-ZG0TwRuGNKSEH3Dqf50Gfw-1; Mon, 30 Mar 2026 08:43:12 -0400
X-MC-Unique: ZG0TwRuGNKSEH3Dqf50Gfw-1
X-Mimecast-MFC-AGG-ID: ZG0TwRuGNKSEH3Dqf50Gfw_1774874591
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-486f830f4e4so30221655e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774874591; x=1775479391; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gZcL+D6MVYJs6bUuhFAMif/UHwsuKpsbEXAkCXYB5OA=;
 b=i7PIx1QTtCvQNu/AibNYewrU8VTNo2+jqC7vGZ3g1GUVHjbioAphXhNndYV7+TM/Mb
 mtieq0VzPCGwQvirwEaHq+hxpIloKU6+FnGQZbUtqbIpSZvjSSFSwtG1Vw8y0IEl2R0j
 WnLNnjW5jrVY9gubXfMDUSGhXP7HqJIaQJR6ox21Y39IOzS6ofH8Eo9Y9TUkSWw+0KmE
 nN9DLq8xCFoNNVcccdPvxO6zULcmCZZzCfVdkD9sLj7SqK2cSUXtX2CnXjo/02ohOhLv
 ZXwM6N+pfHg7E0+txMFSqTdUdu6zjdyrJB90e+YrD/2O8U1shErJOZyy6PlyvuhLoDLK
 EBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774874591; x=1775479391;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gZcL+D6MVYJs6bUuhFAMif/UHwsuKpsbEXAkCXYB5OA=;
 b=nhamLibJgbWCUlZlzsjhaJNGeTE/8wcUyq7ksI1jTcl+SYWsMkQyCidhfE52843Ovq
 fZHxGW5kju3jNYJKVnMtCm+V4XIc9Eg/F0F9sVgZCMmVmA3vF5DqdXndNm3EhgIxqPK1
 GAEeEzmm3cv8T3M2iAnqTUHli3+QtLTzfFc9GLJ8AOQ8rpTf29nS9x5+1wmO42BV3zd4
 erHrYe5Yvtzx8okiKaIyAXXYP8A1KRAzEgjd8+MsG870cO2dqcifW4wqALteaPNoifKQ
 KchZGaQLMbgGt4NBiiFPQBEqBtZMPab7PEeaOj7YeHXWzQB7WR6JxdBMrC/GrpbSCS1v
 GU0g==
X-Gm-Message-State: AOJu0YxEcX5j5pZ+8s9uX8JCH9iu+niC4bZguLqYJJYjBAszURhh83JK
 N6R4X34kT1swWJYfXCJrznI4ZYPeOq6H8Jc+ioQKALEPKj3A22wB3XxpPlt/ivw3MtMzvawtOja
 SnWlkmlQbjswqgxI7QiI1pWg22/AmFpuSWgFCxrEwwpR7SeatpJH7503M
X-Gm-Gg: ATEYQzy/5zKPIsuOa9WlsKgAZI24kMdQ2hQeJZ7KAz74p3+CnVOn1KucB0JJ6EtAeqa
 vOhiwL4Y3/z+T78ByjmLj7f+p0v/I+/iruCe4NcFmOEQjt88SwKQZGLStqL/ASRW/kW7YGUaEvF
 SSYhto3x5Iw1PZ29yKjmsvyNL56sto+K9fZEs365+VgpvDS9LF4E6DqfomIOzn1HlnhrOMVK0+w
 NjN+pp9WcXfhEbBk0nDXt8O2xDMpoa+0Oby5jQ+/18mkqwsxLXza0L+KwPDy61H732IgczMpUup
 ZZvXb1FT5OQ6Sfj2OqCy2dW9Fw+2IcqJgGOsCaVfMZpNfUogFzSnQQhRD/CPU+s/yrNFLrdPBiF
 qBtpUnXVB/ORXRM7VjOo4QlUc7uM/JTtxLfaVMA4cAtXxrLqHI34drYoFmqcC
X-Received: by 2002:a05:600c:1393:b0:487:288:1199 with SMTP id
 5b1f17b1804b1-48727ef16c5mr218225445e9.28.1774874590965; 
 Mon, 30 Mar 2026 05:43:10 -0700 (PDT)
X-Received: by 2002:a05:600c:1393:b0:487:288:1199 with SMTP id
 5b1f17b1804b1-48727ef16c5mr218225125e9.28.1774874590536; 
 Mon, 30 Mar 2026 05:43:10 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487306996cbsm165319385e9.13.2026.03.30.05.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 05:43:10 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 30 Mar 2026 14:43:08 +0200
Subject: [PATCH 2/3] igvm: fix memory leak on failed memory region init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-igvm_fixes-v1-2-03587a5a808b@redhat.com>
References: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
In-Reply-To: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When memory_region_init_* fail, `igvm_pages` is not freed causing a leak.

Free `igvm_pages` in the error path.

Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index 50f0d6fb9a7bacddce91f095b6e2710ecbc79c6f..c347d0c17e7ee744e450d42e677946abad8a7211 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -216,11 +216,13 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
             ctx->machine_state->cgs->require_guest_memfd) {
             if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
                                                     region_name, size, errp)) {
+                g_free(igvm_pages);
                 return NULL;
             }
         } else {
             if (!memory_region_init_ram(igvm_pages, NULL, region_name, size,
                                         errp)) {
+                g_free(igvm_pages);
                 return NULL;
             }
         }

-- 
2.53.0


