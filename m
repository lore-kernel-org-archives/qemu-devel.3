Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C219FCD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR8Y2-00033K-LC; Sun, 24 May 2026 09:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wR8Y0-000332-SA
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:07:16 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wR8Xy-0001T8-W4
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779628032; x=1780232832; i=deller@gmx.de;
 bh=fRNKrpTYYn2JBdqundBkJwQwxPqZtyltMQEizAxkaCE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tqcigFdJrbwIu2NvhCNk87UKt9837I6mBNQL/AM2S96JnCr3qS8OJFJSob31wa/q
 cjjV/69X1pecj3p5ZhIn6k4BXwoahVQKiBy4g2S4XonUCTRFnb6bPTZW1BuTVrq7V
 TE60D34uH1fdFeJ1EOyJHO5Epq15bSoqDicDoU+2zrL3+stSVB3VpCTyXFeFeqEzj
 BcmONvXbwMubKDGZ2v7ng/pHSEkkVky/4B1LPTMKO2Oo9Il2QV3Odktiq7zie/BQx
 CzjiQgVTQWp1N6MPsH1VywCcpCd/zdtWwSqfQ/+7waIFIhFVpnVPRFpKkG4qfLPjX
 O5APT1jMsPxAzQoppQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sDq-1wMAjq1SB0-00EhDB; Sun, 24
 May 2026 15:07:12 +0200
Message-ID: <3eb6435e-3300-48fe-84d4-832039eaee98@gmx.de>
Date: Sun, 24 May 2026 15:07:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/hppa: add coredump support
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260521055707.1380061-1-mattst88@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260521055707.1380061-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oGBunf2HMLnsSXqmNVExGeHzpUzGt/6VjYj0CYrQYMii5WAbDxs
 MhL4Pg9i6Xl2L+1+B3YSLmiKeUGtaCj3FYZ1CF6BfV6y7NSoBa/dsZVBuWtBxcz7kaqjey3
 OJkLWbYuF3NFORkocgxeegzpInSCJTtQcWRXgRcyYfSvBUb59VGZB+Nc7YMf5NSTYrDBWkb
 dTWZB0XuR56DftwicB/8Q==
UI-OutboundReport: notjunk:1;M01:P0:4SjUKN+tEUA=;sIHRTO1EzpFig9GgwHu+YfpySoH
 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
 z3X3AQhMfYzmq3YFV9iEq20Bru4=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/21/26 07:56, Matt Turner wrote:
> Add HAVE_ELF_CORE_DUMP, target_elf_gregset_t (80 entries matching
> arch/parisc/include/uapi/asm/ptrace.h), and elf_core_copy_regs().
>=20
> The struct layout matches the kernel's struct user_regs_struct:
>    gr[0..31]    at indices [0..31]   (PSW in gr[0])
>    sr[0..7]     at indices [32..39]
>    iaoq[0..1]   at indices [40..41]  (instruction address queue)
>    iasq[0..1]   at indices [42..43]
>    sar          at index   [44]      (shift amount / CR11)
>    iir          at index   [45]      (interrupt instruction register)
>    isr          at index   [46]      (interrupt space register)
>    ior          at index   [47]      (interrupt offset register)
>    ipsw         at index   [48]      (interrupt PSW / CR22)
>    cr0          at index   [49]      (recovery counter)
>    cr24_31[8]   at indices [50..57]
>    cr8_15[6]    at indices [58..63]
>    pad[16]      at indices [64..79]
>=20
> elf_core_copy_regs() saves GRs, IAOQ (front/back), and SAR.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Reviewed-by: Helge Deller <deller@gmx.de>

Added to linux-user-next git tree.

Thanks!
Helge

