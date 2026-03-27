Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5045910F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6EiC-0005KU-UO; Fri, 27 Mar 2026 17:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EiA-0005Ct-N6
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Ei9-0003oh-D8
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hPfYq4/WFarXboY4nnyRVuUgvfU5bRhiXWfm+ko4U8=;
 b=K1wJh/fLvMtJsI+wwqBiimS1g++Z27THTf/V2C9rMKaeQ6iOKlQ0qvnsL37NZDfg3qv/Le
 sYkUDPRrQTAkLH4akaLz72xyEmjtlQZuVL92V6wYStunWQSX+871+UF9dQsmSkt/CK/B21
 HhKWFKayZZeuGlg0NTUdf/bt5HtCIYw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-OaygELqpNhyapIMMBB32qw-1; Fri, 27 Mar 2026 17:27:19 -0400
X-MC-Unique: OaygELqpNhyapIMMBB32qw-1
X-Mimecast-MFC-AGG-ID: OaygELqpNhyapIMMBB32qw_1774646838
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43b9a86b9b0so1556727f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646835; x=1775251635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hPfYq4/WFarXboY4nnyRVuUgvfU5bRhiXWfm+ko4U8=;
 b=pUwdrosOn9D1rh7KcmLZlm3wHD/cXPk6dkzflbFPZqYCMlZN5sFxDq/f7i0JIsn+rU
 7O2hoKJfBiMp3Fbp9qftEgMo23pe3siiCnzA/OAGsf+Ys2/dMqjYzxsl36YOMCbH4xKp
 e38Moferjw/DaZFLo4f3sjcBuP/OM3xzWIFZ13mKrvfARiAn/SjVX3lAgnowJOgNkkGg
 DCi2tZtCCxjD+7h0C43LLPe4ZbveTKfgPZ7jjgF3FHttrRdumLmkaQ7guYIdNUCNfJiB
 6uO3fVj0vEuUNr2DFU06x3OIM/IlWqAhM+kSmwpZ7zwfSH3GOS9AyzNFwJ6vpWqevd16
 VHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646835; x=1775251635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4hPfYq4/WFarXboY4nnyRVuUgvfU5bRhiXWfm+ko4U8=;
 b=SSiNk9kHy06DQ3ZTGDIPdXUx5VaPCrD0W7moVgcbUOC0oiZtutXOQmQ7k4H40niZIm
 jm9xVyyD+ak0tW2+h+hS/pz+RgdlQzSVANXzBIG3AQoCOtvP8PbREOkRN6AfKxbpfqKc
 foxgI5V0vZxfTQNuKwza+hD+x2TUX5QvDtS5KyliDbJ5i5FqwjPKGt+ab6VMqgaG3Drh
 DnF/9O4n61ldz6FsJg9sQeRgk4MVbsLxZ1gPoie4SaAQbxJ7mDFeADLdKAv+bCrrGjZf
 mIf9OfdgLRWt4sbmsORTpjLMcmhviyX70ic8sSheGHgLgiEosRqHOlLOpqOmRSEmzDvZ
 KqNw==
X-Gm-Message-State: AOJu0YziD0FMguiTiWSfE+Qdty3dQr0dB3DzuB8bsS0HVOKqEl96P1iT
 mawkJOb3n1D2oD2dfuA/mfXApc7Aw+8kDlsmHGtJMqhq3DRzTRQW8WmtBBNetzihjuN0elPrSbc
 ULZovbXrbxA8p9bUp/R14z60KO9q1qvPAUisyAbBKbH02fwlKNDiJOgjgggW3VPrL53ovCpftk/
 oTaFQ5AvwmwFmXsdvIhsxVXveezNeFp7KahGAzpwA0
X-Gm-Gg: ATEYQzy1SCUFPYecsqCGfoRrf52DsKWVSp2FcL3T3VOe4Vkfwlo99TmLXXCqp+DTCVp
 qrJN7QzrlBbjnArn1rwSPBw0kcNfP7croCRiwUl9ZZ3enxj4bvmQLlAHHMmR8n2ukJCqMzHmfOe
 SVGobjOtDmaJ3xrij11gpJPHnyii43/oJ+O1W/WIMyELURQ2K0gNQi0cv7tkVotlB+wGiYlQwS2
 6CQ/Ni1ELo1aa1JX2+BBneuxoLdWP0YDKifPV1IKlHAbvCTFzWsCVSY/EnA3pkwuSIiEsuvliyu
 6V+lu8X86fN25aKhp8eIt3SvK2zj9o1Qo0TkZEuEwGH3FhlEZ4tBhXiQrMSks+XPTpCFOw9bMmb
 BKdyBCQGOTYUfhfbJuaL9hVz/Pubw32JiAwRQsrFMO7qIcXD968hgV7wZrMtFGPC3BIQKuxixpS
 EzJWTACkUWvMBlCeztW2ck5W8k
X-Received: by 2002:a5d:584b:0:b0:43b:7ff5:fdf7 with SMTP id
 ffacd0b85a97d-43b9ea4a3a8mr6435933f8f.29.1774646835586; 
 Fri, 27 Mar 2026 14:27:15 -0700 (PDT)
X-Received: by 2002:a5d:584b:0:b0:43b:7ff5:fdf7 with SMTP id
 ffacd0b85a97d-43b9ea4a3a8mr6435901f8f.29.1774646835078; 
 Fri, 27 Mar 2026 14:27:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e2487sm812846f8f.5.2026.03.27.14.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:27:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 13/16] ncr710: do not load s->current in advance
Date: Fri, 27 Mar 2026 22:25:44 +0100
Message-ID: <20260327212547.460420-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327212547.460420-1-pbonzini@redhat.com>
References: <20260327212547.460420-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index f768ad74237..298e0317b70 100644
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
2.53.0


