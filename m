Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64519C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqeOQ-00013q-Cu; Fri, 07 Mar 2025 15:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqeOO-00013B-0K
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:34:00 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqeOM-00007o-6L
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:33:59 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2241053582dso19028835ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 12:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741379636; x=1741984436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DqvmzeC3dqWjPhY0E5gdkFzaEXH80M0BjcR5kArn38U=;
 b=apr/0spSmA53Al8fO5SOM9fDsBhhB44OGLPc9q/ihfd+5xc2YWoj0tsU7XavD2AEC2
 WilOX+jucqF6oDSRF1zsJVIe5E0i2hRQCxc0nym0y0Lb1FT8gsxwXSk2TXDgjtPfygYG
 9mw8mux5rrFzH8b49KSqVf2o5nGvwLbM7FPQYk8W4Q1hzkgWlNPjL58gLSWvGwLQt1Lj
 kT2etAx3yrN+k5/I9qVEXnYjotKvS+QE4EHFuGH/web3U2oQdWmTfnkjXe3YcYHM5A+r
 mL+/3Wg+Ixf2nQPXiPf3Lk274iEpnJ5sFZn3nzGAXzt7CJlvXNon76QdxibONRdEXA8c
 ne/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741379636; x=1741984436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DqvmzeC3dqWjPhY0E5gdkFzaEXH80M0BjcR5kArn38U=;
 b=MXYjb97ckHedZSLjWhMF8N4tcCE+tntM9nnpfZgPCtuT8u2JL2BeP0/tMonLdrXZdk
 yQryJmEPNPkqBhotEccTBMhdf8Ac/YdQi7EOaT5ODuqQnO3N1AjWCIExP9BYURlgB1Wr
 zfDMhr7ypViqOFbW0RapaPeW2vzV9gSJrUhEj2pg1rJioXbNWEHJjMo7Jz6T34nTQyxw
 tlGgjO4lglArc/v9Eu/fHYAGS0rPUzD/iZuB+SNZWCaPo3+Tuw2E4RybVabTGjR9c4Dp
 a/rn0I3Yq+G91RLyFGV4+mBhMdgejlxHuiFz/cb0BKrK9rH8AJuq8TUYLlKRhDy9YAS6
 40bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUseto6MqMQAa7Oj+jR9x0mieEKOCRBbrYvNps+nbtKre9y8e3vTsPtfWLCpbFuswSBGovClwPi1FYP@nongnu.org
X-Gm-Message-State: AOJu0YzeRS6C+Vnm660uuJ19+1nt0ANXekm8YxA+eBiDQejZigIpP4qA
 Fy60J0RavxyhFUNWzOoPw7QNLg2dXewrV8l5rJr3cvGRZzEcgjkpP8bSVNhE9TYFKSXcqO8sZ6g
 p
X-Gm-Gg: ASbGncuZyZQcCjbCvpUApwPzWoLprPsH9GScy+EldXRlfR+MP8/ib/WxMx+mqc3IwUB
 QHcF4nm1HbBm0wulrCsySjgTObBDamH+Lj0ZhzJNeWMgOlVJdnWkkCDNE5jD8bNfRPYhFPAozh8
 sunoEQZs0Mg69PFkweAxE1wgs9Jxawq+2ZGBzTdhjSh+sdniwMIN8m8pufPwmChcEFE4MIdY8bs
 k8wXcD66tSMMFiCl1GpdAQY4cRhr1bvhwHDEePvWEqHcdCPUVGTlKB/yaKbnm2pMHRbKitIk9MZ
 le8MAUt5QVhatjNpNt9pZkB0STc0Y2gd9kDYVUs8qTxNKpSiIxKUBLxDClR0IG8pke9Wqgs0mQl
 xyeFrF6kK
X-Google-Smtp-Source: AGHT+IFVSOmp/aJuvetomr62m36WmBYrS58W4NnZP1CwFinLZ6nHThz5Wcqrj++7bARIwQlORmSsxQ==
X-Received: by 2002:a05:6a21:3393:b0:1f3:290b:7be with SMTP id
 adf61e73a8af0-1f544c964ccmr8571330637.41.1741379636479; 
 Fri, 07 Mar 2025 12:33:56 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af5083d4c7fsm1575059a12.0.2025.03.07.12.33.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 12:33:56 -0800 (PST)
Message-ID: <1e7b5507-e226-44bd-afec-0261ee3549ce@linaro.org>
Date: Fri, 7 Mar 2025 12:33:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] system/iommufd: Introduce iommufd_builtin() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307180337.14811-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
> iommufd_builtin() can be used to check at runtime whether
> the IOMMUFD feature is built in a qemu-system binary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/devel/vfio-iommufd.rst | 2 +-
>   include/system/iommufd.h    | 8 ++++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
> index 3d1c11f175e..08882094eee 100644
> --- a/docs/devel/vfio-iommufd.rst
> +++ b/docs/devel/vfio-iommufd.rst
> @@ -88,7 +88,7 @@ Step 2: configure QEMU
>   ----------------------
>   
>   Interactions with the ``/dev/iommu`` are abstracted by a new iommufd
> -object (compiled in with the ``CONFIG_IOMMUFD`` option).
> +object (which availability can be checked at runtime using ``iommufd_builtin()``).
>   
>   Any QEMU device (e.g. VFIO device) wishing to use ``/dev/iommu`` must
>   be linked with an iommufd object. It gets a new optional property
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index cbab75bfbf6..ce459254025 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -63,4 +63,12 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                         Error **errp);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
> +
> +static inline bool iommufd_builtin(void)
> +{
> +    bool ambig = false;
> +
> +    return object_resolve_path_type("", TYPE_IOMMUFD_BACKEND, &ambig) || ambig;
> +}
> +
>   #endif

Interesting solution.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

