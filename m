Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC609CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbzpM-0005U4-6n; Tue, 23 Jun 2026 08:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@sourceandstack.com>)
 id 1wbzpJ-0005Rc-Ud; Tue, 23 Jun 2026 08:02:02 -0400
Received: from sourceandstack.com ([159.223.220.208])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@sourceandstack.com>)
 id 1wbzpI-0007Ha-11; Tue, 23 Jun 2026 08:02:01 -0400
Received: from fedora-3.home (apoitiers-157-1-11-96.w90-5.abo.wanadoo.fr
 [90.5.14.96])
 by sourceandstack.com (Postfix) with ESMTPSA id 6F3FD4803FA2;
 Tue, 23 Jun 2026 12:01:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceandstack.com 6F3FD4803FA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sourceandstack.com;
 s=mail; t=1782216111;
 bh=BHN7atiXl2Lolm9KNQnUWkU6Bt4eukBPAbBhsUd0z6g=;
 h=From:To:Cc:Subject:Date:From;
 b=SUkhMOzXCdB475Yu+QkhCr+0lH1jPLZNMu0Ffyj53uKMWE5/zFF5SlAo2O/WVGPpO
 OLYAS8+9zrAi040GdzUWBmjYolH6YO0ROmPClO2bCSoOMIsMJDIZnlwdGhrstZyWEr
 9kcuzh5KfggTS8P//RXpERT5yBTK08l+K5bJ/9V0=
From: Christian Hergert <christian@sourceandstack.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Christian Hergert <christian@sourceandstack.com>
Subject: [PATCH 0/1] [PATCH v2] block/vvfat: defer write commits to
 half-second timer
Date: Tue, 23 Jun 2026 14:01:46 +0200
Message-ID: <20260623120147.1626479-1-christian@sourceandstack.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F3FD4803FA2
X-Spamd-Result: default: False [0.90 / 15.00]; MID_CONTAINS_FROM(1.00)[];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCVD_COUNT_ZERO(0.00)[0];
 ASN(0.00)[asn:3215, ipnet:90.5.0.0/17, country:FR];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[apoitiers-157-1-11-96.w90-5.abo.wanadoo.fr:rdns];
 FROM_EQ_ENVFROM(0.00)[]; LOCAL_OUTBOUND(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action
X-Rspamd-Server: sourceandstack.com
Received-SPF: pass client-ip=159.223.220.208;
 envelope-from=christian@sourceandstack.com; helo=sourceandstack.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Christian Hergert <christian@sourceandstack.com>
---
 - v2: update tests to flush before checking contents in storage

-----BEGIN SSH SIGNATURE-----
U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgn0Noijiu+xEWY4CvDD7yVv6k3T
7J2x6bWnGCPV5Pt6sAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
AAAAQN+I7C3v3pmZpDIZyAgcq5c1+4BDylqpsGbqFBhFpDLXcm/mWrZoJii3GK3Ce+qdGe
F1dW+FOyJOYsDar+YVyQM=
-----END SSH SIGNATURE-----
-----BEGIN SSH SIGNATURE-----
U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgn0Noijiu+xEWY4CvDD7yVv6k3T
7J2x6bWnGCPV5Pt6sAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
AAAAQBHUGCB70DC5aAkYJdtqoTAlDS3+N6kv0bmmZ15j9QKKFpx/fN4/JTA3hPxbubdeVr
mphBILleJBL2b565llIws=
-----END SSH SIGNATURE-----
-----BEGIN SSH SIGNATURE-----
U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgn0Noijiu+xEWY4CvDD7yVv6k3T
7J2x6bWnGCPV5Pt6sAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
AAAAQOnadRs4oAAVWKsCySAOhrJaSTW98aeW+2Tqb5WJR56PY5d3qcZk4I3tdAwKK9/R04
vVwWMol8jAblAi/ijK3QQ=
-----END SSH SIGNATURE-----

Christian Hergert (1):
  block/vvfat: defer write commits to half-second timer

 block/vvfat.c                  | 130 +++++++++++++++++++++++++++++++--
 tests/qemu-iotests/tests/vvfat |  15 ++++
 2 files changed, 140 insertions(+), 5 deletions(-)

-- 
2.54.0


