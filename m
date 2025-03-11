Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21801C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts21h-0003T0-2v; Tue, 11 Mar 2025 12:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts21E-000325-UT
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts21B-0005J8-Pi
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0KzAbPAe7MgmTFNN7FC6r15PAqJskKuiy8zJAo76hM8=;
 b=eQkqGZmH4ZJTJbDQn/Wh5H64Q8UyJ5b40wMx7MOTuXSNlwMktSOoLfvwMkdEUewNGv42sl
 bfiKU2ckbpsxq8I29F2bs7guidfjIcwk1u2Dj1CYLdpRySO/9PpR88QiA2ykI7+AjkcjbD
 VLk0hfGBBqtdPj6YNuVhMezkHtpmKBk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-orMjJs9oP-qGnZCXDp2Jcg-1; Tue,
 11 Mar 2025 11:59:41 -0400
X-MC-Unique: orMjJs9oP-qGnZCXDp2Jcg-1
X-Mimecast-MFC-AGG-ID: orMjJs9oP-qGnZCXDp2Jcg_1741708780
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63E271955D4B
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 15:59:40 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6CF718001E9; Tue, 11 Mar 2025 15:59:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH for-10.1 00/10] Support vdagent migration
Date: Tue, 11 Mar 2025 19:59:22 +0400
Message-ID: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>


iQJQBAABCAA6FiEEh6m9kz+HxgbSdvYt2ujhCXWWnOUFAmfQXbMcHG1hcmNhbmRy
ZS5sdXJlYXVAcmVkaGF0LmNvbQAKCRDa6OEJdZac5bmLD/49TJdk8vSnG/G53f3Z
UdUGdDiv98lAr/1wPZvmLPGfxiVLrVQK9Rarjnq9+dzmjoJC+w8THyPIvlvlKAQO
aNSe5LV2lcYFLZwJqXQdGHTEWWZX3BmXroSFY06F9znX4lrNSg/cxLaI+Lt+dbEt
BA9IIMzGYB+zhkgJh86Yji1Ioz29qwMgb4etf4OtP3PqT7/djWxxdlYLmyqN7D13
seHAkvhaA7sqglLcfUv0MjrNA1Yxg3QQmbmiErpyaHo9kQ2AuV49THZl5/Pe3WR5
FJAeO83G8hdxdqFuDvnXB0ID2klqWYkZTJsTD75F1hU1yqszkVt8k4mUWubTIDNm
VEFKGz/S+xR2rO0RGgGzMPzEm0FSPbLq1+U2ETRf3xBns0Jbqe6njHeLGAzmOx9p
3F8fkM4mzIrs3oOU/e7dlxOl9N6uQhVfJW6G+9QMLPLveIpNR6CGphbgHuMK8PPL
vZ1WNrGa/xoHvqQi2FvIJJrnKYYBJDXQW1edM+apDgO9jBSmiO5XlKZjeNHwgZ6J
0sNmJUKCmk2SPGtFHdpdRfjfYfN2eR07eTVnVgstpHCUZi0nRz+4A6yq4k0SQLQH
ZWsaq6cdZyfNOOdSHaLfI/2/36eiLpVCAuwn+AjK+XvPR6mQc9rwebV8N5nXLEZ8
OFcig1i00RhHBRJFPrOjWIFIQg==
=iTg5
-----END PGP SIGNATURE-----

Marc-André Lureau (10):
  ui/gtk: warn if setting the clipboard failed
  ui/clipboard: use int for selection field
  ui/clipboard: split out QemuClipboardContent
  ui/clipboard: add vmstate_cbinfo
  ui/clipboard: delay clipboard update when not running
  ui/vdagent: replace Buffer with GByteArray
  ui/vdagent: keep "connected" state
  ui/vdagent: factor out clipboard peer registration
  ui/vdagent: add migration support
  ui/vdagent: remove migration blocker

 include/ui/clipboard.h |  31 +++++--
 ui/clipboard.c         |  66 +++++++++++++-
 ui/gtk-clipboard.c     |  13 ++-
 ui/vdagent.c           | 202 +++++++++++++++++++++++++++++++++++------
 4 files changed, 268 insertions(+), 44 deletions(-)

-- 
2.47.0


