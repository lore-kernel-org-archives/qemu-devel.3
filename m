Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE3CC5AE59
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPoh-00016A-Aj; Sat, 31 May 2025 13:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPod-00015T-Rj; Sat, 31 May 2025 13:16:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPob-000116-RC; Sat, 31 May 2025 13:16:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B1794126B30;
 Sat, 31 May 2025 20:16:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 83B2B21BA33;
 Sat, 31 May 2025 20:16:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v4 00/27] refresh qemu-img options handling
Date: Sat, 31 May 2025 20:15:42 +0300
Message-Id: <20250531171609.197078-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

This is another iteration of this patch series, which tries
to add missing command-line options, --help output, make it
all more or less consistent, etc.

I addressed (hopefully) all comments so far, mostly by Kevin.
I ended up (so far) with a bit different wording somewhere.

The manpage (and the separate documentation) hasn't changed
much, but I intend to use the same wording there as in --help
output.   An example of the separate documentation change is
provided with "create" subcommand only, as a PoC.

I tried to rename a few existing options to make them more
consistent.  This is an RFC, so to say, - I'd love to make
more changes but it isn't really possible because the names
I want to use are already used for different purpose.  All
such changes (3 in total) are marked with "(short option change)"
suffix in the patch subject.  In particular, I tried to use
-b for backing-file, and -B for backing-format, in all places.
Maybe it's too late to change that though.

All subcommands now have --object option.  I wonder why we
haven't done it in common place, before a subcommand.  Maybe
it's a good idea (and I think it is) to add it to the common
(before-subcomman) place, document it there, and remove the
--object mentions from individual commands --help output.

Thanks,

/mjt

Michael Tokarev (27):
  qemu-img: measure: convert img_size to signed, simplify handling
  qemu-img: create: convert img_size to signed, simplify handling
  qemu-img: global option processing and error printing
  qemu-img: pass current cmd info into command handlers
  qemu-img: create: refresh options/--help (short option change)
  qemu-img: factor out parse_output_format() and use it in the code
  qemu-img: check: refresh options/--help
  qemu-img: simplify --repair error message
  qemu-img: commit: refresh options/--help
  qemu-img: compare: use helper function for --object
  qemu-img: compare: refresh options/--help
  qemu-img: convert: refresh options/--help (short option change)
  qemu-img: info: refresh options/--help
  qemu-img: map: refresh options/--help
  qemu-img: snapshot: allow specifying -f fmt
  qemu-img: snapshot: make -l (list) the default, simplify option handling
  qemu-img: snapshot: refresh options/--help
  qemu-img: rebase: refresh options/--help (short option change)
  qemu-img: resize: do not always eat last argument
  qemu-img: resize: refresh options/--help
  qemu-img: amend: refresh options/--help
  qemu-img: bench: refresh options/--help
  qemu-img: bitmap: refresh options/--help
  qemu-img: dd: refresh options/--help
  qemu-img: measure: refresh options/--help
  qemu-img: implement short --help, remove global help() function
  qemu-img: extend cvtnum() and use it in more places

 docs/tools/qemu-img.rst    |   18 +-
 qemu-img-cmds.hx           |    4 +-
 qemu-img.c                 | 1782 +++++++++++++++++++++---------------
 tests/qemu-iotests/049.out |    9 +-
 4 files changed, 1082 insertions(+), 731 deletions(-)

-- 
2.39.5


