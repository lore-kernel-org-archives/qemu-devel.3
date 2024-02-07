Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C48C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 17:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmBm-0003Oa-59; Wed, 07 Feb 2024 12:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBj-0003KY-Bg; Wed, 07 Feb 2024 12:58:23 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBh-0003z2-KW; Wed, 07 Feb 2024 12:58:23 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7DC294B3CF;
 Wed,  7 Feb 2024 20:59:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 908397639F;
 Wed,  7 Feb 2024 20:58:18 +0300 (MSK)
Received: (nullmailer pid 296914 invoked by uid 1000);
 Wed, 07 Feb 2024 17:58:18 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [RFC/INCOMPLETE PATCH 0/8] Attempt to make qemu-img options
 consistent and --help working
Date: Wed,  7 Feb 2024 20:58:09 +0300
Message-Id: <cover.1707328606.git.mjt@tls.msk.ru>
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

This is an incomplete first attempt only, there's a lot left to do.

All the options in qemu-img is a complete mess, - no, inconsistent or
incomplete syntax in documentation, many undocumented options, option
names are used inconsistently and differently for different commands,
no long options exists for many short options, --help output is a huge
mess by its own, and the way how it all is generated is another story.
docs/tools/qemu-img.rst with qemu-img-opts.hx is yet another.

I hoped to fix just an option or two, but it ended up in a large task,
and I need some help and discussion, hence the RFC.

The idea is:

 - create more or less consistent set of options between different
   subcommands
 - provide long options which can be used without figuring out which
   -T/-t, -f|-F|-O etc to use for which of the two images given
 - have qemu-img --help provide just a list of subcommands
 - have qemu-img COMMAND --help to describe just this subcommand
 - get rid of qemu-img-opts.hx, instead finish documentation in
   qemu-img.rst based on the actual options implemented in
   qemu-img.c.

I started converting subcommands one by one, providing long options
and --help output.  And immediately faced some questions which needs
wider discussion.

 o We have --image-opts and --target-image-opts.  Do we really need both?
   In my view, --image-opts should be sort of global, turning *all*
   filenames on this command line into complete image specifications,
   there's no need to have separate image-opts and --target-image-opts.
   Don't know what to do wrt compatibility though.  It shouldn't be made
   this way from the beginning.  As a possible solution, introduce a new
   option and deprecate current set.

 o For conversion (convert, dd, etc), we've source and destination,
   so it's easy to distinguish using long options, like --source-format
   --target-cache etc (-t/-T -f/-F is a mess here already).  What to
   do with compare? --format1 --format2 is ugly, maybe --a-format and
   --b-format?  Maybe we can get off with --source (a) and --target (b)
   instead of filename1 & filename2?
   (--cache in this context is global for both).

 o qemu-img convert.  It's the most messy one, and it is not really
   documented (nor in qemu-img.rst , eg there's nothing in there about
   FILENAME2, -B is difficult to understand, etc).
   At the very least, I'd say the options should be
    --source-format, --source-cache etc
    --target-format, --target-options
    --target-image-opts - this shold go IMHO

 o check and commit - inconsistent cache flags?
   In convert, cache is backwards (source/target)?

At first, I tried to have more or less common option descriptions,
using various parameters, variables or #defines, but in different
commands the same options has slightly different wording, and in
some option names are different, so it looks like it's best to
have complete text in each subcommand.


Michael Tokarev (8):
  qemu-img: pass current cmdname into command handlers
  qemu-img: refresh options/--help for "create" subcommand
  qemu-img: factor out parse_output_format() and use it in the code
   (this one has been sent in a separate patch, here it is just for completness)
  qemu-img: refresh options/--help for "check" command
  qemu-img: simplify --repair error message
  qemu-img: refresh options/--help for "commit" command
  qemu-img: refresh options/--help for "compare" command
  qemu-img: refresh options/--help for "convert" command

 qemu-img.c | 352 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 226 insertions(+), 126 deletions(-)

-- 
2.39.2


