Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3242ACAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 09:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2nvO-0008SS-G9; Sun, 28 Sep 2025 05:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v2nvH-0008S1-Qx
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 05:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v2nv7-00051X-1O
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 05:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759052524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pehKRZAwaRRMOpteDJ57Z0pHHjub3UmC1c+fnIsgX2A=;
 b=A1l9Kn6SeRN9T/6BOt0G/mOf3loAPS+AqzODYHLZt8JNd0TJ2Q8zVVw3yrJU8XtpYgpMta
 p8f9d54wnUUw3htSt8qrjSzPqWk64ecGkltEqS4mIOAIdxI3Xt0ljT59hYOHm4QeAWdSdC
 AUxWwfkTyAwIRI1nxFGF4coLJd5iw9U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-VuuRy8O_NM2-e0SuKfJ7Zw-1; Sun, 28 Sep 2025 05:42:02 -0400
X-MC-Unique: VuuRy8O_NM2-e0SuKfJ7Zw-1
X-Mimecast-MFC-AGG-ID: VuuRy8O_NM2-e0SuKfJ7Zw_1759052521
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-634c48a0ce7so2600733a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 02:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759052521; x=1759657321;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pehKRZAwaRRMOpteDJ57Z0pHHjub3UmC1c+fnIsgX2A=;
 b=JjOhMBBu+hj2j0kv81Sup4h9QVCAYODOKf/eSMP/GyxZDHAKw+UFpi8iivis8bs+NW
 JJbjXoGYUPnnghngLXZOD9f20N7Lo372+Zu6LZQTHegkCIxuFOaTgBdDz6607P3ByKo+
 UobRwj7A8iRqkQ1E/BUC0mNZBdwkveZ+7KSHIYaUhbX6ogvgXEAx5gQYQr9RXXH0b5JK
 IijRrn7fAAwUKe8JrRZh8LOoN6YkI1YZZndMAuKRhzaT16p9YNe95e8THQoWvbe4p7ce
 PlxXq79+GoFKAuForvvZtQncDAy51s2aYLWTiwMuTj1TeiElQxjxNk3Orh223UQuE/Ub
 xQpQ==
X-Gm-Message-State: AOJu0YySDz+UJ6dPl2gcxqrbrvOjn4ss2E7h2mYrEkNH/EhkNgz40RuF
 BlxXR7O+GMfx+dGEh/YxRsBOlR525e+Opm3Of30a/jLShM3f6sTfW8LRLvCJV6A27Fa/JR8DOHX
 y3ft9eOlPrhUwn6BTnhu4C6+zHvrfsNeIKqR+E1dgsyvrgEuLgpeG4J/w
X-Gm-Gg: ASbGncvuQ+GyQrK87Z6oR3aEzOKzoulLYlv73Y0YGGsR13jSoa7+RJNQci87EMkHCBQ
 kH8nizm4/XwC0r3uChWA19JDuIO3/zm0XimdPdzhcfZnbvsGdUVa5HjjbosD2ZlveXLLEKP+BBk
 /qxAoa+FRWZVUlC12FbMPnjcG/1OqiQzqXgTkIjCp2qfWOEqGmH2MahLSPL0wIDqx1MS3Hqm6JO
 kaCRJTSUGRjTkaZsf+tWmuokosyf82Rfi/iThLmffQKOt1KAlnMM9z5W/AW+mtY2PyELnR7XoMY
 9pcDvQrxHV0/BuIIKJW2VbvjTOeqQhvSaEsOijyAcMyNBNN+fC21IoJoPO+J/np3qPlLtYA7JwG
 cL/YxMHlxUS1dI2gyI07GQV7Nur0LVK+6sJO9NhCzTGB9Nw==
X-Received: by 2002:a05:6402:1e91:b0:634:b4cb:c892 with SMTP id
 4fb4d7f45d1cf-634b4cbcc44mr8911005a12.32.1759052521101; 
 Sun, 28 Sep 2025 02:42:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj+uiPdT9PKfGsun1DS1VABHKqEyv561801ZbNm48LyXvZO56/TrD4cxhxMpPZDn2s8Mz4Jw==
X-Received: by 2002:a05:6402:1e91:b0:634:b4cb:c892 with SMTP id
 4fb4d7f45d1cf-634b4cbcc44mr8910993a12.32.1759052520744; 
 Sun, 28 Sep 2025 02:42:00 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-634bf4a5351sm3779422a12.43.2025.09.28.02.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Sep 2025 02:41:59 -0700 (PDT)
Message-ID: <927d4bce-9ccb-4a81-be98-db6d6bbab548@redhat.com>
Date: Sun, 28 Sep 2025 11:41:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH v2 0/2] Fix cross migration issue with missing
 features: pdcm, arch-capabilities
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, hector.cao@canonical.com, lk@c--e.de,
 berrange@redhat.com, Michael Tokarev <mjt@tls.msk.ru>
References: <20250923104136.133875-1-pbonzini@redhat.com>
 <aNVrAkx+ahn7ZRns@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aNVrAkx+ahn7ZRns@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/25/25 18:17, Zhao Liu wrote:
> On Tue, Sep 23, 2025 at 12:41:34PM +0200, Paolo Bonzini wrote:
>> Date: Tue, 23 Sep 2025 12:41:34 +0200
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Subject: [RFT PATCH v2 0/2] Fix cross migration issue with missing
>>   features: pdcm, arch-capabilities
>> X-Mailer: git-send-email 2.51.0
>>
>> Add two compatibility properties to restore legacy behavior of machine types
>> prior to QEMU 10.1.  Each of them addresses the two changes to CPUID:
>>
>> - ARCH_CAPABILITIES should not be autoenabled when the CPU model specifies AMD
>>    as the vendor
>>
>> - specifying PDCM without PMU now causes an error, instead of being silently
>>    dropped in cpu_x86_cpuid.
>>
>> Note, I only tested this lightly.
> 
> Sorry for late.
> 
> I found the previous 2 fixes were merged into stable 10.0:
> 
> 24778b1c7ee7aca9721ed4757b0e0df0c16390f7
> 3d26cb65c27190e57637644ecf6c96b8c3d246a3

Yes, thanks for noticing it Zhao.  Because we cannot apply the machine 
type changes to 10.0, those two patches have to be reverted.

Paolo


