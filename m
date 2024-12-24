Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7931DE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6tv-0005ev-Cx; Tue, 24 Dec 2024 10:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tQ6tt-0005ei-VH
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:32:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tQ6ts-000624-J9
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735054367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LsjkuRBBttKS5dDHbwtUybu0HEbtAQyKBO1ZZH89czU=;
 b=gn0l3NUSFbspXzLgz3RQVjhjP+DWgQzDJ+OLbgtM+4SIKO3m67/uogFK5XpGhFYJb5eEHm
 PKQN3blSE4vlxZs/YtBSSAy68K8UpU5eZOxNQW1AdfYbMtPldo8Krrd8B21G42pXz4yyJ+
 FE9Mqf6R4M9j1HIG1SsH5vrHCHNGd5A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-Mghqi63QNlmu9N-4XIl0sg-1; Tue, 24 Dec 2024 10:32:46 -0500
X-MC-Unique: Mghqi63QNlmu9N-4XIl0sg-1
X-Mimecast-MFC-AGG-ID: Mghqi63QNlmu9N-4XIl0sg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e9c69929so2194692f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 07:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735054365; x=1735659165;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LsjkuRBBttKS5dDHbwtUybu0HEbtAQyKBO1ZZH89czU=;
 b=hFdeJTFR3+dl3ZldZ1BvgaIMxSb4asbznwDkMoGXvmjUW4gVJcF3z30NCy7ufWJKQC
 hhWNMB+uM+6+xZ92nfGPt4SNtgGx+tZuqrezJFTsmXWLrNqwmSXEJs8IncTq/kH9cMEX
 Rq3LPXkEr8ReZZPaDYOi0o4W4lBQ84RnhuPx4JUE+rctVaRZzmFvfvI3q2hjY+QVTduO
 8X2cFXhmMV3HUn3TFYbT4CLLVMtNSTuOczgNhX/1RH6fPN9fswH9oeUubsKc3U8L7YIZ
 GoZpJqkCDaLPCwyJiidyBdLcT+vdVC42CQDUlW9IKbBBufhToS+wmF2PzFdZ5/azdPF+
 zxlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCK9xzU8n9WOWKSts672fZR+eu0OsVurFBocN01nCOPQVV1CA65P8z2Vs+JcUnc3ws/mVuc8SMgpgC@nongnu.org
X-Gm-Message-State: AOJu0Yz7mMLgDMf86TRKLqZZVJf4pUu3QgIhET8HvCdh98PQOgRUcanu
 TxFgLywmSn/1klxWF/DpaRUls87++TxcWYO58fzE8fWDamgTM9KAmAoedFTgJFGvjyYCzqmOAGv
 FL0xyXVM08TJfU84o7PUG1O5MnZSI/9T1RzFjnBR5uNMyZ3CSIAcA
X-Gm-Gg: ASbGncuedTofhNUlVGlvSTutSWniKp6IG6Re3tz3UK748GMMCQeyYJeUqFtpt3SPinV
 lIKcdOaubvCOVT9HlqrXD5eCr93y1oMu1IfZL8+tLyiAVYn/QBwMkHhgBYNVR6XUeILrwKJnvz0
 6yVFUzTMOiDcsW1eU5GOngGSrSBxVQozXZO0IBGfKmhP9+pqCiT9kxIc3e+YD5qo8C9pNcBgIF1
 p8S98xQTQO5cQj1IGuXBGYeTHN7irRShW1ySOcmPnkh+B+j18nvVfbTKsZi
X-Received: by 2002:a05:6000:1a8f:b0:386:4034:f9a8 with SMTP id
 ffacd0b85a97d-38a223f5c51mr13366133f8f.38.1735054365366; 
 Tue, 24 Dec 2024 07:32:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlR74QyzljNtLsUN0ihDUjhjueo7tcl12nKKAV/Fnd3xM7HvzOKCgCsRZ+z3U6rI8bhnooxg==
X-Received: by 2002:a05:6000:1a8f:b0:386:4034:f9a8 with SMTP id
 ffacd0b85a97d-38a223f5c51mr13366109f8f.38.1735054365065; 
 Tue, 24 Dec 2024 07:32:45 -0800 (PST)
Received: from [192.168.10.27] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828989sm14463909f8f.18.2024.12.24.07.32.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 07:32:44 -0800 (PST)
Message-ID: <af13d0c9-1d73-4cdd-8fd0-eff86a5711d3@redhat.com>
Date: Tue, 24 Dec 2024 16:32:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] target/i386/kvm: Save/load MSRs of kvmclock2
 (KVM_FEATURE_CLOCKSOURCE2)
To: Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20241106030728.553238-1-zhao1.liu@intel.com>
 <20241106030728.553238-6-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241106030728.553238-6-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 11/6/24 04:07, Zhao Liu wrote:
> MSR_KVM_SYSTEM_TIME_NEW and MSR_KVM_WALL_CLOCK_NEW are bound to
> kvmclock2 (KVM_FEATURE_CLOCKSOURCE2).
> 
> Add the save/load support for these 2 MSRs just like kvmclock MSRs.

As mentioned in the previous patch, this is not necessary.  If it was 
needed, you'd have to also add VMSTATE fields in machine.c

Paolo


