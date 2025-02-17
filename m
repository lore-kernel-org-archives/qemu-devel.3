Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C1BC021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 17:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5C2-0004Un-8g; Mon, 17 Feb 2025 12:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tk5Bz-0004S1-DO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 12:46:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tk5Bw-0002ck-46
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 12:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739814359;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bARpz6GEXYVosp14t8tSmIlTn9yfAWyKdBrSYpBepWY=;
 b=PPhruxzmXqcqs0IXn0QYEHehEbUXUHmqE59qw0WsGe7/5i/pOWpmjdDbuKVBI2B3XacP5l
 PDsDK6r2NPRDYU0oYWJJ8VjK3dBmZfb6a3kRaPv2QPb4M1capcT4NI9rh/m3B6cnBO9E9F
 msLwZFtBX1rGZpmRub41OXXnfbZY6QM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-a4yN2DMeOuOlMt-kkPchPw-1; Mon, 17 Feb 2025 12:45:58 -0500
X-MC-Unique: a4yN2DMeOuOlMt-kkPchPw-1
X-Mimecast-MFC-AGG-ID: a4yN2DMeOuOlMt-kkPchPw_1739814357
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f20b530dfso4863315f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 09:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739814357; x=1740419157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bARpz6GEXYVosp14t8tSmIlTn9yfAWyKdBrSYpBepWY=;
 b=g6/8bBY1fckUjMSYnxXUhOsvzBptJd1lR71fvavYld1xSsdaG6WoFR6bkQ79aWQirQ
 LfKs4UNWt1e0rJkmkSU+yDfh8Ls+ZG/zGcUFOPDtCwtiudWY1L5hMJjzdaWqhDUzBHzW
 wscDcTz1zqzA3hS5Y5SXcMbCaVcNCdObPwbd30Ypcl2qpANxZCCa3ZToBk0uw3YtQLcT
 xyE3XT4ociaWCcy8Rp8kvLYP7h+fS+zYFqMQU4UafrDHEdrNq5m7QyF4wBdoxrGqhzsY
 QTDXMwQg2x/qDOMoTua4Nc9jnhe8J8VwFygAOcOMDGrlZntLQw3MKdKufODOOQT/Vlqj
 XBJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8jtq3K7fAJ+4Weo9tZPVVnMWaneyzUn8HVTHvyhwZXTZyNuS90Wlm6uqs1pW9AMczW8eudd5uPcOS@nongnu.org
X-Gm-Message-State: AOJu0YxghDJvcv236DSXdoM+r8tTnezbs41AZToPcpDYjqK/DOpqPFJ1
 NQS1cfl5XgbbLn4naJvmR3ocwVN/0w3VGR0qqB49+2xhnLGaFk3d9k9+Jc1iWpBdv3vv9wdp199
 za+WvWcz+KS0bEixZkvoX7CBBBscEbEJ4F+oDryNabw09xoDOK2YE
X-Gm-Gg: ASbGncsdKQfbMvV32CpoS6I4N2hT9a3VdEZNwq3sXKBMS5XN3esfTHuip+rDcWrZ4m8
 aWfrmnZBqCJ1G7bn2U4P41OXKiOPhQfUTNTn2aCLlcuPJf4HAxaDZJgUphc2YdPKj9tstn2SYVN
 4+GU8Qa/UBnBCgUiYZ6AeeKBJ5v64Z/wy/4IhqSmSvfTE6vmHFUxQba0AJP3ac5JWK32s21VXu0
 5O9cxxtfxMxOrX4L5jw4cgmfp5y6Qe+iTzL1mlvIHjF2R0TH3ukr9kI+iXGrZ5P7Gvy7b4A86dy
 39SB8RCJhIArBHQPjZ4CHDXjG6Sugfx0x6h8qtVEoHx9A6xzJAqP
X-Received: by 2002:a5d:6c66:0:b0:388:c61d:43e0 with SMTP id
 ffacd0b85a97d-38f34167d68mr11769337f8f.48.1739814356777; 
 Mon, 17 Feb 2025 09:45:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENXcv78bx2So/8DHb8ew7dbzzjeZI5y4fRR+xqVABG5hZosdSUbFK9Qi3Ur3PYzdJM7o2M+A==
