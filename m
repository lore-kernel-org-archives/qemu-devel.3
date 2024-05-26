Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA3CC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 15:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBGBz-0001ZT-SD; Sun, 26 May 2024 11:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sBGBy-0001Yp-5F
 for qemu-devel@nongnu.org; Sun, 26 May 2024 11:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sBGBw-0007mM-HB
 for qemu-devel@nongnu.org; Sun, 26 May 2024 11:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716738827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03ppgue1ufvN1p0s4VRe0ecv8sXC54JScjHDwel6KEY=;
 b=B/eF2svukqjrveN8ctGHK77kuelcQNLseN+7Ke3ebK5mmftCjTD96ZeCmHiXFfcnqf1pQq
 pEcCXsFkK+K2U5innyzQcd1wnoCDHXzF1SwtcZu9lQhcjXgmn3dMAzuWlph0kZ/NSWGbW0
 yTsIhCT5nU26j3b26lzzpIjRnYOCnPY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-cD8C78-PMkiIg_VALOlC-w-1; Sun, 26 May 2024 11:53:45 -0400
X-MC-Unique: cD8C78-PMkiIg_VALOlC-w-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5785f7b847cso2159482a12.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 08:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716738824; x=1717343624;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=03ppgue1ufvN1p0s4VRe0ecv8sXC54JScjHDwel6KEY=;
 b=DIGeGEOuoSsR7poTUxpcAvew8LNpV/DCUqfCb96B2ce8DJxh8oQYHjGwE86KGX0EDh
 t+lrhRAjfgctpxSqlYchP+57rXmKZUIQszP7XSSq7e2KgXdoofFp48Hz5f5azijXSk8d
 j347ugJuQh4C1c04jjcwX6Q8aowCepfAOroXib81sliOkLzfzRuInGMwR7cFG82KEHAr
 lR+/0g4FeclDK+tTklhTgNMyK3ttVpg87kyVTrcXrsCr0DzdCZXqPbATjKQnl4JKTJ6v
 Gzkts3P8N2mafNKUcClbo+IP1E3llK0h9F9/6SfYEn3zEi1xNnhKuYczzndH9PEzDk/+
 RY7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUetadoc0oB4dOVdCFFRwjR67hmyPVj20GQEGNlvynlEF5LxCfbGIz9kxx5okLBDZ4rqzdu0doj00qD8xlLnWNP10NFJnI=
X-Gm-Message-State: AOJu0YwW0AfakkRjyJ4M1oRiujIuLzz3+L+/FaodjyxE5zbvDR52VwrX
 HbkvGpWJ5vKvLYE3uyLR/KsXWXyxcEW1b52G4DC0FD4Q1SbRjAvVF/Mh7SzvCSSvp5XvjxfG78Y
 XuHm3yOSvrdK9YqoO4iJ/3fHKOc90mVhSbkdaPWujtGu4p/rs/+wq
X-Received: by 2002:a50:96c3:0:b0:578:2474:8e2b with SMTP id
 4fb4d7f45d1cf-57843d8fd26mr7228022a12.10.1716738824381; 
 Sun, 26 May 2024 08:53:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6/JiZo4UxLNO1p3hK/pbANZZPizzojSJ6CuOErlUwxNOx9+fg9e8BFmeEPImm2MhDQ8vhpg==
X-Received: by 2002:a50:96c3:0:b0:578:2474:8e2b with SMTP id
 4fb4d7f45d1cf-57843d8fd26mr7228005a12.10.1716738823876; 
 Sun, 26 May 2024 08:53:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e?
 (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de.
 [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579d0d5aba4sm725967a12.71.2024.05.26.08.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 May 2024 08:53:43 -0700 (PDT)
Message-ID: <3bf1025b-021a-42fa-a4cc-d3cd9ea90676@redhat.com>
Date: Sun, 26 May 2024 17:53:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] hw/intc/s390_flic: Migrate pending state
To: Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240525131241.378473-1-npiggin@gmail.com>
 <20240525131241.378473-2-npiggin@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <20240525131241.378473-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 25.05.24 um 15:12 schrieb Nicholas Piggin:
> The flic pending state is not migrated, so if the machine is migrated
> while an interrupt is pending, it can be lost. This shows up in
> qtest migration test, an extint is pending (due to console writes?)
> and the CPU waits via s390_cpu_set_psw and expects the interrupt to
> wake it. However when the flic pending state is lost, s390_cpu_has_int
> returns false, so s390_cpu_exec_interrupt falls through to halting
> again.
> 
> Fix this by migrating pending. This prevents the qtest from hanging.
> Does service_param need to be migrated? Or the IO lists?
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/s390_flic.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index 6771645699..b70cf2295a 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -369,6 +369,7 @@ static const VMStateDescription qemu_s390_flic_vmstate = {
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT8(simm, QEMUS390FLICState),
>           VMSTATE_UINT8(nimm, QEMUS390FLICState),
> +        VMSTATE_UINT32(pending, QEMUS390FLICState),
>           VMSTATE_END_OF_LIST()
>       }
>   };

Likely you have to handle this using QEMU compat machines.

-- 
Thanks,

David / dhildenb


