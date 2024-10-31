Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6216D767E0
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 15:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6XUp-0005M3-DV; Thu, 31 Oct 2024 11:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6XUn-0005LV-5A
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 11:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6XUl-0006Jr-AI
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 11:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730390038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/h1tHjrUkHJINuo0E1iOTizfAxkU8uiOwRGIjNOipHI=;
 b=OijK844YMPMSkMlEC4ESBybMPhRaPjhwuwoG6ZAwb7bXOG/jAk0Tx/AsS6RUkT3IbkYKPL
 iLYMIHsGAPnPPA6iakr7ULTpT5ueqTdlC35/BXvTVhb8/c3ZROH7msVQMK9ZGYflJRL8oU
 yF7+77IS5wOM6ZYL7ZK9fQv1GRfiKH0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-yakfcxt8OQCFSGf5s0udSw-1; Thu,
 31 Oct 2024 11:53:54 -0400
X-MC-Unique: yakfcxt8OQCFSGf5s0udSw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE43C19560AA
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 15:53:53 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE0DE1956054; Thu, 31 Oct 2024 15:53:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC 0/5] RFC: require error handling for dynamically created objects
Date: Thu, 31 Oct 2024 15:53:45 +0000
Message-ID: <20241031155350.3240361-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

With code like

    Object *obj = object_new(TYPE_BLAH)

the caller can be pretty confident that they will successfully create
an object instance of TYPE_BLAH. They know exactly what type has been
requested, so it passing an abstract type for example, it is a clear
programmer error that they'll get an assertion failure.

Conversely with code like

   void somefunc(const char *typename) {
      Object * obj = object_new(typename)
      ...
   }

all bets are off, because the call of object_new() knows nothing
about what 'typename' resolves to. It could easily be an abstract
type. As a result, many code paths have added a manual check ahead
of time

   if (object_class_is_abstract(typename)) {
      error_setg(errp, ....)
   }

...except for where we forget to do this, such as qdev_new().

Overall 'object_new' is a bad design because it is inherantly
unsafe to call with unvalidated typenames.

This problem is made worse by the proposal to introduce the idea
of 'singleton' classes[1].

Thus, this series suggests a way to improve safety at build
time. The core idea is to allow 'object_new' to continue to be
used *if-and-only-if* given a static, const string, because that
scenario indicates the caller is aware of what type they are
creating at build time.

A new 'object_new_dynamic' method is proposed for cases where
the typename is dynamically chosen at runtime. This method has
an "Error **errp" parameter, which can report when an abstract
type is created, leaving the assert()s only for scenarios which
are unambiguous programmer errors.

With a little macro magic, we guarantee a compile error is
generated if 'object_new' is called with a dynamic type, forcing
all potentially unsafe code over to object_new_dynamic.

This is more tractable than adding 'Error **errp' to 'object_new'
as only a handful of places use a dynamic type name.

NB, this is an RFC as it is not fully complete.

 * I have only converted  enough object_new -> object_new_dynamic
   to make the x86_64-softmu target compile. It probably fails on
   other targets.

 * I have not run any test suites yet, so they may or may not pass

 * I stubbed qdev_new to just pass &error_fatal. qdev_new needs
   the same conceptual fix to introcce qdev_new_dynamic with
   the macro magic to force its use

Obviously if there's agreement that this conceptual idea is valid,
then all these gaps would be fixed.

With this series, my objections to Peter Xu's singleton series[1]
would be largely nullified.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05524.html

Daniel P. Berrangé (5):
  qom: refactor checking abstract property when creating instances
  qom: allow failure of object_new_with_class
  convert code to object_new_dynamic() where appropriate
  qom: introduce object_new_dynamic()
  qom: enforce use of static, const string with object_new()

 accel/accel-user.c               |  3 +-
 chardev/char.c                   |  5 +++-
 hw/core/bus.c                    |  2 +-
 hw/core/cpu-common.c             |  2 +-
 hw/core/qdev.c                   |  4 +--
 hw/i386/x86-common.c             |  5 +++-
 hw/i386/xen/xen-pvh.c            |  2 +-
 hw/vfio/common.c                 |  6 +++-
 hw/vfio/container.c              |  6 +++-
 include/qom/object.h             | 48 ++++++++++++++++++++++++++++++--
 net/net.c                        | 10 ++++---
 qom/object.c                     | 38 +++++++++++++++++--------
 qom/object_interfaces.c          |  7 ++---
 qom/qom-qmp-cmds.c               | 15 ++++++----
 system/vl.c                      |  6 ++--
 target/i386/cpu-apic.c           |  8 +++++-
 target/i386/cpu-sysemu.c         | 11 ++++++--
 target/i386/cpu.c                |  4 +--
 target/s390x/cpu_models_sysemu.c |  7 +++--
 tests/unit/check-qom-interface.c |  3 +-
 tests/unit/test-smp-parse.c      | 20 ++++++-------
 21 files changed, 151 insertions(+), 61 deletions(-)

-- 
2.46.0


