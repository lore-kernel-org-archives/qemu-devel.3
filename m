Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D375FCD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzZ5-00071g-TY; Thu, 21 May 2026 05:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wPzZ2-0006zp-Tc; Thu, 21 May 2026 05:19:36 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wPzZ0-00080k-DJ; Thu, 21 May 2026 05:19:36 -0400
Received: from lt-jeanlouis (unknown
 [IPv6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57])
 by apollo.dupie.be (Postfix) with ESMTPSA id 6A71F1520CC9;
 Thu, 21 May 2026 11:19:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1779355169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uEzEqjOVGStAJsYUw0m3AibY2k0OJdiY9cAjDAuLsSQ=;
 b=Vvx8DXnTP8Wfynu4gE/ZQ5i3oWCT6Ht51MC+dkvxW62K2HyrvJHNEKs6YyxPYNdOTmgHel
 NQxxRw0UBhJJHTTYFC/gMFZG0OJFYeL7iCwW0R0AeAqvdwPxOxWL18u4zDIX/7UTpURsxX
 xdtZejWfPrTyyMErzeKJfNIEq8jR3svL8Dmuix+Av1lE8q5x1X2AL1yprNpKPzfmz1C2u7
 lrejXCeFYY52Xxj2iDMGX+eEmzoB9nZZq1YhW8FbbmQU1RnKohkfH7v+OVOA8+8Pb7OX7o
 3zYEiOywcC8ZytH/9ZiYAWI6vLbRrXleoxRBpn9fChSqxXVWZ2Yve+EMQsvdJw==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH v2 0/2] qcow2: add a way to repair bitmaps
Date: Thu, 21 May 2026 11:19:16 +0200
Message-ID: <20260521091918.2366140-1-jean-louis@dupond.be>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

A v2 version of the patch.
First of all a commit to move qcow2_check_bitmaps_refcounts lower into the code in order to make sure we can access update_ext_header_and_dir.
Next I've moved the repair functionality into the existing qcow2_check_bitmaps_refcounts function.

Thanks
Jean-Louis

Jean-Louis Dupond (2):
  qcow2: move qcow2_check_bitmaps_refcounts func
  qcow2: add functionality to repair bitmaps

 block/qcow2-bitmap.c   | 194 +++++++++++++++++++++++++----------------
 block/qcow2-refcount.c |   3 +-
 block/qcow2.c          |  15 +++-
 block/qcow2.h          |   3 +-
 4 files changed, 132 insertions(+), 83 deletions(-)

-- 
2.54.0


