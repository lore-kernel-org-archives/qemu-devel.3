Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4C1D2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCi-0004sK-MR; Tue, 27 Jan 2026 13:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBg-00035S-4Z
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBe-0000k4-0H
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OCGSzBZO7Qcay01osVXSmLFpVPre+Xa2F2P4gjiFVw=;
 b=QgzIL1JP50bJ44aFPYTg3C96H/2deAkcwirMcJfZvsW2z7Z/yxZXsH7Pn8XrZg5TWwSKzl
 +YaDDY8q1H2eU2Py9z12uBA7VnhMGwDxVbchncBbsrBxxwYILgAELbldnSYOQeZh5pJDsN
 FSsVEeeBMjoN8yhxeFJ5wyFYOiNC524=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-VsQ7tHHmO5yMzDOKJ2carA-1; Tue, 27 Jan 2026 13:53:10 -0500
X-MC-Unique: VsQ7tHHmO5yMzDOKJ2carA-1
X-Mimecast-MFC-AGG-ID: VsQ7tHHmO5yMzDOKJ2carA_1769539990
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88a39993e5fso188562976d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539990; x=1770144790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OCGSzBZO7Qcay01osVXSmLFpVPre+Xa2F2P4gjiFVw=;
 b=a8YdqkoG5zDIubZz6VUsdhs1DaI91wB1TMJRlZUqvIrcjfh23rCghl1CUTsqXS2yDl
 G/O0XMdnGo34BLJoMkW8yNQFieDktZLuMeSbCQFgLjMh50+/1AOZxFZ+Xu/+9wbzevxS
 L84QrvveLU9cFDH0WWGPdXLNGnipWGdP8iv9St8xay9Is9dQuZ8qL5vsExTuDXa6/tvP
 QgkikA9vjefokax9BVWdfuTzqZ41bOLaAFTw4MCZDwVX3u6yw5MnfyrXAbQH/B8vvCQO
 uGfcc1IUpleXx+kjX+aNH71jjB0TWy7FROBKDPi56HH1kEJMuh42Tg7GH4rfqhO6zm2o
 7Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539990; x=1770144790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0OCGSzBZO7Qcay01osVXSmLFpVPre+Xa2F2P4gjiFVw=;
 b=BjSDCGYRs7sGwJ19p/8yKZI14Q1WykZFkwaevzCl8H3mXIMpY+UGzmZfTBG7SzLjU9
 3i+XkfLdFmzm66LLR0nduPCb64y16WH0aLIJUv5NDDMZ+ou81ICc5PZNYHwkIM8yT1Fm
 x47MrQRbIyTZmhqPLSHidx7RljO+iFgC3II4/xJPKhABcQRR/LZxgunecG0gM3s+VmXf
 rzMx+EoPGs2Nd9JpHuJm68iA5jvMyMckptDqkmV286L2jO/cwYn1CUBoK8km0gMWluBz
 V51FObhhg88EIqU9GYDb+VSlzr6DS6rSZ2SYD50pUXLVmdCJmbTKzgMTMjGYGEq/GYKy
 w+qA==
X-Gm-Message-State: AOJu0Yz9JEAu87Y6dCqKtNRA7XevuO4imqb1/snAcJodEk3QnKSaJXER
 p+ogJyYSr32ckA3Qs/g2K3v53VBG9yrIi8920JfT1gp5menyHSzfs+l2lWLFUVBZd6fNOmz5RL1
 GLyW7jwjXlWxOqMPJr12Cx2Qs9jkKUkRb/lqVQCxeeu+eqUIl4FTM6mOZSjlyUQ1qOlevmwjuU2
 HACiUKvmS2ve+kdYdT8T8RGGvuEO7DxkW0tsXsvQ==
X-Gm-Gg: AZuq6aIYy8xnqcmY1+wC/5Q4fv+7UGOSa31SbtBVncFOSlHjbIBYFpQx6I8Ci+6FuGG
 yXai+lmfQPIZOeQkvI3IYUENWPPm7fv3zJhIUpB7bJCOm7H8T9HophjZ2uQnYRDloTpJBTx3gRD
 2CHGAzvJQi8cPsVskOfKUJeBmkSsk1MPaqUBRfDfj6pcFaq1mEXKs5PmENNUhO9rjn7p6ig8Xx0
 Es54ScMUc4UcKbopLoKzgKaXXGuRzS90C6fCzOVa+2+uwudJ8MSXWEwDupKJ3FQbFDWFk77LP2A
 bXmiIIsiXofxEvSec6IFNHQ5uo5JHSE3u2B/Fv4fJg3948XZc9gfPLYfQwx9hjVJBxUSDrTqxfW
 W
X-Received: by 2002:a05:6214:224d:b0:894:6f12:5da with SMTP id
 6a1803df08f44-894cc9786bcmr38388546d6.57.1769539989767; 
 Tue, 27 Jan 2026 10:53:09 -0800 (PST)
X-Received: by 2002:a05:6214:224d:b0:894:6f12:5da with SMTP id
 6a1803df08f44-894cc9786bcmr38388006d6.57.1769539989100; 
 Tue, 27 Jan 2026 10:53:09 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:08 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 11/24] migration: Drop qemu_file_set_error() when save
 non-iterable fails
Date: Tue, 27 Jan 2026 13:52:41 -0500
Message-ID: <20260127185254.3954634-12-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

All users of qemu_savevm_state_complete_precopy_non_iterable() process
return values.  There's no need to set error on qemufile (which we likely
should remove gradually across the tree).  Remove it for possible code
dedup to happen later.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index da9a60c73f..9d2109718a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1688,7 +1688,6 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         if (ret) {
             migrate_error_propagate(ms, error_copy(local_err));
             error_report_err(local_err);
-            qemu_file_set_error(f, ret);
             return ret;
         }
 
-- 
2.50.1


