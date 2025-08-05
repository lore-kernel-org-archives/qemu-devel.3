Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C494C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 20:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujOIP-0005bV-09; Tue, 05 Aug 2025 16:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ujOIM-0005ZZ-P6
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:30:02 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ujOIK-000212-LJ
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:30:02 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5CA962124E;
 Tue,  5 Aug 2025 20:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754425792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VRULV+ymMCvZc9Iyqp7L5cGdcUDu/LJqknfHUx5lcQ=;
 b=XDi8c4thhaD6PRkMdDyQash3RYNR8oXzANfR3ZuVkRpfIs60lxg6hKc60dHSAfQPxqH3lY
 5f7ygzo8O21SVeXn1HHGYPyY4ppnhgBU6/YhabygHXXunVrV9oUq+OwtPnvrHHvtpb3mQG
 Reoe62IudzAgJ7wM52Wh5wu1roY6oHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754425792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VRULV+ymMCvZc9Iyqp7L5cGdcUDu/LJqknfHUx5lcQ=;
 b=ZN+AhnFdJxzUOgDwltaCcbQCZZh77yjNkT6a2eqFo8kQj1eXu7a5tCtuJd9CBtA3tEq5ae
 lLDUW5stOShCA5Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754425792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VRULV+ymMCvZc9Iyqp7L5cGdcUDu/LJqknfHUx5lcQ=;
 b=XDi8c4thhaD6PRkMdDyQash3RYNR8oXzANfR3ZuVkRpfIs60lxg6hKc60dHSAfQPxqH3lY
 5f7ygzo8O21SVeXn1HHGYPyY4ppnhgBU6/YhabygHXXunVrV9oUq+OwtPnvrHHvtpb3mQG
 Reoe62IudzAgJ7wM52Wh5wu1roY6oHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754425792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VRULV+ymMCvZc9Iyqp7L5cGdcUDu/LJqknfHUx5lcQ=;
 b=ZN+AhnFdJxzUOgDwltaCcbQCZZh77yjNkT6a2eqFo8kQj1eXu7a5tCtuJd9CBtA3tEq5ae
 lLDUW5stOShCA5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DF9A13AA8;
 Tue,  5 Aug 2025 20:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sP6PL75pkmjpQwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Aug 2025 20:29:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/1] meson: remove 'gnutls-bug1717-workaround' for migration
 TLS crashes
Date: Tue,  5 Aug 2025 17:29:46 -0300
Message-Id: <20250805202946.19644-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250805202946.19644-1-farosas@suse.de>
References: <20250805202946.19644-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email, gitlab.com:url,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

From: Daniel P. Berrangé <berrange@redhat.com>

The implementation of this workaround does not currently work, so
remove the option entirely to avoid exposing it to users. The code
will remain (temporarily dormant) to be fixed in the next release
cycle.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/20250805182431.504158-1-berrange@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 meson.build                   | 6 +++---
 meson_options.txt             | 2 --
 scripts/meson-buildoptions.sh | 5 -----
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/meson.build b/meson.build
index e53cd5b413..a7b3c683ce 100644
--- a/meson.build
+++ b/meson.build
@@ -1836,11 +1836,11 @@ if get_option('gnutls').enabled() or (get_option('gnutls').auto() and have_syste
                         required: get_option('gnutls'))
   endif
 
-  if gnutls.found() and not get_option('gnutls-bug1717-workaround').disabled()
+  #if gnutls.found() and not get_option('gnutls-bug1717-workaround').disabled()
     # XXX: when bug 1717 is resolved, add logic to probe for
     # the GNUTLS fixed version number to handle the 'auto' case
-    gnutls_bug1717_workaround = true
-  endif
+  #  gnutls_bug1717_workaround = true
+  #endif
 endif
 
 # We prefer use of gnutls for crypto, unless the options
diff --git a/meson_options.txt b/meson_options.txt
index dd33530750..fff1521e58 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -174,8 +174,6 @@ option('libcbor', type : 'feature', value : 'auto',
        description: 'libcbor support')
 option('gnutls', type : 'feature', value : 'auto',
        description: 'GNUTLS cryptography support')
-option('gnutls-bug1717-workaround', type: 'feature', value : 'auto',
-       description: 'GNUTLS workaround for https://gitlab.com/gnutls/gnutls/-/issues/1717')
 option('nettle', type : 'feature', value : 'auto',
        description: 'nettle cryptography support')
 option('gcrypt', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index d559e260ed..0ebe6bc52a 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -123,9 +123,6 @@ meson_options_help() {
   printf "%s\n" '  gio             use libgio for D-Bus support'
   printf "%s\n" '  glusterfs       Glusterfs block device driver'
   printf "%s\n" '  gnutls          GNUTLS cryptography support'
-  printf "%s\n" '  gnutls-bug1717-workaround'
-  printf "%s\n" '                  GNUTLS workaround for'
-  printf "%s\n" '                  https://gitlab.com/gnutls/gnutls/-/issues/1717'
   printf "%s\n" '  gtk             GTK+ user interface'
   printf "%s\n" '  gtk-clipboard   clipboard support for the gtk UI (EXPERIMENTAL, MAY HANG)'
   printf "%s\n" '  guest-agent     Build QEMU Guest Agent'
@@ -334,8 +331,6 @@ _meson_option_parse() {
     --disable-glusterfs) printf "%s" -Dglusterfs=disabled ;;
     --enable-gnutls) printf "%s" -Dgnutls=enabled ;;
     --disable-gnutls) printf "%s" -Dgnutls=disabled ;;
-    --enable-gnutls-bug1717-workaround) printf "%s" -Dgnutls-bug1717-workaround=enabled ;;
-    --disable-gnutls-bug1717-workaround) printf "%s" -Dgnutls-bug1717-workaround=disabled ;;
     --enable-gtk) printf "%s" -Dgtk=enabled ;;
     --disable-gtk) printf "%s" -Dgtk=disabled ;;
     --enable-gtk-clipboard) printf "%s" -Dgtk_clipboard=enabled ;;
-- 
2.35.3


