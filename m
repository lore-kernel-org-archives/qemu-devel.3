Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7F8D185C7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnWc-00053x-G7; Thu, 08 Jan 2026 05:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdnWY-00052t-P2
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:45:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdnWW-0005Uj-Jy
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767869147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LW/FOfBs0BDOWoUTzKCLyAN193h4mN4TWdhc/odspIw=;
 b=DerDULDOH4ORMHLKir3GZY90QpOp3wt8XO4NtuiW63rCul4uWxBqiBrCBZmiyYr2cxQ7wC
 MpJhjibMWjN/xGIXpOtdTLJmqo4ueXguhqQ/IE58cUv8rln6vBsE5yGoAUJZ2Go5fhAOQL
 vnsEYKycN9WXPdXI18RDlKXivZuQIjY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-xFO_tjCCOGGBP44BKxOclw-1; Thu, 08 Jan 2026 05:45:45 -0500
X-MC-Unique: xFO_tjCCOGGBP44BKxOclw-1
X-Mimecast-MFC-AGG-ID: xFO_tjCCOGGBP44BKxOclw_1767869144
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4310062d97bso2139741f8f.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767869144; x=1768473944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LW/FOfBs0BDOWoUTzKCLyAN193h4mN4TWdhc/odspIw=;
 b=Wiz/PSQa1Yqk/plz5cgTVjSioHsVoeZxq8bqpHuWRF2q+kykqKv2HaxF1XARoP4ZvC
 X5SX1GAdxsCTEdtIjpiX2xLBhfu/1+E63Xcr6CTogRyUYIcBcm/UjGRcyyj6tw1/ZqFo
 kXSjdc5Yt2887azv2cNo02pZVXh237KWYPRITUfj4QR4ZKY7jfHWH8RKBx0Ao1gPzkFR
 RuXmVv/BZ0M17CaBbPjq1fD9eRw68BAIixRuHVhQUxpG1EWtIp8eYHOyOzy/0jleZOQO
 Jl+pvYVy4euIm9X5N/OwwKIxsd2kHP+TKBchAcjsVBI9ab2i2OxxAYwXokbyOrVo+hzf
 O9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767869144; x=1768473944;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LW/FOfBs0BDOWoUTzKCLyAN193h4mN4TWdhc/odspIw=;
 b=bCnjO8oqhcqSWrG3vZYWuZLC6E85klUHecyCZ3ZbWIQDgGnOP7HKCwpSdBgBZGTcs8
 5wsS5s9SY0VEJ1uy+pieimqaUOpWQ2BckpTGDAw4nsrcnJDR3R2Ab3K6LarMixnrfXil
 S1c2MfKODN6BqZDIrbHzIfsEl+VpGRxM6ZqdiN0VsA0comiy8ToOit8sM7THfLzdyc5s
 2VDX7yfOXrZwR1LC8uLqZKoNcvukjjnl+17sXkaT8B5xmlM5T9TnyDmK9j6JQZ6x/Kpz
 nF1vOir0eAQ/FtdyxhxpolVmskhefKa1PIAD/aTp1zKqoCb86qIdgi255rs0FnLarkrk
 ZtNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIbXG9cb9BWYCa56rujkdYUIeBBTj8Rora8gvz9yHAclTnVsH0tHVceEeEyKL7pyi8QSlJZrbsj8Jo@nongnu.org
X-Gm-Message-State: AOJu0Yy94Lw1HnGaDgRpKAPhLzKpnt1VFyWzb3WMJk6s9VP+/N+0pVib
 v5pEjqYnQBk/5No6ufdD9eAjRKJLYgpFc3EwPMAA/z5NCQKZR0C80RNIPNvUahdgPWel8+h2k5U
 ITUZ7Ttbl0QA0B85gNBf7BnJLhpgGdxNAr00u4//4nbVGaiVmqcl9UL9oTgyY3Y7z
