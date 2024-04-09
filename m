Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54233C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 10:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru8b2-0000q3-TQ; Tue, 09 Apr 2024 06:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1ru8az-0000po-AL
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:20:53 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1ru8ax-0005Iy-7r
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:20:53 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-516d3776334so5436728e87.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 03:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1712658047; x=1713262847; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6vi3mXNPAtFhRZ7VRL4VAPHciBEA8X0AtAtcbaG6HHM=;
 b=EtodnypS+ljQt3H38T1Y0zd0XJy9r75SOPszxk+wAOKukWG+9kjeH6JcDukEzOerhb
 0VhYjq8XQ66Zgvdg6qNowuBbPOR4rj/3xRhtZkbO0THas4IESnbuNS8LglHMzKAx3j/Q
 dmCRs65wyoBGVONwM9CZ4QKZQV6L5i9XohSHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712658047; x=1713262847;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vi3mXNPAtFhRZ7VRL4VAPHciBEA8X0AtAtcbaG6HHM=;
 b=FkwFvmwj23I86S9w7nAkb2aSqpNm8dIHPHtWxjZcgEmhht+RYsYvFkmbKa7Bli9+Mp
 6bBlY/y3guGCw7xzLkoXvykKI7OAYid5evcbv9r6JhQaHHTqq0u5+741sy4uE+t+hmjU
 RN6Ognh+o2tefOYOQz7G5Tsk6Zo8KQFVOFaJi4ThU3v2p5VpgK21MXYvZj8aMWgvZpjr
 GUpgEQsI1XyJ1pyvctvl8+bYw1fwk8cn7LPrxU5h9BM/r2v5tki6cjsxh91pvUCrucYq
 fpvxwkuJST5Kc2pthI01n3VU2Ywf5FK6T9zzm4694PwTCR2R8oF8HmBUAM/cZcy35KPR
 ytgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXksLu0VqqPsHufpJFzyPCYJFleHvL74aZdAC1tqh7hFQdlNvVlPtamEQjfww1jTSxdWac9slQp1hefPNv/Ab+iHUh7Xw=
X-Gm-Message-State: AOJu0Yw/XA1rDuTJmQg2nSsM5aqLUn0uyrNjfaNeqJy2ms9hWsQAVyxW
 6Wwp0ZWwIWlmWGQ15rzyd/K6UYtZsr5YTmBlxWLxsTmPmVCeahBTY9rDacJtpys=
X-Google-Smtp-Source: AGHT+IHaIpT9eyePhKlcsD5qHDIV8IJtmm5ucgNemPRD1+yysRCR0QTSHPLYSNTgt9iOxBdqVBzHAg==
X-Received: by 2002:ac2:48a4:0:b0:513:c95c:4dc4 with SMTP id
 u4-20020ac248a4000000b00513c95c4dc4mr7701691lfg.7.1712658046987; 
 Tue, 09 Apr 2024 03:20:46 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 be9-20020a05600c1e8900b004163ee3922csm11976111wmb.38.2024.04.09.03.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 03:20:46 -0700 (PDT)
Date: Tue, 9 Apr 2024 11:20:45 +0100
From: Anthony PERARD <anthony.perard@cloud.com>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] xen-hvm: Avoid livelock while handling buffered ioreqs
Message-ID: <90f07634-1600-4654-8e36-7ac9e2f457e8@perard>
References: <20240404140833.1557953-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404140833.1557953-1-ross.lagerwall@citrix.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=anthony.perard@cloud.com; helo=mail-lf1-x133.google.com
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

On Thu, Apr 04, 2024 at 03:08:33PM +0100, Ross Lagerwall wrote:
> diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> index 1627da739822..1116b3978938 100644
> --- a/hw/xen/xen-hvm-common.c
> +++ b/hw/xen/xen-hvm-common.c
> @@ -521,22 +521,30 @@ static bool handle_buffered_iopage(XenIOState *state)
[...]
>  
>  static void handle_buffered_io(void *opaque)
>  {
> +    unsigned int handled;
>      XenIOState *state = opaque;
>  
> -    if (handle_buffered_iopage(state)) {
> +    handled = handle_buffered_iopage(state);
> +    if (handled >= IOREQ_BUFFER_SLOT_NUM) {
> +        /* We handled a full page of ioreqs. Schedule a timer to continue
> +         * processing while giving other stuff a chance to run.
> +         */

./scripts/checkpatch.pl report a style issue here:
    WARNING: Block comments use a leading /* on a separate line

I can try to remember to fix that on commit.

>          timer_mod(state->buffered_io_timer,
> -                BUFFER_IO_MAX_DELAY + qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
> -    } else {
> +                qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
> +    } else if (handled == 0) {

Just curious, why did you check for `handled == 0` here instead of
`handled != 0`? That would have avoided to invert the last 2 cases, and
the patch would just have introduce a new case without changing the
order of the existing ones. But not that important I guess.

>          timer_del(state->buffered_io_timer);
>          qemu_xen_evtchn_unmask(state->xce_handle, state->bufioreq_local_port);
> +    } else {
> +        timer_mod(state->buffered_io_timer,
> +                BUFFER_IO_MAX_DELAY + qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
>      }
>  }

Cheers,

-- 
Anthony PERARD

