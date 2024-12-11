Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1867CE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 20:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLT9f-0007KG-0t; Wed, 11 Dec 2024 15:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLT9a-0007Jf-Rp
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:17:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLT9Y-0004Ch-S2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733948267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXCs7VIoei9S9hqR7yNBH7oBFgZC3Ka7j9AgRTkR+AA=;
 b=HrjrYbJUmX0EJUssBw5/rT27ITeKYMN7C8qSE7R4V5/LdHhhrLS9ZBFXYt2PFGTltdObd4
 wUon5RnWORN9aEohrhF5LLlrYdypP6ZehJEmBGDlGQqvSV+JxBZWN+7k8tOK6mwVbrESEF
 mVjILPwxrTbd3Q5jep+KpYKc1T7CDis=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-7OZ3ccnXN-mhNKCMuh32Ww-1; Wed, 11 Dec 2024 15:17:45 -0500
X-MC-Unique: 7OZ3ccnXN-mhNKCMuh32Ww-1
X-Mimecast-MFC-AGG-ID: 7OZ3ccnXN-mhNKCMuh32Ww
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6eeef7cb8so90642885a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 12:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733948264; x=1734553064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXCs7VIoei9S9hqR7yNBH7oBFgZC3Ka7j9AgRTkR+AA=;
 b=iCWM4BV9G83zHra/XRBh5ssvv/ppXn9IQtXxCwT2/TQpko9qSNLrQGTBu/HXKzqsyg
 dxoLdIfyMC5aPKgnz5Qr4XlgCyw7EVCfehOSnLsWzlxEPIO3jYAyeK4i52RDrmJwl9ku
 LL5KSicB9p11scXZfc269D587Vl7Tqg2bOsUhBTNTy1JsThv83hE9Z70vInrHwiOfkFt
 5+IzdPL7dKAqfBrvmHluBIw/vK1hTGweOtBq9P5cRlnkzo67Fj3nR3Z5Rr4TJ1cR9AaW
 Z3ZBMhYvwxPuLAMgQV2qhOaRjXby+kHv5sKHYeM5vvVLSbHfOqFNexxFj+gwjpIyKEcI
 xUVw==
X-Gm-Message-State: AOJu0YzDBFOG0myC7vgGDElsASvMOGfFHTxqpC7S5ULHXxz6K6wNrcCy
 lGpCPdimhgiarJVY+RHzB+ZA69YwtGqhjnohL5TbsaplMjfAcPGndjqXIW51Y8t0ky24e/a3CPA
 lsNHlWMYah3Qw5f1lXUtzH1qOSy81saNpb3o4e0eDwh2wPis0CjU3REEpvDlgKC1yEW9am2xnSM
 lb+Fki7l824g6jHrezaatd9BbJE9hMiiEXMA==
X-Gm-Gg: ASbGncuD6ik9mc4V6pNxdQ3a8iehh64VsdgA/Xmy3wMiv4IrdGbJR1KpAlDruzFx1HJ
 Ab2HsRoxOp0tEdW3uSzz6x3t5bNTzvzu798JpcoQZzsW8pDX/uOnNK0eQZs4iRUF8vrWYqLbkjE
 S7aW2YI4ogidb0S7dJS8qBhA/ah5GPx5D5m5oj6fFZtjjNeF50LthabRBB/yRRZX4zkLbY094e5
 4HPLxMl/zQO7nIa1OdRIDz0dXpzMpCRDkcvWsUU7SrEZ3oFtJRrM7W4Asif8YSeAcjNODegNVbY
 nfX8pZWj7f4s9KGmBIiQr3tkAZCimA==
X-Received: by 2002:a05:620a:28c8:b0:7b1:41b8:9ed7 with SMTP id
 af79cd13be357-7b6f2543989mr93146785a.16.1733948263933; 
 Wed, 11 Dec 2024 12:17:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaNa4xDFjW5i2nqVVFQ1njbyRWGfigmNl7LjyotqkVMzGCSRnNtfr4k78x3PLJ1OX3Hn8Zew==
X-Received: by 2002:a05:620a:28c8:b0:7b1:41b8:9ed7 with SMTP id
 af79cd13be357-7b6f2543989mr93143785a.16.1733948263615; 
 Wed, 11 Dec 2024 12:17:43 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6c8c6425csm438857485a.100.2024.12.11.12.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 12:17:42 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 1/3] scripts/qemu-gdb: Always do full stack dump for python
 errors
Date: Wed, 11 Dec 2024 15:17:37 -0500
Message-ID: <20241211201739.1380222-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211201739.1380222-1-peterx@redhat.com>
References: <20241211201739.1380222-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It's easier for either debugging plugin errors, or issue reports.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/qemu-gdb.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
index 4d2a9f6c43..cfae94a2e9 100644
--- a/scripts/qemu-gdb.py
+++ b/scripts/qemu-gdb.py
@@ -45,3 +45,5 @@ def __init__(self):
 # Default to silently passing through SIGUSR1, because QEMU sends it
 # to itself a lot.
 gdb.execute('handle SIGUSR1 pass noprint nostop')
+# Always print full stack for python errors, easier to debug and report issues
+gdb.execute('set python print-stack full')
-- 
2.47.0


