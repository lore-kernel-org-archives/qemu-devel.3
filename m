Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B4ACD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfig-0003xg-3L; Wed, 03 Jun 2026 03:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfic-0003Sm-0r
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:50 -0400
Received: from msg-2.mailo.com ([213.182.54.12] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfia-0000JI-B8
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780467909; bh=GRYMYGzGLB2Ip9vA8SoMln+tp1NtsuOPY7MvnxUXcQ8=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=Bx5lKwYwAf1N34dre6NbRV/Vhwmf7FBvREd/d3tSOgOh2OHkpAvOvYwY3s1IzkfjD
 7g7SY25R4YERtMvbtqgxdumE0n/8eB+45TgsJTQyq0UOZFTmaEKr+xe371zyZAj46N
 HCq1Qag1JJwLqRBkwPCA70Yo4dWS3g5PKYot4YA0=
Received: by be1-4.in.mailobj.net [192.168.91.14] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 08:24:24 +0200 (CEST)
X-EA-Auth: 168vOUyfsMiaC+TBxUMKGX4bvdqk76emKAHlxVnSsnHDKpT7/N31VG411+zxfxl6yl5sXev6Syfc22pUd0mNaMuslo3AWE8H
Message-ID: <f5e72a9f-ad15-42a5-a816-19b1adbd0812@mailo.com>
Date: Wed, 3 Jun 2026 08:24:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] memory.c: read memory_region_access_valid() err
 reason in memory_region_dispatch_*
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20260602190857.1506939-1-daniel.barboza@oss.qualcomm.com>
 <20260602190857.1506939-3-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260602190857.1506939-3-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=213.182.54.12; envelope-from=philmd@mailo.com;
 helo=mailo.com
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

On 2/6/26 21:08, Daniel Henrique Barboza wrote:
> memory_region_dispatch_read|write, when dealing with an invalid memory
> region, default to MEMTX_DECODE_ERROR error code.  This happens because
> memory_region_access_valid() until recently would just report true/false
> and nothing else.
> 
> We now have access to the internal reason why memory_region_access_valid()
> would fail.  In particular, we can now receive a MEMTX_ACCESS_ERROR when
> the mr->ops->valid.accepts() callback fails.
> 
> Make both functions return the actual error reason in case
> memory_region_access_valid fails, allowing more precise error handling
> throughout the code.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   system/memory.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 48348edb96..7d38b9774e 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1492,9 +1492,9 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
>                                              mr->alias_offset + addr,
>                                              pval, op, attrs);
>       }
> -    if (!memory_region_access_valid(mr, addr, size, false, attrs, NULL)) {
> +    if (!memory_region_access_valid(mr, addr, size, false, attrs, &r)) {

Now I see you propagate MemTxResult (my comment from previous patch).

Maybe clearer is 1st patch add the MemTxResult argument keeping current
behavior and 2nd patch update to your current patch #1 change?

>           *pval = unassigned_mem_read(mr, addr, size);
> -        return MEMTX_DECODE_ERROR;
> +        return r;
>       }


