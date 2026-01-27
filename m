Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B76D3409C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklnz-00049Z-5R; Tue, 27 Jan 2026 11:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vklny-00048M-60
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 11:20:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vklnw-0001oH-Fb
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 11:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769530835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEBTrGQkkqP8wNomeQEtwo5EbiBN3W4S+Y3APZWO3f0=;
 b=YH971JOHGmHaqk9UtLaxCOAG5c2so4HSTpOtLw4GwrSoTAi0wEwh26WLJQ/iYtJlJpI8D0
 pPFQeTqFwCXYzS3wORNz/C+dfeJZ7I1B5AavYAhgsqdUGBoGugsAZOHDqr/qd1kSOlpBMt
 SAfBxHXSxuMSwxhNSZLU+37EfRCreWQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-eUWTL0CnM5OG0p-1xcm-FQ-1; Tue, 27 Jan 2026 11:20:33 -0500
X-MC-Unique: eUWTL0CnM5OG0p-1xcm-FQ-1
X-Mimecast-MFC-AGG-ID: eUWTL0CnM5OG0p-1xcm-FQ_1769530832
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6582edb3894so6877857a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 08:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769530832; x=1770135632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mEBTrGQkkqP8wNomeQEtwo5EbiBN3W4S+Y3APZWO3f0=;
 b=Htsyr0BhzMC2lhv1pbjDApYe+sUVM2310ak9SpPmBN64dpndH+6XrAycKGArledFiE
 B7gmznPmRy0Hk+J5V3qGM60ZFPJUdvwafdg2g6ZyZTplpxg/ZJ/sS7Pw4ihSKiBCL2E5
 BagUUdRqHdtsDaWVXNhWLVUeuZwHV2Qu5kY4QYDTplvOoKflx33Sxtl3rNmuPrYiIxK8
 Xlhft34D3e7edwBGIMRopi9CBt12lg7jKLb5sUUJzQqEtJuaRMi1sr83LmrvSnzSVA56
 hHfCChakMeiXxCKrPce0ySvB2s37iYzMLBmIZVEbhaQSYkwke+7Ax/BPmuy9jYkfgmYC
 QsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769530832; x=1770135632;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mEBTrGQkkqP8wNomeQEtwo5EbiBN3W4S+Y3APZWO3f0=;
 b=V0FCDMt55bysw5pwij0Y6lVo8Gwajk30xct1xrBUsvHgynlrfEOUwlcILaQ1s1KYCe
 6e1184AihHXswMEESQzcchhfwy9dSjJ0RYIaE6WSI4553wnTDpffRJnD914bhl0gowYy
 +YfXJ17TpSKcyTkFdTSs+IO/kfrb3CrVH20I5yO4KPHo9tpK0HgX1juXCRYTm464Tll6
 X1LOjecSlP/0sumZHydZKP/NrimTQtaR7Z0jv+oXarayqoABG/vfcfknG7ImbgW+Uuza
 zUif2OnLYp1umLW7CW/IkQt6r9eep5rPgMAyshDKHsIOF5i2Cy2h4lA6fzuNdmnBA3Rf
 Zl7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6iiuSrpB5tHQR+HWi+Ic22y7EO+XMYIya5BR3lvhUDxegaGlugksFGccbM5CZSh+fFcN7aO0sqy7a@nongnu.org
X-Gm-Message-State: AOJu0YzIqCfWxZyhv8FmrUvr9kpmmw9FoQ4zR2eLS8oyF9fS26RxjWst
 xqBkUfeqhqh6kDYKncSeZYKPAWIdxHzYw9dvTOif7vhm24sihGot5rwX01naGertWSQYFdXOdKf
 vD6Mg38lq5mOhnRg0S7HNejYJGddWcKNGMjabuAy2/i3fZvaat7duXULU
X-Gm-Gg: AZuq6aIKmomlq/IuR1qvQgPqtG2d97oYC4XLUdUTxcixbkiScAdXYMH7zP4oodW0YPI
 FRj4n1TQ+ZuxUWXEbr7vmuKSgBDWhQTA/gIHG1rkl5ytq1cBVx4qkznd/aFLjIXiFQoLDTISYQ4
 iRca+RFJALU2iajdEF3BKkEdM9IQubH8NVal440EGwosxXH+LMDvn9KvbFf6J6N+lo3hY6NVsRv
 +S1YXRfGzJiVKmf6/UoOaDxZ2WzUmh83bRtBSfQQJUNouvDhyERd0y8Bpr7kNQ9vAoq1I9JuetN
 VDkTnE+Ay3SVBQy1/kKNTwK7k8pxulDN2nQgU6ROrQvSexwZQDRbOBzTrFIXaQ3oS/acev36wUC
 hgVz672gTXJKDaQ/hMosDgbKhfOo9l09NPZYNOxodlqmmrj1JVmz+2d3N3rZS3j5KNwo/9YMJwf
 ENDP5a/wAOfIY0rA==
X-Received: by 2002:a05:6402:40ca:b0:658:3b35:4b25 with SMTP id
 4fb4d7f45d1cf-658a60a157cmr1381096a12.25.1769530832253; 
 Tue, 27 Jan 2026 08:20:32 -0800 (PST)
X-Received: by 2002:a05:6402:40ca:b0:658:3b35:4b25 with SMTP id
 4fb4d7f45d1cf-658a60a157cmr1381078a12.25.1769530831787; 
 Tue, 27 Jan 2026 08:20:31 -0800 (PST)
Received: from [192.168.10.81] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-658b469eb9fsm68597a12.28.2026.01.27.08.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 08:20:31 -0800 (PST)
Message-ID: <5ca27c45-7434-46ba-be3f-517312d50a15@redhat.com>
Date: Tue, 27 Jan 2026 17:20:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] rust: add CMSDK APB Watchdog device
To: Mohd Kashif Khan <kashif04x@gmail.com>, qemu-devel@nongnu.org
References: <CACSvEXav8Gn3DL4TFMCV4nMR2BFDHT4=1Yjhq77=Eb3DryPbkQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <CACSvEXav8Gn3DL4TFMCV4nMR2BFDHT4=1Yjhq77=Eb3DryPbkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 1/27/26 16:51, Mohd Kashif Khan wrote:
> Hello,
> 
> This patch introduces a Rust implementation of the CMSDK APB Watchdog
> (originally hw/watchdog/cmsdk-apb-watchdog.c).
> 
> The implementation functions as a drop-in replacement that:
> 1. Implements the ResettablePhasesImpl trait for hardware resets.
> 2. Uses BqlCell for thread-safe register access.
> 3. Maps the MMIO read/write logic to the Rust MemoryRegionOpsBuilder.
> 
> I welcome any feedback on the implementation or the usage of the safe 
> bindings.
> 
> Signed-off-by: Mohd Kashif Khan <kashif04x@gmail.com 
> <mailto:kashif04x@gmail.com>>

Hi, would you please change it to use BqlRefCell instead?

Also, right now the device is added always to the build.  You need to 
add alternative configuration symbols similar to how pl011 has both 
PL011_C and X_PL011_RUST.

Thanks,

Paolo


