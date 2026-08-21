Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B453DC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxHFu-00069c-5u; Fri, 21 Aug 2026 00:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wxHFs-00068w-8a
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:53:24 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wxHFq-0004A6-Fr
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:53:24 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2d027b7c8easo963835ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787288000; x=1787892800; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r3yLtAY3VuaPWXVg3eERCjkedEW6t/+fIkK6DuWDOW8=;
 b=Q4bGfGevwUOsmFAizkjx3+kEm3QlJchpMh6uf/wArU7CuZ8/DtgAyS+RC6LbQQ4Ahl
 VEOKeNg0SIiD6CcA8cDoXC8l9XFDklK4rjkzHqxKC2lubIvWHeHW9VHJVlUkjdl/c9X8
 Z4AmvRTeDuS9usp0I5jrGWxSAa/K+OA3H+PTAO0mr4Pbhsz0BiEOzECSXlaqE+9ADgEo
 mL0T0km5a7JgkannkFE3er0o7vWYAu6X+kCv5MUnGK2dTj0DaBx9QlqJ6lSGO6Sao0bV
 z+0UeIXQld3/6wo/1DPuRQ5BSiy/Vs4iVL1ZU/uVjsEnybE/Ev6sXTVPouzUiRqMq0dt
 Bdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787288000; x=1787892800;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r3yLtAY3VuaPWXVg3eERCjkedEW6t/+fIkK6DuWDOW8=;
 b=Z35sTU7zPzHCLf4ziHWnUt/ZT07HrLYQxOPvf8GlwM/eyFPpzdbLe875B2sVDJ1qjL
 /OD5I3PRB+ddOhVg+tuPw5qPTjQRuqSAr0x7jvaDMLl1IMCSl2OUz98XGQdPfUmZU3hZ
 vpF7nS/szv2El3wARR1ZwBGg92NzbllmBGBdA6mGUcav/z1txLs7xQa/CacS3+EnLZNH
 CC421tmDVPGT+RgC3sqB8ocHgwoyVjbIQI4GKnCZcFmOpIZ35aqVDfgzIlVsJUAD6o51
 cdyQaJfP38ic1vdPCrkSu6LVJiaCC5atdAG3ezhBRTBX7Udj/bFMS9o87gaPgmrUnPP+
 wQsA==
X-Gm-Message-State: AOJu0YwpKb7QpVz1FWNLVUGXYTJVcTKrTdKf/Z09AN35eQFAscf3SL+o
 ahxrGq/S6b/bRQQMo2MZI804AqcgSzh4RjWYysWCiaUGQP7Vj9PEgwferzO2XmooCQU=
X-Gm-Gg: AR+sD10rBOgxJKFxfJtekyQ6cgPqsNb/VjHYenHnIV3HMkVnRn32QwsXw6rTu6j2oYh
 Eq1XBFX+9u/YtvvcIoo5aQi+50UzWY3ie2oE0P8lFD6N9Jat5h/kb3gl/qAOSkesd1kCEH9It61
 rb9pbRGghb9dVSMuAYnOgKpZYLIwuujokp1y3vJDaCR3PIrR+62SvLsCxRhEU1T+8lqyblrJYpn
 tLuBN72MhXrLwNr92WZGr5I6zXFVDxMn8bpg5cvz/oXyTVXC2Dj9thJbe1c6N9mSvdUHPdKkpmd
 zP+ly9X/5zDEZOOd1t5xeu5czjenOL+LnnMRe8a090ZGP/6NJpoA6blTE2CFBbtprOVPn9No0bB
 eVEpCt29ochp1sMbQYSjO/iCqJgZnUI/jwML5RfiFFPghhyLI3zZdCyAI9wxDnJrrHfvBijMJsZ
 rwz+ww4GEfSnvjK9bXTxHTCJiAg7EbjJmFllLrgyE8paXvo75wwMJUBFa1gHm00gFLXiGKYZ8G2
 7/UOTDKhnItqKE+
X-Received: by 2002:a17:903:291:b0:2c4:397:dd7a with SMTP id
 d9443c01a7336-2d64b189ed8mr32073555ad.4.1787288000444; 
 Thu, 20 Aug 2026 21:53:20 -0700 (PDT)
Received: from [172.16.1.33] ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62d555b2esm14265885ad.11.2026.08.20.21.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 21:53:19 -0700 (PDT)
Message-ID: <7f691e05-7512-4982-a4e9-a1ba5f5bf823@oss.tenstorrent.com>
Date: Fri, 21 Aug 2026 14:53:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] hw/ssi: Add Synopsys DWC SSI standard PIO
 controller
To: Kangjie Huang <flamboyant.h.01@gmail.com>,
 Portia Stephens <portias@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
References: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
 <20260808182956.290561-2-flamboyant.h.01@gmail.com>
 <3ed04624-9d4c-4c11-9d7b-4bb6568b2590@oss.tenstorrent.com>
 <CAAW0U4Z4hSpbC62xE78PJjJPQKNh+7XxF3-Q14QzymELedxhSg@mail.gmail.com>
Content-Language: en-US
From: Portia Stephens <portias@oss.tenstorrent.com>
In-Reply-To: <CAAW0U4Z4hSpbC62xE78PJjJPQKNh+7XxF3-Q14QzymELedxhSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=portias@tenstorrent.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 21/8/2026 1:56 PM, Kangjie Huang wrote:
> Portia Stephens <portias@oss.tenstorrent.com> 于2026年8月21日周五 09:11写道：
>>
>> I don't think this will work for frame !=  8-bit with the m25p80 flash
>> model used by k230. ssi_transfer() takes a 32-bit value but it then
>> calls m25p80_transfer8() which will just transfer the bottom 8-bits and
>> drop the rest.
>>
>> I don't know if this is an issue with your code or with the ssi_transfer
>> function though. It seems like ssi_transfer intends to accept 32-bit
>> values.
>>
> Hi Portia,
> 
> Thanks for the review.
> 
> On SPI_FRF: you are right, the explicit clearing in dw_ssi_write() is
> redundant because dw_ssi_write_masked() already drops the bits that are
> not in the writable mask. I will remove it and add a LOG_UNIMP warning
> when a non-zero SPI_FRF value is written.
> 
> On the frame width: ssi_transfer() takes a uint32_t word. The issue is
> that the DWC model uses CTRLR0.DFS (4..32 bits) to define each
> transmitted frame, while SPI NOR is an 8-bit consumer, so the two are
> aligned only when DFS is 8. The K230 SDK SPI-NOR paths use 8-bit
> frames, so this case is not exposed by the current K230 use case.
> Maybe either add a DFS != 8 restriction with a LOG_UNIMP warning, or
> have the DWC model split byte-aligned 16/24/32-bit frames into
> multiple 8-bit ssi_transfer() calls？


I think either option is fine. If there isn't anything testing the 
variable frame width it might make sense to just restrict the width to 
what is tested.
> 
> Thanks,
> Kangjie


