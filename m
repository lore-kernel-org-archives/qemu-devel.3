Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E53EE3695
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZYG-0001SF-QG; Thu, 12 Feb 2026 11:28:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vqZY7-0001P6-Cs
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:28:17 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vqZY3-0007jA-99
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:28:14 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4833115090dso80575e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1770913686; x=1771518486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8aOSQznK0wRSj7jtceoYwT//BOFye86Z3vfSaQ7H8M=;
 b=ft1vsDiFcYHmPym8MCkCN8ZrSdixBGFkV8TRINfB4Q7WkXCBox90V2ipnCMx1t4anh
 NnXN9SpSLTIZ7rc0sZcOKwiNhT9xXEzFuegl09k/8uCkWbmTlEARoQCxcA0N9ARXVWAX
 vU99qRHmhmEJG3ZzyNG8IMz73h7tKhYyLBL3IDg2pQDPqic9j8GV1bdYsBMMAi9dE1BR
 YO0LnIyGYbnCXYZf4+BsAIP6dcTdpJo3bCqOAYq5c3DT9WCyaRrZx0Dy6JkiwVAMgwN0
 nEbFomHMfZPlpC7b4ilG3I5ooeypPMfSzMEHTkRoRz9oihkRvZRLegzroo/ICZmwwg9j
 eH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770913686; x=1771518486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8aOSQznK0wRSj7jtceoYwT//BOFye86Z3vfSaQ7H8M=;
 b=U63vp+5H+crAuIwins9QdCWbKk8DWh0W/bKd2H3zd65myrsrRhHP7jG4Nz6po88I59
 O32FAuvM/OAnmxd9P+vAZblqRZj946qwZ9kU2mx7jKmZ547TNhrgByxOl5gNgfWnLnGi
 Z8YsUXUcxvmUsx/VnWZatmqU29ayLpyPYObNYIhSdBtE6h4AgKNPKhVAxC/OiXB6roKi
 xZpHJothSU3BEWGJgvope1VvfgoTkW4wj8RSGR/rlWT6xuSYFG1ddAq5Dg0yH0N/h8k5
 4z9GT5Q4+qke3cTkUWCBbIGCpWv6rtFu78aDelGLyTeE3GKsELOy6r8I8HgF2DuILRSH
 DRSQ==
X-Gm-Message-State: AOJu0YzzwigQJjhNccT1YqYZOrlk/+UAvTYsbKjX5zs1TmfPJl1XDxxK
 KRotGFpAJJ4DxFpeg9UZO/atmqbE7VwnduA3WKnp2s+QpCdEBv0eYP4ZbjqyAtU+osPWddJ9gfp
 SWVKz
X-Gm-Gg: AZuq6aI7YSAEfFZkdRA4X0HzKw2LhptwUs9kn2mZsESREu0gBgVdmUBUOZ18kZAbQqQ
 FOnLdLZ2R4agYBZoV9bvOZmtob3LNOMzvHzgmrZam67ll4EagZJdXzB/AWwuSDeJsHGwu8Cczb+
 YkY9cK1ntnRIFNfVKbe6tLjnOEXPaxf6M3+fWJOOLjqinCff9cC6x4CXbTG4yF444GfNEryxYmD
 g2o/wcrnUrYHsHLeQBKyWEQc8WMHMqyEqaZdp4Cj7YkM8eU+zJUd9FUZ6YvaruqXLWcwnX/3zWi
 SueO9WtlHMwMFEb4H9fwPO1nT6hH4yUiBI+kxmCdKoJYeH0S3p/UVH8QnmMBazj12fzTSYrSe50
 txI8TMQck4+cq338CDA+1b84t2KG1jtdpq6lL1zKjdbXJYZXa3MTeW5fPn5aAql3JQwgJqFGx7j
 fR7KL4NwNUz1rLU40qvUubUKsZjPZTuI379kA+PRSz7oP9+3qg
X-Received: by 2002:a05:600c:3b12:b0:477:9814:6882 with SMTP id
 5b1f17b1804b1-483670fac0fmr43839005e9.5.1770913686453; 
 Thu, 12 Feb 2026 08:28:06 -0800 (PST)
Received: from localhost (710304585.box.freepro.com. [130.180.219.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a66c544sm59616405e9.6.2026.02.12.08.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 08:28:06 -0800 (PST)
From: Antoine Damhet <adamhet@scaleway.com>
To: qemu-devel@nongnu.org
Cc: Antoine Damhet <adamhet@scaleway.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 0/2] block/curl: fix S3 presigned URL support
Date: Thu, 12 Feb 2026 17:27:23 +0100
Message-ID: <20260212162730.440855-1-adamhet@scaleway.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=adamhet@scaleway.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

This series adds the support for S3 presigned URLs that only allow HTTP
GET requests. While working on this I also stumbled upon a deadlock with
concurrent I/O and slipped the fix here. Over the years there was
already an attempt to support these kind of URLs[1] and at least one
report of a user in need of the feature[2].

Unfortunately S3 only allows a presigned URL to live up to 7 days so we
can't really put an example with a stable URL on the commit message but
here is a presigned URL for the archlinux cloud image[3] that will
expire in ~7 days.

Cheers,
Antoine

[1]: https://lore.kernel.org/qemu-devel/110120539.4133.de5ac8a5-69d1-4f59-9540-4a679771a547.open-xchange@ox.pcextreme.nl/
[2]: https://lore.kernel.org/qemu-devel/7b37cc65-1314-29f4-006f-70836bdfb4b4@linaro.org/
[3]: https://test-presigned.s3.fr-par.scw.cloud/Arch-Linux-x86_64-cloudimg.qcow2?AWSAccessKeyId=SCWDHE3XBQGZFV282QKG&Expires=1771517864&Signature=9Jy5hOW%2FeHlpqQNQtKxg5AjVv9E%3D

Antoine Damhet (2):
  block/curl: fix concurrent completion handling
  block/curl: add support for S3 presigned URLs

 block/curl.c                          | 115 ++++++++++++++++----------
 block/trace-events                    |   1 +
 docs/system/device-url-syntax.rst.inc |   6 ++
 qapi/block-core.json                  |  14 +++-
 4 files changed, 92 insertions(+), 44 deletions(-)

-- 
2.53.0


