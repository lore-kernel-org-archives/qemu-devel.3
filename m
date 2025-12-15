Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5799AD5B85B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 18:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVD5h-0008TS-7c; Mon, 15 Dec 2025 13:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vVD5U-0008JW-FY
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 13:14:27 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vVD5Q-00050P-Ai
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 13:14:22 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so42078735e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 10:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765822455; x=1766427255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3dzsXqkHvwqoBXvxlu95nqIsRk0MCO35JmcU23X3QE=;
 b=SO2lVVt0KgOlqK6ymM3Y7zioqkrtDZrLXJEKeIaq5y0sQulfBAf2xJnWgSXNmGRvb0
 vUzylYnkDWBa2n8NVxjahCyNEByaMIsKKgZOz8ULOYYXnhrHGfaDPMgpLHPBLvSJ1LB7
 oxfX5JwB0NvhoI4gPnkL7eXkoC2zURS9VP7RVMqIPre2jMSuH8/LcvDjlmg8eIjXnNgj
 JB00qV1+HP8kgxJLxwnRv6RdeNeT7TnCn0lPc0suwiIOTy+GQlz1OgRMm8vdO9B/xZv/
 BZbji37tVjPkLaGqKSvjwcfO+rzsYRXuVPy3K+3DYTJn8qW7udKM0uGIbPWAsKdQD2gn
 qAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765822455; x=1766427255;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K3dzsXqkHvwqoBXvxlu95nqIsRk0MCO35JmcU23X3QE=;
 b=PSFkrIqfLgP3BMTJaSwAQTbFLQzrYYcYDR8FQ33UeBpcv29L5ffBzW5aOnHHWW6N5g
 LYw+i+jOqytiUQGOQUcoz3BkiF03lnVdU5qj5Dreq2KADk/D0zFpT1Ev6FBPJf4/Yx4S
 7SvZ/DnLenakeCuPcS1ZEMJa5aEPFdd1h9vCk0DAXk7vxtRx2xwfz6jkpC7V4N5GWMFB
 igGCEb02UeuN5rrkJfCiNxuRb+v9n4eMgxnWo9eWf5X7BfUFE+1vAK6/S8AqhcBAsO5H
 A8vd81rTsZnJM6kqt8elAtjtaXRUZe9YR2nwLk64uEYc1XVpXem9ql1IT5MNHmXnGU4q
 t1OA==
X-Gm-Message-State: AOJu0YwCz2dUJs4MEdMQwE5GbHcXeCM9wbiZvXg+d5yEFk6iQFMRU1rb
 I4ZNp2bQLHzEsIRtIxtUchNlPu3SIzIuv7o4gYp9YuVcf62Wmz3ChAetpSSerg==
X-Gm-Gg: AY/fxX7fbRp2N3WIiMJPWPJmSTvCTQnZVhneTF0UckkDZ9S2ObksIPbq8mbhOZLVmif
 GGHoQLinKeY79gQYKBGvktPT/SkH8IoSeEeLlIw40DWhNdRufEaWzXSZ7h75rBGoRrWSMXxAXVL
 REbv2ggq6mLFSTPhHGbm5+AX8z1OQqYytXXjkhtD06UtH59DN4DmEYtr5AveOq+UfiN55etzkIp
 EM9g5fnTNzTpI6Rbpkco0LeuNdY4N7vn4ybtZdMMcRZCQYOo4u/tN0NORLvTjlfD+Iy5Z7wfKI+
 FTUGZ7g+vE4BanZCEuiqVqgr3hOZA7n9tubTTXZv5cWsAFqjFIKSf9X/vLs0bfiP2lyGBz3P3ss
 djffnZdYrkgKMlkla8F/GFT9JkqaDquTFx2u3XyAsw1YkX6XB7N7U1W6qE3v/OG1M6PJcGulv3/
 ENOXByjbPxdPv7duw1t6Lq+0t10eGoNlOlMTXc+dxwknU525oKsn6V55R+x4SF/ZmRi+rD/fDt9
 awqvBFf
X-Google-Smtp-Source: AGHT+IGYTTi/mdmsTZs5noFQjWVVIts/LpkOPrQYKtmoxitQKDC/vqt8DwTQLhEeY0q52gFGs3+cCw==
X-Received: by 2002:a05:600c:19c6:b0:477:5c45:8100 with SMTP id
 5b1f17b1804b1-47a8f906decmr118865955e9.24.1765822454752; 
 Mon, 15 Dec 2025 10:14:14 -0800 (PST)
