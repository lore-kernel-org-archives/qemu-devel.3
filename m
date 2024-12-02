Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F2BD78301
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 10:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI3Ri-0003HG-2j; Mon, 02 Dec 2024 05:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI3Rh-0003H8-4b
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:14:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI3Re-00074Q-Eb
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733134460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qiuu96ul6qeHnhQFACFV5CwwT/a1OEqqAY4aZO0ckJw=;
 b=DGEatGhRhQmCPQO1cQES16KQzF8gemO8sStFmHj4Mml2pVo/Rtg1UpGD9GNBFcytQX/vd0
 QJVu5B4vPuA6putHouOpsDCqnrF32dEFikCM/SZnTG8WsVbU0FAUiUTSpzxoGIjJ9QzNDy
 Ah9/YgTO624uIbZ7JEalw3A4saUrCqU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-rFwl7g9IMsu5rBpo_7fc5A-1; Mon, 02 Dec 2024 05:14:19 -0500
X-MC-Unique: rFwl7g9IMsu5rBpo_7fc5A-1
X-Mimecast-MFC-AGG-ID: rFwl7g9IMsu5rBpo_7fc5A
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385dcae001fso1471486f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 02:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733134458; x=1733739258;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qiuu96ul6qeHnhQFACFV5CwwT/a1OEqqAY4aZO0ckJw=;
 b=L/IoLxE9wNYBclAJ+es5LZFKqu+gjEPCgV+ItoKlpHemi2tezvxuzc5dSMk+Br2pkA
 ysDXTfYdydyhCnsLteoL30gpTNMeByhOPO9LH3ZNHbYCfjixfEGS7kgPBYd82rkg488d
 zKnowdHRkBdIEqH8PpKVkuScByueME9fF3H2cjZHz0b33+DBmfc848bQhocb8yEDs1C6
 HxAMH8pn/AK7tGDFZNAT5xq2NEH4VLRRe+dmwyWB3AQ5mfjJ/0k/4EQep6SOezMbjXdN
 LiGECNsrnjmTVSQHKkUlbeJTPT7Fh+0pUxpV4yK1ZBOJaoI0VIMnlC1HDIEAniefFdpr
 3r0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyUqJLycPiok6UNgvJ7Q2FeXdM3YAdAM6OlwJwG0rIo1WDQ490OJ1Yzx1RWm8kIypmjM7a8K/U19CU@nongnu.org
X-Gm-Message-State: AOJu0Yw92WivSDUWYKScfPWDQmDSRH+zyvBZiA8+Cb2GT46d0R9NNdIW
 gxPr6CsEyuUi2A+uuMuV529yK05ZNlMlzCdILK2pxVNQxrcpKV+fkRhW5JLiw5oDqWjB5kD8TN9
 T2Xv1cahofdcb77fBS3jvegc8fEoHt+Uw4knsSsyBS1/AmDNOaK0b
X-Gm-Gg: ASbGnctA2tj18Xo8ZbsMQSLN8pL6q31I7i4AFZVEmTbFNHgEU0Dt0wKM8QeB856KkzH
 bZssvgs8V5EXrCIVYd2b694Bb4YV6olPjd1JDHouj/FCzW1zDnB6oWip2pJkruf8wqINgHlj3JS
 TAh9ZNP/D/3pYo3SR6H+4Sn2KHEck6rh4HW+eYKZ++uqQvXbyZoE7gFXPpci1db38WkxU3HN9O/
 VaDi4Jbp3QBst/Zx47iWKm+KavbvDi7H4jIf8gUC6B9gcMoy9BOuOIr1POGBLQg1QFR3LxOlqs=
X-Received: by 2002:a05:6000:1a8a:b0:385:f979:7683 with SMTP id
 ffacd0b85a97d-385f97979b8mr345870f8f.37.1733134457879; 
 Mon, 02 Dec 2024 02:14:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFik0Hjq5NG+FkTLosuKxLHwJxD5/BpMpzD9cuh/2xApaQJh2ZkyuiiJZcC7cSKAI8HvUQCVg==
