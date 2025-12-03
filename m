Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B487D12D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 14:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQnz4-00064I-69; Wed, 03 Dec 2025 09:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@bonslack.org>) id 1vQnyz-000642-QR
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 09:37:29 -0500
Received: from bonnix2.bonnix.it ([37.247.49.194])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu@bonslack.org>) id 1vQnyx-0003pg-MT
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 09:37:29 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 bonnix2.bonnix.it 3E5BC278B3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonslack.org;
 s=20220805; t=1764772641;
 bh=3Ul68GK16LS63bufEmjxkX7SyPJGO/DL4Lk+54/CZ1s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cxOE+KjD5ZiGedq/sFHkixZ8rEgyNum5XbKi0a1xDPAfoGqlPvTD/XfAwjI6mc8ZL
 DGEGQpiviwnUrzR1VJeCHcrO3VkNC07edWYn3huyh2UpXkfVnH6FXJnqsuv4Pi7cuW
 8t0JB3LTfBTqLZbdyNF3369Q8/7R/jjbDn7Ppdco=
Received: from [10.0.0.70] (dynamic-adsl-84-220-72-247.clienti.tiscali.it
 [84.220.72.247])
 by bonnix2.bonnix.it (Postfix) with ESMTPSA id 3E5BC278B3F;
 Wed,  3 Dec 2025 15:37:21 +0100 (CET)
Message-ID: <345301f3-c75d-40e8-92c8-0c5525da250f@bonslack.org>
Date: Wed, 3 Dec 2025 15:37:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] Add termios2 support to linux-user
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <745f18b6-ee62-4903-9a56-dcb903b610cf@bonslack.org>
 <aTAp6fZ7f8hYupbh@redhat.com>
Content-Language: it, en-GB
From: Luca Bonissi <qemu@bonslack.org>
In-Reply-To: <aTAp6fZ7f8hYupbh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.247.49.194; envelope-from=qemu@bonslack.org;
 helo=bonnix2.bonnix.it
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 03/12/25 13:15, Daniel P. Berrangé wrote:
> You've added this for a handful of archiecture targets, but
> in Fedora we're seeing the incompatibility affect s390x and
> aarch64 too, which this series hasn't implemented.

The patch is for all targets, but some specific targets use a custom 
termbits.h include file and require the addition of the structures 
and/or TCGETS2/TCSETS2 defines that was missing.

Specifically, s390x and aarch64 use the generic/termbits.h include that 
was already ok.

> BTW, ideally send a cover letter with a multi-patch
> series; there are tools which make this easier than
> using git send-email directly:
> 
>    https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting-your-patches

Thank! I will use git send-email the next time.

Luca

