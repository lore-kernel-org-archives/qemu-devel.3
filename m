Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F97CC5DF7A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3tC-0003ug-Ld; Mon, 17 Aug 2026 16:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3tB-0003u6-Dw
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ww3t9-0002pM-My
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786998295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/2cLEJpVnZtTQYgeKgJJ0gnMiImIuK6URdpvYeWWeE=;
 b=cQblwkD7Mxyy2nkT7LKQViQvU1nfuwUnaeJ2Nm70rRNvNvk7h+ubpuI435DxLllKYrhHE3
 PKJ4+L0N3q1yogE3f6NoTPH1eg4Oiq6FTTF6k1P1BGl9TgT+1BjcIrKb7MU25kdMtEjZbZ
 mVcACjNjTFLS1GV5H54VjERkW+NDBoM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-2T8cW8KUO3qTBASzZTDk6w-1; Mon, 17 Aug 2026 16:24:53 -0400
X-MC-Unique: 2T8cW8KUO3qTBASzZTDk6w-1
X-Mimecast-MFC-AGG-ID: 2T8cW8KUO3qTBASzZTDk6w_1786998293
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8db414c7so54110101cf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786998293; x=1787603093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z/2cLEJpVnZtTQYgeKgJJ0gnMiImIuK6URdpvYeWWeE=;
 b=NO1XdFN6w6ojlPN0eQkzXtwWPS8MY9A4XVwwHs5W8jj4F7ZfY1p93B46CroC04CJWO
 iR2GfWNEUL5CgY63MeWBBX5YdGGVQemGEOlif40xHJqEIN+v4gNoe2ZZm3y3ICAhdu6h
 KjTgmbxt4EZF8rXQcGvJ49bb3KPfoAzA+WeyP6v8oK4s9anGtFP4ysIUUlApf7pZWMCy
 9xs3lF8Tqa2MPcO+2RPYizjm6XXwcYEHwF7HsEEI4g9dtgggW1/yoQjo1c1Be8Rx34+R
 RkYYRV01uxfL8ErpScltS8wUxoUKjV80IqEHRWq4fuSrFWF+Jhx29HDQTqFbBjB7E8Bb
 Nyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786998293; x=1787603093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z/2cLEJpVnZtTQYgeKgJJ0gnMiImIuK6URdpvYeWWeE=;
 b=Yqmfc5KJ1ECoBSvyMba5rDKhkjyHRQymC40eG7nRkvPzfJSgoYh87yI3bDlwwCzWQH
 1kC7ZmXoq7SvEu8m7eVBEooIHDvxktEwbpX5B85THlZKhnurWwpn4IlGfdTew5flSktx
 cfATohm+gogh2ikLqffLmYc/uGWd+miPxg+lob3WD4EO/Fps/r0o69lTUm4r7kk0daQB
 C6rmRjMf7QGNDuAnrxOrNfS6EGj5gwp5/ww0h1YNFwG+bFxZmfSE9VYZWU3vAtBUxIXI
 3eLb6F3B/5xWzC7IgLVDx7BCfyFTn8sb0cvB/9OJi5Sv8FnWjW6Jse/5YGrqb5Tjuf+h
 agqA==
X-Gm-Message-State: AOJu0YyPQIlDviGirYshJ9IuH0MUeHUriudxO7CsaOS+82RHxYxqzscw
 h9L4e1cv4tpSv5c7VsRdYJfrAHtfh+5yW1ujRipUbIui5d4D5OMOEP2L1t5i4vSkjp2YeMRAKOK
 lpE+JopoLEjLcu26m0afh7NaDXhBKnRHBgU5mgjmmrINDb7ejLbfyX1JF/8x9U0yVAcweKc6iDU
 5xaFYucLjLGSkPd+yuAibZvaCRHyHppNYkz4MGiA==
X-Gm-Gg: AR+sD10j1xjIl1NFKJMsVYYzvnwa7RhQN6s+PIUduxUPg0sc1Nq6H1xaF4xl506UqGM
 S8Xaz3m4i4fpxRYuYO1M1BpIW+S6bqOvhx6Ae1aFGtvdz09PhafUPFXeI7TUAHB7S4C+o8VuvEa
 AQ1QWLVHavNI9gDgM99OxUkFaOZ3DYD0qNx2M9CgSjFKhIuollNCy8hGETs0e0UaUlVDlTq05Gs
 wcyA3i7pLFv+m2OZYSKGBzOgAEyJH8WrzChvYyzBRHFz0/3e2boAJmTTb1DQaLT7EOpaGk3228E
 Jit1G55Wjh21lfN5N2XSjE7O1gvT4FgKSmhFq7hswa6HMXxQdLS+Ch1wh+fL0ZfOJg==
X-Received: by 2002:a05:622a:292:b0:517:6d82:ceff with SMTP id
 d75a77b69052e-52d853cbab0mr287656251cf.13.1786998292949; 
 Mon, 17 Aug 2026 13:24:52 -0700 (PDT)
X-Received: by 2002:a05:622a:292:b0:517:6d82:ceff with SMTP id
 d75a77b69052e-52d853cbab0mr287655511cf.13.1786998292314; 
 Mon, 17 Aug 2026 13:24:52 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db6136569sm22865761cf.12.2026.08.17.13.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:24:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Jack Wang <jinpu.wang@ionos.com>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH 09/10] migration/rdma: Sanity check upper bound of register MR
 address
Date: Mon, 17 Aug 2026 16:24:23 -0400
Message-ID: <20260817202424.2901438-10-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817202424.2901438-1-peterx@redhat.com>
References: <20260817202424.2901438-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Before registration of RDMA ranges, QEMU destination checks for validity of
current_addr no less than the target ramblock's start address.  But it
didn't check for the upper bound to make sure the address is within the
size of the ramblock.  Add it.

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4007
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index bbbc40ea3b..13dd60c11b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3389,7 +3389,8 @@ int rdma_registration_handle(QEMUFile *f)
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


