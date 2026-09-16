Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D48C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6q0A-00012a-G1; Wed, 16 Sep 2026 09:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>) id 1x6q01-0000yy-8W
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:48:34 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>) id 1x6pzv-0007ap-Im
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:48:31 -0400
Message-ID: <410859ee-80a6-41f1-8b40-7e5014a6bd10@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1789566499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Igc59xd1XhWQfCEbYQ4Dgnsc7scU2x8RjSc3HldHxIw=;
 b=F7sX3hFNEKocYPUttXFbtMIXJKX8RORH22vuMPnNR1XzL7LrcWIt1WIs8nMbBDMwTcyMvs
 tBiCbYB22JGTrp1vD2ptD6ZxnLuXqM4hx5tXed9X6jX44uExP/o7PZzTAUUuYmFgQJAD5q
 +SSaXRAK/MCJMiisP1HBYUV6Gss1maI=
Date: Wed, 16 Sep 2026 16:48:19 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] util/error, hw/net/virtio-net: fix NULL pointer
 dereference in error_vprepend
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, mst@redhat.com
References: <500d4850-f7d7-45fb-91e5-74d32d35fde2@swemel.ru>
 <87h5jp8iqc.fsf@pond.sub.org>
Content-Language: en-US, ru-RU
From: =?UTF-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
In-Reply-To: <87h5jp8iqc.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=zorin@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hello!

This is not AI-generated content. We have a dedicated team of engineers 
who monitor and analyze security events (ranging from ASan/TSan 
sanitizers to PVS-Studio) and perform statistical analysis (from 
cppcheck to SVACE and white bear). This is a strict requirement from our 
Quality Assurance department, which is mandatory for compliance with our 
government and commercial contracts. Unfortunately, I cannot share our 
internal security tools (especially since they are tailored to our 
environment and won't work for you). However, I can share what our 
engineers flag as potentially dangerous cases during their research. 
Since the patches we submit address long-standing vulnerabilities, we 
have to maintain them on our side for years, as they rarely get fixed in 
your upstream. If you think these findings are outdated or redundant, 
fine. I'll try to convince our researchers to drop it—letting them know 
that the upstream developers consider this work completely unnecessary.

P.S. We are backporting these from Debian 10 (even though the current 
release is Debian 13).
P.P.S. I used AI for correcting translate (I not good knowled english)

nice day

16.09.2026 15:48, Markus Armbruster пишет:
> First, please read docs/devel/code-provenance.rst section "Use of
> AI-generated content".
>
> I'm not looking at the patches, only the commit message.
>
> Николай Зорин <zorin@swemel.ru> writes:
>
>> SWSA#b0709cee-9722-4603-a30c-dc857dc87961
>>
>> The `error_vprepend()` function modifies the error message inside an
>> existing Error object. However, it only validated if the `errp` pointer
>> itself was non-NULL, missing a check for whether the underlying Error
>> object `*errp` is `NULL`.
> This is nonsense.  error_vprepend() and error_prepend() modify an error.
> They must not be called when there is none.  The check isn't missing.
> Adding it makes the functions "work" papers over bugs.
>
>> Calling `error_reportf_err(local_error, ...)` when `local_error` is `NULL`
>> invokes `error_vprepend(&local_error, ...)`, which subsequently crashes
>> via a `NULL` pointer dereference during `(*errp)->msg` access.
>>
>> Fix `util/error.c` by adding a defensive `!*errp` check inside
>> `error_vprepend()`.
>>
>> Additionally, fix the invalid error reporting patterns in
>> `hw/net/virtio-net.c`:
>> - In `vhost_user_net_save_state()` and `vhost_user_net_load_state()`, when
>>     `vhdev == NULL`, calling `error_reportf_err()` with an unallocated/NULL
>>     `local_error` is incorrect and unsafe. Replace it with a straightforward
>>     `error_report()` call.
> Both uses of error_reportf_err() are indeed wrong.
>
>> - Fix a cosmetic double-space typo in "Error loading  back-end state".
> Worth cleaning up.
>
>> Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>


