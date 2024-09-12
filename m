Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20734EE645B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soemy-0006wS-J2; Thu, 12 Sep 2024 04:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1soemu-0006ds-1I
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1soemr-00041o-9A
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726128163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJCCBAsy1yjL6s99J+14imn5GBc215lIAHWntNhCiQ4=;
 b=NN/9nE8IYophqsUeaKc67tZP7tH7K5OGQpsBVOOwSK3SDRwjfgHEmWg0F8rvK/RKZEdjed
 H+vQAB/lNwOM/J8wfEul16oy534P1Ug9OFU7EXj6iYanqpF61GyzUapsiJYgqJh9CBT+vm
 o07XH/s8zGs5+MQn/eXGrlhm/BiemA8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-BNUdrCyANmW0AUuluBhFdQ-1; Thu, 12 Sep 2024 04:02:40 -0400
X-MC-Unique: BNUdrCyANmW0AUuluBhFdQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb6dc3365so4844125e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 01:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726128160; x=1726732960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJCCBAsy1yjL6s99J+14imn5GBc215lIAHWntNhCiQ4=;
 b=mi6LUsjyHOOYTS3HFgXZN+qZDHiyrQ5PlrsTXWZUBU7cog2ZBdpp32UQZvTjSMTHgh
 2g7gC/nlbuk8/KqNOQD1QpoC6HMqLLBwpqeHTObVIb+HmS9+ODFHso0X6IOrMagpKOIb
 WEH5Ls/ZuIZzcS6YAGxwzBt9EPxoC24yge84Ay1Wb3zC5ufBS8Me5CSQgL7zHq/d69zJ
 Lgc1FhtK5IR16+R5ZgkBJ19vt87HNtvHW32x5no0MViGvBdiV+L8aSukRnb9Dz3jJDin
 vjUrT2b4gn27tJLWCB1UDZLyT229Wl2rCqkyT9Z1Coo7nwdZ4FzGp/zHtOi02ZDiC7ol
 l/3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsJMs/TFS/vacXIurmS8VVDhTxlk+IVIHU3ACaBCQvBoa2Cn28omGVs7z3iGNHpwJHtW+fbqpq0U+M@nongnu.org
X-Gm-Message-State: AOJu0Yxl3B+5tErLj39FM7nyEPcddNVhW1BvtRBxcudwdYw4O33DmyjO
 0YZHCSW6keVzI6ghKlrUBs4QDC212PAiY9J/qKcVh8DcYswjAx8xcMVQnk5drHrVPneLMGrfsgh
 6jUNNyCgYckWJI3V79w/JkMMipIe/bpMi4Ci4yRyYcSCuWww2xosT
X-Received: by 2002:a05:600c:511d:b0:42c:b62c:9f36 with SMTP id
 5b1f17b1804b1-42cdb5389e4mr14181105e9.5.1726128159718; 
 Thu, 12 Sep 2024 01:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEON90/FK9z91xoz/hl8qQv4UdLOeyoldJa5DD3joRha0AcFsGOMu+tz57qR5UM1pH1Hmui2w==
X-Received: by 2002:a05:600c:511d:b0:42c:b62c:9f36 with SMTP id
 5b1f17b1804b1-42cdb5389e4mr14180635e9.5.1726128159137; 
 Thu, 12 Sep 2024 01:02:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb32678sm163754975e9.16.2024.09.12.01.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 01:02:38 -0700 (PDT)
Message-ID: <fdd3f261-c2a5-49a7-b8ef-3e99287a0921@redhat.com>
Date: Thu, 12 Sep 2024 10:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 43/48] hw/ppc: remove return after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <lvivier@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>, WANG Xuerui <git@xen0n.name>,
 Halil Pasic <pasic@linux.ibm.com>, Rob Herring <robh@kernel.org>,
 Michael Rolnik <mrolnik@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Corey Minyard <minyard@acm.org>,
 Keith Busch <kbusch@kernel.org>, Thomas Huth <thuth@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-riscv@nongnu.org,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Helge Deller <deller@gmx.de>, Peter Xu <peterx@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Eric Farman <farman@linux.ibm.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Gibson <david@gibson.dropbear.id.au>, Fam Zheng <fam@euphon.net>,
 Weiwei Li <liwei1518@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
 <20240912073921.453203-44-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240912073921.453203-44-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/12/24 09:39, Pierrick Bouvier wrote:
> This patch is part of a series that moves towards a consistent use of
> g_assert_not_reached() rather than an ad hoc mix of different
> assertion mechanisms.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ppc/ppc.c          | 1 -
>   hw/ppc/spapr_events.c | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index e6fa5580c01..fde46194122 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -267,7 +267,6 @@ static void power9_set_irq(void *opaque, int pin, int level)
>           break;
>       default:
>           g_assert_not_reached();
> -        return;
>       }
>   }
>   
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 38ac1cb7866..4dbf8e2e2ef 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -646,7 +646,6 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
>            * that don't support them
>            */
>           g_assert_not_reached();
> -        return;
>       }
>   
>       if (hp_id == RTAS_LOG_V6_HP_ID_DRC_COUNT) {


