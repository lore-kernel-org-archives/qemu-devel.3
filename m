Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826EDEE36AE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 17:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqaEe-00059o-Fz; Thu, 12 Feb 2026 12:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqaEc-000590-Hi
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:12:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqaEa-0001Lj-I1
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770916327;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PzN1WE3GD0GND6zNm9NxG5NxpCZo4KC1G3L4q0sgVp4=;
 b=H3yhk803S+3mKVbpsN6DHwDNwrj9Czf8twzhVVS1OhfBSh+uBrmovkaHb+rx6tlaK+PW5r
 37oWbFq+IY4z0jsJyqRD+3GEsNTRr9LRUYQUfnHYQBTqZ19g163z8szJqeQ8ElUSGumyH7
 5Szyi/D/AnwCZoa6JBVCRepRMon9IWA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-gl3t41miOr-DDGCDgUhcgg-1; Thu, 12 Feb 2026 12:12:06 -0500
X-MC-Unique: gl3t41miOr-DDGCDgUhcgg-1
X-Mimecast-MFC-AGG-ID: gl3t41miOr-DDGCDgUhcgg_1770916325
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-435add03f12so59193f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 09:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770916325; x=1771521125;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PzN1WE3GD0GND6zNm9NxG5NxpCZo4KC1G3L4q0sgVp4=;
 b=hxSf4iSiueQdqyCoXljOTR9syEhg1yaePI/XxV+xDy7nfRwvrZN/YRVKSQtqrQV2st
 +Pb6GRYoVPORinaREermxoyePsNnfjfrw/kUW8IVNlN9iChpJ+AOFq+bKoQLrjy+Mpiw
 fjCw2qa4/JTzTwm1q1CqdiGt5B6wz0RpgqmxGC7QvBK86qbUIMmmhNad0A9KGiwKHhmS
 ScHjRoW2hG31vHRcniKZkV0wcMx4CCI8R+LGqwWeMhLqoLFVecTjX1NBb6C0Dsiag4Rp
 IOThyeTGsdPHwGVoLNxbdoA8xuiILWMOROgu4ZkoJ19DPhfzOweYLf5aDZSgZ0yS0xDX
 gSMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv0TQsmq6I0dIYXPRWjvuG6kRu4REsOA9iwv24KQv1ZROjxcOr5isj8D1MmatIZDEk3JzoHGOR7oSd@nongnu.org
X-Gm-Message-State: AOJu0YyBCvRjOO/X+qvSsglAaeKCrJ2LHotNYBhdXFL7qspHmswkpXyV
 s/OIBjbEEpHlvux5eUZk1rkhm1llYKDW2lsprVi4p9eT7ltKXOE/JmqZzRgvmHhdYv+LMAad7nr
 1OysDzrNVzN0oaBngrTKG9WmDLCP7ytpBAoffjdW9iGwJ2/5uVpxMq5gi
X-Gm-Gg: AZuq6aJcRwZYVqPFGXTjqP+supt3k/+cPGnmBSkjI/jC82EygVjDOhDOBMIYHZcXfTC
 SGIQF+shEw++ky9chD6Mz4Xl17+asEI7iX62FqA4chR+fmKwGRTpN54oLizDmhjACbLk/9irc6J
 ypkb4BSLUGuo2ZJSALNs3WW2Z1H+PAdYNhnz9c5oLXmKd2al2rkw6Cn3c94DlJAJrwjhp4Hg4Pc
 O23bsQWYQTBntGv7wNR6nN3wjNCS2dNSQeXWHMeZuwvxxVwMeusiXBU+lXYk7/7KfS94IUV42yy
 NAwikfvKjIEOKHoWyryXObCRpzdsy9z5faXBtJghEMAHXsZNAD5S1f1LfPyhpO7OUKGsTdhLOZE
 2K1wQZdBLF0nBmc1hnPDNkL4EmDM8kExItvxA4Sp0EPpXCKsPcPlc1uVvxMiQja2TJsn60Q==
X-Received: by 2002:a05:6000:2901:b0:435:b7ca:7521 with SMTP id
 ffacd0b85a97d-4378aa0cd4fmr6499198f8f.15.1770916324870; 
 Thu, 12 Feb 2026 09:12:04 -0800 (PST)
