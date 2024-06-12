Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B947C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 10:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHLGP-0000VG-Id; Wed, 12 Jun 2024 06:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sHLGN-0000V5-I7
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sHLGK-0005W8-AS
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 06:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718188285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=36OILvTl00flFAhyOkXlhvG6WEZfOCLEZ/cfN8jW6Rg=;
 b=ThaZJOfrKitpUCRZ4d2z2rTNJpFCHMV3lEsSt0aX6gnuJRKRzdHKVtmcBOSSAovJgkax1K
 CVQPVA6mVCpjQLU/K+BHqHz3u/d5JXpXIf9JjxMyGHqCaWBri8CALn1l54MAO9OlbRwc1C
 BF9HtlxNOJityL3udSFVjpyCkzqYK1I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-ECKSgeq_NQuTSQi8cl3fAA-1; Wed,
 12 Jun 2024 06:31:22 -0400
X-MC-Unique: ECKSgeq_NQuTSQi8cl3fAA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 513A21956086; Wed, 12 Jun 2024 10:31:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.216])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6877119560AF; Wed, 12 Jun 2024 10:31:16 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH v5 0/1] qga/linux: Add new api 'guest-network-get-route'
Date: Wed, 12 Jun 2024 18:31:04 +0800
Message-Id: <20240612103105.301456-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

v4 -> v5
- Remove useless struct
- Rename 'GuestNetworkRouteStat' to 'GuestNetworkRoute'.

v3 -> v4
- Fix some indentation issues
- Update 'Since 8.2' to 'Since 9.1'
- Remove useless enum and adjust this change.

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
 qga/qapi-schema.json | 56 ++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)

-- 
2.40.1


