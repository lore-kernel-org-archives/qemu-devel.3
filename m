Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4DDC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pZr-0005xX-Nr; Wed, 16 Sep 2026 09:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pZq-0005x3-GL
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pZo-00032U-Ks
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789564887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4REO1qBeWuk8/clBHJch74Ty6Oz13hhJb9h5IHDXZ44=;
 b=N35+Z0kHy+qOcHlpkNSiJLLYyTqhPwY1ElBQknMnorkFt5lkWJZVXOYVV+r0RFWqZjCW95
 0CtD1lg4E/V1udlV/tol7Uff5rfhxuVusu3V3Rww5PzRUuNtPxUHhjIWMBvRaVpund+EYC
 UjEYvQjsBnnAl6Ve4ec21h53UBidJic=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-V0XdP7S5O1ezDJ_YPBdvLQ-1; Wed, 16 Sep 2026 09:21:25 -0400
X-MC-Unique: V0XdP7S5O1ezDJ_YPBdvLQ-1
X-Mimecast-MFC-AGG-ID: V0XdP7S5O1ezDJ_YPBdvLQ_1789564884
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49ccfad90f1so32696965e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789564884; x=1790169684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4REO1qBeWuk8/clBHJch74Ty6Oz13hhJb9h5IHDXZ44=;
 b=epjxzLD+P/0EhwfC4rjzZ5gxBNV/GhX3JqYHtbjkEAhKwJrousbNkIW6m/3nYTRQCI
 2UzVmmY2QED+2H5Uuxdezsvwx1nyiCy1SLPluGdv6s2BaPRoT63CaEGZP15uo7f9c95S
 2v7P/gbCXNatYzTtALRZCN7VRcUKfxB+BPFQZG1WpRAsBKyFsPP3BiZEl7BkXxHRzLka
 7H26nEABZ/bNvlUr2tTv0jTmb7ytmJ0PGHq3GV9vCMzkOCkJnU8tUVt3cMvPW0i5XwPy
 +fCihzobxOWo+i/4MxMWIJm+84Qdb3dOBPaa33kIT6cBtQYb/DJo9oB3UkVRktKmLexb
 6uZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564884; x=1790169684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4REO1qBeWuk8/clBHJch74Ty6Oz13hhJb9h5IHDXZ44=;
 b=fnLY8EoRMcR2vQByV5m5SwuaAKsRcWyS4nja92sFzPXeZYIx8gnT4kAhrzKv7+0h9a
 QfgnR6qh+06BkasR74FHP/d2icTWJH22/khBBkJBW7y6eHl3/zvSkfyEViQxcYdtjYS3
 ygBS/F+p3ECoD3SijGX+S/tkMV/hlw612Pb0JHBjgiyGdED8z9SphdIEL2x7bL6PSfb5
 DD0R06iPWH+3undxF3XJk2Pk5RwNslvavdYyRKBchVoUMaUWxwI1k/H4G3PlwYk/+R6P
 oAYiqV1YXNCQPo/jrEYqavmpvpmx5Izaf8ucUOv57bKfh9PSjdiDCDsseGSiJ5l1UXt+
 mQOQ==
X-Gm-Message-State: AFuF++mIcfO6BIV1y4IvBTenfo4furnBN9xnFvW53EUQhF4oxVmf3Oci
 s26ZsiYF5Q8uoJAPo8ENDu147TEpUB5ebnN7jTL8TlYL6U3Q2IAPTRmWZBpzmwzJ0euSfeQh32i
 GsQK0TTlXaCTG5Bi2IcdTciUls3nMwyRhaK7fuw69bl44XWemVlZX7wnZQ0UXakD6wFKbf4Ue3c
 TiEh3n9vV2s2IymbsvrORpjPs97KMNn3Z5/uLNJ6Ee
X-Gm-Gg: AYBFou0FyZwZ059/jVr6yv3Gk3KtYSWwiEbw8Z2X4jnlWrIfl06IZiuID+UdGXaRiN2
 cz1QtOZ4vfZohoOGrpFwPAvCOxWCx9xCySYliXKrwfMaUZKRlhzSh29LHYDxMAHX3gnwFbPzWB4
 JB0mFe/lccyqkJj+5wngxMqdB7WBH1LP4wjZ+THyj9BYvSOvRsVFyodil1WZ3y0x2Ya1eeK+Kse
 SAtZLYoWg0wAoOSRkqQ/rHw3UPxqXPLOj+VT50CitWsEwh+/7sosGrDBVeOOTsqmN3ZJfW5tovt
 dT3KP9FMDu821NHxCxpPJ0oVaOoQpBCx4QSVLNUsOqrfJvI1D+sqMiwclx3sHNjnwx+L2TsV4u4
 ilVP/LSb0YMjzFMaHXPSxxbHiE0K+zNKNOghhGT0WPbeogswXsJIhpR3op0onkGkJeuLfRvQkAT
 Ihrkdc
X-Received: by 2002:a05:600c:6085:b0:49c:dca2:ac47 with SMTP id
 5b1f17b1804b1-49eac45c06bmr30124885e9.2.1789564884427; 
 Wed, 16 Sep 2026 06:21:24 -0700 (PDT)
X-Received: by 2002:a05:600c:6085:b0:49c:dca2:ac47 with SMTP id
 5b1f17b1804b1-49eac45c06bmr30124345e9.2.1789564883890; 
 Wed, 16 Sep 2026 06:21:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83a8d6e2sm81816535e9.1.2026.09.16.06.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:21:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 1/8] ncr710: simplify ncr710_clear_pending_irq
Date: Wed, 16 Sep 2026 15:21:13 +0200
Message-ID: <20260916132120.860910-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916132120.860910-1-pbonzini@redhat.com>
References: <20260916132120.860910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The same checks are done in ncr710_request_free.  If req->hba_private is
anything, it is the NCR710Request that points to req, so it would be
cleared.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 57967e7a84f..b87fed05a4d 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -316,11 +316,7 @@ static inline int ncr710_irq_on_rsl(NCR710State *s)
 static void ncr710_clear_pending_irq(NCR710State *s)
 {
     if (s->current) {
-        if (s->current->req) {
-            s->current->req->hba_private = NULL;
-        }
         ncr710_request_free(s, s->current);
-        s->current = NULL;
     }
 }
 
@@ -739,9 +735,6 @@ static void ncr710_add_msg_byte(NCR710State *s, uint8_t data)
 
 static void ncr710_request_free(NCR710State *s, NCR710Request *p)
 {
-    if (!p) {
-        return;
-    }
     if (p->req && p->req->hba_private == p) {
         p->req->hba_private = NULL;
     }
-- 
2.55.0


