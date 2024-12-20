Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89644E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaUy-0001O4-O3; Fri, 20 Dec 2024 05:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaUr-0001Cv-8g; Fri, 20 Dec 2024 05:44:41 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaUp-0005ia-SG; Fri, 20 Dec 2024 05:44:41 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2161eb95317so16527515ad.1; 
 Fri, 20 Dec 2024 02:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691478; x=1735296278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptTgrJ3AAjPAgcSpVyralWA7dIyvJHWNmDfWV22XPFk=;
 b=C2QJKjQIti8ootOiKpJws+u3bioig3hLdvI7G1J43AID3xcYg8OfkEsXiarXUhNlKQ
 Thbrg38oanvRpzXQ0f06UsuVVDLZuF/4ASpa5V1TBl0tqPdPbTYRb0FR9fMjIzi8FOYj
 RMBOOu/9EJD8pcYu/WDB79OLeipiJp1RJKAXcW+rDbgBswmKXEXpwYYwI/8V14aPFaUb
 ZYNiIZ+6E3awXNX1g2CxBVZVnhP+x6OfEQNeLr4QBApwFaAzya/U45A+b6QjEPXD7YZ9
 aoYWWzI2AFzg2tg3icqLIQ2BhEJB246gP4EtvKI1gPviHPr50oOEFyyj5s0W/d4Fa8Kz
 d4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691478; x=1735296278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptTgrJ3AAjPAgcSpVyralWA7dIyvJHWNmDfWV22XPFk=;
 b=RD5Nip/w5D6s3rkZs8em2pxmzh9ufoxStdKU20Q69ayfR3abX3ykNrJaf6JDlWMX+6
 SK+ShpHpPafY3gFN3gW7Xm3xmhKjKQ4JfebKUVRQSeSpJNyfmouvRkB1qXydqzmSAzFJ
 FKJP0kt7X5jBT2M0PvT17ibooyAqMvDO6UvOV8Hd6yeLdQUpfLjv/j20aVcjZTTjnAMV
 SBdc/BTR0PDaO2z09PJSm6lRsI9JWS68rdGWp7zQAQOiVxb+XqnclqgPGhbcDRUMpMMk
 9hYilpehC1YltgeIe3WsspeOrV32fYLMFOSpQEjKWQUhziSnJvKU/0kOfpfxaZtXezui
 He0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtuuB163RrxYMBZGm9+RRsxgdDWIbypWPSfpdfqMy8g58g7MiHUyq28292btO4E50nlltD73lp68P/@nongnu.org
X-Gm-Message-State: AOJu0YyJsFILEetojO2ctJMSF4IzfiaKXNZzTYEVq2yypzYptfS9iPrf
 ixszL+sTgGprfN1HSRL3wADxqccdx1iRnE2XkVSd4LJxz3CInTVthXmhvg==
X-Gm-Gg: ASbGncvLqxeUY2IpcjTLOiAeRmPG/jwh+GVcRJXD0Uo1jHJkok9bfM6YF/uM/tCJ1NB
 J4fvw73U2+8rkfOfKpMWbctZfJLxvmR52P5OgknsLv88cr73bZT2wT5sl3sQP1CP+VDn4fz/Joh
 SeoplLZQReQMOeZJ2uLte6dZskxQxVZNJWrcKOnXOanih4pJN1JXkNT83o8XInc7gQ2urIaM6nz
 KPA+W9ECZ6gEKINy4mLt7M8QEaxOV1OC6bKkbngCX+O3vV231UG4sqMnyYAcXJzDrue5rNEMRYH
 R/RTNHZ1bw==
X-Google-Smtp-Source: AGHT+IHHFjbJJDnydvH/EeyeQ+EbHqUtfiWYhPxLLlnL+4fEaaPAKUcotO2zlojz6R7w3hCvT3m/Dg==
X-Received: by 2002:a17:90b:2e10:b0:2ee:fd53:2b03 with SMTP id
 98e67ed59e1d1-2f452ec6ec7mr3462445a91.25.1734691478132; 
 Fri, 20 Dec 2024 02:44:38 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:44:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 16/17] tests/avocado/replay_linux: Fix cdrom device setup
Date: Fri, 20 Dec 2024 20:42:18 +1000
Message-ID: <20241220104220.2007786-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The cdrom device was not being added to the command line.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/replay_linux.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index 38b6f8e6652..6c08ddaaff1 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -57,6 +57,8 @@ def vm_add_disk(self, vm, path, id, device):
 
     def vm_add_cdrom(self, vm, path, id, device):
         vm.add_args('-drive', 'file=%s,id=disk%s,if=none,media=cdrom' % (path, id))
+        vm.add_args('-device',
+            '%s,drive=disk%s' % (device, id))
 
     def launch_and_wait(self, record, args, shift):
         self.require_netdev('user')
-- 
2.45.2


