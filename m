Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6076EC55ABA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr9Su-0003vB-MO; Tue, 04 Aug 2026 03:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wr9Sr-0003jW-ON
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wr9Sp-0001YU-DB
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785828086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+5DIBFkHj3MpvRH+EMQbVA7d1EFloNPTRZrCzMHzlM=;
 b=TGvP3fEKO0Wn5ZtDJF1BQ7hWwqv9qqylmQ0H74Se6OC7foY7fuUf/As2/NUD+JfMzCBweN
 qTLJQZrDa5iiG56qNrJL0P03n/dYSupJbLVZBc8p9tXoTjkFeicMNITNJehTQg+2MF/h6h
 5I3C/EF0oI2hywyph7NRhF4uXWSR0IA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-Li71nkCSN3mPwEw_IRbG3A-1; Tue,
 04 Aug 2026 03:21:20 -0400
X-MC-Unique: Li71nkCSN3mPwEw_IRbG3A-1
X-Mimecast-MFC-AGG-ID: Li71nkCSN3mPwEw_IRbG3A_1785828080
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D140B18002C1
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2026 07:21:19 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 280BB414; Tue,  4 Aug 2026 07:21:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 04 Aug 2026 11:18:58 +0400
Subject: [GIT PULL 9/9] qapi/dump: add allowed-by-guest feature to win-dmp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-fix-v1-9-0c2be5390809@redhat.com>
References: <20260804-fix-v1-0-0c2be5390809@redhat.com>
In-Reply-To: <20260804-fix-v1-0-0c2be5390809@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2712;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MW7OVd74nIo16HSj5Bdl5yYs6LiN+vBhp4QxuK4O7gg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcZJdSnIKZEBAgwjQMKcPRjfnS6V8k/18qyDdl
 McuO2bHbc6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanGSXQAKCRDa6OEJdZac
 5dwhD/45DFJTe3wdxqWfQIlpj8AjCOQ5uxpBvPjgRgNTWkKD3cOR8XX3///OtrObWzuDuvrXoau
 j2Qqa5H1OWlmb0Oga76/6ElxcCLeQ3EVIypBdyMe3ktqYecR4kHuVwS2YUdvu7YA/4yRuCiZZjl
 k0qVMieIyf/ooc6UqDc9yzu1Ri3paRYbohu9puN7OQjTn/Eryw4xMq/CuJun9ga29BILMNzUaWl
 XWq9W96DTDD2eHQkeusWIlwDd6OrqndBQUOb7kB6ikQLfoF7Z5yA7XXx8WsuK3bin7OMPUJHBS1
 GL93VoOoMYJ7g7ABxkoJAqAUMtvolOrQYcZvNC01zzt0tfgYXhFgucTV124sHF/fSLEPPpayAU2
 lSdsCjAd2iLAeQD+InCFbi4vmd7x/I03Tjvm4a7ullbqZhxCjnzS4Mh7MT8zTTBbatQzFAUSWUy
 cclphtzDVceLCOKyz8eAA+cjwfmHz3GHehZJARxi6yCvX50cWjRxOBU7hyq5OmQ/b7C6IYnIW3U
 mduOAT9CpTj0eDw0xc6Ab98JmzGREmXlU2jAUL0v696x2cjtMQAHlicMFIn8Cltg/6v/FJMXvZZ
 gmAaCAfvv6tif277CCgN1YOJDXPR0Qg+PdNc0bYaOwGZtzmFLo81OCW4/FxaC0Ep083WCkP4BBY
 CQdSwiQRD2xrF4g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

Commit 1c0e259c5a35 ("dump: make win_dump_available() check vmcoreinfo
for a Windows dump header") changed two things in a way that is visible
to QMP clients but not to introspection:
query-dump-guest-memory-capability now lists win-dmp only for a guest
that has published a Windows dump header through the vmcoreinfo device,
and dump-guest-memory, which shares win_dump_available(), rejects the
format otherwise. Before that, both accepted win-dmp on any x86
machine.

A client that wants to select win-dmp automatically therefore cannot
trust the capability query on its own: on an older QEMU it reports
win-dmp for every x86 guest, Linux ones included, where the resulting
dump is useless. libvirt ran into exactly this while picking a format
for on_crash and watchdog triggered dumps, and has no way to tell the
two behaviours apart.

Add an 'allowed-by-guest' feature to the win-dmp member of
DumpGuestMemoryFormat so the fixed behaviour becomes discoverable.
DumpGuestMemoryFormat is reachable from both
query-dump-guest-memory-capability's return type and
dump-guest-memory's arguments, so a single flag covers both halves of
the change. Where the feature is absent, a reported win-dmp says
nothing about the guest, and a client that needs the dump to be
loadable afterwards should fall back to elf.

CC: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260731155001.1204103-1-den@openvz.org>
---
 qapi/dump.json | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi/dump.json b/qapi/dump.json
index 726b5208703c..690f3963fe15 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -38,6 +38,13 @@
 # @win-dmp: Windows full crashdump format, can be used instead of ELF
 #     converting (since 2.13)
 #
+# Features:
+#
+# @allowed-by-guest: If present, @win-dmp is listed by
+#     `query-dump-guest-memory-capability`, and accepted by
+#     `dump-guest-memory`, only when the guest has published a Windows
+#     dump header through the vmcoreinfo device (since 11.1)
+#
 # Since: 2.0
 ##
 { 'enum': 'DumpGuestMemoryFormat',
@@ -45,7 +52,7 @@
       'elf',
       'kdump-zlib', 'kdump-lzo', 'kdump-snappy',
       'kdump-raw-zlib', 'kdump-raw-lzo', 'kdump-raw-snappy',
-      'win-dmp' ] }
+      { 'name': 'win-dmp', 'features': ['allowed-by-guest'] } ] }
 
 ##
 # @dump-guest-memory:

-- 
2.55.0


