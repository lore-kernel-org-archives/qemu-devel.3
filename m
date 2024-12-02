Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A15D78303
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 10:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI3hP-0005x4-L0; Mon, 02 Dec 2024 05:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI3hO-0005wj-20
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:30:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI3hL-00035J-JX
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733135434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u2yRkP3tJBqHOXYD+ENmZFgoDi9CszY/RPmzmMdoBFg=;
 b=fV6fwlSHR/6iuUXa1YEr3u7HfwKnIu9DRHy3Hsk/ftuA+iCHzXFZZVvYja17meezDEXAKO
 f+k+PJFHBIKsUN1mTe3MOfSLLnZMi2QCTA9KpfbM5Ra7xYYrAVBqvbmvdd65lCgm4s2xpk
 WQyDjFCzEZuNFMt+ZVk7rT+4IZ9OAvQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-LWn74vkIN_2ObBF89FTqJA-1; Mon, 02 Dec 2024 05:30:31 -0500
X-MC-Unique: LWn74vkIN_2ObBF89FTqJA-1
X-Mimecast-MFC-AGG-ID: LWn74vkIN_2ObBF89FTqJA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434a4ad4798so30233025e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 02:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733135430; x=1733740230;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u2yRkP3tJBqHOXYD+ENmZFgoDi9CszY/RPmzmMdoBFg=;
 b=XkzzcaPUxEgei8k2W4X6Y/aDkgm9/muiBukZ7L2/PzIENpzH2QAYWtV1d792LeQGr1
 ItgE5SJRuNSJ4R7b6w/KH8kVLMoDj7zsdgbZgEg3u2yscKEXHxMvQ6PhHlAUOagS0pZU
 j9NdrMEnzDTqOTy56iX5YfxAqoJMAX2jat5kC5aGoHJvXwWc4QVNk4+/O/PBVxzqbt71
 9/mHdsBTUXKFeR87Jbzo5P3kITfNGyqtDrYwXy/r9/+mx5oSeu0LiaQgkL//IcH9FhyL
 FvlAyrM2b4DOZdqgjxXwDE0yDeFAI80JQiiN4YymjF+rK1jEI8M9XQv2yNFChutbcQKH
 C07w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwNcfyDQ+GuHzSmEXaK4H/ppQUUYHXfi92AmjPLvdmRi2bLntBwUeKrgWzGPIeATmrD6krUhQ2MmGI@nongnu.org
X-Gm-Message-State: AOJu0YwS2XY5NBeaRSUID7yYg/hBQ77JIxrNE35Nft2Xq5sd/pzfG3Tx
 a5vm+t4P2BkHaVT5XgRHA9FCy5+97xC8xf6kDqxV1r+/3WIkMa7iSzOIaZhgopi3EqRbFLvFGtU
 biIYqzfUAWqAEC8D2EIjXOCGGKwUkeWmHT/qd5VTztSngG+S81xIl
X-Gm-Gg: ASbGncvds1hyScJ/TeJHhsQB+w87rHgmkikQYoNrI65jIxbuP0eoT2xmSFVu2O/DLV6
 xY1RVvwlx3BweODjMu1HTJHot/OO0YCAKOkVHc2hxaqvHqzlxzgXwafKoaxh/0rDpLmwYSImCBE
 aHgwsU15wFyzIR5GvRrt0KQ1Kwk5F7fuRYQP8Hts9la15gflq27ZYnW/QuJWVyE3mn9N+3eOT0c
 qcnXZ7gQ+TCDwD6TtWn3NmHzVqgZ+A2ducN/2/rNx1H/xCp/RjCz4zkEIqyw7WtFwsQRM+V9LI=
X-Received: by 2002:a05:600c:314a:b0:434:9e46:5bc with SMTP id
 5b1f17b1804b1-434a9dc3e92mr230200635e9.10.1733135430004; 
 Mon, 02 Dec 2024 02:30:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp8F6Ez5UOPSbCvszuljvKgR1cOvPqKRCxOEFgQkux5IAnQUxIfFu/PHq8ku2cX2pt4WefFA==
X-Received: by 2002:a05:600c:314a:b0:434:9e46:5bc with SMTP id
 5b1f17b1804b1-434a9dc3e92mr230200315e9.10.1733135429591; 
 Mon, 02 Dec 2024 02:30:29 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74edb1sm182025795e9.3.2024.12.02.02.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 02:30:29 -0800 (PST)
Message-ID: <9277a627-13d6-4d0f-9802-dec6b2606cbe@redhat.com>
Date: Mon, 2 Dec 2024 11:30:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/22] tests/functional: add 'archive_extract' to
 QemuBaseTest
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-19-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-19-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
> This helper wrappers utils.archive_extract, forcing the use of the
> scratch directory, to ensure any extracted files are cleaned at test
> termination. If a specific member is requested, then the path to the
> extracted file is also returned.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 36 ++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 2f32742387..31d06f0172 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -28,6 +28,8 @@
>   from .asset import Asset
>   from .cmd import run_cmd
>   from .config import BUILD_DIR
> +from .utils import (archive_extract as utils_archive_extract,
> +                    guess_archive_format)
>   
>   
>   class QemuBaseTest(unittest.TestCase):
> @@ -39,6 +41,40 @@ class QemuBaseTest(unittest.TestCase):
>       log = None
>       logdir = None
>   
> +    '''
> +    @params archive: filename, Asset, or file-like object to extract
> +    @params sub_dir: optional sub-directory to extract into
> +    @params member: optional member file to limit extraction to
> +
> +    Extracts @archive into the scratch directory, or a
> +    directory beneath named by @sub_dir. All files are
> +    extracted unless @member specifies a limit.
> +
> +    If @member is non-None, returns the fully qualified
> +    path to @member
> +    '''
> +    def archive_extract(self, archive, format=None, sub_dir=None, member=None):
> +        if type(archive) == Asset:
> +            if format is None:
> +                format = guess_archive_format(archive.url)
> +            archive = archive.fetch()
> +        elif format is None:
> +            format = guess_archive_format(archive)
> +
> +        if member is not None:
> +            if os.path.isabs(member):
> +                member = os.path.relpath(member, '/')
> +
> +        if sub_dir is None:
> +            utils_archive_extract(archive, self.scratch_file(), format, member)
> +        else:
> +            utils_archive_extract(archive, self.scratch_file(sub_dir),
> +                                  format, member)
> +
> +        if member is not None:
> +            return self.scratch_file(member)
> +        return None

Ah, ok, so the guessing is done here ...

But somehow it feels wrong to have a "archive_extract" function in the 
QemuBaseTest class that also does asset fetching under the hood.

Could you maybe rather move this into the asset.py file and rename the 
function to "fetch_and_extract()" to make it clearer what it does?

  Thomas


