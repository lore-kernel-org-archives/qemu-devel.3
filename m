Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB191C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGxV-0004Vp-1e; Wed, 29 May 2024 06:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxS-0004Ud-IM
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxP-0002pw-GB
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VYOcBDhJ8HciylCpBRGAPqcNY73QjdPdsYmrI7tl+k4=;
 b=MZU4IXit0BrF3ldKTrFTZ+hvX+iOdQrdwXL1aJEx8OEsMCIxwIq3F5JryMQu/+viELbZO/
 B7lBVZJD1Cu3QwVUfXgYisDXYbPA8XR18DV/s1JlKHJh3Y6EDiklRx4l0yOzR/eW96U3Br
 vfICO11q8MCeBD+e4CKENdlH6fRfD7w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-M1St05R7NhCZQivL9WSpcQ-1; Wed,
 29 May 2024 06:54:56 -0400
X-MC-Unique: M1St05R7NhCZQivL9WSpcQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E52F1C05131;
 Wed, 29 May 2024 10:54:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 976A21054820;
 Wed, 29 May 2024 10:54:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org
Subject: [PULL 00/22] s390x,
 build-oss-fuzz and Clang -fsanitize=undefined fixes
Date: Wed, 29 May 2024 12:54:32 +0200
Message-ID: <20240529105454.1149225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

 Hi Richard!

The following changes since commit 79d7475f39f1b0f05fcb159f5cdcbf162340dc7e:

  Merge tag 'pull-block-jobs-2024-04-29-v2' of https://gitlab.com/vsementsov/qemu into staging (2024-05-28 11:28:34 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-05-29

for you to fetch changes up to b04091393e6a71065aee6c91b2566f2dec95a4c9:

  qapi: Do not cast function pointers (2024-05-29 12:41:56 +0200)

----------------------------------------------------------------
* Fix and improve PER emulation on s390x
* Fix problems of the build-oss-fuzz CI job
* Fix broken update-linux-headers.sh script
* Fixes for compiling with -fsanitize=undefined on latest Clang versions

----------------------------------------------------------------
Akihiko Odaki (3):
      qemu-keymap: Make references to allocations static
      lockable: Do not cast function pointers
      qapi: Do not cast function pointers

Alexander Bulekov (2):
      fuzz: specify audiodev for usb-audio
      fuzz: disable leak-detection for oss-fuzz builds

Richard Henderson (14):
      target/s390x: Do not use unwind for per_check_exception
      target/s390x: Move cpu_get_tb_cpu_state out of line
      target/s390x: Update CR9 bits
      target/s390x: Record separate PER bits in TB flags
      target/s390x: Disable conditional branch-to-next for PER
      target/s390x: Introduce help_goto_indirect
      target/s390x: Simplify help_branch
      target/s390x: Split per_breaking_event from per_branch_*
      target/s390x: Raise exception from helper_per_branch
      target/s390x: Raise exception from per_store_real
      target/s390x: Fix helper_per_ifetch flags
      target/s390x: Simplify per_ifetch, per_check_exception
      target/s390x: Adjust check of noreturn in translate_one
      tests/tcg/s390x: Add per.S

Thomas Huth (3):
      hw/s390x: Remove unused macro VMSTATE_ADAPTER_ROUTES
      scripts/update-linux-headers.sh: Remove temporary directory inbetween
      scripts/update-linux-headers.sh: Fix the path of setup_data.h

 include/hw/s390x/s390_flic.h            |   3 -
 include/qapi/clone-visitor.h            |  37 +++--
 include/qemu/lockable.h                 |  23 ++-
 target/s390x/cpu.h                      |  85 +++++------
 target/s390x/helper.h                   |   8 +-
 tests/qtest/fuzz/generic_fuzz_configs.h |   3 +-
 qapi/qapi-clone-visitor.c               |  30 +---
 qemu-keymap.c                           |   8 +-
 target/s390x/cpu.c                      |  36 +++++
 target/s390x/tcg/excp_helper.c          |   2 +-
 target/s390x/tcg/misc_helper.c          |  68 +++++----
 target/s390x/tcg/translate.c            | 242 ++++++++++++--------------------
 scripts/oss-fuzz/build.sh               |   1 +
 scripts/update-linux-headers.sh         |   3 +-
 tests/tcg/s390x/Makefile.softmmu-target |   1 +
 tests/tcg/s390x/per.S                   |  82 +++++++++++
 16 files changed, 355 insertions(+), 277 deletions(-)
 create mode 100644 tests/tcg/s390x/per.S


