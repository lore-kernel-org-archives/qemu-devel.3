Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F23E10D14A2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7BAd-0005NU-MF; Mon, 30 Mar 2026 07:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8y-0003fF-Dp
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8s-0005wq-Dl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJNY+f2TrbCPXZjzOHz0yYvcyj3qPpUKW0IeXPo8WUg=;
 b=PJpGkRk6m+ckCjm7v4iGcNaSWOiiFSh4yDcvyRiChekIUmx5yOYOLX/glBBwDSU8UZlWfS
 VGma9CNEGkd5mDuBBegzgJyIkHZzGMUD/9khEjkR3ThUQsd2woerE8Na++hH4/hF1d97cu
 nLNx9G4KegVu4R8iiPIweoBZiZQSTLM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-2ax8G-3fMhS-Xmi3FcN4aQ-1; Mon, 30 Mar 2026 07:50:39 -0400
X-MC-Unique: 2ax8G-3fMhS-Xmi3FcN4aQ-1
X-Mimecast-MFC-AGG-ID: 2ax8G-3fMhS-Xmi3FcN4aQ_1774871438
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d034589d0so410910f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871438; x=1775476238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJNY+f2TrbCPXZjzOHz0yYvcyj3qPpUKW0IeXPo8WUg=;
 b=Ci0t0xDISiukipZsqHs56De+QYjUVZSHGQvWnYBk+eZCLwxGzS8F/NOzxhdxFb17Yg
 2udnfpPn/+m7zEC+O+h4+ZdPBv1CVbq+YR2q/NYAqBr7bV5XGraYw2PwxXooucZjCkFQ
 PChqh044re1axdrO+yyjsW30zViK1uXMCluYWu5JdRudO32YtEKbnE1p1aPlZRc9llbK
 cna/PvBGX8oa5IfeLR/NzyFBtlQ6uSDl7+IpJO6FFtjJBqVcc6x3h5MhV+RbDo4kuTk9
 JbsM2MauFHdzzEee8Y8GPx+tt25NrL26vgaJbnfrMSBQIWjhRxAYH0NRjPQweJ+zhvug
 mnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871438; x=1775476238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wJNY+f2TrbCPXZjzOHz0yYvcyj3qPpUKW0IeXPo8WUg=;
 b=Ljd7Ke101qhZ/P8GlGx0iEfrTMmnvbQ7GdAg+CvQ0kISLesayUzarEeWt8ogOAI3IL
 jxHgZo5iTytNPCn9VS1wJL6ByB3UHi+crcMCgfKR+6+EHCsErPVnTwSlMVlEYQbJd/uA
 gDYzIQHUzUpIX0DF0RVSmnn4MFrIOJQw4+5fedsM6Zr9Fzm5NELk0eApRUwn71IfitY+
 /cRf1qVK2pFxOgx/AJmNXRFiPV8IBNbu/hk623LfcNSDeZ9xx/lLxp3Z20prwT2TXghI
 /4vnK0dMXC0OL/uwP0a6xjXslYIQkSHFC2pO51yw6amIw0gPu+e1vcAYcRBXLUKhM1Wp
 nhkw==
X-Gm-Message-State: AOJu0YyVkaDbQEHXnunDYGXZzylvohRdlDyvJsl/w2ObMJHsaRlYDnBQ
 lqjGo00tzBR/+oFrSNxmGRZZcsoQagJQCNJKk7FgVYyfiCg2ioBy48o9RP75mYk/nyij7HWlU8s
 I5a05zcW2E0B4FISdXxgWzwl7M8EAQgVesp/6sMmAKqGGxeR1GNYvNy0+r51AJqsuaYAQG3zixd
 ncI2xut5DLq9DcdU5hmhBU9mzh3F9IRlr4bvwxyCAw
X-Gm-Gg: ATEYQzyyA5E38BZKKI21A5XOGEnHTGMG5pD6F9ZlmsEfO64lDfcFgxThpKP2FooD6yA
 MDfY8LiHrnzFlSDE/dQ0CeQGraH+cg2NXQbozWPsZN2pN0n98jojsCgIjsnn3zwENLrtUguRnjq
 1DCq3LPBdCt23PhkSipSKI7iVarz8IQd80Ti9e4+c0ASMFpP6wPhXWmFsdm50U77bXAvptMLiHK
 eRXJ3ZsvjoEkbzjCb4Www1g+kbI11TNgnYwLPovw39CO3RLj22pFzcnAP7P8T6+arlHVOIIs+0U
 7AeEZZZB3JCqAMsItMD7NiflxMJGwCMApmWlSXvTlpWbNb6JNw9SqSxn9XTa1jP5YZUwGzeTHvi
 +byD94ur5jsZXseWIs+r22+uPU2r6WzAfIAwK0zX+oYNp8bwUXqsM4K0+wImajvWGPUlKCaBVUo
 fQdaOdeTY2dAq3jbtGggGyS3Dx
X-Received: by 2002:a5d:64e8:0:b0:43c:fde6:2126 with SMTP id
 ffacd0b85a97d-43cfde62295mr7316034f8f.37.1774871437534; 
 Mon, 30 Mar 2026 04:50:37 -0700 (PDT)
X-Received: by 2002:a5d:64e8:0:b0:43c:fde6:2126 with SMTP id
 ffacd0b85a97d-43cfde62295mr7315970f8f.37.1774871436940; 
 Mon, 30 Mar 2026 04:50:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf24707f2sm19331948f8f.26.2026.03.30.04.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:50:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 07/12] lsi53c895a: keep a reference to the device while SCRIPTS
 execute
Date: Mon, 30 Mar 2026 13:50:11 +0200
Message-ID: <20260330115017.256211-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330115017.256211-1-pbonzini@redhat.com>
References: <20260330115017.256211-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

SCRIPTS execution can trigger PCI device unplug and consequently
a use-after-free after the unplug returns.  Avoid this by keeping
the device alive.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3090
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 6f43e500b3c..90643b26ab8 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1163,6 +1163,7 @@ static void lsi_execute_script(LSIState *s)
         s->waiting = LSI_NOWAIT;
     }
 
+    object_ref(s);
     reentrancy_level++;
 
     s->istat1 |= LSI_ISTAT1_SRUN;
@@ -1182,6 +1183,7 @@ again:
         s->waiting = LSI_WAIT_SCRIPTS;
         lsi_scripts_timer_start(s);
         reentrancy_level--;
+        object_unref(s);
         return;
     }
     insn = read_dword(s, s->dsp);
@@ -1630,6 +1632,7 @@ again:
     trace_lsi_execute_script_stop();
 
     reentrancy_level--;
+    object_unref(s);
 }
 
 static uint8_t lsi_reg_readb(LSIState *s, int offset)
-- 
2.53.0


