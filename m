Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E653E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjvX-0006Fu-D9; Thu, 12 Dec 2024 09:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tLjvV-0006CT-IO
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:12:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tLjvS-0002sc-W9
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734012741;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNzM/5KHaOdjwOXaIll3vIt6zX42tMOo69nIstNet+E=;
 b=JIp8Rkv2AWrhrH9K2i2SDoSuxZESa02DeyyzCdDsx17w7TLuze8XXhkn6aZ1ozHNwmdUAh
 dzH6Vcsk+UDrgVQ+ylvmcoIfUMLrFdk8izmdTC2/gzGb3KY+DJqeNU9s/XTBxqleK6qG+Q
 Zmt7gW/SFI+6vh9IzvAfaQaWyNAs2nw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-scuoFotnOkWD2EavOLcaqw-1; Thu, 12 Dec 2024 09:12:19 -0500
X-MC-Unique: scuoFotnOkWD2EavOLcaqw-1
X-Mimecast-MFC-AGG-ID: scuoFotnOkWD2EavOLcaqw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361efc9dc6so4159265e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012738; x=1734617538;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lNzM/5KHaOdjwOXaIll3vIt6zX42tMOo69nIstNet+E=;
 b=XstKhsC7zPF398/tMzdCk3vwJ/kOQ4/V/aEp4liGIhAF0QlNjV0fSHV3EOorpU8qSU
 7lawqgBgCd9o7n+/2a1ApAiFQGKUFUpfVLl89qMxZE0hacBGU+HerAzF/sQhV+u+JW9E
 2tNpE2wYZmlqNYS8PnTo5bqkvvyBEyZZHmiIPzhnKTygidlEtansRuHQcNn0JqmXyYIc
 X1AN6e187iIOXtNbSxGumk6aOCltnwaS0zPuJcDk9amDUr8kRwiaQ07MIoM2DcazCFWL
 1kc9fY4PhsU3Pb0cEgmu0Tzsr+T41m0CeMp0ZCEDzXtvoI0h/GtfLYSyA6coaFyCB59S
 7BpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhoFIFys3J+VsVKo6zwdGgFzATvjZ72bIt41mNr5EoaW7LLTNlOLOOBEvIMOsVhr3H1ah1TgouCB4H@nongnu.org
X-Gm-Message-State: AOJu0YyS81Lt069SVWZzhTECTRahByMSEtSQUd7F6qw7TfgqXGzeTLXI
 J6ey/8P83S/ZH7I4DLuPVMalv9eMd6y1PEJiAp9vRDaaUINeXgJvJBfu5v0EKcnWArdpI3ZFV8L
 on0qC6k2VleM2REpEWu+TP2g2PhtSccIHSQ+4rrexGXQQkWv/z5wk
X-Gm-Gg: ASbGncs9DHbPidx/8zs2Ycb99fUgD7uA6v7NAT9h5CVEm4lpl22JuDXUJgv7y7U1syi
 ByZRLQA0f4VneLDRTpOo8K2En8ZivjOYN0fj1wKIbnh4n/Fw2XprcRr3cfSl10eWlK4VyV/iKZZ
 W18k8jYHwjZKhdrq/Lbn/E/rgBUtSv/SL6FYs9ZsQfwNFZ7hcdimovgc+r5nfNKH0KYBNIwxGpy
 wVGl8P9bkPfP5tamL7VLlCt3EzJxhNmX+/ty9X0D47lgFXnNjgXeKdX50v/dK0rLwwA4Mkjxbbc
 vKj6+Lf23a3ME9x+SADKQ8EMgzZE
X-Received: by 2002:a05:600c:5107:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-43622842924mr34681905e9.17.1734012738450; 
 Thu, 12 Dec 2024 06:12:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU8Gkh/6x9u1nP/VCWEubXoDik5WGdtMCiI9rgLd/giqAVYpPerfHi1FsZqd0S62AvM7EIUQ==
X-Received: by 2002:a05:600c:5107:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-43622842924mr34677335e9.17.1734012733105; 
 Thu, 12 Dec 2024 06:12:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436255531f2sm17862685e9.9.2024.12.12.06.12.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 06:12:12 -0800 (PST)
Message-ID: <f06b5f10-6ff4-4851-96db-56d6596bd176@redhat.com>
Date: Thu, 12 Dec 2024 15:12:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 01/20] kvm: kvm_get_writable_id_regs
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev
References: <20241206112213.88394-1-cohuck@redhat.com>
 <20241206112213.88394-2-cohuck@redhat.com>
 <a1ad71d4-4148-42ee-b77a-fc4df1f5c2c0@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <a1ad71d4-4148-42ee-b77a-fc4df1f5c2c0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hi Richard,

On 12/12/24 14:59, Richard Henderson wrote:
> On 12/6/24 05:21, Cornelia Huck wrote:
>> +#define NR_ID_REGS (3 * 8 * 8)
>> +
>> +typedef struct IdRegMap {
>> +    uint64_t regs[NR_ID_REGS];
>> +} IdRegMap;
>> +
>
> Where does the NR_ID_REGS come from?  In particular the * 3?
> IIRC, all of the id registers are in op0=3, op1=0, crn=0, crm={0-7},
> op2={0-7}.

According to the KVM API and code,

"The Feature ID space is defined as the AArch64 System register space
with +op0==3, op1=={0, 1, 3}, CRn==0, CRm=={0-7}, op2=={0-7}."


hence that choice

See:
https://lore.kernel.org/all/20230919175017.538312-3-jingzhangos@google.com/

Definitively we can add a comment

Thanks

Eric

>
> Whatever the actual answer, some comments would be good.
>
>
> r~
>


