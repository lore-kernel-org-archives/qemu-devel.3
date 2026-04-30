Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D623DFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINDI-0006A8-E0; Thu, 30 Apr 2026 04:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wINDG-00069k-Nm; Thu, 30 Apr 2026 04:57:38 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wINDE-0001id-UY; Thu, 30 Apr 2026 04:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=IWwvq8hRTp+RgtNm5y9MAV6GLt7GzGdhEXG+fHLNIJs=; b=VG3YH0AyUqjqgEmrfN6dfbBcAT
 byHfmtpXsdGqFx6NM0Xmu4HCBy8sA/dM3xHqBnVEjpa1u/iKpiNirjG/W82tU0t3sBQ4Yk/eoi142
 THhaw17WdBnowkbzUHP9OJryDCAonZIFFPjtBi+D1nmbnViGx/BCjl1C4bxUNY7GasmJ29jtUEdeG
 GrvVGbJxYUYloqex2bu9EEx+B2GLUrskxoSP3RsJpAC2izYH/IzjzRZ4dsjnagNYEYWQCCIieJkEC
 EL1d0rCGw3243J2YsnOSOIHANg8C1OjNrd3k2QDN+jMX7DN9QGI2aB23usgY6e66aZfVC4fapW492
 GP7Lw6qNCmT9wOGNXWqrxUYKJ4qKBPHKiYp5GgoBXjOuahM/Nvk6Ip+pKpENFxPYYxAAkJRRiNsiw
 Q2BSJfmV55P9uxVx5nx/Q65f1ycOd153oBindFOR28F9ly4MqDTDF+Mpg/+zjPPJa4FkJCiT/JyxD
 m7mD/rXb9/XiDiO7LohZYohxJWjRwbC5Kd4t7xg909aWkD8OQgEUoqSjzUpBdPm+daIgLTLcjCD4q
 G0o7ekiDKnDeVQohQxuaGng4kgGgJid++9far5JdlyEjQQIAVaqHKUM5m9ZmpmMVZqpQQUB/EYkFj
 YyMq1vTFiVMvthL/qH01HO6DAfwk1sjWqDs/4Hfjg=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org,
 Jia Jia <physicalmtea@gmail.com>
Subject: Re: [PATCH] 9pfs: fix deep path truncation in V9fsPath
Date: Thu, 30 Apr 2026 10:57:32 +0200
Message-ID: <1954333.tdWV9SEqCh@weasel>
In-Reply-To: <20260428074614.3169999-1-physicalmtea@gmail.com>
References: <20260428074614.3169999-1-physicalmtea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tuesday, 28 April 2026 09:46:14 CEST Jia Jia wrote:
> V9fsPath.size tracks the length of backend path data. Storing it in a
> uint16_t truncates local backend paths longer than 65535 bytes, so later
> path copies can end up much smaller than the string data they are
> supposed to describe.
> 
> A guest can reach this with normal 9p filesystem operations by creating
> and walking a sufficiently deep directory tree on the local backend. On
> an ASan build, calling readdir() in that deep directory aborts the host
> process with:
> 
>   ERROR: AddressSanitizer: heap-buffer-overflow
>     #0 __interceptor_strrchr
>     #1 g_path_get_dirname
>     #2 local_lstat
>     #3 v9fs_co_lstat
>     #4 v9fs_getattr
> 
> Fix this by storing V9fsPath lengths in size_t.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3358
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---

Hi Jia, thanks for looking at this issue!

> Runtime reproducer:
>   confirmed on current master (11.0.50) with an x86_64 ASan build and a
>   local 9p backend
> 
>   guest actions:
>     - mount the 9p share
>     - create a 260-level directory tree with 255-byte names
>     - walk back to the deepest directory
>     - call readdir()
> 
>   host abort:
>     ERROR: AddressSanitizer: heap-buffer-overflow
>       #0 __interceptor_strrchr
>       #1 g_path_get_dirname
>       #2 local_lstat
>       #3 v9fs_co_lstat
>       #4 v9fs_getattr
> 
>  fsdev/file-op-9p.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index b85c9934def..e8d0661c4b5 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -112,7 +112,7 @@ struct FsContext {
>  };
> 
>  struct V9fsPath {
> -    uint16_t size;
> +    size_t size;
>      char *data;
>  };
>  P9ARRAY_DECLARE_TYPE(V9fsPath);

I fear it is not that simple. Just changing this data type would only move the 
problem and furthermore turn a small OOB into a giant OOB: g_vasprintf() 
(called by v9fs_path_sprintf()) has as return type gint -> int, and 
v9fs_path_sprintf() returns -1 on error, and this change would then implicitly 
cast -1 to a giant unsigned value.

AFAICS the only way for truly fixing this is by getting rid of dragging full 
paths around with FIDs in general, which would be a massive change though.

On short term I only see a possible mitigation: adding error handling to 
v9fs_path_sprintf(), and for FIDs where v9fs_fix_path() fails, making the fids 
inaccessible for good (i.e. immediately closing those FIDs).

/Christian



