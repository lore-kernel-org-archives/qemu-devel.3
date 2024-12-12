Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D62E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjVn-0007U0-Dq; Thu, 12 Dec 2024 08:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tLjVH-0007SM-40
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:45:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tLjVF-0003bB-2o
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734011114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bpdclzJsaIZALyPWoE54F2+ZJeOc/CWpGM1Z/p8NEJc=;
 b=i9prf64cC1UxfkiLxHA9Y/eY6EDxxqljiCI2Gs6Vt8VKH0G1EZv6+B+uHhHMjq/SP1Lr7g
 JRAZMhCXSBmI3+V5M7ZM43FVAQ9kbELvNcXXidjF6eJRdX1orK11gvkqdlGN8OEZzWeU5N
 UUzWi5MIsZ9tZ2zHgihIv6MZXKlpW3s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-YwlWieE3MgiE1-BSyjl98w-1; Thu,
 12 Dec 2024 08:45:10 -0500
X-MC-Unique: YwlWieE3MgiE1-BSyjl98w-1
X-Mimecast-MFC-AGG-ID: YwlWieE3MgiE1-BSyjl98w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 173921955F65; Thu, 12 Dec 2024 13:45:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.198])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 03CDA1956052; Thu, 12 Dec 2024 13:45:05 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Philippe Mathieu-Daude <philmd@linaro.org>
Subject: [PATCH v4 0/2] vpc: Read images exported from Azure correctly
Date: Thu, 12 Dec 2024 14:45:02 +0100
Message-ID: <20241212134504.1983757-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
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

Changes since v3:
- Split the change into two patches [Philippe Mathieu-Daude].

It was found that 'qemu-nbd' is not able to work with some disk images
exported from Azure as it uses a currently unknown 'wa\0\0' 'creator app'
signature. QEMU currently supports two methods for determining the image
size: CHS and 'current_size' and the list of known 'creator app's is used
to decide between the two. Invert the logic in QEMU and make 'current_size'
the default as it seems that VPC and old QEMU are the only two legacy apps
where preferring CHS makes sense.

Vitaly Kuznetsov (2):
  vpc: Split off vpc_ignore_current_size() helper
  vpc: Read images exported from Azure correctly

 block/vpc.c | 65 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

-- 
2.47.0


