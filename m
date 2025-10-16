Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE68ECCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 22:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9WfG-00011G-Sf; Thu, 16 Oct 2025 18:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v9WfF-00010u-LR
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 18:41:41 -0400
Received: from pc232-62.mailgun.net ([143.55.232.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v9WfB-00048k-T2
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 18:41:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mail.yodel.dev;
 q=dns/txt; s=pdk1; t=1760654495; x=1760661695; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: From:
 References: To: To: Subject: Subject: MIME-Version: Date: Message-ID: Sender:
 Sender; bh=uFDrjIWQb74pobuLKsFLeRlHZoFM6tPTF0pa8Y8+Y2o=;
 b=iS4T6pjkPsoGxQ8dequC0JOdBnsNezHEFEyVfNqP+dtpQFGlj0PQBJo+KSd3FBFvY8e037IBRYpP7mj1Kpp5WTxu1IfGQ7cDsY5JHeQgmj/dxrdgoHJM0M1661mEkX6xUwh+tbyTOVeSznVenOnAB5nKgVh0JWxkBIaQ3PiS4d62RtbxeaNxcCW6N8S5HSVm/3y08hQpam0+40+Gldw8i9853rOAeZNI3S3cy+DOU5UGr5j4bHVK0xNGQ9cgJV8iqvEfIm4ajF9qFP4dKuoJbpxcOvrhZlKiPuAK70Gc16h55idoFOV6cNnpTdz+ZrQnSiByRfzsuib+0bNoECAohQ==
X-Mailgun-Sid: WyJjZmM4NiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjMzZTkyMCJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 3324ebea0a9c932455ce733cb80fd46901b980d287b6a3b3b4d598a8273db52e with SMTP id
 68f1749f51cb16734bc57559; Thu, 16 Oct 2025 22:41:35 GMT
X-Mailgun-Sending-Ip: 143.55.232.62
Message-ID: <bb997856-ded0-4a03-9e60-b65bb8543932@yodel.dev>
Date: Thu, 16 Oct 2025 17:41:34 -0500
MIME-Version: 1.0
Subject: Re: [PATCH] gdbstub/user-target: Map errno values from the host OS to
 GDB
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251015162520.15736-1-yodel.eldar@yodel.dev>
 <87o6q6j3oe.fsf@draig.linaro.org>
 <8d00eb96-97b0-42af-9e3b-645efbe909e2@yodel.dev>
 <9971552b-9c7f-44e9-9263-3fd08526e4d0@linaro.org>
Content-Language: en-US
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <9971552b-9c7f-44e9-9263-3fd08526e4d0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.62;
 envelope-from=bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev;
 helo=pc232-62.mailgun.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Yodel Eldar <yodel.eldar@yodel.dev>
From:  Yodel Eldar via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 10/16/25 4:51 PM, Richard Henderson wrote:
> On 10/16/25 13:51, Yodel Eldar via wrote:
>> Since your review, I've noticed that Richard Henderson already authored
>> a host-to-GDB errno mapping function in commit 7327e6023:
>> host_to_gdb_errno:target/m68k/m68k-semi.c; it's functionally identical
>> to the mapping proposed in this patch (albeit missing two errno values
>> that were undocumented in the GDB manual until recently), but written in
>> the context of semihosting for the m68k.
> 
> Heh.  I had glanced at your patch and thought "don't we do that already"?
> 
>>
>> So as to avoid duplicating code, I'm considering exporting the existing
>> host_to_gdb_errno in a minor refactor to use that instead; do you think
>> that's a better route?
> 
> Yes.
> 
> 
> r~
> 

Haha, grateful for your eyes and input on this! I'll be sure to Cc the
next time I name-check you.

Yodel

