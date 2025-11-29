Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B934BD116EA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 01:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP9fB-0002bD-Qr; Fri, 28 Nov 2025 20:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vP9f9-0002a5-D5
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 20:22:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vP9f6-0001cl-Ro
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 20:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764379325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aaXld7QRK+hOb9QqSes3j1caeP+4l3n/jwswr44E1L4=;
 b=Yyv7PzFixw7IgBJXZDyjZRIjYYVKSgF/Wpjk5q+uKtEeu6jQyiFG8eL2C3VaJ6iZyvVsd8
 VE2wGWLxUnQfVGFU7r9yNHk0YlWW7r5JFxsmh8TvJSXykAs2LCIXPZ8RlP/n++WXwBu2lp
 tNY/42L2E5Szkg7NjJKAYjbHIWauXrQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-tQ6xMJwdOnSUefmniOa3Rw-1; Fri, 28 Nov 2025 20:22:03 -0500
X-MC-Unique: tQ6xMJwdOnSUefmniOa3Rw-1
X-Mimecast-MFC-AGG-ID: tQ6xMJwdOnSUefmniOa3Rw_1764379323
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7b80de683efso3459417b3a.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 17:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764379323; x=1764984123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aaXld7QRK+hOb9QqSes3j1caeP+4l3n/jwswr44E1L4=;
 b=AKbqvtwxC0g7QaVa1pWoK0JPIA+Jvkki99AlQOu38zjBIUVGsa3HW4KB3PJ2d2qvTw
 X1YTDsRvnOY5cjOy2+DppTJ5GqgzZLryNp6NxM9HEuWalbSpT3yOdOJQ9TVuCtqdFxYu
 vY/BLgvJMlM+0ehupYT31Hav3ZelIhRlsPf7+I+Cpeq+8aQjx/GzO4BiQ2gn9V7HZq4O
 TVtfFSm+1Q1yeYIySKe1wXOgdAFknlUpXa2DhrGbnNOVB0s6QJ0fYmoq3794C7K1UHTy
 jjAPL+0PvPBSn6BSFy3eHG6MZAxUQBUoXeMTM1WfacfW89e2UGtUAqa8tKfBx262nhp+
 3eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764379323; x=1764984123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aaXld7QRK+hOb9QqSes3j1caeP+4l3n/jwswr44E1L4=;
 b=RpIZRrrgl3AtOKaDBckxJej8UObCUPb6zYX1r9t8WdyHsJLf5wLUwCafHm650e0IMO
 vT4Y659VsvkWMDif72jtk2hxnqBAWMgJ7vzMb0nW/GbuR39tcloKyCez13melLsizmVx
 KnZ8EW+ZbHDx2byBc3ZG9PSwEunqY1j5Tmanf4hDHfmbWpzWqklKv7ltLo7V2Lm6TogM
 nVQVR66AZVpVuSUAYVnjTIG5LDRweWDRb3vMEgXRNWBjlEGEpl9fe/6HYap/bOUYP2cA
 JVkRozXc8DCK7RDsUirlH7Kz+T+nrmw9h8tMi8K5UeSdiEXKGtm/gvIkkrTn1fXWYV0W
 Evpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6Y5ChUhqYbLy5mcLR+q86Gjvh3399SdYLeoVwDODzPHTWi4VRf0r27OYNezS+WtmpvSss04QO8fTi@nongnu.org
X-Gm-Message-State: AOJu0YweqIiS4aoU/4Cm/ybwIDgBIqDnkegNalsYHLOFaKlApPFA9PkQ
 CxmyD0hTt/hCI13Dyvs4oi7vJ3TA61RNn6PgxM38vA4if053WEwx6p1efLdV4UNDfVhyR7Xl3Oq
 kt/n3rIc8NsnPMN+vxO0MbFbhkRc/eHSSmob6qKEQMeTswPLOYdK4f/Qk
