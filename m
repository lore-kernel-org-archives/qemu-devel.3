Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B098CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHqm-0004WW-Mj; Wed, 24 Jun 2026 03:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcHqk-0004W8-Sc
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcHqj-0004bO-D7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782285400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hQ/vGf0qXdW11TwKepvfckc2LrAvE+KdMl1iHL+v9ls=;
 b=ZPggu2qIjorGQv1l8l0P5DsHWL6e5MGJwBGRsYdN/gWgHJMUIkXCfM/Z+w4Zr5mkcSgVy8
 SfEqA6ze93oTSmK5In6D1gIeZV8yT1oKhrvauKiMlVddDgO71GMUJyh+TO3kAvcYPeTi87
 NWttH+GhRHiFNbR0pS/PCsomQ8VDV50=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-0N0Pz03WPtmytyXEiSaGZA-1; Wed, 24 Jun 2026 03:16:39 -0400
X-MC-Unique: 0N0Pz03WPtmytyXEiSaGZA-1
X-Mimecast-MFC-AGG-ID: 0N0Pz03WPtmytyXEiSaGZA_1782285398
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-460129ef947so384424f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782285398; x=1782890198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hQ/vGf0qXdW11TwKepvfckc2LrAvE+KdMl1iHL+v9ls=;
 b=htd4oIKKuksN0HDywcfxFLH0Zt06Faul7qk6XagwY6TmagOjOK7lp+WDVoAGKk7xxJ
 ZtFVLvZANGUOOZOb24P8R0auCUvB29WhTmo10KpB68tS9Bi4xGIsdVB2tGIGzYGZw0wM
 t8y0aHRzifCxIf3U1U+4930IAzCAHziCfkN+cPEPxhluSm7JqCbzABI73FAciNa/wLxA
 bQQLb/zYg5KpD9egtqjNj/wypuf/PWwgVHpkn6pg9MAhJ941fc6uxad9fZpFyIxtF6tu
 q0QSjUvgYWO9UA1bfBBVTEGans+CgLh83YPnrLSM6ejK9fGg8a6IGAM6lIEIp+rgNmJS
 Rk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782285398; x=1782890198;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQ/vGf0qXdW11TwKepvfckc2LrAvE+KdMl1iHL+v9ls=;
 b=k0ykPpdyZidSYbwy1QiYX/Na63hVvQEY9G0RTegGDlK5+p39dwrvfT38Or7NYatD0/
 bTVvEMqeN/e2jzYY7SCX6OGpRwqyBuRmiv/ZJxjgAhwcb/i6jRBfPs0CThQY53E+FAEp
 z692BJyFy+H4eYiISNnX1F6nfAx0Y5+p9F3OiRy5bZImcIghujCmaR6TySpFSSD6EHiC
 Zqcsz+12DtR0jmQTq59gD4YY/RBDPo+7dHzJhr2QaAVp4urr/Jbh3MWKylgPHiNlKelx
 GfQQvfcnBOxeBu02kvnbVih4iGWt4iaOTLYJOR5+d+oCdpHjSmuTu95rv7QozHuZJDq4
 MQwg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1cPhCZYPF14h+87ZkrjvmvIvGVbeLfN4MXiCqTWEAy/C/mQpDRphOxA7J467/utZ36NohBda99ONb@nongnu.org
X-Gm-Message-State: AOJu0Yzlbj3LC2WHt+TZBu8bJ6S4tC10yrJ+lOM7r/Q2dNTeiTGHYk3O
 7L4B5cKID5FfpQDpm6h132ZQl6rT8shQ7+hM62nQ2l/mltC/JS2yNDT4mNxjvLmz/RtFikcY8xp
 HIQcsOe/6fjRSeu8bOGMzRPAypKSxKBtDJySCvwWil4eqBi/wMeqmyWr+
X-Gm-Gg: AfdE7cl0QeeETYbWguPCKLlwGthQ4YcmLZ2xR/aGh9uSuBwNI21ZTWwbfGOFX6/LycT
 O46M06Z4Qw1xHLhkOeaUGxiB/PGr9t09Npllty5HvVyxrvyauumVDMRc7yt7dhCYtScBbeUhveX
 rasYDOPNqQ0TarkWsqnl2QjqpBQBOoJcMEG0KSaCun+uZfxUOpsQVztX8IUAxHQEhcCtZexcf7i
 x/pNmdauIq9Rldem5PXG3MnVQRrynp+gZkYiUC/IzzOfrIIpTLD2at0YibfwAaoUuNmhVQQunSb
 eIpzmu4lyyy6h21uGp+mwx9dHWY8l5o69UXMv+0EzOJjXJKGAVbPc3L40J07rE6MNe6QHGT/iVc
 Hwl6fdcltEHROWMr2ONX5A0grLTMSL/k1KBnEAymnEWgplh9qXrL6YEM=
X-Received: by 2002:a05:6000:2992:20b0:452:c246:ab69 with SMTP id
 ffacd0b85a97d-46c04ff8f2amr2510951f8f.13.1782285397861; 
 Wed, 24 Jun 2026 00:16:37 -0700 (PDT)
X-Received: by 2002:a05:6000:2992:20b0:452:c246:ab69 with SMTP id
 ffacd0b85a97d-46c04ff8f2amr2510887f8f.13.1782285397334; 
 Wed, 24 Jun 2026 00:16:37 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6?
 ([2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01d51sm3267111f8f.15.2026.06.24.00.16.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 00:16:36 -0700 (PDT)
Message-ID: <3972d4ca-8a7c-4028-8743-bf6277299766@redhat.com>
Date: Wed, 24 Jun 2026 09:16:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] migration: Enable new switchover-ack
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
 <20260622101214.25770-15-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260622101214.25770-15-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/22/26 12:12, Avihai Horon wrote:
> Now that VFIO has implemented new switchover-ack, enable it for new
> machines and keep legacy behavior for old machines.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   hw/core/machine.c   | 1 +
>   migration/options.c | 3 +--
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 9a10e45aab..a4af779357 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -48,6 +48,7 @@ GlobalProperty hw_compat_11_0[] = {
>       { TYPE_ARM_SMMUV3, "ril", "on" },
>       { TYPE_ARM_SMMUV3, "ssidsize", "0" },
>       { TYPE_ARM_SMMUV3, "oas", "44" },
> +    { "migration", "switchover-ack-legacy", "on" },
>   };
>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>   
> diff --git a/migration/options.c b/migration/options.c
> index 4c9b25372e..dfce19405d 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -110,9 +110,8 @@ const Property migration_properties[] = {
>                        preempt_pre_7_2, false),
>       DEFINE_PROP_BOOL("multifd-clean-tls-termination", MigrationState,
>                        multifd_clean_tls_termination, true),
> -    /* Use legacy until VFIO implements new switchover-ack */
>       DEFINE_PROP_BOOL("switchover-ack-legacy", MigrationState,
> -                     switchover_ack_legacy, true),
> +                     switchover_ack_legacy, false),
>   
>       /* Migration parameters */
>       DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


