Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38242FA0C48
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 08:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCvQv-0002PD-6X; Wed, 15 Apr 2026 04:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wCvQt-0002Ku-J8
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 04:17:11 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wCvQr-0004rO-EH
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 04:17:11 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7F0093F6B1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 08:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776241026;
 bh=bAzfcynvIl0xCNstMQsFagx8f4Jwt8qtXq16KuGWHA4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=WFJe6aO14UAGlclUZEgo353NiWbQXgKf5cZIneNnC2cWvW78zkJ0bOhtvl7t4xWRt
 /t7T8J0cO4AwP9iBpiYmE5IO5qrItfv9R98D1qnH4GvZjdbvw0ceCPAXBGSXOHIBcz
 qUyGilPmt0bD/5vVmMc0bvkCk1fFBqg+DHfANQcqQNjcCWovR+zio/5fQoNxvcvPDz
 q5AZ1yYVmpAN/tKSNNtVodRT0pqL+Nz1XggXWguHL+X6AxRAOsiK116F5tZqw8hQ+G
 Z5GN4XsmlriVWNNBnVOLKzav7vIFKXUtNgTb/oSmGGX7kZc8n0nji0mvT34OPXz1ct
 U8qQxasQbhVrJ7/CA699tXh9jbaAedoW7DcbatGBe0MPgSZnIF+dowYN5aJyig9GTL
 teoMNZSEb3a+ct2lJ5SMZxDd0Iltp9hbW+yWs+usAMRheGOR26pr1jBkFZh5BMbvuR
 +DtX7dPwHT+UTAwB5bT7Pko1O8Zrqf9cvD+d7zvtvm6nSqxjyHDTMQcZ/7majqUOQD
 tCb3AhiCI6iSKfvt+Xvbbx0o0VJtVHnO/e4G0WAypbX34Ri91nBczE9ZB0/ZsRDWlq
 AKiIopqki0u/Z3mApWaeYkrgLNBiiiClGEAjwlvEa+WD/5AbF9/6mY/m/f2BGmsTDZ
 HAT4H4H3NsCwSjso1EUaP/YE=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488cc31ea57so40838965e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 01:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776241026; x=1776845826;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bAzfcynvIl0xCNstMQsFagx8f4Jwt8qtXq16KuGWHA4=;
 b=JKozsct4T6Gz/0eA1PgD4fBxIXyJP1Uxn/EAM0bBUYrARvHLSuLVBym9bY9SabS6O2
 BFgj7zykY2O7Tm55ZHF4qvKq/vO6OfehzyEspyYRb/rgwsrjziQA5komKksMKyXNtuUW
 pnslJrxn6XWoIZgYirZttvsjtx1X/bGh6WzMpc3Z3wpcJZYAJS1yKlJfjJ/5nVEFyA7f
 ZG2uA+c+hvCZ5fqOD1TE8RpqJgVq+7rxwJ6aWmghZR2Zu8ZEZUZ31cSBchq2BC15upSP
 zghm3DoWGVOfcX2Ukf8ylJpznI/BqSAjYPaHFzipzfmj+ti+EG4NNFzIoP0n0/c55Kex
 VhOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tur29CYNwDxeuwxJ6uHsP/6sibabJ1Wn5lL4yooIUJ6TmH9ZFwZjjJ6aIRVIS6CXLD/6TQAicsW8O@nongnu.org
X-Gm-Message-State: AOJu0YzncxSvuuTuSYi0VgHjinEOh4LMgVfjBlgNz/lCe9RAzv72VSyd
 AUxX8z79db1+F5MLMpvLbeZEqy6lYHtc8e2NktK3/EB5iuBvIceVuaWRgu3refM7JICWBgfp8Va
 EOQtXq8JY1+JQAoWrdMJ5njwIN1sEg/Z5b0UmkZDYUkUOB0l/H3nvJwZ1kDzv+xg0FIwDYD0V
