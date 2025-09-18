Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49272CAC5A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 12:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzDfq-0001gS-K0; Thu, 18 Sep 2025 08:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uzDfo-0001gE-Ov
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:23:40 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uzDfm-0008VI-Q9
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:23:40 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58ICNWDX016968
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 18 Sep 2025 21:23:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=xhTk4ESANYO5aNW03Dh6h/drChMdJGEKEjsL/tUNqac=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1758198212; v=1;
 b=EnslrRrzSy2Q3aJhYr/Uo5glO0JJ27fU/vHCZ4C2MBXlS6U+n1JNFWfJOhrEZd39
 Gke5tpcMqRtfMuczIrjwVzdXBRFKdh5ftER8q7PDjGtsDuQmf6aEqJ9/0FczMPKr
 l9FWqL8LU8T/4vNeLqPiGpXwL0ZJ29y+aCZHdqst3urVfgGXCZZQAiUv6qziuhLt
 ZPuXFg/z3A53tgJH7hd2Fn3VyHZj2fSyCKIdYiiNfAbZBLKluoGmqHqLPjXvMffI
 Sz8tEIRW1NJ3PtDE8kYF5tnZd8jNWlkoiGzZBMgL6uCbXEiH3TgwftiZaJIzeVoq
 x3EQ5tj4CH7rgxxWeajchw==
Message-ID: <9bc5b8b1-e68a-4e39-8cbf-4205707f8317@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 18 Sep 2025 21:23:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] tcg: Fix error reporting on mprotect() failure
 in tcg_region_init()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, berrange@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250917115207.1730186-1-armbru@redhat.com>
 <20250917115207.1730186-3-armbru@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250917115207.1730186-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/09/17 20:51, Markus Armbruster wrote:
> tcg_region_init() calls one of qemu_mprotect_rwx(),
> qemu_mprotect_rw(), and mprotect(), then reports failure with
> error_setg_errno(&error_fatal, errno, ...).
> 
> The use of &error_fatal is undesirable.  qapi/error.h advises:
> 
>   * Please don't error_setg(&error_fatal, ...), use error_report() and
>   * exit(), because that's more obvious.
> 
> The use of errno is wrong.  qemu_mprotect_rwx() and qemu_mprotect_rw()
> wrap around qemu_mprotect__osdep().  qemu_mprotect__osdep() calls
> mprotect() on POSIX, VirtualProtect() on Windows, and reports failure
> with error_report().  VirtualProtect() doesn't set errno.  mprotect()
> does, but error_report() may clobber it.
> 
> Fix tcg_region_init() to report errors only when it calls mprotect(),
> and rely on qemu_mprotect_rwx()'s and qemu_mprotect_rw()'s error
> reporting otherwise.  Use error_report(), not error_setg().
> 
> Fixes: 22c6a9938f75 (tcg: Merge buffer protection and guard page protection)
> Fixes: 6bc144237a85 (tcg: Use Error with alloc_code_gen_buffer)
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tcg/region.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/region.c b/tcg/region.c
> index 7ea0b37a84..74e3b4b774 100644
> --- a/tcg/region.c
> +++ b/tcg/region.c
> @@ -832,13 +832,17 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads)
>               } else {
>   #ifdef CONFIG_POSIX
>                   rc = mprotect(start, end - start, need_prot);
> +                if (rc) {
> +                    error_report("mprotect of jit buffer: %s",
> +                                 strerror(errno));
> +                }
> +

Nitpick: this blank line at the end of #ifdef looks strange to me.

>   #else
>                   g_assert_not_reached();
>   #endif
>               }
>               if (rc) {
> -                error_setg_errno(&error_fatal, errno,
> -                                 "mprotect of jit buffer");
> +                exit(1);
>               }
>           }
>           if (have_prot != 0) {


