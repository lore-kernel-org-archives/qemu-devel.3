Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75F1EDEBEB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxVdZ-00060D-6s; Tue, 03 Mar 2026 14:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxVdX-0005zr-Go
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:42:31 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxVdV-0007kj-Vm
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:42:31 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4837907f535so53668245e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772566948; x=1773171748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEZHV65hPRfDyLVZPVIu6MqDA0osLIwKG/u+gMAwub4=;
 b=RPhFRR635lPskiHITw+miJg/+Wo2wKqI7AwINFDTlTiKql7RAwbT4V5Q4U+1knkC0Z
 Md3wmeUBJFEAmBznwWWOVa9lWu7LMHAiV0O0eakGJhCVrR9Yr7CzcR+OeG+6O0XUn3X2
 s8pAKmLS3R/ba6AePq+yghpIsNZZqLezFV5VoAzT75U9HixPriJNqxQayN8pwOfPeQmc
 1sT532JqebI3gBQT78+DJS7jS7HkDpY0/SQQJH4iqVLQFyU+il2KcFSSAA9rv48yimDv
 aVKmMrAt92mxxHPo45J6BXruhnSTE7B/j6NGS1tY0E4AKxZMA3Y8g6vT3i3RvaQNj39l
 t1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772566948; x=1773171748;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AEZHV65hPRfDyLVZPVIu6MqDA0osLIwKG/u+gMAwub4=;
 b=BBqAaPUB8BiZKifQ7ajyg57Hlcb96JZZpD8/JJlfhTDTcrr1P/92E2HgxFJTO/Htkf
 Sak4DVO1PZ8Lm4xwDZh3s+wfWIrrtepGDZmFxFvdGS5OT8mX2PQ6WhFvYm+ohUClLXfD
 O2oy4xdetJhSWh795qag0d3b3FN1fXusjHRMGnFWnywAQ/sCP1A6vhYtwWgRZmUCteq5
 Pw7fndk1Wa5EFEZBG4xDsqm+6m0XInPy1K7q9st4z29WUdjSgnmZJqhcGOtM0QLhTkU+
 gs/fMzLnhA2r0Vnf3wfWifcOhm9RsmuoNIlF0lDI/1wUFPXvKByb8HLe9weJWUI7HHr0
 rouQ==
X-Gm-Message-State: AOJu0YwVA3Yq9EYkX7sEpsgOVbIhgXb/zHw+n53jDZhR+iM/UBKzttNb
 SibWiJhj7xyh3dvsSt+JJR6ALtQGJ+SFnASn99ye33Zpr9A76XePA0nF
X-Gm-Gg: ATEYQzyl60ByAuhDRGRnrbAnxVVj/t6Ip3BfNTPOPhnzSvFFkw1bFtKeuSteiY81Itg
 dDR/QglvHAEiZ0O69Ud3DTDc1fQ/PzOxudDBUJB4HZG3vweMjpbNGcDlPwFr6ARGNoiOJ6Kr6oI
 xDRTZA8aWpGVpYLsvKCMDor7AMaCJlDWEdsyiqS8UyLywa8enOe74xkU8rVNEtxFIZRlv2dbzfT
 oCUFfscVjHrgSx1Fla3PQg6NIdymz+4Geei554dUu+FbBH0wOqDUl9U8WWBJlydyy5I7NP84b0t
 LRXHWs90XpYAR4jGlSNBbyZ8cf19neBR5YPRrMrlmCD3Ngj8d5tnfSBYEEVcAbCK53pORLrcvUL
 FEt+aBzPNqLjeSx0TudxibYXATMgUbWR9W8oOQga5M9WMsSA3Ruj7XI6rvNFbqfN6gZURFH4y6i
 FkbfHLLGX8UkTxm8TzM0VourZaRe1VzQvzWQckYRgGegWpdPQ4PMX0o/FgomrK7lc6mfUs4coSv
 R7osq5DRKnxRdILuGtg63E90kxHt4kqi1YKWt2XLS7dXD1VJ/tLF7vMig==
X-Received: by 2002:a05:600c:5308:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-483c9bde0f0mr307361955e9.35.1772566948145; 
 Tue, 03 Mar 2026 11:42:28 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-1c79-b600-f009-a6c9-39e7-d8fe.310.pool.telefonica.de.
 [2a02:3100:1c79:b600:f009:a6c9:39e7:d8fe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48518807293sm59365e9.11.2026.03.03.11.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 11:42:27 -0800 (PST)
Date: Tue, 03 Mar 2026 18:44:47 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>
Subject: Re: [PATCH 05/12] hw/char/serial: Remove unhelpful comment
In-Reply-To: <CAFEAcA_Y11BUgYZ9erfSgDmak5E9CdxHaAemj+7ntscDGLUTVA@mail.gmail.com>
References: <20260302220254.1166849-1-shentey@gmail.com>
 <20260302220254.1166849-6-shentey@gmail.com>
 <CAFEAcA_Y11BUgYZ9erfSgDmak5E9CdxHaAemj+7ntscDGLUTVA@mail.gmail.com>
Message-ID: <6C35DD57-E514-415E-BF2F-D45331B63FCB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
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



Am 3=2E M=C3=A4rz 2026 11:27:18 UTC schrieb Peter Maydell <peter=2Emaydell=
@linaro=2Eorg>:
>On Mon, 2 Mar 2026 at 22:03, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>> There is no "is_load" flag and one can tell from the method name what
>> the method does=2E Remove this unhelpful comment=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  hw/char/serial=2Ec | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/hw/char/serial=2Ec b/hw/char/serial=2Ec
>> index 2c558cb9fc=2E=2Ef73de1ae4f 100644
>> --- a/hw/char/serial=2Ec
>> +++ b/hw/char/serial=2Ec
>> @@ -281,9 +281,6 @@ static void serial_xmit(SerialState *s)
>>      s->lsr |=3D UART_LSR_TEMT;
>>  }
>>
>> -/* Setter for FCR=2E
>> -   is_load flag means, that value is set while loading VM state
>> -   and interrupt should not be invoked */
>>  static void serial_write_fcr(SerialState *s, uint8_t val)
>>  {
>>      /* Set fcr - val only has the bits that are supposed to "stick" */
>
>This must be an ancient stale comment from before the device
>was converted to vmstate=2E

Yeah, "stale" seems like a better fit=2E Will change in v2=2E

Best regards,
Bernhard

>
>Reviewed-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>
>thanks
>-- PMM

