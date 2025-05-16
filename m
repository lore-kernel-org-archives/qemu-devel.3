Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C86C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFxRG-0008PS-1K; Fri, 16 May 2025 11:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRF-0008PE-1W
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRD-0002c5-5M
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747411046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G6DqREFKwwgteXyKP7TZSmDj4NshSV+PmyQk9X+XziE=;
 b=gUlwZsWZuQLhHnijDks+LYla2hxAartsiTwNTXLAoY1hm24D1vJGR1+OXRp5iBMO5x64Ho
 Nh8cKm/rIj7PpdiHe0IP/Jh7injd31ysFJF58rYcyQLN4ERaRDDh5qci/RUkv7A4/qB+zk
 OSoXETLz3v7hKG61hOo5SJbc1IHY14k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-KIyHrEhgNLSyKhXrMgATZA-1; Fri,
 16 May 2025 11:57:25 -0400
X-MC-Unique: KIyHrEhgNLSyKhXrMgATZA-1
X-Mimecast-MFC-AGG-ID: KIyHrEhgNLSyKhXrMgATZA_1747411044
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A70819560BC; Fri, 16 May 2025 15:57:24 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 777B318003FC; Fri, 16 May 2025 15:57:22 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 0/7] util/qemu-sockets: Introduce inet socket options
 controlling TCP keep-alive
Date: Fri, 16 May 2025 17:56:52 +0200
Message-ID: <20250516155710.2246148-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

This series extends the work introduced by commit aec21d3175 ("qapi: Add
InetSocketAddress member keep-alive"). [1]

First, the series fixes an issue in qio_dns_resolver_lookup_sync_inet(),
where the InetSocketAddress structure is only partially copied. Next, it
refactors setting client socket options into a separate function and the
success and failure paths in inet_listen_saddr() in preparation for
keep-alive support on server sockets and the addition of new TCP
keep-alive options.

Then, the series extends the support for keep-alive on server sockets.

Before adding new inet address options, there are a couple of issues
with the inet address options parsing this series resolves:
- the parser contains a bug where it does not allow options with names that
  start with the name of another flag,
- the parser lacks some common function for parsing numeric values,
- the parser supports only a subset of the inet address options, namely
  the 'numeric' flag is missing.
This is resolved by the sixth patch by reworking with parser using the
QemuOpts parser. The series also includes unit tests to verify, there is
no regression in the refactored parser.

Finally, the series introduces three new InetSocketAddress options for
the control of TCP keep-alive settings. By default, the value of all new
settings is 0, which means no custom socket option value is set.

This is useful, for example, for live migration. In case there is no
traffic from the destination to the source machine during postcopy, the
destination cannot detect a failed connection due to a lack of
non-acknowledged packets and stays in the postcopy-active state until
paused by the management of the QEMU instance.

[1]: https://lore.kernel.org/all/20190725094937.32454-1-vsementsov@virtuozzo.com/

---
V4:
- refactored inet_parse() to use QemuOpts, this resolves a bug and
  allows more option types, with tests
- fixed HAVE_TCP_* macros on Windows and macOS and other suggestions by
  Daniel

V3:
https://lore.kernel.org/all/20250408112508.1638722-1-jmarcin@redhat.com/
- moved the InetSocketAddress struct copy fix and the common function
  setting socket options into a separate commit
- refactored inet_listen_saddr()

V2:
https://lore.kernel.org/all/20250319163638.456417-1-jmarcin@redhat.com/
- moved socket options setting into a common function for both server
  and client sockets (suggested by Vladimir)

V1:
https://lore.kernel.org/all/20250303143312.640909-1-jmarcin@redhat.com/

Juraj Marcin (7):
  io: Fix partial struct copy in qio_dns_resolver_lookup_sync_inet()
  util/qemu-sockets: Refactor setting client sockopts into a separate
    function
  util/qemu-sockets: Refactor success and failure paths in
    inet_listen_saddr()
  util/qemu-sockets: Add support for keep-alive flag to passive sockets
  tests/unit/test-util-sockets: Add tests for inet_parse()
  util/qemu-sockets: Refactor inet_parse() to use QemuOpts
  util/qemu-sockets: Introduce inet socket options controlling TCP
    keep-alive

 io/dns-resolver.c              |  21 +--
 meson.build                    |  30 +++
 qapi/sockets.json              |  23 ++-
 tests/unit/test-util-sockets.c | 196 ++++++++++++++++++++
 util/qemu-sockets.c            | 330 ++++++++++++++++++++-------------
 5 files changed, 458 insertions(+), 142 deletions(-)

-- 
2.49.0


