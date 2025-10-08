Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBEBCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 04:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6LPF-0006Md-Sl; Wed, 08 Oct 2025 00:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6LPD-0006M3-IV
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 00:03:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6LPB-0005Wb-Od
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 00:03:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so72605845e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 21:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759896235; x=1760501035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pDxokV8dHp4k5TvHdeMKKP9EAWhnhvNQGRW6Dz2Bgi0=;
 b=fMzC4wwYyhA9y+9YjECxNszUVoG1fLjwKr31+NULxhzpbvpKa6SQLy8uBNrNb3FXhr
 5+O5udh5dogYnvq6cOlMr9OPkxLj27LepjFp4LSNenX7XSW0Y4NP0rnb+RP89gsz1r4H
 N48JqHU8+amWqr2bl99jt8ziUHeSPox2c/M+k3K3jhKuajq1N/umF6As0Wvn0UbOz87F
 t5kZoTFu0dXJBSKIA7hANPs3fJGMI7sK7zJ/UO7/4XWmMf+9cv8nNBhOOucDfgfMaWBi
 qdunFQCwPK0iO7rEUldsHGbfOHHNQKEkBBKtoH7JbxFOYiz8KG5wwm57lpyysjUveTi+
 4M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759896235; x=1760501035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pDxokV8dHp4k5TvHdeMKKP9EAWhnhvNQGRW6Dz2Bgi0=;
 b=HIG+5qs6+ODBmNkxsb6JX02+SIeBMbsYDh8mkdZ+7KkWWSzO5u1DP+6fIJL2anVoz4
 k2fP0jmdMQ7F0gxQ9XVfW2SYnbr9HZrJcYNew3FyoUsHEUlnSrFmcHNHDWYT9qjXnOjN
 86ARASkW8rLyPO6cqPhTW7CijbyaVnyiDzpa72vrAyRvSfkXoMLtKxK5xk2g6Qc8MO1M
 rC3UI3R88X+rgccxGb/VS/nvxmQHrhwzc/G6bvVqWDm7jCkSYBRShz9kuiSA7xH3JLI1
 E6ZiAKizEvZ0fXZe6CLO3JGTENelrW/NqRWBO7no1qINpgY/MRDIO1WmQmStXDV+Kc9I
 JyUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2BQlHejUQW/edopoJFwKIZ2w27z8Ac5OzjpQRuYmqv21c105mMdnIPUHE/wxLa31Vl6fu0oxnKWuR@nongnu.org
X-Gm-Message-State: AOJu0YzATsTJUZxn0Q594wMA4RvKO/naBwaAXIxu6Qsh6g4FwK1YLrmx
 F0CTwtKlNv9QH21MFD7tfYZWPv2Yod1deouOFnlkk3dLrADgdpcOqdhbKvfTBQMm54U=
X-Gm-Gg: ASbGncskmafyphr/Q6lHeIaYEKJsiD5nP4AZiupgkVx1s5Jf6LCVF/eDRgl7KK5YD9C
 h8wEYI2uPR9WSo+0889FIozGAWqPsJgGAdBxUMmWJeJt6UtDxMuT7mWBOudkm1tmWBL4ObM3s3+
 BgHRGchOsaDYPEdiG1j63gl7AqULpUE+X3yWSPcrdcVpqENcqoPjdJ2E84zaXzOfrVlrmXOLNZd
 TiY7P1boCqY/QClG4oSQwYtLLBEbx/rNOMWuBrI0B+LoERZveEF/K6b/SIhBWUDilx1jA+DTziY
 WrK6OCApc7cno6tUtNuhT7RXYuEQULmWDIfI6/KSHrSWPB72X0wRiA/0J4dUf/PEVTKJCiJW+ZO
 ki4JJUuSPXPtqUM5Gj/7E1BHuNbj7Mm/Qkm2cxAErm1cbeNpihz20KJugJcTbk+LUlhRP8MQyAR
 xSDA1kO3Squ2lzbXhGJg==
X-Google-Smtp-Source: AGHT+IFLpFYJZ7f91YsjDOeznZPw9lkkoySKt0IpXaGIH3+gXMaFPfCUNJZq4J0uszMlbZkeYgioMA==
X-Received: by 2002:a05:600c:8b42:b0:45d:e6b6:55fe with SMTP id
 5b1f17b1804b1-46fa9b16607mr10581765e9.34.1759896235631; 
 Tue, 07 Oct 2025 21:03:55 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97fbsm27753043f8f.34.2025.10.07.21.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 21:03:54 -0700 (PDT)
Message-ID: <f09b71ea-7402-4e41-8071-5ff45555c128@linaro.org>
Date: Wed, 8 Oct 2025 06:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: fix path to rust_root_crate.sh
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20251007194427.118871-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251007194427.118871-1-stefanha@redhat.com>
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

On 7/10/25 21:44, Stefan Hajnoczi wrote:
> Generated Rust root crate source files contain the wrong path to the
> rust_root_crate.sh script.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   scripts/rust/rust_root_crate.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


