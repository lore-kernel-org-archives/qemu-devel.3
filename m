Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324C7C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsAw-00032P-Pj; Thu, 10 Jul 2025 10:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZryZ-0000gA-OD
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZryU-0004Jl-Kl
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752156607;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9bjJYpCH7ZfK0sawPwyP0TDIcWspMQNetqywwvCHqCc=;
 b=JI0qK3NQHqIc6ogpXFqXTRMdnLVXaYTKo5Mo1F+E0T2SDECG9mR3kaQc6xEu936XN2tl/M
 HZ82AR5sPneb8tPPy2eztyw6wPZSQjO+vx/alS7ySiLx/WrUwziqt96AZgpIc6qSggbUf3
 bcDhqBr4Z6j8UR5srSYJydReJqtfe0k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-81UPv23hP-O9j_e5RwbUqw-1; Thu, 10 Jul 2025 10:10:06 -0400
X-MC-Unique: 81UPv23hP-O9j_e5RwbUqw-1
X-Mimecast-MFC-AGG-ID: 81UPv23hP-O9j_e5RwbUqw_1752156605
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450de98b28eso10323845e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 07:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752156605; x=1752761405;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9bjJYpCH7ZfK0sawPwyP0TDIcWspMQNetqywwvCHqCc=;
 b=FEsgwzaVUNQ3srhot/ZVU0wOpO7w8mMxHRNxPUECHvztBkzoIldr+V9TmiCJ7vuUTT
 4wgHHhGmi53+kl8m4bHrZOlTV5k/Pi7/tPGwvfVd9hgpyxUx2XPJVxB0QSQck4sxzKYh
 vw3A5Y3KKrSlkAtGxzfGD3JYH8+Hu8/V872TtSW1IBF37D1rs9CfTru8uJw+KJqMg+sQ
 NV1or8qPpZ7OC9VEmgLHcCEWgVk+YHbc24otTqnNpPf+utPj+1cbUbNRMWM504fyljzb
 9bbTLIX833RfiyZERR2TzaJxXYf7FEy6PgBQrARbh7iHuKRS6AF/NzEzEDyESwNEmO/g
 jBcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOURsN0P9mF59rATGXi9hWMJhiV1pRtkmnCfk+h2nRLvVw75ghQutT89gHotoFp+61nLHAbaRsn/B8@nongnu.org
X-Gm-Message-State: AOJu0YxNFXrycCwjvE+95CeWAr/mH2Sg2v6ccByYTtmXRS51LqDMYe34
 fyDmDQpSO8MtwH29+Hw8P09klbKX7EraHevZFAZ+Is/ReUveNalfLGML3VCsqUwUo6L1HAQGsZ0
 g5MT2V9h5JoN0K8sghNn2Vw5axt7njDrpfRXsPGWKkbH89hm59qaqSH51
X-Gm-Gg: ASbGnctqQ7NOySPrz9bV4LLLg3M3OevZuhnXIL+AGJKqfrZnz/52eNzL/mv6XjBtAo2
 vbpOOMS+7g/48q238gPBjpwkPODwCXVGEnKtJecGOzdvGHuSUOQmtXmLlKUpmwGzUzQjRCLIubY
 kPyfPD1EhbdMsUcJhksy/B36qiEswZKpfOBZsDElRUx4WImzqeqxOCl0iANArU4lFFhCWk00mbj
 b/tORZWZ3+ibAoCYZaRVuqV5Jy+NDEAYmFkiFVmx6ui0SLpKKWLBamdn2Q2SmazDFH+XX7inZfo
 ZlImcZjcCcFAzHQKA8QTWAt38Im0LMhqYxLY8j/SgvLibLvKRShnZ6ZM5JhthTRicacB/w==
X-Received: by 2002:a05:600c:1e8a:b0:453:45f1:9c96 with SMTP id
 5b1f17b1804b1-454db8bf413mr39662285e9.14.1752156604814; 
 Thu, 10 Jul 2025 07:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6psRf5P3aN2vGoaXDYQS7IIdKIGys2vxts3vY0vAop44l6lLGzwwi9GjwHLRdCCTUXuK3Qw==
X-Received: by 2002:a05:600c:1e8a:b0:453:45f1:9c96 with SMTP id
 5b1f17b1804b1-454db8bf413mr39661625e9.14.1752156604150; 
 Thu, 10 Jul 2025 07:10:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d511bd78sm61242615e9.35.2025.07.10.07.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 07:10:03 -0700 (PDT)
Message-ID: <322a9301-a1ee-4cd9-b423-fbef2fc0593d@redhat.com>
Date: Thu, 10 Jul 2025 16:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] hw/arm/arm_gicv3_kvm: Add a migration blocker with
 kvm nested virt
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, gkulkarni@amperecomputing.com,
 gankulkarni@os.amperecomputing.com
Cc: hi@alyssa.is
References: <20250707164129.1167837-1-eric.auger@redhat.com>
 <20250707164129.1167837-5-eric.auger@redhat.com>
 <48fca85b-096a-4d1c-97dd-380669cb6604@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <48fca85b-096a-4d1c-97dd-380669cb6604@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/10/25 4:04 PM, Philippe Mathieu-Daudé wrote:
> On 7/7/25 18:40, Eric Auger wrote:
>> We may be miss some NV related GIC register save/restore. Until
>> we complete the study, let's add a migration blocker when the
>> maintenance IRQ is set.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/intc/arm_gicv3_kvm.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
>> index b30aac7aee..fccb3886bf 100644
>> --- a/hw/intc/arm_gicv3_kvm.c
>> +++ b/hw/intc/arm_gicv3_kvm.c
>> @@ -827,8 +827,16 @@ static void kvm_arm_gicv3_realize(DeviceState
>> *dev, Error **errp)
>>       }
>>         if (s->maint_irq) {
>> +        Error *kvm_nv_migration_blocker = NULL;
>>           int ret;
>>   +        error_setg(&kvm_nv_migration_blocker,
>> +                       "Live migration disabled due to KVM nested
>> virt enabled");
>
> (mis-indentation)
Did not notice as checkpatch does not complain.

Eric
>
>> +        if (migrate_add_blocker(&kvm_nv_migration_blocker, errp)) {
>> +            error_free(kvm_nv_migration_blocker);
>> +            return;
>> +        }
>> +
>>           ret = kvm_device_check_attr(s->dev_fd,
>>                                       KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ,
>> 0);
>>           if (!ret) {
>


