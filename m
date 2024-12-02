Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10AED10DCF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 09:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI2b1-0000BJ-9L; Mon, 02 Dec 2024 04:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI2az-0000B3-O8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:19:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI2ax-00006C-9E
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733131193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+affJrMHMT1VUrYSH4K6ny2yWHIycRqrMVg8+CbaE/U=;
 b=M66NWVtibf/XjszPaqyhNJkl/caKtwLgbnYlkEmfjs9/tXeEPEpT+SWq9bsvGeGBYwubNa
 yiKKUP3q5aPCBK/o4XIq5UhXDMKpuR1j7enRdOal/roVQBZrbHTsSEWyWKNRLdeMYI2GR0
 2GCpCA/5arbnBcBO+eNKeKz3wwWTf04=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-utIyY3hINVeN7wCAkgpVNw-1; Mon, 02 Dec 2024 04:19:52 -0500
X-MC-Unique: utIyY3hINVeN7wCAkgpVNw-1
X-Mimecast-MFC-AGG-ID: utIyY3hINVeN7wCAkgpVNw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4349df2d87dso38137665e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 01:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733131191; x=1733735991;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+affJrMHMT1VUrYSH4K6ny2yWHIycRqrMVg8+CbaE/U=;
 b=t3KNzdNIgdsjG4xAzj+kqVsHzIsr61UQwnKUp9P1vWm9c1JBq6ksaCWExcimaXxz3w
 ilYEir6wtTlNMzmqEEgStQfjSK1IT5m7C2cHDQDRRl8QPmiN7b1KxFH86pj5Q5DIqv+v
 vLzO035HBqnE3P+VK+VT89nDiroS6tAZhElWenHTithr6Aa0SEoZvW0gx9e4QGy+qqAW
 +SSnuLIyZcGfq7+2JeTGsN54ZpfHYfTioKtm1li7FUxZ2l9at/GlBTMCN/vifXWa9tvO
 wlVuTIzYGb/iMdkKyv8CtBWMMGY6CRF2ijxu0L/G47LoSQZxU688SsxHi15Ggut4IlzX
 Hj1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxxfz7UfUM49c5s5ilRYVHKVEFkJcNLeCnShMJjZB/UsiQ853qEdEmN76XKIWqiHRfwpCMUvI/xt3B@nongnu.org
X-Gm-Message-State: AOJu0YxwEJotctygvrkYYaEK9oFDuJcvIDL7Ph/x19s+HkYao0WLz0CG
 mPTAHF2RVkAGgZFNp8pOLbG8+782aBMPuHLoBofBQ+luIAwyS1bRSvzpn2HTYoEuBcUTa9JGKiK
 FUXKpr9XgsUDqX8DdAJM+o3h4O17NnQG8Oqag1SZMEx9VkyOCB8zj
X-Gm-Gg: ASbGncsfEtH9HwLN68P0PmpRJlq/302G75T2bVOjBMV1ix+58athoEYnIRbnYT+hzLw
 +joAw8zOr71lnkTdEz8tpV+twvc8eZdA7iq1Dxh8ebh7vA4n2CScXDGXSUopAuKocfTZdlOHdNf
 xokm86lj4PRXBrzYwZcgcjGcdio2nD2Qa5zHd3ziDqLpJIJ0mvz7G8BL0kMeatuKqpONfaeVCk1
 NLxplYr1ybEXc/UcinY5zFB+6i+UFWhsC0G8JGXQbtgLDsTwWvfh2qxqyEGR34EdJJUs1KIP64=
X-Received: by 2002:a05:600c:4686:b0:434:a986:11cf with SMTP id
 5b1f17b1804b1-434a9dc3030mr232087185e9.8.1733131190804; 
 Mon, 02 Dec 2024 01:19:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHczI6D8OKFQwHccT7GcdmMvlJXq+nlKc3jhEQu86kswk9mBUTAWnSRLvvvXsdAEhCnHxXWZA==
X-Received: by 2002:a05:600c:4686:b0:434:a986:11cf with SMTP id
 5b1f17b1804b1-434a9dc3030mr232086915e9.8.1733131190404; 
 Mon, 02 Dec 2024 01:19:50 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7d25d1sm177514775e9.31.2024.12.02.01.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 01:19:50 -0800 (PST)
