Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800ACC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 13:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU448-0005tP-7V; Tue, 24 Jun 2025 09:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU43y-0005qS-97
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 09:51:51 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU43v-0006wQ-Uc
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 09:51:50 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7fd581c2bf4so4110202a12.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750773105; x=1751377905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZPmW5gQNFbQB3YKfX159noc5HimH9q9vcQblZijP7kk=;
 b=FgVwhuL8N7f7JnMePgyEX+sPaPiz1jiw8jo2CXveUSAd9p2h4Hp55y4hXtPZR7VN0n
 SDVipcW6zwFsS3kTVm5/ezRc+CHi0Blj9dieZiGgXXRq4e8ThB3wSYh/p5CdtlpBvRCy
 6mzATImEHy6l+saVk9sXx6rtVUfF8tDskqWK2EuQGKi3TZSWslLkb1oO/jyyxt+nIZqB
 gGn1FSkJDPvzoemnoDxL9EF+crjlhr3nU7Q4zrxoCDmsfsGfNPP7C3axj2D32ChWulum
 1k47VNvNLMQENX9aCyWBQYYoQyf8u76mC7JA++lgzBZKYnoXkcwndPJUpFINEPWVKWP3
 GdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750773105; x=1751377905;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZPmW5gQNFbQB3YKfX159noc5HimH9q9vcQblZijP7kk=;
 b=u7XIKnqDM48dUPZcKOPcy9aRaPYKeuy26VqVSu0gy7nT3hK70j/1jmom05JOFn5Iop
 CuH5r/0xgHBvMjZ9+7CZbC+PW//kvwLjlK0PvsZJ48bpYQYB+p/0Y/CHV9q3dTMsRKRK
 DtW7Gksd8z43Z6xY7Z9JCSCIGBxq8ACBeqWkE2Z6eNpu48NODQq4GeCEvaUqlVI0/0B1
 RfsrMmWy1GM1ggf9tMojfpC+QcAt+zp0yjAHG1Chb8kCIIBnrMyOR030UtTgYGixcUY/
 sh9Ov9pyBXZ3SvL43r55LZvdwhIB9CE0QjNZ0la6F5V4KoYKmcFERa3nnoKLCtiwNhys
 eWSA==
X-Gm-Message-State: AOJu0Yz+rFgRoqHG8kF0rR+6YZumNvFsVl3m1e7VixLQ63HST1nZQexK
 6TKLO6KPAGvGBtGzQPPKeneNq+eAhUOkBUhjGOceBDJgEsgi/H5KxE3oLW+aO2LgKnMoHa98vxz
 UTEmaj68=
X-Gm-Gg: ASbGncvpbFhkwcjqZ6iddLVSks8M/D0lofwFw8fMd4/5eRo1J11X1EONzxFO1v0+7Lx
 nZKbgJyyWINdryRKrT9YXWxgxw0zNKB7OrPgiHisG/Uz/SbPzkAivqU2FjwxTAGkyomEvSnY2kG
 7fqubz/SC1L/+sFNgmP6gNeoh1KjYrJdE8DXADDRRL4z0NbFt/KJyQQ4Ee0IAvaYU8gXfKG00f4
 e8sDRzZ1A6EYH8Zk6XLEPa5fuHRku9Lj1x71jcdIeUSwWfMulm06Iuy9WbqlLS6QIqpqTQUwMpZ
 zZl4TPO7C2DO2WCTHaq+8BRtNWuaBATT36xrGcDiEJE2lFbtGJThY4/cvYLK4twHG9YFUuajOZH
 1GB7wJJmjAqVxBCl2EV6vQB+RlVKB
X-Google-Smtp-Source: AGHT+IHsIWzkPbn6jAvLsH31MLIxvMCW5T3R1nN7/q6KL0n/f0sYLAp7jyZx8Z9NUU2o5kyoduEFSA==
X-Received: by 2002:a05:6a00:3e16:b0:742:aecc:c472 with SMTP id
 d2e1a72fcca58-7490d75725cmr22541128b3a.2.1750773104702; 
 Tue, 24 Jun 2025 06:51:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e0aae3sm1918359b3a.22.2025.06.24.06.51.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 06:51:44 -0700 (PDT)
Message-ID: <3fa66062-21e5-4075-b366-67e74a85f96e@linaro.org>
Date: Tue, 24 Jun 2025 06:51:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 046/101] target/arm: Implement SME2 SMLALL, SMLSLL,
 UMLALL, UMLSLL
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-47-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250621235037.74091-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 6/21/25 16:49, Richard Henderson wrote:
> +USMLALL_nn_s    11000001 101 ....0 0 .. 000 ....0 1010 .    @azz_2x2_o1x4
> +USMLALL_nn_d    11000001 111 ....0 0 .. 000 ....0 1010 .    @azz_2x2_o1x4
> +USMLALL_nn_s    11000001 101 ...01 0 .. 000 ...00 1010 .    @azz_4x4_o1x4
> +USMLALL_nn_d    11000001 111 ...01 0 .. 000 ...00 1010 .    @azz_4x4_o1x4

                                                      ^^^^ 0010

r~

