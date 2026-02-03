Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D01E83041
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 02:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn65x-0005s3-8Y; Mon, 02 Feb 2026 21:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn65p-0005qC-UH
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:24:43 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn65h-000152-SC
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:24:41 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-8230c839409so4097002b3a.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 18:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770085463; x=1770690263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cf6DMZmyKS3/rG3G6fIPqmL7Z+nqO+EfT8m7N4GQ+MA=;
 b=DK+kZ6WzJUI9EEECubI6MPPR0k6WmX+qMH8SrzE0HQ7V1N01uH/Ajw8ix7Hmb9bleZ
 yjmHwRjTf5XhwHJ612mQmlh3Wb54Eku4dw6Evs5JyAB96PouTIgfMCAoJM6QxwwetnW2
 eEWfbvP+M0Dx5md1vbYPq1k1++rSuTUeA37H6WQC27lpdrKGdtpN5SHg+unFhSTZETcg
 swHaaod0xdzE7qXU/7ymHmcqnBlNtfMrGmvomSMqkgBB1fWxqccBfMxb4aJUB9Pnq3lN
 R0U7Bh/XcU9WQoX4vblnZoLCQp8Sg/BldLFVpl79PKjOAZ1POwve2n/oet8biDKjl24N
 FIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770085463; x=1770690263;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cf6DMZmyKS3/rG3G6fIPqmL7Z+nqO+EfT8m7N4GQ+MA=;
 b=k7kI7aeWKl+FRMw0p+7vEoreYQAbnPeMWwtSXPqF0duDxK1ABJn0Ywp9mh64oh8E9G
 R/FYwpjx0iefCzYRc2ICY3dUKI3IKXcQdRsI5DOYtiFVscxhyGx8m95IyEXn2jIHwK6k
 Vf3e9S97Swckc3UTZlvC53N5+gRl+N9ew2kCI+hEh/SsjhvcVykyhHotGfY8yRCWaZ2T
 ZVmdvoijAO//ONXM/8i0vpH9H5pqhORObcli4WJKpJKuyCE1p2nPaFsgj16wGWC1uYpi
 KjEzR7qyHhppXs3XJjAJjk6Fpxkl9zrSMlu1ARafZhA5FZ2NmW0ZqT1i7CWy7RSLMxNv
 B4rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMcabbzX+zbpLJossKseJ/1oJVS6ThVq3iReGaJDvkYBQiMJEG2PMciJzQVUYp8xJHMTpH9qN7lWZa@nongnu.org
X-Gm-Message-State: AOJu0YyJH6Ke4ntFuYaO1oXeC6pZp0q2EyQw1RPXjBj6VjvdTCQvEyG6
 kORGsOC5zWjod4sc5Ma8dwh+tk7RT0K/fs16wbdHr9QNqka+wTpO7vN84Tl8QHxV0ZY=
X-Gm-Gg: AZuq6aJNID4iDswoV/LZd8gRc+bZHCCt1XxBYg766+ZedZXFeCgtbQo8RIu+CErZ1te
 2zX9v70st22/Do96KOCVajGfcctFwwZLfKxalih9koTUbQsiqv1ongRWyRC0kuujg0qPIaG1Zcp
 EPJJV0jKmv03qYojYlmMM+ebrGu01eMOoyDCqhqUu39STxTQ1hhwhNCBaOVBNU9q0vJRToWY2+9
 1uhHEYyt4oNgzqHyda+JfyasDw2Pyb6eAF0rxrN/UEtzI3wP1sVs0ynLsgUl627RNyi441F4h2i
 dMqlnonB9D2IoZ+rYCKPjDepEMSA71lBiZFAFXsXvU/biavmmpw3x7yP48W8W7kC8PChfAM5p8s
 K5FCF69IWdIE8LjhZM8waDtmVAfSNO5P8hclOEyRdZS6NgdNXCBFdLJHaGY7qSoDIZMY/DnpV+G
 /iQOuRxpH4GlK+9bgLdmYvZYa+F6CvPBbKkYYkhJBGIhryqQdM1Pq+qFs0/GdTyLZWXdnKc1CkJ
 p4vdAJw1v7GKi1oZK+abf5wQM6cqaRI/jDYVbkx+g==
X-Received: by 2002:a05:6a00:4b03:b0:81f:de62:4b64 with SMTP id
 d2e1a72fcca58-823ab98fa2cmr13159329b3a.68.1770085463448; 
 Mon, 02 Feb 2026 18:24:23 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b2305fsm20728991b3a.10.2026.02.02.18.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 18:24:23 -0800 (PST)
Message-ID: <fb85a3b7-5281-45e8-a0df-9c804236324e@linaro.org>
Date: Tue, 3 Feb 2026 12:24:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/tcg: Pass access_type as an argument of
 tlb_set_page*()
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20260202075358.2137740-1-jim.shu@sifive.com>
 <20260202075358.2137740-2-jim.shu@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202075358.2137740-2-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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

On 2/2/26 17:53, Jim Shu wrote:
> Pass the access_type so that we could know CPU will do the read or
> write access. Then, CPU can fill the CPUTLBEntry[Full] of the specific
> permission (@prot).

This is wrong.  tlb_set_page* is recording data for *any* future translation.  There is no 
one access_type which is appropriate.

I know you're trying to handle cpu-side iommu translation, and that you have a case which 
requires reads and writes to go to different address spaces (?), but this doesn't help.

I think the underlying issue is that, for your case, we're handling iommu too early -- we 
want to be able to defer the translation until the actual access.


r~

