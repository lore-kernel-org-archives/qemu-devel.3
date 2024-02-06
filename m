Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A3EC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLou-00078V-Pq; Tue, 06 Feb 2024 08:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1rXLot-00077F-4y
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:49:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1rXLor-0004Gq-ID
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707227340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZlTXuUxevi1xdyeCWtbG2UH6Kfc0/VdJvdHbdkc9XzY=;
 b=Gmwgo09W4K04CM8vSQbXAi1efjJlx52LiBxbJQIj1uoCdljLFr5FKB3aC1fme2K5CAa3Rx
 s3x+5DXhNBhwRkRkDON9/dCYeXHTZY65d4ZqNIhuMzSlxI7+72bN8pk4/47jJUbzqZvAs7
 x158lEdsxfgSRGl1PvCrNoeJnmkYgx4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-k5mdq2dNOeey9SeWAyaO3Q-1; Tue, 06 Feb 2024 08:47:41 -0500
X-MC-Unique: k5mdq2dNOeey9SeWAyaO3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CCDF862CC3;
 Tue,  6 Feb 2024 13:47:41 +0000 (UTC)
Received: from work.fritz.box (unknown [10.39.195.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2512A2026D06;
 Tue,  6 Feb 2024 13:47:40 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH v3 0/5] Generate x86 cpu features
Date: Tue,  6 Feb 2024 14:47:34 +0100
Message-ID: <20240206134739.15345-1-twiederh@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

Synchronizing the list of cpu features and models with qemu is a recurring
task in libvirt. For x86, this is done by reading qom-list-properties for
max-x86_64-cpu and manually filtering out everthing that does not look like
a feature name, as well as parsing target/i386/cpu.c for cpu models.

This is a flawed, tedious and error-prone procedure. Ideally, qemu
and libvirt would query a common source for cpu feature and model
related information. Meanwhile, converting this information into an easier
to parse format would help libvirt a lot.

This patch series converts the cpu feature information present in
target/i386/cpu.c (`feature_word_info`) into a yaml file and adds a
script to generate the c code from this data.

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg02005.html
v2: https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg01773.html

Changes since v2:
* Rebased on top of current master
* Removed all "drive-by" changes to feature names ("vmx-ept-uc", "vmx-ept-wb",
  "kvmclock", "vmx-invept-single-context", and
  "vmx-invept-single-context-noglobals") as these needed further discussion.
* Changes to the generator script reduce the changes in formatting to the
  current feature_word_info even further to address the concern about code
  legibility. See Patch 5, "target/i386: Generate feature_word_info.c.inc" for
  all non-whitespace changes.

Tim Wiederhake (5):
  target/i386: Split out feature_word_info
  target/i386: Translate feature_word_info to yaml
  target/i386: Remove comments from feature_word_info.c.inc
  target/i386: Fix feature_word_info.c.inc formatting
  target/i386: Generate feature_word_info.c.inc

 target/i386/cpu.c                   | 679 +-------------------------
 target/i386/feature_word_info.c.inc | 710 ++++++++++++++++++++++++++++
 target/i386/feature_word_info.py    |  71 +++
 target/i386/feature_word_info.yaml  | 701 +++++++++++++++++++++++++++
 4 files changed, 1483 insertions(+), 678 deletions(-)
 create mode 100644 target/i386/feature_word_info.c.inc
 create mode 100755 target/i386/feature_word_info.py
 create mode 100644 target/i386/feature_word_info.yaml

-- 
2.43.0


