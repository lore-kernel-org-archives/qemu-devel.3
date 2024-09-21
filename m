Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7C0CF9C69
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2024 02:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srqEm-0006n4-H1; Fri, 20 Sep 2024 22:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1srqEh-0006lo-Ej
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 22:52:39 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1srqEg-0003HO-1i
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 22:52:39 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4X9YhF49xDz8PbP;
 Fri, 20 Sep 2024 22:52:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=lLjbb9srol5MHHS0SJ0jpXjtrVX/eEJkL9QPzOKQDD8=; b=MXJQ
 rtneWdLbXUFVOy5cHDh7bMLASGf9iCwDw5xO5SBYOmwE7rum4H7VYUHuqe8I7Min
 aEf+gdXtPkvulQQU3ecq3U3+b4oQiEQYbPOe1Y+3XbdtmoCXD13hQV8kBugYAerK
 fTXwr2B7eChYQBiEb0ie0L5BfLyqXuLxw8uHDNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=dqR6U16VEk/Qmy818HhMjI6xKDen0wBUvK2prYmd6GXR3NGCzCsX5
 SmsFr8Ta8AIgIvCtloWylZtg1Tj4lt/Jp3sVhla8SmWcyKXgaeU2dh94qpNhdrXq
 nAySf+eH81UW9Yp9tOzL8JGizUgDoU97it00a1Y8HsU2UMog0CidvM=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:cfcb:5d76:f5f5:6212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4X9YhF1pMqz8PbN;
 Fri, 20 Sep 2024 22:52:29 -0400 (EDT)
Date: Fri, 20 Sep 2024 22:52:27 -0400
From: Brad Smith <brad@comstyle.com>
To: Alex Benn_e <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] contrib/plugins: ensure build does not pick up a system copy
 of plugin header
Message-ID: <Zu4063fjfHC5hHUl@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
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

contrib/plugins: ensure build does not pick up a system copy of plugin header

With the ordering of the header path if a copy of QEMU is installed it
will pickup the system copy of the header before the build paths copy
and the build will fail.

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 contrib/plugins/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 05a2a45c5c..52fc390376 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -41,9 +41,10 @@ SONAMES := $(addsuffix $(SO_SUFFIX),$(addprefix lib,$(NAMES)))
 
 # The main QEMU uses Glib extensively so it is perfectly fine to use it
 # in plugins (which many example do).
-PLUGIN_CFLAGS := $(shell $(PKG_CONFIG) --cflags glib-2.0)
-PLUGIN_CFLAGS += -fPIC -Wall
+GLIB_CFLAGS := $(shell $(PKG_CONFIG) --cflags glib-2.0)
 PLUGIN_CFLAGS += -I$(TOP_SRC_PATH)/include/qemu
+PLUGIN_CFLAGS += $(GLIB_CFLAGS)
+PLUGIN_CFLAGS += -fPIC -Wall
 
 # Helper that honours V=1 so we get some output when compiling
 quiet-@ = $(if $(V),,@$(if $1,printf "  %-7s %s\n" "$(strip $1)" "$(strip $2)" && ))
-- 
2.46.1


