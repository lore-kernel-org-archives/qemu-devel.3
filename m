Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFFCCA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFAyc-0006iy-Ql; Fri, 09 Oct 2026 09:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFAyX-0006ib-S4
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 09:49:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFAyW-0005zv-6h
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 09:49:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so35609635e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 06:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791553765; x=1792158565; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zDw4a1OhACcIY5arZQeRAvTDSvNMCEH+foflxe0rcJY=;
 b=noGLHxSS4+WBtUpLIIvnlqMc1qThPsAGPuTq+4/DrQlWNC405qYitIRwUOHkdFozx0
 6bbIGE9G6Ez+KDxbG1y09WZMAmknLbvuPLdoCAPxkb2ea12/BoBanYKh1gNUoZrAWHdy
 PPUpfIUvWr9pUtACrcJ9jo6/34Ku563HiwAvu1Oqmz8zYJJBY4f2qYQyiawqZoXmpkSw
 J7od/WloROaaB4ip9j0C2qgyXFf6WJR//1DD7ahklSvCU8GxqeNe3T3iDfSi6p2pD7h/
 TF+fqQw274ogYAHw951OqjYIEF4aOleNF9d8/4T/7bUEwa4Og2ZhHPw+nQEW2NVXzkCr
 CujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791553765; x=1792158565;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zDw4a1OhACcIY5arZQeRAvTDSvNMCEH+foflxe0rcJY=;
 b=xwXboiLpdqsW0UTb7JuAY49oGsTYfaPTIB3ppK5fBjTrm9SjyhO298ajF/PalzVheC
 N5tBfHOd/of2Y/E+lorsyMQipBoH62liOnrIoYp08DMgA/423ck7hu1q3iepOfqc9DPE
 vRQB/QIh75HAhWwpli7rtMVUQxFLsMjZ1F0BPiEqBGOKyfTOuR+bWlJmA3vnuyAzbZbP
 kZSW8T5I8BR1ok/0nFJkeIfnidVA4DX/XTj9nVcj9iQeqeycTIRiMcm3CMwJ8baKARdJ
 IgSsPe8VKSsvwSZPqLZadRjIxeI7ouaIWSsWQGKfY/tXW9VOLnB839IPyZqc5TeWH7AF
 YHMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCoASNPIkg/FgM+zIs6qUU3chmzg0nliXpcJpUqiiJgr+RIVbPVwM3m0kWh9coWpBpM3Z4fE5ss4o7@nongnu.org
X-Gm-Message-State: AFuF++mCd0r4ONqrhGgB9VVyKpDadcc+57kN8RiaeNsJQVYyaiVwQ+vK
 zRXeKgPccUVcZxeHTVFLq2gepPI2XsVLfzz1n2ECHT/0OsVuQJiOSm650Yw9P3xs9E4=
X-Gm-Gg: AYBFou2OPn3I5HzmctS+WNTAKuJGwm+OmCAH7y9rFsjngnQQZpO/KFlBbXVyQomwRsL
 DYmSSJ8LTDv8ZEEQPcvy66Hw+4qxMZ5HqASDt1Lso/OzFRO0v4pkmeWFiBaipLPTmzrqbqEWA2p
 YeMbKdlYS2xooWsWBI989ELKYM0DkSnu4h3JsWWpYxpoP4iYuHLyntdBICH/Op5msnP8WOTXRNV
 1zn1OKrHm2G1jUEmDIViTGliMjkUvfMDt8rKS66dgCiqG3VNVyjjApQhpbWpe7DwQyj9hJlXxnV
 /yyPWPnnQVIZ5hV4qX6ydlMg3FcZ8i0Ank0sInG1poLD89yVHpq8S+NaBg3mC3Nvd2YFGPA3f4l
 D5ely9uLnxwBJQ82VCikC/YI5jhDqxS8b/gdORkog3RC7tk6m4OGH5W7/nAFJxnqbX/QFvcZNGt
 puF2kojgtEYJc6OV2xMowpJ6Oi7+Mq7w8x7l6Yz4xvhoGh5hcsa1X6Ks1HOOIRDdnoKqy9/OriQ
 KNWoRJqiKsZjNRHW/JugsG8HdEcjrlt906w2SBvn8huiMYDt9xdK9yIl9+yNUp1JbIvMmMi5PTg
 hg==
X-Received: by 2002:a05:600c:3488:b0:49f:e941:d6e with SMTP id
 5b1f17b1804b1-4a18e4c05d9mr38903215e9.21.1791553764971; 
 Fri, 09 Oct 2026 06:49:24 -0700 (PDT)
Received: from [10.86.151.227]
 (ipservice-092-208-245-012.092.208.pools.vodafone-ip.de. [92.208.245.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c85009csm44672085e9.2.2026.10.09.06.49.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 06:49:23 -0700 (PDT)
Message-ID: <9fc1f626-3b86-4fa3-9738-f64b6e06b572@linaro.org>
Date: Fri, 9 Oct 2026 15:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v1 00/10] Merge tpm 2026/10/08 v1
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20261008212723.3679685-1-stefanb@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261008212723.3679685-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 10/8/26 23:27, Stefan Berger wrote:
> The following changes since commit f9587d4045c67cd0d8d8bdcd5d0bb5b6b395b63c:
> 
>    Merge tag 'pbouvier/pr/plugins-20261005' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-10-06 11:26:40 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2026-10-08-1
> 
> for you to fetch changes up to 0c2f2309cddf6dcb5a340e7838e2b37e3fc22bf8:
> 
>    tests: Add tests with commands with bad length (2026-10-08 17:18:31 -0400)
> 
> ----------------------------------------------------------------
> 
> This PR fixes a couple of issues in TPM-related code.

Applied, thanks.

r~

