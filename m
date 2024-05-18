Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79573C25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 02:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8AC0-0006xI-LM; Fri, 17 May 2024 22:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1s8ABx-0006wG-OY
 for qemu-devel@nongnu.org; Fri, 17 May 2024 22:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1s8ABv-0006v5-P4
 for qemu-devel@nongnu.org; Fri, 17 May 2024 22:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716000770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dWgjYc8agZKBw/q7IfMBainSsI5CypgMcIUuDYXNEVM=;
 b=bK84YwwzK+2IXyCdPU7jjhaUv9CGkoFCEI9IHxoUa9qbwCyPAF+S4FacSSW/YHen2CxsZN
 Hk1A9iv3LwrRuk7R26tMv7Cn9VS6l7vWyETYENxBiv2TiIPvNXJDNJ+QAydzWGofv3x0dQ
 5kX11n6BoHz1VeOQ9LgtS5qUoUVoKOg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-3aqXKhh_NDmZo07A3-reAw-1; Fri,
 17 May 2024 22:52:48 -0400
X-MC-Unique: 3aqXKhh_NDmZo07A3-reAw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0F1529ABA1B;
 Sat, 18 May 2024 02:52:47 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16307491032;
 Sat, 18 May 2024 02:52:46 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	stefanha@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 0/2] Fix NBD+TLS regression in presence of iothread
Date: Fri, 17 May 2024 21:50:13 -0500
Message-ID: <20240518025246.791593-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In v2:
- correct list email address
- add iotest
- add R-b

I'm offline next week, and have been communicating with Stefan who may
want to push this through his block tree instead of waiting for me to
get back.

Eric Blake (2):
  qio: Inherit follow_coroutine_ctx across TLS
  iotests: test NBD+TLS+iothread

 io/channel-tls.c                              |  26 +--
 io/channel-websock.c                          |   1 +
 tests/qemu-iotests/tests/nbd-tls-iothread     | 170 ++++++++++++++++++
 tests/qemu-iotests/tests/nbd-tls-iothread.out |  54 ++++++
 4 files changed, 240 insertions(+), 11 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-tls-iothread
 create mode 100644 tests/qemu-iotests/tests/nbd-tls-iothread.out

-- 
2.45.0


