Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2684C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYKk-0006be-FR; Fri, 09 Feb 2024 16:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYKi-0006aY-IR; Fri, 09 Feb 2024 16:22:52 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYKg-00005q-QM; Fri, 09 Feb 2024 16:22:52 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 554264BF58;
 Sat, 10 Feb 2024 00:24:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 38E9877ED2;
 Sat, 10 Feb 2024 00:22:47 +0300 (MSK)
Received: (nullmailer pid 1123138 invoked by uid 1000);
 Fri, 09 Feb 2024 21:22:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 00/23] qemu-img: refersh options and --help handling
Date: Sat, 10 Feb 2024 00:22:21 +0300
Message-Id: <cover.1707513011.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Quite big patchset implementing normal, readable qemu-img --help
(and qemu-img COMMAND --help) output with readable descriptions,
and adding many long options in the process.

In the end I stopped using qemu-img-opts.hx in qemu-img.c, perhaps
this can be avoided, with only list of commands and their desrciptions
kept there, but I don't see big advantage here.  The same list should
be included in docs/tools/qemu-img.rst, - this is not done now.

Also each command syntax isn't reflected in the doc for now, because
I want to give good names for options first, - and there, we've quite
some inconsistences and questions.  For example, measure --output=OFMT
-O OFMT, - this is priceless :)  I've no idea why we have this ugly
--output=json thing, why not have --json? ;)  I gave the desired
format long name --target-format to avoid clash with --output.

For rebase, src vs tgt probably should be renamed in local variables
too, and I'm not even sure I've got the caches right. For caches,
the thing is inconsistent across commands.

For compare, I used --a-format/--b-format (for -f/-F), - this can
be made --souce-format and --target-format, to compare source (file1)
with target (file2).

For bitmap, things are scary, I'm not sure what -b SRC_FILENAME
really means, - for now I gave it --source option, but this does
not make it more clear, suggestions welcome.

There are many other inconsistencies, I can't fix them all in one
go.. :)

Michael Tokarev (23):
  qemu-img: pass current cmd info into command handlers
  qemu-img: refresh options/--help for "create" subcommand
  qemu-img: factor out parse_output_format() and use it in the code
  qemu-img: refresh options/--help for "check" command
  qemu-img: simplify --repair error message
  qemu-img: refresh options/--help for "commit" command
  qemu-img: refresh options/--help for "compare" command
  qemu-img: refresh options/--help for "convert" command
  qemu-img: refresh options/--help for "info" command
  qemu-img: refresh options/--help for "map" command
  qemu-img: allow specifying -f fmt for snapshot subcommand
  qemu-img: make -l (list) the default for "snapshot" subcommand
  qemu-img: refresh options/--help for "snapshot" command
  qemu-img: refresh options/--help for "rebase" command
  qemu-img: resize: do not always eat last argument
  qemu-img: refresh options/--help for "resize" command
  qemu-img: refresh options/--help for "amend" command
  qemu-img: refresh options/--help for "bench" command
  qemu-img: refresh options/--help for "bitmap" command
  qemu-img: refresh options/--help for "dd" command
  qemu-img: refresh options/--help for "measure" command
  qemu-img: implement short --help, remove global help() function
  qemu-img: inline list of supported commands, remove qemu-img-cmds.h
    include

 docs/tools/qemu-img.rst |   2 +-
 qemu-img-cmds.hx        |   4 +-
 qemu-img.c              | 843 ++++++++++++++++++++++++++--------------
 3 files changed, 558 insertions(+), 291 deletions(-)

-- 
2.39.2


