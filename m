Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05675C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whU4V-0005KP-D9; Wed, 08 Jul 2026 11:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whU4S-0005Jl-0Z
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whU4N-0007UT-7n
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783524014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Fo/sV5MUbwlVd+NTZQ1OtdFbABFEV/liJ/xV8wGClJg=;
 b=I1JgMU9rZb5lYboAV+CTo1CnuxUxkPEIr+Ahq+aMBdWR9+NQbZnGGBxQQRGF0okqpU7Wmc
 RU2cUbzoudz6Xgzkkvd2uizqB2kmJNsLxzVIt5Xemsm1deokoYGKJpZ+MdHHMfYuZEigE8
 fnXUzDzsdh49GU68a/BF5lMcGYeuy5U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-MhmKdq85PGeYDCrLcL_bZw-1; Wed, 08 Jul 2026 11:20:12 -0400
X-MC-Unique: MhmKdq85PGeYDCrLcL_bZw-1
X-Mimecast-MFC-AGG-ID: MhmKdq85PGeYDCrLcL_bZw_1783524011
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4784d0fb9cfso721988f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783524011; x=1784128811; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Fo/sV5MUbwlVd+NTZQ1OtdFbABFEV/liJ/xV8wGClJg=;
 b=qygN18u6tpcqQe7FXted6LQeA4TalFb69M/hoFFpLCNc4t+Ka+YNZCnWllA698Xf6z
 6G8WkC+kZvVBHLTFATqkmbmtvz2t+o1k7nkoJ7CAnop2enZ9YCJBKm2KzqRKQeWwRKG9
 2Mesn+vrlD45quwp0/aVpIapiR2oQ8vVwxlyBUdJG7/2ieibMrrDWSM49L3/MpAjBQSk
 OK67H8Pu/OfdmXyg6ymJip8SUzJXkGfv1A/bO96dVXFmk9zPV6lmnK82dU10sV9MI0gJ
 FhorjI4iismQbc2XTlqJj184IAe80TEWsbnq7bPT2X0QuVJw1c5ocZ9SKGQtarAxx2+1
 SSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524011; x=1784128811;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fo/sV5MUbwlVd+NTZQ1OtdFbABFEV/liJ/xV8wGClJg=;
 b=dX+V/IN+eg0/N2Wu88cted6l3bypdFYgOXBWx4HbduZrx3ZhBtIpUN7q4QxhDquudM
 RCQcOfTUG5t+64WI+VILZrnjl3/VoqjwfsiVugVlPy3NgPAhyntONJDCHAVOT2dUoicz
 eFOLu3YuH+g9Dk/1x8I/ShLp2ZedC7C/MYPLbZixScVThQN0rKjWRpbVf4FixTQcQCNo
 c1wQCms37PdZalxYk2fuko2bXM6yStbF6Sx9GHuzVBw4EPAkUk8AjbIYpYgFXjdKCbDz
 ubysSgiiLxsdPL9nNvhAjYWG5S0gAPvfvJp9piI0mDu1JI6Pk056MlQkH1DT97K3E4WI
 PaDA==
X-Gm-Message-State: AOJu0Yw/4jv++bgbV52Xsv3UfNGTzBUxbiS2hQ5HsOV98/XjyrRxeQ3g
 zJp77vltAByE+se2mB7TBjPQi+Hs3hWJd3yeA7SMCsi9OrUolf06oBKelLtSW0jSOaifQ4bwjUa
 gbVXgCgTvnLH7g5GJQLVdmLzxK/BB7VkgyR44G4oE50kznOKP0Qonmv+I
X-Gm-Gg: AfdE7clkL9Js2sM2ydsjiWiSpDQFjBnq2viPWP2TzgWRUi/wz2Qhz8vLT858UzaJppd
 umWoBriu3QYpZ11lEAfk0tobMRz9O/f6OrWulVy02xiQv2DRt0EglbcBVdFyR+G8Yq+e1iqLXtI
 0SWO8CoTLx4v+sxmU6K/haHa5pAije6VgPT6cHW6eO/mvImiavTNrH1anb7tm5isJFBOvm9Io2I
 EXpfobBGYZyxtX9/Oi+TLXn8xL/IunpMxT2J1S7kWyyZZO21CIlNFn0uBWPvxChIEKmcJTjLWkV
 0Z/3wEqhGn503IXBUGggOe+G983ButnjXKROLRBg9R/aZ4b8VqPhkrzApUYHxRWPRPUYVPj/4i3
 oO5oMDeFl9BkEv9N7IoXkvXt2GO1GXRgWSn8MSeL4DN/RX6mHlg==
X-Received: by 2002:a05:6000:1a8e:b0:45d:4a00:b927 with SMTP id
 ffacd0b85a97d-47df07ec6abmr3717204f8f.31.1783524011353; 
 Wed, 08 Jul 2026 08:20:11 -0700 (PDT)
X-Received: by 2002:a05:6000:1a8e:b0:45d:4a00:b927 with SMTP id
 ffacd0b85a97d-47df07ec6abmr3717157f8f.31.1783524010876; 
 Wed, 08 Jul 2026 08:20:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ae44sm41781776f8f.23.2026.07.08.08.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 08:20:10 -0700 (PDT)
Message-ID: <9be0741b-ce3b-4c54-b4f5-8442ee9dbb9b@redhat.com>
Date: Wed, 8 Jul 2026 17:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/listener: Replace misalignment whitelist with DMA
 capability check
To: Alex Williamson <alex@shazbot.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20260708133604.1606448-1-clg@redhat.com>
 <20260708090650.2247755c@shazbot.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260708090650.2247755c@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/8/26 17:06, Alex Williamson wrote:
> On Wed,  8 Jul 2026 15:36:04 +0200
> Cédric Le Goater <clg@redhat.com> wrote:
> 
>> The vfio_known_safe_misalignment() whitelist (currently TPM CRB only)
>> requires a new entry every time a device exposes a non-page-aligned
>> region, which does not scale.
> 
> Arguable as we have exactly one class of device so far that's validated
> as safe.
> 
>> Replace it with a DMA capability check: a region that is not
>> page-aligned or is smaller than a host page can never be a valid DMA
>> target, so a page-offset mismatch is harmless and only traced. Only
>> warn for page-aligned, page-sized regions where the mismatch could
>> indicate a real mapping problem.
> 
> But it's the composition into the address space and how that address
> space is defined to the guest that matters.  Imagine a minimum counter
> example to the test presented here, a page-size range of RAM in the VM
> is composed by a device as two contiguous sub-page MemoryRegions.  We
> only see the individual MRs here, they're each sub-page, the shape
> suggests they're not DMA targets, but together they map contiguously
> into the VM address space.  KVM can trap and emulate them as normal
> RAM.  QEMU emulated devices can DMA to them as RAM.  VFIO cannot map
> them through the IOMMU.
> 
> That is what this test is meant to validate.  The judgment that the
> control register range for a TPM device presented as a RAM MR is not a
> meaningful DMA target for a vfio device is the thing that cannot be
> determined based only on the shape of the MR.

ok. I understand. this is difficult to address cleanly without a
white list then. Which is what "Extend safe misalignment check to
tpm-ppi region" proposes. I will let it cool down.

This change is not critical. It is part of a broader effort to
avoid giving users the wrong impression that the problem comes
from VFIO when analyzing diagnostic logs with errors/warnings
spread across the system. This is not the only VFIO message in
this category.
C.


