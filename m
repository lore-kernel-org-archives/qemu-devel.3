Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23309CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQ08-000471-8R; Mon, 10 Nov 2025 06:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIPef-0008FR-LU
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:01:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIPea-0003F8-CB
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762772502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pL8QZ5lQK9L/Ct/Tp+ILnLfQ4P66qZr8nEuIbPW7JZI=;
 b=ejmAfm+IIliaT2DRLZmsFmYJigHWZIMA+w6yS2NCdesZrsaTg5AmhYsu+ydUZEFBfz3oAN
 1V6w2iBjPZsgdxBBOx52owrdltRi23lU29d/jk+dWZn6hUgrMjnPng46xpeKRtR5aLuBoI
 JQSGhiwUbJOugjO19xv/STvVoHnJ8nM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-Jhs7X4jIPrKbsNMztRPUuw-1; Mon, 10 Nov 2025 06:01:41 -0500
X-MC-Unique: Jhs7X4jIPrKbsNMztRPUuw-1
X-Mimecast-MFC-AGG-ID: Jhs7X4jIPrKbsNMztRPUuw_1762772500
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4775f51ce36so28432345e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762772500; x=1763377300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pL8QZ5lQK9L/Ct/Tp+ILnLfQ4P66qZr8nEuIbPW7JZI=;
 b=CqQGymWPybrZwbhxwz272f96rnWWceJdiI5ALic0LqDSxzdPAgsZgkGkxauLeH3f9+
 3ZLHlr4VUNLsSosspLb5BHyBnv3xh39pGMX8nEh0soZ8Ms/c3t3+oUnr58fmFUOjrb3+
 nT2/nzQ0hgMFWbKHHCrj5FRqBIZjrG3R2a40w621ihgfHIISh0D4OoO5io3uLbyfvDZv
 EuVhsS1asZyXCi1/auFEzElKIjFsJipT1Dy9qdf2Z5lPmJZ9Ik8QbquyYM6P0s8nXfpP
 1D9HYGcV+oWkPhcf9KA+dz8AqgI1DEu01uj98jngEFylbdTAXsW+HaHnMi1rSNc8UQU0
 HWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762772500; x=1763377300;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pL8QZ5lQK9L/Ct/Tp+ILnLfQ4P66qZr8nEuIbPW7JZI=;
 b=Lepwam0PwVlJ4PweJC2i92C5Ir+hAwt6oRRTzWdIIYL1ce3xkCkkzX6hZ+dGOcLMPm
 HrqjGJqaqOBU3WyfbpGnhDaBiQEBtG1MD39D5mCbPPjjTn09jCm7VTvjITj2a4Au72ea
 oFpIFebr1COsFr4dTHCOko9DouSRgGMEGAl7cAvivmG3q6CHTJ77aP/Z0ffxwVSLiatF
 fCBDTzcK37kVvqC3y0tV3BlMHspi045lqxoXxUOykcj0dujfuLzmGmNzfhX0y9s7XpOi
 LcVYo8qbjRKiPd7tQVs0APhwsW8Dah6alEAD5cAFzfRDZS9Stm5+r2hrMAMaQE9B1XNv
 8dJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGptG5BkMc7C87bjf0S4PEtVi/UZaWfGCjCF7gz86+IAkmWge2ioyM7GUHitpENLK+gj+xp5jDwItp@nongnu.org
X-Gm-Message-State: AOJu0YwcrsoHx08UKrRk3dXsI246foE08XHOjqU9yCSvnjQ8v/hxMHBK
 fbux9odMC1ne/L3FcFJ+Xxpr8gTowecrXPlj/ck4Wm9TbZl9xOM13z702ZgVm8OfN6WWSQucHah
 Be31iYbibEKWPq9HRzaK+9LQgafAxKjNbQw2IIjCLX3U2DV1HRt/ca2yL
X-Gm-Gg: ASbGncu81wCCmC00Zj4yqcgd17et8sS8MC3LcceOI5oUUExoDrfoS1gbTNYx2qh5h97
 F4O883ZIKIwOwxv02oNFOmcy4SIflEQrOZ3WYS1mKbSYq7K3xslJHusTbQErgMO53lpeYRiGE5D
 tQ1mXzN1XA/EUb8SRNUF3IjHo7yc7cPorKi42M73Y1qBq63gXnlwYS8K0Z7E8Nx+gibVkZ3cv4L
 udkokgQ3b+qgmyuQv6IZBh3QDGt0YLoULEbXAaZHWAKkQxr2kusH09bqdEQuZvqPF0E38UGC3Xm
 CMLx1xJpckSW4KxUres3sbyGAL7XJqLjx2wRRKqS/oXFacndsBdk8Nsn7RH8Y2orEcyy4A42
X-Received: by 2002:a05:600c:3b9c:b0:477:7b16:5f87 with SMTP id
 5b1f17b1804b1-4777b1662c9mr31739875e9.0.1762772499540; 
 Mon, 10 Nov 2025 03:01:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETXE577tyV5v2HtfZ8K2WD+7tuO0M2r90R/ivhHw/W6QROlyOQpbkhXTpRxL99b2Q36p53kA==
X-Received: by 2002:a05:600c:3b9c:b0:477:7b16:5f87 with SMTP id
 5b1f17b1804b1-4777b1662c9mr31739425e9.0.1762772499064; 
 Mon, 10 Nov 2025 03:01:39 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.171])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776bd084d4sm244532255e9.14.2025.11.10.03.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 03:01:38 -0800 (PST)
