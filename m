Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5894D74969
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 09:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWWwL-0003Rk-L6; Fri, 19 Dec 2025 04:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vWWwK-0003RW-He
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 04:38:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vWWwI-0002Vb-TA
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 04:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766137102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Avink2tMPjpbdCDWU1EbkTNExSGwx7k9UAdsPnFW6Zs=;
 b=W7kYua8kSX5+iluFEUmmRKJfBNjaI6hmPEEk3myAWMT2bIQE6DFTklojk7pNtGzbLrF020
 RCL7O4fXtvrE2ADABSZIroUfe+c2cgLiT0YSBUMkfrZpefCgGffgZ6uatsj66KRyEJesAj
 Bq+hWohQutgJCARrykAethAQaxmvh/8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-wiEqWJRAOL2zlSPArVUasg-1; Fri, 19 Dec 2025 04:38:16 -0500
X-MC-Unique: wiEqWJRAOL2zlSPArVUasg-1
X-Mimecast-MFC-AGG-ID: wiEqWJRAOL2zlSPArVUasg_1766137096
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-432488a0ce8so1047157f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 01:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766137095; x=1766741895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Avink2tMPjpbdCDWU1EbkTNExSGwx7k9UAdsPnFW6Zs=;
 b=RlFm9x4CAqv7ZOJ//MC5nL/vxKIwgt+3BLF+9QMUtmRgs2Jp3s3j640gDyHrNz29Ca
 7UXZDDN0dVZ4pANA/NsBPx7PApjvaTLyi9S0R8XdPMDwOiE1ztemZBUi+MklzYu2IBIP
 JSWprelRTQyvL2+1H27SGnM1BxVpDroacv9I1c/yMuuRbUWg3NFofW8YK6yffcH83u88
 iQAXl2Xb7mjK6DGxvcGC7HHDwRG5UstWBc+u0q/WvEdnmr3U6WZFr7jXA1NNIS5Upl40
 hxJ0d7IdtIF/a3Fn2UNG/f0lbrAQeodbq3xgUgMO6xz7HO54x0PnWq+JiT2IysT7WXNR
 Q4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766137095; x=1766741895;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Avink2tMPjpbdCDWU1EbkTNExSGwx7k9UAdsPnFW6Zs=;
 b=KOLY8su6kfqcRBnliRlL3LHDgvlTZUfsb1KQEUNiAcqlWyRn0hjqhwyQ+1E21PlvnK
 BYc109OPlT01di+9LEUy85vpZfv9cRVVnL4V1jbdnIKEhE/EsdHAURnExlmmD4hTQ2x+
 RJM0QWRHoBHHztBjII360DebI/wOMUfgb55EMr2lFWMuINnKwL6Nd/brpuK+JmNlkMix
 FbnR23ymYwK1WGUbiWJl1qkRzcDRdFp5o86Tnvr+RAi8VW9I0ImhU8M3uzZfgUP0AjJD
 7fusS4K7j2EHA+930TvcHSTus8FXcg98PJ8jmJLnKI7eg3j7hapvFzNZJxgSyUpU2kJe
 UsMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFJA8lzl47ODNXaHY/0g3QoMUwL6UIf4EKBkX31amHYi+3BgrUHen8L8vDrgxspJ0QDUzEAR45RgG2@nongnu.org
X-Gm-Message-State: AOJu0Yy1u8Y+bpR95CcXYMXDfYAQw2H2C4jFePuPv41t3g+Ka43PMfEQ
 728kPwSgwhGZqdhU0rNBWLazeTsopVDun3LwagPF+ZurUqi4QKm3tHT07VhxO9o/fmRZexqSBSG
 PayofvZrzM+cMZjnchsW1V618tLlWPg3WiBgHKn3/zCUGd4JINplTLKOG
X-Gm-Gg: AY/fxX6KJw8PJmAGxeX01WcUIxZH733xbjB9QjTj2Q6RiC6dDSV+OU5O4lQ/fYeZJu8
 gUAIbB9hfx6bRDOMzdHLtAgUQ5zaXf1yP6o2Irj6IkJDPAS7AEBI4b3aaMoP8fZB6LlNn1nMYEv
 rnFHm3LdvaJJ5ync6rN0psBr74MlXVbdDtH8oRFSw2rJBg5Biqb6uLfe1NGJ8McHpUE+ItoO2pg
 fHqQ/iRry2q/PHs07K293tRV2XTmH9Q/ZJU7vU0v9lso2rx6PRmv0PIdpnSkG98tdDu8FgUwySl
 a0jX+GL3kZJFi0iZBoxA/pTDiEyCLIdOKXoLGXU3IhsuDMPcZxg1u86zW2QoSio5R/t5yY7TN6J
 jpasPw/M=
X-Received: by 2002:a05:6000:1a8e:b0:430:fdfc:7dd3 with SMTP id
 ffacd0b85a97d-4324e50d781mr2435644f8f.50.1766137095648; 
 Fri, 19 Dec 2025 01:38:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlP0Bp5D32dZdvlwWP74n6vsF4dpQ6mCV6U3jc5oy4mUDNuFggCNJ3OtTv4vq4DDeCvAHhcQ==
X-Received: by 2002:a05:6000:1a8e:b0:430:fdfc:7dd3 with SMTP id
 ffacd0b85a97d-4324e50d781mr2435622f8f.50.1766137095267; 
 Fri, 19 Dec 2025 01:38:15 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b36fsm3915867f8f.5.2025.12.19.01.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 01:38:14 -0800 (PST)
Message-ID: <0da41936-484d-4ea0-ae69-a0d98c66c16a@redhat.com>
Date: Fri, 19 Dec 2025 10:38:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: Re-enable the MAX78000FTHR machine in
 qemu-system-arm/aarch64
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jackson Donaldson <jcksn@duck.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20251218214306.63667-1-philmd@linaro.org>
 <a8a2eec0-f458-40e6-bfcc-d51be9333799@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a8a2eec0-f458-40e6-bfcc-d51be9333799@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/12/2025 10.02, Philippe Mathieu-Daudé wrote:
> On 18/12/25 22:43, Philippe Mathieu-Daudé wrote:
>> Unfortunately while rebasing the series registering the
>> ARM/Aarch64 machine interfaces and getting it merged as
>> commit 38c5ab40031 ("hw/arm: Filter machine types for
>> qemu-system-arm/aarch64 binaries") we missed the recent
>> addition of the MAX78000FTHR machine in commit 51eb283dd0e.
>> Correct that.
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Tested-by: Thomas Huth <thuth@redhat.com>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3248
> 
> We have a functional test for this machine
> (tests/functional/arm/test_max78000fthr.py)
> so I don't understand how we missed this.

The functional tests are skipped if a machine is not available in the 
binary, otherwise the test would fail if you'd configure your QEMU with less 
machines.

  Thomas


