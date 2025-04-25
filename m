Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342B2C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KPF-0002Lf-8W; Fri, 25 Apr 2025 10:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KPC-0002L2-Qj
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 10:51:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KPA-0007jx-RH
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 10:51:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso1727652f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745592711; x=1746197511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CGE6UG+OVqd3GaSBfL9qpLMTvgMRYgEqf87pGEIjybA=;
 b=sAqTxqc3OwaODtt9ziI4Yo9cFr41H+J9D48D8VaPhVPXlF8mZCJVr3zz0jdt2CM1UN
 9xtne6sH0FHTSkFL8sert7bj4Btf+lxb6BUYh1fQi/+XYyIOKJi/0PP3XheJV4Jy3bOq
 7PzHHxBPPCJayD1ZVax1hwUvYsRqbhFRizkW4FUIpJWKwdnsuxwbBIWPqC6QzVKn1oxh
 T/Oe9dgC7FxpN8XraxMv+6hFkYI+Bsmr3Q0f1qNUEhES8UmPhCMeZ7VNKszDdgZ4cgfw
 XW0EpC/OWiYc34KH21AKJRF8KRgGlmTr9a+IeaESl9GaX8YxWWixsO3VSR8h7mJdr0+1
 kt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745592711; x=1746197511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CGE6UG+OVqd3GaSBfL9qpLMTvgMRYgEqf87pGEIjybA=;
 b=rJeugV0qHW5LKqOwLym6EVRkAMOvp5tzLK/vMDQJg6MHTSwAo9/d1zn5lOZIZrmQ7O
 6Zkvg5ka5P681euR7YLrGQY71eTPoA9E/jTdfskwBxyvBqu+8M0Af76VLZ15Ayn4n0Mf
 CtnsWxJTMJFL9k/e5P6MotuRlOZX1f2qinezfoi+Dxzgdb7QK5ke3lkeBxBIjn7dij31
 ukWbeuqU+qylJy6muZBcjUY3nVTXIuGFBTBSmw/i2Z+xJV+l9a2f8KRMMAcCc9R6LgL5
 vfHc43ijBn2pX1jIhQAadl+W05i6fuI8lsewHItibJ1mj9Lh+kol05cfPIKgystjnEZ8
 MDQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdYjVFDfL+mveZYLesrw7XevGw0zviBWE415aGC+vmehSmE7JjSfxWjBI4/xZoVNqDF6Ej6tRiuwob@nongnu.org
X-Gm-Message-State: AOJu0YzmCrpOwW3MBDu3+EjCznpfwcvcDpDejYurENtp0maqeAnF0j92
 HjTGZzrm8vcG6+d1fYrPvCQxnCmKVwqLoQwSFzXHwUxluvl72fwovvwPJkKH2AP3/ly2EZ2dYM4
 2
X-Gm-Gg: ASbGncs+HayhIk+i7mcaP4N5rfCAH3/0xGNKLHSBbO5kGHShecLu5hJ7ksMSERpFHxn
 AQz+KoVfhrq8buBPrvYsWR4UGtrbKP2AbmQxMX1qGLDKc9CQSKi/fbaX5MBuMEf+mt21NXwAv0M
 FUZu1LTbMKGYyQSIK87gaGabvdNAzrIxi8sQeacEjOpfWwOET0IPWePoeMUTVaIOnh4QRuyeV94
 My0Hzg8VGli6lkHTgbDyMhdYvxW5DKJ0Wq0l8S2NZmI9PvL5fzOPYUm4OAb1y/wAD/6qqPPPCWy
 3mmfcbSZr8mRHTHQs/4nu+DM+f2FjA27Y0xuXFjvCxv5JCONdxlKCCTBwfiAD5Fkdni6hWB7dZE
 EZwC8wcsR
X-Google-Smtp-Source: AGHT+IFSc1UFfFshkZOlDunJCHlH6dSK2nCeOkmDpatGTQV6+ofkvOfND9JWvvMrYs6wH8CXB5J4Dg==
X-Received: by 2002:a05:6000:2283:b0:391:2f71:bbb3 with SMTP id
 ffacd0b85a97d-3a074f3a0a3mr2286228f8f.46.1745592710663; 
 Fri, 25 Apr 2025 07:51:50 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ccf44csm2624994f8f.60.2025.04.25.07.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 07:51:50 -0700 (PDT)
Message-ID: <c22b4b2c-aac4-4e67-a026-1739ff10addd@linaro.org>
Date: Fri, 25 Apr 2025 16:51:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/20] hw/net/can: Fix type conflict of GLib function
 pointers
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
 <4d47a75c5768c9a6dc5d8b3504e78837577ad70d.1745295397.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4d47a75c5768c9a6dc5d8b3504e78837577ad70d.1745295397.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 22/4/25 07:27, Kohei Tokunaga wrote:
> On Emscripten, function pointer casts can result in runtime failures due to
> strict function signature checks. This affects the use of g_list_sort and
> g_slist_sort, which internally perform function pointer casts that are not
> supported by Emscripten. To avoid these issues, g_list_sort_with_data and
> g_slist_sort_with_data should be used instead, as they do not rely on
> function pointer casting.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   hw/net/can/xlnx-versal-canfd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

