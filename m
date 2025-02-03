Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC926C0218A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tenPV-0002KX-OR; Sun, 02 Feb 2025 22:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tenPT-0002KM-Sz
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:46:07 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tenPP-0005Qj-42
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:46:07 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216395e151bso45801095ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738554361; x=1739159161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nJ+tVMMyIAxblgRQ/4c6VnjGzx3RqEHRGHW9bf9S7bs=;
 b=t3ph1Zs46NiON8hOQkk2yGo+IhiUq2bPNds/B3F2rnMcjK2Cru9tYol766aAFlmxwJ
 E4kuLIAfX4QtRrWwDFek4iBwSM6BkZecCpJ67GaLW9XcNXbfrIsoLO5cHwKJ3gWGdlqc
 oGLOnD61DUO6mzs/RiHuzgu8CFjNeGnt3fwZsX/P6AwWjdkEAve4+qQg9kD/MJsqIEwF
 Drnk7rchqiYSdmvrx+C7ew9RzbPDSXR+nzSj8Dj1d1TQBVJHi4YqOhR1AhAEMjrLzQwR
 O1NiO8PPwxaB9IKAnbeZoe1OjP8rIdmY5GU3Dqji4S8Col66goeejwcTkGBOdUbeVYx0
 zssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738554361; x=1739159161;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nJ+tVMMyIAxblgRQ/4c6VnjGzx3RqEHRGHW9bf9S7bs=;
 b=bTj1vbFJrgRhMZSHBlO7O8wzNUQrhuB4sjidx4FtB715Ao207rrfcHWFz8t1XDIZBz
 gyXUj2sYF1+sCW1qMN7Tcbo2L37BBSQB1Nca/VCcWMHGR/dHd8t9088RDuP9Fhnqdp1N
 d72LlATRk/54tNKSiabpSPOkKLGB5fnHsAi4o9i6sIH01S8FiThKQnGCj8SVoGJmMz3d
 2+lQf3F3Vh/MYerwU54T9p74mEv3rVIOosD+QFrGI9zSXPDZu+XnoqwbKTCNG0opz2Eq
 tyrt0HMfRUiNRMvSrgHNuYABDE0tadRuvunCaIMT3nUYwJJrk5JkqHH2vn9HfoKslucq
 iemw==
X-Gm-Message-State: AOJu0Yw2naqBoOCyaaGMhy0vF8M92DqwTxBByc2XxtgW0zUwxM/ySOEC
 n3dRFn1BNdKiiFg7O1m+OLxwaQv7pujy9NISRzv37A5K+3B7tKESCVLuOv1MkTOvHUEJpgKbRWT
 D
X-Gm-Gg: ASbGncvh6LE+4LhobIV4oUog8IN4RbVNJD+mCGxx1K9xx7QwWN/eAQvHpWWngEMx+LQ
 Owk5fboqRZTTGFZVMrH2PhY7/o2IxdiYAtZ1DhQArz68sQpBD9OVTHeEQDQ8m2R9sRMQMB8HrTD
 Llrr1OEPjJn/de4uRmkD9cA7xJp1K6rBii2XHY/UgrKYqhJnErkCDaD+gHmuxiUmdb3BKVDa2gU
 RhYWJ0Thf+WfjGWzy1KK+C3wIoGDZl3jRo2dZwHGldg76V2G93Sy0pT3GFiAnhrhrHY4rVbkVj8
 uWAyHi1N5qVRLkzsXBVUJoKuTZfMXR7iXP5LJoWB1LWK/2vZbXUOj6A=
X-Google-Smtp-Source: AGHT+IFrDhmgeX1FGrmYWMkGeltjrrSSjkIzPFzJeRnno7vrgQqE9WcfVfdpbg1BN1qnAAXNN3LOhw==
X-Received: by 2002:a17:903:120a:b0:216:3f6e:fabd with SMTP id
 d9443c01a7336-21edd7eafccmr183109155ad.7.1738554361332; 
 Sun, 02 Feb 2025 19:46:01 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f83bb9bf39sm10121727a91.0.2025.02.02.19.46.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 19:46:00 -0800 (PST)
Message-ID: <abbdad0c-fc98-4ec4-b69a-8d91dbd49554@linaro.org>
Date: Sun, 2 Feb 2025 19:45:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch: Sparc prevent segfault when dumping uninitialzed cpu state
To: qemu-devel@nongnu.org
References: <eb7fe8ed-e885-48c0-a36f-1f700bc692bf@laaksoft.nl>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <eb7fe8ed-e885-48c0-a36f-1f700bc692bf@laaksoft.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/2/25 19:14, Henk van der Laak (LaakSoft) via wrote:
> Hi all, my first contribution. I checked code style, patch submission rules and did a 
> manual test (details on request)
> 
> Synopsis:
> It's a corner case, where a segfault occurs when logging Sparc CPU state in a partially 
> initialized state.
> 
> No related bug report.
> 
> Open to harsh criticism ;-)

How do we arrive here with a partially initialized state?


r~

