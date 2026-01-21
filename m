Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65ACC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viglx-0007jz-7d; Wed, 21 Jan 2026 17:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglv-0007j6-Qa
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglu-0003il-G8
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769034833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0KwZQsjE4pN+swkzLDzKgsPZ0j9sLwHdgCl9FXQ/rm0=;
 b=hA+0+kmZ08b5NjpBqg5HcgdrApUAkcUSXGMdfEzmlfvuUYyx9WIeZdkNnhhkHtRJY7KaPI
 LZ8I9RwwUDG7v22SC5Nb4B2lhqlrf6VvIEt3QKa+hQ6ZFT4Ww13E8uAha49svQXko1TBDF
 EaJHLaWery3Gy1i+jZipKQvtH/odSLI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-x3F33G4yPfildKOGvc8wKA-1; Wed, 21 Jan 2026 17:33:51 -0500
X-MC-Unique: x3F33G4yPfildKOGvc8wKA-1
X-Mimecast-MFC-AGG-ID: x3F33G4yPfildKOGvc8wKA_1769034831
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5014d56a63aso7701501cf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 14:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769034831; x=1769639631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KwZQsjE4pN+swkzLDzKgsPZ0j9sLwHdgCl9FXQ/rm0=;
 b=IEmkdceVggWhZ6DJCDKqIOClgtKjomKknsoKBIQH4EuirIYd+g+ozjjfUlpkf5/ZD8
 RhkwSZu4jj87oDWqw2xPgIrFeVngmYNEPbf66/HWzO5EueSpWOKOuuUl/PQV4Hv+EoNd
 s9A5jZ7dHY/gyGhXzHAVibjpUyqQ2WyM+q0KDMkI2qOmKsiV5JzcQPGjgIoWn4aK/CwT
 k2tS+f2USWKOoFU05g4xxV/jlMQkwuWoVbbGJBrDEsZFaaktz2dWAJX9Bpxx0I6Oj2fY
 VOQrY3zFFzyjuOlAv9p9q8eBdTUenl18EtSstUFIzkuRudPHFClmYexNt3y7pxHMHTyO
 QiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769034831; x=1769639631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0KwZQsjE4pN+swkzLDzKgsPZ0j9sLwHdgCl9FXQ/rm0=;
 b=XRTjUZANFAmBc0BAKqtgz88kEmmwzZTp/7ltLU4C0CNEgVnWwjJGI15eEHVlXWTl+8
 OxgYU0FlBaCWsDDl+d4FpxJlHP74nShjmYWWFhFPQkOYC+lYD6iJtetChM1cZcI0/a80
 yiUg31S96EXKX6yrm59ymaKQIAxV4ryMveE5gh41orogdB9vd5EObnHJuDOlOeNUA1ro
 bvvUOEdo+Eg4citV0jtCoIM8eKmT4DRrOwbSPGsuZhZM7b46kBc6LaUR/vPTuX9w5IrX
 JgBApjrPbEJKhheRiSCzKdua7ALCCPKpcMktGR3EqU3Vvd/bHBNe9b5kUj8x4p6qAwYI
 dorw==
X-Gm-Message-State: AOJu0YwYlsnqVLH8V0U5Za5JRqcv0BC+O8hXVsYVpezwIsUzR/8ELiHY
 hJaISQCztnLb/plSnDKd89OCq4oN0Sqn2YYZACDgzTYbd/lkzEjkVMhudTvDdV1xcwi3agbNLVC
 PTJEOrFbrCzfFVxMWv9ikbsNS46JRCYCehbcf8WW+UkZMBgkIzbto2y/dWsWIZ/TAG7F0Nk2aAu
 IaUryr/Fo5LfhwVNVErEjfu9QuUm/7WdZEhc1YOw==
X-Gm-Gg: AZuq6aL9Kk8qnOuzRcIeOEAHrLpw3/fS0kkN0bmbG35yOfGt2fMqYUwT4BD0JD0VZKn
 s31FJSGzwsOBuguWqaawaQvz/kfPXz+UD+PlGXKBr6sQA7eKGUUxtFm1EVMpmmAo+lSxC/r/jC3
 ENaUjU/8R0EU1eI7I0hAYt545e433L01fc7qOc4L7t/seLOmY4UXjHncexOc188gM6JfD1aLkIP
 Fm/fKWVLr1/bXjLRvoRNIYi4lXyshvpF51yBRFjezDJlIfMPssIQ7W1IxZNhtivDegoxUzU97WU
 o8aPycNBfZxNNtFaPFvUqSJ9vtJChASKVfbIu3IatQ5XZoFU6nnY/EXhtNrtqXW//5ThZ1lGhBq
 9
X-Received: by 2002:ac8:5a55:0:b0:4ed:8264:9199 with SMTP id
 d75a77b69052e-502a179c5bemr264430261cf.67.1769034830718; 
 Wed, 21 Jan 2026 14:33:50 -0800 (PST)
X-Received: by 2002:ac8:5a55:0:b0:4ed:8264:9199 with SMTP id
 d75a77b69052e-502a179c5bemr264429871cf.67.1769034830134; 
 Wed, 21 Jan 2026 14:33:50 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89470b0ac3fsm25598306d6.25.2026.01.21.14.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:33:49 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 08/10] migration/colo: Use the RAM iterable helper directly
Date: Wed, 21 Jan 2026 17:33:33 -0500
Message-ID: <20260121223336.3381912-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121223336.3381912-1-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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

qemu_savevm_state_complete_precopy() has a weird parameter called
"iterable_only".  It's needed because COLO saves device states in advance.

To make dropping that weird parameter easier, let COLO directly use the RAM
iterator helper instead, which should make the code easier to read too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/colo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/colo.c b/migration/colo.c
index c344943173..f92803dd29 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -469,7 +469,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
      * TODO: We may need a timeout mechanism to prevent COLO process
      * to be blocked here.
      */
-    qemu_savevm_state_complete_precopy(s->to_dst_file, true);
+    qemu_savevm_state_complete_precopy_iterable(s->to_dst_file, false);
     qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
 
     qemu_fflush(fb);
-- 
2.50.1