X-Received: by 2002:a05:6000:2901:b0:435:b7ca:7521 with SMTP id
 ffacd0b85a97d-4378aa0cd4fmr6499147f8f.15.1770916324440; 
 Thu, 12 Feb 2026 09:12:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d46ec6sm13514876f8f.9.2026.02.12.09.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 09:12:03 -0800 (PST)
Message-ID: <db4a1b89-aae2-4328-98b1-5233283e9351@redhat.com>
Date: Thu, 12 Feb 2026 18:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-4-skolothumtho@nvidia.com>
 <aYzFeMh1szhJlJJk@Asurada-Nvidia>
 <e66e82d6-0953-49f0-9d84-bf2776e8f3ce@redhat.com>
 <aYzJhEFg/zxtrJ8z@Asurada-Nvidia>
 <CH3PR12MB754855AE35A087B900B0C311AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aYzTUDmTzIZZCwnW@Asurada-Nvidia>
 <39acf072-3227-442b-acfe-658829071917@redhat.com>
 <aY14rcVQuLs3ugll@Asurada-Nvidia>
 <CH3PR12MB75482F20A549CD3D480226E4AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB75482F20A549CD3D480226E4AB60A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/12/26 5:28 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: 12 February 2026 06:52
>> To: Eric Auger <eric.auger@redhat.com>
>> Cc: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org; peter.maydell@linaro.org;
>> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> Jiandi An <jan@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
>> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
>> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: Re: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
>> accelerated SMMUv3 devices
>>
> ...
>>> Usually error_append_hint() is used to append a user friendly msg that
>>> helps the user to fix the problem.
>>> In qapi/error.h there is an example that relates to "Receive and
>>> accumulate multiple errors (first one wins):" by using
>>> error_propagate()
>> I didn't look very closely but just run a grep for "append" :)
>>
>> Yea, I think error_propagate() should work better.
> I am not sure error_propagate makes things better though.
>
> If I am not wrong, this is how the change will look like,
>
> static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>                                 uint64_t data, MemTxAttrs attrs)
>  {
> +    Error *err = NULL;
>      Error *local_err = NULL;
>
>      switch (offset) {
> @@ -1614,9 +1616,15 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          s->cr0ack = data & ~SMMU_CR0_RESERVED;
>          /* in case the command queue has been enabled */
>          smmuv3_cmdq_consume(s, &local_err);
> +        if (local_err) {
> +            error_propagate(&err, local_err);
> +            local_err = NULL;
> +        }
>          /* Allocate vEVENTQ if EventQ is enabled and a vIOMMU is available */
> -        if (local_err == NULL) {
> -            smmuv3_accel_alloc_veventq(s, &local_err);
> +        smmuv3_accel_alloc_veventq(s, &local_err);
> +        if (local_err) {
> +            error_propagate(&err, local_err);
> +            local_err = NULL;
>          }
>          break;
>      case A_CR1:
> @@ -1724,8 +1732,8 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          break;
>      }
>
> -    if (local_err) {
> -        error_report_err(local_err);
> +    if (err) {
> +        error_report_err(err);
>      }
>      return MEMTX_OK;
>  }
>
> And error_propagate() only will keep the first error.
>
> Instead, if we do below:
>
> @@ -1614,10 +1615,12 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          s->cr0ack = data & ~SMMU_CR0_RESERVED;
>          /* in case the command queue has been enabled */
>          smmuv3_cmdq_consume(s, &local_err);
> -        /* Allocate vEVENTQ if EventQ is enabled and a vIOMMU is available */
> -        if (local_err == NULL) {
> -            smmuv3_accel_alloc_veventq(s, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            local_err = NULL;
>          }
> +        /* Allocate vEVENTQ if EventQ is enabled and a vIOMMU is available */
> +        smmuv3_accel_alloc_veventq(s, &local_err);
>          break;

If you want to accumulate, why don't you use the example in qapi/error.h:

 * Receive and accumulate multiple errors (first one wins):
 *     Error *err = NULL, *local_err = NULL;
 *     foo(arg, &err);
 *     bar(arg, &local_err);
 *     error_propagate(&err, local_err);
 *     if (err) {
 *         handle the error...
 *     }
 *
 
Eric
>
> This will report errors from both paths.
>
> Please let me know if there is a better way.
>
> Thanks,
> Shameer
>


