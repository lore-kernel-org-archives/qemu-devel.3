Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F1FC48BC4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 07:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbbXC-0004hd-MA; Sun, 18 Feb 2024 02:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbbXA-0004hS-KC
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 02:24:20 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbbX7-00039D-37
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 02:24:20 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5cddfe0cb64so2626595a12.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 23:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708241054; x=1708845854;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6s2J7pxcu87jybxbe9Jp6wbGRAOwl00TkrgMBn8O9WM=;
 b=aB6daOqudDqb3dVma7YCF0PdJJBI9+gEZ9Hon7FlrJ0uauvYfpZO6FkP3tww9qTx/F
 C3LMsA8oP3GjpZALIIml+WY0JyhJkj6uNmDtYmVhBBVaq4EsiG/AoWRHP7yu1sKMCsrA
 5FzSt0jTwfoVMb0jPNZ0sx5mrFkUwE7crYRWL3LKuplt5z3dVOlwMDajz7Blcoe1u3At
 zopgzeBaUwJs0sXEUxyyFBc7Q3ij6dTGUN5Ef7tn2TkEkGVYWTrFYlAbvz5sp3tZaq1s
 GlTGHAeQpiXc8e4n8f7E7uobiE1KdU+EweQ7x54BvOXKJz2QIkd2fIQ1B9jE5TYHUOIc
 Ia2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708241054; x=1708845854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6s2J7pxcu87jybxbe9Jp6wbGRAOwl00TkrgMBn8O9WM=;
 b=F0dVLpQJ61jegO7lPoLkSc2ztc5sLge32QOjoyHVWaGYYum++rQPFUUY+3dPzSVMQ9
 whvwJnhgk+3DgKXYwY9rfykV+pxpfdXvCykQlm7MyTHI2zEuczz9HaqY4DzM+N9Giipm
 R0tls+FUFJ9icUndo0sXIrjioJ1jqCLRavN2dKlK3yWd1nO/g5j4JeF61O0WLP0hrnED
 zPgs1mrDlpUL0+Wn90m8mWRhJfdG1lS8mVRiX/1PwXt8R3N/ZGC4dCPWp/x2Ke/3D9Y7
 fUf2+mFpWGd02zNOFWZmnvfL2v8J/0t0VG7JX5tj4GFp7k/ReJTWSBzcpOX0FVlsVgV2
 aggA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl8cKpZZeXLuNWBiO2fCKzQb8+wvToceDfTzs8d6xCKc2m4bBj2LVnh60X964adrR8HbVePQB3GiCGCKjoiRUD4RXnSg4=
X-Gm-Message-State: AOJu0YzZBe3enFRN2ImCw/f1IPSqvhDtkJwSiYoj1KFbtUS6le1WMu4D
 CUDpTlaHV3I4TuiC6Vp5BipK+As+F6Udg5wWBMIA4unQtnTJBR1gliM87j7N4po3SrmmXGUH4pu
 R
X-Google-Smtp-Source: AGHT+IGTXlEyTOh6Lr45Kgr6LpxZ4RpnB7ejC3x0pleG1qYu7wRlJActMCGI6zY9XMf0Os2p4TwDvQ==
X-Received: by 2002:aa7:854d:0:b0:6e3:e797:2eef with SMTP id
 y13-20020aa7854d000000b006e3e7972eefmr1118912pfn.4.1708241054269; 
 Sat, 17 Feb 2024 23:24:14 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 r27-20020aa7845b000000b006e45a40b2edsm463459pfn.212.2024.02.17.23.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 23:24:14 -0800 (PST)
Message-ID: <a06987aa-c361-4150-8f06-1600419d289b@daynix.com>
Date: Sun, 18 Feb 2024 16:24:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/vnc: Respect bound console
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20231211-vnc-v1-1-a3551d284809@daynix.com>
 <CAMxuvazT6KbrSe-Y-nPZqPyvsOrvKLaMYhpDwrCD+tJMW1xTWw@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAMxuvazT6KbrSe-Y-nPZqPyvsOrvKLaMYhpDwrCD+tJMW1xTWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/11 18:43, Marc-André Lureau wrote:
> On Mon, Dec 11, 2023 at 12:51 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> ui/vnc may have a bound console so pass it to qemu_console_is_graphic()
>> and qemu_text_console_put_keysym().
>>
>> Fixes: 1d0d59fe2919 ("vnc: allow binding servers to qemu consoles")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

It looks like you forgot to pull this patch so let me remind.

Regards,
Akihiko Odaki

