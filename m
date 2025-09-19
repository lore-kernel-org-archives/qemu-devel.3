Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC13CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 07:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzVxS-00023L-67; Fri, 19 Sep 2025 03:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <floss@arusekk.pl>) id 1uzVxK-00021q-GN
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 03:54:58 -0400
Received: from out-189.mta0.migadu.com ([91.218.175.189])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <floss@arusekk.pl>) id 1uzVxG-0002nR-H1
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 03:54:57 -0400
Message-ID: <cab5b519-fc2e-4560-9dca-64effbda428a@arusekk.pl>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arusekk.pl; s=key1;
 t=1758268490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVGGdrVB6waBbYJKax/jwwVZ6Y+CeFVcphMAwdCRqAU=;
 b=r52sw45WCsuMeo2nnpJQ1M1oypoYHf/CqgGCbbwFT/HD8WMGIawUustdnqezG1YM54pkAy
 mFoLM179G4K2aEhj7hTAiYu64lkBzIqor4ccZnhgNtVF8sidmWgNnPb2LPW8B4Qcq35e6q
 si6RjXPmPvX+kjxvv50wvS1twcdVYBwSOVSgEBoHIuHNPTeBehJQvtbfCX0gjMuuGnbaTG
 k8x58/dBcxYlmgSfriyE0TRT/T3a1WRAE71HfuMX/z5oKWrGrGfX+4IDf4yxiPwrnCPrp0
 q3vxPtvEMn7WuUnqUqMEm0V/ypbImUFWwIJJQYfxjFMku8Yf3hpwlRfoeksZng==
Date: Fri, 19 Sep 2025 09:54:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/4] linux-user: Add syscall dispatch support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: floss@arusekk.pl
References: <20250904102311.57383-1-richard.henderson@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Arusekk <floss@arusekk.pl>
In-Reply-To: <20250904102311.57383-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.189; envelope-from=floss@arusekk.pl;
 helo=out-189.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi!

W dniu 4.09.2025 o 12:23, Richard Henderson pisze:
> I have adjusted the signal return trampoline detection from
>
>    https://lore.kernel.org/qemu-devel/20250711225226.14652-1-floss@arusekk.pl/
>
> and tidied up a few other bits.
Thanks! I was also thinking about it, but I apparently sacrificed 
clarity for non-intrusiveness.
> Would you please re-test this
> versus your plan9 emulator?

Compiled and tested. My use case works great.

By the way, I wonder - why are the VDSO blobs included? Is it for 
reproducibility/stability?

Thanks,
Arusekk


