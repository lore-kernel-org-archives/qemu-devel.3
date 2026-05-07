Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5D2CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 08:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKthc-0003fo-Ax; Thu, 07 May 2026 04:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKthR-0003f7-GF
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKthP-0004be-EY
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778140989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y1Cb/E1eqc+3IAf+iiXZxeWCZcb6PIHN8MgEpgDs54U=;
 b=Cf5RPfiQ073vPB7junuMfefqaHOrej0dJPXddnDk0BcAzOXJdBvUKgbtMgiCzKvP0vsKjp
 Gf6AL37sZT6yXslY5wetnKeyuL8NdkRLoAvf+Q7O4FhbvPGtimEUNCSNYHVm9WPeXF5fD2
 NbYMV35b1MyNbVP7XitL8PGw+JVrtOo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-DNFplHq5NEOxa9jzQp7TxA-1; Thu, 07 May 2026 04:03:08 -0400
X-MC-Unique: DNFplHq5NEOxa9jzQp7TxA-1
X-Mimecast-MFC-AGG-ID: DNFplHq5NEOxa9jzQp7TxA_1778140987
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48a5952c635so5229635e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 01:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778140987; x=1778745787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Y1Cb/E1eqc+3IAf+iiXZxeWCZcb6PIHN8MgEpgDs54U=;
 b=phv1IpyZQzHuM8FIQUoeNIIs9/o1VMGzpUOc+bzE+M3Aeg9ZpRpJcN+I+JpedwBoIx
 jaPX7Fjrk8ftMiFZqzh9dCtnXSNaJtaJUDoRkqMuCP33HpOT7F93usVDGDgOwqv4T35q
 J92MVIcfwRCDH//8LLZQBhhtPPBiU6wl8YSY+mVtBqkh7Rf1l6njKQgeaKWhQ47Dfrq+
 5/myQMQGww32VlzFewgqdSyFACSNQ5E4Z9x4207FhEoTtv/yztNinllYnQFa23MYlERQ
 u9RKYkyUYfEBqKTFiAiJZPki5dwO7Yl7EMexU8Ecw1kFoYAq0wwrHTcEG9abIcP4D5UQ
 hRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778140987; x=1778745787;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1Cb/E1eqc+3IAf+iiXZxeWCZcb6PIHN8MgEpgDs54U=;
 b=OSwVAkWwkPWvMfHv8/8DapDBAR5RaDFJrQabnlKaJMi7pgVTLDWjKtDmiCpEAG0FpK
 z+pDAJGs3mfLXjnun5vvDyK5D5aPLp3x+5ZVRsEzU3i6ztIAaYhmpt2fpCtfUviyrQ9O
 cWE0BfVsKEGpTiZjgpYJRecijxJqvnnL7rY3TgctL79cQUWhFHuQv6RkOctpTbR/a+6R
 NKiDz8Qk1MV+fsD3Fk4BJ1rOb2ETBpQmTqzo3YmGNB2eY0UzKFEe1qj9FsfXCFtImOgY
 z45ovtp1URDPRVkQ3rHK/O5/dx3+BMUxK05gPgDQPNmBCZ8EAgD4WONfjNIH+5Usbwqy
 m1YQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HOlN0zd32k55DjXaj0U9iVOYkmv2zwkFcxLATYIscDFF7IY3QFMu80QSyWyixfkXO3urwkNwvA/K5@nongnu.org
X-Gm-Message-State: AOJu0YxqIv4m7v9tpyKUbIzZmd60Oto3M/WFBAlaTQPeEczc3p8cf88s
 8Dhn9cAd0YS5OVtI/Jme1VV+f6wppmVK/HzQQBhaHMfRmzN2EgyTFmsfdqdebpfkIDtJNkGMDUu
 l/2oRvtMhXIWhiFmMH0/x6IHH8JPK0sLJKfCAyQifjAEmTRnMSzkccZa/
X-Gm-Gg: AeBDietr7wtAr827rmaLZ+n60FhBTT2FNp5T8LPzh7xvAsKVWhlKGHLBCgdbkHf64Bj
 ZIfUXl1jpDw8+1u7aGFYTKvg+kO+N+EhstfZVPGDytZc6dEDHDs1BcvTjQKm/hrhPkuatRBYWva
 AafF2V75u1OVmMofDpwPnEQJtX90RdtywIItjtWtiOF3ou1ktfjYJH3EDYSDa2Fkn+VPX/Lz4wh
 XBoxL/z39gF0iorWK1UMFEZbDDiCnIePMuO+xFbg+cAm4HovXRP9u7DJAZDviO2KEHKM92jnbF+
 x2W4RU+oJIXU7Y0zPLlzJuTRmN6LmyzrRiXTu8ya4gX4ky/hPq7S7PkM4nl8Fu16SYQcPL4E2c4
 gK3z6LfcqZUIxfJKs7ay7xlaBxjd24xZG4s0Ctc7qNU2EZ3Q3LTKQqO4peq7E87NCkrSwa3M=
X-Received: by 2002:a05:600c:a08b:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-48e51f4119bmr109428875e9.21.1778140986725; 
 Thu, 07 May 2026 01:03:06 -0700 (PDT)
X-Received: by 2002:a05:600c:a08b:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-48e51f4119bmr109428055e9.21.1778140986181; 
 Thu, 07 May 2026 01:03:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530b21e1sm36514915e9.6.2026.05.07.01.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 01:03:05 -0700 (PDT)
Message-ID: <c439b516-b8f2-49de-907c-9dfa2edd9e2e@redhat.com>
Date: Thu, 7 May 2026 10:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] migration: Propagate errors in
 migration_completion_precopy()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-4-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260505081423.28326-4-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/5/26 10:14, Avihai Horon wrote:
> migration_completion_precopy() doesn't propagate errors to migration
> core which leads to error information loss. Fix that.
> 
> This prepares for a follow-up where migration_switchover_start() can
> fail on switchover-ack and still report a useful error. Errors from
> qemu_savevm_state_complete_precopy() are not propagated yet as it
> requires more plumbing.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   migration/migration.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 6fd89995a2..a5c7ca6796 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2780,23 +2780,28 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
>   static int migration_completion_precopy(MigrationState *s)
>   {
>       int ret;
> +    Error *local_err = NULL;
>   
>       bql_lock();
>   
>       if (!migrate_mode_is_cpr()) {
>           ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>           if (ret < 0) {
> +            error_setg_errno(&local_err, -ret, "Failed to stop the VM");
>               goto out_unlock;
>           }
>       }
>   
> -    if (!migration_switchover_start(s, NULL)) {
> +    if (!migration_switchover_start(s, &local_err)) {
>           ret = -EFAULT;
>           goto out_unlock;
>       }
>   
>       ret = qemu_savevm_state_complete_precopy(s);
>   out_unlock:
> +    if (local_err) {
> +        migrate_error_propagate(s, local_err);
> +    }
>       bql_unlock();
>       return ret;
>   }

Instead, I would modify migration_completion_precopy() to use the Error
variable in migration_completion() :

   static void migration_completion(MigrationState *s)
   {
       int ret = 0;
       Error *local_err = NULL;

       if (s->state == MIGRATION_STATUS_ACTIVE) {
           ret = migration_completion_precopy(s);

       ...

Thanks,

C.



