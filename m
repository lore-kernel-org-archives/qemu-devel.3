Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83575C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0xr-0008Qk-5c; Mon, 17 Feb 2025 08:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tk0xp-0008QK-Ax
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:15:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tk0xn-0006Qm-Fl
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739798106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YrGABxwwGZHT2B4gf82mLxksEB4xHLc10oRZplieXt8=;
 b=d9UPUIlZqaFjdXYSkw80/vMJOQuF0+IRd+rAIvfrF3Yl+kN7x6ex492vUt4pLzaWyniTyK
 n6acnsnIfK5uN6tI6+0IdoAR8Gu3WFIk7RQA9ozMm85UmJHsZIMfmki88LcRfRFo1Bwr2y
 vh6MfRCZge5Cb9gTLI+iMB0zqUc3QCo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-5QcKKyu0M7WpSoSsBMpsEg-1; Mon, 17 Feb 2025 08:15:05 -0500
X-MC-Unique: 5QcKKyu0M7WpSoSsBMpsEg-1
X-Mimecast-MFC-AGG-ID: 5QcKKyu0M7WpSoSsBMpsEg_1739798104
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4388eee7073so27089695e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798103; x=1740402903;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YrGABxwwGZHT2B4gf82mLxksEB4xHLc10oRZplieXt8=;
 b=uvJkGFcblt4JpwyQnIIasmS34XGK8zEPSKis3PFp4UTNSDTN8SwPfniI2bMwa6Nclx
 wxDcQer/aN3ok1+30HoSsg5mHowIAPIeOLI64MGviqpndBv/WyxEA7HbQtUtXgBfc28P
 JmHnxxz/QrJp76xPuKqJg/XJK9Uq68c8DEl9SnDy8oVegcZqFMcdGuKN6SVRsXzYDx/X
 a6aEc+lg3YkoWXM2yfJLP5Uib44pXDMiiYtf9JsUj/zgGrcihJLWYi8GKyU4qRTarbQs
 7Lo5PJ7P+aLvZLtBRUuNBnZq4Ooy7NfR5WcTk94BiC/4P3EK4Q/kKmEoWRSXb80GqeI5
 /K/g==
X-Gm-Message-State: AOJu0Yxz6kZ6li6ydeFFmEeZJCWf+t8xQsBcPpM4x3TSmJWiM73ePncu
 mgm9fsnJw/IqqpOIF5Fmc7irXMsch6XxmdqxQjot4YmbOJVwLcc5c8OWiekMGMX7GJcbeHqZ7Rl
 TSO6AhNuPf3D7LpM+7ND6GFMgcnnZ/X2/+WL/WldBGJ1Fh+oGZ6P9LST/rIKYjJQ=
X-Gm-Gg: ASbGncvsu4ZR3TUpHvTiPJf0rhDvcFRFq3QGfyUjjSwpZgXw+3RnyKi4NLgmqjr6iA1
 wk+RNAu+hB6uBGp7irlRoagyNO3ZIBKtmkaBpziM79iadzn2FGPDcU4KkaP6Zbc6Rgl15JtPj53
 fIMY0qDISEeDVsLr5m4Mu8Za1uOc9AaGeYi+V+XNBoTxdYFizb/64IZxQkEtSNSxxvqleQ2+1Pq
 3xBxfPmT0jt8FE/IztgWatKLMmJX8wf+izP/2eUnL/DJBICzYra8RGK4n6kJyWkLRBEAbD+mC0+
 akat+N7eetA=
X-Received: by 2002:a05:6000:1fae:b0:38f:3aae:830b with SMTP id
 ffacd0b85a97d-38f3aafb43bmr6683000f8f.26.1739798102980; 
 Mon, 17 Feb 2025 05:15:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBoHrZPTR405Vae9+juiOk2LJpDLXBKm20dfj6C0IPo0AOsc6hvD715JL/m1NmhqtbY66Bkg==
X-Received: by 2002:a05:6000:1fae:b0:38f:3aae:830b with SMTP id
 ffacd0b85a97d-38f3aafb43bmr6682976f8f.26.1739798102651; 
 Mon, 17 Feb 2025 05:15:02 -0800 (PST)
Received: from [192.168.10.28] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38f258ddbe0sm12386062f8f.39.2025.02.17.05.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 05:15:02 -0800 (PST)
Message-ID: <b5eb1cf5-da20-49f9-8663-c5d27e00378c@redhat.com>
Date: Mon, 17 Feb 2025 14:15:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 23/27] i386: enable rust hpet for pc when rust is enabled
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org
References: <20250213160054.3937012-1-pbonzini@redhat.com>
 <20250213160054.3937012-24-pbonzini@redhat.com> <Z7MXkxoMC/xpLiL2@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z7MXkxoMC/xpLiL2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/17/25 12:03, Zhao Liu wrote:
> Hi Paolo,
> 
>> --- a/hw/timer/Kconfig
>> +++ b/hw/timer/Kconfig
>> @@ -11,7 +11,7 @@ config A9_GTIMER
>>   
>>   config HPET
>>       bool
>> -    default y if PC
>> +    default y if PC && !HAVE_RUST
> 
> +
> +config X_HPET_RUST
> +    bool
> +    default y if PC && HAVE_RUST
> 
>>   config I8254
>>       bool
> 
> This patch doesn't enable the configuration option of Rust HPET for PC.
> 
> Is it because the Rust HPET would break live migration, so we have to
> disable it?

No, something like this is missing:

diff --git a/rust/hw/timer/Kconfig b/rust/hw/timer/Kconfig
index afd98033503..42e421317a5 100644
--- a/rust/hw/timer/Kconfig
+++ b/rust/hw/timer/Kconfig
@@ -1,2 +1,3 @@
  config X_HPET_RUST
      bool
+    default y if PC && HAVE_RUST

I haven't checked if this passes CI yet.

Paolo


