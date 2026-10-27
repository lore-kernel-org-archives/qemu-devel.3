Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5100F606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=RKvezmBW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmZT-0005ar-W1; Tue, 27 Oct 2026 15:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLmZR-0005ZE-CX; Tue, 27 Oct 2026 15:10:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLmZO-0000jZ-5C; Tue, 27 Oct 2026 15:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793128235; bh=ijffY8gq3B5OWgogyI014QYvmZ+xmF1WROniH2pb71E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RKvezmBW4CxPwRp6Q9FsW0vVaQHkAzOYWsS6Rc78998kzRK1jFW37LeQdgM2I5iTf
 mpYlrTXBiCPgFQDVeMzW0EUFQei83OkCQHTZBrZJA0Vrk1p2QgHiTFKIlPn8KHJOwP
 u1l9tWJCLXgkefQFdYJpFBgT4Wi2GPsasNt2MWNj+zH8LYAV27tHXgLSyH3fqWf/zw
 5xyGnoA+kSHp8rUnNq6yeAd6ndUOFGKuRvDhNoowwoBmt93PunbcFhQYEiCI490uXU
 lj2KzV0kR7YqwaEu18lY5xNCFCUj/qoGb75KHDaQhhyGLaOIpa9w9JB442LO5ZC0sA
 MIXOLq2KZNDDg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 173F21E19FB;
 Tue, 27 Oct 2026 22:10:35 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 068A444C8DD;
 Tue, 27 Oct 2026 22:10:35 +0300 (MSK)
Message-ID: <4e55719d-647a-4163-87b1-950a89144d48@tls.msk.ru>
Date: Tue, 27 Oct 2026 22:10:34 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/dev-mtp: Fix assert crash on undersized BULK IN
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20261012140839.93559-1-tcalifano@redhat.com>
 <55d79d30-cd7b-4673-8fda-434fd701313e@oss.qualcomm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <55d79d30-cd7b-4673-8fda-434fd701313e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 21:18, Philippe Mathieu-Daudé wrote:
..
> Committed as b17205f23a9a8661394d30148b2c995ffa932019.

Curious, why did you send this email?

FWIW, https://lore.kernel.org/qemu-devel/20261026135441.1019505-22-mjt@tls.msk.ru/

Have you received this one and the similar one for 11.1.x?

Thanks,

/mjt

