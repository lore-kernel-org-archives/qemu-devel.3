Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257EBC35FF8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 09:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu6er-00073Z-R2; Mon, 17 Mar 2025 05:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tu6el-00072b-4w
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 05:21:11 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tu6eh-0004AE-CG
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 05:21:10 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so3593164f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 02:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742203264; x=1742808064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YpUsKKtqVCRGopEBPreIzxle1j3+eqS8AQYhEVEoDhg=;
 b=cHZ7zu9xtGTfV9uyfrxhY7ZGRO3CzGDPhYBg+9A+Crf3vUUTRZT0jTEbmtDBKmmiV2
 TkVOAGspCePcDjnZpJSvDhEsMJ4h98hTc+P+lsv/GI8D4NUk9riH+2kYDyPmyaHYKDSE
 nDWoSFImn7ESfwHld6ApF3Q/X+Op648yWq8t6YqaAG7GobtFCMg6rM/BbikrpWNfm8FY
 J8gc9ZPY9plck83wezTu37PE6lM+TsuKNCAB6BNTSV0A+GmrYs710DHh8iQGf5wXunSc
 wu6nY3YZ/K19Tfn9RTLIbIwBn6jTQqXHd63dtnWp+/4NmmOjaVVqJ7XxLsjqJgJO2FGx
 5/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742203264; x=1742808064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YpUsKKtqVCRGopEBPreIzxle1j3+eqS8AQYhEVEoDhg=;
 b=vCfCligy0YYdzWPevrMIWfjmt8dEQ3EWAGDjtW77I3CvtLtpdwTPd/MPFL3IQjCQQi
 gfyd1gaJ9zqJ2c2fk3FRDWnuVqsNKegGXptht9MVZBisGI1XOtV4Dtslj/UnC0m6j1TI
 KvUalwevsV6neCGUt3kx25zf1196ZSg3AkTwPUlPb5cj9hCvSqNrRADI2faN3yAcpP0q
 3hiNPvbrETNbbpSxDxpLZtOBjSlVf5zMn313jt8LlhrmXxbz+KZyfBPSo9o1gbWe7ybS
 ZXLaeXT1vV2nCitlG4/oW+BW6QcqJITzxGH5lSk0NHWSUeGGICRkUFzZavPJMiMSxW4L
 BwCg==
X-Gm-Message-State: AOJu0Yz3EizsrUvxgLXixxO2AYbOjiSpiqDRpi6BztaJOiV1/JO+EAOe
 lciwSAcwqC2VD7EqHPt+HrjOOPZuNgkUwcV9OqbP4O+2QGlws6LgGSzB1uENxic=
X-Gm-Gg: ASbGncupVpNJAnROEjgc5l5Q23cQLAWVJuCqvx5+9rH5YtJGOkNl/tgf5x2io+yaMmd
 t/mvmAAxbVNIDQq0IzmhKNuHHLnZ6mmap8PlE/e8qPHcoBcnZiicjyeBjPeSl99v9fzBL2DZXC/
 OBCA6IhgFuKKRlMu/BHgtvEgk6Ph8MEUXSNmq1X8MrvNbaRIyLdSuCDH0bMJrWmME543P8951hr
 I/mk/bnKgv1pM12rWthDbbsWsn2EcxY02IyjCcw/63b0x/Q86uY4Xd0YU0WYn2eB3I3DrYeLchb
 2+2h6dp5x7/MJ9gTGYDnx9OOR7fzzOtZdW482hjfpVFfzDFztAbPOA0VFEPFI/cNwI9pCCo9NyS
 jj65Z1Ktjx9s=
X-Google-Smtp-Source: AGHT+IGWnfmu1vxKt8DfVr5Wh5yIJXe0q4pEomCwp6mUHJGY4TnJ5r3CTWvfyQ4vsQ6wNtdAUg6E4w==
X-Received: by 2002:adf:a456:0:b0:390:df83:1f5d with SMTP id
 ffacd0b85a97d-3971f4116ecmr10959222f8f.35.1742203263878; 
 Mon, 17 Mar 2025 02:21:03 -0700 (PDT)
Received: from [10.223.46.213] (109.21.205.77.rev.sfr.net. [77.205.21.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c888152dsm14131479f8f.48.2025.03.17.02.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 02:21:03 -0700 (PDT)
Message-ID: <3ce90214-a080-4ae8-86ff-9f8fd20f1733@linaro.org>
Date: Mon, 17 Mar 2025 10:21:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/17] make system memory API available for common code
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anthony PERARD <anthony.perard@vates.tech>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Paul Durrant <paul@xen.org>,
 Peter Xu <peterx@redhat.com>, alex.bennee@linaro.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
 <5951f731-b936-42eb-b3ff-bc66ef9c9414@linaro.org> <Z9R2mjfaNcsSuQWq@l14>
 <ee814e2f-c461-4cc2-889d-16bb2df44fdf@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ee814e2f-c461-4cc2-889d-16bb2df44fdf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Hi,

On 14/3/25 19:39, Pierrick Bouvier wrote:
> On 3/14/25 11:34, Anthony PERARD wrote:
>> On Fri, Mar 14, 2025 at 10:33:08AM -0700, Pierrick Bouvier wrote:
>>> Hi,
>>>
>>> one patch is missing review:
>>> [PATCH v5 12/17] hw/xen: add stubs for various functions.
>>
>> My "Acked-by" wasn't enough? Feel free try change it to "Reviewed-by"
>> instead.
>>
> 
> Those are differents. From what I understand, Reviewed implies Acked, 
> but the opposite is not true. If it was, they would be equivalent.
> Thanks.

IIUC on QEMU Acked-by means "as a maintainer of files modified by
this patch, I don't have objection on my area, as long as someone
else takes the patch". It doesn't mean the patch has been reviewed.

Please correct me if I'm wrong.

Thanks,

Phil.

