Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91DFCEFC56
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 20:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syGsu-0008VT-8O; Tue, 08 Oct 2024 16:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1syGsp-0008V9-Rq
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 16:32:40 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1syGso-00046C-1j
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 16:32:39 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53988c54ec8so7105742e87.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728419555; x=1729024355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6w49QYyYVLa6GqkUiBgNT6GdPCIBCzn072Fys/T2Vg=;
 b=Mf52dL/24RVcWDqFijrVs2j01ytanUbOZTldDI/aXkoEcFxpQ5wljF0uRaJdHeVZiT
 7jZKvYHJ8dMVIZYL1uXHOYLQ5aAM8ZUlNbr4YRxtzYmTO/lcekfGsNUN1GQshFDhLob+
 XqiT97SKGqipnDUFD6qAUMVtyEsB2rxvPf70vFx0Lm4ZsEilFxwnK5IJXot6dk669j6j
 VLr0yIgGTsixyQm3njcnKuZMj5hHy5NwR9KbhKJtPBZgfUetrtwombjEg1SIUJDR1gdU
 TrTKdn6Ncu+7fLUttkxnfQ+6w7PxGoF6b1nJZggvlowgbXveop5xfdWYyp5F/h+HM8sh
 1PHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728419555; x=1729024355;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L6w49QYyYVLa6GqkUiBgNT6GdPCIBCzn072Fys/T2Vg=;
 b=t1SuL6zDW7rzT6Y9xzVGNd4onUWWCyEAJ+6hGlWHJtr83LOJ6aYoosinjIRD/3KMq5
 5ihthOeNmPXhKINMLktY0c7TzWjeunAfG54hAEgHhntfyk+82fwdLW+cHRmjiITXNT2j
 zdeb+rc/pgR835pHTv0JxkmTq9RpOcL2G8C/cc7IsFvBRWkdTCJSEpRlMpNMKfpaPybn
 eqNM48SNSadr6v/3q36QkxtnXJ6bIHFhXiaH0pwbSemnFBpwPJFOWwKqM4kOO1glnCw4
 PiLOSE5vaiqX7LubqKYe1IGXtwcVnFCn4HL0LB8qd0PsSb2cPNGNXdA7koKhd9oJX0U4
 pLvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGtWrzMuuEA5QyBZsvMg5MsH9GHzPwDXk8zjnUktpG06CwvgsAjpnFTXfTp6+X3yT4p3LlG6RW5j+c@nongnu.org
X-Gm-Message-State: AOJu0Yzvsc3K3THapCWrsfr9JrGsMqN/5GFT7lV2awG/QLi7fGkz8Ypi
 aZTGQOp/omskX01ih1EskQhw1fX2Z1Bqrrq8uN7xzNhF6teGDxvW
X-Google-Smtp-Source: AGHT+IHySahIAfX01v1iAz8ltyDie8D/AKb6lFBBkIITy97Q0ZwMdnfI0mSa8uq6RpTomIywYt/jOg==
X-Received: by 2002:a05:6512:104b:b0:539:8aec:ecd6 with SMTP id
 2adb3069b0e04-539c494ec96mr13953e87.44.1728419554950; 
 Tue, 08 Oct 2024 13:32:34 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-183-017-071.77.183.pool.telefonica.de.
 [77.183.17.71]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a992e61da6fsm550757166b.62.2024.10.08.13.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 13:32:34 -0700 (PDT)
Date: Tue, 08 Oct 2024 20:32:33 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
CC: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH] net/tap-win32: Fix gcc 14 format truncation errors
In-Reply-To: <a4ed7ba2-2cf5-4ac3-a9df-97c42eb881ec@tls.msk.ru>
References: <20241007101313.3900-1-shentey@gmail.com>
 <a4ed7ba2-2cf5-4ac3-a9df-97c42eb881ec@tls.msk.ru>
Message-ID: <8577ECC5-C337-4866-86A1-E8B69E8A2D63@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x132.google.com
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



Am 7=2E Oktober 2024 15:47:29 UTC schrieb Michael Tokarev <mjt@tls=2Emsk=
=2Eru>:
>07=2E10=2E2024 13:13, Bernhard Beschow wrote:
>> The patch fixes the following errors generated by GCC 14=2E2:
>>=20
>> =2E=2E/src/net/tap-win32=2Ec:343:19: error: '%s' directive output may b=
e truncated writing up to 255 bytes into a region of size 176 [-Werror=3Dfo=
rmat-truncation=3D]
>>    343 |              "%s\\%s\\Connection",
>>        |                   ^~
>>    344 |              NETWORK_CONNECTIONS_KEY, enum_name);
>>        |                                       ~~~~~~~~~
>=2E=2E=2E
>
>>       for (;;) {
>>           char enum_name[256];
>> -        char unit_string[256];
>> +        char unit_string[512];
>
>Is it maybe better to use something like g_format_string() or asprintf() =
here?

Will use g_autofree and g_strdup_printf() as Peter suggests=2E

>Here and also in net/slirp=2Ec

There is a dedicated issue on Gitlab [1], so I'd keep the ball flat for no=
w=2E

[1] https://gitlab=2Ecom/qemu-project/qemu/-/issues/2607

>
>Thanks,
>
>/mjt

