Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB7AE7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 11:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTfuT-00016r-2u; Fri, 03 Jan 2025 06:32:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tTfuQ-00016E-Dk
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 06:32:06 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tTfuO-0004KP-Hz
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 06:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=FgygfjpFVrtLCX3r+bHF7l8KIJq0zui++aq0cRv0YnY=; b=TM0iAu/kwI7g5W+TKmkL+9STMz
 WMnp1jyk3SzkaP0V9wNVhLSOkHnM01j0uN2EpmDKpXZIcqi+hYKYH+cOaVj0l5UoAPDIoUbgQsxAE
 2A0ndSikIVGcURatAgee+2Gvfdh4duSM3lyrdfp4d3/HyjS/+AFh45PnQGNd7ve8feCfPF7eufOI9
 JsLxAt+jp52n+syeEheaeCc2Zgc9Lgx7OCEjjHu4t9z0KzuoNi6CDaxoTK8zzqTSsFOzl8EbIKLwf
 cIQb3YdOpGEcpTeHrFuQkdVU+lbqnFJITqCGyiG392em2ADcIXDcj1CoUjcpOUL8LsnRuuwODUDW2
 NxDOzrLTxxgllITdjCeAaKsFlGMvJdJHm7dU+DP0G1bz/yD9THYGc4i15qhSNR+ls5393QQKYzUO8
 TraUvDx/0fEhgb5x+6QIy1NXR1jWK/h9VSpleJxjE2PBp2BL5w83qZdei6iR/Cn+u2jxgI7ulMZ9Q
 uo1Bu/p3+Q/f9KasaXKJprm4rwlTYDfXbnpHl9fNZVmw7swJpK88CZRCT/KG3QWmzi8wXtOhMVRQZ
 58dmbslNveAzbj5FpfxufHU+61w9gmtF9KV3zk91aL6JsApYmnGZXJmXZN30nr1Jhrb25k9sV9O/H
 ++6m8svFmZ60/4UxpNwK04pPUVyOFf/YyqkwJswE8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: improve v9fs_open() tracing
Date: Fri, 03 Jan 2025 12:31:59 +0100
Message-ID: <14000677.NzGkIOIz7l@silver>
In-Reply-To: <45674069.kNWJ3c3XjC@silver>
References: <E1tN8RJ-008jNq-5L@kylie.crudebyte.com>
 <45674069.kNWJ3c3XjC@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Monday, December 30, 2024 10:50:59 AM CET Christian Schoenebeck wrote:
> On Monday, December 16, 2024 11:30:09 AM CET Christian Schoenebeck wrote:
> > Improve tracing of 9p 'Topen' request type by showing open() flags as
> > human-readable text.
> > 
> > E.g. trace output:
> > 
> >   v9fs_open tag 0 id 12 fid 2 mode 100352
> > 
> > would become:
> > 
> >   v9fs_open tag=0 id=12 fid=2 mode=100352(RDONLY|NONBLOCK|DIRECTORY|
> >   TMPFILE|NDELAY)
> > 
> > Therefor add a new utility function qemu_open_flags_tostr() that converts
> > numeric open() flags from host's native O_* flag constants to a string
> > presentation.
> > 
> > 9p2000.L and 9p2000.u protocol variants use different numeric 'mode'
> > constants for 'Topen' requests. Instead of writing string conversion code
> > for both protocol variants, use the already existing conversion functions
> > that convert the mode flags from respective protocol constants to host's
> > native open() numeric flag constants and pass that result to the new
> > string conversion function qemu_open_flags_tostr().
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  hw/9pfs/9p-util-generic.c | 44 +++++++++++++++++++++++++++++++++++++++
> >  hw/9pfs/9p-util.h         |  6 ++++++
> >  hw/9pfs/9p.c              |  9 +++++++-
> >  hw/9pfs/meson.build       |  1 +
> >  hw/9pfs/trace-events      |  2 +-
> >  5 files changed, 60 insertions(+), 2 deletions(-)
> >  create mode 100644 hw/9pfs/9p-util-generic.c
> 
> Queued on 9p.next:
> https://github.com/cschoenebeck/qemu/commits/9p.next
> 
> Thanks!
> 
> /Christian

I just realized that evaluation of O_SYNC and O_TMPFILE was wrong, as they
might contain several bits.

And O_NDELAY should be filtered if it is exactly the same as O_NONBLOCK.

This should fix these issues:

diff --git a/hw/9pfs/9p-util-generic.c b/hw/9pfs/9p-util-generic.c
index dff9a42d97..4c1e9c887d 100644
--- a/hw/9pfs/9p-util-generic.c
+++ b/hw/9pfs/9p-util-generic.c
@@ -28,15 +28,21 @@ char *qemu_open_flags_tostr(int flags)
         #ifdef O_CLOEXEC
         (flags & O_CLOEXEC) ? "|CLOEXEC" : "",
         #endif
-        (flags & O_SYNC) ? "|SYNC" : "",
+        #ifdef __O_SYNC
+        (flags & __O_SYNC) ? "|SYNC" : "",
+        #else
+        ((flags & O_SYNC) == O_SYNC) ? "|SYNC" : "",
+        #endif
         #ifdef O_PATH
         (flags & O_PATH) ? "|PATH" : "",
         #endif
-        #ifdef O_TMPFILE
-        (flags & O_TMPFILE) ? "|TMPFILE" : "",
+        #ifdef __O_TMPFILE
+        (flags & __O_TMPFILE) ? "|TMPFILE" : "",
+        #elif defined(O_TMPFILE)
+        ((flags & O_TMPFILE) == O_TMPFILE) ? "|TMPFILE" : "",
         #endif
         /* O_NDELAY is usually just an alias of O_NONBLOCK */
-        #ifdef O_NDELAY
+        #if defined(O_NDELAY) && O_NDELAY != O_NONBLOCK
         (flags & O_NDELAY) ? "|NDELAY" : "",
         #endif
         NULL /* always last (required NULL termination) */

I post a V2 of this patch now.

Best regards,
Christian Schoenebeck



