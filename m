Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0880E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 10:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLgfu-0000L7-J4; Thu, 12 Dec 2024 05:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLgfq-0000Je-Au
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:44:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLgfo-0003sz-Iy
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734000237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O9zm8cwCHIU5/gbEr0qIf7Zkb7/99oYR7rvGGsLCyV8=;
 b=Ju5i0jk1hdSuBfLedPJ7OEARB3BYLJ+dt9ebXBmDgMXGXGplDs6xSyb4PEHnxDKfcc8gYv
 yZHD313C5rSn9FP40HN2EwXN/dYlHLb6hixIiqV0KjXKatxUxGC+SzA34otKoX+J+cpKs1
 g4KdctoWhAeVnB6XCuDtcADFN4QrE0Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-ZXLGWVAUM4enbD4VSxdxFQ-1; Thu, 12 Dec 2024 05:43:55 -0500
X-MC-Unique: ZXLGWVAUM4enbD4VSxdxFQ-1
X-Mimecast-MFC-AGG-ID: ZXLGWVAUM4enbD4VSxdxFQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385ed79291eso904028f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 02:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734000234; x=1734605034;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9zm8cwCHIU5/gbEr0qIf7Zkb7/99oYR7rvGGsLCyV8=;
 b=SFx8IpeSecqK72YzFDTrjEOAUujwn4E06YFTgbOSoy8Zc7U+jVBqB+LCLUNEsuQBQA
 mc8jJE1g6sm+98z0783az1xCJ8YcT+6nrcSSxpNxmBA35bBE7vUS8jk9n9YVgGCAotq5
 3aliLjELj37Ry3HVOpXFFlS0YyEZuDV7lceTc235kwE7sj9Popc+zSo9yJRd+RBejHDu
 OHBQVltx/GXqXlX63t3+VmM5y3IEEceIFCI9zzoCHCqYwrKjloBhP4YsFxo39T7yi4aJ
 RslUqV9IAX2cHiFC5r3ZqBSrMNgyyOMYMYYNVHAy9B6Dcz9X1Jv4hQeyrvXKyovZG3RR
 RPzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/xJnuBsZVX18J0Q3gChJCjFqXY4lAMTd8pcr6yG75P/mwmkLlbWe5K4/aJG4aaRrT0aGFkp78jIVl@nongnu.org
X-Gm-Message-State: AOJu0YyX/Iw26ObISKnNd97zoV1QrqIPHRNOjKPC8IwO3CpuA0h9snQ3
 ITr49Lh2sK0ahdcOmtkDPp9doX4TtvcjhWb2vUnhLBBhIARB/aPaBS0lgEd2tb2NUV6ns70Q3Eq
 nvaD7pS5ByFuJ9McJFPidOtKr0S7tFCtvggo0NG36E7G4SCRu2Up+
X-Gm-Gg: ASbGncuCty2CLN4GVnIbKH1CXk2TiGC+on860tYwvi0TrhL6TYWivSBmsxUFaDBuajx
 zsN4Qo3VOmRDgXm0UBUP0CW3wS6tkiFOERCbJ/piS8/3UjWzn6b8FJYMrcCetjXOo8zMBTUM//g
 V2CBrNSEWtKPVJGwzUdhfagL/4G36W1oMtVghtkEXtsRlmKOWPDZ63pVGQnvHNV8xrgX2CsEJNl
 WgKOb8D3vwC7H78eTEwzjCVT4RbTX90pj00qQXsNhQZHDAkVE3KQfYv3p5L1NKfGRSm7pZD2Jx7
 MoRDGg==
X-Received: by 2002:a05:6000:682:b0:386:374b:e8bc with SMTP id
 ffacd0b85a97d-387888051d8mr2061445f8f.15.1734000234662; 
 Thu, 12 Dec 2024 02:43:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhdBiHY9UGetOmNeQVLqrAOsxBI8fH/NTuLmit92hDvR+gEuyqkQ2Lf2SumxL0HRbaMzzPIw==
X-Received: by 2002:a05:6000:682:b0:386:374b:e8bc with SMTP id
 ffacd0b85a97d-387888051d8mr2061431f8f.15.1734000234352; 
 Thu, 12 Dec 2024 02:43:54 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625579464sm12668695e9.10.2024.12.12.02.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 02:43:53 -0800 (PST)
Message-ID: <1cf475e4-87f4-48cf-bda2-dde93174cf20@redhat.com>
Date: Thu, 12 Dec 2024 11:43:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/31] tests/functional: add 'uncompress' to
 QemuBaseTest
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-26-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241211172648.2893097-26-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> This helper wrappers utils.uncompress, forcing the use of the scratch
> directory, to ensure any uncompressed files are cleaned at test
> termination.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 19fb1d0c07..684c94d45f 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -29,6 +29,7 @@
>   from .asset import Asset
>   from .cmd import run_cmd
>   from .config import BUILD_DIR
> +from .uncompress import uncompress
>   
>   
>   class QemuBaseTest(unittest.TestCase):
> @@ -40,6 +41,30 @@ class QemuBaseTest(unittest.TestCase):
>       log = None
>       logdir = None
>   
> +    '''
> +    @params compressed: filename, Asset, or file-like object to uncompress
> +    @params format: optional compression format (gzip, lzma)
> +
> +    Uncompresses @compressed into the scratch directory.
> +
> +    If @format is None, heuristics will be applied to guess the format
> +    from the filename or Asset URL. @format must be non-None if @uncompressed
> +    is a file-like object.
> +
> +    Returns the fully qualified path to the uncompessed file

s/uncompessed/uncompressed/

With the typo fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


