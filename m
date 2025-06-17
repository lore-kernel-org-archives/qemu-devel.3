Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2BAC71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYIu-0002AT-EZ; Tue, 17 Jun 2025 11:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRYI6-0000vN-Lw
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRXxT-0008JR-5f
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750173042;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ssC0ToNZSsFUgX/YNPCV7KnTvzwfgw9hctupgvZqXoM=;
 b=XVda42RkD+gJ2ubG/N8rbv80pl0dSJGHewKRg8DHuPZ4Q2EYMgGHTyBhZv4FAFd3svuJD3
 WuyxmWxNbWbl5zd3vdBC3qfvMmTU4PuESjkPNarCw24OLgdCMEqahigv1858QMxN9MEloV
 AiEY/1QiqEfqF7MTUzJxLaml91ylv0c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-bCtPPGv7MuCI3sTcQMtOlQ-1; Tue, 17 Jun 2025 11:10:39 -0400
X-MC-Unique: bCtPPGv7MuCI3sTcQMtOlQ-1
X-Mimecast-MFC-AGG-ID: bCtPPGv7MuCI3sTcQMtOlQ_1750173038
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a3696a0d3aso2223598f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 08:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750173038; x=1750777838;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ssC0ToNZSsFUgX/YNPCV7KnTvzwfgw9hctupgvZqXoM=;
 b=VGIr4XToUvNI1bs1/ptSzhE6SdzBY7dTwVbuuZiXx0VmrDsHvF6hkDbpvJ5RBp8LAF
 edoQXcrRmjLqi7IHm95dzIDVDnNGyerNNS1D8HCYBsPsPK/61Yq4ntYn9+1XdFxN13vp
 5LJ93biWZHBzCp4rG800/JROqql+aV87JlxAM2/sP9QlEsM7HoAfII2KSAd2F6hG0bjm
 CR37aWd5+dDIiqhJIiIMKGYm0Nv+I5PUZSWjgFyVxFXUO60amWJ6BLD0XoDTn0yjBt+d
 aUfCad5GEwMP9gJHngJxm5mfdCng2XR28Gdvw/rP+q7GO1vuhzv3YRDY2ddC3jmBSE5j
 HO6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX5PbIycigi4Mqansfu8cw4hkfXTniTYbf3WXimSLIPDiMN/i9eZznPFgXq4/dwa66CYAG/TtoTqUX@nongnu.org
X-Gm-Message-State: AOJu0YzxDLxpeFAK7yfBwpgwPbiFs9fpPoi8ZMvvQoXqlGN0Mbmc/ZWX
 BlnuIhu36Jfxj+FHtrZ5olzoC5GdD/mKgplfJsyxjUKImm/VMeCkLqRIWWqqukTHxFTcIvAXWgV
 evIOE6a7B5loes/V/MilxF2wUfl58mYBYPWPzVmS2g1n21V7XMhd89nLW
X-Gm-Gg: ASbGncuWgMEkLdczdyTHX1wa1ndtO6QEU5IQxsjEwSqs3wq5lkvPTPCCI5iYoASTWjg
 BnYzVeLWMV9J7HMTdBed2GxBmWXHcr1XPdSOSeC2bb42MjPpiUKcXOA2a5CTWg6TnLUCWpWVcHM
 TebTzs4yvcLoaiDy+w45y/bkgmZM1atu49DKiTgZitxRjHA84dTBU0JwHG91dXImwbvo8e5g/t4
 R3nIViShZH7LiACsXBfUilMetrbPcEG/8G90otYdVKgxD1F3vMu4rInGwMPbE5JNycI2D2HfwRa
 VtiZygvcdBYm6VsFgG56ssqmQXqzFK7oMtdD4+XuTxbdFB0IXWH/xt15NdiFCetTNiw8PA==
X-Received: by 2002:a5d:64ce:0:b0:3a3:6b07:20a1 with SMTP id
 ffacd0b85a97d-3a572e8c1dfmr9690421f8f.40.1750173038330; 
 Tue, 17 Jun 2025 08:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZN8Hta8TEiGPlTKRj7WjuD78YMZV9++UqgG/6V1JkfvYC332lSpl2VkBaEBjgqYjbXsK6eg==
X-Received: by 2002:a5d:64ce:0:b0:3a3:6b07:20a1 with SMTP id
 ffacd0b85a97d-3a572e8c1dfmr9690384f8f.40.1750173037881; 
 Tue, 17 Jun 2025 08:10:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a54af6sm14125442f8f.6.2025.06.17.08.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 08:10:37 -0700 (PDT)
Message-ID: <8c4a62d2-6590-4177-8ccd-7e3520611fe7@redhat.com>
Date: Tue, 17 Jun 2025 17:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] hw/arm/virt: Allow virt extensions with KVM
Content-Language: en-US
To: Alyssa Ross <hi@alyssa.is>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, miguel.luis@oracle.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <20250527062534.1186004-6-eric.auger@redhat.com> <875xgutpuh.fsf@alyssa.is>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <875xgutpuh.fsf@alyssa.is>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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

Hi Alyssa,

On 6/17/25 4:17 PM, Alyssa Ross wrote:
> Eric Auger <eric.auger@redhat.com> writes:
>
>> From: Haibo Xu <haibo.xu@linaro.org>
>>
>> Up to now virt support on guest has been only supported with TCG.
>> Now it becomes feasible to use it with KVM acceleration.
>>
>> Also check only in-kernel GICv3 is used along with KVM EL2.
>>
>> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Hi!  From what I can tell, this will produce an error on hosts that
> don't support nested virtualization when QEMU is invoked with -accel
> kvm:tcg -machine virtualization=on, but I don't think that's the ideal
> behaviour.  It would make more sense for it to fall back to the first
> permitted accel option that does support running the machine as
> configured, so if hardware nested virtualization is not supported, it
> should fall back to TCG.

Hum I think I misundertood your point.
I guess you meant you get "qemu-system-aarch64: mach-virt: KVM does not
support providing Virtualization extensions to the guest CPU" which
sounds the usual behavior of qemu in case we attempt to run a feature on
a host that does not support it.


>
> I maintain an OS development environment that includes scripts for
> running images in QEMU, where running KVM on those images is a
> requirement.  Currently, those scripts simply force TCG on aarch64.
> With this change, to take advantage of KVM NV support, I'd have to try
> to identify in the script whether NV would be supported.  QEMU would be
> in a much better position to determine this and fall back to TCG if it's
> unsupported, like how the -accel option with multiple values usually
> works.
Switching to another accel mode is a policy that is not implemented by
qemu. There is no such situation where qemu would switch from kvm accel
mode to TCG. You need to implement this policy in your test env I think

Thanks

Eric