X-Received: by 2002:a05:6000:1a8a:b0:385:f979:7683 with SMTP id
 ffacd0b85a97d-385f97979b8mr345854f8f.37.1733134457522; 
 Mon, 02 Dec 2024 02:14:17 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385f22af241sm2532328f8f.74.2024.12.02.02.14.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 02:14:17 -0800 (PST)
Message-ID: <36f44436-5448-4ac8-bed5-1f23b79887dc@redhat.com>
Date: Mon, 2 Dec 2024 11:14:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/22] tests/functional: add common deb_extract helper
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-17-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-17-berrange@redhat.com>
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
> This mirrors the existing archive_extract, cpio_extract and zip_extract
> helpers
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/linuxkernel.py | 15 +++++----------
>   tests/functional/qemu_test/utils.py       | 13 +++++++++++++
>   2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
> index a6525f9dd6..fb6a158d36 100644
> --- a/tests/functional/qemu_test/linuxkernel.py
> +++ b/tests/functional/qemu_test/linuxkernel.py
> @@ -6,8 +6,8 @@
>   import os
>   
>   from .testcase import QemuSystemTest
> -from .cmd import run_cmd, wait_for_console_pattern
> -from .utils import archive_extract
> +from .cmd import wait_for_console_pattern
> +from .utils import deb_extract
>   
>   class LinuxKernelTest(QemuSystemTest):
>       KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
> @@ -37,16 +37,11 @@ def extract_from_deb(self, deb_path, path):
>           :param path: path within the deb archive of the file to be extracted
>           :returns: path of the extracted file
>           """
> -        cwd = os.getcwd()
> -        os.chdir(self.workdir)
> -        (stdout, stderr, ret) = run_cmd(['ar', 't', deb_path])
> -        file_path = stdout.split()[2]
> -        run_cmd(['ar', 'x', deb_path, file_path])
> -        archive_extract(file_path, self.workdir)
> -        os.chdir(cwd)
> +        relpath = os.path.relpath(path, '/')
> +        deb_extract(deb_path, self.workdir, member="." + path)
>           # Return complete path to extracted file.  Because callers to
>           # extract_from_deb() specify 'path' with a leading slash, it is
>           # necessary to use 'relative_to()' to turn it into a relative
>           # path for joining to the scratch dir
> -        return os.path.normpath(self.scratch_file(os.path.relpath(path, '/')))
> +        return os.path.normpath(self.scratch_file(relpath))
>   
> diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
> index 41bd1df666..bafe7fb80e 100644
> --- a/tests/functional/qemu_test/utils.py
> +++ b/tests/functional/qemu_test/utils.py
> @@ -15,6 +15,8 @@
>   import subprocess
>   import tarfile
>   
> +from .cmd import run_cmd
> +
>   """
>   Round up to next power of 2
>   """
> @@ -53,6 +55,17 @@ def zip_extract(archive, dest_dir, member=None):
>           else:
>               zf.extractall(path=dest_dir)
>   
> +def deb_extract(archive, dest_dir, member=None):
> +    cwd = os.getcwd()
> +    os.chdir(dest_dir)
> +    try:
> +        (stdout, stderr, ret) = run_cmd(['ar', 't', archive])
> +        file_path = stdout.split()[2]
> +        run_cmd(['ar', 'x', archive, file_path])
> +        archive_extract(file_path, dest_dir, member)
> +    finally:
> +        os.chdir(cwd)

Not sure whether we really need this ... extracting .deb files is very 
specific to running Linux kernels in the guest, so IMHO it should be 
sufficient to have it in linuxkernel.py.

Anyway, if we add more and more *_extract functions, we should maybe 
consider to move the extraction functions out of utils.py into an archive.py 
file, what do you think?

  Thomas


