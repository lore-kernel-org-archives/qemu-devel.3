Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16659E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 17:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOgiJ-0007kL-Up; Fri, 20 Dec 2024 12:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tOgiI-0007jp-Em
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 12:22:58 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tOgiG-0002GW-AT
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 12:22:58 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-728f28744c5so2237531b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 09:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734715374; x=1735320174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HDBfv625c7R2aSi7f/KnPch+VhE+r1TPXNdzdRWwyYw=;
 b=md6w93rURIqXHi5YPniFRXiggs3HD2odDv8+2Fi1/PrNkWCj6mQSArlALDnD7B663+
 AykH4Jb6y6fM2ubXf1LcD5cdL+Cg/NFhuk2lNjKiTB+JzOH2RHdveCYb4Orl0Y0kIq9H
 LjXcTqA+jYif/nkt0PN+rpuakMZ4+TbI6ilijuDBwutLZYcSuj8N7T2qo1P9ICqSvJ2J
 tYY1Jcwf8yFCagz+lefutgtwni/SV2XgfWMTx9xQBH5V+kt8EzbLW0gb3GyQHSxsKaxr
 TJfxb7ElKnsHJuXsHchE905bsN8sXrCqVseXeuT8sxZyRc+H1xEei7JvX50tQezDCbbT
 mkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734715374; x=1735320174;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HDBfv625c7R2aSi7f/KnPch+VhE+r1TPXNdzdRWwyYw=;
 b=qq0t7HGPImYbpmv/7xYSJrcgxypC+sX7Z7neA3kvjctYf5LS3tkvQhxdgESwwVDhVd
 C521hj4LWXFgsgP5gQ7o9q6HTb5Ow8XcQdE2pL4f5JTBrYKQ3H9vdgaW5IvwVJfiNbv2
 BZRvUt5d7W53oeuzI4E1gzkaeIfT3SW0tsDXhwvj0xeQjkZfNsfxJ85iRVFCkgCJUlt+
 AJZC6PnAHvHWNSwlAXj1OL9zFDMvS1fFCMkakGra8Pz1rAZekssPCtlThsHPm6fXyAfQ
 8HT36AttB809eC4UvMSHrXv4zWGMpW+E7REVSWUtH62lGFkggu0gc5jxkfZWYEzvpnx2
 jDOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPqcL3giuahTRuBNrL0T5aLuEGrchub9KiLe+yys7nZv1BKqjom4lw7l9j+C9RuGXgpo2nbAVkIZYL@nongnu.org
X-Gm-Message-State: AOJu0YzMdFJaM1jfGabC0wq4STeACvoMZErHdfxXKXMQMaMYKNiF4aIE
 qH/cQvhKeFP3IvFOPOiTViWdMgCv1hFiQEbE+Eig1jZe3pXGncJK8bI0Ap1kzwc=
X-Gm-Gg: ASbGnctFdXbaYxWMg+j4l/MclN85pBmdP4wpQJZeesHhHA++ov7JXjuCAfzQGzv1Pgx
 K9txfc69QjSXhGwBVamDU4VeWE5r13r1qCbpx0YFQ9U4wiTH/pkr9mTMDvIBzD0Mr1zwJu7fStw
 Jj5chRcBB1sC6BAJZGJAA+I9ZEk8Yrq9NIMdLoZ/PE2i5uB+hoZaeBWdQWSUxdusRLV+ulq+aoo
 Zhtt/XYs43Z/oilIu6ws3PUvL58Yu+jw1ard09aNg8ja6wnB3LWp8vqQRKfmjFvkvELM6P7Jx/6
 7O7vMDF/ljlrkJQnEgDJ+Od45T7m
X-Google-Smtp-Source: AGHT+IFfTLJ/ChrBnfLx/VA16C3Uhv3fqXXNqOYH+jlcNcfCt30pfTLCpmu7C5+LJ3Zgdp5R820YYg==
X-Received: by 2002:a05:6a00:6c88:b0:71e:4930:162c with SMTP id
 d2e1a72fcca58-72abde65a6bmr5559407b3a.6.1734715374581; 
 Fri, 20 Dec 2024 09:22:54 -0800 (PST)
Received: from [100.64.0.1] (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dd180sm3462262b3a.109.2024.12.20.09.22.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 09:22:54 -0800 (PST)
Message-ID: <258795e9-4e97-4cd7-949f-24e88d24f25e@sifive.com>
Date: Sat, 21 Dec 2024 01:22:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1 v2] target/riscv: use tcg ops generation to emulate
 whole reg rvv loads/stores.
To: Paolo Savini <paolo.savini@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Jeremy Bennett <jeremy.bennett@embecosm.com>,
 Craig Blackmore <craig.blackmore@embecosm.com>
References: <20241220153834.16302-1-paolo.savini@embecosm.com>
 <20241220153834.16302-2-paolo.savini@embecosm.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20241220153834.16302-2-paolo.savini@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x441.google.com
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

> +        for (int i = 0; i < size; i += 16) {
> +            addr = get_address(s, rs1, i);
> +            if (is_load) {
> +                tcg_gen_qemu_ld_i128(t16, addr, s->mem_idx,
> +                        MO_LE | MO_128 | atomicity);
> +                tcg_gen_st_i128(t16, tcg_env, vreg_ofs(s, vd) + i);
According to the v spec, the vstart CSR contains the element index on
which the trap was taken.
The vstart CSR will get wrong index if the failed element is not the 
first one
of the element group(ld/st_i128) here.
I create a test case in the following repository for this vstart issue.
https://github.com/rnax/rvv_ldst_test

max

