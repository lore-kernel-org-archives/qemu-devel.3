Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA011C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 12:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tevA8-00036e-GS; Mon, 03 Feb 2025 07:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tevA7-00036I-7v
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:02:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tevA5-000186-OU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738584163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qVyoyKflWLfh67/Td8mQTMGptH17tmuBSPnE2dyo7II=;
 b=ZFPLZ/917CLHhBEXPz3PSUlqmSJspHzIyOOBuJsAWkt/bzhG3m7SFNHVpC6sOotnob3ujH
 qhaNtm+4GKOk9KbJn81ZvRNFqWVeMq66YFqTHQmZ2Z/ijU/mOeTTLZb47g1TETeQjrOZtL
 MEIeKF2eNSOrQT4M93HKife0l6Rqj9Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-FEXcLHBGNfu7tcXy3XQ4UQ-1; Mon, 03 Feb 2025 07:02:42 -0500
X-MC-Unique: FEXcLHBGNfu7tcXy3XQ4UQ-1
X-Mimecast-MFC-AGG-ID: FEXcLHBGNfu7tcXy3XQ4UQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38629a685fdso1779045f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 04:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738584161; x=1739188961;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qVyoyKflWLfh67/Td8mQTMGptH17tmuBSPnE2dyo7II=;
 b=ui2XpVNJJ4J28qQf8R8chjR5ekskqKOkUbAOHglXgQ01kKuZ8U++Ee2sOsPqxrkYwf
 LJkAtURFA1Fup6b8SW8kh9MovFuqoVJU+OLBMYmK/LgPHjsUbTOxYQNyxZ2ywWUNRC5/
 F5EBPdLZKUVPi3rOHLOciwZwprqXqDZVtOrWuDcFy/DCGQCn/nS9eGGMrsISJp4NVotf
 38wHhuuN36SBqJU4H3hDwvkFL1pXi1VIP56JVvX58Y7mcTeT8YDsyI8itVxqwSOT6hty
 +LCRKuzK0HANKCDUJV4A76O3gGx+bN7kAZjfJLP0lVIzelfdExaw4nUon8Ts28rCig6J
 kp4g==
X-Gm-Message-State: AOJu0YwvhWHDdOLrTU8Nha8ttdhfZIMCzZ+J+Er9G9bKmS0L3zVvtplR
 NyeXqPxxUvgTsczOLvKpVDQkgpNmxFvo6MZtRGLbty++Gm7uT66bhngO0Hkq3WhYZBK10GhbTh8
 KGPIkoX3lc7Kbc5O0OX7mDZtP3yi2Onb0DdBk3kbdpQma1r5wYA2i
X-Gm-Gg: ASbGncvL/86i+LYkqLx50Kw4IKiOYLOf69eiBjQx6EGqcZKX/9bi6aXNPbg6kTrQwTj
 XTBO7vXblZN8usuySsjFLRDrn/2pCr4pGOkkTIdrnSzbgAIrYV1AK3NXI74cArPMaYWmHZ6RAzH
 gqzJLutHVtC1f7EcXz7gbxN6PbMQXSgIK91fWTujeov6HFthQhuNQreqhaUW0TvKBiH8SZIAANL
 xLbIZwke03dP7w8/L1kx0tEzRHbacf2meslarLWFIfn+AhaZTe6oK3Vt/EXHl5o1RUJ3W4wxhdG
 oSK5RQ==
X-Received: by 2002:a5d:64ab:0:b0:385:f7a3:fea6 with SMTP id
 ffacd0b85a97d-38c5195f6c9mr18782133f8f.13.1738584160943; 
 Mon, 03 Feb 2025 04:02:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES/YbunIhrEZ5GhJM1YKi6yFGzyij85o7ZkAM5TJHxQbjWdEWKoAEduKL5NU8w1EkbdtJ6iA==
X-Received: by 2002:a5d:64ab:0:b0:385:f7a3:fea6 with SMTP id
 ffacd0b85a97d-38c5195f6c9mr18782100f8f.13.1738584160618; 
 Mon, 03 Feb 2025 04:02:40 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102bc0sm12727276f8f.35.2025.02.03.04.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 04:02:40 -0800 (PST)
Message-ID: <a1aceae7-4ab9-490e-897f-8a14992c7341@redhat.com>
Date: Mon, 3 Feb 2025 13:02:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/i386: Fix 0 * Inf + QNaN regression
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250116112536.4117889-1-peter.maydell@linaro.org>
 <20250124172224.815473-1-pbonzini@redhat.com>
 <CAFEAcA-191pk0zeUP5-=Z6JFJitPzw8cXwcVerYLNFrLGRQa0g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA-191pk0zeUP5-=Z6JFJitPzw8cXwcVerYLNFrLGRQa0g@mail.gmail.com>
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

On 2/3/25 12:05, Peter Maydell wrote:
> On Fri, 24 Jan 2025 at 17:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Queued, thanks.
> 
> Thanks; do you plan to send a pullreq with these in soon?
> I ask because the Arm FEAT_AFP set is now ready to land
> and it has a dependency on these.
I do but if you want to send it yourself, feel free to include them.

Paolo