Message-ID: <7a10e700-67dc-4619-bf6e-76bac44e88cc@redhat.com>
Date: Mon, 2 Dec 2024 10:19:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] tests/functional: add helpers for building file
 paths
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-9-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> Add helper methods that construct paths for
> 
>   * log files - to be preserved at the end of a test
>   * scratch files - to be purged at the end of a test
>   * build files - anything relative to the build root
>   * data files - anything relative to the functional test source root
>   * socket files - a short temporary dir to avoid UNIX socket limits
> 
> These are to be used instead of direct access to the self.workdir,
> or self.logdir variables, or any other place where paths are built
> manually.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 86 ++++++++++++++++++++++++++
>   1 file changed, 86 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 90ae59eb54..fb62052817 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -13,10 +13,12 @@
>   
>   import logging
>   import os
> +from pathlib import Path
>   import pycotap
>   import shutil
>   import subprocess
>   import sys
> +import tempfile
>   import unittest
>   import uuid
>   
> @@ -37,9 +39,93 @@ class QemuBaseTest(unittest.TestCase):
>       log = None
>       logdir = None
>   
> +    def socket_dir(self):
> +        if self.socketdir is None:
> +            self.socketdir = tempfile.TemporaryDirectory(
> +                prefix="qemu_func_test_sock_")
> +        return self.socketdir
> +
> +    '''
> +    @params args list of zero or more subdirectories or file
> +
> +    Construct a path for accessing a data file located
> +    relative to the source directory that is the root for
> +    functional tests.
> +
> +    @args may be an empty list to reference the root dir
> +    itself, may be a single element to reference a file in
> +    the root directory, or may be multiple elements to
> +    reference a file nested below. The path components
> +    will be joined using the platform appropriate path
> +    separator.
> +
> +    Returns: a qualified path
> +    '''
> +    def data_file(self, *args):
> +        return str(Path(Path(__file__).parent.parent, *args))
> +
> +    '''
> +    @params args list of zero or more subdirectories or file
> +
> +    Construct a path for accessing a data file located
> +    relative to the build directory root.
> +
> +    @args may be an empty list to reference the build dir
> +    itself, may be a single element to reference a file in
> +    the build directory, or may be multiple elements to
> +    reference a file nested below. The path components
> +    will be joined using the platform appropriate path
> +    separator.
> +
> +    Returns: a qualified path
> +    '''
> +    def build_file(self, *args):
> +        return str(Path(BUILD_DIR, *args))
> +
> +    '''
> +    @params args list of zero or more subdirectories or file
> +
> +    Construct a path for accessing/creating a scratch file
> +    located relative to a temporary directory dedicated to
> +    this test case. The directory and its contents will be
> +    purged upon completion of the test.
> +
> +    @args may be an empty list to reference the scratch dir
> +    itself, may be a single element to reference a file in
> +    the scratch directory, or may be multiple elements to
> +    reference a file nested below. The path components
> +    will be joined using the platform appropriate path
> +    separator.
> +
> +    Returns: a qualified path
> +    '''
> +    def scratch_file(self, *args):
> +        return str(Path(self.workdir, *args))
> +
> +    '''
> +    @params args list of zero or more subdirectories or file
> +
> +    Construct a path for accessing/creating a log file
> +    located relative to a temporary directory dedicated to
> +    this test case. The directory and its log files will be
> +    preserved upon completion of the test.
> +
> +    @args may be an empty list to reference the log dir
> +    itself, may be a single element to reference a file in
> +    the log directory, or may be multiple elements to
> +    reference a file nested below. The path components
> +    will be joined using the platform appropriate path
> +    separator.
> +
> +    Returns: a pathlib.Path object

Looks like it is rather returning a string?

> +    '''
> +    def log_file(self, *args):
> +        return str(Path(self.logdir, *args))
> +
>       def setUp(self, bin_prefix):
>           self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
>           self.arch = self.qemu_bin.split('-')[-1]
> +        self.socketdir = None

Should we also delete the socketdir during teardown again?

  Thomas


