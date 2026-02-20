Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E00C55178
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 09:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtN9Q-0004N1-OK; Fri, 20 Feb 2026 04:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vtN9K-0004Lo-5G
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:50:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vtN9H-00022O-25
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771581009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6uhBNrXyMboNm4QSHsIfJLmZX4qBXq8YyMWbkOHlbs=;
 b=SKCw9iIzseWk2L4yQgIp0f/DNq7E8YauuSFcHKUpV0YeRoBkcFAhuZwNlioRFwpnivffoi
 FCtnTYA7OAqNPGwFJxEGVUKhYYPn8ozmazzxUJYRLEVawkWaIjaaph+0JMOQeCM0udA34B
 nIHJ3WqdvhwXYDnZYQn8KRsDMdTLgdc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-QkJpFsL8M1yNnFDyIZCQjQ-1; Fri, 20 Feb 2026 04:50:08 -0500
X-MC-Unique: QkJpFsL8M1yNnFDyIZCQjQ-1
X-Mimecast-MFC-AGG-ID: QkJpFsL8M1yNnFDyIZCQjQ_1771581007
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4359849d324so2208160f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 01:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771581007; x=1772185807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f6uhBNrXyMboNm4QSHsIfJLmZX4qBXq8YyMWbkOHlbs=;
 b=EDaWM9bMGIUc8Qn+Xu1uyTc7Fi+zC8uXZeVgj1A6+4+V/DVf92oZIyTaOYzYk6DhM7
 QfdKYdIWUnJNAluWdamVue3QNh7Tx4uhihOQ9r2075W+I+nes7I7T3KM6oPWCzkGpI/r
 Ci5yPgNybftz9Uw/6M6ts53bymS6gGqsWpLwpDz2gRtKazEJr43VEtqANLJtWnPAYoo/
 Jvlc5GNi41dQf7xO89lbmAT0His8Sf3C1qh76+FNsBVHzquYaShoFuymLbh+387mmlhl
 XBIIER2jm+A/xjxRHs4IPnniZSPsbzkg3DdSqbrBbWPiDli7RcVsVvlevSTOB4/K0qyH
 urDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771581007; x=1772185807;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f6uhBNrXyMboNm4QSHsIfJLmZX4qBXq8YyMWbkOHlbs=;
 b=nGfUDMOLKylkO4nZsBIVyrAeb2q2wM5IirIpyqvYWr1ceXTUz9Fmm89l1ajtFZMAj7
 d0Mx2Do2R/p0uKfR+dN32st+DpJCnn+x9wQTkb0rDA+o6OQIkf/D2btlY/8VPZ+L2R8A
 XsnKvN6jsusfh/YRf1yL5GtRNwybDcqWdfWdMjfs2IqWhGWcVkT8IBYxqunaseU7Pkh8
 NeKUBNEsIim+8uHNB2TV3ztA7MoBfUBhH0cNUsrTOvma10SdMWQMdkd8xn4B8e2mLT4p
 +yPiUSm2jzWWXEMg+9hlSRj3jYhNxhkv8pDIsJEXMNRCaJ7LixlTnuLMS0AvpmU7iNpk
 6IxA==
X-Gm-Message-State: AOJu0YxFK2h6Yu+tOjvQLC6ccazESTricjGcgG5DgRr+BRVkYKmztRAb
 GCGI5URUQWCX+TdC94cONuziLYiLxaWYZhkhreeE9Bln8+k8QX4sSQjN06AUgXqqP15KYoW3zNz
 nUE07WZm2VUVNxFS26JYwzWAJXVmsZnNC8LMfff8JI81MS/RMdgeCiy3k
X-Gm-Gg: AZuq6aJap2Y1Rt/uoN0ghqr4yQLXpxuRfK/aaT7iTsvRTkm8YTln6dl8VgjZW0W9H9W
 cNWMbUSkZf+qryK3ubGrKe8hfh79alN8fmdaNbWlkLN90Vu4Y2koT8SwCQ29SoSRF9CrD7hMQNo
 tRjHb+p1rlNxBeYe0NU9eSHvN7g8KhLfqLjJBuxksd7twHNDJ/c3qbkJeRXrDi7K1tKtNGaE1zt
 N9EyHt02RXwh8uEOAaqrkl86MVzmFBTlv4ao0GduuREtIXELnjR3K2Wxz3kjw2C5ukylHAtXaOK
 UAtpv8QYRD+lPDX/VxR/zEGBouNy6gTsfNja6hfIsacJo3G9Kmf6ovao4QzYFS0Zb5k1/nEKcWS
 tw2+HaAwAVSbVbdksFJ17BQkOU1wA8lLKPXU/uuzvUiVj7LUKARGTXkBd/SSHGhEgKmFSFzU3F3
 HMDR4HLimxSwagn1qA9yQDdKzFLbo=
X-Received: by 2002:a05:6000:22c3:b0:437:75c1:5793 with SMTP id
 ffacd0b85a97d-4396b02f160mr2150738f8f.3.1771581007165; 
 Fri, 20 Feb 2026 01:50:07 -0800 (PST)
X-Received: by 2002:a05:6000:22c3:b0:437:75c1:5793 with SMTP id
 ffacd0b85a97d-4396b02f160mr2150700f8f.3.1771581006729; 
 Fri, 20 Feb 2026 01:50:06 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796ad009bsm53293194f8f.39.2026.02.20.01.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 01:50:06 -0800 (PST)
Message-ID: <d2cd7d34-0775-4cf1-87db-8ff9ce979163@redhat.com>
Date: Fri, 20 Feb 2026 10:50:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] target/i386: query mshv accel for supported cpuids
To: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
 <20260211155410.203883-9-magnuskulke@linux.microsoft.com>
 <28261EA8-97DB-400F-A85C-4066A1AC425A@unpredictable.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <28261EA8-97DB-400F-A85C-4066A1AC425A@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/12/26 00:35, Mohamed Mediouni wrote:
> 
> 
>> On 11. Feb 2026, at 16:54, Magnus Kulke
>> <magnuskulke@linux.microsoft.com> wrote:
>> 
>> We implement mshv_get_supported_cpuid() and invoke it in 
>> x86_cpu_get_supported_feature_word() retrieve the cpu features
>> that the host is supporting. Initially we mask the virtualization
>> capabilitities potentially we might need to mask more in the
>> future.
>> 
>> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> 
> Hi,
> 
> Interesting. For WHPX on Arm, what’s done is creating a stub
> partition and extract CPUID info from it (with necessary guest stub
> code if necessary) but doing it this way like HVF x86 does is
> intriguing too…
> 
> Is this future-proof or are there catches with this approach?
No, it's absolutely not future proof.

The difference is two-fold: first, HVF on x86 essentially implements the 
hypervisor itself.  It operates at the VMCS level and is a mix of KVM 
and "regular" QEMU code.  Second, for feature leaves HVF lists 
explicitly all the supported bits and it also limits EAX to 0xD (it does 
not try too hard with AMD leaves at 0x800000nn because HVF x86 is 
Intel-only anyway).

So, what this patch implements is not like HVF x86.  The stub partition 
idea is nice and more future proof.

Paolo


