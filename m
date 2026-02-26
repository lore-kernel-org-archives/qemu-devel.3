Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6716EFD4609
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 03:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvRrr-0003bk-DX; Wed, 25 Feb 2026 22:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vvRrp-0003bL-M9
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:16:45 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vvRro-0004h0-Al
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:16:45 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8c6f21c2d81so32881085a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 19:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772075803; x=1772680603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpAKj43cib22IuMyJbqH1W6yTVANl6eh+qWhnRWv5WI=;
 b=iyOpp+FXJ+3rBKZINiC0Ko9DAQafNu2E6vAIREr0/eQMOyxN3wYNcE3D7PzFpUUo1a
 waCQYjLquAp4uTCLCIdOl7jku3aNF6nsQDl2MScK0UdVfQcJ+/QFBnBVOGZaGarmfhex
 CtKca06XTIJozhH4OLHHGcAT7LFNEgbDp6gLoA/IQw+erMIMMG+ve+Be+8EsG633dz6B
 c9lpCIAoeJsfbCQyI8/iBOlMTjWTzsHPowonywfSfERarJinwFqVTlTUVi1brskymk4z
 3HGnNP73SqRAXOD/R7ZcelFay0bO4ugSLsfCDkJXDMCRmPg35cpHktDYK9KjttAtIWfT
 4s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772075803; x=1772680603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TpAKj43cib22IuMyJbqH1W6yTVANl6eh+qWhnRWv5WI=;
 b=GkJ4t56lc92z0C48JHFsD93xZC1vq6IjL9fgXlfkf4nvt4qAdXnfIfHeT3p7vJOhK2
 THAZSynm9ZYfNs/IahLbWj0LSV0SFr0kKP0/zbgYgKofOt56Gs4kYR+qRO2VS2Zo+Qcg
 ldFWC+xexi7UZSTPKszp9zcn588ZHqmJYRUOiijaNSBhTH6ftvPzra7EqmT7woUuPfg/
 OTZJ9yuj0XWDo6tkYTKUP/nuPfQr+/km+aGV6BPLflbnLIX2SLJTI1KZ9nmd2/LiuM6z
 NW+VHY41p7MjAxhJY6Uz40W5pS38rfEk3tmBB923vLByYVj4uwFS3JVqQ1d9lqiQJWD2
 2wGg==
X-Gm-Message-State: AOJu0YzXB9/0n4d3Nfsvst6MA4l/RIDGn9GrGexR7fnCqDIP7MVf5G8V
 mI89G15CsBdpwBjv8FsVeHt5eCCTeYTz7oj5GblyOOtpA5laF3OHP80nwFI9nQ==
X-Gm-Gg: ATEYQzxeYcWxOsBZSlNWIgbfaWU/9cK/3wG/1dViqqhIiAe+UIj3DWuJMUaxXdeiEhp
 owv5HPYh4DFJB0IoB7P6IXFcq7tTZw706c5raHIa/aDAKBzL9TTSdddnZntqokmEWWy1N4ZlpgU
 A7S7a9muzrfecJdEirJlR3GGa/4v8FYZCaeltwxVaPEUSpPvHU6MRBOVNruXeEGbajHuW9gh6pw
 GAPOqJl6PFFi77xBHHWFxzh62zgfNnTrs8UQi6hrz0cggEFF0/EGFMTbprMgmCGtM8QvDPbvjEC
 A/XYihxmOPeZ1W89DBTiHVfXJ2PIqB63kap/XD7cmyMuw7dicR+SgeC7xkKfl/YGuelK6YF2s6J
 SozYn8lTJ3gZbnHxUupn9MbbUANoQdNp49EgTJ4TENoRCccsSo4BPm3+tZSWONN8Af4JwjPuLkD
 SIJE5nhAIA+0kYTWtaDBUkU9NKA/FA2rk0mHmL9ETdsTpHV/u84+E=
X-Received: by 2002:a05:620a:4607:b0:8c9:f996:81f2 with SMTP id
 af79cd13be357-8cbc1102522mr79916085a.17.1772075802989; 
 Wed, 25 Feb 2026 19:16:42 -0800 (PST)
Received: from localhost.localdomain ([207.98.184.46])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c715af1fsm7376156d6.1.2026.02.25.19.16.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 19:16:42 -0800 (PST)
From: David Hamilton <dahamilt0@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Hamilton <dahamilt0@gmail.com>
Subject: [PATCH v3 2/2] hw/misc/ivshmem-pci: Check error after
 setup_interrupt() in process_msg_connect()
Date: Wed, 25 Feb 2026 22:16:33 -0500
Message-ID: <20260226031633.12369-3-dahamilt0@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260226031633.12369-1-dahamilt0@gmail.com>
References: <20260226031633.12369-1-dahamilt0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=dahamilt0@gmail.com; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

setup_interrupt() can fail and report via errp, but
process_msg_connect() was ignoring the error and continuing
to ivshmem_add_eventfd(). Check the bool return to avoid
operating on a vector whose interrupt setup failed.

Resolves the TODO comment at the call site.

Signed-off-by: David Hamilton <dahamilt0@gmail.com>
---
 hw/misc/ivshmem-pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index c987eebb98..147e8223bb 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -553,8 +553,10 @@ static void process_msg_connect(IVShmemState *s, uint16_t posn, int fd,
     }
 
     if (posn == s->vm_id) {
-        setup_interrupt(s, vector, errp);
-        /* TODO do we need to handle the error? */
+        if (!setup_interrupt(s, vector, errp)) {
+            close(fd);
+            return;
+        }
     }
 
     if (ivshmem_has_feature(s, IVSHMEM_IOEVENTFD)) {
-- 
2.50.1 (Apple Git-155)


