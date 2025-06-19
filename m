Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336CEC7115E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 08:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSAUq-0006Re-DJ; Thu, 19 Jun 2025 04:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSAUo-0006Nd-KN
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 04:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSAUk-0004xv-4i
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 04:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750321176;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qX1ZSkd//NoJquOm66zsf8L4UNYjr2aiShByP7TVuNk=;
 b=FMABH14N5O7FyMdU+StOr4lkkbmA7z71YTR4Z4UGV0WddVHQ0HyZxeA5M6vhiBkeiW1RwC
 8Yil+3uJSxstvlBoUEgfIiNKMQczz3k2/YirVWltM+EiwwUcKnlKnIz2CpPKypp93M73mG
 B7xFWlTeIiflR47U5CmFIklRw+fsbs4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-nrQISv7PPaqKfePYPb_j_Q-1; Thu, 19 Jun 2025 04:19:34 -0400
X-MC-Unique: nrQISv7PPaqKfePYPb_j_Q-1
X-Mimecast-MFC-AGG-ID: nrQISv7PPaqKfePYPb_j_Q_1750321174
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so243344f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 01:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750321173; x=1750925973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qX1ZSkd//NoJquOm66zsf8L4UNYjr2aiShByP7TVuNk=;
 b=b+BCHLxfL8k8dG80QXb48Hw+ufXjmpRA5G+Wp9+Icr6MmAFT2/w0TvajGJMQQdcIuT
 JNZpGOpgkzqALu2ErDmlEFv2ZflbFXRpTcvQa9wGibOwC3R5lxICG214SJmwL2LsPhAk
 voDB1SckDl2gLYImYUMrHJoEzQrGSUuf/wyGezgvPRm2rLVCBi4RfpfV+b9TjaPBZliL
 HT+C/OoouanI1lkJYd5sRRi1U2OgHrKcYHWBPJqii9HS8FMfA7tdfMUtoEYHGJUS2XLs
 fmSK7yCc2WAM4JG/V8tHvVTP8v1SRnO8HMRVI4H6ZP5dqHFFtFyiyrZWW774M1qSa0ih
 ZoZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgqwDbe+h3XHFCDHQCBpyrxMDvS0Io1G14oecx/X95OFI90q8MBA4ssPCStWSXeRYA+Vi3qMxjQElc@nongnu.org
X-Gm-Message-State: AOJu0Yx2ItGVHrzkdzXJ1yPX+1jGFwb1IcXiyEaB3m5mViEslK5wP37G
 5reXZmNHGHKEd5/c5DjxP68QR6+ufF8VIyh9F9OdDpKXoLf48JrFnCX9UPsrEE88alberpNaEyR
 Gc0PaKOSBG0jz1sllYMCWRaYDE+0uvD9CENbgiKPnPttxPZkmMV+FFHzr
X-Gm-Gg: ASbGncvo82EVN2KpfiA3g//Aj13rFIF15T15mZRCJI9vwX4yBzC0jqMeO07G4W2u/Dm
 xzZPHD1p34+q3n6L5/a/as40pbcrQe/wU+/Us8rV97N8GjE0/A1I+3dAKSm8hkcDe5omcfqvJn9
 9RuNyU7dkftnXme2HEX4576rbgvt6ebbKcXk+Agc4R3SENtL5EGeUZrrqvLOue9Ak/PuiFQlIh+
 LOf2EURqPGAk1gtOnLr0ZwFigAPMOVcA8DEAhZRd7q5GnKJ29ad+FQNfzL+UHbrrXbMKBS5FB3x
 8NG+Rh3YpYFkduwXv91WOsGMWsG+ih7nkq7CMfqg5k9fBhKAkEye471IC7i9uNij5FL37g==
X-Received: by 2002:a05:6000:2308:b0:3a5:25e0:ab53 with SMTP id
 ffacd0b85a97d-3a5723a399cmr16341969f8f.32.1750321173585; 
 Thu, 19 Jun 2025 01:19:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmlZfZJbeOUugPf61W3toW1nv/KIjiDaiJjy4lpTm41opEP24DUmL+kxYs8fMSwgEPrKJldg==
X-Received: by 2002:a05:6000:2308:b0:3a5:25e0:ab53 with SMTP id
 ffacd0b85a97d-3a5723a399cmr16341944f8f.32.1750321173162; 
 Thu, 19 Jun 2025 01:19:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a58963561csm6485934f8f.47.2025.06.19.01.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 01:19:32 -0700 (PDT)
Message-ID: <5813ae16-c898-4620-9622-3c12e8a7b22e@redhat.com>
Date: Thu, 19 Jun 2025 10:19:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] ARM Nested Virt Support
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, gkulkarni@amperecomputing.com,
 gankulkarni@os.amperecomputing.com
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <86msayec3a.wl-maz@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <86msayec3a.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Marc, Miguel,

On 5/27/25 9:39 AM, Marc Zyngier wrote:
> Hi Eric,
>
> On Tue, 27 May 2025 07:24:32 +0100,
> Eric Auger <eric.auger@redhat.com> wrote:
>> Now that ARM nested virt has landed in kvm/next, let's turn the series
>> into a PATCH series. The linux header update was made against kvm/next.
>>
>> For gaining virt functionality in KVM accelerated L1, The host needs to
>> be booted with "kvm-arm.mode=nested" option and qemu needs to be invoked
>> with: -machine virt,virtualization=on.
> Thanks for respinning this series.
>
> Do you have any plan to support the non-VHE version of the NV support
> (as advertised by KVM_CAP_ARM_EL2_E2H0)? It would allow running lesser
> hypervisors (such as *cough* Xen *cough*), which completely rely on
> HCR_EL2.E2H being 0?
While respinning I'd rather not support KVM_ARM_VCPU_HAS_EL2_E2H0 in
next respin. The code is mostly reviewed and I would rather add support
for this in a separate series. It will most probably rely on a change of
the virtualization property type to support a "restricted" enum value.

Thanks

Eric
>
>
> Thanks,
>
> 	M.
>


