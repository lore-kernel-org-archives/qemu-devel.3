Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92965F30928
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5cx-0005dZ-4y; Thu, 05 Mar 2026 05:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy5cn-0005Wl-10
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:08:09 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy5cl-0007ZN-JN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:08:08 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64ae222d978so7312398d50.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 02:08:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772705286; cv=none;
 d=google.com; s=arc-20240605;
 b=Wh/B4ce717+W3yiXG9EO0NMKIdENsZV+hFo9BmzKM5KVUMhnUBtaxQm5NcEIZdvJy7
 nqxbUTE/pWbmpMgZvjiKcb4F18XXwpAVVxMzvr7zRfXDS1ap9dWgXtHGc0ndovUqIJJ+
 UnVZ7vwm7RzZ/ooIMqk0SA7wJ6x8Tuzxx5Hf8+zSTZQWzjpxVisjYnlFdJpJKxcip0H8
 rlv+FLLFk2iCCoQnTcJc6OO7/v+xR2LP4Z2W/2VdYdPcIpvul/5jg89F9O4H4Ec3M8v+
 cXboZ3O+p0IBXD1gqrt+ZtupblzBN6W3NjZWxywaV8x/QDsOqrGJoHYjBw4Y9cv5C0aY
 NPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zkHjZt0x99k4YWi8QXUYX0HQDy0YamUUJ+u8aYP7oGU=;
 fh=jIzvWV6lmISWZTXv3M0Np2HMsoZAsMa3LTC/2QEOYEg=;
 b=VmngfomJfiDN0UFO6DCWuzS3cDMi+WmTDthlnWO1HFH3iYA7KVkDNS521eRtTy94lD
 ILUbKbxnEqwLk2SPMoaPdG61407hRwHIaKBVfWFAYk845a3fZV0vWYlTKKkuiMExJD14
 WYme1VLfmKQ94vqVObMKzrAfdBOJIQP8pGavBN9qXWLF0HWzRM1S8CNDYhA/V9F+ZF7x
 KJ6bcOXU79UBi2jewto0b4FumS/Jb+dTCTDbH1AV+jJgeypyNohs9d2p4daRi9aC1UcT
 3Kc7ucdl8S95ZsTocoLXFJYLs4tPm37Caia/H1ycJZs/mTfrIm5D6OkJRA9Drk8UOiBy
 zQaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772705286; x=1773310086; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zkHjZt0x99k4YWi8QXUYX0HQDy0YamUUJ+u8aYP7oGU=;
 b=mC3Rt9kb0m1PKQgxm1hba1cXJYPIjlikA5AJT0HJZE/MWrSZHan81h/gyc9XfR3Vl1
 dPJMwctA+m3tvg5Z5H2cT4bEWYp+Gh6Kvk0AusRSXfrOGfIEVnUmYMSnJDz6Jhc9+hU4
 /C4Xq0emCdSsKhMWxai8wL1ubmvBAo1kRzg3FbvtLZOinsjBZmYvXAgI0E72iwVRIU5Y
 Lr5TARtpVLy8IWwM6gcqPlq7J4ouZQy3jbyXAGe7ktFMKcF3ImurZAMNOpnUM0Fw+mJT
 W8ZEvF8XBsJPZtxiVFyEID2otLUmdU7m5HC3Sk6irlItQ+GyA+dbr2s5gP+gIke8Coo1
 uh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772705286; x=1773310086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkHjZt0x99k4YWi8QXUYX0HQDy0YamUUJ+u8aYP7oGU=;
 b=MPNYm+FLmomx6jc0/cGzw2kaz8pd1W9HLUZuFLPyomdm5dbYasoohzdlp5rkv3pwyO
 Z2fZATD/yPyIP61pjF1P/r8VB7MAeA6AhliFug2D2R43SfGtPONNd+INex8vyjq828MQ
 mvE/1VIPwfzOmbfQNP5z4LuR05EKsMFxjRvH5qKhhjUWBgn6fl62hs9GeDGntvdTFo83
 iZSJTXybCSnK16uHklmNdKlvEhETVrCEw7Iw2iK0Bq6AD8CySxvpII/iJ/aQARyXyPFN
 3DoBxumUWEy9cFjYv9eKyUitFS+Xk6Ryk+jHCKY6vL1DD8/YEYneDaFimf2kCcjpBT3E
 YfJw==
X-Gm-Message-State: AOJu0YxFp6QHphXvPP817k9Cj/BbLRxNlWm+KQ/0P5gMYNcgMs5nBba7
 dwOopnLdH8Frxt0WG80s6+0t+6vw/N/lJd5Lr6wJIJNf8mn1ZKXyTGvkKJuDuuBU7uVXAP0Xmec
 NjqelzZfEkPCoc/5YrtuHJR3/ISl9DJ2BeNboBjWXz00ShsCBJPao
X-Gm-Gg: ATEYQzzNC2xufPFgc+dTyeStpOBmQfK/eshqaMkDcnCbn3GEVoH4sneVo2Pzlm0q6V9
 4480qgsIQA9N6pttEl5WXvrWk+20kiRLKiUaEOL6R9lq03AWB1380Zl1s4hRRo3whRMKhBLV1sY
 z89cu18DkJd3LeRGdGZYzOIvchnbZ1MqonYLzpMUErfZsrW/q0S0oO0cUjhfXyap4YoG6pA5pQL
 r35cHxX1CDtoviusxZuoSa+cfj768Z4K72qzzH47tX/wWd50Kqgg7U1YD/wTsVcASrrnQpAAE3V
 AtU9mAoyboU2pq5ZSZ8daUlXmjotIQ7OogbpGCyXozUZMF0EZSg/cP79X7fqpkZN8J0=
X-Received: by 2002:a05:690e:686:b0:63f:af33:e413 with SMTP id
 956f58d0204a3-64cf9b53c47mr3156827d50.24.1772705286434; Thu, 05 Mar 2026
 02:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-14-shentey@gmail.com>
In-Reply-To: <20260303222143.142741-14-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 10:07:55 +0000
X-Gm-Features: AaiRm52qPVcoirAhaPCCzH_ptcnJXie7oefaIEI3VyjjfVEq-Ul9wkTC1aVKdcU
Message-ID: <CAFEAcA91+=5ronWLL8hX2vqGQJepdD_SoLtchcn7U11fvYP9=w@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] hw/char/serial: Plug into reset framework
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 3 Mar 2026 at 22:22, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Now that SerialState inherits from SysBusDevice we can take advantage of
> having the reset method called by the bus hierarchy rather than having
> to plug and unplug it manually.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/char/serial.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