Message-ID: <2657323b-6172-4795-a3b4-f98f26262daf@redhat.com>
Date: Mon, 10 Nov 2025 12:01:36 +0100
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
 <09faff84-3245-4704-aab6-e7cbb76e1130@redhat.com>
 <89a7f911-4d50-4e03-a64e-b11e866f3bd0@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <89a7f911-4d50-4e03-a64e-b11e866f3bd0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 05/11/2025 20.21, Zhuoying Cai wrote:
> On 9/26/25 8:38 AM, Thomas Huth wrote:
>> On 18/09/2025 01.21, Zhuoying Cai wrote:
>> ...
>>>    crypto/meson.build                  |   5 +-
>>>    crypto/x509-utils.c                 | 423 +++++++++++++++
>>>    docs/specs/s390x-secure-ipl.rst     | 165 ++++++
>>>    docs/system/s390x/secure-ipl.rst    | 181 +++++++
>>>    hw/s390x/cert-store.c               | 213 ++++++++
>>>    hw/s390x/cert-store.h               |  39 ++
>>>    hw/s390x/ipl.c                      |  62 +++
>>>    hw/s390x/ipl.h                      |  27 +-
>>>    hw/s390x/meson.build                |   1 +
>>>    hw/s390x/s390-virtio-ccw.c          |  52 ++
>>>    hw/s390x/sclp.c                     |   2 +
>>>    include/crypto/x509-utils.h         | 131 +++++
>>>    include/hw/s390x/ipl/diag308.h      |  34 ++
>>>    include/hw/s390x/ipl/diag320.h      |  91 ++++
>>>    include/hw/s390x/ipl/diag508.h      |  38 ++
>>>    include/hw/s390x/ipl/qipl.h         |   7 +-
>>>    include/hw/s390x/s390-virtio-ccw.h  |   3 +
>>>    include/hw/s390x/sclp.h             |   4 +-
>>>    pc-bios/s390-ccw/Makefile           |   3 +-
>>>    pc-bios/s390-ccw/bootmap.c          | 107 +++-
>>>    pc-bios/s390-ccw/bootmap.h          |  11 +
>>>    pc-bios/s390-ccw/iplb.h             |  96 +++-
>>>    pc-bios/s390-ccw/jump2ipl.c         |   6 +-
>>>    pc-bios/s390-ccw/main.c             | 111 +++-
>>>    pc-bios/s390-ccw/netmain.c          |   8 +-
>>>    pc-bios/s390-ccw/s390-ccw.h         |  19 +
>>>    pc-bios/s390-ccw/sclp.c             |  52 ++
>>>    pc-bios/s390-ccw/sclp.h             |   7 +
>>>    pc-bios/s390-ccw/secure-ipl.c       | 781 ++++++++++++++++++++++++++++
>>>    pc-bios/s390-ccw/secure-ipl.h       | 212 ++++++++
>>>    qapi/machine-s390x.json             |  22 +
>>>    qapi/pragma.json                    |   1 +
>>>    qemu-options.hx                     |  10 +-
>>>    target/s390x/cpu_features.c         |   7 +
>>>    target/s390x/cpu_features.h         |   1 +
>>>    target/s390x/cpu_features_def.h.inc |   5 +
>>>    target/s390x/cpu_models.c           |   7 +
>>>    target/s390x/diag.c                 | 555 +++++++++++++++++++-
>>>    target/s390x/gen-features.c         |   7 +
>>>    target/s390x/kvm/kvm.c              |  34 ++
>>>    target/s390x/s390x-internal.h       |   4 +
>>>    target/s390x/tcg/misc_helper.c      |  14 +
>>>    42 files changed, 3488 insertions(+), 70 deletions(-)
>>>    create mode 100644 docs/specs/s390x-secure-ipl.rst
>>>    create mode 100644 docs/system/s390x/secure-ipl.rst
>>>    create mode 100644 hw/s390x/cert-store.c
>>>    create mode 100644 hw/s390x/cert-store.h
>>>    create mode 100644 include/hw/s390x/ipl/diag308.h
>>>    create mode 100644 include/hw/s390x/ipl/diag320.h
>>>    create mode 100644 include/hw/s390x/ipl/diag508.h
>>>    create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>>    create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>
>>    Hi,
>>
>> looking at the file list, there does not seem to be any test in this series
>> ... could you please add some functional tests to make sure that the feature
>> is working as expected?
> 
> I’m currently working on the functional tests for secure IPL and have
> encountered a few blockers, so I wanted to reach out for some guidance.
> 
> The main challenge is determining how to provide signed components and
> signatures within the tests. In a manual secure IPL setup, we would
> generate certificates, use the sign-file script to sign the components
> (stage3 binary and kernel), and prepare zipl inside the guest.
> Additionally, the signed components would include Secure Code Loading
> Attribute Blocks (SCLABs) appended for further validation. These steps
> are difficult to reproduce in a functional test environment.
> 
> Our current idea is to create a bootable image using the SCSI scheme
> with a minimal boot map that includes fake signed components with
> hard-coded signatures (and SCLABs if feasible), similar to the approach
> used in prepare_image() in tests/qtest/cdrom-test.c. However, this
> approach is more complex than expected, and we are unsure how viable it is.
> 
> Do you have any suggestions on our current plan or other recommendations
> for how we might approach testing secure IPL? I’d appreciate your guidance.

  Hi,

would it be possible that you create a real small qcow2 image (e.g. with 
buildroot.org), make sure that it gets the right signatures, upload the 
image to your github account (or somewhere else), and then add a functional 
test to tests/functional/s390x that downloads the image and tests the boot 
process with it? I think that would likely be the best solution...?

  HTH,
   Thomas


