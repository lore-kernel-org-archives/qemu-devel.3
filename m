Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86407C3DA47
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9P5-0001nb-Fy; Tue, 09 Jul 2024 07:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9P2-0001hs-DK
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Ou-0006bu-In
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tdPFQXQSQZMNxFPBm94K3NbKgNhWOYAIwcO0ydpIx28=;
 b=eoXc0aF+sL+SHq8VL36Trr/PhKsWMbZx/d/BNzPsVDh3r5T5QFOM1/G0A6KpTjz+TyOBI+
 i3MGWuCGrqNUzMx0KvCQN6T25s9eRGaA3sgVPSFj4Levwj9/1W9UwQSFrU5QhQ9MDHvi+0
 gt3PtdiHUZTrE0q2LfWndAFuzMPPnN8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-T8zMhkbAPKG9bA1BafX6AQ-1; Tue,
 09 Jul 2024 07:52:46 -0400
X-MC-Unique: T8zMhkbAPKG9bA1BafX6AQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2BA51955F42; Tue,  9 Jul 2024 11:52:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13CA13000181; Tue,  9 Jul 2024 11:52:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 6/8] hw/block: m25p80: support quad mode for w25q01jvq
Date: Tue,  9 Jul 2024 13:52:26 +0200
Message-ID: <20240709115228.798904-7-clg@redhat.com>
In-Reply-To: <20240709115228.798904-1-clg@redhat.com>
References: <20240709115228.798904-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

According to the w25q01jv datasheet at page 16,
it is required to set QE bit in "Status Register 2".
Besides, users are able to utilize "Write Status Register 1(0x01)"
command to set QE bit in "Status Register 2" and
utilize "Read Status Register 2(0x35)" command to get the QE bit status.

To support quad mode for w25q01jvq, update collecting data needed
2 bytes for WRSR command in decode_new_cmd function and
verify QE bit at the second byte of collecting data bit 2
in complete_collecting_data.

Update RDCR_EQIO command to set bit 2 of return data
if quad mode enable in decode_new_cmd.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/block/m25p80.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 8dec134832a1..9e99107b42e2 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -416,6 +416,7 @@ typedef enum {
     /*
      * Micron: 0x35 - enable QPI
      * Spansion: 0x35 - read control register
+     * Winbond: 0x35 - quad enable
      */
     RDCR_EQIO = 0x35,
     RSTQIO = 0xf5,
@@ -798,6 +799,11 @@ static void complete_collecting_data(Flash *s)
                 s->four_bytes_address_mode = extract32(s->data[1], 5, 1);
             }
             break;
+        case MAN_WINBOND:
+            if (s->len > 1) {
+                s->quad_enable = !!(s->data[1] & 0x02);
+            }
+            break;
         default:
             break;
         }
@@ -1254,6 +1260,10 @@ static void decode_new_cmd(Flash *s, uint32_t value)
             s->needed_bytes = 2;
             s->state = STATE_COLLECTING_VAR_LEN_DATA;
             break;
+        case MAN_WINBOND:
+            s->needed_bytes = 2;
+            s->state = STATE_COLLECTING_VAR_LEN_DATA;
+            break;
         default:
             s->needed_bytes = 1;
             s->state = STATE_COLLECTING_DATA;
@@ -1431,6 +1441,12 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         case MAN_MACRONIX:
             s->quad_enable = true;
             break;
+        case MAN_WINBOND:
+            s->data[0] = (!!s->quad_enable) << 1;
+            s->pos = 0;
+            s->len = 1;
+            s->state = STATE_READING_DATA;
+            break;
         default:
             break;
         }
-- 
2.45.2