X-Gm-Gg: AY/fxX6rpapXeE9Z4ELW1udfHQbEU8yfaJygFNkXy/AMQWsyasmc2X/QMvhawvpIgYx
 qByJRKE6XUlx+RttuaU7LCrDvA28ujXUuINt5Ca/ax2D4Mf0f9EOk65dU5eJPzp/X8luyNI6WA/
 ox7X1lWe5jLUXTVrzlKNDGRsbAwcLgXYPRFKaHW8YKDVrAlCU+e47bEy/JRAg1eYuKX4fVOQzxS
 2TFKeYC5wOmHzp3s7zpTXfpMUQDUK6AosJKEhp6uE8z0beK+G8dO5CXUN7ySleTMdHBX/OPS+v8
 hPggkmJR9FYzrqdLJQZgZH9laPwO7obV+emN/u/fB9ITvJBbr8YtEVcfaTqnZU7jRvpAOGYOMiX
 xxFOsNMs=
X-Received: by 2002:a05:6000:230c:b0:432:a9db:f99c with SMTP id
 ffacd0b85a97d-432c375b13fmr7546042f8f.31.1767869144426; 
 Thu, 08 Jan 2026 02:45:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNaX5mJuD8K7WvhFErqPoT/5qm65v81X09/CQvpkTWb3bc/3ezPs8bdi6aGzZKH5Fb5Gkq9Q==
X-Received: by 2002:a05:6000:230c:b0:432:a9db:f99c with SMTP id
 ffacd0b85a97d-432c375b13fmr7546004f8f.31.1767869143987; 
 Thu, 08 Jan 2026 02:45:43 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacdcsm15551459f8f.1.2026.01.08.02.45.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 02:45:43 -0800 (PST)
Message-ID: <6781dae7-ba6d-447d-9dc6-aceb31b34c01@redhat.com>
Date: Thu, 8 Jan 2026 11:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/29] Add boot-certs to s390-ccw-virtio machine type
 option
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-2-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-2-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
> machine. This allows users to specify one or more certificate file paths
> or directories to be used during secure boot.
> 
> Each entry is specified using the syntax:
> 	boot-certs.<index>.path=/path/to/cert.pem
> 
> Multiple paths can be specify using array properties:
> 	boot-certs.0.path=/path/to/cert.pem,
> 	boot-certs.1.path=/path/to/cert-dir,
> 	boot-certs.2.path=/path/to/another-dir...
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/system/s390x/secure-ipl.rst   | 20 ++++++++++++++++++++
>   hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
>   include/hw/s390x/s390-virtio-ccw.h |  2 ++
>   qapi/machine-s390x.json            | 23 +++++++++++++++++++++++
>   qapi/pragma.json                   |  1 +
>   qemu-options.hx                    |  6 +++++-
>   6 files changed, 81 insertions(+), 1 deletion(-)
>   create mode 100644 docs/system/s390x/secure-ipl.rst
> 
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> new file mode 100644
> index 0000000000..0a02f171b4
> --- /dev/null
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -0,0 +1,20 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Secure IPL Command Line Options
> +===============================
> +
> +The s390-ccw-virtio machine type supports secure IPL. These parameters allow
> +users to provide certificates and enable secure IPL directly via the command
> +line.
> +
> +Providing Certificates
> +----------------------
> +
> +The certificate store can be populated by supplying a list of X.509 certificate
> +file paths or directories containing certificate files on the command-line:
> +
> +Note: certificate files must have a .pem extension.
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...

Maybe use "-M" instead of "-machine" to shorten the line a little bit?
... just an idea, feel free to keep "-machine" if you prefer it.

> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
> index ea430e1b88..0103fc91cd 100644
> --- a/qapi/machine-s390x.json
> +++ b/qapi/machine-s390x.json
> @@ -140,3 +140,26 @@
>   { 'event': 'SCLP_CPI_INFO_AVAILABLE',
>     'features': [ 'unstable' ]
>   }
> +
> +##
> +# @BootCertificates:
> +#
> +# Boot certificate for secure IPL.
> +#
> +# @path: path to an X.509 certificate file or a directory containing
> +# certificate files.
> +#
> +# Since: 10.2

This needs to be updated to 11.0 now.

> +##
> +{ 'struct': 'BootCertificates',
> +  'data': {'path': 'str'} }
> +
> +##
> +# @DummyBootCertificates:
> +#
> +# Not used by QMP; hack to let us use BootCertificatesList internally.
> +#
> +# Since: 10.2

dito.

  Thomas


