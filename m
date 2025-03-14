Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C63C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8iJ-0000hK-Bp; Fri, 14 Mar 2025 13:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8i6-0000fp-TH
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:20:39 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8i1-0006hw-Os
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:20:38 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fec13a4067so4109356a91.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741972832; x=1742577632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Z8Ejyf5gVIQB49egYugEEvIlbhLo/s2/9aU/7U8kVY=;
 b=nnByt/7ISSab8zmfjkf9ebyAQgZqqRA/JtoEohkmZBAPK+9t+/Pw6dsDdG5hEUTsTl
 zM+1HZwfY0nvCXf9J1EbCHQIxKK4b0kdb+z4P2iXiqudysRp1cxDs6S5SMyR5dopZJzx
 ZknP+izsE9Bu6PDOvuRYLC7SyJcWmtpw5WEIAsdnhi8dkexq0VILNAwFJpUUtlzcnaGr
 W1CQVBstgiDHwU6HlVizbc4T2N4najva+X6lGOhNwH5iw3YjSPEv0aQlz2ZcDjtkxYDd
 iq/qObx0kEGVnSU7VrzjSLCpB87KjO14bg0i5YfPSYXxFt681apgIWPpnMBpWlxme+fZ
 1hzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741972832; x=1742577632;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Z8Ejyf5gVIQB49egYugEEvIlbhLo/s2/9aU/7U8kVY=;
 b=Y2ZeE2qzaU7hUBXn48CNywfkwJAg0QBnQzieEfeq8GMCB/S9SpOR8NBFuwQitxccKW
 BAOJTY3bcL7PxwEMGiWRjA07zwm4CKcE2eI4q4Rrb1xZneV8FHebXx2NDsWC1wHL1GuG
 bJG/v+WaaSbJRwzcWK14rnzoudE1EY7wokNjmgha3Zhl4ewtMYDun0hfZqaUn3llJycK
 jQJncEpFAxOsarkCdFH8WDuCqLBId61we/phPv/6YRfxAOd6fj6ZgzeP1uLKUrL6O9Tk
 pFZ/4jiuZoMCKc+lOLh9RqQQkbMA696VHmI0wJBK+ZEzlmbMSmVQpY1pvTWIc9tKV5tl
 VZrg==
X-Gm-Message-State: AOJu0YyRO3E7kA2DmfGZudg7vwH8fM4sLN+0jYoBX/+14Ie1otNUnzHh
 7qLy7i4HOr57AStkrTBplIgtL04VqFLmVuFhMWkaws1OoVaZkSuMb+ADtXUG43o=
X-Gm-Gg: ASbGnctGx0iY4HIKx+UGunK2VKe5hhzhPiGGvrVJ4wWwxX/+THXkU4JK3iZJuKRMnXw
 6DXPTK3qcQfF2pTItECtexlII7C9r3ZZKCjgbPDxuAvIscqPFq4Ybx6F6O//Zp8D8IE6ylGPkty
 y/19MBARwIBx6zedrYnXBDsFpBtaqQnHVkTcguPBsnC2AEwWw7EA/0i4hAeJOaJ3M39l1bJPpeh
 OGCZNe6GNJ1nys0mWYIpP017wirf3XFUWVULrSyW7RU6C5Pp8KUcPVd8X8PYd9ypKoG7oGQPzDt
 PfWDqNrtRrDbpR3hbUSfFafFE1drkBFkmQa2M8+13oonWZlNQ2lsVc+w5502esFo8wtY
X-Google-Smtp-Source: AGHT+IH14/vkNdOBVlHqTbsYx0wGv8KV3ghiAEvAGkec1UsA+oGhZP9+b0le8JVQuRL27/WBey/Lyg==
X-Received: by 2002:a17:90a:da87:b0:2ff:5e4e:861 with SMTP id
 98e67ed59e1d1-30151d9d4d8mr119507a91.24.1741972831743; 
 Fri, 14 Mar 2025 10:20:31 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301539d40a1sm1393009a91.1.2025.03.14.10.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 10:20:31 -0700 (PDT)
Message-ID: <a04d4b3e-c2d6-4193-a95b-b8f61645dc27@linaro.org>
Date: Fri, 14 Mar 2025 10:20:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/17] hw/xen: add stubs for various functions
Content-Language: en-US
To: Anthony PERARD <anthony.perard@vates.tech>
Cc: qemu-devel@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, manos.pitsidianakis@linaro.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
 <20250313163903.1738581-13-pierrick.bouvier@linaro.org>
 <Z9Qwg4PC_1bEaOLK@l14>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <Z9Qwg4PC_1bEaOLK@l14>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/14/25 06:35, Anthony PERARD wrote:
> On Thu, Mar 13, 2025 at 09:38:58AM -0700, Pierrick Bouvier wrote:
>> Those functions are used by system/physmem.c, and are called only if
>> xen is enabled (which happens only if CONFIG_XEN is not set).
> 
> You mean, 's/is not set/is set/'?

Right, I'll update the comment.

>>
>> So we can crash in case those are called.
>>
>> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> diff --git a/hw/xen/xen_stubs.c b/hw/xen/xen_stubs.c
>> new file mode 100644
>> index 00000000000..19cee84bbb4
>> --- /dev/null
>> +++ b/hw/xen/xen_stubs.c
>> +
>> +void xen_invalidate_map_cache(void)
>> +{
> 
> Is this stub actually necessary? xen_invalidate_map_cache() doesn't
> seems to be used outside of xen's code.
>

You're right again, I added it by mistake.

> In anycase:
> Acked-by: Anthony PERARD <anthony.perard@vates.tech>
> 
> Thanks,
> 


