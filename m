Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED540E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLq6b-0003ZP-Uf; Thu, 12 Dec 2024 15:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLq6a-0003Yx-2H
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLq6X-0000tn-UK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734036488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXCs7VIoei9S9hqR7yNBH7oBFgZC3Ka7j9AgRTkR+AA=;
 b=gm2qbfEWUNNPsuGr/+pllY5ToKC9n8KcMuQQMMTTdHY2fcP2m2RPEGpOvMJBUzBd111KXj
 MGJKC2m6fy8grTYefqeyHiS3olZ6mVwISCWVbImDb1ZeKQy6EutEJc2h3y+Z5SHcBJhIS6
 WFpqlcjoVKA343PgXk8SYVVJnkC6n0w=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-FU_8xFV7P4apafgoobrVgg-1; Thu, 12 Dec 2024 15:48:07 -0500
X-MC-Unique: FU_8xFV7P4apafgoobrVgg-1
X-Mimecast-MFC-AGG-ID: FU_8xFV7P4apafgoobrVgg
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-844cfac2578so152648739f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 12:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734036486; x=1734641286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXCs7VIoei9S9hqR7yNBH7oBFgZC3Ka7j9AgRTkR+AA=;
 b=nAQXWe9jW/xH9fj8owNKvMqLPghUsq14+X5JvK9vRGfVT8Z2YPW9XXJ4WQA65tavsv
 UPxa+9TG/uM2T6QYCq7tXd6mXUjaRdNEKY6/ATseFi7FFhKui0abNNFd1PM8GID+l4ER
 LrfvG7QW4yOklGDvW8v4mAWMk1KWRNOvvIrsNDnJdhshs9CMuCmMVKVyrZBdpMOWOe99
 TtKEd8ryqoQGHiWS8e/xuyIt0BshS9o8rzsI0WR3z4SN0u1SQVKYe+jAwBZ+9ix8erYz
 ayCQzw6YjV9fHjvmWRJE6IAtSzW5ABpZnLiKeRTUmLm76stbAgXk3jozANbLzIfc4qvZ
 Yv0A==
X-Gm-Message-State: AOJu0YxgS3AOZ+tIBxD6MGOYBcEKWcNQvJfPT7LJ5+kulmDYVsQZ8YYA
 Ua2E6F7npNXN2rJuxO6nXNDaucY7mFLv5Fkpxy8mnFC/OMOk57YgPEgmjnVZGhxSDYSY6WmwfTN
 /qp0hq6osYP35tikeKdnrOpGH+nu0gUQ9VrBE8RsMV7QztIs6XLTLri0gx10+Ph9pSKcTnVHbsH
 KwGa14JQK2do47DnidZAMqnY8X0dl/PIcY1w==
X-Gm-Gg: ASbGncuFECE/34DF8UCEghxWJDe/wr1A/If2H5YOBwd1oOE7deYSsBx93l6fzSoYLKM
 8KLf7cWI1x0WAuQoo3U+1sTQPdWfbRB80voVx1WyBfSKQHjANfbeQDZExjEnKp2oUYE02DdqEO+
 nqWq0lZvKBl0JpqnhiHApRtKHd/ca3lIJye3005rtHCuTsfPq95RADvBebJsd/dFZiPmRLl2sn5
 JUjpYw0SChdnmUxTyXP4AWDief+tV/ZFjh3N4YJh4FA89gp+Fh3SeC8vuSL/NCF88RlFO9t9pF3
 F2g1jkp2/t8lY1/n9tAkdbj/6QQqjyOU
X-Received: by 2002:a05:6602:164f:b0:841:a678:de40 with SMTP id
 ca18e2360f4ac-844e866b1e4mr41838639f.0.1734036485840; 
 Thu, 12 Dec 2024 12:48:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLPOXQ5HYJZ9+O4ZTZ1OL1zYi0Y3Ii13pdgx76fflIAN6aQDFGRriXhW0DsI28WiUQX9KJpQ==
X-Received: by 2002:a05:6602:164f:b0:841:a678:de40 with SMTP id
 ca18e2360f4ac-844e866b1e4mr41836139f.0.1734036485474; 
 Thu, 12 Dec 2024 12:48:05 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844e57b48fcsm20807839f.35.2024.12.12.12.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 12:48:04 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 s_sourceforge@nedprod.com, Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 1/3] scripts/qemu-gdb: Always do full stack dump for python
 errors
Date: Thu, 12 Dec 2024 15:47:59 -0500
Message-ID: <20241212204801.1420528-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241212204801.1420528-1-peterx@redhat.com>
References: <20241212204801.1420528-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


