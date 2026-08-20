Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28063C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8zg-0000PK-IH; Thu, 20 Aug 2026 16:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8zf-0000OG-EH
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8zc-0005Pj-UD
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787256244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SEo2eVbCTpmPKnzPC7tEz19MQRMXHP5CDmZv/G66jaY=;
 b=aICI2fEqxoBi7q37s+oDd60GC9UIA2WdmHML+dXhwimXKLzg5ZkUyWIdTFO6TEa3gh/7og
 BGQ3+uTb+zGivd3dtErTXAB8TMQlVbdEOSISCE7zELyPM0xOr6FtaWHDaa8dZUwxq17e+m
 459Nf2WgduW7YecpotO5nEXTaLsTIbg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-RhX88dfhO1aVrbniXVKWiw-1; Thu, 20 Aug 2026 16:04:02 -0400
X-MC-Unique: RhX88dfhO1aVrbniXVKWiw-1
X-Mimecast-MFC-AGG-ID: RhX88dfhO1aVrbniXVKWiw_1787256242
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6a17baa4d18so460617eaf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787256242; x=1787861042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SEo2eVbCTpmPKnzPC7tEz19MQRMXHP5CDmZv/G66jaY=;
 b=qVPywGriuaqaTY5Ex0tgfBRgwEjjR+ck121gJEGHZGwQgPe9l8EiBbVcBME8aglCuu
 YEcrYe6fSKxWc0D4QoBafiQzialc4ddz9zb/kFyivnW7AN3TQ5+15lsPRqOR7m8RiQ8f
 Ije0fyKiq45qyDF/wbxMTJFbKKuVIdDbe7TlMG1YnVuj/+GIivabovYAi2XmNMUKIoRu
 vX+U2yg9u1RWqgFm5oHDcrUbzzAMhFEk5nvNb2n9wTem6nDTTVGWwqLZjHkklo2gyVwl
 fmkouU7fBZWjkhX3qX2hlHXEwBMseNv7LjjT2FxMrsBnxOzCgMCmuPie55rBJAKopXkr
 fC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256242; x=1787861042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SEo2eVbCTpmPKnzPC7tEz19MQRMXHP5CDmZv/G66jaY=;
 b=A5aRdMfL7Hv5bnen4PgUoCKrB50CI4OevSdOUl0DyXt1T6VGcTCqLCyzyWgRkC20cI
 OTCGGIg4GZqa4e7z9pLEHBnKJQvWDJ+DyrgkkQC5KuhIKKwl1dXaAkfr4dAWyPKzR/mj
 /vtJgfI74O2EzYhvS714NgKmgSeYr2+eQARKwAIP9jAkkjwXtIb1iIOd+3lba3nMSaqQ
 YdE0OzwarC/hhDZNlZy/PAEybf7LhgLZweAvXQoYKpReF1I8oe5SMILRZOIXG5WwRHU3
 X7DWWE/sVbcv1ohQ8c7hEz+wtsGZFfNflzJwrPxg6GW4/Prdp0edofLr+fBy3bEDs0Nm
 5x0A==
X-Gm-Message-State: AOJu0YzgkBjqYWuPYLrkYBTI6fp+cMG0cnJ/qVgVMWdx4TlI+ylaxwsr
 L31tiAUBAHN0mbKfnF1dedPPMCssAP0u24yUewnnNiHmF2aHxhcEY6P8FRq3PqagtzgXJL7ZYCM
 WDrmcapA9MRbIuz18xeos8/4FUf9O6w/gmkVVVaMHuRSo48F6o0qLkXqmCuiYjKMMGYhncnQObg
 v4MIEl5zYcW23JwTW0NPudP2OSDECyb5uSzk9s/Q==
X-Gm-Gg: AR+sD11Pqi9XD45uxelX1MrI8OVpRCePwtDvhvwOa6cbzfm8uZtyVSINj+t3WNeEQjB
 92PEFPLhlTB1IA/9iyZd6Z2IugAvv3HGxRX0MhIFmKFAIv0klXUBHv/3KWLps4IuV55devtfP/Q
 t2AITELvRLbd7FG8UFxvIszyZElqO+xQ1zO10dXXyEdFKPXl8JiRO4sJqEePT9nEfN69ZxnyeJG
 Odd7oprJ/tUXNafiTWLyK/UmcnzELXnRK3BvwKAbG+1+DiGp22onkKu3F/3EKQFyJdIMd6nYdhd
 RMWNYWFo81Q/Y7VSJMeic3804ll4z7v0PjZqn6gYCCbzqoRyuUC3hRjnohBb8EqhJuvI5wLYmzn
 XakOQPZgEuHLAKmxwdpslEug9Gqz7J60BdjJsnAtJZmzwu99YQn0Bl7VyOHk=
X-Received: by 2002:a05:6820:709b:10b0:6aa:d97f:453b with SMTP id
 006d021491bc7-6b1593f3ecdmr1104822eaf.28.1787256241990; 
 Thu, 20 Aug 2026 13:04:01 -0700 (PDT)
X-Received: by 2002:a05:6820:709b:10b0:6aa:d97f:453b with SMTP id
 006d021491bc7-6b1593f3ecdmr1104751eaf.28.1787256241555; 
 Thu, 20 Aug 2026 13:04:01 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cebeb2esm6181314eaf.10.2026.08.20.13.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:04:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Samuel Zhang <guoqing.zhang@amd.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v2 09/10] migration/rdma: Sanity check upper bound of register
 MR address
Date: Thu, 20 Aug 2026 16:03:21 -0400
Message-ID: <20260820200322.3321036-10-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820200322.3321036-1-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Before registration of RDMA ranges, QEMU destination checks for validity of
current_addr no less than the target ramblock's start address.  But it
didn't check for the upper bound to make sure the address is within the
size of the ramblock.  Add it.

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4007
Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index cf6688a4bc..d8953363fe 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3387,7 +3387,8 @@ int rdma_registration_handle(QEMUFile *f)
                     goto err;
                 }
                 block = &(rdma->local_ram_blocks.block[reg->current_index]);
-                if (block->offset > reg->current_addr) {
+                if (block->offset > reg->current_addr ||
+                    block->offset + block->length <= reg->current_addr) {
                     error_report("rdma: bad register address for block %s"
                         " offset: %" PRIx64 " current_addr: %" PRIx64,
                         block->block_name, block->offset,
-- 
2.54.0


