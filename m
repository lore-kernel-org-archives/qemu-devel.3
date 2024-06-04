Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5CBC27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUXq-0005hs-BO; Tue, 04 Jun 2024 09:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUXp-0005ei-CH
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:49:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUXl-0002kU-WE
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717508980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j//Nxs201oTTkWwU4qV9/iE6SADkzu+L5NnjUPAzCrw=;
 b=NXrnU6CnyvfvfCtcpGTGYVTfFTt6LDJneEPALejM2rFAjT1pRgR2kA7UUv4KKDBuc4f73i
 uhHRLU0TmFvjiWTaFXxPn7TrhcNFGHwNM+QoKC5x6kZa7s0LPS0atRKNyCfKh5pyXpHYih
 ITfCq0u2NV685Jb9GvhEnDpWE4lAfh8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-64-lCUQmPUGjzWJIRJwj3w-1; Tue, 04 Jun 2024 09:49:37 -0400
X-MC-Unique: 64-lCUQmPUGjzWJIRJwj3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE2E885A588;
 Tue,  4 Jun 2024 13:49:36 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8851EC15C15;
 Tue,  4 Jun 2024 13:49:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/20] qga: clean up command source locations and conditionals
Date: Tue,  4 Jun 2024 14:49:13 +0100
Message-ID: <20240604134933.220112-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This series is a side effect of other work I started, to attempt to
make the QGA safe to use in confidential VMs by automatically
restricting the permitted commands. Since this cleanup stands on
its own, I'm sending it now.

The QGA codebase has a very complicated maze of #ifdefs to create
stubs for the various commands that cannot be implemented on certain
platforms. It then has further logic to dynamically disable the stub
commands at runtime, except this is not consistently applied, so
some commands remain enabled despite being merely stubs.

The resulting code is hard to follow, when trying to understand exactly
what commands are available under what circumstances, and when changing
impls it is easy to get the #ifdefs wrong, resulting in stubs getting
missed on platforms without a real impl. In some cases, we have multiple
stubs for the same command, due to the maze of #ifdefs.

The QAPI schema language has support for many years for expressing
conditions against commands when declaring them. This results in the
QAPI code generator omitting their implementation entirely at build
time. This has mutliple benefits

 * The unsupported commands are guaranteed to not exist at runtime
 * No stubs need ever be defined in the code
 * The generated QAPI reference manual documents the build conditions

This series is broadly split into three parts

 * Moving tonnes of Linux only commands out of commands-posix.c
   into commands-linux.c to remove many #ifdefs.
 * Adding 'if' conditions in the QAPI schema to reflect the
   build conditions, removing many more #ifdefs
 * Sanitizing the logic for disabling/enabling commands at
   runtime to guarantee consistency

Daniel P. Berrangé (20):
  qga: drop blocking of guest-get-memory-block-size command
  qga: move linux vcpu command impls to commands-linux.c
  qga: move linux suspend command impls to commands-linux.c
  qga: move linux fs/disk command impls to commands-linux.c
  qga: move linux disk/cpu stats command impls to commands-linux.c
  qga: move linux memory block command impls to commands-linux.c
  qga: move CONFIG_FSFREEZE/TRIM to be meson defined options
  qga: conditionalize schema for commands unsupported on Windows
  qga: conditionalize schema for commands unsupported on non-Linux POSIX
  qga: conditionalize schema for commands requiring getifaddrs
  qga: conditionalize schema for commands requiring linux/win32
  qga: conditionalize schema for commands only supported on Windows
  qga: conditionalize schema for commands requiring fsfreeze
  qga: conditionalize schema for commands requiring fstrim
  qga: conditionalize schema for commands requiring libudev
  qga: conditionalize schema for commands requiring utmpx
  qga: conditionalize schema for commands not supported on other UNIX
  qga: add note about where to disable commands for a platform
  qga: move declare of QGAConfig struct to top of file
  qga: centralize logic for disabling/enabling commands

 meson.build           |   19 +
 qga/commands-bsd.c    |   24 -
 qga/commands-common.h |    9 -
 qga/commands-linux.c  | 1805 +++++++++++++++++++++++++++++++
 qga/commands-posix.c  | 2375 ++++-------------------------------------
 qga/commands-win32.c  |   64 +-
 qga/main.c            |  154 +--
 qga/qapi-schema.json  |  153 ++-
 8 files changed, 2196 insertions(+), 2407 deletions(-)

-- 
2.45.1


