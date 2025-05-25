Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E28CC54ED1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 00:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIzRr-0007i9-4f; Sat, 24 May 2025 20:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1uIzRp-0007hu-Kc; Sat, 24 May 2025 20:42:41 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1uIzRn-000213-BS; Sat, 24 May 2025 20:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748133754; x=1748738554; i=deller@gmx.de;
 bh=+Wj11fwaPwhIw7j4ydQEx7HZOsYnF1rfCGbwyDwteeo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lQ0mZ8U9CrDXMSxo+Uz1GqxiDdBH1/TJmvctCatXcJtwlU5/5qkbhXG7F2nvVcDG
 n8dIDgO2RIo3YfmLjoQLQO6QAgHqNYYxgqBiKCBFOeE5fF9ZX5kFiFFI2nCfwIvmQ
 R5DDXrV0t6nEPeZBlmGHP7JAJAM7onHoKU6h3rexesCed3tPBsKjUlmMAUDs0fe50
 f+MwxmY3XYttFSbWlNlFe3NX4J90ZU2LmbGOQTAxwtBH/ZqGuSuVUCCvYOW15tXXO
 xUwIv/t671J/K6HHnmrqCs5pdItjVA+Zy0yL6KGOoxPa5W0HahxqS5siNQsetiyng
 UwPepVuiQD2IsZaxdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.249]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiTt-1uVGQZ1Z7t-00VymI; Sun, 25
 May 2025 02:42:34 +0200
Message-ID: <a82cceb9-4d5e-4a49-b476-cf2f97269133@gmx.de>
Date: Sun, 25 May 2025 02:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target/hppa: Fix FP exception handling
To: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
References: <20250517120053.18231-1-deller@kernel.org>
 <6998a9c5-90ca-4bbf-bf8f-81391ad79009@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <6998a9c5-90ca-4bbf-bf8f-81391ad79009@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:63Ts08qxAkTIKnPQZ4Cp2cNsICPuUovBDqdUchfttn597ATzy+f
 m5llG7j7Tre3ewgO7UsI3D8/v4Q7MmVgwFkLgRVfaFO8Eeh8D4ihNZtnhySytpcjz5o6DFw
 Hj77qdt9TH+ew/t91TMAa/jKDVdg1KN2GCNRoxKIMmiLWgSuCRNODX9NqnC1rjaYDXzaiTo
 dhIC/pPoL+cXlyUkz10pw==
UI-OutboundReport: notjunk:1;M01:P0:z5An+i5bZ7o=;Wl6JUStgi6DuNeLTENrkFT4KON+
 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
 3RO+BtrLKV4ss=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 5/24/25 12:26, Michael Tokarev wrote:
> On 17.05.2025 15:00, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> This series fixes and improves the floating point exception
>> handling in the hppa system and user emulation.
>> A testcase is included in patch #3.
>>
>> Please review.
>>
>> Thanks!
>> Helge
>>
>> Helge Deller (3):
>> =C2=A0=C2=A0 target/hppa: Copy instruction code into fr1 on FPU assist =
fault
>> =C2=A0=C2=A0 linux-user/hppa: Send proper si_code on SIGFPE exception
>> =C2=A0=C2=A0 target/hppa: Fix FPE exceptions
>=20
> Is there anything relevant for qemu-stable?

Basically all are relevant, but I think they don't apply cleanly.
 =20
> At least patch #1 seems to be relevant, at least for the recent
> qemu-stable series.

Patch #1 alone won't help, as the OS will only recognize it if
the bits are set as done in patch #3.
So, backporting all or none of the patches is the right way.

Helg

