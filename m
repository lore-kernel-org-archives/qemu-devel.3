Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F85C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 08:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpNCs-0001EX-AO; Tue, 04 Mar 2025 03:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNBf-00009k-FG
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNBU-0003H5-CI
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741075162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=0hojsqr1mliEcFxxn6q69rS2Om4P70YoeoZzTwtq1pY=;
 b=ZvZxH9fnisCnjBLfOmBHjeJcpoi8fKqZ6PVvjmRtAPK6vXiL0JEFiEBa3XYYjWZp+1655Z
 isN+VguYvpaObqwm+4Otdb5C5TzWAx/EF61wQgSyEYr/yAfAlYLMF614cn49plosAvgyXP
 NALV33nJz4WQC0uLcDgAAi7FVJ4jFlY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-U2sa28p_O_WEeBI83GlEag-1; Tue,
 04 Mar 2025 02:59:20 -0500
X-MC-Unique: U2sa28p_O_WEeBI83GlEag-1
X-Mimecast-MFC-AGG-ID: U2sa28p_O_WEeBI83GlEag_1741075160
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2892F180087B
 for <qemu-devel@nongnu.org>; Tue,  4 Mar 2025 07:59:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D355719560AF
 for <qemu-devel@nongnu.org>; Tue,  4 Mar 2025 07:59:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3783421E66C3; Tue, 04 Mar 2025 08:59:17 +0100 (CET)
Resent-To: qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 04 Mar 2025 08:59:17 +0100
Resent-Message-ID: <87cyexw7je.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com Tue Mar  4 08:43:47 2025
Received: from imap.gmail.com ([2a00:1450:4025:402::6d]:993) by
 dusky.pond.sub.org with IMAP4-SSL getmail6 msgid:11/315748; 04 Mar 2025
 07:43:47 -0000
Received: from blackfin.pond.sub.org (p4fd0400e.dip0.t-ipconnect.de.
 [79.208.64.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b737074d8sm187289425e9.16.2025.03.03.23.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 23:21:17 -0800 (PST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5180D21E66C3; Tue, 04 Mar 2025 08:21:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 1/5] qapi/char.json: minor doc rewording for `hub` device
Date: Tue,  4 Mar 2025 08:21:13 +0100
Message-ID: <20250304072117.894134-2-armbru@redhat.com>
In-Reply-To: <20250304072117.894134-1-armbru@redhat.com>
References: <20250304072117.894134-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: [Gmail]/All Mail
X-GMAIL-LABELS: "\\Sent"
X-GMAIL-THRID: 1825647234722748545
X-GMAIL-MSGID: 1825647234722748545
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Roman Penyaev <r.peniaev@gmail.com>

Refine documentation for the hub device, specify the maximum.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <20250219090607.559887-1-r.peniaev@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/char.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/char.json b/qapi/char.json
index f02b66c06b..dde2f9538f 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -337,7 +337,7 @@
 #
 # Configuration info for hub chardevs.
 #
-# @chardevs: List of chardev IDs, which should be added to this hub
+# @chardevs: IDs to be added to this hub (maximum 4 devices).
 #
 # Since: 10.0
 ##
-- 
2.48.1



