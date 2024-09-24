Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EE3CF9C6C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 04:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stJR0-000395-7W; Wed, 25 Sep 2024 00:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1stJQx-0002yV-Fz
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 00:15:23 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1stJQv-0003Qr-Ss
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 00:15:23 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8a897bd4f1so921005266b.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 21:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727237719; x=1727842519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o04QcM8aD4YgLfalQRy3IgJO//9a3lI3E2/E+NIlF4o=;
 b=gDmeUW9HLw/bt7K43T7/ODT+9ZHka7Cn2851hIQvs9vCG22Z7wHqJFkZb7TegntKnU
 ARM1XxTzWL+kPb9HgIE224t1cL0vjGzpmF4OA/kFn2P45LFA/8o3kQUXWU+twWwp35/2
 otzWoovhpjtUcs+bpnGYYwd+lZaZiT6SAoAffx+43Zjfs7O7Wf/+ohwaLR/lPucoOIT4
 QD0GrqkgO+q8bKDTaZDpiiDaQ+fJanvc2L4tp0JFgPqQcXZYoLIp4479ELa2WGPyDiAL
 Mc/cp1cn0gakdEDFOOlZ/kGJrqT04qnEdTzCtPumOKSSzNnMu9nGNPoo9qDKUr4SzL/y
 qTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727237719; x=1727842519;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o04QcM8aD4YgLfalQRy3IgJO//9a3lI3E2/E+NIlF4o=;
 b=CzP35dSIfjLk4/+Gjp78FZ5LgNsqD9gHiTtjcYJaT/XjTcl+TlAVGJ/tz6EZ9qPRDl
 I1C4hJOHSeJLMJGamzCPjctRA1dF8udtB0Hp5qvv2UgSAWldZcraj2jgq6jG+ecFicEc
 mnnZ3BN265KMH/X0JHQ6Po7zEH3DdwL7yBaJ5xb+6pORCqzsZfPSo//eBC5PyPrvgCPd
 8GiQeu/YXbGNLTRpBK+/k1b1G3grLVYgrh4uRFCrzqTgq7FNOSNNcfgr9GZaaHrLMvIc
 mcescr1RpMGtMB41zlc5CX/4DmsrGQ1YN46lEGnyojmdKjSCk7ojt5TKEDrfwXs2e37N
 1HKA==
X-Gm-Message-State: AOJu0Yz+mQwoFL7rrwFpRoTBn8zI0D31/SiT/efq49igOdDvqVmLH5yO
 PHErRHm1JIdqDlXniNEbXMyQ8PHejaVhSKhhvVEsrCGRNWOXGc+kY4wl2f8ZnwA=
X-Google-Smtp-Source: AGHT+IFWN2AEJlWgi2i+9otuG8VB8kjY/7J3TWm/1FXXUe6KugOlcojGlKTdI3YCDPtVrcddzGl85g==
X-Received: by 2002:a17:907:25c5:b0:a86:9d3d:edef with SMTP id
 a640c23a62f3a-a93a03421b2mr130028066b.12.1727237718232; 
 Tue, 24 Sep 2024 21:15:18 -0700 (PDT)
Received: from [10.3.28.97] ([178.17.6.11]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7911sm166511066b.172.2024.09.24.21.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 21:15:17 -0700 (PDT)
Message-ID: <8c7ed3d0-15c2-426b-baf5-304a984d2559@linaro.org>
Date: Tue, 24 Sep 2024 13:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] Stop all qemu-cpu threads on a breakpoint
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240923162208.90745-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/23/24 18:12, Ilya Leoshkevich wrote:
> Hi,
> 
> On reporting a breakpoint in a non-non-stop mode, GDB remotes must stop
> all threads. Currently qemu-user doesn't do that, breaking the
> debugging session for at least two reasons: concurrent access to the
> GDB socket, and an assertion within GDB [1].
> 
> This series fixes this by importing pause_all_vcpus() from qemu-system.
> This in turn requires introducing BQL and a few stubs to qemu-user.

I would have expected you to reuse (some portion of) start_exclusive, which is already 
part of qemu-user.  Is there a reason you chose a solution which requires...

>    replay: Add replay_mutex_{lock,unlock}() stubs for qemu-user
>    qemu-timer: Provide qemu_clock_enable() stub for qemu-user
>    cpu: Use BQL in qemu-user

all sorts of other infrastructure?


r~

