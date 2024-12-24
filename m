Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC63E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6t1-00050t-3X; Tue, 24 Dec 2024 10:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tQ6su-0004xe-M7
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:31:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tQ6sl-0005nQ-7M
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735054295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sttA86JlVJRPGR1pZfidlTi6I1TCvbAFziqdjrjC9pk=;
 b=hpBS6w/U396GkCa4jjI+ojdGx9IaLauhzEaF8J+Tvv3XPjuK2UgMxKkboACPCxJe8M4b2+
 oE8s4LXu9KuUl4X4E9WqQF+O+eMFmDMqrIVTaAOV7WQjqd/orY7gQgItxFw2Jf3IyHiGiD
 qDMCX6jEXiTKpy6180IRBN23loXz4Xg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-jOQfo6eKMO26dy0y12E8hQ-1; Tue, 24 Dec 2024 10:31:33 -0500
X-MC-Unique: jOQfo6eKMO26dy0y12E8hQ-1
X-Mimecast-MFC-AGG-ID: jOQfo6eKMO26dy0y12E8hQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-386321c8f4bso2878665f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 07:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735054292; x=1735659092;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sttA86JlVJRPGR1pZfidlTi6I1TCvbAFziqdjrjC9pk=;
 b=Skh1Mn+ypSM4JmKkM9htEJc1oTn0Kjw1bBU92wKOttDPsTnPNKL4Op8TCK7lnuDQyM
 jZMz5++SGYb/lRBuhUL6SQOBp9flZ3Cih+sM7eHQZycm3a5W05Mo1A4bm7W9KqfXCWLv
 AgrB9YQDvqsP/5hf34LmzSlph2qjAk5wj2ylItjNqdiuDDyY1mbMZy5m3nytrfvBAgST
 wZZcR+bAtYhCkr/81UUa+fxFukC7eaO+Yk5cDndtK+GXuNtsLfHYXRJvrLsvLNl5m4Qe
 7r38EO6jXB8L6wRNUufIPUeakNWEh09aOYYkWNnxfMfWtlIEzMAzGJfgh7dSR0+JvpSY
 Umaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnzt6Mj/OJv81pl/yMuPhoE0lNSgRSzwC+KK6+uLDndjFtPuJTkshM0KpnKmd6MbSwu+r2DiO40v6z@nongnu.org
X-Gm-Message-State: AOJu0YyYdPJHwevK0Qi2UHKGi36fc883nV5X2/394ShbvtG64hA6MRc7
 EAVn4mUSh361RVhVFodAOgURbuw3q+OK7RouUA4FeW7p/mPBENnOppyCIlJeenbjIVgGUpVYgew
 vgQCO9Yw9LETpziLp1cxMl8k5MCvZ3s7A3KnAd4bZUEwRVsYxK5se
X-Gm-Gg: ASbGncvEzCdmnhUvXCPoJGadWIh9vyA791+JbFt9VGRd8kTz1EJL76+BpbAWPFFFk/a
 odE3QmyVkWu0CxLWu8OZic+ya9SF0BKEz5zzXQuKpALEsX7g32XYcUiuTEVD/MXFMjaYeqVHmao
 xcJsS4CM7ezbBUh0yZXQfn1aG7L2L6GUVoQN0Erdyq7NLSE1BRFZg/mnvUQyuYr7xGDWVQJU6ke
 +Ru9afgTHpyiUMTeTuAYhpLgqJPvkaF6dVXkwR3PqQtz95Ut8v0uvJWSomI
X-Received: by 2002:adf:a453:0:b0:38a:2b39:679d with SMTP id
 ffacd0b85a97d-38a2b396927mr5880316f8f.32.1735054292542; 
 Tue, 24 Dec 2024 07:31:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjDev92cI1a9hEfMDA+fr2hM4oSjxKaQxdL1upD0q+0U/fRFDrGLeO5ylm0YCPlcX6RSvckQ==
X-Received: by 2002:adf:a453:0:b0:38a:2b39:679d with SMTP id
 ffacd0b85a97d-38a2b396927mr5880306f8f.32.1735054292219; 
 Tue, 24 Dec 2024 07:31:32 -0800 (PST)
Received: from [192.168.10.27] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8292adsm14314648f8f.19.2024.12.24.07.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 07:31:31 -0800 (PST)
Message-ID: <9d60933c-4713-4d61-b11f-64d4bb667e04@redhat.com>
Date: Tue, 24 Dec 2024 16:31:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/11] target/i386/kvm: Only save/load kvmclock MSRs
 when kvmclock enabled
To: Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20241106030728.553238-1-zhao1.liu@intel.com>
 <20241106030728.553238-5-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241106030728.553238-5-zhao1.liu@intel.com>
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
> MSR_KVM_SYSTEM_TIME and MSR_KVM_WALL_CLOCK are attached with the (old)
> kvmclock feature (KVM_FEATURE_CLOCKSOURCE).
> 
> So, just save/load them only when kvmclock (KVM_FEATURE_CLOCKSOURCE) is
> enabled.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 

The MSRs contains the same values as the "new" pair; QEMU only has to 
save/restore one of them but the code should be active for both feature 
bits and thus use

+        if (env->env.features[FEAT_KVM] & (CPUID_KVM_CLOCK |
+                                           CPUID_KVM_CLOCK2)) {

Paolo


