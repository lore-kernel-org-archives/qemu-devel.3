Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FE8C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 14:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM65x-0004vo-F2; Mon, 02 Jun 2025 10:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uM65u-0004v6-Nx; Mon, 02 Jun 2025 10:24:54 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uM65q-0002X7-Gl; Mon, 02 Jun 2025 10:24:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-23228b9d684so47307815ad.1; 
 Mon, 02 Jun 2025 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748874287; x=1749479087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=VAraLD0O99qqVbCM0WzQeauqLQGFXXrsIpxYuOivrn8=;
 b=JMN00tUsZboUg7e0SgbAmPGVB6+5KmXxOKlB1DlDHB2pmPJVtyVgcQWpmiUkD+s0XW
 VHoFcG+/rKA3Qgz4/BNxivImJEYQJz6SCjmB3yI/vASgNlg2hybJR57UESsK0vmBXKNT
 bGZl2WJdrtPlt9P51zaqMpsTECBreOgYu6y/A8A3g65/4ex96h6o3MGHitZFCjSheHvQ
 GiYFvxfG/+JBLAgLNla8F4FTNJqCqXd6fr4aEH0QVfFjpXIeprkvCvBB+6WjdcdjtR/e
 csKQ4oN8biDX1CAy4276KWX1/4Saf4ZGkq7t2u0rJ29EExmm43kaStU9OwPmecU8T7kn
 FA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748874287; x=1749479087;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAraLD0O99qqVbCM0WzQeauqLQGFXXrsIpxYuOivrn8=;
 b=UED5rC/gFbN4SyXGx10tnpxd9OztKZRF4uCI+vBVNzB0OqYN3PyqBhZ78APaUKuUSs
 ALPJGbbje0ME4eXzZNSr7F9uWwDjue18z561gNszOGr+sSxH94RSztmVittUGH3umDM8
 IPcmyHbhyAP+/4zRccrINv1AddQXiTHyZCeH3stykgLJShyBj+kvJifvKJV6HJpaIWUm
 Vcwj+k914/BYB2IkmJMeUrag3Muj7z6uDUvJVFvl1o/nHjeMJhqfsEr48KqonO48WkHm
 fiwq7MEFa01so5NGvaRSXjH0g7/4Fu9XfFr3iXUOWIXJRB8qfRFIZnSyxQf9FXLtqPfM
 Sgwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU19eTL4mfjYrPjVP1ZlKkq+l1CIIQUo9r5MadU0oL+6qRCy4gCmyistkYD+UyN5hPyLuWWIracwXEp@nongnu.org
X-Gm-Message-State: AOJu0YyPz4lgy3C46A/OIwNoN6Ff5Xkgh8c1DCEVGMzxnDhd2jneb40b
 ayLHN5NlUkLMpwLOm81mz/xmXimI+5wEwHsd4zcxJ5QWZmsnVsRbs3uebwuX04Ad
X-Gm-Gg: ASbGncvgFy+uhfYvfNOsCa5UDacCLpJhoSjmr76YUJJDAhjBMAleRJorWtlpZSIb7W3
 KwjD6OMxLGAPm3uAec79vwaEEv/Nn8IN5meFqKTXbsdTZxqqBYyS3ayQXX4KQJCJQ7GgdBmm6Lr
 sLfOp+c8sXTrvhN7cKx4ztNowv3Il0Jp7UouMGEhzbSt+tkg6WI5gDpci/PXK2+koa0JeAAS/H7
 Aueju2IdQN7cUDWT2G3oIcx/nvri0f4eD6TZp9UVaoxH8Pgm1/GG3TWQlDh7NmSzgvNOcQ5YW5F
 V2QLHjcrlr8jJ9k4TavV6960Bc2z6zbk4DY+uZbBheoCunB1AYGfw4OBSJQB2EBWeTxMAdxRko5
 pEkNP76vnpxXQR0EVtr8r5ozb
X-Google-Smtp-Source: AGHT+IHpDEl0SzqQf20EKbGho4yBizZsyyl2rJaYobDUAFB5Qv83yDcEfTWqDuE9bTXHRGOoAesgbA==
X-Received: by 2002:a17:902:ea0f:b0:234:df51:d16c with SMTP id
 d9443c01a7336-2353961befdmr178747995ad.45.1748874287545; 
 Mon, 02 Jun 2025 07:24:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cd8f9esm71080525ad.142.2025.06.02.07.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 07:24:46 -0700 (PDT)
Message-ID: <1301bf7e-0e52-43c0-9910-55ea34647a34@roeck-us.net>
Date: Mon, 2 Jun 2025 07:24:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is anybody still using the "highbank" or "midway" QEMU machines?
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <7aae8238-f7f4-4f3a-9a7e-e9afc99d1d0c@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <7aae8238-f7f4-4f3a-9a7e-e9afc99d1d0c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/30/25 07:23, Thomas Huth wrote:
> 
>   Hi Guenter et al.,
> 
> I was trying to create a functional test for the "highbank" and "midway" arm machines of QEMU, and only succeeded after lots of trial and error to boot something on the "highbank" machine. Peter mentioned on IRC that he also does not test these machines by default, so we started wondering whether anybody is still using these machines? If not, we should maybe start the deprecation process for those instead?
> 
>   Thomas
> 

I don't try to boot midway anymore. Commit log shows:

     midway only works with an antique version of qemu. Stop testing it.

That was back in 2021. The log shows that it needs qemu v3.0.

I only test highbank manually (not in automated tests). I have this in my code:

     # highbank boots with updated (local version of) qemu,
     # but generates warnings to the console due to ignored SMC calls.

I have not run the manual test for ages, so I have no idea if it still works.
It also looks like I removed the local changes. Those were needed to enable basic
SMC support for highbank; maybe similar code is now upstream.

Ok for me to remove both. Not worth the trouble.

Guenter


