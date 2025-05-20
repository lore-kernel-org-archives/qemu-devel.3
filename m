Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76ED5C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNPP-0001Da-Au; Tue, 20 May 2025 09:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNPJ-0001Cb-V8
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNPD-0004X5-TQ
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747749198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uQY297q/qpN9tCJDbaMPk2rn3rxlGnqXOnF74IRuNPg=;
 b=cgTAGW1lzFBC8dD/Cj42d0ebzRJ+75O5MbP97lBlZdwnyMQEPaWPzLsGgsBE0g04Sx7UVd
 p7YrFAOM/p+px5Md9Dpo83TVaom3ZD/P0szNiNoDBTAPOhVNEgdTrgZrI5oxYMzlZqYkhe
 iZpS/hYTyMKdRY9dvdunynAbo+2HNKc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-1KiZHSZ1OwyFPS81Zg21Pw-1; Tue, 20 May 2025 09:53:13 -0400
X-MC-Unique: 1KiZHSZ1OwyFPS81Zg21Pw-1
X-Mimecast-MFC-AGG-ID: 1KiZHSZ1OwyFPS81Zg21Pw_1747749193
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-442d472cf7fso45196255e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 06:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747749193; x=1748353993;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uQY297q/qpN9tCJDbaMPk2rn3rxlGnqXOnF74IRuNPg=;
 b=oYbj6+NHb3er3Oj63098S5PXHrOebQxwdLajBZkC9Us0hV4ahIBEgKdPIZ5ga0N7NV
 204njFidUufXTss2Vz6d+XdxzWjw2I9pp7jq4m7bhm8Ex8mDxLe5sFqKoY+11fq/aJyi
 HkCtEla20XOKZLbYQQVsLcu8np5Wdmcqfpa1xwaOxzC8by2HZOi263ks6hOjy+n+aAIh
 b5PIcJdr3JKdCeGPTNPzew58NFBq/0z0ybsQD5ymjF+cUh8AtUFq8WbOp0Du0S0p3Ma/
 56xZ0dwX4ENZwGTmTTneXmn8xsyDAZ0aFXcdMBXlzf4MbgBhoLYV/UaucOxP4iEL4v/l
 l8EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSc7Lu3hoFZY8QEG7FFShmQBZfQp3ILEOBPxaj+lKniZYcUEsMhbGVPGhNee5VrKask5IIo6imRN+s@nongnu.org
X-Gm-Message-State: AOJu0YyjoPyiQso7G3bUeIejKz91IV0o6tM2JjTyIEsD55UGWu+38BNh
 OXCaBnbBb/2QKwHACPu/Ars5O7PkMAQtmQSUypNtRk68yjRf6TEWTKSdwpZWLs5rra3OHSjgN1Y
 giL3TacKnaSTz1Qib0cIYK250d+fiJNhy58KYvKW5jokaBFisZihVOx8h
X-Gm-Gg: ASbGncs3pzbTZBG90fO6MpwbARwOdf6f0JYVtxex8HTImyK5zb0u9kPNAHlKg8lkWP1
 2jnilyv5tzwkDgmFYT9pdMOkCe/38zEVWVcg68H4uClcE/d+A5/ZzJe2jhCIjc9xJ3WWTV606gx
 8OUQlGoIrUM00XTVXecUdZvn/yOx9D0+4HUT0t9IpMfQ3HuozT4pBjSV1/LX200qmD8+f8aQ+aq
 KLi9hR+b3f3moKp0dcOUsjBb3H53rsxHs87ZLVCFGv9d+dnG4irIIVlH/9lq9fXb49P2A6FmyIB
 Ku+At4+KMrO27g==
X-Received: by 2002:a05:6000:40d9:b0:39f:fd4:aec7 with SMTP id
 ffacd0b85a97d-3a35c808cacmr17683405f8f.7.1747749192639; 
 Tue, 20 May 2025 06:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkjuNvmgvA0VA0lmHyLQW2tCew2RtmK5q7vzC6wvV85uzcx2d/mh9JR8eJKGVa/v4khTPJEg==
X-Received: by 2002:a05:6000:40d9:b0:39f:fd4:aec7 with SMTP id
 ffacd0b85a97d-3a35c808cacmr17683366f8f.7.1747749192199; 
 Tue, 20 May 2025 06:53:12 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d224sm16989776f8f.12.2025.05.20.06.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 06:53:11 -0700 (PDT)
Message-ID: <2b3b3e89-a471-4245-af63-d7ed8ab1c843@redhat.com>
Date: Tue, 20 May 2025 15:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 25/25] accel/mshv: Add memory remapping workaround
To: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-26-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250520113018.49569-26-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/20/25 13:30, Magnus Kulke wrote:
> Qemu maps regions of userland multiple times into the guest. The MSHV
> kernel driver detects those overlapping regions and rejects those
> mappings.

Can you explain what you see?  QEMU doesn't do that, just look at KVM code:

static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
                                       gfn_t start, gfn_t end)
{
         struct kvm_memslot_iter iter;

         kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
                 if (iter.slot->id != id)
                         return true;
         }

         return false;
}

...

         if ((change == KVM_MR_CREATE || change == KVM_MR_MOVE) &&
             kvm_check_memslot_overlap(slots, id, base_gfn, base_gfn + npages))
                 return -EEXIST;


Paolo


