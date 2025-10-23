Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFC4CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC141-0006Qn-Oz; Thu, 23 Oct 2025 15:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vC13z-0006Q9-HB
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:33:32 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vC13x-000780-7k
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:33:31 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-63e10cd6efeso1327652d50.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761248008; x=1761852808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d94ECx0P+rh0kR5NeaIkySJY0SymIoCwJcIDQQgYalo=;
 b=lkNh+XgegMRKk7J4mUTaWaykLxlWiMcSyTPQjVjpnccAfOtGncRvg0ADJxTvsWRDx4
 NALBB8ymwD6brHy9BovLtCGBPTig6IxHWjPwHZpVt1031WYI4VTYnujEJAeEihbRjASu
 D0Ae0gB5t20rLbLims202LbxO4fzEfGR5U2G3wtWDXc0BSBXzU1ZHLdJjmaN3VBGaLCg
 GItLzzsBadyWnPGih4ys3A2fqHpxDj01CHxXemmxHIicnQUEb+RtqLouNi2NLc/dDjtb
 qBbmdMZlqvPZhScgw9+TwFAY93efkKuVmvgoFnw+3yUPSlnbd52Msocy34KwJRC0ylK1
 O/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761248008; x=1761852808;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d94ECx0P+rh0kR5NeaIkySJY0SymIoCwJcIDQQgYalo=;
 b=tD/slG0ouQorRndCYZvqb7t6lfc3UtAJR/+cXaXJlRLxRViizF9O93dezfWWgSkTdJ
 BW2TKAsj70/AJP8BUi3rdtoMOwJoz+RH4MpT8eOSZF3M5/vkEAWCsSxEsP6kNVUlJ3Jm
 h+GHchv+UffNkGUu2RtYmNVaLf4BByqG4uG4pQvNchzIBaL9YInX9EfFHEoBECRa8aCE
 wBVM8J24uEPNivSrl7pYE3N6FOWudUWmpr0mOl9QzYMMBCjIR6hKiXnom7Nxq8SZ4/3o
 GORYnkftskE/JhsgV53l0oL0IqJD7oMqpjcqxFODcpCHYiVs2oQNzWxwjB1MKTJKtPMK
 Sc+w==
X-Gm-Message-State: AOJu0YypNX7raPx4Y1GZuXXtMP9snJbv2MUPA4kvKeIdhyfKaETceWFI
 aryD9BRaQ02AzB2E/VOarlleN77KBDaXUSDxNP2GtIgCheXkuETUfyNDpvF8waCGFmGohOOacVX
 o9uhZ
X-Gm-Gg: ASbGnctebz67IMddMI0lv7j1VPiOes+/T+jdr3Tc83tmO27HZRZcKKApFhykCGhhiew
 dZ0Dm6CNg4a2ScU9KbEhPUbxpkkALmOVQOToMArYU1U7hsnkTQ9hH2NdEdw1yQKrL7Lgl/jEhS5
 ehvrxFdb6eehUSB6fHZPAds6a8B3lVcExNbPY1N45F1REf/9emu83P+cSRsY/6C7XnZnQ4bqZXu
 XKPKI6l7zc/Bvpeg9y42aDjVDffe8iLftRHcsFajBhN+cE6ieenGZUgRskhUkRxx6NOoJQh5y3R
 2/IJezWstlrn+kbnAMx+f02ZxZLySULXgfl/2gPayb90tllGAG62O5nEEoHYErtZl21qDIvNQl/
 0mxVWty7+wETiDH4AhdkmOGKT60yycOS96tZUEwAH2ZTTgkWkEY9DsQYbBemq6D4+A4zlMbyrsM
 W3+zjXbGv55fZFuebEUeO96JU+LcYBoY8PaWdOqQNETm19yaw4jbCEe6au6w8W1RYk+D/Bgws=
X-Google-Smtp-Source: AGHT+IGaw4GM1JiN6ZKOVe6OFvKWLg2RPSqUzxRJMQuAyjFGBG1Gqa2WvlWjYJiQOJUGBFwKDxsBeg==
X-Received: by 2002:a05:690c:360c:b0:783:67c9:6d6d with SMTP id
 00721157ae682-7836d364120mr426748607b3.61.1761248007811; 
 Thu, 23 Oct 2025 12:33:27 -0700 (PDT)
Received: from ?IPV6:2607:fb90:8ae0:85c9:1b89:4cd2:87fd:d3df?
 ([2607:fb90:8ae0:85c9:1b89:4cd2:87fd:d3df])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-63f378d948bsm902017d50.1.2025.10.23.12.33.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 12:33:27 -0700 (PDT)
Message-ID: <23b07c6a-28d8-4bc9-8430-c495ee07e7a4@linaro.org>
Date: Thu, 23 Oct 2025 14:33:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL RESEND 00/32] ppc-for-10.2 queue
To: qemu-devel@nongnu.org
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb132.google.com
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

On 10/23/25 07:16, Harsh Prateek Bora wrote:
> The following changes since commit c0e80879c876cbe4cbde43a92403329bcedf2ba0:
> 
>    Merge tag 'pull-vfio-20251022' ofhttps://github.com/legoater/qemu into staging (2025-10-22 08:01:21 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-10.2-d2-20251023-1
> 
> for you to fetch changes up to 3db841bf1194b2720a08df2ee0a6ca517091ad0e:
> 
>    MAINTAINERS: Add entry for FADump (pSeries) (2025-10-23 17:37:42 +0530)
> 
> ----------------------------------------------------------------
> ppc queue for 10.2
> 
> * FADUMP Support for pSeries
> * Pegasos II cleanup and Pegasos I emulation
> * Deprecation of pseries 3.0 up till 4.2
> * Coverity fix for amigaone (CID: 1641398)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


