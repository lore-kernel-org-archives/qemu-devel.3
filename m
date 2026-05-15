Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B39CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 09:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNone-0004Wc-Im; Fri, 15 May 2026 05:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wNonc-0004WC-D4
 for qemu-devel@nongnu.org; Fri, 15 May 2026 05:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wNona-0001y3-PO
 for qemu-devel@nongnu.org; Fri, 15 May 2026 05:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778837138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2yBU5VtTweY8IOyY2Tw62vnj/2PamRjDe6oobKXa0cw=;
 b=RWC0b86Ctl8OqdHHHujRHAYzkZhwdwzNyJ3U5CQ9HrWIT2+l7U7dPcFHqgPoNMCWxMfT+h
 Kk0XU7YRBXrIChoiUtDcvzkeeL+AhJjX8mqvkfnHhE2XVe4UdF1nm+swlojSqUgZJXCjLC
 mT3eK7hh58dehikACs6aAzkwjA1amQU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Josh_2BHMBaYV62UsMZgeQ-1; Fri, 15 May 2026 05:25:36 -0400
X-MC-Unique: Josh_2BHMBaYV62UsMZgeQ-1
X-Mimecast-MFC-AGG-ID: Josh_2BHMBaYV62UsMZgeQ_1778837134
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fde68e420so13583925e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 02:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778837134; x=1779441934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2yBU5VtTweY8IOyY2Tw62vnj/2PamRjDe6oobKXa0cw=;
 b=bLyyae9dizjv2kCIQ7fTRmbUAN5NfrCRze09iwrNmw2UcHT86H6dNvsaYoiEVO5Xlg
 eiVcVLJ3vYiftZOZTSn5eC071ONZ6OvLbRBFUSVtW47dJ0yCUdlCF827/eVx0DRkPlsM
 3SpawBmXMAZU4Dw28MhDEAGM+xCxef2ByezXN8J9uqMrGxNRkEW8t1MmIG3KBSw2YdYY
 vtSyz5j2LXev896ivzLwZGDGi1UIlE5uFCaJkxs8Y6ZnFsRJCEf2FaWrH4sxxbW5w3Xc
 re9OSqshZy2T54pweCJfxqcVkfhePVW+IeW0cfZLHLVIPjXWjcn9Ub2S/HPktADkPILC
 8stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778837134; x=1779441934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2yBU5VtTweY8IOyY2Tw62vnj/2PamRjDe6oobKXa0cw=;
 b=Tuqqc6RheYG+AHkI5GDbTOE1P38vzQyaFQjlcIxrAG6FtpTVR2y17wBSRMarS1gVvo
 lJw+tO+zzSGiIEq5BK9YujmZ0X6k+sh0FtUqGmQ26oIMygcCgy5Ts54gWCjHHUFyC0S1
 e+jSBghate8fmJwY3mHUskRi3uMMjmwdQ9V3mOFeYpjL9sKUjYYIypcM0rF8w0X2r/KX
 41DUfULxbiT0g3VibB4pPZdIgD0vGVkuNnLZ8AVEWjMluJ8hOu8DpIiSr0WYvebkv2L6
 upLaBl3JAYx7QP/i7aq6o8gOrDnKBL0FuFN4COs85bbiqbEviz5oE0YsmJIW3JuZFg+0
 xZfw==
X-Gm-Message-State: AOJu0YxkjHRVP7ny2h4x14Qopumb8EDos8XT/MzCLQ13A3EG2ey0eOV4
 Sl67g1J4svom72AziXtZxNTiuVGua299b+CzArsIOtso9xPju4RaapIj3D0nxjqZM8+T8+C/we0
 96lnJLMXqroOc+TP6VUNCzeTsMopETSMKsWsCMxu6RuS6RPrSSnTAACrF9VVKwt5Ib9atn1GcTl
 f/At3WgQQeaoICTPWEKowi21ZdSLh8jZF9Qeu/EWWK
X-Gm-Gg: Acq92OFc2+3VrHnzDjI+BPHXlQi7okeHa2/WCYDmxabeGbK9ZNTmLArNGTha8JwF1lk
 jso/bI9+nISikHJCoyw+fk7gYXKI2ktreWW+OMX4+wxqNFzLNQCTMlq5y4ETTLeI99enGVQNiR6
 1T09nrVPGRMuvdQjU1P2pmjf+7LNTyKAESN2NOis2hTKzS7gcwA81Sufd0SlFNVtsjOf51kw5az
 jG7hNBeuF+baXEdG+5Sic3N/0OaIow5vgkMHpz84aAKvQGmGum0AgTk7XbC0rhruuXOrC4l40Sp
 ijASQh+0fYjLHmUPv4solm+ypjHIg7YAzJAW8gCRTdFMyKz/WG/HA1HrRLwavDjgL0IIrUhuIBj
 eOarT/Nxi4kBKPprzsvvwmSIDxn5qzOxUkVqOLi6EhL1qEOInwonDxq0FHHIahf2sgf5l9HbgXj
 +/m5azpzxBm4hiRcMXsJ5A1rY9ixCD
X-Received: by 2002:a05:600c:c087:b0:48d:c0a:3813 with SMTP id
 5b1f17b1804b1-48fe60de6a7mr36243355e9.3.1778837134423; 
 Fri, 15 May 2026 02:25:34 -0700 (PDT)
X-Received: by 2002:a05:600c:c087:b0:48d:c0a:3813 with SMTP id
 5b1f17b1804b1-48fe60de6a7mr36243145e9.3.1778837133974; 
 Fri, 15 May 2026 02:25:33 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fea5297f7sm15302875e9.0.2026.05.15.02.25.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 02:25:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] lsi53c895a: clear tag byte when processing messages
Date: Fri, 15 May 2026 11:25:28 +0200
Message-ID: <20260515092528.3860322-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Instead of simply ORing the message byte, clear what
was there before.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 0843d325ab1..1b7f02fc7c9 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1041,16 +1041,19 @@ static void lsi_do_msgout(LSIState *s)
             }
             break;
         case 0x20: /* SIMPLE queue */
+            s->select_tag &= ~0xff;
             s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             trace_lsi_do_msgout_simplequeue(s->select_tag & 0xff);
             break;
         case 0x21: /* HEAD of queue */
             qemu_log_mask(LOG_UNIMP, "lsi_scsi: HEAD queue not implemented\n");
+            s->select_tag &= ~0xff;
             s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             break;
         case 0x22: /* ORDERED queue */
             qemu_log_mask(LOG_UNIMP,
                           "lsi_scsi: ORDERED queue not implemented\n");
+            s->select_tag &= ~0xff;
             s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             break;
         case 0x0d:
-- 
2.54.0


