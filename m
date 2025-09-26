Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC14CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27jO-000669-TP; Fri, 26 Sep 2025 08:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v27jI-00065I-7t
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v27j8-0005GC-81
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758890340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UtihAy58BrqwoxpGFqBno9FmNvWaiMX2xOapiAGxbtw=;
 b=H+m47G6VzNyS4sa7BzXWQNDftEeNvdsbym/0FqFJG8ScBxuDlnN0JXBjc6pqW/u8Cp/lQN
 Z2zcs5WBemt3TO03ykldbmAmGuYXoqsn3Q0XZCQMXSnfWXnnqKvQ/SseLsb31utExL7wC9
 GRS3rLCdn38n7tzch6VgOdb39SehOU8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-EctXOI7gM9iZNZSw9tyidg-1; Fri, 26 Sep 2025 08:38:58 -0400
X-MC-Unique: EctXOI7gM9iZNZSw9tyidg-1
X-Mimecast-MFC-AGG-ID: EctXOI7gM9iZNZSw9tyidg_1758890337
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f7b5c27d41so1119018f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 05:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758890337; x=1759495137;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UtihAy58BrqwoxpGFqBno9FmNvWaiMX2xOapiAGxbtw=;
 b=T0zNBBuqwkMApfjFZErM8Rolhy4b5iZus1Pxa/3kBg7W8q8D+1bmuzorFS1Cms3MZq
 +rOBkENfRppmpXO9jrZ197pRxgAtxc7U3um/I/JJ/mYbxKDnDNsmN5TN687/p8blfBPC
 XN0DCdZ+hTT5BNZZCny+ITZ1NW1l1Ka9ByjiWY++6cMDV5VIMat0M8bWDSBLriln+3iX
 FFSqxlek/6QGnZmID92BU/U02j/HRsPIFvCGRf+rRDA3tmx0pM1xgLYiztJiNsbVhyC0
 i5wjl1aHE/SxgwqY52aA4KNoPxc4nDNV8ovXqNOvJmSZBGVFj93YVEludO7AvrPJMDIb
 Vk/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYe995bBLiSkWMOI7AtL8z0t34uFEFsLA2slhPME7Wx7if6drN+8n3WgeKvmWs7CXx5sAFI5x/60uW@nongnu.org
X-Gm-Message-State: AOJu0YxvD5XCaLqU+BosWG3qmGRwVhn8YwsxnC6NTOkisIUurgpg24JT
 k0r9QP+IKJbHNjbjcx+qoQeapR2Go/QD3tnLpR6vwEwlEd37/IBoieLtgOeBZwvnC3Mwom6cYt8
 pRxT3hnLAlAOirZiO3o0W7dlCEvhoby20DfVrHCXaNlKSFi9blVCI+UFD
X-Gm-Gg: ASbGncuqbwR6MTmPZ5ohvv2mP3GE4LbYPiLVc+tRM27gb8QAWOtriKujyR+qqVIctI7
 ugIXvTgXHd3cpAFanayWmcL6x9W/8Cowk+OwslpKTxhHJ0EALhT/dERkcAK9TgiYOUyO1jgPmrP
 pGo2VxOz/Y+DCsNFj6w+6gO9cizeNpRf0oTAD+N8NDVaVUXeuUlYZD1KFCfTVaDWiXv3OhCEeUT
 NYgbFTEfmlYy2NXlR4ntdry+3Yv545XBAgo/mA7cdLUvXAKpJUFwvrFT3iPEeoSDu8NpyFodVtj
 f9RruZGAKtO/0kjcEJUWwmrSjovvOqDQz+ZGs5t875j/erQzSzlN4A1hwfZ+Yn5IxcYhY7UMJza
 Ul/H1xw==
X-Received: by 2002:adf:9c82:0:b0:3ee:3dce:f65f with SMTP id
 ffacd0b85a97d-40f65cafd2dmr5566376f8f.14.1758890337502; 
 Fri, 26 Sep 2025 05:38:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeBY6zglABMfnVYL/IrFiRrsL9vBI7JvbY8fxhN9DwSBKcpT1FD1PqnB5l5hXjRRD41rP9zw==
