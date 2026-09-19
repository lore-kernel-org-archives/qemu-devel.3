Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4DFC982CC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 20:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x81sM-0003M8-Uk; Sat, 19 Sep 2026 16:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x81sG-0003LF-Ks
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 16:41:29 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x81sF-0001dj-3R
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 16:41:28 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50db3so1031088a12.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 13:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789850485; x=1790455285; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fAZsEpTHiGYJL5KYPpHtWXBBE86l9Q2N2rzvxUsW6sw=;
 b=zkP1Qo95wqz48p8L44ye/vA2ceWlduznNkSf1dKLVD6llZqlaK618PJe54+XrF3eW+
 yxqx6TfYh7o+1E8bm2/oC3xRac4mT8S5iDALcAsej5Af+lCH/j54/JkAKoUT9twYAcul
 EjDBXwTf8JUN3lraWBAnv//hrueuGk0yzMBxvBU0y4oKytt/fbonzDJ5QL7q+RNOhaA2
 w6qW//ys+1jXjqw4Tu3ZMEyjY6eigwQlRr41Wkqd2Y3N6v4L8FjxG5/HIRvkgiWGWOVH
 LUE2c48jzQ7uimVOyplh4vY3KhrX1Lyyc/vE8FO2L9nnjne8WatWyjo9hG3eKwL61nNC
 cCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789850485; x=1790455285;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fAZsEpTHiGYJL5KYPpHtWXBBE86l9Q2N2rzvxUsW6sw=;
 b=CnE4I/rCq1wvBizCY+7TNUuXFlCPJBm4+Gq+Mbf8W+bZ8umxdHq8hQuZaJ1ItmV1ye
 Pqno9BsWwhF1XHZJty6rzCgZcHVBoSBcDEQJy0jDhi4MOfouGSk13iXlOCvRr63izXEo
 ofMSE52vw4sms+FmakCucCPBXmya2jKRqQjrEWxbALBGBt5LSEtFr2Dnz4FjSZ4hmm+1
 wc+5zJuLvAK8kPeiyYirXNQi5R4ckNa6SMMqo9/QntHcIb4UqiQjNhi337svQOiQEmPQ
 jWS+TiEhOXNsAHacxcOoP7H9ZwIIZ0+sfxa/YqMkJ+kfqJMfZUPqXaMiJCfC8WBu5jOr
 9R8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwb5aZycHOaF++vBpkMYbF5yhJ/N+hZMHHRE1dsY5GCVUW6spZnD7YZeqEnhnSlEosP8Yq6J2wPN3tP@nongnu.org
X-Gm-Message-State: AFuF++k5NzLMotXy5gXN/HEXRQzxcWZmv9Jg3eg7iMTtj425mx4uz6i1
 P3GzVtYPUvWdACcJIWMKQpmQcf8ymLIK0pVj/bjyZBL0K/B5T9RSheeyM+0mcWvOmQs=
X-Gm-Gg: AYBFou3No9vdMPJE1fw4mj5jofldUrEWT59+051M9lQmmd4pXCnVpH/LLWlqt6LP92m
 hOV9BqcR9NnNGtx+TgFHzQZ57FFPCdeaWoP5QMpcFD8hpmNuhgltpl1ekGB7hLN/WyyddF8q0ay
 4GPdIK3uSfbbM0s1P02sJjVZjPMYBAjYxDLP03fOputD/rEjniHyK3yAEU+vs//xyB/34Il1Wxy
 X9ZuKjVxuIjIGX/PbM8Y6gI0SRY/pSVWoV681uB8QFxWrb5wKe189xG1JBJub5SmIEfPnDUPfTU
 CnN2VhJGT8u7mvs8BbSlzOzU+Qw5kN0GysI5ypTxoBMfwPo+b/OVBcnT0tYoUiMktTBC5Td2yw+
 CgfAb5CLy8QRvRQ25emskxyOVzCYP1i08Wgz1/tRnKLuWhfjoOa6uqcuOIBnrOb1xjbzwnRJKmJ
 p2zJeKAimhlsm/nPmKxCHImvXTkfoHIS5mhTDTh1YruGnyCSVH0V9Rh6GLR3jzUftOwRvGlvsFu
 4tqdHLbpyWGiqXM/elzg97RwLfQb94XrG8XoOXXCTaycJp+3xcY4NPZpKiM2w==
X-Received: by 2002:a05:6a21:a344:b0:3dd:85a9:559c with SMTP id
 adf61e73a8af0-3dd8c577aaamr12326656637.30.1789850485345; 
 Sat, 19 Sep 2026 13:41:25 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:126b:fa43:b140:ff23?
 ([2603:800c:7900:ed00:126b:fa43:b140:ff23])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e3f17288dsm1830546eec.29.2026.09.19.13.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2026 13:41:24 -0700 (PDT)
Message-ID: <0f0d3936-d594-44fd-b82d-37c779fdf1a0@linaro.org>
Date: Sat, 19 Sep 2026 10:41:21 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] Linux user patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Helge Deller <deller@gmx.de>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20260918202947.5322-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260918202947.5322-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/18/26 10:29, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit e8dca265c91b45f4cde746e5094d7b763444eb6a:
> 
>    Merge tag 'pull-11.1-more-check-tcg-docker-meson-180926-1' ofhttps://gitlab.com/stsquad/qemu into staging (2026-09-18 07:52:24 -1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request
> 
> for you to fetch changes up to e95f53e30be7935d98e38eb09cd6360fe2886249:
> 
>    linux-user/loongarch64: Detect vector stores in host_signal_write() (2026-09-18 22:20:21 +0200)
> 
> ----------------------------------------------------------------
> linux-user patches for mlock syscall and loongarch64 and riscv fixes
> 
> Add support for the mlock syscall, and some fixes for loongarch64 and riscv.

Applied, thanks.

r~

