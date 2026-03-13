Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FDC106FD6B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 03:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0t1i-0003UL-UW; Thu, 12 Mar 2026 23:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0t1h-0003Tr-Cv
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:17:25 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0t1e-0002g8-0h
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:17:25 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so1338472f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 20:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773371840; x=1773976640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x72ezNfguV1D5kcHdzXSnoxnpGHocVbCl/JVzvSwXL8=;
 b=sxPGTpMQDgw7RAD9C9mcNiGYkO73cUqmo6+Qf1bio1ewulPT2xg4iu2Dhsy9qqG7Pr
 EEdCRj7SUlSahriVA+/07R683z0Gfn8w1S43fz4+ZX3dQeO/W6OOtmZfhO6/n0WF0NGn
 Vx0K3fujqVBBkyZxAFLdVVEJyP0uZAEr7fFpwitpzmXsgph87vcaM7textej18LrC5z5
 /ogdcBmntlI8yBmCYAddCYxzNJoa7gCU8FoG5L2sXDlqZe6+sKZkvRWJkWTA1LtbvUrN
 RCP6T4Wf0TH07mJm/BodXo2VdyUTIW0zO2iK/d520UxKqlXphBtpzAP4LuRdKstgXdBQ
 qhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773371840; x=1773976640;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x72ezNfguV1D5kcHdzXSnoxnpGHocVbCl/JVzvSwXL8=;
 b=PD/jRvsGRP2OLX1hQJ3BPZMazqFcbEDMguyb7FlGQv9VfRRbTDFVmrlCi4bLTIy9YX
 SUg6m/+f/gLA1ePbho/ve0IqkWMKyRlZuETAvyvWqtDN6pszKmILqjJYwU1hpNBDGW/M
 RlsAkiMThy9w96UWCd5dHKYH6PP+szJuc9VeSmbI1Dix85NnCTNBhmKpVYPdypCWFnfl
 FOcwJubqfnA48cH+SNW8CujLWcJeMW5A2ldegZxQGMQlTX4Y7cwy5Qeul0Nq31mXorff
 83pv9Hxpc+E0nIfbozhDeEx8J49REMBi4c8C/2C8lrTzxsSTCj+gc5wG54Hdr9sdfeHE
 tYPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUj57538IXR9SvW3pVVYepuaybzygOoP4Nqj2kM0DrOVwZQGp7yXv8zn4U49MuV60VAiWp+B2m6jjx@nongnu.org
X-Gm-Message-State: AOJu0Yy7felDPbDtvCUCgFh4ObymakvQ1S39882lWyoLTkpXSZvLlShK
 iZjuLn5jVZxLnUHnYbtVpbDgK/2Z+lAvlzCKLuYghQyr8ziTgba41CeHnZ116AUFdBA=
X-Gm-Gg: ATEYQzwtdUND36i2XRofB0ypZbPTZi/znAkMS3CvV7L7bqjSWNU912W8OOayWfXN0bv
 DRhARv6umIDGNTiTP3r3oAdaFAa/rb5NuIsDkZ+yOnAMN3o8Ku+MP9gdk2mnkaP9UT4doL6FrSh
 DdQaGSX/rwB/nSkJWPbKulI5WjRM7o0kDTGjG9BrwA5xPNwaILXIjlzW5UudqgMua71cPnRx5+r
 HKmNGSD5egwHlFJ0DZ+bgtPBOLoP5dzUhZXPTQ/z/fsiOd5FT7rGt1PodQOa+5A/8/v4e5n7mND
 MhbGcYdga3YsBKuSeEyMTWIFJOFNc8riusYyr53SqDCvNjbzF6KLJTAHi8+RNGCZQFIrMg2fZ4c
 gJ70bi7AO8gUmaDLH+QcyfsUkbpK6rO7V0AqK8wjJCkB9+TEb2uBg1mMcQn5kc7/k3FIA9zGZOj
 wX054RmM2QKLu9tpZfSo02NSl9aCcIYrx4bKr4y7INVrn+n2nb8CI6HmCzKeY7tmg8cQ==
X-Received: by 2002:a05:600c:8489:b0:485:4552:8fbb with SMTP id
 5b1f17b1804b1-485566fab29mr23844035e9.22.1773371840363; 
 Thu, 12 Mar 2026 20:17:20 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f708sm398991405e9.11.2026.03.12.20.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 20:17:19 -0700 (PDT)
Message-ID: <bc9fbad7-073f-4828-bbeb-18abc271972d@linaro.org>
Date: Fri, 13 Mar 2026 04:17:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] hw/vfio/helpers.c: extract kvm helpers in
 kvm-helpers.c
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-3-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260312224449.1605071-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/3/26 23:44, Pierrick Bouvier wrote:
> Because those functions use kvm specific types, they need to be isolated
> in another source file.
> This allows us to link kvm-helpers only in configurations with
> CONFIG_KVM.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/helpers.c     | 172 -------------------------------------
>   hw/vfio/kvm-helpers.c | 192 ++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/kvm-stubs.c   |  27 ++++++
>   hw/vfio/meson.build   |   2 +
>   4 files changed, 221 insertions(+), 172 deletions(-)
>   create mode 100644 hw/vfio/kvm-helpers.c
>   create mode 100644 hw/vfio/kvm-stubs.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

