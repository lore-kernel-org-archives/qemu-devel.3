Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EA3C88E56
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 21:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5VQJ-0002T1-Mc; Sat, 12 Sep 2026 17:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5VQH-0002SP-M2
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 17:38:09 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5VQF-0008Vt-FU
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 17:38:09 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d91a931f66so3620155ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789249085; x=1789853885; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BK5/3qjPdA3Lt901cw54PgHqkQRHvjzMQRuWzcUrPDU=;
 b=lPjd83mtGS2rKJGYLyW5xAwtgFsZN33NvcwwEyRXOS4M/xNrtUDrPasJIz1y0fF+Wi
 9DvPfzE8uDXM5SZGXShpG7Hao+v5+ZSgZ8umCXbYdiqD9irrlzgUYsNzCKBvibhwi9yO
 pF5evwts62HYrifZ7Mq0i4Pfmh7Ibw5zBQeUsuv7H5mdxZYOqViMDTSsvTYV1+3eI5Qh
 1vE7I6f4XhjzneJ0tQuzSTzbJ6B5n5AqzOu2vNB3I8IkyxLIhsPWDrGhtjv4VQrkHtkC
 90PHdM8VEulMhwj1i2Ku72QgHFBRkcdEOdI48st8PLIUEStMbBFEYOsdfZA8ATl0mL0z
 JNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789249085; x=1789853885;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BK5/3qjPdA3Lt901cw54PgHqkQRHvjzMQRuWzcUrPDU=;
 b=rSxWGcdWLok0Lc61JtnWmxb7/d+dg6tjSDjB/xCBz/HK62fMCDse2pBI3ERw89dboc
 BNjLILdmZhQEfpZfJZ81zcn2pWUPYSSaXT8CR+SfIyVtxuHHR+Kr/VgPz6oWXq6eeOmk
 algLmTwfdjUoJbKkQa78KKiPXdYZTCZz5/zinLgdGi/3Y4XAxPTVnJxm6Pwnosc3GO4U
 OWFqzMledpVUC0i5AnufMEIfTWTwj96Ee7VYOR5+QUotC8BgAgA1RjRaZRS13ColGdY1
 cjS8XOmeZocatg/Q38wNvB1ox23J21IljkJe9KTB995YBRY+FaHyF6QBLIvgBzqtyVgH
 bSHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtc+3VfCJA3wv0fHM2Zoa+y0Q3082xzfotC7DLw6n0Nb0kPIuYe6jmboFzu0EVYuwWC2x8JQBICerR@nongnu.org
X-Gm-Message-State: AFuF++lk1N3q95mHB6UgfWRCvXFD18tKvAXOci8IRCl8vq27UgZscFOl
 Z00VLFSq1cunJ17dPw4wmJbORHfQV6YfsjOKdZtCjiRBn0G76mnx3XriQJhFMmoJguo=
X-Gm-Gg: AYBFou2labw+aKy6i0BycdXR2xlKgD1+/HiuNqc03Qw9H/5sT+Pl24/5Vt6Epo4PwMF
 VU6wiyWfG8U5bK1Aq4KjuI2QVTRj8Kyzhl8KTh8FXC4wD9i4Xl7MT0uDEXWu8amQIo3ndvVScYV
 cr0hMDBTBrIjP1SHhSPsQRXZViSU3JZ6O1U4J16kmJq1IjYHv5b20OocNtUMEzj+FGszbaaizFr
 9Eq2Bwrabwr0geZlqTxuF5ZdtJNYB7IAP3drW4f7KQgUqKyG40zayvBJvVyUR864CX6zm9kchuI
 g8l7Udvow0L1dNxkiZCiW+QUcMJQGxwLbkeSFpl7yOmrxBnJqeKhxMYNiMT4V7ALhTIopj11dlp
 FjNSJKDv6G0nq6ut8nlE1X7XU8cjg6fZwSYB2pg+t+MO5M2Oao+flRS5SjJfKkIJssQb1xnQI2G
 vYOdGkMF2Gr1I85WZ15XxGw86Ne7uipumRu8Eg5xD8aZThWnj73D4MaSmNZQd0LbdxR+rQveH0T
 frOPWmaT613D16xjPr7tfcRIt0zVifulnt3ojOL9hpic2axUm2O1Kucwilbyg==
