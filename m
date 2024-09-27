Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F57BCEBF78
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 06:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4Cf-0004fZ-6w; Fri, 27 Sep 2024 02:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4CS-0004Ra-MJ; Fri, 27 Sep 2024 02:11:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4CP-0003ER-GT; Fri, 27 Sep 2024 02:11:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1DCE092D11;
 Fri, 27 Sep 2024 09:10:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7E183146703;
 Fri, 27 Sep 2024 09:11:21 +0300 (MSK)
Received: (nullmailer pid 573337 invoked by uid 1000);
 Fri, 27 Sep 2024 06:11:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH resend v3 00/27] qemu-img: refersh options and --help handling,
 cleanups
Date: Fri, 27 Sep 2024 09:10:54 +0300
Message-Id: <20240927061121.573271-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

This is a re-send of this patchset from Apr-24, after multiple pings.
I rebased it on top of current qemu/master, though nothing has really
changed - it is still the same changes.  We should either apply it or
drop it if it is not appropriate for some reason.  Complete silence
for half a year isn't really nice, I think :)
----

Quite big patchset trying to implement normal, readable qemu-img --help
(and qemu-img COMMAND --help) output with readable descriptions, and
adding many long options in the process.

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

There are many other inconsistencies, I can't fix them all in one go.

Changes since v2:

 - added Dan's R-Bs
 - refined couple cvtnum conversions
 - dropped "stop printing error twice in a few places"

Michael Tokarev (27):
  qemu-img: measure: convert img_size to signed, simplify handling
  qemu-img: create: convert img_size to signed, simplify handling
  qemu-img: global option processing and error printing
  qemu-img: pass current cmd info into command handlers
  qemu-img: create: refresh options/--help
  qemu-img: factor out parse_output_format() and use it in the code
  qemu-img: check: refresh options/--help
  qemu-img: simplify --repair error message
  qemu-img: commit: refresh options/--help
  qemu-img: compare: refresh options/--help
  qemu-img: convert: refresh options/--help
  qemu-img: info: refresh options/--help
  qemu-img: map: refresh options/--help
  qemu-img: snapshot: allow specifying -f fmt
  qemu-img: snapshot: make -l (list) the default, simplify option handling
  qemu-img: snapshot: refresh options/--help
  qemu-img: rebase: refresh options/--help
  qemu-img: resize: do not always eat last argument
  qemu-img: resize: refresh options/--help
  qemu-img: amend: refresh options/--help
  qemu-img: bench: refresh options/--help
  qemu-img: bitmap: refresh options/--help
  qemu-img: dd: refresh options/--help
  qemu-img: measure: refresh options/--help
  qemu-img: implement short --help, remove global help() function
  qemu-img: inline list of supported commands, remove qemu-img-cmds.h
    include
  qemu-img: extend cvtnum() and use it in more places

 docs/tools/qemu-img.rst    |    4 +-
 qemu-img-cmds.hx           |    4 +-
 qemu-img.c                 | 1311 ++++++++++++++++++++++--------------
 tests/qemu-iotests/049.out |    9 +-
 4 files changed, 821 insertions(+), 507 deletions(-)

-- 
2.39.5


