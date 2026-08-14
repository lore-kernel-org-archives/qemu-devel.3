Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420BEC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 18:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuwGK-0005Ar-UQ; Fri, 14 Aug 2026 14:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuwGB-00059s-VW
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 14:04:05 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuwG9-0004xQ-AP
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 14:04:03 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso2006763a91.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786730640; x=1787335440; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FoEeosqa2/i37onoWr9gmcc3wDKMx15tBxBVC66EVIU=;
 b=zIadNw6yIwphg2CSCkWlAGJFfe3gVK5C4O8xytLuA593kTE9wjVjBfQ+r/wRtNSVkU
 MzrOuiHTODVme0veew4tLGp6JBi15HyRBizLGZIm5znkS6xjcEmpfddaXGVbcTa7fHvt
 vEMRAfHzozsOXv0XUJfssBAxkCqWok6LI1CCx4TFgtO4n2GCK9/Onm6aSfwXhT77zobS
 KrH7nnFX5QWits811uXwmG5FK7IZZ6MDISuuzuHN2+g1DHDhNlTtPQRCgy39ArqA45ID
 HiMBlGtJtQ3imRX4I9puRi8DHeUSChpjSGQo2uptABgH+5NUIWL5M8YlNfLjg67y/r6J
 C3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786730640; x=1787335440;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FoEeosqa2/i37onoWr9gmcc3wDKMx15tBxBVC66EVIU=;
 b=W+4B8tbPUSm4I0018NDiKDlnQz2Aup3mysFV5TdWJh1+Qd9jdhGfjl2+dk+tsBkcq4
 /fHiCSK+mSuCigvGhMPcYmG27qXaDmU1vqYf+040zvmPi7gQNfLCM66RbYGulFtOxD0e
 CGHadjT5ncw4UYvuDJR/6JoSdl49qYShCp6wa7Qm2c+2aGlsYWdK6W95CbguE2H2950Z
 9YNocdFHP9v+hXt4pp4JCmXRTBJUbqwMqU1m8xEpmOPpoZrC1u9Kh0OaOLxwoUe3J+Fe
 9pvPvU4ij66mSpE0NzVXOSasv7co2wMQyDvt5shbuEChM92T2rSY5CFL5cVcgALdU9Po
 I41Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDFnD823fG4DrZ1nIlrGiPW/zSAyIHb5BGMAeGZ4yb2b1iqhLxDCAbKccGk8JAbopyj1F53kVoukYK@nongnu.org
X-Gm-Message-State: AOJu0YyrAqDVM9CWFjeyzEn/CPDlZfxegDjXVPbJ8WP/QLcRgHbRBmP/
 izVQATWfAtIDVtpbuY17R9f0/a38RadPtgGdKltGT/01HpGiF9PdKA08mUXEMUkTa5s=
X-Gm-Gg: AR+sD117vZEydJjaznM1hgttiJGa+TWpjA+UqVrWU4Ay4wfTeNfZ7O3qd79d4W8/cd7
 86nc5/zHCAn6b9BtVL/45Nwv4U/i0BUxUJXwFcqB4VGIGtPcF2z8/asVua/+V1jBlO3uVBjCJsZ
 GIYKJYlOUrjonrsa835u38qH5h9wP+oaBLyMKaDUrNRMMV9GxV2tNnkgENvTscTLiCmWSbIOm+m
 PqztQ2Sp1FM5Yv3AAmtawTnpiWzabvM9Oeqz/6ltPQ4VAAZBpr0utTKinXbRDwJDtupEtby2qY1
 ykkyVKrjQK4BO2vYdzVheQBoLRM0kIgVWbET81UCCXDqPdbN9g4cIDzCG+O8E8pTHkUydsEdVDE
 8C0mnIOJjkxnxaJcPxjV7i62zITKO8+hSajvB9kN8kYXH85vfXhGJD52d8yMEHPXjoiXi4fUDHJ
 7MOkZl3FxZ1a5FABGHVPV52IngEjMdnrrFoUdJKpg+DwwnzYWzH2Sm52dYfUxeQz/K7Cyv5QbR3
 JGgRoy8zILpzp3XA6gGzwKKXOZD
X-Received: by 2002:a17:90b:5745:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-3933b7a6986mr9595430a91.8.1786730639598; 
 Fri, 14 Aug 2026 11:03:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ebbcc34csm3441604a91.15.2026.08.14.11.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 11:03:59 -0700 (PDT)
Message-ID: <3b2fb487-b603-4d07-8848-a5c28c74ee5f@linaro.org>
Date: Fri, 14 Aug 2026 11:03:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] Functional test framework improvements & bug fixes
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20260814100917.163448-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814100917.163448-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 8/14/26 03:09, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 539bc315538afe036a4b99088659aa82e3b489f2:
> 
>    Merge tag 'pull-loongarch-20260813' ofhttps://github.com/bibo-mao/qemu into staging (2026-08-13 07:16:25 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2026-08-14
> 
> for you to fetch changes up to 4adfb431c0c3abd84909d1228b4954bfd68a1dbc:
> 
>    hw/i386/amd_iommu: Avoid undefined behavior in amdvi_setevent_bits() (2026-08-14 09:14:58 +0200)
> 
> ----------------------------------------------------------------
> * Some minor updates to the functional testing framework
> * Fix a guest-triggerable abort() in the usb uas code
> * Fix a guest-triggerable abort() in the vmxnet3 code
> * Fix a undefined behavior problem in the amd_iommu code


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

