Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DB6E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 06:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVPlf-000805-Nf; Wed, 08 Jan 2025 01:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVPlX-0007zK-Mm
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:42:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVPlU-0005nc-UQ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736318523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XhxNRVTCKtc9/WFiD1+tRaBv/KR4USKjJ+CA7V9EstM=;
 b=QvQlfBE69hrDxCynd+Zqsfw/3U5wfAbJF5p8TkNAe348htSYW7X/0sYyQV07SGfxdb1pKZ
 Z0fQynEr/onYnOtlQM2z054/4uiTh541vlMvH9drHBbL85J+HdumHiNgO2m4gNjAqJu0Yo
 2zqLWtx0TBNtHx4C8UoplSCoNzXlDyA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-OuVcqkAcPMG8wlv6D2Yz_w-1; Wed, 08 Jan 2025 01:42:01 -0500
X-MC-Unique: OuVcqkAcPMG8wlv6D2Yz_w-1
X-Mimecast-MFC-AGG-ID: OuVcqkAcPMG8wlv6D2Yz_w
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa69e84128aso1175839266b.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 22:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736318520; x=1736923320;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XhxNRVTCKtc9/WFiD1+tRaBv/KR4USKjJ+CA7V9EstM=;
 b=pSWLWviNJ4sepra98s3APYHkAflMTLT1FNbDJHxK49MUDAJ4W0+E4TmkJNW+SKFZo7
 Q9M3072WSECx30rH2lGZ7sLpT3c6ZwBh/vZAPvjVv8CBobwsJ4Yf+B7na671HisrjAmU
 glZWPX1+UQqY7LTyp7SQG8mzlr0qRArzou72ooeTqIwfmx/1IlessRGiea6nPs+zJjT+
 dbV+Z7+lIPsKocm04rH62ATktoyF4im3b57Yv6wcYC1M6QmavE7XY+2tO9lceJjT4jdp
 pPIhKwdHWwUpakVNYxmfB7FnMrm26TCphH8o+mc3+GdigBeggXyzCPvQyd4BqmpCYsVv
 cpmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRaL3fPuQQccHKbNBeHL/Y2+U1nu6t+mvAXcUCV5LS2XHvhlFw020epnlT5ZdXyV2z3TprjNt4KzUp@nongnu.org
X-Gm-Message-State: AOJu0YzkyxMP68DS16hULwAn8kENnPUZ2lp+PtiuFDiKdAR7c2uQ1t32
 pqdQoJzzJj4BrxBjdDi0KI7SkFro8bsw7SWxn6gvXPX1zP1Ka9/tpWY51bqQMJG+FphS6rS9sTu
 ID2N85+5WGwH3DPsmIdxhItjndRZc6bfnRuQJJ+zQgVaOok68q/GT
X-Gm-Gg: ASbGncvi1GTn8HI9lyWiCtSLZrY5V5mCGuBd8VBJtd6CtUajJYBAGcRQvnts40u5BYC
 DdY177SEV/dIZe3QuUK9/ra0xeFB7ARijYz66KeJxG+dJwn+fNsIX4h44KX8xIdtXkAKPwv2mxF
 cwakkVm5bEE/GuBYxUopwvYgFNYP9VgKYOPkazYDwuAdGbbgqOB5xGdQ+GB470A8MwW+3qmU/Z2
 J+0uRjB4iWW3Nfj60F0Hm5ATel5X+rxfa2Ifrb0GvG+j7nQDMcukQ9fbdvOsR0qcK5fciI0fQHp
 u0+BIdD0EiYA
X-Received: by 2002:a17:907:3f89:b0:aac:501:5629 with SMTP id
 a640c23a62f3a-ab2abc95256mr130841166b.56.1736318520421; 
 Tue, 07 Jan 2025 22:42:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnuSk+iJhdaIsF2FaV8kvM9PEEQHx3bWKaA+PtNOmmUIBheVERBkX2RMXiEA10mfUs3nEFAw==
X-Received: by 2002:a17:907:3f89:b0:aac:501:5629 with SMTP id
 a640c23a62f3a-ab2abc95256mr130836366b.56.1736318519970; 
 Tue, 07 Jan 2025 22:41:59 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-182.web.vodafone.de.
 [109.42.49.182]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f06da76sm2458615966b.194.2025.01.07.22.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 22:41:59 -0800 (PST)
Message-ID: <b7618b1d-a48d-459d-9768-40830c866560@redhat.com>
Date: Wed, 8 Jan 2025 07:41:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/29] tests/functional: add zstd support to uncompress
 utility
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Beraldo Leal <bleal@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-riscv@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Weiwei Li <liwei1518@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-arm@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Eric Farman <farman@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250107165208.743958-1-alex.bennee@linaro.org>
 <20250107165208.743958-20-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250107165208.743958-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 07/01/2025 17.51, Alex Bennée wrote:
> Rather than using the python library (which has a different API
> anyway) lets just call the binary. zstdtools is already in out
> qemu.yml so all test containers should have it around. Tests should
> still use @skipIfMissingCommands('zstd') to gracefully handle when
> only minimal dependencies have been installed.

Thanks, sounds like a good idea to have a common function for this. Just a 
comment below...

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/qemu_test/uncompress.py | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/uncompress.py b/tests/functional/qemu_test/uncompress.py
> index 6d02ded066..404eee1f83 100644
> --- a/tests/functional/qemu_test/uncompress.py
> +++ b/tests/functional/qemu_test/uncompress.py
> @@ -12,6 +12,7 @@
>   import os
>   import shutil
>   from urllib.parse import urlparse
> +from subprocess import check_call, CalledProcessError
>   
>   from .asset import Asset
>   
> @@ -38,6 +39,18 @@ def lzma_uncompress(xz_path, output_path):
>               os.remove(output_path)
>               raise
>   
> +def zstd_uncompress(zstd_path, output_path):
> +    if os.path.exists(output_path):
> +        return
> +
> +    try:
> +        check_call(['zstd', "-f", "-d", zstd_path,
> +                    "-o", output_path])
> +    except CalledProcessError as e:
> +        os.remove(output_path)
> +        raise Exception(
> +            f"Unable to decompress zstd file {zstd_path} with {e}") from e

In tests/functional/qemu_test/tuxruntest.py we had to add a

   os.chmod(..., stat.S_IRUSR | stat.S_IWUSR)

to make sure that the write-protected compressed assets are usable 
afterwards... Would it make sense to add this here, too, so that the callers 
don't have to do it on their own?

Also, could you maybe change tests/functional/qemu_test/tuxruntest.py 
accordingly to use this new function here?

  Thanks,
   Thomas


>   '''
>   @params compressed: filename, Asset, or file-like object to uncompress
>   @params uncompressed: filename to uncompress into
> @@ -59,6 +72,8 @@ def uncompress(compressed, uncompressed, format=None):
>           lzma_uncompress(str(compressed), uncompressed)
>       elif format == "gz":
>           gzip_uncompress(str(compressed), uncompressed)
> +    elif format == "zstd":
> +        zstd_uncompress(str(compressed), uncompressed)
>       else:
>           raise Exception(f"Unknown compression format {format}")
>   
> @@ -79,5 +94,7 @@ def guess_uncompress_format(compressed):
>           return "xz"
>       elif ext == ".gz":
>           return "gz"
> +    elif ext == ".zstd":
> +        return "zstd"
>       else:
>           raise Exception(f"Unknown compression format for {compressed}")


