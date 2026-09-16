Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B653EC982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pa3-00060B-DZ; Wed, 16 Sep 2026 09:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pa1-0005zq-Qm
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pa0-00034V-Gt
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789564899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iyyduBU03DJCFgy9GNHUIma7DAM8Mym2KtDJiobAzUc=;
 b=VUC+TAdtqPyncoxBkgQIdTGK9riXvfkRbV8h2RrOMQ6iq+7DXjssXmLEfaTrSMsJlAVNJ8
 w860QEjOpZJ5QPgDdsyI9B/oaThh9fFm8K9ELOQlDyacV6aEIdjFcsLl3GrFJB5B53JOg7
 q1zQkUWmlCKfSI6qW2WE0bsVW6aey9A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-XaMtA-vtPJC6U-Te6nCmOQ-1; Wed, 16 Sep 2026 09:21:38 -0400
X-MC-Unique: XaMtA-vtPJC6U-Te6nCmOQ-1
X-Mimecast-MFC-AGG-ID: XaMtA-vtPJC6U-Te6nCmOQ_1789564897
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e65bee41aso19744345e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789564897; x=1790169697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iyyduBU03DJCFgy9GNHUIma7DAM8Mym2KtDJiobAzUc=;
 b=epltWdih5sxwxNj64NeErwyivi8df4/z7EsCr/Vtkl6J/nUaM0kYsnS09nS4ZuLhHQ
 5+pw+BFExmgYY/JFIhQofcFZD854PeBIyqLJ72P4qQZP4HXjzAswd3TT5wA29ej/QZ2X
 iNATaZVYrochL5b/2rspuWaGgPBQ6M9BKNbBlN/I+n4z21SmOwJoCMvdVCRvrxrqvBtg
 9WsXJxMmWe1uBk66Su1y01BPP3MflRdCPHLsDErvX2vC7rfA1S+nZLah82Og7AOks5JV
 7X/n74T8eNBZTdksm1105pTStaU/2pTWmO+el1yxYJImoJ3y8hec+0fm03HihOV0VAML
 SWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564897; x=1790169697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iyyduBU03DJCFgy9GNHUIma7DAM8Mym2KtDJiobAzUc=;
 b=qua9a4yGCW28oHLrWC9ykfsJMLfC+OB+RNBWfjliT6BL0Wq67PWSbBK4hnt/Fa49s7
 DJCPpawutHT8vxUXCEU0yBpBym3tI+jZ6i5BzA6w48BWHR3GmXqA1lvUzFoQtjEdhOA2
 M9eQPMBtIUN0IMm09LZMZQQalrgF0DyogKAniaOKii4GurUjjqhN134lqvxpB08WIIzc
 JTUrqs8tJ6+eyf6f8Ztqel4IqgiVf6STfT4+RjPuSbm72vctJ5USNd7S54eXesrY9ndd
 Nac8icCycD+etj60iBcq6xCrw4Po+agMO9yzPpJ6gzeLDWGXgF5QZkqgDMNKfN+Klral
 +9Iw==
X-Gm-Message-State: AFuF++kqLfBwPJeLTglymI2mv9GXOrtIMp+Oj7Z28dNr4zdWW7EgOITA
 1aP3T0ziFR8TZDW0FmqK9A6jjF8LFggE7Wv+tOpIPi7P/v2JTHSFRBMtEcx49EJzxizlnZbTTxf
 K8BR2wZspHxjOcfVjrwtx1Z+PDl/2801x3DnufX7th/adWEAGy3rL0+GQY1ddHbhsdtB2aZy80k
 4msu3n3zRsAjAgCttB8m3WBahj6dc7UWDpLzAzccEb
X-Gm-Gg: AYBFou2nh0EdnZG3+sTYzXWGI7Pu8uRiLJrTv2mdGJX0zGpRyNqelBiQRPIaihVKgr9
 EOrnqzgG76SLQw0zOyYQjLuRjzYhvVb72hAaxVX5UGDgEdhbuQoh+y/UnPzf7dVkC0clioaSyKZ
 ZWKfR1nipdP5ZCEXbAwtOoOBLmmVYR64OAzwXrAKN9x2p99c47B9qEU36o4Xjstw1VcI9cJWCaL
 OcU0cw/8AT2DhpgGO9y9TmeABlKcvYyQO/9xWzlmUVIXV+RDB63j+i2MfigNzW5RyjRliX9cmxY
 TcY//kn1s/2zMdeAwjriNIlnoxBOoFhQlGK+qXpsU6Vpt8SizAwEsrW3VxHDE24FO1P3+94MkaV
 eH84vP+ixW5MJeHmO4C/fF0PI5C6hKfqf1S5pidK/4oozEMuSjWlpZGmBILkLCqyclMsOamnkOk
 i4OMR2
X-Received: by 2002:a05:600c:3507:b0:49c:f13e:e52 with SMTP id
 5b1f17b1804b1-49ea20b48c2mr30748135e9.15.1789564897003; 
 Wed, 16 Sep 2026 06:21:37 -0700 (PDT)
X-Received: by 2002:a05:600c:3507:b0:49c:f13e:e52 with SMTP id
 5b1f17b1804b1-49ea20b48c2mr30747685e9.15.1789564896452; 
 Wed, 16 Sep 2026 06:21:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83da071asm97284495e9.8.2026.09.16.06.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:21:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 5/8] ncr710: do not load s->current in advance
Date: Wed, 16 Sep 2026 15:21:17 +0200
Message-ID: <20260916132120.860910-6-pbonzini@redhat.com>
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

It is unnnecessary and potentially could use stale data.  Load
s->current just before use.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 9939d2e2813..4b20afa7e33 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1040,8 +1040,6 @@ static void ncr710_do_msgin(NCR710State *s)
 
 static void ncr710_do_msgout(NCR710State *s)
 {
-    NCR710Request *current_req = s->current;
-
     while (s->dbc > 0) {
         int to_move = MIN((int)s->dbc, NCR710_SCSI_FIFO_SIZE);
         uint8_t temp_buf[NCR710_SCSI_FIFO_SIZE];
@@ -1169,8 +1167,8 @@ static void ncr710_do_msgout(NCR710State *s)
                 break;
 
             case 0x0d: /* ABORT TAG */
-                if (current_req) {
-                    scsi_req_cancel(current_req->req);
+                if (s->current) {
+                    scsi_req_cancel(s->current->req);
                 }
                 ncr710_disconnect(s);
                 break;
-- 
2.55.0


