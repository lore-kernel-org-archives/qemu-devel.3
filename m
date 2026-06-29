Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D2AC43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCaP-0005rM-7s; Mon, 29 Jun 2026 10:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1weCa8-0005k2-P0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1weCa7-0000yO-9d
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782741806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89vgmoIDNI6gFhaNxYzIx4OgW9TYHX5IZ9h7MjVh3o4=;
 b=eAggyG4CeGyEEbZjwZDM36HrgnSpvYZp2jHvv8FDjx16Bg4gw/EHgqXDJ7SxZvqt8Mahw8
 OjnSGs3lJB2M9FMcyr1cxJhjHcCw15mdh1qXhpqW8uT7wNkWXkM964Bm3DYa1MBmP26nmF
 W1mdjxK/uFpaS22DSJfhQ4lMQlng5Ig=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-xfYT9gBBMmmje5w_sOXipw-1; Mon, 29 Jun 2026 10:03:22 -0400
X-MC-Unique: xfYT9gBBMmmje5w_sOXipw-1
X-Mimecast-MFC-AGG-ID: xfYT9gBBMmmje5w_sOXipw_1782741802
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c1215680359so304977666b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782741801; x=1783346601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=89vgmoIDNI6gFhaNxYzIx4OgW9TYHX5IZ9h7MjVh3o4=;
 b=IZrs1SqFp22tuj40h6eSXZnDTZ8MD7mnbyqXOOklq9tlVd6PvFAZf6bittAN/cdSO+
 9DZ+Zvyme/I6XL/9F7QY81mvdpABKXgSitytA12G9U5zLjEVFpucTq2vjYslIxwW8mur
 2+dSGVJ/S1iPLVEh64knVI92c75Pz5q0fHbZy428L0t/2AJJQXtUev2zVT+1UGLhdgZ/
 EX/XL4OninabS2ChxtIT2zfJAB7CK54boqmqXo2Szi0ScDwLl4Lw/2rkCpAW2cmmz1il
 ZTmyX6kC8l0ihuhWJ9HHagFLyoYBN64BQDe1CX31FV2bNvsQInNWQrBxeCoF7fRa5VET
 hyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782741801; x=1783346601;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=89vgmoIDNI6gFhaNxYzIx4OgW9TYHX5IZ9h7MjVh3o4=;
 b=b3lF7fc2cJWaHJv1ODppRQAMF3mXiXXtqT31zvWwQ4S+9mvwUOOrteu0PdgfqYkK6K
 sTD0UmN95vsobsSkNdD/U0TH31LGSmFnGL+5HXCVGvTqf/w2UfSsouobLaS9Cd5Ga1vE
 qU33bdCSBImgwgGdUnba8jq2yljEtVoRvX7NyHmpfbEAzryWjAj3WKtDdTLacEW83Zhl
 n7TVaiB1eukF3NoP0VYYY8DmILVoG68N6+IBOw5BrOUGdqFxgOUFbzk/+hH8Fs5Ms0ys
 tRTGtBa5JIhAAFgEcbsi7m12ErsI3t6i67KEzuWf0FSNpLwfn6jmoHcB3YtL40pS7itx
 rAxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpoSDN6aN5oywguNKtQM89PnzC/bIn1j9hJPV8eIXRBaL5WtTFkXWcdIVL6iOtgQgwv6/1kN5DVT7FH@nongnu.org
X-Gm-Message-State: AOJu0Yzv+gHviMgvRt+vJQyYSe8rKXnc8B21hadP+larYGh3yatIRlwI
 6wxXUEU/9eAev6NxUOgpOV2M40sWVPWWnPgUUrOvtpKcbr9H8+/Aqvf4duToomdtjTdC6DpaReU
 5BYWoLFtbIAu2a7nHXYJ2v46WYIrna9Mh/XkT4dNHCA0zmnf04SrTmrnJ
X-Gm-Gg: AfdE7cmRR2bTzpIVduybc2rH347jTAYwV32ezOJPp3NbTWoEBBAL+yQnpL2Jz8c14Kf
 14ebDc+bOaz1eGQJfpgtShjoKGGbzdUcBz6MWxUeqsHYcO/ZtdkpBhoH2O20ctrm197FXzqIdSf
 BXjexBklaxCvIJIMTE8VOCVvUOCacQzaOHUoXa/eyhA4KeuGqpaGAM7zC7Ujz8BC5MRBReqwPPG
 pO6iggGr7AM7EJ2zKfPnlPQbPXdTfSZVRPkgf25Sp3b5upbMy1JRLqFp4xXBomWP8xxdAWdS8IL
 9I6kL2vURv+4Ee5GUPCHRyaTqITYY2ywzYZdb9m5lBqyWHva+fFXXfoyUCURO0IMMcGVe9TuhGk
 bYljs66Ul9yDA/mu6kmWbTB49IaoZn3A8il7hfpWPRfkr3r4VRPe21A==
X-Received: by 2002:a17:907:1ca4:b0:c12:7418:729b with SMTP id
 a640c23a62f3a-c1274187cf2mr126354666b.14.1782741801388; 
 Mon, 29 Jun 2026 07:03:21 -0700 (PDT)
X-Received: by 2002:a17:907:1ca4:b0:c12:7418:729b with SMTP id
 a640c23a62f3a-c1274187cf2mr126352566b.14.1782741800839; 
 Mon, 29 Jun 2026 07:03:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12239d9268sm550574166b.61.2026.06.29.07.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 07:03:20 -0700 (PDT)
Message-ID: <6c609613-8f32-43df-aac4-790abf2357ad@redhat.com>
Date: Mon, 29 Jun 2026 16:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] sbsa-gwdt: move all foo_REFRESH logic under
 REFRESH condition
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 rad@semihalf.com, leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
References: <20260624102830.1355552-1-imammedo@redhat.com>
 <20260624102830.1355552-16-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260624102830.1355552-16-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Igor,

On 6/24/26 12:28 PM, Igor Mammedov wrote:
> No functional change, just code reorganization to
> prepare for direct WCV load support in the next commit.
> 
> While at it, simplify timeout calculations
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/watchdog/sbsa_gwdt.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> index 6113dcd077..5ee0e06af5 100644
> --- a/hw/watchdog/sbsa_gwdt.c
> +++ b/hw/watchdog/sbsa_gwdt.c
> @@ -109,22 +109,18 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
>          return;
>      }
>  
> -    /*
> -     * Extract the upper 16 bits from woru & 32 bits from worl
> -     * registers to construct the 48 bit offset value
> -     */
> -    timeout = s->woru;
> -    timeout <<= 32;
> -    timeout |= s->worl;
> -    timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, s->freq);
> -    timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -
>      if ((rtype == EXPLICIT_REFRESH) || ((rtype == TIMEOUT_REFRESH) &&
>              (!(s->wcs & SBSA_GWDT_WCS_WS0)))) {
> +        uint64_t offset = (uint64_t)s->woru << 32 | s->worl;
missing extra empty line (or is it no more requested?)
> +        timeout = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                      muldiv64(offset, NANOSECONDS_PER_SECOND, s->freq);
> +
>          /* store the current timeout value into compare registers */
>          s->wcvu = timeout >> 32;
>          s->wcvl = timeout;
>      }
> +
> +    timeout = (uint64_t)s->wcvu << 32 | s->wcvl;
>      timer_mod(s->timer, timeout);
wouldn't it be simpler and functionally correct to call timer_del only
in case of !(s->wcs & SBSA_GWDT_WCS_EN) or actual refresh and let it
live otherwise?

Thanks

Eric
>  }
>  


