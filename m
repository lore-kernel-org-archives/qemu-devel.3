Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FEBD2FEDC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoBv-0003Fg-OS; Tue, 27 Jan 2026 13:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBa-00030A-H8
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBY-0000hU-KX
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZQB1J2GnKkcSVhSmw1xL9j3DRaUqmRPYIrFKnPzwZI=;
 b=hz/vAlWcyXTmd+UBxwE/mG2XXsM9hK/1IOf6l6smw9PMQJRC4g+ciaWz/pQMelY6uh8FNh
 usKUQQVodkj//TUAX7mLNAlDCKLLS87QO5ytc1g0TKoq0DHOjinePpSjbYunK0Hl544fQ2
 kFeDndXeQXqz1aZsGnT7i1IGTiGJBvU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-8rXe7MI-OaCq3vjkVP77lQ-1; Tue, 27 Jan 2026 13:53:06 -0500
X-MC-Unique: 8rXe7MI-OaCq3vjkVP77lQ-1
X-Mimecast-MFC-AGG-ID: 8rXe7MI-OaCq3vjkVP77lQ_1769539986
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c52af6855fso755497685a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539986; x=1770144786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZQB1J2GnKkcSVhSmw1xL9j3DRaUqmRPYIrFKnPzwZI=;
 b=ob8vKC0R/Hn1+sSk27Kw6oik6y9+07cU1wMZcTHDk1jZ/vZRrl1TGEmuAuMDFvryfI
 g2D2lZoWlR0hL2BPIUtK7zO9iI9NBOKA3JLmUtmyXWtWW0QT//lZf8U7ax+1Y7ATTxW7
 a97e8sYqiIoVh6kkGnH65i5ahN/fmmhLDdYpGeQQrBRd/N3P1s+g85DaSjUas/ARerBI
 dAKYf1YmA91fJccag/l4ID8CIzOKT7CJK3QI/vpD3hhgCyxBatdMZu3AD1tjz4h0che4
 mto0++nMLS8q/iuzeHXMTkK8dSMot7qSNs0v8D9K2+79VSv6lOE+iDk68uOjBsbc/zeZ
 b5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539986; x=1770144786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GZQB1J2GnKkcSVhSmw1xL9j3DRaUqmRPYIrFKnPzwZI=;
 b=bUEJ1cj+9c6fsX6xbmZuq35IEqApHRy3TKhAV83gBreo9naxUap7xKy7Ra3gGDFhje
 EpnOQsi12d5V/mGXW1kVbVL6wYJgH3N4cGLtqJ+zA+CpcMl1LjIvmJdHGHvw1rQkdOnh
 qeIX7IF9Yhol2KzQuNffYw3FHmDB2MIepyL/iDfqVnLBJ4tgtjsbs2lmrjwfeX+EFv7l
 juOTbX3kDXNMJW8Onpgt/9M1QOwNVp6MaUyLTUJLRbR2Qay1GMSEwUDAmuB+xN7B+TUr
 pAncPDygTh5d583L0Uqt5WFLcYy1T4N7THhWN42Z6JtJDRDg6D08a0xH4KohzEfUhPe5
 opJg==
X-Gm-Message-State: AOJu0Yxj5YsXM3S56kbqSTQ4v5xxkjzLHZ43QwIQ2CA+UgV9AoVflK2R
 RZBfIb6nfE/WfDFeqXpTZ9sgSPItPlwx5sasgi4tYmwTaX/Os67uBTamOlEnR8q5i19x9NyvgDu
 Orw1KC5MR+WvZXBicseVLKjlrMiwIxGIY0iA4ufWA8GoixnQM1dAnf6CkT1eIPsq0MaolHIJSux
 k7eMazorhfFz6/OlY0LEs0EhoKJxsCH1bGXLKXNg==
X-Gm-Gg: AZuq6aLDsLl/dR1EoQtVl8pwXIozsG9PJuI67ANzTupA+igSJs6wR4LDz+ljyfkgmX9
 GhMa8tPvhj8chayei1UaUgJQ+bwmdYR08ymcedNjBNBV2audofpc0h+OsX1sYcafboA67cFiXYl
 D1JE8EZtvYP8siO/tw+Djv+EH6LtRJz0HrwTi84Y5w7EQwuvk5IwBG59gnKxqrK2AAo/OqDcmgN
 ZOZ4llHIufaplFbRm5JNv5JlMHjHK/ADmJdBmGj8QMbdjb+R/y2G+hY/VfUxzquIGZaHDvSN/3o
 etqZmTNQ93Svvza541Ij1kNhXDGUDBgXolxn3vkmjHL0sWBfvexzmThDH6uEAcBZfLOUGoE81vq
 k
X-Received: by 2002:a05:620a:1988:b0:8c6:b45b:9e2d with SMTP id
 af79cd13be357-8c70b873b49mr355903485a.26.1769539985828; 
 Tue, 27 Jan 2026 10:53:05 -0800 (PST)
X-Received: by 2002:a05:620a:1988:b0:8c6:b45b:9e2d with SMTP id
 af79cd13be357-8c70b873b49mr355898285a.26.1769539985167; 
 Tue, 27 Jan 2026 10:53:05 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:04 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 07/24] colo: Forbid VM resume during checkpointing
Date: Tue, 27 Jan 2026 13:52:37 -0500
Message-ID: <20260127185254.3954634-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

COLO will stop the VM during each checkpoint on either PVM or SVM.

Accidentally resuming the VM during the window might be fatal because it
may cause the RAM and devices state to misalign, corrupting the checkpoint.

Hence forbid VM resume during the process.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor/qmp-cmds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 1ca44fbd72..0c409c27dc 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -84,6 +84,9 @@ void qmp_cont(Error **errp)
     } else if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
         error_setg(errp, "Migration is not finalized yet");
         return;
+    } else if (runstate_check(RUN_STATE_COLO)) {
+        error_setg(errp, "COLO checkpoint in progress");
+        return;
     }
 
     for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
-- 
2.50.1


