Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEB5CA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFBDK-0000u0-WC; Fri, 09 Oct 2026 10:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xFBDJ-0000sm-3z
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xFBDH-0007To-EG
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791554682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ljNn1XOWfi+3xRI9PcLvtRLf/d3+n96IiP95gNMxoLA=;
 b=IOyLxywjkj2GOH0LFeCzHTNQN3fU2lz+At7I97mnDfah6OCBR0hI7BxeBWyRodHopliZAn
 z3Thd53herhXhi0tdgi1FLXVVjXLhe48hYC6Qr/9RVpFSd/8HwIW4XDMYc0PfutqDtqeg5
 8v8ec/lNQhHOXPkhbqor+nsFbsdcNNM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623--RfyNE_1PROCYT4ZSG4mnA-1; Fri,
 9 Oct 2026 14:04:35 +0000
X-MC-Unique: -RfyNE_1PROCYT4ZSG4mnA-1
X-Mimecast-MFC-AGG-ID: -RfyNE_1PROCYT4ZSG4mnA_1791554674
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25640195FCD1; Fri,  9 Oct 2026 14:04:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEDD7447; Fri,  9 Oct 2026 14:04:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 47D0721E6A04; Fri, 09 Oct 2026 16:04:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	michael.roth@amd.com,
	jsnow@redhat.com
Subject: [RFC PATCH 0/6] qapi: Preliminary work for better QOM introspection
Date: Fri,  9 Oct 2026 16:04:25 +0200
Message-ID: <20261009140431.3175479-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Marc-André Lureau has patches to improve QOM introspection.  Latest
version is

    Subject: [PATCH v5 00/62] qom/qdev: associate properties with QAPI schema types 
    Date: Fri, 11 Sep 2026 20:34:34 +0400
    Message-Id: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
    https://lore.kernel.org/qemu-devel/20260911-qom-qapi-v5-0-7732a55b7760@redhat.com/

The first few patches make the QAPI code generator emit type
information for use by QOM introspection commands.  They refactor code
to gain access to masked type names, and to make query-qmp-schema not
elide types QOM introspection might want to refer to.

My series does this in a different way I find simpler.  It is RFC
because merging it only makes sense if Marc-André finds it useful.
Marc-André, please have a look.

Markus Armbruster (6):
  qapi/schema: Rename .lookup_entity() and tighten return type
  qapi: Ease access to introspection names
  qapi/introspect: Simplify masked name comment emission slighly
  qapi/introspect: Don't elide types
  qapi: QAPISchemaVisitor.visit_needed() is now unused, drop
  qapi/introspect: Tweak integer type masking

 docs/sphinx/qapidoc.py     |  2 +-
 scripts/qapi/introspect.py | 74 ++++++++++----------------------------
 scripts/qapi/schema.py     | 57 +++++++++++++++++++++++------
 3 files changed, 67 insertions(+), 66 deletions(-)

-- 
2.55.0


