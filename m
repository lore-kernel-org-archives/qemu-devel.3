Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40F3CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjxt-00044p-K0; Wed, 17 Jun 2026 02:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wZjxo-00043v-4T
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wZjxm-0007q7-DX
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781678485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JBpFjUflSjpTZIiB5JbQM2AoqPQYTsnx1PEDFL66A1I=;
 b=ElxjXMIU2GzmIBlXyqqRH0l3rsFZAaoFY6dCY+S9W/GhjmDxg6rayhMJln+i9A6KKlqxix
 NzGLBoOgbfNjJmNQGRpPz3AaaLN+H/c1aDeYf/n69KKreEhEbMBWV34f08eOAtsPxwt8pD
 AUYDLp/9p0jjFgFuSFJfyklZ1EMjuWg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-NuaCIcoqPx-JExWxZ-U9sQ-1; Wed, 17 Jun 2026 02:41:21 -0400
X-MC-Unique: NuaCIcoqPx-JExWxZ-U9sQ-1
X-Mimecast-MFC-AGG-ID: NuaCIcoqPx-JExWxZ-U9sQ_1781678480
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b3f53c81so22960365e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781678480; x=1782283280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JBpFjUflSjpTZIiB5JbQM2AoqPQYTsnx1PEDFL66A1I=;
 b=FCuVUPotpxy1vjEh/5nLaBbzL4ZO6nEXVejethhy08r7PEllqniVD4CqvuGxw9WD0K
 oEOvg/1ukQK5eVhDbVp3CxUq60fbsVbOmnbi/CAGqRkLcg/xg6ZR+DXqfFsKxunF83jT
 RCcGGftgMFQYw81sMIoRzelvSSaTqy76GLW0+eK/9hfhpsVy+p6jvf/PBqXIV7H8f8wb
 iJGxEL8pT8ffLxOysHHlnL3rmxcsqYWDJfAD3wEskdsnUls0f2lxQkulhsfshEkl4UQd
 wuEyIglzos9bcXIjW606BeS6TP+chUmAffqBuFEqNDgyCV01f4Ou716o+Vm0Hsk9gpOw
 JfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781678480; x=1782283280;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBpFjUflSjpTZIiB5JbQM2AoqPQYTsnx1PEDFL66A1I=;
 b=gZdt9tRnkQpSWBJ7Z0LzTD7FXkyT16id5Js0wJ3Rp6eMsRW22g8W9ldQ1upppWBMvk
 vqWD5FERAV/x2ryEn68ntDP18dl6Rbw/+b2KBS8zlHdA87w5Z27u871pFHqLpUaQU1/C
 3E0t/GbNIZ+ITnhi934tXQhnXUUG8Jt6Ek9d74e5+1Fm4qZGHnD+oWCMIW06Rff+lU/D
 WA8Z6iAbZNVXi46QxrMS4E/HnELPf2F5+Ep2uDysjgcOlyl79yB1ibZCZ895a5zOlyhE
 R9l4+dVNP/Skqpi7dd885dahyuWC6woZ/bNkk3xxi6Z2XjfE/uTHmmTHw1n+m59R4IM4
 rWxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UF6ZuylYk3gHe6SGEcCjwcDGoPByxzDdpwJGdaBis05SE6sMQ+NJgak3YD/BviGMq588IEDjh3QbA@nongnu.org
X-Gm-Message-State: AOJu0YxmFbnsPbr5TCnGPDuGhDBzsRgOqzx1L88FwM+x32RxQo3x+Ypa
 oUxbtUXw/XrAELS0Tsneg7lB4nUD7OkXpApORZMi6PxRd3EizKDswR0ah+aMjdlw4Aw/MDlGOcx
 iyJSrMkkWsnUbkx8Mm/Ig76oM2n8AOaIsxd+3AmdyqS1UxVVovcML0zze
X-Gm-Gg: Acq92OHLpASfZ218fjTb54TO+iLUQBfyA1Awrj8fnoZS+9jqRqxAsFcoqwRc2H0axYs
 JVWZTG43RVDwUqO/NCThEWgF9Y56oRVpjfYQRY04FcDf6se1+sRtW+0cRXeR5bydc+TEIY0b53p
 QI5pI5R1T99WilpWvSH23cuWyuFxF85ZzSh2xl5yyXiBf4g/eQwn9KyOjIYtZtoubPoej+jCp5O
 y7A2pd9ADDUY83ogcN+6kW6s9SusMr/MWr2i6Ek56yF8j+oGrv8/PYN9eyl5cWizN+0teaH40Yc
 3350L+NQTQPStOLOeThbGKVzjLOj15x1rTjADBIFBrLY2MJ9qjYj4VItn50+Sr07l8BWZE5VNAz
 8kz7/438=
X-Received: by 2002:a05:600c:c113:b0:492:32f3:a344 with SMTP id
 5b1f17b1804b1-492333dd1efmr32618525e9.31.1781678480240; 
 Tue, 16 Jun 2026 23:41:20 -0700 (PDT)
X-Received: by 2002:a05:600c:c113:b0:492:32f3:a344 with SMTP id
 5b1f17b1804b1-492333dd1efmr32618035e9.31.1781678479822; 
 Tue, 16 Jun 2026 23:41:19 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm147724455e9.12.2026.06.16.23.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 23:41:19 -0700 (PDT)
Message-ID: <183d0ed6-fc14-426f-95af-4767ea65c0b2@redhat.com>
Date: Wed, 17 Jun 2026 08:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/aspeed: unify boot completion detection
 on 'login:' prompt
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Ed Tanous <etanous@nvidia.com>,
 William de Abreu Pinho <williamdapinho@gmail.com>
References: <20260617042718.2883655-1-clg@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260617042718.2883655-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 17/06/2026 06.27, Cédric Le Goater wrote:
> The boot completion check in AspeedTest waits for the systemd
> "Hostname set to" message, which occasionally causes intermittent test
> timeouts, e.g. on ast2500 SoC machines. The root cause seems to be
> console output interleaving of both systemd and the getty login
> process. This results in the expected pattern string being broken up.
> 
> Unify and simplify all boot completion checks by looking for the
> generic 'login:' substring in AspeedTest.wait_for_boot_complete().
> With the override gone, remove the redundant FacebookAspeedTest class
> and update the Anacapa, Bletchley, and Catalina tests to inherit
> directly from AspeedTest. Also drop the now-dead image_hostname
> parameter from do_test_arm_aspeed_openbmc().
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3117
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/arm/test_aspeed_anacapa.py   |  6 +++---
>   tests/functional/arm/test_aspeed_bletchley.py |  6 +++---
>   tests/functional/arm/test_aspeed_catalina.py  |  6 +++---
>   .../arm/test_aspeed_gb200nvl_bmc.py           |  3 +--
>   tests/functional/aspeed.py                    | 21 ++++---------------
>   5 files changed, 14 insertions(+), 28 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


