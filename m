Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A7606A331
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=P1Ea3s3x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xThjV-0005wn-Ss; Wed, 18 Nov 2026 10:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xThij-0005ol-VU; Wed, 18 Nov 2026 10:37:14 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xThih-0004Cf-Oz; Wed, 18 Nov 2026 10:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795016227; bh=4LjI7iBeEgibPvNdW+p/GP2fo1Kyu9/TiwEeTrqbOeo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=P1Ea3s3x5kxjzexCk3z5/Kzt0T2jtFFRDmaGd2DarmqVsRld3iOnI+OAZcoP9UpAp
 IKydb2jgn4P4l19ZhwIUlqgdfX7V7uopQ8e3jU9oVypoQvUJ7N3jvJj3p2iYzz1N8z
 UUuPEZ5O73ClXurGXzYprB/6zbojxGaKPU0p+2c7POvtjWNsRCei/3gyNWec2yOdOF
 Z+66EyjJOAMGLXqbHdNhYkfw4x7c+6wwLsnXHMPhcNNYpGr8dsiwADZAgUbHr/7D5k
 blPY60B9Ck12q+2aB8PXUVL2mCslaBI28iELonv1YL3sKGra35mR1oZ4NO7YNpHg/2
 tQaJ0/Qc+28tw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 65BB41E7B5B;
 Wed, 18 Nov 2026 18:37:07 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4AA3D461158;
 Wed, 18 Nov 2026 18:37:07 +0300 (MSK)
Message-ID: <0e42092c-da03-4a53-9785-d50a8c66fd07@tls.msk.ru>
Date: Wed, 18 Nov 2026 18:37:07 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] tcg/riscv64: Fix vector immediate handling
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
 <d16001a6-d66c-4af5-8e61-35484b24c37c@tls.msk.ru>
 <5f508944-1398-4163-9c72-ba7970640c6b@tls.msk.ru>
 <74083d44-2bf2-4972-ad84-52c9b93f099e@oss.qualcomm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <74083d44-2bf2-4972-ad84-52c9b93f099e@oss.qualcomm.com>
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 18:32, Philippe Mathieu-Daudé wrote:
> On 18/11/26 15:34, Michael Tokarev wrote:

>> Aha, so the other patches fixes ussues introduced after the last qemu releases.
>> So..
>>
>>> Alternatively I can pick just this function from 3/6, which does not feel right.
>>
>> This seems to be the right way to go.
> 
> If this isn't too much burden, sure. Otherwise I'll defer to Aurelien.

https://gitlab.com/mjt0k/qemu/-/commit/9ee013bd83c0c817c2eedc9efc5e510095970775
fwiw (it also contains another change for TCG_CT_CONST_LOGICAL_VI definition for 10.0.x).

Thanks,

/mjt