Received: from ehlo.thunderbird.net
 (p200300faaf27140000b3712bc8ea4066.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:b3:712b:c8ea:4066])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f74b17bsm202810515e9.2.2025.12.15.10.14.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 10:14:14 -0800 (PST)
Date: Mon, 15 Dec 2025 18:14:12 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Pavel Pisa <pisa@fel.cvut.cz>
CC: Matyas Bobek <bobekmat@fel.cvut.cz>,
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: i.MX6 SabreLite FlexCAN emulation for QEMU progress/working
In-Reply-To: <20250710-carrot-pillbug-of-election-eca4ab-mkl@pengutronix.de>
References: <202507101258.05760.pisa@fel.cvut.cz>
 <20250710-carrot-pillbug-of-election-eca4ab-mkl@pengutronix.de>
Message-ID: <1B709815-4D9A-4C4A-B5DA-C69B432F7B5E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 10=2E Juli 2025 12:50:41 UTC schrieb Marc Kleine-Budde <mkl@pengutronix=
=2Ede>:
>On 10=2E07=2E2025 12:58:05, Pavel Pisa wrote:
>> Hello Marc and others,
>>=20
>> Matyas Bobek has implemented FlexCAN emulation for i=2EMX6
>> targets in the frame of his bachelor thesis
>>=20
>>   https://dspace=2Ecvut=2Ecz/bitstream/handle/10467/122654/F3-BP-2025-B=
obek-Matyas-BP_Bobek_FlexCAN_final_4=2Epdf
>>=20
>> with reviews there
>>=20
>>   https://dspace=2Ecvut=2Ecz/handle/10467/122779
>>=20
>> Please, if you have problems to access documents, try that later,
>> our large archive with theses and publications is under
>> "AI" scrape-bots attacks almost permanently=2E=2E=2E or send me note
>> and I send the document directly=2E
>>=20
>> The project continues and on base of Marc Kleine-Budde
>> review, Matyas Bobek has implemented timestamping
>> which should ensure correct messages ordering
>> even if FIFO mode is not used in the drivers,
>> Linux driver default case=2E There is even workaround
>> to advance timestamp if the the QEMU virtual time
>> is too coarse to provide unique values for for
>> too fast delivered messages through virtual bus
>> without real bits serialization=2E
>
>Nice! Good work!

Indeed!

>
>> The actual code is available on the "flexcan"
>> branch of the repository
>>=20
>>   https://gitlab=2Efel=2Ecvut=2Ecz/bobekmat/qemu-flexcan
>>=20
>> The clean, minimal patches sequence will be prepared
>> for review for the proposal for inclusion into QEMU
>> mainline, hopefully soon=2E
>>=20
>> In longer term perspective, I have interrest in i=2EMX8
>> and other FlexCAN variants with FD support, etc=2E
>> I do not know if Mr=2E Bobek will have time and interest
>> to continue in this direction=2E I can offer that as the
>> another thesis or can offer that as summer job
>> etc=2E But latter would need some funding for students
>> motivation and their time compensation and I have had
>> never and do not have any QEMU related project for such
>> funding now and even minimal chance is even in future
>> for other than CTU CAN FD IP core where we support
>> silicon and FPGA products=2E So no timing, chances,
>> estimates for something beyond i=2EMX6 FlexCAN=2E=20
>
>ACK, I think getting things mainline is more important than CAN-FD
>support=2E

Any news?

I've been playing with Matyas' flexcan branch and integrated the FlexCAN d=
evice model into the imx8mp-evk machine [1]=2E With some minor modification=
s such as allowing for 64-bit access I am able to run cangen+candump on eit=
her side and see the communication!

I think Matyas' work should be upstreamed=2E How shall we proceed? If desi=
red, I could do the upstreaming process, leaving all credits to Matyas of c=
ourse=2E IIUC we'd need Matyas' Signed-off-by tags (of the *squashed* branc=
h) in this case for legal reasons, correct?

What do you think?

Best regards,
Bernhard

[1] https://github=2Ecom/shentok/qemu/tree/imx8mp-flexcan

>
>regards,
>Marc
>

