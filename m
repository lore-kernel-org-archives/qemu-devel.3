Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4459BCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Wku-0003XR-M0; Tue, 30 Sep 2025 05:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3Wks-0003XJ-K5
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3Wkk-0001Ap-FV
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759224869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NEzFz8chgZah+oV88vBhXIFT447BpUOfog/6/3sgDmw=;
 b=Ng6iq52Rw96SP92V46QAhxP2gTCm1x0M4ilfbqK7rhy40RXuP9w4IY42dhaoWQTvPP9Gl8
 v+LiehwvMeUHXYKbuT8ZJ4HPHmCbSyiHVelQHDhPlfW98czNmZAcKgv1Y2/MtvVdvvvk//
 ef3s2T1KRMSjs2Wb8iKKR5qkRCoeAkE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-AYyT34arNAmmQB-6XCg2Uw-1; Tue, 30 Sep 2025 05:34:27 -0400
X-MC-Unique: AYyT34arNAmmQB-6XCg2Uw-1
X-Mimecast-MFC-AGG-ID: AYyT34arNAmmQB-6XCg2Uw_1759224866
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3f7b5c27d41so3142711f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 02:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759224866; x=1759829666;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NEzFz8chgZah+oV88vBhXIFT447BpUOfog/6/3sgDmw=;
 b=CT4OHYJk8UCQ1FqCuZdShn/Hbw8upYalGZP5Bs2Kf9P+3S+BYbqsrtv+INXPUHwBA3
 4TygTMVLLSxUrK4s68IZFaZsw38kwDw3JaVnVl9Bd7iumsMR5bVHpr+2yASmSOQccXB+
 jNmVOvO6741aTIKrXOtPCsos6RQ9uqJT3xYQtQ7RQwOl98wpTZ34yGi/xyDTdIPpnqUp
 Oi3fRXBaeTk3+XxghVEFkZ7mQCAScgRUVAhTylM9hZPNPLu8OZhG+oVpUuTobkD7gSdH
 uQk9HA3zSN7HbFGNIgfmHnfvtjTU6DBNGNFkk0uo2B0vUGCQQKCjP6iO7jCfuzqN4uD2
 D+fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkJpIWYIA8ixnNZXSBDrg32zum69SnP3z1lNBOlQlI1Ozyy8/uvP1zbwhFt3FuteuMHq33U/aU7a+M@nongnu.org
X-Gm-Message-State: AOJu0YwiKhH6HaBodBZL1PgIEGH8m+f5M3QvuT1yBwm0bMhveKvC6Rgd
 xt6MQvh5x/5HeCWgCQtfTEH7Tg29ts+I+gKKQW/op+RDGEel7jxPNjQcawGLkEL8j+tEYu448Rv
 d7nxviOaFNY1X/GpDEsRewKA429CnJ5GQhAgEw1frsUWVY8QP+392cDEg
X-Gm-Gg: ASbGnct8W1chfaM0qDh1y/rBLF6WQLh/bQXYcG8/XOhx7+CoF/ww0cLfckanYj311QS
 EdQiQIQkQB8WjEWLFQw8NU0BoTQEVv1eAhlPXRB1qeffgXxQzIlYQ0Jg79SLShoUCKzEpJXMALY
 uHjO/4TVDndsOubxIsvgsTj53CbiRCs52fy5eZ+y6PVWpBdYIl2vZihlaomY6QKwE6cscYB545E
 dYelc8oysAQcXxq5szCGZPQ6Xj+bwqtHMU7fbwa4ndJzqzrFqvv099d3BmigyKjHaeTE6LH4LuV
 49QKp2JXhiMzuKdKGmM7nqagjHFnswpPmppRpCojMgLM9ItnKuDfdPTjUTXWp8ff0T5jlzCm1iq
 EmnkLmtya+Q==
X-Received: by 2002:a05:6000:184e:b0:3ec:d9a8:3700 with SMTP id
 ffacd0b85a97d-424119d226bmr3274286f8f.23.1759224866081; 
 Tue, 30 Sep 2025 02:34:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkQz+2GazXC/Q2xFW5MaORRKuQjp60vYdQMfNdW/GOBhuZcD/oXYQMvCekKH7iFkn2zZDuNQ==
X-Received: by 2002:a05:6000:184e:b0:3ec:d9a8:3700 with SMTP id
 ffacd0b85a97d-424119d226bmr3274245f8f.23.1759224865569; 
 Tue, 30 Sep 2025 02:34:25 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5603365sm22534999f8f.37.2025.09.30.02.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 02:34:25 -0700 (PDT)
Message-ID: <9f3a8d43-c428-45d4-bce5-1af764cf18a9@redhat.com>
Date: Tue, 30 Sep 2025 11:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/28] Add boot-certs to s390-ccw-virtio machine type
 option
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-2-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-2-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
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
> ---
>   docs/system/s390x/secure-ipl.rst   | 21 +++++++++++++++++++++
>   hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
>   include/hw/s390x/s390-virtio-ccw.h |  2 ++
>   qapi/machine-s390x.json            | 22 ++++++++++++++++++++++
>   qapi/pragma.json                   |  1 +
>   qemu-options.hx                    |  6 +++++-
>   6 files changed, 81 insertions(+), 1 deletion(-)
>   create mode 100644 docs/system/s390x/secure-ipl.rst
> 
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> new file mode 100644
> index 0000000000..92c1bb2153
> --- /dev/null
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -0,0 +1,21 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Secure IPL Command Line Options
> +===============================
> +
> +The s390-ccw-virtio machine type supports secure IPL. These parameters allow users
> +to provide certificates and enable secure IPL directly via the command line.
> +
> +Providing Certificates
> +----------------------
> +
> +The certificate store can be populated by supplying a list of X.509 certificate file
> +paths or directories containing certificate files on the command-line:
> +
> +Note: certificate files must have a .pem extension.
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio, \
> +                               boot-certs.0.path=/.../qemu/certs, \
> +                               boot-certs.1.path=/another/path/cert.pem ...

Using newlines/spaces between parameters does not work, so people cannot 
copy-n-paste this example to the shell.

So I think you either have to merge it into one line, or use multiple 
"-machine" statements, e.g.:

     qemu-system-s390x -M s390-ccw-virtio \
                       -M boot-certs.0.path=/.../qemu/certs \
                       -M boot-certs.1.path=/another/path/cert.pem ...

  Thomas