X-Gm-Gg: ASbGncvGkfsyyyuxnWYRTBBUIF3N7+wTi1gArnRyiYaIlPiyM7HNPi5JjmH1Wf8fBS8
 otoanEGySpP82xuTlN/3I693fbCj58lSoSLst1e9J4ndzQSE3wLN8Yyne6cRUZrFOVSRy/4AC3g
 9Yf+nMUcqV7cQpZzYqGL8m03y8317xqHpV8tL9T+C23/HVosQpo3YooBrE7Ax1NFFmnasMVj9W5
 ssixP4j6v9z7+Yqm1FHIXx6kA/NahejTV/iPWsT8LLJysAGSGUBly9Empj1RkPnkl43UeD9FIpT
 V0Jrou+ditZtQlsmTPdRF6eIzT63byrb4rbrh4RkLfMEvvk3ABsV/zf920Hfiv6uA+YrFDbziCB
 X2MRdxNdmlzP4oXlNkmstesBHJuN1Zp3TwlL+4wMKDDdyUsjnEw==
X-Received: by 2002:a05:6a21:33a3:b0:35e:4b35:3669 with SMTP id
 adf61e73a8af0-3614ed962d0mr32247881637.31.1764379322688; 
 Fri, 28 Nov 2025 17:22:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD/6y3yAZEsqUQBC1nJ6TunkYnaU4h+HVdAIBKEdrnk3b6L33o36MHqLLUTIw/BYUqgDsOVA==
X-Received: by 2002:a05:6a21:33a3:b0:35e:4b35:3669 with SMTP id
 adf61e73a8af0-3614ed962d0mr32247863637.31.1764379322337; 
 Fri, 28 Nov 2025 17:22:02 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7d54b003177sm794831b3a.14.2025.11.28.17.21.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 17:22:01 -0800 (PST)
Message-ID: <53c3c2c4-b8e3-4ca1-a0dd-88148520ad82@redhat.com>
Date: Sat, 29 Nov 2025 11:21:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] acpi/ghes: Error object handling improvement
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251128150926.78bebacb@imammedo>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251128150926.78bebacb@imammedo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Igor,

On 11/29/25 12:09 AM, Igor Mammedov wrote:
> On Thu, 27 Nov 2025 10:44:30 +1000
> Gavin Shan <gshan@redhat.com> wrote:
> 
>> This series is curved from that for memory error handling improvement
>                   ^^^ confusing
> based on above I'm not sure if it depends on [1] and shoul be applied on top
> or it can be merged on its own
> 

The current series is a standalone series and expected to be merged by its own.

For (v4) series of memory error improvement [1], Jonathan wants to extend
the handlers in the guest kernel so that the granularity in CPER record
will be used to isolate the corresponding memory address range. With this,
the patches in the (v4) series to send 16x continuous errors become useless.
However, those patches in (v4) series to improve the Error (object) hanlding
are still useful. So I pulled those patches for the Error (object) hanlding
improvement from (v4) series to form this series.

>> [1] based on the received comments, to improve the error object handling
>> in various aspects.
>>
>> [1] https://lists.nongnu.org/archive/html/qemu-arm/2025-11/msg00534.html
>>

Thanks,
Gavin

>> Gavin Shan (5):
>>    acpi/ghes: Automate data block cleanup in acpi_ghes_memory_errors()
>>    acpi/ghes: Abort in acpi_ghes_memory_errors() if necessary
>>    target/arm/kvm: Exit on error from acpi_ghes_memory_errors()
>>    acpi/ghes: Bail early on error from get_ghes_source_offsets()
>>    acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()
>>
>>   hw/acpi/ghes-stub.c    |  6 +++---
>>   hw/acpi/ghes.c         | 45 ++++++++++++++++++------------------------
>>   include/hw/acpi/ghes.h |  6 +++---
>>   target/arm/kvm.c       | 10 +++-------
>>   4 files changed, 28 insertions(+), 39 deletions(-)
>>
> 