X-Gm-Gg: AeBDievsA2kij1ZORZCzfq1JQhH4+YkujnHPoSL2k52hhymWvTmqStTRDrm0Zi2MpBb
 lwzncq3aac7mszcZG8/OurbwwVOuHu54JyXnJ5fP3IOkBDdwiEbVnzhwulQgs1X/krbA1ACvBIr
 6BcQGy6XbHtuZ5Ewgvujk58UrsHJvIxZVMHCmGrpKo5tobefi1K3Cia5zFNGgGj8ttNKbXrJ1da
 BYdOhkgB5ULicQa7QIPFbyN4lZIXPHAKSqdgIisDmeimsgWrq6uUQHeKmdrN6K3NvfHC20nO0JV
 LjT1QAPgw1ch2NztPwL3JHZ9a3WTxSoMTj/GdVCWNlIo8THdzpxHQUxG+ObGNPFGpllV117gZXf
 3bIaEp18uTDQT8E8OEJLPPuXjUxLGUJ+Hk2PGqyOFYOgYgKfyDqLybMONh94vSUeDx6VPXU57z+
 39+hvW700vz1THtVSOhOqDYgu/mdRIG7xDtrcncS+2rm4pDmjZ7y73Vrae5IyEpMr9x48=
X-Received: by 2002:a05:600c:45c9:b0:488:869c:edaa with SMTP id
 5b1f17b1804b1-488d67e269amr283726365e9.7.1776241025965; 
 Wed, 15 Apr 2026 01:17:05 -0700 (PDT)
X-Received: by 2002:a05:600c:45c9:b0:488:869c:edaa with SMTP id
 5b1f17b1804b1-488d67e269amr283725605e9.7.1776241025367; 
 Wed, 15 Apr 2026 01:17:05 -0700 (PDT)
Received: from [192.168.103.132]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ecde5b26sm124220735e9.2.2026.04.15.01.17.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 01:17:04 -0700 (PDT)
Message-ID: <4cfd4f96-f761-459b-9233-da81c0a8d492@canonical.com>
Date: Wed, 15 Apr 2026 10:17:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] linux-user/riscv: add vector state to signal
 context
To: Michael Tokarev <mjt@tls.msk.ru>, Alistair Francis <alistair23@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
References: <20260321141345.599105-1-npiggin@gmail.com>
 <2e752dc3-0ba5-4d38-9d38-d19b2b841b07@tls.msk.ru>
 <CAKmqyKM2boFhCnnFOq85xK_sjrVbr3pye45tAUgueDcyR3eBdQ@mail.gmail.com>
 <0087dcb7-ef45-4f1d-b178-9ab9a78ced54@tls.msk.ru>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <0087dcb7-ef45-4f1d-b178-9ab9a78ced54@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 4/3/26 21:57, Michael Tokarev wrote:
> On 01.04.2026 07:31, Alistair Francis wrote:
>> On Fri, Mar 27, 2026 at 9:13 PM Michael Tokarev <mjt@tls.msk.ru> wrote:
> 
>>>> Nicholas Piggin (5):
>>>>     tests/tcg/riscv64: Add a user signal handling test
>>>>     linux-user/riscv: Allow restore_sigcontext to return error
>>>>     linux-user/riscv: Add extended state to sigcontext
>>>>     linux-user/riscv: Add vector state to signal context
>>>>     tests/tcg/riscv64: Add vector state to signal test
>>>
>>> While a bit large-ish, and being sort of new feature, but it feels this
>>> patchset should be picked up for currently active qemu stable releases,
>>> when applied to the master branch.  Back-porting possibility to older
>>> releases hasn't tested yet, though.
>>
>> I don't think it's high priority to backport, as Vector support is
>> still few and far between

With the SpacemiT K3 an RVA23 compliant RISC-V CPU with both vector and 
hypervisor support exists.

The Ubuntu distribution is on RVA23 since release 25.10 and requires 
vector support.

> 
> I noticed ubuntu had to pick these up for one of their releases, -
> apparently they had an important-enough use case for that stuff, -
> that's why I thought to include these too.  Hopefully it wont break
> anything :)

As described in https://bugs.launchpad.net/bugs/2133188 running riscv64 
containers on x86_64 crashes on QEMU without this patch series.

The v2 series was added to QEMU in Ubuntu 26.04. We would prefer to use 
whatever is going to be backported to upstream QEMU 10.2.

Best regards

Heinrich

