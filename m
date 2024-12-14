Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4535E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 06:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMLKD-0007jI-By; Sat, 14 Dec 2024 01:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMLKB-0007j5-BJ
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 01:08:23 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMLK9-0007aL-8x
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 01:08:23 -0500
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so4508571a12.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 22:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734156499; x=1734761299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6k2K2odY24JB8hiSPsvM5/9yTaXV+mLJf6dfE0gNcCc=;
 b=myH+h806oWjqLVPWNkXvH69/dG3XEb5THC+WtKUKA7Q3HxZsVS/6QaRIC61mSJj7/n
 /utvpMLpK6rqbLq5yeF0FSCpbmYkxuSn7rheW4LfbKS6544zbRvG+KN/KWJcGKDO6GlO
 BhDOVWgvotxwWHZ1xTcVmcozuGrw+4PEe0L1oYXH+BQAccPOmZLpCpGo5bUIwqkIejtc
 I3jvPNWtixtpDgbWs9/gO9jfV33OikZIhjBAFlX/jTaoS616Bhel+h1EUUAJ6/fRthxo
 cTTcU0YilgTitljrM77PQyL/1SXwD0RSzAZKTeKidzi8h3ks4slkZEtWsngU+OQhMynC
 L2mw==
X-Gm-Message-State: AOJu0YyXwl6B1ScjU6iyKrghBUyu9JbAJutMycwt99qLmE0eX0oWvzuQ
 QZUOuhXjPqB10TzXDg9PB4hjas4Q9r3dbtYoyOMZvJ/oGyIvS4C2Q7yrQQ==
X-Gm-Gg: ASbGnct/XYm+OIwEi+GCg4Yj1CVwo5PFRrdf2fTcYaASp/i+q0MMy52LLeE2uJs28xd
 sEucmrkuNZ8/+aB0ttiLE+/PlCc04ecK3CGub4PE3O1FJ4rM/jMDgM9Hoh+nNiLxAZpE2rL9/Zn
 hG4w0YIQSR13bK0+SkMIErB6aN66VnUwKN+tKNNPmI+hHzwlsm9AE5OTMy8LD8POjcXYbZsw4z5
 dT0gZehvNZn+Pl2ze+RT4S6aVYcS4ZqMHq2k776fdISAQM7zG+CwB4Cz7CAsy0QTBy0jQgd5AV8
X-Google-Smtp-Source: AGHT+IGhi/NEUvFxHa6O7d0/kOzlQJWdI43c++sB/AAU34s/PB6z4RxndaqUUD9BpgBeW9O/p70RbA==
X-Received: by 2002:a05:6402:4494:b0:5d2:2768:4f10 with SMTP id
 4fb4d7f45d1cf-5d63c320dedmr4980825a12.17.1734156499069; 
 Fri, 13 Dec 2024 22:08:19 -0800 (PST)
Received: from tpx1 (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652ab50cfsm608936a12.12.2024.12.13.22.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 22:08:18 -0800 (PST)
Date: Sat, 14 Dec 2024 07:08:15 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 25/34] next-cube: QOMify NeXTRTC
Message-ID: <20241214070815.1fc6c597@tpx1>
In-Reply-To: <20241212114620.549285-26-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-26-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.54; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f54.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Thu, 12 Dec 2024 11:46:11 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> This is to allow the RTC functionality to be maintained within its own separate
> device rather than as part of the next-pc device.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 71 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 50 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 9c91ee146a..c947af65e2 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
...
> @@ -1078,6 +1115,12 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
>      }
>      sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(dev, NEXT_SCC_I));
>      sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(dev, NEXT_SCC_DMA_I));
> +
> +    /* RTC */
> +    d = DEVICE(object_resolve_path_component(OBJECT(dev), "rtc"));
> +    if (!sysbus_realize(SYS_BUS_DEVICE(d), errp)) {
> +        return;
> +    }
>  }

Would it be easier to directly use s->rtc instead of taking the detour via
object_resolve_path_component?

 Thomas

