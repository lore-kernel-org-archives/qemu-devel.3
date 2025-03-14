Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAACC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 18:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt9ww-0004AO-CG; Fri, 14 Mar 2025 14:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt9wb-000423-2P
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 14:39:46 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt9wX-0008FJ-1U
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 14:39:40 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-301493f45aeso63321a91.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 11:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741977575; x=1742582375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fOozeBnii/eu0U/Pc7KwHCWiz8f0qLLsCP/hc4MPynk=;
 b=kt+VaxkwBs9JZYf1h42qxj/cixdRyn58YJXXABCpuLEMQfXARMfYxPvYWhegj23g6i
 xRfAXmrXhy6znXZ4kHB8TuBmUzrBG6gdgJBbmOov/WLMz528k2mixFscqdZ1I57nVnZB
 xmyFVqlMIVaemvhu+2YXo6k03eJkiecuwOwrTVS4+cUW6Zby4Yu5OQ9bjHSglbkXY9vb
 8yB166NelkXoJMniNbHsEoOEMSVjlTqgRHBSeiPuKKsW7fbfEImFi788MWwPrHO5tEDV
 JjH7Rc4ppB+yjIdGCl9vRSjKC+uJg5TUeQqwVfKpC5f3RBkqZWMDjCdmoyluMepfCt/2
 /p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741977575; x=1742582375;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fOozeBnii/eu0U/Pc7KwHCWiz8f0qLLsCP/hc4MPynk=;
 b=R4aXL6vzI83TvsxOFP99RAW0YoDQUrpP0VsntM94ee6+aAOnPwM/xtONhtC/HA+SVY
 0OF5Lgi8S8H9iGDMPmyYkKxNXBdPYaQrMuGe55Q4oCJ6zsfr3KZDf98lSyKiPpB44dTz
 bXMjeuwCaSYtriP0KmmIJ8Wc3cfRLJzkHK6vZHcFPivPmL8Ws4RXn3G7iZYs5qSa3j/0
 acomN7M8R/WEpzi9J9fKWVHYR8gTlrexDbvdN87X6NiNTe1P7ND4ddIvMBKo4DnIoSAQ
 gMZTesmPm+53mc0DKnPprC6xMuZTkd/mX/4YjFaFu7DMpBskcrJOoZfloSwLiHPK4j2i
 sGwQ==
X-Gm-Message-State: AOJu0YwKs/6gzGwv3q1BBaNaeXzm+poG5d/jq7XkR6O7EXJJzDp0gx3T
 DWmy9EKHS/bxUMx2pkO6yi2sj8TMOpir7zvda0Sp0ii3w1R6XYozHgI/mSVhRps=
X-Gm-Gg: ASbGncv7o+ezjXcuC2Rb2M9oV2sxoH9do6LC4m7SrL5+WLCee9zWwuOJEpJURvvbYLh
 4s8MGHWSU3QY2129PsFY1sWt/CDH564R0FU1VHgP5RVEBtyDG37rpU0G2/Jhebsulf94olJuZ47
 2pwgbaMOKcsF5qWae7YqZFOhRgx+rKJmFPZQ0+2RXOaPxO+4eu8RHtthCZwO+Hnidq/JVK77K51
 ONg/9RbiVpNXvEDG/jY6OrWqc3HlkGVAKyz79Tb+6BbVR48CsPbieS0AEUvesBybDrDWYvguyzH
 ug9d3AYK88YSVTH82jQgTxQ+eln1YJBTP6ygyIHUD4YHRh5v57g/cB3L8g==
X-Google-Smtp-Source: AGHT+IHy4R1pysrhxzZHf8PsIff+cJIi5Kt3lbwGj1TI7jFN2ZmDtBraZqUWWgeIc5QjfTBBwo1w6Q==
X-Received: by 2002:a05:6a21:6d82:b0:1f5:8eec:e50a with SMTP id
 adf61e73a8af0-1f5c12c7864mr4910034637.31.1741977574981; 
 Fri, 14 Mar 2025 11:39:34 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea7bd0csm3027381a12.47.2025.03.14.11.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 11:39:34 -0700 (PDT)
Message-ID: <ee814e2f-c461-4cc2-889d-16bb2df44fdf@linaro.org>
Date: Fri, 14 Mar 2025 11:39:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/17] make system memory API available for common code
Content-Language: en-US
To: Anthony PERARD <anthony.perard@vates.tech>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Paul Durrant <paul@xen.org>,
 Peter Xu <peterx@redhat.com>, alex.bennee@linaro.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
 <5951f731-b936-42eb-b3ff-bc66ef9c9414@linaro.org> <Z9R2mjfaNcsSuQWq@l14>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <Z9R2mjfaNcsSuQWq@l14>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 3/14/25 11:34, Anthony PERARD wrote:
> On Fri, Mar 14, 2025 at 10:33:08AM -0700, Pierrick Bouvier wrote:
>> Hi,
>>
>> one patch is missing review:
>> [PATCH v5 12/17] hw/xen: add stubs for various functions.
> 
> My "Acked-by" wasn't enough? Feel free try change it to "Reviewed-by"
> instead.
> 

Those are differents. From what I understand, Reviewed implies Acked, 
but the opposite is not true. If it was, they would be equivalent.
Thanks.

> Cheers,
> 


