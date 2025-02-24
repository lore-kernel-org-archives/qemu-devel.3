Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82006C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdtC-00013p-Uh; Mon, 24 Feb 2025 14:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmdsD-0000bw-Hr
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:12:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmdsB-0005vZ-IS
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740424326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TxYBL+4hRhBbfgtlH9JJpjWGYvnqfoEPb6Z9IpA7Lv8=;
 b=cwB7amPK+gmbjLDQqg083Mezw7mxdSiX6n+UWe0IdIYpEu4BdHFu/JTuuPzmdgXkJbN1rp
 hDkCRW71svtsKyFA5RHPHabyZAv3nMI229GIlAoj+E7RxDDOLCWsWCYWZ/TYhviW8/2KpT
 G/NU7vPYH3bTnCjd9xkeE80UKKB3n+M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-few2OpEgPCaWd4HZ0f7XTQ-1; Mon,
 24 Feb 2025 14:12:01 -0500
X-MC-Unique: few2OpEgPCaWd4HZ0f7XTQ-1
X-Mimecast-MFC-AGG-ID: few2OpEgPCaWd4HZ0f7XTQ_1740424320
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70F4018EB2CE; Mon, 24 Feb 2025 19:12:00 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.119])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B32D180087D; Mon, 24 Feb 2025 19:11:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [RFC 1/2] python: be more selective in hiding mypy subclassing warning
Date: Mon, 24 Feb 2025 19:11:51 +0000
Message-ID: <20250224191152.2123003-2-berrange@redhat.com>
In-Reply-To: <20250224191152.2123003-1-berrange@redhat.com>
References: <20250224191152.2123003-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Use an annotation inline to the file instead of in setup.cfg

This has the added advantage that the mypy checks now pass when
using 'mypy /path/to/python/qemu' as well as 'mypy -p qemu'.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/qmp/qmp_tui.py    | 12 ++++++------
 python/qemu/utils/qom_fuse.py |  2 +-
 python/setup.cfg              |  8 --------
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index 2d9ebbd20b..8720d70e60 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -401,7 +401,7 @@ def run(self, debug: bool = False) -> None:
             raise err
 
 
-class StatusBar(urwid.Text):
+class StatusBar(urwid.Text):  # type: ignore
     """
     A simple statusbar modelled using the Text widget. The status can be
     set using the set_text function. All text set is aligned to right.
@@ -412,7 +412,7 @@ def __init__(self, text: str = ''):
         super().__init__(text, align='right')
 
 
-class Editor(urwid_readline.ReadlineEdit):
+class Editor(urwid_readline.ReadlineEdit):  # type: ignore
     """
     A simple editor modelled using the urwid_readline.ReadlineEdit widget.
     Mimcs GNU readline shortcuts and provides history support.
@@ -485,7 +485,7 @@ def keypress(self, size: Tuple[int, int], key: str) -> Optional[str]:
         return None
 
 
-class EditorWidget(urwid.Filler):
+class EditorWidget(urwid.Filler):  # type: ignore
     """
     Wrapper around the editor widget.
 
@@ -498,7 +498,7 @@ def __init__(self, parent: App) -> None:
         super().__init__(Editor(parent), valign='top')
 
 
-class HistoryBox(urwid.ListBox):
+class HistoryBox(urwid.ListBox):  # type: ignore
     """
     This widget is modelled using the ListBox widget, contains the list of
     all messages both QMP messages and log messages to be shown in the TUI.
@@ -535,7 +535,7 @@ def mouse_event(self, size: Tuple[int, int], _event: str, button: float,
             super().keypress(size, 'down')
 
 
-class HistoryWindow(urwid.Frame):
+class HistoryWindow(urwid.Frame):  # type: ignore
     """
     This window composes the HistoryBox and EditorWidget in a horizontal split.
     By default the first focus is given to the history box.
@@ -572,7 +572,7 @@ def cb_add_to_history(self, msg: str, level: Optional[str] = None) -> None:
         self.history.add_to_history(formatted)
 
 
-class Window(urwid.Frame):
+class Window(urwid.Frame):  # type: ignore
     """
     This window is the top most widget of the TUI and will contain other
     windows. Each child of this widget is responsible for displaying a specific
diff --git a/python/qemu/utils/qom_fuse.py b/python/qemu/utils/qom_fuse.py
index cf7e344bd5..0a1e02af87 100644
--- a/python/qemu/utils/qom_fuse.py
+++ b/python/qemu/utils/qom_fuse.py
@@ -56,7 +56,7 @@
 fuse.fuse_python_api = (0, 2)
 
 
-class QOMFuse(QOMCommand, Operations):
+class QOMFuse(QOMCommand, Operations):  # type: ignore
     """
     QOMFuse implements both fuse.Operations and QOMCommand.
 
diff --git a/python/setup.cfg b/python/setup.cfg
index cf5af7e664..8dcd4c946e 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -83,14 +83,6 @@ warn_unused_configs = True
 namespace_packages = True
 warn_unused_ignores = False
 
-[mypy-qemu.utils.qom_fuse]
-# fusepy has no type stubs:
-allow_subclassing_any = True
-
-[mypy-qemu.qmp.qmp_tui]
-# urwid and urwid_readline have no type stubs:
-allow_subclassing_any = True
-
 # The following missing import directives are because these libraries do not
 # provide type stubs. Allow them on an as-needed basis for mypy.
 [mypy-fuse]
-- 
2.47.1


