Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B0CF99C9B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEDxs-0008KR-4c; Sat, 18 Apr 2026 18:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDxj-000819-MG
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:16:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDxi-00085N-4q
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:16:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488c2690057so17480105e9.0
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2026 15:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776550584; x=1777155384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ePfa/GMngx5939waiNGcXDE+WF6mNQU/sdgDKua9di8=;
 b=XRwlP/Bugt3uONGDwJrayVrqDfFSgEgtKICr2bC+uF0HE2ag4ypoptDRVKirEP8yrU
 2TuEN6ifvx8z4To3/fnQW0vB7pYP5UMk7uzIofzVhkYP0RJVmDAzZtZM8UzVb6cztcSd
 ayHQYCknNDJYlTtHgZdKAE4G7WQ2djMJ68uugZ2Z9+Q2UqhutSihIK0A4glhdkwDokvB
 N1g9SYongoghXwXUjreVImZqORWKfHlxcnKwbhEd3cxUPsqXxmw4OO9t6s0gamoKEGOB
 U/2ywi/pQWwvr0bAO+0Dtqrty+UhXbJq9tO0S3dlFcisiCOSkLUiShM1bbsJtWZAVZ2k
 5zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776550584; x=1777155384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ePfa/GMngx5939waiNGcXDE+WF6mNQU/sdgDKua9di8=;
 b=sDPFoZmivBNN9ityzyyGzbsuXYfrrWrd5ouTGwmQwQfGKWNBCsVz38Zp7Kqp8HEUC1
 JmgTyoWm6aerjViPPkvU35bkfFD+0H05mgsvg4q9JMzuHmnVXY8d6Exn/G0gx/MooMcU
 fM1ss+oKPHyNz0vbnThrpnsCHIhtU7tkxw8loDtOHESB9XdtqWw78B52MNr7c7rgbkkk
 hJiz29w6sR3fBld6vjAv+S/xy8uSIz5YK41QCzTzCngowPPfaXvaga18SkueQYMLhKPl
 PXXdQPO85BqOw5gpyNYb2kudzIjOkWV49U1yppxDftLVyaRADJXZpl+0BAKKyHvS0F3R
 9VMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AUaWgAt9jSB9RUb/zpRcdci9xuVfWPAlEzN+9W/364unS+8wt4/YmlQ3lJ3uzTEZYfVWNVKSCyNU1@nongnu.org
X-Gm-Message-State: AOJu0YyrHoNi1zQNt+zHosmpePy+2UarnOchPR59vjJWrMp3DB1lmlBL
 L4A4gcwrN7xvM3dfoeacH1E/LuRn2cb0J0JvKMDBYjNyWTystGAil9UhI3jEN4sZ2yI=
X-Gm-Gg: AeBDieuhqUG1T2LH0N9ObZU+rT3bIdubVk/To8vnGHgFLeHM/+0URkcp3e5DakEUuIF
 5eeuEa9owov5JlO889emw5zK5FmG7zXzbU3DpJxvLVI1vu+LGTS6BldjUQy8K1pUsZEaiqZPz7o
 HJlrshsUxwcsJl2Mb848WimxvR3x3d7igJYCqRlOCeb6wcZdqeTdAAZ0YSrN51rBSXZMQYS7OK6
 z2wz1N+wiTPBpxyznzv81FqqarW1w0S5Y44ltCNayK1QZM/Mvu6EyC4B3FBu2434WSESyJd+PpN
 YNxmndoPAprMhcX8ooyC5L5lDgWBlJpPTajFnXL9j3yRCmt5AL/li35jPOIjOboUAw/yFGTKlzw
 NaJ/D4UuxAhavtI2IAxvibzzmOItCVePbcwDYVFNkVdbIaH7vVcwMRm1NKELn3Z0o/Dch3U/RVW
 SFnqNehIeIZCd6kRS2bA1we8SZHYBbdBEc+hcOzu7hFLk91SXVy0AawiQ/g9HdlD/+ztqg77KEN
 boS
X-Received: by 2002:a05:600c:5295:b0:486:fbd1:9dc0 with SMTP id
 5b1f17b1804b1-488fb780463mr102683585e9.22.1776550583775; 
 Sat, 18 Apr 2026 15:16:23 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1682sm16978866f8f.1.2026.04.18.15.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2026 15:16:23 -0700 (PDT)
Message-ID: <0824f794-c89c-489e-a020-1e75f3b00321@linaro.org>
Date: Sun, 19 Apr 2026 00:16:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] target/arm: Rename arm_cpu_get_phys_page()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-12-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417173105.1648172-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 17/4/26 19:30, Peter Maydell wrote:
> The internal helper function arm_cpu_get_phys_page() is named that
> way because of its use in the get_phys_page_attrs_debug method.  Now
> we've renamed the method, rename the helper to match, since it can
> handle non-page-aligned addresses.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

