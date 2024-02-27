Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AB4C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezSk-0004OA-OB; Tue, 27 Feb 2024 10:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rezSX-0004Hy-7A
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rezSR-0005HD-JI
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709048005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xop/Ba5+TQcVzS6naoCuT4sW8PBrETBtuaYDcMfpves=;
 b=XsTJfhYP5EDGYGPLn66CzuEoCfLqKUIfFZ7TRzkWxeQvHk1nDT87rODd7MU7k7K3UR9r8u
 6YKX8RdTzSLs2lypnQ9hfCKNIBavV0moauYIoH5FuHLgJ0aDUCyix/mjvIydtBawmU1s14
 OtV3l/EGFYgI3s9b0RkjjWkBUzJo8CM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-BJCAy9w6MO-fTrSOHoZsKQ-1; Tue, 27 Feb 2024 10:33:23 -0500
X-MC-Unique: BJCAy9w6MO-fTrSOHoZsKQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EEC68828C3;
 Tue, 27 Feb 2024 15:33:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A5EC492BD7;
 Tue, 27 Feb 2024 15:33:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F14E621E66F4; Tue, 27 Feb 2024 16:33:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: steven.sistare@oracle.com, philmd@linaro.org, dave@treblig.org,
 jasowang@redhat.com, michael.roth@amd.com, peterx@redhat.com,
 farosas@suse.de
Subject: [PATCH v7 0/3] string list functions
Date: Tue, 27 Feb 2024 16:33:18 +0100
Message-ID: <20240227153321.467343-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

This is Steve's work (v1 to v5), tweaked by Philippe (v6), and now by
me.

v7:
* Old PATCH 1 dropped
  The proposed str_split() is a composition of g_strsplit() and a
  conversion from char ** to strList *.  I'm willing to accept a
  conversion function str_list_from_strv() next to
  strv_from_str_list().  I doubt having a function for the composition
  is worth the trouble.
* Old PATCH 4 dropped
  The tests mostly test g_strsplit().  I'm willing to accept focused
  tests for strv_from_str_list() and str_list_from_strv().
* PATCH 1-3: Commit messages tweaked
* PATCH 2: strv_from_strList() renamed strv_from_str_list(), and moved
  to qapi/qapi-type-helpers.c.  Function comment tweaked.  Local
  variable @argv renamed to @strv.
* PATCH 3: Adjust for the rename.

Steve Sistare (3):
  qapi: New QAPI_LIST_LENGTH()
  qapi: New strv_from_str_list()
  migration: simplify exec migration functions

 include/qapi/type-helpers.h |  8 ++++++
 include/qapi/util.h         | 13 +++++++++
 migration/exec.c            | 57 ++++++-------------------------------
 qapi/qapi-type-helpers.c    | 14 +++++++++
 4 files changed, 43 insertions(+), 49 deletions(-)

-- 
2.43.0


