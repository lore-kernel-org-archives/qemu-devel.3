Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C09C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqeza-0000wM-1i; Fri, 07 Mar 2025 16:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqezR-0000v9-7Y
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:12:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqezO-0000Zv-61
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:12:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43bc0b8520cso14278885e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741381932; x=1741986732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l64+I2Ef5txlgYNJJZ7ulgkakQ+zvNIWx2E9yaYadXc=;
 b=MjHOQd8gxaZFqTWnb83lac9Lj7d6ohvBPB/VCOMCm1VmjAnVJ0/59vtVeyXdDjbfef
 /ZUf5vZt/DEbFZxEMBgsoEVvvIlnkYJta+mp/5XCFA+jQKbrP0StojYeug6uLNhiz6L+
 DOIf5Il748Avj/ooBlBc+XHCqVGs1nq+7YhtpSxhDNxJSBzA42CHjo4cDcPkXXJ4S+aE
 urIqfiD0GgE9Mo9Mi8A1c8kRzekmVUNPYfTmOYj8QqJbB5Gc7iCteO5b130zQ8Q/88Nk
 IJXKpvgOuHPtZCrgIoyo/5W7zmhoG9cH0Mc82KjkvAuKimtO+gdEb3jAcddUi1A/cV4Q
 /39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741381932; x=1741986732;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l64+I2Ef5txlgYNJJZ7ulgkakQ+zvNIWx2E9yaYadXc=;
 b=wtQykqYddTUrgt4qJL225HfAQQkwDqeSzWcfks3xcFCiLtanvEDraYKGAhocnG72iH
 Z/ymJGt8U+L4auZU3f2q2pmR8RaPFdK7F4AxNVgfqLKjZ5UmyeRAGTrVDN1lEyDSq/AC
 RxCIPg28bIb5Gu8gvC/segliMPOO/b9DFpwtIA0zSdPlK+MsPNYil391dVL2uD2Kd8cq
 6Sfwya/nbsFynE52EE921VDyoZqiK+b4SklVgtKjdFA4aAWdSIljeDhyfwQ1YdjMCbNP
 w5K0HW+yBqogsGLGhjQmSrDOXMjPne2bZkmF3mTmS6NZwMvs79r+I+XNDCQOZiod1noh
 UNZA==
X-Gm-Message-State: AOJu0Yyj8HFUZuYplnKq4UPb8T7ZfcZWDAUmf6RgIgmA6NByayld0z/z
 RhTrYYEtFPSddt49VMvdaDSbIOxRkGf8YNfhIsba2JrDhN3DvhQtWd6taK4WJtQShFSr1fa/rbH
 s8ok=
X-Gm-Gg: ASbGnctbd5NX4ba6ULxWonq+rXjtC+rI/bTpytsaDyA5LsnC6okXdMsbGw3RvDpyIIT
 9WM/5Af3t/icYnKZhIgEMHMM9MR7sJ+HeHxirB9UdPuw2FUgBoQPMKxHhXgIowX7Ol39ocdOAee
 c6jQmp38MnhxYUBR60w4SrgDb49JK+x2OgsaekfYwQUPtOybNk3mtmEsQfH0muLIAS/EJnhkXy0
 /FznQLhssbNcppnktN5vX5H+eKe27w9vrqxyIy0fWu81r7A6h36bAokMjlugMQ59elx2uXcrcuP
 +E9MsA6aLfATQoLIX+0n/Gyv7oBu682hofqP7/EGRLNuN7xf6FWLCBxj8CuRpdroPk2y4fiHoXi
 c7n/24AQFBnqg
X-Google-Smtp-Source: AGHT+IGMHinE/FosS8DiGLzc8NSoY80Ag05j+jkWNdrl93TrEoYsCnm/CTh9yxyf5sjzV/B5gSbRjA==
X-Received: by 2002:a05:600c:1ca5:b0:439:9b3f:2de1 with SMTP id
 5b1f17b1804b1-43c601e129fmr35212005e9.15.1741381931945; 
 Fri, 07 Mar 2025 13:12:11 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c6f4sm91146665e9.34.2025.03.07.13.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:12:11 -0800 (PST)
Message-ID: <083ec6f1-dac6-4ef1-8c4a-5d8c399154c3@linaro.org>
Date: Fri, 7 Mar 2025 22:12:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] system: Declare qemu_[min/max]rampagesize() in
 'system/hostmem.h'
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-7-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307180337.14811-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/3/25 19:03, Philippe Mathieu-Daudé wrote:
> Both qemu_minrampagesize() and qemu_maxrampagesize() are
> related to host memory backends. Move their prototype
> declaration to "system/hostmem.h".

   qemu_minrampagesize()
      -> find_min_backend_pagesize()
          -> object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)


   qemu_maxrampagesize()
      -> find_max_backend_pagesize()
         -> object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)

Having:

include/system/hostmem.h:23:#define TYPE_MEMORY_BACKEND "memory-backend"


> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/ram_addr.h    | 3 ---
>   include/system/hostmem.h   | 3 +++
>   hw/ppc/spapr_caps.c        | 1 +
>   hw/s390x/s390-virtio-ccw.c | 1 +
>   hw/vfio/spapr.c            | 1 +
>   5 files changed, 6 insertions(+), 3 deletions(-)


