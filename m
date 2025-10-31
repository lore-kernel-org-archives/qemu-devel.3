Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AB4CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 13:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEpc4-0006fL-7d; Fri, 31 Oct 2025 09:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpc0-0006eY-B6
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:56:16 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpbq-0002hZ-Lv
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:56:15 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4270a3464bcso1629964f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761918961; x=1762523761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m1WNAVaODwgXCtm5Cmjim4oK7JCm0TKoAGLjUtVRlXk=;
 b=e0MmEL7jZpClUmgtFOCkt789BXnA5nlVHBRNLoP8mW0MgYHL0emytvP/UJZ+Pg2N+u
 w1dGnCa/ou54jmGDtLbNeJ1ZKhIKvFusylO7aNoJ++xE5l47prQq5sxWEHwVRPkumIZe
 z27zRVjIGtyQpncg98tv1WRFIYpSRYlpn6YTiJbCpDNw4xgMQqqOLm6FfGXrgoPO828N
 NhpFPAvjKW+oDOkoDcv4fVGygaN4keKho/SFon87PWbjdvaWBSFTFTH1WvfG8FENzzBS
 AbyRRNMuJhLykwdiQyEy0GolEBeDmAouxo7VcmrHMybQxgzc04PU/MGHEFGeWfwTgUsa
 cOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918961; x=1762523761;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m1WNAVaODwgXCtm5Cmjim4oK7JCm0TKoAGLjUtVRlXk=;
 b=KqBNer0ILaUbPkIYFsntNTm6gCeNQiUfEqgT8LphheHEQKnLzpb/a0zICuZz3p0NGP
 NeSmuJLoO4noupR/aHnOy2mhdQ+Tl9jGAemKtLXJkaYfAHDWH2BEleJ4xtZzZb0vnHzK
 55PU9w+Donf49VZ20/2o1tmpffUvLGkgzWjs0i6hWd3h0BmZYPNJA7XfAlpr+++QmjEP
 oEu3LCyMlT7QhsBuf/UjziOfT7WASPUM0GPqkQfElS2oIip6X/45o12TafDCUPMkNXA+
 CPBk7t2+vUwV/h28FvlZjW9MhrJgte5zxYPulk0c1V7u1tB0g0tGE0YUO03cCNDiFyVu
 b9UA==
X-Gm-Message-State: AOJu0YwSNUsxu9vkIQEmNuTOG73ko4zI0xS5b3B8orTbR47uaC8dCKT5
 sL2gs2pt//vKZN0XC/HgToSjWRogVxqNK/mwfc+Dn2MjdltvxEPAZ/C9UELkXtpyjpTJ9zf+z0d
 Kc8r4+e46yQ==
X-Gm-Gg: ASbGnctQI/IwPsnvphwIsj9w0Pd2gsD+6XqXXc2Wrqh4Wk/oApmT19begexBc8bwlnW
 mGt7Fgu/fCaN5SOeb694YLfWkGSX4P2T0r3dBOKmg7RKEi5/BJycPtwKJnXQKKso24HndBeMU7x
 mQWQI6dNsXDy3BSZ/UVNdq/29NhlC2lY3485PtM7MgTfZo2oOgRsYEGCcsiIE/QCNs0rM4s7mAA
 2WyoUSaapgwh/0kCYMGIssF5PYHooLv1J20GpRxDiURgrsD8eOumzXm0iUHxY1d6GC/X1kx3E28
 zJcyRBliZQfXono4m7c0ITQCFUwjPETd4k1L9ONeTQsIxHO2wVHx0UU38ekzGrI0b6qkyQpxXz4
 4uC+ODO6uBgqmZVhLANk19mE9hOtPO0UkiEXpOS71ZgA6C/swUsSMNwhEbhiikmPdTKeAjd3JUe
 TDWZmNXvlnTNKYP26hl5n9LCwLPSkc4s3SXhRvsMsT4uH5ACvPEQ3SmBU=
X-Google-Smtp-Source: AGHT+IGlSPBqcIJL8tL7nzE9MD+YtHKUEWCHwDF5YPRKfMQisUemu/1BYO2x5L4+lru5S53Ox0ceOQ==
X-Received: by 2002:a5d:5d89:0:b0:429:b4dd:ff64 with SMTP id
 ffacd0b85a97d-429bd6ac108mr3460764f8f.47.1761918961149; 
 Fri, 31 Oct 2025 06:56:01 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13edc36sm3781060f8f.37.2025.10.31.06.55.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 06:56:00 -0700 (PDT)
Message-ID: <78d871de-b64d-4073-a5a0-d9dcb2d9b31d@linaro.org>
Date: Fri, 31 Oct 2025 14:55:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io/channel: Have read/write functions take void * buffer
 argument
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20251031091351.27625-1-philmd@linaro.org>
 <aQS_ULZEGQSPrM63@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aQS_ULZEGQSPrM63@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 31/10/25 14:53, Daniel P. Berrangé wrote:
> On Fri, Oct 31, 2025 at 10:13:51AM +0100, Philippe Mathieu-Daudé wrote:
>> I/O channel read/write functions can operate on any area of
>> memory, regardless of the content their represent. Do not
>> restrict to array of char, use the void* type, which is also
>> the type of the underlying iovec::iov_base field.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/crypto/tlssession.h |  4 ++--
>>   include/io/channel.h        | 14 +++++++-------
>>   io/channel-tls.c            |  4 ++--
>>   io/channel.c                | 14 +++++++-------
>>   4 files changed, 18 insertions(+), 18 deletions(-)
> 
> Also needs a change to tests:
> 
> 
> diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
> index d0baf3b304..0d06a6892e 100644
> --- a/tests/unit/test-crypto-tlssession.c
> +++ b/tests/unit/test-crypto-tlssession.c
> @@ -36,7 +36,7 @@
>   #define KEYFILE WORKDIR "key-ctx.pem"
>   
>   static ssize_t
> -testWrite(const char *buf, size_t len, void *opaque, Error **errp)
> +testWrite(const void *buf, size_t len, void *opaque, Error **errp)
>   {
>       int *fd = opaque;
>       int ret;
> @@ -54,7 +54,7 @@ testWrite(const char *buf, size_t len, void *opaque, Error **errp)
>   }
>   
>   static ssize_t
> -testRead(char *buf, size_t len, void *opaque, Error **errp)
> +testRead(void *buf, size_t len, void *opaque, Error **errp)
>   {
>       int *fd = opaque;
>       int ret;
> 
> 
> which I've made locally when queuing this patch, so no need to resend.

Oops, sorry and thanks for fixing up!

