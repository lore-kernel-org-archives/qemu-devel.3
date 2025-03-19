Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7940CC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwHY-00071b-Bp; Wed, 19 Mar 2025 12:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tuwHM-0006xv-TT
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tuwHE-0001yj-AE
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742401696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1jN3JYaISGpCoQlHXSArIIlBu4y1yps/wWZ3QdGDmgM=;
 b=GrBhvl9Uq9C9qekwTDRffyn9MlPJYiOpVCgYEdY/t+LICbxct5JXLeUbZClBp3NIFwSrIU
 0998a8Y3wYibWxl8VbGGzr1rfEeYP6yJ6OWVpipH3k9VZhBRs5gtF9M2/2w24MtJAq897D
 vIaxvYbSA6pbpQ0WKM3E7Bhedxye3wU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-5fyBKuSiOi6bRz20I7LIiA-1; Wed,
 19 Mar 2025 12:28:15 -0400
X-MC-Unique: 5fyBKuSiOi6bRz20I7LIiA-1
X-Mimecast-MFC-AGG-ID: 5fyBKuSiOi6bRz20I7LIiA_1742401694
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E64C19560B3; Wed, 19 Mar 2025 16:28:13 +0000 (UTC)
Received: from speedmetal.redhat.com (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0AE7E1800946; Wed, 19 Mar 2025 16:28:10 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Pavel Hrdina <phrdina@redhat.com>
Subject: [PATCH v2 0/3] scripts: render_block_graph: Fix with new python and
 improve argument parsing
Date: Wed, 19 Mar 2025 17:28:06 +0100
Message-ID: <cover.1742401551.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

New python doesn't like '\l' escapes from the 'dot' language.

While at it improve usability of the script by employing proper argument
parsing.

v2:
 - use mutually exclusive group instead of hardcoding it (Pavel)

Peter Krempa (3):
  scripts: render_block_graph: Fix invalid escape sequence warning with
    python 3.12
  scripts: render_block_graph: Implement proper argument parser
  scripts: render_block_graph: Avoid backtrace on error from virsh

 scripts/render_block_graph.py | 80 +++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 23 deletions(-)

-- 
2.48.1