X-Received: by 2002:adf:9c82:0:b0:3ee:3dce:f65f with SMTP id
 ffacd0b85a97d-40f65cafd2dmr5566334f8f.14.1758890337039; 
 Fri, 26 Sep 2025 05:38:57 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a9ac582sm119854445e9.9.2025.09.26.05.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 05:38:56 -0700 (PDT)
Message-ID: <09faff84-3245-4704-aab6-e7cbb76e1130@redhat.com>
Date: Fri, 26 Sep 2025 14:38:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/28] Secure IPL Support for SCSI Scheme of
 virtio-blk/virtio-scsi Devices
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-1-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
...
>   crypto/meson.build                  |   5 +-
>   crypto/x509-utils.c                 | 423 +++++++++++++++
>   docs/specs/s390x-secure-ipl.rst     | 165 ++++++
>   docs/system/s390x/secure-ipl.rst    | 181 +++++++
>   hw/s390x/cert-store.c               | 213 ++++++++
>   hw/s390x/cert-store.h               |  39 ++
>   hw/s390x/ipl.c                      |  62 +++
>   hw/s390x/ipl.h                      |  27 +-
>   hw/s390x/meson.build                |   1 +
>   hw/s390x/s390-virtio-ccw.c          |  52 ++
>   hw/s390x/sclp.c                     |   2 +
>   include/crypto/x509-utils.h         | 131 +++++
>   include/hw/s390x/ipl/diag308.h      |  34 ++
>   include/hw/s390x/ipl/diag320.h      |  91 ++++
>   include/hw/s390x/ipl/diag508.h      |  38 ++
>   include/hw/s390x/ipl/qipl.h         |   7 +-
>   include/hw/s390x/s390-virtio-ccw.h  |   3 +
>   include/hw/s390x/sclp.h             |   4 +-
>   pc-bios/s390-ccw/Makefile           |   3 +-
>   pc-bios/s390-ccw/bootmap.c          | 107 +++-
>   pc-bios/s390-ccw/bootmap.h          |  11 +
>   pc-bios/s390-ccw/iplb.h             |  96 +++-
>   pc-bios/s390-ccw/jump2ipl.c         |   6 +-
>   pc-bios/s390-ccw/main.c             | 111 +++-
>   pc-bios/s390-ccw/netmain.c          |   8 +-
>   pc-bios/s390-ccw/s390-ccw.h         |  19 +
>   pc-bios/s390-ccw/sclp.c             |  52 ++
>   pc-bios/s390-ccw/sclp.h             |   7 +
>   pc-bios/s390-ccw/secure-ipl.c       | 781 ++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/secure-ipl.h       | 212 ++++++++
>   qapi/machine-s390x.json             |  22 +
>   qapi/pragma.json                    |   1 +
>   qemu-options.hx                     |  10 +-
>   target/s390x/cpu_features.c         |   7 +
>   target/s390x/cpu_features.h         |   1 +
>   target/s390x/cpu_features_def.h.inc |   5 +
>   target/s390x/cpu_models.c           |   7 +
>   target/s390x/diag.c                 | 555 +++++++++++++++++++-
>   target/s390x/gen-features.c         |   7 +
>   target/s390x/kvm/kvm.c              |  34 ++
>   target/s390x/s390x-internal.h       |   4 +
>   target/s390x/tcg/misc_helper.c      |  14 +
>   42 files changed, 3488 insertions(+), 70 deletions(-)
>   create mode 100644 docs/specs/s390x-secure-ipl.rst
>   create mode 100644 docs/system/s390x/secure-ipl.rst
>   create mode 100644 hw/s390x/cert-store.c
>   create mode 100644 hw/s390x/cert-store.h
>   create mode 100644 include/hw/s390x/ipl/diag308.h
>   create mode 100644 include/hw/s390x/ipl/diag320.h
>   create mode 100644 include/hw/s390x/ipl/diag508.h
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.h

  Hi,

looking at the file list, there does not seem to be any test in this series 
... could you please add some functional tests to make sure that the feature 
is working as expected?

  Thanks,
   Thomas


