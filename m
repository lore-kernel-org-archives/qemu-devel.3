Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF56AC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 10:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl3Sb-0004tl-4F; Thu, 20 Feb 2025 05:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl3SZ-0004tL-9y
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:07:11 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl3SX-000249-H7
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:07:11 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4397e5d5d99so4146775e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 02:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740046028; x=1740650828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RI1jv+irFIIOd7XokVf+EABviwKqcdwfpuXISrK4264=;
 b=x3ylRnTvJI90wTUnI8s+P9Xi+Or1rjY8DUrwWJrc90hnEdve9beyC8l4OhdXVa5kTq
 GwP/g7KJBkzIzhMy+/hcJLQKYVC21Ox/+SCCn4vhQZXO9F0clHILfz3y+3x4bdtJFZfW
 XGBQ2O+gZfEyogUXO8TWRqx2aaQMvz+SEb35jmP2b/DmZTQOl3k76dQ04wFlRLTS/hgT
 ITBhiKaYAWJZFqE04jJt+cmG/R+j4FJU4xlbeERrUIxra+VADJqjU39r8o+FLja3PoQX
 Zc35Hmfh0HDX07NZIPTPECI/1vSX1XlA6QAFemW3rE8dgPM1ctSKdnKNT1pQD4+j8D3i
 5Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740046028; x=1740650828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RI1jv+irFIIOd7XokVf+EABviwKqcdwfpuXISrK4264=;
 b=U5N4kU1E0XOiYJRrEfvn5/pJhS1W8Ak1xLuA5U1/DPyFuKjxiIaxqmRMa5gw5JYG4N
 YZfDo8EGOwaHfPCzJxPEF74nlp17VoCViCiNBiAmeizjLUl8yzJeKz3WWMWobQ7v3Cw0
 fTObv+9dtLGgeOo+WynvxLfqIytcRBlz/Kbto3EqAFZLn9u0bJxCh6ZmbzEYuAMB3/Su
 /x+PKra+zhR5fvtjIeuOcEnY45ts2Yip9fonVFHQLc8bGopxgquSzueYPg31CdL6yFrD
 isKpY0+qpksC0EfofgD7FCzct1NhRLrSCDkLVP/eS4en5HFaQzGSWB7IJ12LBaXgoYA1
 INcQ==
X-Gm-Message-State: AOJu0Yxq4wh1LxtS+hYpOFwpFBo3IWu1YIMuKKsbGcrRK4ZaJ93WHxQy
 aklUNwyGzFDLp/2eK9MJfSYFPFOgB35mGekeEf4wsOXgTriCl9o6e951RkQWcO4=
X-Gm-Gg: ASbGncvm9bpDDMRUxjf20gOjb6Bhi3ABv/RtVBb7Mw9dW8It1l3+SIRinkxzkgOgIcL
 Ao6NaG0AcqLsdZx4SE9mIeWgr6vHQ3Wi8ae1p1tIw1uBfh460t35zT1ISW4k2E7W/uR8qQhYpBU
 UGhY2rvtIk39U5khNPlSALthFHCMMVdedq3ZIQTBgNcc/rZL6jYq3UwD8kNOY6IQasiAJmAqBY3
 vsOFum33cTYdK+ZE+nzVPdVxsCmoPcbyM16YeCcvAvDlvRMn5qLSJ9ePQA4+Nn6LC2ZX5pAKoJe
 RFDTaiOAnV3hbxcUyj9Oaz+ko1TVDgtguGFdMOcQ2692uAN5lGY3VdbRCLM=
X-Google-Smtp-Source: AGHT+IFipjLuHx6LzH4Zdfi7PtMt5O1Sv49H1bJNbsbwEXldqaFTdJ4xQLMr8fgixvxSiZHC05jFMQ==
X-Received: by 2002:a5d:584a:0:b0:38f:24f9:8bac with SMTP id
 ffacd0b85a97d-38f33f46b95mr16831417f8f.23.1740046027663; 
 Thu, 20 Feb 2025 02:07:07 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f85c2sm20839456f8f.91.2025.02.20.02.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 02:07:07 -0800 (PST)
Message-ID: <9f92521c-419d-498f-813c-083f3728617f@linaro.org>
Date: Thu, 20 Feb 2025 11:07:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Qemu-devel] [PATCH v2 00/11] chardev: Convert IO handlers to use
 unsigned type
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20181012002217.2864-1-philmd@redhat.com>
 <20181012082011.GS16720@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20181012082011.GS16720@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 12/10/18 10:20, Daniel P. Berrangé wrote:
> On Fri, Oct 12, 2018 at 02:22:06AM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Paolo,
>>
>> Here are the changes you suggested in
>> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02294.html


>>    chardev: Simplify IOWatchPoll::fd_can_read as a GSourceFunc
>>    chardev: Assert backend's chr_can_read() is positive
>>    chardev: Let chr_sync_read() use unsigned type
>>    chardev: Let chr_write use unsigned type
>>    chardev: Let IOReadHandler use unsigned type
>>    chardev: Let IOCanReadHandler use unsigned type
>>    chardev: Let qemu_chr_fe_* use unsigned type
>>    chardev: Let qemu_chr_be_* use unsigned type
>>    chardev: FDChardev::max_size be unsigned
> 
> s/unsigned/size_t/ in all these commit messages, as it looked
> like you meant 'unsigned int' with the current commit msg.

Sure.

Paolo, any blocking comment before I fix the bitrotten places?


