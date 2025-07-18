Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8661CC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 09:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uchX3-0002y3-Nu; Fri, 18 Jul 2025 05:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uchWp-0002st-Sd
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uchWn-0003PF-LA
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752831431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6ETIWMtBY6Wdw5LtXNsIeTyyk3CS2q6KK7HJzk9hnik=;
 b=Hk8JkxonV7Z6oSBN2cgGwC2WfdcSa1CqQNX8KqFn2GbtnRJkcbfi9LXjNhcctgl3sXNFlw
 5SwH1USwEBSryxYettx8JdYRIP2UTkwJO+yvT8lD0wmoPRJ9h1dE1IbZDmmc71NkmHp+cc
 EcSmLrLr1lIInHIAPeVjrxvaat++faU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-qypQBISbOACP39y5FhG1Ng-1; Fri, 18 Jul 2025 05:37:09 -0400
X-MC-Unique: qypQBISbOACP39y5FhG1Ng-1
X-Mimecast-MFC-AGG-ID: qypQBISbOACP39y5FhG1Ng_1752831429
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ae3b2630529so191940766b.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 02:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752831428; x=1753436228;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ETIWMtBY6Wdw5LtXNsIeTyyk3CS2q6KK7HJzk9hnik=;
 b=iukcv/Sz2nlMRXaW7UZt9oUMK4igLRHX9rpjonJcq8E4iq9EXWKmzAv8t+hV+9fWeV
 EPkPqFMm0pvUu0c0qjSsoZ39hM6w+ruOEgWbV0CL05JDDaJwoMOWt4acWLJEZXnoQVYK
 NwFYs/QgwP/Hh7k/Bby5Cm+pBepSjO9EhzopkW7hlCSdaURNwAH4u8Tas3+eJN69DlDd
 ivit2SZLK6ms/6rIyElesKmebBd2T+Je8Ob+hXiAeJ0mhCYY/TObv86CictlXJORXNt6
 99HOWvksPsZrYpAQM6g1/jmr7J5zqktcxtz3Q/jXnuO3Cl2n9/c58ee6U40cwvbhfQll
 MLwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2GUNjSyGEO2ds4FGwzSwsOf2SmhuKVRTxVxy+krAViHtqNudDcg7p27REOS2spLfNIFobPC/FCqxo@nongnu.org
X-Gm-Message-State: AOJu0YyueWr/vbWnVDoP/HLxuq8mg4taiBLLmlLdYz7V3YrlW4TxDGpy
 9XqP+C2iH+DFBgvqjhcqF0S2tEDbZB7N5H9lQJ3Kd+8jNambExuAkRcmlocwFiCcCd00vv2NkFd
 l7936SrShdhEKlHq/Cl1NksbUZqgjgtKuIAknSxwfMWzFsFmfPMJ1E9Ws
X-Gm-Gg: ASbGncstRqGVY+i0UCUDTkerOhUc2v9wHNlvhonHwVYYIGiIrYZElHNzEPG9XWwY42o
 ppdm7pVEh/QWT40ZtShjd9D08oKLYaSRfPORN0/scSmCgIN3g7ej6bMMVx+GMzrETw4zC3vKkqE
 1IxPjMjT+XnU8QLMM8kr5eP+7cwy189SvCSByNsVPq4IsI2HWlQDgatLziV187qwoAmbPRR8PDP
 /VTtATjqFYulcarXZOsXrnvnMRYBiqiJSfhq6yoCCd/Ckugcyq0xmivvQgGyGzmPYyxT9om0nAj
 xHcZm8cE1xcbrTOUXPo6PegcaoEwp2tUBuI7eE87MZ4=
X-Received: by 2002:a17:907:1c91:b0:ae0:9fdf:25e8 with SMTP id
 a640c23a62f3a-ae9ce149d12mr974415266b.47.1752831428430; 
 Fri, 18 Jul 2025 02:37:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgsOcEZdFA8rezI5nA+Uxy0bfCn3ibjrlKp9Vm3wW8T9oyiV5OWu6RY8hxz6Hwvi1xIQG2aA==
X-Received: by 2002:a17:907:1c91:b0:ae0:9fdf:25e8 with SMTP id
 a640c23a62f3a-ae9ce149d12mr974412266b.47.1752831427901; 
 Fri, 18 Jul 2025 02:37:07 -0700 (PDT)
Received: from [10.131.45.123] ([151.49.73.155])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-aec6c79c279sm89416366b.28.2025.07.18.02.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 02:37:07 -0700 (PDT)
Message-ID: <1c805fa1-09c2-417a-9529-6ee9122d37dd@redhat.com>
Date: Fri, 18 Jul 2025 11:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/functional: add -k TEST_NAME_PATTERN CLI arg
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250718-functional_tests_args-v1-0-54d4c6207690@linaro.org>
 <20250718-functional_tests_args-v1-3-54d4c6207690@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250718-functional_tests_args-v1-3-54d4c6207690@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/18/25 11:12, Manos Pitsidianakis wrote:
> Add a CLI argument that takes fnmatch(3)-style patterns as value and can
> be specified many times. Only tests that match the pattern will be
> executed. This argument is passed to unittest.main which takes the same
> argument.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   tests/functional/qemu_test/testcase.py | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 4455fcc38016c14db04019bbd64eaae9b47363c1..b7a660fd729afe39ff8cf7a0be97c2fc2f2f573f 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -55,6 +55,14 @@ def parse_args(test_name: str) -> argparse.Namespace:
>           action="store_true",
>           help="List all tests that would be executed and exit.",
>       )
> +    parser.add_argument(
> +        "-k",
> +        dest="test_name_patterns",
> +        action="append",
> +        type=str,
> +        help="Only run tests which match the given substring. "
> +        "This argument is passed to unittest.main verbatim.",
> +    )
>       return parser.parse_args()
>   
>   
> @@ -301,8 +309,12 @@ def main():
>   
>           tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
>                                      test_output_log = pycotap.LogMode.LogToError)
> +        argv = ["__dummy__", path] + (
> +            (["-k"] + args.test_name_patterns)
> +            if args.test_name_patterns else []
> +        )

This does not work for >1 occurrences of -k. Maybe something like:

argv = list(itertools.chain(
     ["__dummy__", "path"],
     *[["-k", x] for x in args.test_name_patterns]))

Paolo

>           res = unittest.main(module = None, testRunner = tr, exit = False,
> -                            argv=["__dummy__", path])
> +                            argv=argv)
>           for (test, message) in res.result.errors + res.result.failures:
>   
>               if hasattr(test, "log_filename"):
> 


