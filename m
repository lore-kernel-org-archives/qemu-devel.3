Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B500D78303
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 10:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI3Xc-0004fm-D6; Mon, 02 Dec 2024 05:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI3Xa-0004fX-D5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI3XW-0000U7-RJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733134823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+oAdtKQRAgMl/Rs38FDp0ftBVOe0lH2rrSSjsAj0Sww=;
 b=VBzlhSpg6FMRYWw2IPv3GUOymnt9mQj7BbunUQL2LCLdC59nd+8vDRbb05KU6m1p/4QyYA
 RGckLyLGsv5tz5RShqpzlbNHfK/KaScqi5lYcNsNwXyjG/1jzbbb1JZoXepF8qBJA/RpM7
 PuM4ac7cAk2Qb2E+PuSf2j9w2c+rvrc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-oN4jxMrPN-eiQi4BE_d-Kw-1; Mon, 02 Dec 2024 05:20:22 -0500
X-MC-Unique: oN4jxMrPN-eiQi4BE_d-Kw-1
X-Mimecast-MFC-AGG-ID: oN4jxMrPN-eiQi4BE_d-Kw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434a27c9044so22144365e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 02:20:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733134821; x=1733739621;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+oAdtKQRAgMl/Rs38FDp0ftBVOe0lH2rrSSjsAj0Sww=;
 b=X5D+xdX3KRiFExk2KEPIJR4ZwFOjQcWlL4W7WHfgkhmU7F9prjVKHXH3qEpsBuhDW3
 5bJ3NO7hnt0itlIrW82WRwfOR65bdkXnh/x5mdwAjM+BdV2jD1wl/qxG3VzZjv2SIvRU
 +dD0iu2I1qakSpraI64fOOaxxko1H3CJ33OFiAkyKyMUDAdibttsU+FLTTO9gtl07+JM
 9XtMlXy73b+wkhqrsssBSTCaQETQNIN/e0duvyTtyloeUsfif2QcgjBXbVoAwAttxWrt
 XMbVwPrJcJkDLGUtPwywXiNHzROrzeljOasLZpM4bttZ7Zj33mBNwLknbS6DUmVgD70p
 QCfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6T0WmSllfO89j2eE2uGX6Jyr7pX9tNvrZ1wl+r5nXUYw/8D762QkeL2LUlD7MJlEn/KharE7QyXmh@nongnu.org
X-Gm-Message-State: AOJu0YwvGoReM+02F/xrL5iIM9Jqo3uohM/mayb0xVhJEzROXYJW6/Qy
 IUNrfSA4qf6XnssRmJQu0dcm8ma3f64VMOYqL3CwkC+tFrxoNn4ZfXtVmxj+OtyAqf/asaZDgxu
 o/yJCufzoGHm/w6+m6RJ5A3m7pQJ56xCLbH2teNT+xbFzcF4TquTC
X-Gm-Gg: ASbGncuod9jICcPEjI7DgHPP99gwZaiF6m6RxHFOcyHfML291zskVw0KX2l5iCpLC0P
 IjmknF9Gjs4Xo8hIZG7KS0JG6yD2pTBscVlwXdJ3pDHaufwb9Nyzxjs24umu+kCMckdgHGlJC94
 lhQFpwnDFtm/tO7bCd8SmaOf4TQNWMZwVEkhHHy1y6J2dyYBD4UkWucALIgOBtcYhfaU122RKFl
 Yo61K5wNkYb//BRqnljl6JHnvnbxBqvB+lZtMj+UfQD7v/6fb2shGVwpi+Z649Mh4HFI6D0MKk=
X-Received: by 2002:a05:600c:4f12:b0:434:a0fd:f9d1 with SMTP id
 5b1f17b1804b1-434a9de78c4mr183623895e9.20.1733134820854; 
 Mon, 02 Dec 2024 02:20:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfGZEMBr8FQh4jVtf6ax/GQUeZATrQeLhhLlS+QxnobT9JjoTvBKZaCfdGl6hr+3I/oBiW/Q==
X-Received: by 2002:a05:600c:4f12:b0:434:a0fd:f9d1 with SMTP id
 5b1f17b1804b1-434a9de78c4mr183623615e9.20.1733134820469; 
 Mon, 02 Dec 2024 02:20:20 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa77d01esm182283485e9.22.2024.12.02.02.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 02:20:20 -0800 (PST)
Message-ID: <f7e57416-5812-449b-8c9e-4d2bdc12adfd@redhat.com>
Date: Mon, 2 Dec 2024 11:20:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/22] tests/functional: generalize archive_extract
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-18-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-18-berrange@redhat.com>
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
> There are many types of archives that the tests deal with, and
> 'archive_extract' suggests it can cope with any, rather than only
> tar files. Rename the existing method to 'tar_extract' and add a
> new method that can dynamically extract any zip, tar or cpio file
> based on file extension.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/utils.py | 31 +++++++++++++++++++++++++++--
>   1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
> index bafe7fb80e..8c1df8f8c2 100644
> --- a/tests/functional/qemu_test/utils.py
> +++ b/tests/functional/qemu_test/utils.py
> @@ -14,6 +14,7 @@
>   import shutil
>   import subprocess
>   import tarfile
> +import zipfile
>   
>   from .cmd import run_cmd
>   
> @@ -38,7 +39,33 @@ def image_pow2ceil_expand(path):
>               with open(path, 'ab+') as fd:
>                   fd.truncate(size_aligned)
>   
> -def archive_extract(archive, dest_dir, member=None):
> +def archive_extract(archive, dest_dir, format=None, member=None):

Why not doing "if not format: format = guess_archive_format(archive)" here?
Otherwise this helper function is rather useless - if you have to know the 
format, you could directly call the appropriate function anyway.

  Thomas


> +    if format == "tar":
> +        tar_extract(archive, dest_dir, member)
> +    elif format == "zip":
> +        zip_extract(archive, dest_dir, member)
> +    elif format == "cpio":
> +        if member is not None:
> +            raise Exception("Unable to filter cpio extraction")
> +        cpio_extract(archive, dest_dir)
> +    elif format == "deb":
> +        deb_extract(archive, dest_dir, "./" + member)
> +    else:
> +        raise Exception(f"Unknown archive format {format}")
> +
> +def guess_archive_format(path):
> +    if ".tar." in path or path.endswith("tgz"):
> +        return "tar"
> +    elif path.endswith(".zip"):
> +        return "zip"
> +    elif path.endswith(".cpio"):
> +        return "cpio"
> +    elif path.endswith(".deb") or path.endswith(".udeb"):
> +        return "deb"
> +    else:
> +        raise Exception(f"Unknown archive format for {path}")
> +
> +def tar_extract(archive, dest_dir, member=None):
>       with tarfile.open(archive) as tf:
>           if hasattr(tarfile, 'data_filter'):
>               tf.extraction_filter = getattr(tarfile, 'data_filter',
> @@ -62,7 +89,7 @@ def deb_extract(archive, dest_dir, member=None):
>           (stdout, stderr, ret) = run_cmd(['ar', 't', archive])
>           file_path = stdout.split()[2]
>           run_cmd(['ar', 'x', archive, file_path])
> -        archive_extract(file_path, dest_dir, member)
> +        archive_extract(file_path, dest_dir, format="tar", member=member)
>       finally:
>           os.chdir(cwd)
>   


