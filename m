Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AB0CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCISg-0000qC-MM; Thu, 01 Oct 2026 11:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCISd-0000pD-BU
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCISb-0000u6-Q0
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790867556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lcWLmzele1KePFBt1NDM09SM7asBQ6cEdSXpYPeRAqw=;
 b=LrzESRSXxmiLWOJaaT6jzXNtoIlYVbbfkraCj1ZoHQRkaeYhiibfJ73uCBh7NGwS2iKg0i
 z9yPomw6wv5Mw7jrH8XE61EVR4z+ycsFJnRk1A/6FNUwM/+yevrT+kGm5Of9zT0Hwmr9nh
 dJvc9FFEvJdF2wyOGsKBE6TpUvw7QXM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-8T1r2-9jOAaMpExoM4UuOA-1; Thu,
 01 Oct 2026 11:12:35 -0400
X-MC-Unique: 8T1r2-9jOAaMpExoM4UuOA-1
X-Mimecast-MFC-AGG-ID: 8T1r2-9jOAaMpExoM4UuOA_1790867554
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B40901802164
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 15:12:34 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9A031956042; Thu,  1 Oct 2026 15:12:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 03/20] trace: fix handling of char** in UST backend
Date: Thu,  1 Oct 2026 16:12:11 +0100
Message-ID: <20261001151228.3373747-4-berrange@redhat.com>
In-Reply-To: <20261001151228.3373747-1-berrange@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The UST trace backend fails to compile on version 2.14.0, as we
pass a "char **" arg as to ctf_string(), which only expects 'char *'.
It should instead be treated the same way as generic pointers, and
emitted as hex.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/tracetool/format/ust_events_h.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index cee7970a403..76c883bc5c0 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -72,7 +72,9 @@ def generate(events, backend, group):
             names = e.args.names()
             fmts = e.formats()
             for t,n,f in zip(types, names, fmts):
-                if ('char *' in t) or ('char*' in t):
+                if ('char **' in t) or ('char**' in t):
+                    out('       ctf_integer_hex(' + t + ', ' + n + ', ' + n + ')')
+                elif ('char *' in t) or ('char*' in t):
                     out('       ctf_string(' + n + ', ' + n + ')')
                 elif ("%p" in f) or ("x" in f) or ("PRIx" in f):
                     out('       ctf_integer_hex('+ t + ', ' + n + ', ' + n + ')')
-- 
2.55.0