X-Received: by 2002:a17:902:ce0c:b0:2db:479a:5127 with SMTP id
 d9443c01a7336-2dd4bd95335mr73403345ad.19.1789249085393; 
 Sat, 12 Sep 2026 14:38:05 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:bf2d:a6f5:e308:cd27?
 ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9b359sm15602125eec.14.2026.09.12.14.38.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 14:38:04 -0700 (PDT)
Message-ID: <6f208201-faa1-4ae5-a6a4-92321c2dc508@linaro.org>
Date: Sat, 12 Sep 2026 11:38:02 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] target/arm: Keep the S/NS bit in migration data
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>
References: <20260907130223.3148989-1-peter.maydell@linaro.org>
 <20260907130223.3148989-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260907130223.3148989-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/7/26 03:02, Peter Maydell wrote:
> For Arm, the format we use on the wire for migration of sysregs
> (cpregs on AArch32) is a set of arrays, where cpreg_indexes[] holds
> the register IDs and cpreg_values[] holds the corresponding values.
> The ID format we use is KVM's ID format, which is 64 bits.  This is
> not quite the same as the 32-bit ID format QEMU uses internally for
> things like the coprocessor register hashtable keys, and so we have
> conversion functions kvm_to_cpreg_id() and cpreg_to_kvm_id() to swap
> between them.
> 
> This conversion has never handled AArch32 Secure coprocessor
> registers correctly: the KVM ID format has no way to indicate a
> Secure register, because KVM VMs on AArch32 were always NonSecure.
> The current code doesn't touch the CP_REG_AA32_NS_MASK bit when
> converting from the 32-bit ID format to a KVM ID, and it forces the
> NS bit to 1 when converting from a KVM ID to a cpreg.  The effect of
> this on migration is that the indexes in cpreg_indexes[] have NS = 0
> for the Secure banked registers and NS = 1 for the NS banked
> registers, but when we read and write the values into the CPUState by
> finding the register using kvm_to_cpreg_id(cpreg_indexes[i]) we
> always find the NS register, and so the S register values aren't
> actually migrated.
> 
> This went unnoticed most of the time because a typical Linux guest is
> running only in NS and doesn't really care about the S register
> state, but it breaks migration of a guest which is running in S, such
> as Linux on the imx boards.
> 
> This would be more awkward to fix if KVM still supported AArch32
> hosts, but luckily that was dropped some years ago, and AArch32
> guests on an AArch64 host expose the sysregs as CP_REG_ARM64, not
> CP_REG_ARM32.  So the only place where we use a CP_REG_ARM32 KVM
> register ID is for TCG migrations.  We can therefore (continue to)
> steal a bit in the KVM format for the NS bit, with the semantics
> we've given it on the wire in the past.  We just need to let
> kvm_to_cpreg_id() pass it through rather than forcing it to 1.
> 
> To retain compatibility with migration from older QEMU versions
> without this fix, we need to add a subsection to the migration data
> that tells the destination that it can trust the values for Secure
> banked registers.  For incoming migrations, if we don't see this then
> we ignore all the values for Secure banked registers, giving the same
> behaviour as before.  This means we continue to work for migrations
> where the Secure world exists but the guest is basically not using
> it, such as a direct kernel boot on boards which don't set
> arm_boot_info::secure_boot to true; this includes the cubieboard,
> bananapi and orangepi.
> 
> Attempting migration from a new QEMU to an older QEMU version will
> now fail cleanly (because the destination doesn't recognize the new
> subsection) rather than silently corrupting the Secure banked
> registers.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/467
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h  | 21 ++++++++----
>   target/arm/cpu.h     |  6 ++++
>   target/arm/machine.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 100 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

