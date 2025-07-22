Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BC5C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 20:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueJMS-0000Y0-7o; Tue, 22 Jul 2025 16:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1ueJMP-0000VJ-L9
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 16:13:13 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1ueJMN-0001ne-OI
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 16:13:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso5159245b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1753215190; x=1753819990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yhLALA9B3rULq7Vw42aLBvPtSaoo7MaonmbLRVdlFf8=;
 b=D96h+G102L9B5jWGvgmD/ueoRXfJmjRbt1LuLf84o/m9lGk3niF4SWF0gvxkjCkF0i
 GatUQBf2WXiQGkwLWvxr1QKHkYDOk4i+RG524smH84NxNtMpYmYaREKe51sb5QNO06Xc
 tOZvOJ1IBEQx30hgse8rbvmhTdkt46hjhPPSGLHl6SijharL+md6XG+9bz7obscn6XLa
 kAl6ntAjtwGCoDKqyNUfRRFou0IAdS4tDGx/4TTuKSKhaDGS//fwIG+M73g6VyGeQST0
 EEtsXWJH+W7OB5m8wROIMsWJeub2+BeiQj5tw7jjh+GwRnYbD9/bJfxwG29z7MlflFzL
 rG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753215190; x=1753819990;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhLALA9B3rULq7Vw42aLBvPtSaoo7MaonmbLRVdlFf8=;
 b=Q+sbvtEuUOoeHOT6UiikNIlJ1kp7kwhO5cedlFc81RLqi7lQJ8eoiYN1GmyQy5JHuU
 oISAJZ9JkSsjIE9mMgM6Ta/bjEPYDsJJt/X1Ps28ML01/hqpYDJi/DJRqYJVUwfqSgsv
 I4j3GH49SQ377aEOWR7OMcBtIbbVRm6mR9/WHdAKjIrSisVP0a/5sne4Af7P4v8yfa6+
 Ex5qX6QU2PcJonCwSZr6g7fdhUc9BXAyD8Hxmphzs/n6U12nW9AuKN+qYLptOl2uw7s3
 oTtJQ8AJFx/DAMs4rBQdFkMffWYOOH1PR0aTjt9IXdsT4ioGkvQ6DHB5BTlIMOYFDrMT
 +8/g==
X-Gm-Message-State: AOJu0YwlWfAJro0TSKgkT4HlVQnS3IWAeMfqxAft32oeXHljk9K+cM0c
 ZX58py7jGBQKs57lXj5ZHSIf41/bXKTOkgXaiJA4XKmHLvSu++fRwLOkY4WqFGc7s5g=
X-Gm-Gg: ASbGncsrobZpLXTzZq8bH3Om7kvxsaC8YTiS2aWrr6DN4ukEckHwHblrQC9qGyeXIN2
 ZyPvtVgrxZBnmsHMPBPiuUQ9j7+U2XCbbi1MN5f6PKaerbctXAcjBya7zKLkdQ+AysJ2HVQjG8B
 jXFxiqz5Ch506qMB9XhtLU2wFCoWEbu/HrDPrfWqrq03TFHPYxFIi0kxsQBws9sLUI2D3zLdfYl
 yIu3hIVFYhA7HkeOVQi/2VqmtmoCrVVWkCAXew2d7L4wX9T+InurnwMYtgHI2um6y2yWYJrG4j6
 UpxrVO0H63h1qyLRTAkm/+RPSaCfJAOxLXOFUpSz7grk1wNXa7V5q3DRntE5K+D6dbJSei07Q0B
 JK6fzB1R1No26Td3H7JgT8oKquy9LvH9r+nIL7gkwY3URhi05z+wr62leJZckOWq1zw0XarKPy+
 8V0mkE980isMBtIAg07ayipWOuMNRPI63FahNdXn4Nt21fhe9GcKbLi+s=
X-Google-Smtp-Source: AGHT+IHYPk53nUChKVapkUHv3H9H6FTfDsjozDyj6Fty2m+Mis+ubcSsO3JOGJKE76bJMrILGMXHgQ==
X-Received: by 2002:a05:6a20:3c89:b0:234:8b24:1088 with SMTP id
 adf61e73a8af0-23d48fe0481mr291696637.3.1753215189831; 
 Tue, 22 Jul 2025 13:13:09 -0700 (PDT)
Received: from ?IPV6:2003:fa:af22:cf00:2208:a86d:dff:5ae9?
 (p200300faaf22cf002208a86d0dff5ae9.dip0.t-ipconnect.de.
 [2003:fa:af22:cf00:2208:a86d:dff:5ae9])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f2ffbce6esm7519095a12.72.2025.07.22.13.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 13:13:09 -0700 (PDT)
Message-ID: <834dd439-34dd-4cc7-a1cb-ffe3b95ec460@grsecurity.net>
Date: Tue, 22 Jul 2025 22:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Disable hypercall patching quirk by default
To: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
References: <20250619194204.1089048-1-minipli@grsecurity.net>
 <41a5767e-42d7-4877-9bc8-aa8eca6dd3e3@intel.com>
 <b8336828-ce72-4567-82df-b91d3670e26c@grsecurity.net>
 <3f58125c-183f-49e0-813e-d4cb1be724e8@intel.com>
 <aH9yuVcUJQc4_-vP@redhat.com>
 <c2d2a3e9-e317-4049-9b6d-b6b3027ddd6d@intel.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <c2d2a3e9-e317-4049-9b6d-b6b3027ddd6d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.158,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22.07.25 14:21, Xiaoyao Li wrote:
> On 7/22/2025 7:15 PM, Daniel P. Berrangé wrote:
>> [...]
>>
>> Usually CSPs don't have full control over what their customers
>> are running as a guest. If their customers are running mainstream
>> modern guest OS, CONFIG_STRICT_KERNEL_RWX is pretty likely to be
>> set, so presumably migration between Intel & AMD will not work
>> and this isn't making it worse ?
> 
> If breaking some usecase is not a concern, then I'm fine with no compat
> property.

Well, there's still the chicken bit `-accel kvm,hypercall-patching=on`
one could make use of if (and really only if) that's really needed. But
I'd rather have the guest see a proper exception emulation of trying to
execute an unsupported instruction than seeing a bogus #PF.

Thanks,
Mathias

