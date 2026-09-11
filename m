Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C2AC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x56a8-0002vF-PF; Fri, 11 Sep 2026 15:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x56a1-0002tR-GH
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 15:06:34 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x56Zz-0001Bs-6t
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 15:06:33 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc4d98911b9so42015a12.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789153590; x=1789758390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OA2sVMpJOFs521Sm7QLlbcXgZJxQUaU87i0p38nQDe4=;
 b=uvvc6GQSSobZT/ZeszjTN32YZSgOmWxqT91SZtm1J5QLnkwQLimw3GisvksUI7IWzO
 +5ibQ04g4f3bOhY5DJN2GzKXzOeUgeKgpbAVMQzODxv3/qYZODhPz04NRi2Uhvce5iGv
 0MLpb6vMJ7dZ1w9RdUXXaCz1E1MxClebld+bAnsClulPiOP+1uJSMPHfZQpOwNgaRrHf
 +yvHG6AWCT8cZuaHpsxjgfGX+n7jpKy3sKBx7JIS6js1XEqfzZdM+3FNjX5U3+ddl6fI
 R2Z0DGU8yQ8WmgtTdz5rdIJCMR68FSpoKqPYnSAbFPdOCJeuun6Gno1GQEf38BveQVsu
 UQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789153590; x=1789758390;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OA2sVMpJOFs521Sm7QLlbcXgZJxQUaU87i0p38nQDe4=;
 b=B7MdQ8PmDsrIoAmdyymuBFeB1klhRB5+4oJvb+RP7Gl5goCA1cpY10qkl93yGEeDGP
 9QXPLb29lNKas9+8mbJKNI2fY+ezBqJ+B+OjJAfTkkSS63eeGCxgPfQYaRKbJkzZZsMB
 QqloFhav0XhUn/CE7uu9qGTzTe69AFJT2YFtBU5r0u3iWlofHYeuPadsAXX5jKulGptC
 qjbo9Xip5aozAN5mWV7IpfyT/06HTr9xMn0bEqpgA6brWtOXOZwEXvFr9ARKPL7LNqwI
 3Ve0amvqiVNE/xV7s0trhtDiKh+pZy6tLK4qhgkeNmdNsjfRM3i2jgGCANTwzRsv/2to
 TUGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCtLUkO4ipXatcztV1Qv28HctEiEUVNOT+sWagB4RH5izQppAHHBfomZ1kLVol2Vz9J/jGH+Lqy39x@nongnu.org
X-Gm-Message-State: AFuF++n1I7cQ1ymK6H63wdAQQ/HctSjJHzN1NHThPVL+5CIo+4KTJm7O
 WJn9xt9SpC5fYaHAw1jENtwQbInMKzgMyo245H/z8og2JIQml+tS+ceZBF8BLmMzOFQ=
X-Gm-Gg: AYBFou2n0i/FfjIFxf6cCdhOV1Eyv8V80mbGxX9i0ZIeNIhB2UbD5sopXkdh+8kbdiA
 RoRG0fIE2oPDjb8uPjesiItJo8v2ZVtKOxTWz7903dRoI5OCdMprr/woFhC1EOCsEzyEIB6s5qk
 oVnWafJWwInC9y62xlbM1AbJE91n+mmEPTEYIzg5qcCRPvg1blqxSs8fTseeeY4YW/uT8n7zpX8
 mgH8qD4q2gQ2SBlbLdMwotTIlWyhsIJj8fSZ7txuBa2vcUNPPX2ZggQcadvtO1Y7gLmex0T0d9+
 ExcfDFx9DvQkTnAbiOibIPBQg7xd7TDfEkD2BeC6HyC8UxKWzOrcy0r+0VB/DyoAReZ/IDi9g2y
 QJ6bJesnXR8O8NYhJFerzaONua3QcX/03xnVHO7qz1QHaUIRwNvRL5h/0zl2y8Y8Fjhqc/BZkQp
 9aNLVlY/RQz/rmOu14xGxX8ZOcIwjMuo+9OpzfdyfIXvN4HaeLitJDN9DpQ5xE40yn3+ddfukz4
 UpbAvD545iYxMCXTRsIjkT5S8AjE+K2gAMyLe55GZSJvqTMHDo2jDAIiOg=
X-Received: by 2002:a17:90b:3ecc:b0:39b:4877:ae90 with SMTP id
 98e67ed59e1d1-39d9c352654mr8754422a91.22.1789153589520; 
 Fri, 11 Sep 2026 12:06:29 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f0feaasm7998205eec.21.2026.09.11.12.06.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 12:06:29 -0700 (PDT)
Message-ID: <6134ac71-f451-4caf-88df-af001641a05f@linaro.org>
Date: Fri, 11 Sep 2026 09:06:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/75] pci, vhost, virtio, iommu, apci: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1789117222.git.mst@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/10/26 23:01, Michael S. Tsirkin wrote:
> The following changes since commit 1df256f5968e9f7c3c4533a1383b071c044a36d6:
> 
>    Merge tag 'qom-qapi-pr-pr-v1' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2026-09-08 18:35:31 +0100)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 2f8991c0b9c400f55897849a538580039b61865a:
> 
>    MAINTAINERS: add Junjie Cao as CXL reviewer (2026-09-11 04:59:15 -0400)
> 
> ----------------------------------------------------------------
> pci, vhost, virtio, iommu, apci: features, fixes
> 
> new vhost-user-media device
> virtio-net now supports live-TAP local migration
> cxl now supports CFMW restrictions and per-window options
> intel_iommu now supports concurrent page fault handling with PRI
> pci now batches memory transactions around mapping updates
> vhost-user-blk now allows toggling inflight-migration at runtime
> virtio-rtc now supports smeared UTC clock type
> intel_iommu now exposes SMPWC when SVM is enabled
> new reviewer for CXL patches
> 
> Fixes, cleanups all over the place

https://gitlab.com/qemu-project/qemu/-/pipelines/2840522620

Between the 6 failing jobs, I think there are 2 failures replicated:

https://gitlab.com/qemu-project/qemu/-/jobs/16454091774#L800

18/34 func-quick+func-x86_64 - qemu:func-x86_64-linters 
               FAIL             6.00s   exit status 1
34/34 func-thorough+func-x86_64-thorough+thorough - 
qemu:func-x86_64-tap_migration     ERROR            0.19s   0 subtests 
passed


r~

