Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB541C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeqM-0007vg-0e; Tue, 01 Jul 2025 13:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWeqB-0007qn-Dd
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWeq8-0007jS-Lu
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751391134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+oSMyrCsd9PQmvJAo8VtpC0GfICKT3Ea3CYydX0cp8s=;
 b=cdxmadMVCRc4HuxmYGYAQff/RPXxRZgLJ2QyLR1KPRV403yPF6Rg7VtNO88c7RbeUhkbDD
 zorzxV5V0ZCFrydof4qSB0563hDPMn+197s1RPtDtfYh9ZKLwh1BZhTl4R9qXIfouBJiNZ
 /Yiw5fXPDG2FYVYSE/8vlMgBT3eDdPg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-FzQD2spwOrG6J4TZi2_SKQ-1; Tue, 01 Jul 2025 13:32:13 -0400
X-MC-Unique: FzQD2spwOrG6J4TZi2_SKQ-1
X-Mimecast-MFC-AGG-ID: FzQD2spwOrG6J4TZi2_SKQ_1751391132
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-453a5d50b81so13202345e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751391132; x=1751995932;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+oSMyrCsd9PQmvJAo8VtpC0GfICKT3Ea3CYydX0cp8s=;
 b=oPKjdBN1Y+ScFNYvh+pRvtvXZIDkV6DrPdaVbXuCdFka7atDNlnVciDYvdRYvqsWO/
 cdKTQDNsLj4yCL21jlF/0zoy8Cbyioo0N4VXmeLj0NeiPJtd+qcnFFvNzCX39oW07gr6
 Hkuymawc8QfuXV3iwZPklg2phnjozt1mPSAZ+6vhDs65xQ9F0s5YTVFqljUVJNruXYOe
 4xbHorK2fcVmPQ1squBA+h2wLqJzNygF9yiAfJqHwjPJBG34XSgzLlfnWLzYEiyo9bVO
 ciKegch74lLBU38/fhoU7ydu3iJrvsQHBPSSns+W75Wq4twGJKZJVH2Q2W3sPJ80KIFA
 uBWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXnxk/A5+KhtsM7RAlssnKuE+PDn0nSnFpRDWK8jx8Xei/k3sO9gOJxS8ViPapuuAVc47/EvbimWGP@nongnu.org
X-Gm-Message-State: AOJu0YyFt6mHcwG9iL4eaC3swJivjgSm83ICnQfP5ckJb9jJ+p7bbMZa
 /hrLaosJOWodw/hVT9aR0VdmEjDYubkm0SWZ/2Bv3D2lAVVjzUmCB3LZmOs2gTZiBE16/R3QL4H
 7BjxjAijSTWAPk5U8EugIHcnXUv9ktZpLLKPVpj5ITCyo0JN/BUDdhue+
X-Gm-Gg: ASbGncu+WOrz/y6C/N6Plo02OQabjr/RgQ1eHnhGRP1GFjg/DafV3u2mB1RZBfAGHKF
 mnvIrjpYAtDJ2HDIYbd3E0jJUAFyOr5aMQ1E9phi/VMVAk+zOlVfFVU4F43AoAtR5PU+Fa6gT2F
 qd+zSUZ0tLryck2BraPAOiShCj9sJmn0FNZVyvFT9szwz9N1hZjrr9hXKz/v4wr1a+cb8SvdtU8
 qnNTHkOZ1LW6KuJlw7ff6ai6IoXM425d1Iqbx73P1oIaxqdQe6mE84dFK2oyl8yAuDhWJvvjeGC
 xy39h0pS81Bwnt84KKW9py1YNeyDHS/DMqd/dtNL6eILYCKamDJj0rHOuACoEw==
X-Received: by 2002:a05:600c:698c:b0:441:b076:fce8 with SMTP id
 5b1f17b1804b1-4538ee5db08mr203962285e9.14.1751391131947; 
 Tue, 01 Jul 2025 10:32:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrDi1kdke+sinF7xSSSY+sFf1D6wdSqaIqUHRyD1XBs3e3Zvpcc8AVESdpb/V1u1kVCGm/mQ==
X-Received: by 2002:a05:600c:698c:b0:441:b076:fce8 with SMTP id
 5b1f17b1804b1-4538ee5db08mr203961915e9.14.1751391131467; 
 Tue, 01 Jul 2025 10:32:11 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-041.pools.arcor-ip.net.
 [47.64.114.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e74fbsm14023459f8f.10.2025.07.01.10.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 10:32:10 -0700 (PDT)
Message-ID: <55f15763-9b67-418f-a670-9a1bbd55d3f8@redhat.com>
Date: Tue, 1 Jul 2025 19:32:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] treewide: fix paths for relocated files in comments
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Peter Maydell
 <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 "open list:nvme" <qemu-block@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20250616.qemu.relocated@sean.taipei>
 <20250616.qemu.relocated.06@sean.taipei>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250616.qemu.relocated.06@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/06/2025 17.51, Sean Wei wrote:
> After the docs directory restructuring, several comments
> refer to paths that no longer exist.
> 
> Replace these references to the current file locations
> so readers can find the correct files.
> 
> Related commits
> ---------------
> 
>    189c099f75f (Jul 2021)
>      docs: collect the disparate device emulation docs into one section
>      Rename  docs/system/{ => devices}/nvme.rst
> 
>    5f4c96b779f (Feb 2023)
>      docs/system/loongarch: update loongson3.rst and rename it to virt.rst
>      Rename  docs/system/loongarch/{loongson3.rst => virt.rst}
> 
>    fe0007f3c1d (Sep 2023)
>      exec: Rename cpu.c -> cpu-target.c
>      Rename  cpus-common.c => cpu-common.c
> 
>    42fa9665e59 (Apr 2025)
>      exec: Restrict 'cpu_ldst.h' to accel/tcg/
>      Rename  include/{exec/cpu_ldst.h => accel/tcg/cpu-ldst.h}
> 
> Signed-off-by: Sean Wei <me@sean.taipei>
> ---
>   docs/spin/tcg-exclusive.promela | 4 ++--
>   hw/nvme/ctrl.c                  | 2 +-
>   target/arm/cpu.c                | 2 +-
>   target/loongarch/README         | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


