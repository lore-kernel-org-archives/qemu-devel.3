Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304BFC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 09:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWtVr-0007wW-5a; Wed, 02 Jul 2025 05:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWtVo-0007wN-9x
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:12:16 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWtVm-0007Ps-Bi
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:12:16 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-453426170b6so39758575e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 02:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751447530; x=1752052330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kFBWLajcalmmXrx/a1UaeBauyTYYBLmg9BJXhbcBxtU=;
 b=YOcmR2I9w1RGAvrFF9BcKToi5n/pWSSjzuleMVOOKnzYo7b7BLlsNGzUCRqOfjERPx
 qlHYJUsYfWYJSA/ZqIkjMVSG3ucG+aVDDgtevrZn6W+/OfLToOVhC35OjNxN8hpLJKSe
 P9Y/nOlZpbXb+2i0bzXtJ/IMnBF6EydTop5sq+Q241nTB+IlDXcPUJEkgV3Qq9FYS9U7
 Zw9ZSrtRUAgacyH37Eht8dAQoEUg1DiH0cIpBBjAqXiZDFJSErdBhQZT29vsvec5VBvu
 aDABaCt/+ZxlwqQp5lPiTm6iBg2viqcqePg/94Q4256KBJx5UV4x/BUIoNjHoTMSxBFi
 JX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751447530; x=1752052330;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kFBWLajcalmmXrx/a1UaeBauyTYYBLmg9BJXhbcBxtU=;
 b=Dt1pagZIWkddweyXi/7fuvfFax40KBWO2ko5b2JjI7QkE7BPY/xvRFkOEOCWGPSzEh
 Jt6TLGLhgdgXIHY7leo/APWmhTvAfETs7KaTgBdpmBZ5a/IfCUo4275gNdu0v2TaVvyT
 uOW4D//WeVtw4f3BqXWfOa8Dsq7IjlKvJMNwl0tVI7S4rO9TCe5wVYm/iN7aqnBiMveJ
 p7g6fakxh429bYbiTnKqxVaRb4SPm+zsTjy42Bqxl2qAku/Eq3uXWp45Qd3RQFoKSL83
 TuQSkM52C9SIfHMi4e5Xb2qPi3ov69Mn9mogDZmGZOyWc9+HaPp4mGq73Air5JWZzZ39
 mt/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgZfNU38f2VvbQDwDZrQRCE8NE/yvNQy5+Czc8fmYHF5Rzfjn25QxmM3z5ickdE8guZwf9LpdLM2H7@nongnu.org
X-Gm-Message-State: AOJu0YyTVz3MigiLnfjD0Ih6pZhH2gPLk6vk3z8ze9kGB4LqUaTf3MKz
 JRqfe/24NlV2jJuLRPAM7v4YlQxOL3fFIP9gG8CKlq1TwA63OxT6t53wxNJVZ2uQ7TQ=
X-Gm-Gg: ASbGncuqR6Qzf/OM3s3CQ/7QYJIsBLX3B8CpluKJT6wiLzZxWO3mfPNxlxHNPysytuV
 CY/jOTic0MKq0VJbx8u+i2ixdVLiiN5wdOHbCZmQwqWWsoTuhbEFiBzIbyqgWcy3Hs2eeLvZdzT
 EPtKhBig5LB+1FVF/rjd/FNMH8kpWt2XMrdG4TqYDiRp2vvC6AtgV/983TQQqJII0VFONEl4Zyg
 9e44nCkSqh+wIj9zMcC10NgDL9/2eGmfreTp4OyxRRpa5hcf9vpstFLYSkD/QCO/XSsgewRq9CO
 UN+5TQfUP5yO0/H1wdw0I/MRROziU0jCNgiHU3erif/nsKZOUegoB1XDrehvg/cD8MFWV3/wKVi
 BVETJRViMP181G3rBQF6nZdiT1ySurw==
X-Google-Smtp-Source: AGHT+IEvw67+QDLEMfYgM0ShPdp7SyTnTOfZX15HNJAs7ojrm9bY3KQsCgoHZ+cdrX0vfa+RxU0qCg==
X-Received: by 2002:a05:600c:1f90:b0:43b:c857:e9d7 with SMTP id
 5b1f17b1804b1-454a3c1e6d6mr18279265e9.5.1751447530288; 
 Wed, 02 Jul 2025 02:12:10 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52a5asm15686079f8f.54.2025.07.02.02.12.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 02:12:09 -0700 (PDT)
Message-ID: <5bc1b43d-764f-4f6b-ba1c-d929193abc50@linaro.org>
Date: Wed, 2 Jul 2025 11:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system/target-i386: Remove the sentence about RHEL 7
 being supported
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-trivial@nongnu.org
References: <20250702082138.23109-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250702082138.23109-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 2/7/25 10:21, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> According to our "Supported build platforms" policy, RHEL 7 is not
> supported anymore, so let's remove the related sentence from the x86
> documentation.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/system/target-i386.rst | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


