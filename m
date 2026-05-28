Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F4FCD6E56
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVBI-0005Jp-UB; Thu, 28 May 2026 03:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVAb-0004wb-N6
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:28:47 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVAY-0003Pk-SJ
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:28:45 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4904127c32cso39463755e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779953321; x=1780558121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vs0Ru16v/kVCmYV5cc1rpyROkSzyZN/jl6POv6UvvZ0=;
 b=ZOozvMRujRhOGW+tzzMor37D4RYxECtpzEHPgf+bhSULuVqsb1hrrlEY5tmN74Gk2f
 0lwkD4dY0rV1YNHYR77uzf4sZ1gvLLFzMV0P96H2eFFAwLceDce1OpQC5UlcBLwd1rSm
 clb1mGZX+LJdqk9JKoWupGEcJKXeBjITH9YNdGXVXmJyswUnAldOr2+8+2vjyNeJGefc
 06jyPKoCawZ4N8de4xFW1XZSHibw5W9DPd+kE1xSLQ6TI+uQuNJLGLEfK5ymbM9EdEBI
 YT54v0d3+xWUkCzX4FnnB6FDkU2Xtz/LzbX0naiycXkbbw9DnfZu7idXNMCQ+Y0u3M/O
 SgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779953321; x=1780558121;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vs0Ru16v/kVCmYV5cc1rpyROkSzyZN/jl6POv6UvvZ0=;
 b=J205XBeH5ydQjisrx9ndmRGfbPCVoxdUCBykGk63HwD1OK86y8kRl/ljTR1LiwhWyA
 Cg+2ZDy8/sYZqHFUvFLTdeBRcVrJdjGv+m/tME+O3fGlIA1JMqRp7fkiNINRYx3WUWoW
 hrzBacCeeqyOXe/yx8ln5nNxtlghCeWgF14jI4cqBbzGXmUp+qNKWzswClLSXNOXuQhz
 TmjfIKY5KnC+0rH+LwVOOp2W+WFdQbkC48ApBsuJSn503FduE/Nb9Op24cWP2KTpc+aQ
 eQA9v/Dn5jfYDwiFf+5lA7G2PeOgyafZtMNre1l4DVoYrZy1XaJieGpXS0AxlYJMlz7U
 lEVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/38xertjN2lDYyMfwG/A8SMcb/VQ3LXtvJiYWQDeGUUZtHdINg+E/tPKGy24hHanXTe+HBL5MwW0RF@nongnu.org
X-Gm-Message-State: AOJu0Ywi6RgmkQlCqap2Z3Uc/Bu6lFAmB7WgshyBm80ELZ+tLs4gqjbU
 9h5yJPVQBgUcsDLc10sByFr6Brg0f4f9yA55VU046e0PcJT51aU+HuvQsHuGYXJJ3zs=
X-Gm-Gg: Acq92OGTDoFQ+9rqSvQ6ZN6epLYfoiOPqC0UzUjck7zywydKsrK8YAWIN2R+GtLzBUM
 OQtLALFA/S4siieXcATUe4N1Cl8YJniFs54oA4gsGmXtYWHxIWP4MSy0s9E6fkym5JmljX9lRGj
 vbpnbRnwoNKzqLfwKVh6YTmMrl/7XPdQkNzJ/VbErgmLXgqc3MMne8veH8f/3UsdKlDavFmhOWA
 ma1VjXiNmtiNg+YQp4Gq5it+EVxlFGrVILUtQI8QbuTVy5HbZ1SELznooZPcbTvtNfvT0ruiC12
 R+wXNqOrsjc4isD7mp07zQ1WS06gAxtz17snN9g1CBQiwtTYH5WPfrdiSwmnKZt0Sk9GLHqIYt/
 NQkPtLgWt8K7Uy+o3rGRfI2LzXr/Sr046edL62XBQ3U1sMRQHEcEbradkTM1nqYlX6cOwA0KvYJ
 uwTn7gOTEmVqgOJnRrxDPygZDfe8BZBkGavFU+6lb3clru2UQAK14+iU0H1f7pdX3tIheqYfZzg
 ubi
X-Received: by 2002:a05:600d:6451:10b0:48f:d5e8:758c with SMTP id
 5b1f17b1804b1-490426d1a78mr320661265e9.16.1779953321219; 
 Thu, 28 May 2026 00:28:41 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092a92594sm20652775e9.13.2026.05.28.00.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 00:28:39 -0700 (PDT)
Message-ID: <ed66d1df-81a2-4835-a2b8-1e95c905d980@linaro.org>
Date: Thu, 28 May 2026 09:28:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] target/arm/whpx: move whpx-stub to arm_stubs_ss
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Helge Deller <deller@gmx.de>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Brian Cain
 <brian.cain@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Peter Xu <peterx@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
 <20260528051642.115721-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260528051642.115721-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 28/5/26 07:16, Pierrick Bouvier wrote:
> This eliminates symbol conflicts for whpx symbols on windows-aarch64 host.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/arm/whpx/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

