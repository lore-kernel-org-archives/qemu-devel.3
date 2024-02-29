Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2343FC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfaDu-0007hc-Gz; Thu, 29 Feb 2024 01:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rfaDo-0007Lp-4K
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:48:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rfaDl-0006SH-Lv
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709189324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=drGryLmlDnbb1TOonzHcX8forMbHQaGbfm74WcsgeKA=;
 b=GuH+u115u5OyHpfEV0jdSh9f3ohN/p7XQGxCzBbgK+jZGYjBKbKqGixQE3jbXxgYDKC5w1
 VSbr5GFeKFNyC90ehW/X7NQJrWvKzQMgVGs2VHPI8IMozZp8uF7DGWYKxVcUYFOXLGlszx
 t9ADIO2nT5YyuSyCwdoBqwXXLq27IL4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-Jj5DgvGYNvKIkZsOpmOiYg-1; Thu,
 29 Feb 2024 01:48:41 -0500
X-MC-Unique: Jj5DgvGYNvKIkZsOpmOiYg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DDFF3C1494B;
 Thu, 29 Feb 2024 06:48:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01ABE1121312;
 Thu, 29 Feb 2024 06:48:38 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH v3 0/1] Optimize Code
Date: Thu, 29 Feb 2024 14:48:35 +0800
Message-Id: <20240229064836.21867-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v2 -> v3
- Remove this declaration and make the function 'hexToIPAddress' as static.
- Define 'IFNAMSIZ' from kernel instead of a hardcode
- Remove 'GUEST_NETWORK_ROUTE_TYPE_LINUX'
- Set flags 'has_xxx' for checking if a field exists or has a value set

v1 -> v2
- Replace snprintf() to g_strdup_printf() to avoid memory problems.
- Remove the parameter 'char ipAddress[16]' in function 'char *hexToIPAddress()'.
- Add a piece of logic to skip traversing the first line of the file

Dehan Meng (1):
  qga/linux: Add new api 'guest-network-get-route'

 qga/commands-posix.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c |  6 ++++
 qga/qapi-schema.json | 80 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

-- 
2.40.1