X-Received: by 2002:a5d:6c66:0:b0:388:c61d:43e0 with SMTP id
 ffacd0b85a97d-38f34167d68mr11769307f8f.48.1739814356402; 
 Mon, 17 Feb 2025 09:45:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25914d73sm13039169f8f.54.2025.02.17.09.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 09:45:55 -0800 (PST)
Message-ID: <349acbc0-dfc2-4cb7-8d5e-21e48a4219e7@redhat.com>
Date: Mon, 17 Feb 2025 18:45:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] docs/cpu-features: Consistently use vCPU instead
 of VCPU
Content-Language: en-US
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, sebott@redhat.com, maz@kernel.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Yi Liu <yi.l.liu@intel.com>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
References: <20250217163732.3718617-1-kchamart@redhat.com>
 <20250217163732.3718617-2-kchamart@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250217163732.3718617-2-kchamart@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 2/17/25 5:37 PM, Kashyap Chamarthy wrote:
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  docs/system/arm/cpu-features.rst | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> index 37d5dfd15b..a596316384 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -27,7 +27,7 @@ disabled, enables the optional AArch32 CPU feature, is only supported
>  when using the KVM accelerator and when running on a host CPU type that
>  supports the feature.  While ``aarch64`` currently only works with KVM,
>  it could work with TCG.  CPU features that are specific to KVM are
> -prefixed with "kvm-" and are described in "KVM VCPU Features".
> +prefixed with "kvm-" and are described in "KVM vCPU Features".
>  
>  CPU Feature Probing
>  ===================
> @@ -167,22 +167,22 @@ disabling many SVE vector lengths would be quite verbose, the ``sve<N>`` CPU
>  properties have special semantics (see "SVE CPU Property Parsing
>  Semantics").
>  
> -KVM VCPU Features
> +KVM vCPU Features
>  =================
>  
> -KVM VCPU features are CPU features that are specific to KVM, such as
> +KVM vCPU features are CPU features that are specific to KVM, such as
>  paravirt features or features that enable CPU virtualization extensions.
>  The features' CPU properties are only available when KVM is enabled and
> -are named with the prefix "kvm-".  KVM VCPU features may be probed,
> +are named with the prefix "kvm-".  KVM vCPU features may be probed,
>  enabled, and disabled in the same way as other CPU features.  Below is
> -the list of KVM VCPU features and their descriptions.
> +the list of KVM vCPU features and their descriptions.
>  
>  ``kvm-no-adjvtime``
>    By default kvm-no-adjvtime is disabled.  This means that by default
>    the virtual time adjustment is enabled (vtime is not *not* adjusted).
>  
>    When virtual time adjustment is enabled each time the VM transitions
> -  back to running state the VCPU's virtual counter is updated to
> +  back to running state the vCPU's virtual counter is updated to
>    ensure stopped time is not counted.  This avoids time jumps
>    surprising guest OSes and applications, as long as they use the
>    virtual counter for timekeeping.  However it has the side effect of
> @@ -200,15 +200,15 @@ the list of KVM VCPU features and their descriptions.
>  
>    When kvm-steal-time is enabled a 64-bit guest can account for time
>    its CPUs were not running due to the host not scheduling the
> -  corresponding VCPU threads.  The accounting statistics may influence
> +  corresponding vCPU threads.  The accounting statistics may influence
>    the guest scheduler behavior and/or be exposed to the guest
>    userspace.
>  
> -TCG VCPU Features
> +TCG vCPU Features
>  =================
>  
> -TCG VCPU features are CPU features that are specific to TCG.
> -Below is the list of TCG VCPU features and their descriptions.
> +TCG vCPU features are CPU features that are specific to TCG.
> +Below is the list of TCG vCPU features and their descriptions.
>  
>  ``pauth``
>    Enable or disable ``FEAT_Pauth`` entirely.


