Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1918D4A60A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgeek-0004oA-0V; Fri, 16 Jan 2026 02:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgeei-0004jp-6U
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:54:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgeeg-0003Fm-Hl
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768550039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BUSWysyHKHMebho0H6gzDOwUxh4mQM2YSn/WcDSdfUM=;
 b=D6hukh4Cz5aGC3ksJ96HN6BJJij/QIYIjoqZ9aZ/WOOupr/1NHa9aPMrROR3mT5JgUNBad
 lLf/OaMpO3D0S+XFILZ0bIj9vdtqA5JiEC+nojd5mNtGhm4b+qTL/Z8r3UCjwu7A+uZ4rd
 F9YTM3SaafhqPEEFucLFmsAPWPuoU74=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-qMzk3lm4NvmT-7HIu1G5rA-1; Fri, 16 Jan 2026 02:53:57 -0500
X-MC-Unique: qMzk3lm4NvmT-7HIu1G5rA-1
X-Mimecast-MFC-AGG-ID: qMzk3lm4NvmT-7HIu1G5rA_1768550036
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b7ff8a27466so169140066b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768550036; x=1769154836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BUSWysyHKHMebho0H6gzDOwUxh4mQM2YSn/WcDSdfUM=;
 b=VqB+Hrp8E3WNJOhK7/T9oeieM6m1ZYZZ4vcPYRP/QdtJjo6jOsExmj2UTooVaa4656
 GjW/fl3i9XORg9+QL/F66xC9aMI6VzOGAlLDF4f1Trf5CvnNmOMKa2zvYj+W1UdiUKCX
 02oRt+Y3oCV+4MuItxOqulPGrXyiwO80iV9mjbwKlCNDZ0KRLFqMxAiA++FlqK/xG0/X
 YLnYOf2cQ9tSI616NUSmDbg+dR6NKR/rtrNTYOcLa2m7W1jyFFivBc9w5zEn2Dq6dEXT
 ZzBET+XdDJ/bsdmAw4bHCVRSx3pZFCuXIfIlnkCbmGvswBZInyFVhBk8ehwn83A4fZKk
 LkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768550036; x=1769154836;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUSWysyHKHMebho0H6gzDOwUxh4mQM2YSn/WcDSdfUM=;
 b=uZIfWRkgIM+xF4T0yT+CAIv/tuPUK6sFWXuupPReWCZLlPrCIaMvd/hXNokmv82Exv
 UTcVTLXcMY0shF5KPBvVc1v6jrJ+zPaMo75E+UDL69N3YxdJlYgI4Q6SaFRZMdN2w6p+
 cyIzdIEufJXflL5LLqlBeUkdvGGVjGRLb/sm65wYdUk/df421xj3kk+FP9NCoJpT/GmR
 +euBdlGlQ2ybn9sfeoXzBNP6hwnTqHzJX4s4aasrHijz0B8zB5ZV5V8DfaRJHrPJ+/cU
 SmNQo8Iq9VmG3SEQTIbEGeQMp3y9GUYDHCQbRsZD1JvrEsSQ/dSO+8IlHwx32NWk+xhE
 /CwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLtm/m94VwqITGfiiQ5fTI27iCGF2WaryShiobixSiXfQPPqxnvsq5rLuTdRbqwQ96u3KdH9kBIJhX@nongnu.org
X-Gm-Message-State: AOJu0YxinHT71ASurNm9osb6l2yw3mE9vYqbtq9kQCR6PcG1ZpUGx5Hq
 gwh8+4givxyBAaGziY1WFDJBLVepHLPUMx+YmqcJ4USb3dVYqejLaBJLqF70EpX9CytDcXgDj/s
 3EIjGm4I1/dHpppi8i/gYwdoD78SS9fjLrqqNHGP5HpgEkI2Xd3D6lWo0
X-Gm-Gg: AY/fxX5BhxNMkpH5V21i08maSYEUSyU0Exoca0RFL2UqpPqzugSp4mGFEwv9WMr3HQi
 qi+qbQtbIBIEEbQgNUzR+HOgy2LAAgFGWmoqN88Ww4qc9DOxBqeuqQoj+cKpgZNld+Z5cigZJ+g
 aPkDOJNfDET+KH2XdJ7tzwkwiJuSpI8gE95lnDzdUgIb1Yz+zl7tRO9/H3R1zbO37cFe16nRW9j
 zoD8Ur15gQ8fEflYa9nfTsA6a990o8BwQItZzkkv+4+pm9xkLWtAHpodpUgayrWzbMLojWhfaWe
 9mqxOAFoSqFBAOblmKd5zC6LRK0O6zvblfLPKT3tgIj6fbpmqivR7CKIMxiuCF5Yhvn7tMbEtO6
 g/e8ei58=
X-Received: by 2002:a17:906:9f90:b0:b87:2b61:b03e with SMTP id
 a640c23a62f3a-b87968f57e0mr150692066b.14.1768550035745; 
 Thu, 15 Jan 2026 23:53:55 -0800 (PST)
X-Received: by 2002:a17:906:9f90:b0:b87:2b61:b03e with SMTP id
 a640c23a62f3a-b87968f57e0mr150688466b.14.1768550035258; 
 Thu, 15 Jan 2026 23:53:55 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fbd23sm159543366b.51.2026.01.15.23.53.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 23:53:54 -0800 (PST)
Message-ID: <8a659ac3-e113-49c1-b83b-fd86690e3dbd@redhat.com>
Date: Fri, 16 Jan 2026 08:53:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] gitlab: add jobs for thorough block tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>
References: <20260115164756.799402-1-berrange@redhat.com>
 <20260115164756.799402-15-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260115164756.799402-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/01/2026 17.47, Daniel P. Berrangé wrote:
> CI is only exercising the qcow2 'auto' tests currently. As a result we
> get no exposure of changes which cause regressions in other block format
> drivers.
> 
> This adds new CI jobs for each block format, that will run the target
> 'make check-block-$FORMAT'. The jobs are separate so that we have the
> ability to make each format gating or not, depending on their level
> of reliability.
> 
> There is currently an undiagnosed failure of job 185 with the qcow2 when
> run in CI that is marked to be skipped, reported at:
> 
>    https://gitlab.com/qemu-project/qemu/-/issues/3270
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 92 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 92 insertions(+)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index dfe954fe3c..91b398bd63 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -176,6 +176,98 @@ build-system-centos:
>         x86_64-softmmu rx-softmmu sh4-softmmu
>       MAKE_CHECK_ARGS: check-build

Reviewed-by: Thomas Huth <thuth@redhat.com>

One more though: I think we could then also remove the iotests from the 
"build-tcg-disabled" job since they should now be covered by this new job... 
WDYT?

  Thomas


