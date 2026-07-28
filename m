Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619B2C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wok7H-0002gq-LB; Tue, 28 Jul 2026 11:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wok7G-0002gb-Jo
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wok7F-0005ek-5S
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785253992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IsC7scSoMMwxbuUHpN2mbAKsPK+vpKAPH5cRD66AqaQ=;
 b=YLbMZmiIuFi1ERE7gnakgsMkxvxCcZHNACLlvtpkIcEHq8T3nJ+rDGmNoX+oH73mHhvsgj
 S+tr/hvOzeIVFItLZ3KpT1MaY1xkwrUCUywmRfxIEQ6ruioSmYkST4GVz5XZGRQlR2zci8
 +ixEs94kJlymKMKaaOXMZqu8KzLMj3E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-ocCAiCRFMrK7QV9TDi6YHQ-1; Tue, 28 Jul 2026 11:53:09 -0400
X-MC-Unique: ocCAiCRFMrK7QV9TDi6YHQ-1
X-Mimecast-MFC-AGG-ID: ocCAiCRFMrK7QV9TDi6YHQ_1785253988
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso74451991cf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785253988; x=1785858788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IsC7scSoMMwxbuUHpN2mbAKsPK+vpKAPH5cRD66AqaQ=;
 b=iwXAW5Xy/SYs18/K5pHU34L1wX7aGljlMrvnyxIL6i6Q1+SLD5S+Mk1BToqIyIdBPY
 t5/5Bse6huOWSKo1VI3kwWC1xvsOtW0+PHCMR68j+r+DIxhqOgbV2wwBnYNqm7rcqMLc
 Hadut+piGIGCrvLuRHKZiIseVLkGDrtP+tXN/TDIoZWtaSrjOR5qX7wfKob61XJur4bg
 eNhqcKDRt3J/Zg3mQmuCfJUZ97rfRIAk1R8TdYyk5Q0yyN5URwXzwcPM/3RXZ+Fw7CuJ
 wdXGCcR6heJvKTqYGYXg+VmO7HUvY2j+fh3v3c1u7g2gdfgsV9tssq9+6X+0DI4Z4rkt
 FL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253988; x=1785858788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IsC7scSoMMwxbuUHpN2mbAKsPK+vpKAPH5cRD66AqaQ=;
 b=WA0efRxmSdl/dT5pfB39wcd9kj28+GtIl8YpNm4ryqzByD5TRtifUi1ou4h9zU56b+
 fjVwDfi8dOkln4flyM3n2vjGrBKHTCy5lhR1Nch0VMzk++GXdXyyQ68rtC2QJD4PFOXM
 l67hnB5cWpZ2+VR4jNI7yefUH2ExK22sa97qRcmftF5COXV/GL3VrOmPymvOyzj1N4Bl
 bVi3pgBgUSHy0ifG7JnmeUrzLHvJtUpT8dDIQUlW6jsv+ELZxIE9Pt/H4NLEKDrfm5UM
 LQgi5MqMLonqg1O2Gh70BuKQfPBVKH9XEo9TCudKSBR6RvJy0b4CI1oMSJXmOMBqcNAA
 2VPA==
X-Gm-Message-State: AOJu0YwRZdtYPET+HdPUesQIwRgWF/2Dc5zICb5WXEw++qkI5zS01kq+
 ytGSKQtJsU9fQxVZMJprCNcINItILYhczrv6YhWYPEpt8/R5bDslZlAvnmVbUussyyL98d2ZnSn
 M39BxG8hFcXxNkZvrk1M6erKPHkFGmZw43dYw5t8cwuc6ZPv3xtSkzUGONHxLwDS3VRMjyUs/v/
 V/X1WXQFMAgpS1STY58jWDXX/8X7y24K0wxHA0/g==
X-Gm-Gg: AR+sD11BNHmOCtox0csxQ2EyeHjZAdBmU6MuBiuOR24MBzF95m2NtpLIqziEtle7SRE
 L9hM8E8zqr4GJvcxhrRqEXhlGJRPRSJUumgZnwc8M3CHIs40+guaNNGGRr+IBcxDkhe1GWCHZUt
 xu0pBbUawTkdrA3nyUmHW2CJr0oMgKFkD7UbqSWc90hm9gFF4ix6xca87qqEuTD6YDxogFYmVUY
 Ax0DqBSuBDSg8quSPdGVYDWRBhfFHRDOGGouuYnsaNdlzVTkIPits6bZ06kcVASGPZ7KH2Rm2e4
 PhKHYiydC5o6fuwSxG//YIT1xI1NhduKfE6nYBV6CLaMIjxJyuFciD1y8aplN4EVWA==
X-Received: by 2002:a05:622a:1c07:b0:517:b68a:8d84 with SMTP id
 d75a77b69052e-529d70eb27emr26288781cf.56.1785253987974; 
 Tue, 28 Jul 2026 08:53:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1c07:b0:517:b68a:8d84 with SMTP id
 d75a77b69052e-529d70eb27emr26288411cf.56.1785253987401; 
 Tue, 28 Jul 2026 08:53:07 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2dd54dbsm492481cf.23.2026.07.28.08.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:53:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>,
 Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 5/5] migration/ram: Check for RAMBlock size mismatch when
 parsing
Date: Tue, 28 Jul 2026 11:52:47 -0400
Message-ID: <20260728155247.1894355-6-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728155247.1894355-1-peterx@redhat.com>
References: <20260728155247.1894355-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Add an underflow check for the subtract of total RAMBlock size to make sure
it won't underflow.  It should not happen in production systems but only if
the migration stream was hijacked, which is not a real concern since
migration channel is trusted.  Still protect against it.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4013
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8918b2f03b..85feff578c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4268,7 +4268,7 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
     int ret = 0;
 
     /* Synchronize RAM block list */
-    while (!ret && total_ram_bytes) {
+    while (total_ram_bytes) {
         RAMBlock *block;
         char id[256];
         ram_addr_t length;
@@ -4285,8 +4285,15 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
             error_report("Unknown ramblock \"%s\", cannot accept "
                          "migration", id);
             ret = -EINVAL;
+            break;
+        }
+
+        if (usub64_overflow(total_ram_bytes, length, &total_ram_bytes)) {
+            error_report("%s: RAMBlock '%s' size underflow total RAM size",
+                         __func__, block->idstr);
+            ret = -EFAULT;
+            break;
         }
-        total_ram_bytes -= length;
     }
 
     return ret;
-- 
2.54.0


