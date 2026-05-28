Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D00CD6E45
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSh5y-0001nz-B7; Thu, 28 May 2026 16:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSh5x-0001no-2Q
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSh5v-0007lU-16
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779999160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/HagL7twaMFlVA0Reve5J1vdwwEinYuD3ZoBYB5YA8g=;
 b=Gl+TmZKw37xjreSMzuAswrXp0L0XUq062tvT6KX8WCZ5Uwqsu1Ds7oXwxlphRhAHb/M7cH
 SfS5HcdtWpde2zJuv1Y7aQdloyMH9CrY7lyZ3X6iC3MvkppEEUzhrLx+KYyOMROHRsVnm9
 ImmAHXKWbQCg573nwIzBsTThihvHtdk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-peKXKmC6OCmiBsS_jcBKAw-1; Thu, 28 May 2026 16:12:39 -0400
X-MC-Unique: peKXKmC6OCmiBsS_jcBKAw-1
X-Mimecast-MFC-AGG-ID: peKXKmC6OCmiBsS_jcBKAw_1779999159
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ccdfe1ff26so5790286d6.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779999159; x=1780603959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/HagL7twaMFlVA0Reve5J1vdwwEinYuD3ZoBYB5YA8g=;
 b=t9XP0Y5PiB6itq1hfIMEr2Z2wUmLQLvqnjVZUVU1e4euJSSLHgkVQzg9eKGXrtv/fx
 Y4Lao3vQtchLIO5/Zm2oqttyDeghdMWNZFXwqOIu5Up9wRsaJyDW7Edh0xRZ375I+o5/
 2x+eRQp3MsAvHBxISyBrqQGLz1kbaV6h6sKkNLQAOnFVU7cl7vPE+B8r/JXyLIJ4mskX
 2ZHrWFQck1GMoJE7rgG4+mITP6fThUkM/G6XEcKeY6kO71G+gq/g/VHI18ThMS3hfZLj
 bsTBfZaDO8m+xGYFgmjb7PelKtTt+m5INgm4ILIaGitmQ/7ovE0GYlL976xMT4NoOabU
 3Ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999159; x=1780603959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HagL7twaMFlVA0Reve5J1vdwwEinYuD3ZoBYB5YA8g=;
 b=mihLGeiVM315GG/81TFX2cqHX62k7aBLT1x23s57IXE54FU5BPMYLfUIntmGK6oijO
 x5vFALUZz83HI0l13RCXx7/6G1lFC6goosi7wWIK8pElfunLj8cnHMbPplyr7wyb/azs
 4ufHPevUHSDA+JTcrDaBbEaYR1hT+ORysA3k95mPXpmDffTsuID135cRsauvu5vs1jIk
 DR7G8PJjHuULandfTggD5L46XTpGbWJX0OipGDHsmC9dHbexmNFslLyPcrg3b0aH5XOB
 b/uLWnmC+pOpoDaxYSafdz5mV2tZpcd3LVC7JJ77w8UQh66rdnSgt9Ba/XeUjMLfqWZX
 JWng==
X-Gm-Message-State: AOJu0YwBQ54TZ+l8o3JSzhUxpNSs0uOZ46Kc6rw/VA35fFKjEf5AFNaz
 b5MeSYtUptUxnc7N8+oPja8nPFR7Ved+fyeJ5O56Ez1QmlG4So5YPqCn9YUR7dS3o1CwP5J/A9v
 ydIfujAoecP5Rb/MeMm58BvjYikxpJN6pydCqi5npn/jIz5jdedIdN0cEvjZHVn/k2o/1hEDmFj
 1Hvc0w0fCpWwsOrL/L1/rEiNs6IyPTWcWmwNfKXQ==
X-Gm-Gg: Acq92OF2/jnJxtzdovMZMVjkJtQCvgzYBrbg1RVEtqcuuWbeZw4oTHvTefzaxerFnT7
 YxS6vmgsS4ZyX8OoCVZdG68GEv15aL5LrA9r3KDvRBxcjRdkxEO34jOTV2BfvcoZhmdeyA2N1tS
 pDzygTlP39gvYN7YLX1qAeWYfDzeh6dYK800i6qgnCvZoYUIlhD7wjoFDBHn+oWEEQNdN6OsOag
 XyF2GJ6DUO79BzSL6rFgWP8dLVGGiI1LCj6e7V3OYExQaFGtKQ2QFzPB54s9CRYAp+zzORbdtZg
 yOw8lYmBYN/sU+351CW3HD7a/sWauMTHwUusrwzus/ms+VME8QS05L630B2UHeBiN2aTN9/eBRQ
 LqO7VJ3jdngxzbl64N0EJswk7qt4mbrSCicm51WzetxJKmNPd46ubQQ0=
X-Received: by 2002:a05:6214:4704:b0:8cc:e25a:675b with SMTP id
 6a1803df08f44-8cce25a6c5dmr10200986d6.47.1779999158748; 
 Thu, 28 May 2026 13:12:38 -0700 (PDT)
X-Received: by 2002:a05:6214:4704:b0:8cc:e25a:675b with SMTP id
 6a1803df08f44-8cce25a6c5dmr10200476d6.47.1779999158192; 
 Thu, 28 May 2026 13:12:38 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccd69da209sm26538146d6.20.2026.05.28.13.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 13:12:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] qapi/migration: Remove @cpr-exec-command doc in
 MigrationParameter
Date: Thu, 28 May 2026 16:12:36 -0400
Message-ID: <20260528201236.359452-1-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This parameter was developed during similar window when the deduplication
work was done, hence overlooked.  MigrationParameter is already in
exception list of doc sanity checker.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 27a7970556..e8756308cf 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -804,10 +804,6 @@
 # Migration parameters enumeration.  The enumeration values mirror the
 # members of @MigrationParameters.
 #
-# @cpr-exec-command: Command to start the new QEMU process when @mode
-#     is @cpr-exec.  The first list element is the program's filename,
-#     the remainder its arguments.  (Since 10.2)
-#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
-- 
2.53.0


