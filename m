Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB7FCE8D4D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 16:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJwMu-0006Ut-Ob; Fri, 14 Nov 2025 11:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1vJwJa-0005OD-3H
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 11:06:34 -0500
Received: from pc232-55.mailgun.net ([143.55.232.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1vJwJW-0004S6-D7
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 11:06:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mail.yodel.dev;
 q=dns/txt; s=pdk1; t=1763136362; x=1763143562; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: From:
 References: Cc: To: To: Subject: Subject: MIME-Version: Date: Message-ID:
 Sender: Sender; 
 bh=JMWv7SnNk9uHTSK+5UUAcAtgxk3r3DIoAzn0QcNOEso=;
 b=4aooKRYWz2tK4X2O2l5lHIJ/l71sy7RtE187a/kUZESXE+HGPRsScci1FYNN6rKRL0EzlfUoXm5hUZgHbJ2nA/gJUmMMfOlT8PivxoPbp7ySRwFQrZrriHagAJJSwKicmnHobeyPyzClS6DOMlc0WWinQG13HBmXmw6RwHoBpxNTfTmxWdjiG5bJLCBPCnZjAh71b0Dl8b4NuBbgl62h+GWOqTKmkmp4FNawYOE26vnUFMovIsg6ORx/U6U9Rk4EST+fXIgjGjpHzUwP2srYbs5z67CWslZvOss2il7FmiL23pONvSEMG+o1+RO8q8s773RKd32dgbHsU0b4u4EUaA==
X-Mailgun-Sid: WyJjZmM4NiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjMzZTkyMCJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 3b7d14ad9ad78b1c6e6d7409de447049a6855f48b903eaec24781089ed31cc57 with SMTP id
 69175369c093f57552b734e6; Fri, 14 Nov 2025 16:06:01 GMT
X-Mailgun-Sending-Ip: 143.55.232.55
Message-ID: <4d6d7e9d-0952-4158-9ef4-6093a16e9dd9@yodel.dev>
Date: Fri, 14 Nov 2025 10:05:58 -0600
MIME-Version: 1.0
Subject: Re: [RFC PATCH] hw/dma: don't allow weird transfer lengths for bcm2835
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Raspberry Pi" <qemu-arm@nongnu.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>
References: <20251111105429.3993300-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <20251111105429.3993300-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.55;
 envelope-from=bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev;
 helo=pc232-55.mailgun.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


On 11/11/2025 04:54, Alex Bennée wrote:
> The datasheet doesn't explicitly say that TXFR_LEN has to be word
> aligned but the fact there is a DMA_D_WIDTH flag to select between 32
> bit and 128 bit strongly implies that is how it works. The downstream

At the bottom of page 38, the datasheet [1] states "the DMA can deal
with byte aligned transfers and will minimise bus traffic by buffering
and packing misaligned accesses."

IIUC, the *_WIDTH info fields are implied as maxima.

[1] https://datasheets.raspberrypi.com/bcm2835/bcm2835-peripherals.pdf

Regards,
Yodel

> rpi kernel also goes to efforts to not write sub-4 byte lengths so
> lets:

