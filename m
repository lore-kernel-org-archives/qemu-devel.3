Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5664CCCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 17:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ogl-0006J0-Ap; Fri, 17 Oct 2025 13:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9ogk-0006IH-1f
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 13:56:26 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9ogi-00042M-1p
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 13:56:25 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-290a3a4c7ecso23794995ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760723782; x=1761328582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G+vnCt7pNSgjiLmWX8u1exqmmC4Vinyf4pdLIaqQdXM=;
 b=SmL04AtcM9YUoXKhoUBt3NWF03SrwBCqPzb99wF91Ai3Y88tAWjmsfAw1FAf4X49rd
 UYz58Rf2uKWyikhxkoq1/lBC4+y7Yr1J98xHGLuOery8Vho7YpXyAYM03hhXr5WNq4UG
 kz06BWl1iJtYUVaPpJ7MxO9fMDLqh29QWnpXmUvVrKtEyR6aU060svjLWNV3G8dLYmXA
 ZJq24bw66lTB68J1RXNxyGOpU7Mpna9XvFKiwgftMrYS5Dcx9b7DEWqJoBIJsKA2XEGq
 8DnTKlBSKpCKosHg5fKEnnkPBkfj284kL+GecjrW06MQpXbUvvYC5abmFb66gFyRj0XN
 CGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760723782; x=1761328582;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G+vnCt7pNSgjiLmWX8u1exqmmC4Vinyf4pdLIaqQdXM=;
 b=Oiq5oNk959uWc+csoCLZt8pv+QcsVXNocEDG3w0oNKBx9zmBe3RNykZfXc0CC2lHVJ
 Y6mGqdlYC+Ea2ZqR8lab++cWQvF04VuuAFvZ/KZV4ZEoTWrCVh0KC5sgbi61d+5Kb2zM
 1we5m1raGFGdDGE9t49ftVRwHxw5iWjNy2oWVaqi2hGEj4D+rKFZ6yZOahoSZzj3QRyK
 VR1HSAWttznIhRUViol9UqIevkS9Z8UXwHz9vst2Md8Voo63fI46zmYW29XvpwChoWve
 DYJBidxVXdzt+7z9YjEzJAxbV9n8J8n98o/tjhyxsphMMPRk2N7zJBQiS6uCmW1cgpT7
 4E8Q==
X-Gm-Message-State: AOJu0YzDualH1b+lRzClJMRBiaTdCwFGvf039+igtmgX+rNMubb4CfDN
 +43xUjuld7yh/WxIEgWLf2G1AHe8ic367neSMNTRYq1loNZ70V6rBBen+8Knj6S+2s/mPT6lNPd
 xZ0nTDoI=
X-Gm-Gg: ASbGncsBtAQhYkmh7YKrqJUndJ/MxNtqlZPPAN9dkFezfdq3Qne3L3GgIz5v1TruAvJ
 vLHkiJWG4K3jzcHcDqpiVuGxmF0tNOGjYnid5L6Uoq7+u/eSzmqt0y6+CkhTAds66RXNSMsmevv
 SDxuFWC/OHeJIWCy6nyTIvqKJiXgzjfHkJzxJjPLCgIMqeBovYLePSjLd1u4n51pEOsEX10leDE
 WJbgIhBtg7TBZhsR2T78V7+bsXjInI9E+P98a7dDbuPn9h8jf1vdVv/BTCHmH2w07n0oXggr4CB
 R5PPy1U8AyxK3fAKgaG3D1+k1WOH+PpDktmUWC06AkGBhhDbm4r64qPyMyMuegTq+2/ciGrjVi8
 Qcpr/LxACn76YpOaFefkLzxRuuxCxiZXAu0pVGRKpiHKWLXYADI5yuWXXNzIy9Diethk1AlcaLX
 /KLllVMi7h+/pPURrFkCw3ElIA
X-Google-Smtp-Source: AGHT+IFK4+sza/MSayeHuF4ZkbxJbGaMzC8syKAzwNBOeka9TYMIUiwIPNJFuPPYhSADFFibKSAEFQ==
X-Received: by 2002:a17:902:d60d:b0:270:e595:a440 with SMTP id
 d9443c01a7336-290c9cd4b48mr55349065ad.25.1760723781639; 
 Fri, 17 Oct 2025 10:56:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292471d5874sm1161315ad.54.2025.10.17.10.56.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 10:56:21 -0700 (PDT)
Message-ID: <cc5e4aba-7d88-4748-9368-cb8845c82150@linaro.org>
Date: Fri, 17 Oct 2025 10:56:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] gitlab: drop aarch32 runner and associated bits
To: qemu-devel@nongnu.org
References: <20251016150357.876415-1-alex.bennee@linaro.org>
 <20251016150357.876415-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251016150357.876415-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 10/16/25 08:03, Alex Bennée wrote:
> diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml b/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
> deleted file mode 100644
> index 0cc34cd10b9..00000000000
> --- a/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
> +++ /dev/null
> @@ -1,127 +0,0 @@
> -# THIS FILE WAS AUTO-GENERATED
> -#
> -#  $ lcitool variables --cross-arch armv7l ubuntu-2204 qemu
> -#
> -# https://gitlab.com/libvirt/libvirt-ci


Had this file been missing from tests/lcitool/refresh?

There appear to be no more references to ubuntu2204, which is still present in the refresh 
script.


r~

