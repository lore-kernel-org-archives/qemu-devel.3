Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC8BCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 01:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1EKE-0003dy-0F; Tue, 23 Sep 2025 21:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v1EKB-0003df-G7
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 21:29:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v1EK6-0006oV-Qw
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 21:29:38 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58O1TKbN005265
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 10:29:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=GeCXbzOAB7Ri8I5WI56flm3hPXB98NZ58kyzN9iMias=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1758677361; v=1;
 b=ipMzuw2VEJJWX6kEzp7ddIYzokWDC1ffz7Sx1rEZzaUnf+HbUSQ+NTu60/h9HTvT
 6cFqH1s2jH5nfqnmTbgx8Hiqz6lxDpqbzV9WLc+LgKVGgsFfHmWLLAMEGeHBT5Xl
 6zS8p/CdL0lw9QV7EgdDadeve5kImqFCNqQzooWnh84f6eEm5NoTgufZUIuB+bvx
 2PSDknrpW4v/uNp60at+f8gymol1SfFopm6+sh1s0EdpgyCj+fcg7AuMiiBdycQ7
 Bs7Hv+NAWuO6SxMPmEJ+P6s8s/j1IwjPFT/ikOEHLYOH2J/lQxz+OIUGIE0+w4l5
 YLDcF313OtjNpBYilkwKFQ==
Message-ID: <d1d48391-2b34-4e7c-b732-ee2f528115d6@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 24 Sep 2025 10:29:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] Error reporting cleanup, a fix, and &error_warn
 removal
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, vsementsov@yandex-team.ru
References: <20250923091000.3180122-1-armbru@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250923091000.3180122-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/09/23 18:09, Markus Armbruster wrote:
>>From qapi/error.h:
> 
>   * Please don't error_setg(&error_fatal, ...), use error_report() and
>   * exit(), because that's more obvious.
>   * Likewise, don't error_setg(&error_abort, ...), use assert().
> 
> Not mentioned, but just as undesirable: error_setg(&error_warn, ...).
> 
> This series eliminates such uses, and gets rid of &error_warn.
> &error_warn has multiple issues and little use.  PATCH 12 has full
> rationale.
> 
> A note on warnings: we don't use warnings much, and when we use them,
> they're often pretty bad.  See my memo "Abuse of warnings for
> unhandled errors and programming errors"
> Message-ID: <87h5yijh3b.fsf@pond.sub.org>
> https://lore.kernel.org/qemu-devel/87h5yijh3b.fsf@pond.sub.org/
> 
> v3:
> * PATCH 02: Whitespace cleanup [Akihiko Odaki]
> * PATCH 06+07: Memory leaks on error paths [Akihiko Odaki]
> * PATCH 08+13: Rebase conflicts
> * PATCH 12: New
> 
> v2:
> * PATCH 03: Mention change of cxl_fmws_link() return value in commit
>    message [Jonathan]
> * PATCH 04: Change exit(1) to g_assert_not_reached(), because it's a
>    programming error.
> * PATCH 06+07: Replace questions in commit message by answers from
>    review.
> * PATCH 06: Fix a format string
> * PATCH 08: Keep warnings instead of reverting to silence [Daniel]
> * PATCH 12: Adjusted for replaced PATCH 08
> 
> Issues raised in review I decided not to address in this series:
> * PATCH 03: messages could be improved further, in particular the
>    "gdbstub: " prefix could be dropped
> * ebpf_rss_load() can return false without setting an error
> * Capture the discussion on how to deal with undhandled errors in
>    cover letter and/or commit messages.
> 
> The first two could be done on top.
> 
> Markus Armbruster (13):
>    monitor: Clean up HMP gdbserver error reporting
>    tcg: Fix error reporting on mprotect() failure in  tcg_region_init()
>    hw/cxl: Convert cxl_fmws_link() to Error
>    migration/cpr: Clean up error reporting in cpr_resave_fd()
>    hw/remote/vfio-user: Clean up error reporting
>    net/slirp: Clean up error reporting
>    ui/spice-core: Clean up error reporting
>    util/oslib-win32: Do not treat null @errp as &error_warn
>    ui/pixman: Consistent error handling in qemu_pixman_shareable_free()
>    ui/dbus: Clean up dbus_update_gl_cb() error checking
>    ui/dbus: Consistent handling of texture mutex failure
>    ivshmem-flat: Mark an instance of missing error handling FIXME
>    error: Kill @error_warn
> 
>   include/exec/gdbstub.h         |  3 ---
>   include/qapi/error.h           |  6 ------
>   include/system/os-win32.h      |  5 ++++-
>   hw/cxl/cxl-host.c              |  7 ++++---
>   hw/display/virtio-gpu.c        |  8 ++++++--
>   hw/misc/ivshmem-flat.c         |  8 ++++++--
>   hw/net/virtio-net.c            |  8 +++++++-
>   hw/remote/vfio-user-obj.c      |  9 +++------
>   io/channel-socket.c            |  4 ++--
>   io/channel-watch.c             |  6 +++---
>   migration/cpr.c                |  9 +++++----
>   monitor/hmp-cmds.c             |  7 ++++---
>   net/slirp.c                    |  9 +++++++--
>   tcg/region.c                   |  7 +++++--
>   tests/unit/test-error-report.c | 17 -----------------
>   ui/dbus-listener.c             | 22 +++++++++++++++-------
>   ui/gtk.c                       |  6 +++++-
>   ui/qemu-pixman.c               |  5 ++++-
>   ui/spice-core.c                |  6 ++++--
>   util/aio-win32.c               |  2 +-
>   util/error.c                   |  5 +----
>   util/oslib-win32.c             | 25 ++++++++++++++++++++-----
>   22 files changed, 106 insertions(+), 78 deletions(-)
> 

For the whole series:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

