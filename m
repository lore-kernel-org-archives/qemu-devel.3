Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA94C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 18:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSLQI-0001mg-C7; Tue, 23 Jan 2024 13:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSLQG-0001lz-5a
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:22:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSLQE-00072w-MI
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706034173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/XIomd7FwtU6MAO8bx+bwdsVq7NLXu1L8ZYmsCFmiWg=;
 b=WRneLY1JMoQaJoAiip+2sOScUJQ0kIYvOvvBX5i+/uTcO62wXmqHVqdIbjsos8PfIU14Py
 9qyQnnpBwFXUMw9qFEqxfCAjoE26sWto92JRoWE/hZooLtO0jtPeugHwHLPOpPTLxTmmDj
 n55C4Vh8Sm0EdCYFsYnX5v+e3o0jY3c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-0xtK3HvvNd2VIC0J_vXsWA-1; Tue,
 23 Jan 2024 13:22:50 -0500
X-MC-Unique: 0xtK3HvvNd2VIC0J_vXsWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB172280C2AD;
 Tue, 23 Jan 2024 18:22:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 497472166B32;
 Tue, 23 Jan 2024 18:22:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH v2 0/4] util/uri: Simplify the code, remove unused functions
Date: Tue, 23 Jan 2024 19:22:43 +0100
Message-ID: <20240123182247.432642-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The URI function uri_string_unescape() is pretty much the same as the
function g_uri_unescape_segment() from the glib, so we can simplify
our code here quite a bit.
While at it, I also noticed that there are many other unused functions
in here which we likely can drop, too.

v2:
- Replace uri_string_unescape() with g_uri_unescape_segment(), so
  we can remove uri_string_unescape() completely now

Thomas Huth (4):
  util/uri: Remove uri_string_unescape()
  util/uri: Remove unused functions uri_resolve() and
    uri_resolve_relative()
  util/uri: Remove the uri_string_escape() function
  util/uri: Remove unused macros ISA_RESERVED() and ISA_GEN_DELIM()

 include/qemu/uri.h |   4 -
 util/uri.c         | 869 +--------------------------------------------
 2 files changed, 11 insertions(+), 862 deletions(-)

-- 
2.43.0


