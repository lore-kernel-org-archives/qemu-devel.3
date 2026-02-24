Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F266E9B248
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 09:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vup8K-0001AV-DJ; Tue, 24 Feb 2026 04:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vup8I-00016V-Sg
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 04:55:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vup8H-0003RT-31
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 04:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771926908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GGbUwPmGQVUFZv0POoe4yf0KJlx8pnnBQvEspqTSCE=;
 b=IVCnsKOsSrR9dHwcOQAvDeKysqi6RD4/DDfUKZPNv0XC/QnAgUCmWG9tFVzdFk7DCYkzHB
 0xq6KXHuHkPWam8TK1xfhJnAnzyC5CPnfyWUHLl+bidduFuKuseASVbFmZbFQPMcB7jtL8
 JEYgHzXMiaWp5rcuhJWO3a+OCS8axA4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-6d3ub2RPPa64Pqo6X64VOA-1; Tue, 24 Feb 2026 04:54:59 -0500
X-MC-Unique: 6d3ub2RPPa64Pqo6X64VOA-1
X-Mimecast-MFC-AGG-ID: 6d3ub2RPPa64Pqo6X64VOA_1771926898
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4362456500eso4864484f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 01:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771926898; x=1772531698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3GGbUwPmGQVUFZv0POoe4yf0KJlx8pnnBQvEspqTSCE=;
 b=JHMA7HThy4T5+pn/lNGJ1rWlnhJojW8z73YZFlqHhCZVRozdEATHA8Y3Lu6+hyZ1Ud
 NUbePUvWk8xKb59tRS5zZtsZlsNT+rZTxRGVJ6wAsluW/RVXWKa/7+mCWnY9jIrGnwDa
 6Zqelmh+C5YRFD357ctnfpdQlzHNFqS0x8h6nPd23hCfdcAWyCtsDrE+il1E1NvIxAY4
 ZU3kbq26ozPTOgFnSzS4Fx5S4zkSDAx1rL0WVzoABHUoOFfQPBxya0QKxFPn/dhn9Q+q
 Q1WK1aeSUH4RAIICoeA4waW1vOwGzNQi3IWb5FlSd8LZnGrZwc4WvTga4Rx0bk4jIHzU
 SjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771926898; x=1772531698;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3GGbUwPmGQVUFZv0POoe4yf0KJlx8pnnBQvEspqTSCE=;
 b=Q0CZIiOfrZ/QhmeZRZ6aLtclXAAaXJHqX2HR5YX3V5A5hD6JnARIrei19GFNqWnlMM
 rLSCjOgLIaqo/ta0qe018SBB7r/27u0qptRO2+sBKMiV+9a2q7tR59XDb5Ypw2lblGhM
 8gPMGydiADCf/W+q8CZYHSCsdw93D8n1vxkWX7aYU36MzObCtSB5DQhHyrUucASdziOm
 P/lKveIJyC8vDm+KPrkbpQoXBuCpShvihI3SW7ndkeoa82pq+7/T3DSrd1HQTyu7j083
 SqEvmJMqj05xVnN+XnNNlOYCpcn8h9BSzt0euWTpEkxcGqZ2qTUugoM9uvqtQvI/KPSr
 IPLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6FfkBR1HYKa1xTf6Vh+xy5NJr7V5ebnXml01wd6Gtr8HL4A/okiauOqAyoQq7nuq0VKF37gdEooxH@nongnu.org
X-Gm-Message-State: AOJu0YxE+f7VYyu+Nka0M0SpZHil3UMOzaBN7wlEcowVJfsR1b/2MOpr
 BQJmFepMeX/ph+xltbWkJr2zZdgcCFyGVmDQssOy3loIZDP7Fi3KV80soXnXTiu+/jfuhvYo9nD
 pT/KLiJm5aB8W2kOf+hLwDW7yfxVaduZQRrYI+L1GUGj18yFsUWhvXpuS
