Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0D8D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvxe-0005Vn-0M; Tue, 26 Nov 2024 08:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFvxc-0005Vd-Iy
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:50:36 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFvxb-00037S-6S
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:50:36 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-296539a58b4so3047477fac.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629033; x=1733233833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XOqH23CdoH+o9Km6tgUOwC+jyeB3DBspFnu1boTZ9A0=;
 b=WaQs6+jm95LFpl/D0GbVy0n0XJPrrmaZ7ki3D+4o2rhIs5PL/9/ITmumbnH6Q+98V9
 4HFWBgJgoGCnhp4f4bukDfm6uY88kcBYPH+2xvZMkLO4hJJDQI1r4fkfDMh7hlJxlHmO
 pyfPF/ZPsLkVFpeiQAtJXcWMxHId7y/SQYXzqLXNM7lV7Qs9ftIQpSPZVqxuT1WJ0BkB
 wzfSokMJlF3RxCBmUmftRQlLWCq24CHfgFmzhAolKz9OC3Af5e9YQuIzMZae+NKBUP/j
 J6mkKlsXD72dVM91Z/owrp09iDINwMLJyMJv7GxfU1kCp9thadfmC1PIp02Y9L5JTKrd
 P0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629033; x=1733233833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XOqH23CdoH+o9Km6tgUOwC+jyeB3DBspFnu1boTZ9A0=;
 b=nRSjftIikPGcXDAj/gwBsFHD5/V6PkOq1wEVw+bGoihB2aB7uvGL6dzJn5LiKAbxM7
 iZaURElaGJ3R85ftWDc5cwN+SwtVMnflejkhxn8IL3B4c0b5j2oNp1IYccnJ3uk5SfNs
 0pOWD/Dq+9+Av1H2xNNgLvdJv7ZgGgYvftkE9y5JwefAeVR9GL27nczWH8By40gfLKTH
 xjtFFleGCWWfMa3cCTpLiuXGtazPCiiNS/aU4aVls9Hbpc4dz0/CPlTYjAkW5U/jVoof
 WuSShJiBdwKF5fLEQgi04+0ONlF4zSqdc6h0FTW/k/q36xg5RQEfYcJnFI0lCmBXLBSo
 PJNA==
X-Gm-Message-State: AOJu0Yy0vBCxr1i2wzj3+UETFfoCg8SvY6Bjj4fJ/HUKlJTJPn5itvBz
 AEWPZ+NsHyaVeBXmLCWTwF5qheNkj9QhwDdXwe/VVifnu3MLOZ249rnGvKLBKekzrn5gmSR1x8t
 i
X-Gm-Gg: ASbGncthBWNz0SLh+5Ef9PPoWg6fmhmYvXBNHi2uIpHLoVVAR9ZmUvmZJCKFBCLiPLv
 PAMILOjeqa2PDPQFHIS/jG8hwc5Whb4Cv9+8LBTDUpQwi4Du+Ku+U8CB61/wjcboiV12j37lhGp
 iwnW+Hc4MxjuEr7IEBRt3uasKuxrGFUAsU38ho+s6Ha8evwflGYKtQ6Wf0c4ZI49LxlP1RZGG69
 w/IgrrLUJlSNc+eE0GlcDJ4bDuIEHu+oB+vcRbQa9O4z11oEO/KujQ+yR+VMDs5Zg==
X-Google-Smtp-Source: AGHT+IHQWoDnOlgeb0QtkG0fHO2UDw3DPJMMFZyLGzco6TFqriz21Noa/jKvU8U3P54aEBxTtfacbQ==
X-Received: by 2002:a05:6871:3184:b0:297:245b:1e49 with SMTP id
 586e51a60fabf-297245b6749mr10062841fac.40.1732629033294; 
 Tue, 26 Nov 2024 05:50:33 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f1fdf7d4bcsm468918eaf.2.2024.11.26.05.50.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 05:50:32 -0800 (PST)
Message-ID: <6bf03d4f-85cb-478d-92e4-652fe6a98f50@linaro.org>
Date: Tue, 26 Nov 2024 07:50:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] target/mips: Rename gen_load_gpr() ->
 gen_load_gpr_tl()
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
> MIPS gen_load_gpr() takes a target-specific TCGv argument.
> Rename it as gen_load_gpr_tl() to clarify, like other TCG
> core helpers.
> 
> Mechanical change doing:
> 
>    $ sed -i -e 's/gen_load_gpr/gen_load_gpr_tl/' \
>      $(git grep -l gen_load_gpr)
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

