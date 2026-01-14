Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E49D29FEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 10:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfyWN-0000dG-Gy; Wed, 14 Jan 2026 05:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfyW7-0000ac-Di
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:54:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfyW5-0006OA-Ni
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768388059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9X9Z7D5GWOm3rR+ZhjJWpTji8CclQCiWQwkSiybtERA=;
 b=gdxs/A1NqDoHSeyhp0V5RcFOa3wOfILGtAe02ZI0hqHidsa8bTIlbzZOtyQc8P0HXkeygO
 pp0YI7ltXgIY9HtaphWeio82jenk2UaEnO1uTYNy+J9Y/5nm4u6fl9HOwUpICCdahr+Rs7
 TG0UMehSPqfPSFhXiURvhQLg8vAMCXo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-CsYt3bJWPGeIA5Bp62f6Mg-1; Wed, 14 Jan 2026 05:54:17 -0500
X-MC-Unique: CsYt3bJWPGeIA5Bp62f6Mg-1
X-Mimecast-MFC-AGG-ID: CsYt3bJWPGeIA5Bp62f6Mg_1768388056
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4776079ada3so85851625e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 02:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768388056; x=1768992856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9X9Z7D5GWOm3rR+ZhjJWpTji8CclQCiWQwkSiybtERA=;
 b=L+WAxyj0O4d3bmbYNomwHpmWZB3KZFA7+r62fInoGd3+P58POPJAe0qWMtRWR36/ky
 w/6MqSsJU3qUcAv+ZmJ6i9fnMUUMgXiVXZIU3Xby/CLMkfLN20ATayNwREVPTNnJlAdG
 Cf3Vl6Qr2c0yKaGLUWAmBA2PGNA3p+aKDU3IwH0xjYZlJeo5kMItz5ItdaZdj168/GX0
 RcV1Nd9no/D+F1QuYkjcAG7xFkhl7h7x9nAXD2/1zl/3TneZGLKh10AZvmUM1azN0N4p
 QjxMLWbNocBkds5lPBMNfjouVnZ2bXVqApGy6G+0IjduSgr0+CTc7yhokp3d5BGjTBY9
 tXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768388056; x=1768992856;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9X9Z7D5GWOm3rR+ZhjJWpTji8CclQCiWQwkSiybtERA=;
 b=tpLbprYfza24BlXAZ5Kj/21JPi9iBmEnRJ4VXrtMhNmI/rAevPZZXlTORyYbYORqwI
 xATkpvpzWycyuQZB7Gf7pHYDP3XmQjIdGxtowqv3YOyGTFeu9pS3s3yhGdykjbYv1qYo
 FSpiXf2bAVsiJdoTqdjLrPkYE8SAViQ4e5svsjzxcwoq1AbhtyUINlt96yyfVhtHllF/
 aU292j8ilHFY4cpirclg2PAKma3+xGCAWFMCeh0FBtaF2u+IQ9FL/G4XVHPsYgrkIjVc
 Gxsgnnmdqwo0TjQTSQ4QQje6HOCKhhoSmxKYv6F/m66ix/tS3yM3T6RtXio+3fkcWvMl
 MQBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxJjmlodtra6gRVsloGxvROr3bOSamXT+GxOHzfevXyloFwzef1FHHCsn+SqjX44ePgXPi69+MYHFm@nongnu.org
X-Gm-Message-State: AOJu0YyohygJvTD4XsVRrX+TtIQ7S4DV+QmfbJmH/rjr+Pd8iwjlT+hj
 jxRr25ILH+8x2E23fj7+ipAghYQwEWTEy8Dt5FLTlXj32ejU+L9x2E0Ux1V1CXfuBBzFtiHNLb/
 ZfC3ezff/2y0X2TZpP9Bfg3wDiVPdu7+B5UtdUC/Qx+qMhRm38oNse9Ru
X-Gm-Gg: AY/fxX5BD3kguCjtF6gkFATINN1fp8KlUr6BPJyF5zbDNrK7h5EJUlzgrnR64iRBSb/
 ZiTl8AmYSC+iwlIXzcX3vLQcmv5l1U1uZoypcDu5GYS3n8PrXe7sZwmW/PBOdDGYgX5OFVPrc4o
 O4HVJmLWVrX832tgjbCJR+i97pwmz/KDQTOv4h0qB6PhCf8oSQlJiknWxNo7HsLN2EBei/Oc7Vi
 wH7AGFeU8dXHN7ABHJQvDLLK/EyWZM12kxVIajnzyXq1lnOsylSLaqrlNz2DV6Ag26Gq64TSbkD
 IcXvc3pZ9w3bOKj9OenOZKUVjYD9typeRZkA+UbfLQS1Ed2l60T41/8mq2v0eH9gX7yMeRsyNeL
 atshFSTaA4nvwcuWVzzpyLyv0gGgRbvR2XXZErLake9To/OGCHPxK0F1on4dGqV/a5r3x6cwN8L
 6FA+hMrKoO/vnLjg==
X-Received: by 2002:a05:600c:314f:b0:477:af8d:203a with SMTP id
 5b1f17b1804b1-47ee338a6fcmr23802775e9.27.1768388055783; 
 Wed, 14 Jan 2026 02:54:15 -0800 (PST)
X-Received: by 2002:a05:600c:314f:b0:477:af8d:203a with SMTP id
 5b1f17b1804b1-47ee338a6fcmr23802545e9.27.1768388055323; 
 Wed, 14 Jan 2026 02:54:15 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47ee57fea00sm26923595e9.11.2026.01.14.02.54.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 02:54:14 -0800 (PST)
Message-ID: <8bff8d59-7729-4a08-b4c6-e32c2ff35e68@redhat.com>
Date: Wed, 14 Jan 2026 11:54:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
 <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
 <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
 <87v7h44pal.fsf@pond.sub.org> <aWdfqvJhtDt14lTJ@redhat.com>
 <ea1e0e45-f864-4a43-a40e-48fd82c26c56@redhat.com>
 <87a4yg4gmo.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87a4yg4gmo.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/14/26 11:45, Markus Armbruster wrote:
>> ---- target/i386/nvmm/nvmm-all.c.orig	2024-11-20 22:48:05.000000000 +0000
>> +--- target/i386/nvmm/nvmm-all.c.orig	2025-08-26 18:32:38.000000000 +0000
>>   +++ target/i386/nvmm/nvmm-all.c
>> -@@ -1057,7 +1057,11 @@ nvmm_process_section(MemoryRegionSection
>> +@@ -984,7 +984,7 @@ nvmm_init_vcpu(CPUState *cpu)
>> +         }
>> +     }
>> +
>> +-    qcpu->vcpu_dirty = true;
>> ++    cpu->vcpu_dirty = true;
>> +     cpu->accel = qcpu;
>> +
>> +     return 0;
>> +@@ -1059,7 +1059,11 @@ nvmm_process_section(MemoryRegionSection
>>        unsigned int delta;
>>        uintptr_t hva;
> 
> That they didn't immediately post the fix upstream is a bit of a
> disappointment.  Deep in the weeds, I guess.

Eh, it happens. :/  For the future, since Ryo and Reinoud are in Cc, it 
would have been enough to contact anyone on IRC or reply to the release 
announcement.

Paolo