X-Gm-Gg: ATEYQzwJr7CHZzBOt9Z8JbP5jb5prU9d8bDpa+LtFN5zMwYEpfjymSgT2tpVMo/k/ge
 eqB+tIl+YtpUfLrpGN9sGPjFzyYMKWsN9kSb3xPlHWD36Me3Zdz/Di8sShVPeERckFAPYPF9Xzo
 NzlWIxcRzDHuizDrlrBX1x//2KuZ0FDQ2XbQRIM1fzQTKEFP3sxDJJ4WQWnbil2e8dJHGk3b+zG
 bBO/t5hLxoJwUFfQvgBqviE2Rd73z6OdX0p40wTLZ39ZNtSl0voqq+A7KSIbVFBL2UwwmB3gJ0b
 eYqA5SGkyFspHbGhV4q7WoH6lNiSvvYA5PPVOTMIak00WYJV0Xh9/hS0KH/zXkfdru78km0o9bu
 Oz2fZcrshNMQWTCUWUO6aJGrT2xhcz9SZIgeWt5wwx0LFTavOZxuj69ucTbM6mIlNmv2Gt1eD/U
 J027aBVvnMYtn+7nAalyGd7k9eyg8=
X-Received: by 2002:a05:6000:2087:b0:437:6bda:d97e with SMTP id
 ffacd0b85a97d-4396f17b10fmr20285427f8f.39.1771926898366; 
 Tue, 24 Feb 2026 01:54:58 -0800 (PST)
X-Received: by 2002:a05:6000:2087:b0:437:6bda:d97e with SMTP id
 ffacd0b85a97d-4396f17b10fmr20285377f8f.39.1771926897858; 
 Tue, 24 Feb 2026 01:54:57 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c626sm28440153f8f.28.2026.02.24.01.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 01:54:57 -0800 (PST)
Message-ID: <a1872a68-0eaf-4061-bf2b-ca1c567357d6@redhat.com>
Date: Tue, 24 Feb 2026 10:54:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/28] whpx: x86 updates (2026-02)
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/24/26 00:39, Mohamed Mediouni wrote:
> It's a bit of a misnomer, but didn't rename this series to not cause more confusion... should
> probably have been named more like:
> 
> whpx, target/i386/emulate: fixes for target/i386/emulate and move WHPX x86 to it + WHPX misc fixes
> 
> Should have probably put a bit less faith in the state of target/i386/emulate from the get-go...
> 
> In guest OSes compatibility: Win9x works now (but is not too stable...). I probably recommend using -M kernel-irqchip=off
> for that case though as it apparently raises stability (a bit). Win9x didn't work with winhvemulate.
> 
> 32-bit Haiku didn't work for me with or without this, with an invalid bit being there in the PTEs, but 64-bit Haiku works.
> 
> On the bright side, this series should fix a lot on x86 HVF too...
> 
> Some questions/notes for mshv:
> - On the model of the "whpx: i386: inject exceptions" commit, also have injection of raised exceptions for
> the MSHV backend for this all to work as expected.
> - I removed the reliance on the Hyper-V GVA translate call, which is a very slow one. If you want to add it
> back instead of using the QEMU target/i386/emulate page table walker, there probably ought to be a way to reduce
> the number of calls to that...
> - but emul_ops has a new mmu_gva_to_gpa call to enable this case to be implemented
> - la57 code is not exactly tested
> 
> And in missing things that are probably a better fit for a separate patch (series) instead of this continously-growing one:
> - I don't handle privileges for the page walker in target/i386/emulate
> - and SMAP/SMEP for it, with complexity they might add to the picture
> - and the same applies to putting the reserved bit on error_code for erroneous PTEs

Yes, these can come later; maybe the TCG page walker could even be 
shared with target/i386/emulate.

I'm queuing this thing but please take a look at my remark to patch 25 
and I can squash the diff.

Paolo


