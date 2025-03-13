Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B5AC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 19:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsntR-0006m4-GN; Thu, 13 Mar 2025 15:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsntF-0006lr-Q1
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 15:06:46 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsntC-00071i-PI
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 15:06:44 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224019ad9edso36279825ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741892800; x=1742497600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2lCqlsM5gY+6rfzYzWKfFpeMTG5edwRquGqECgvsrFw=;
 b=gYxLo1Z10sB+1k/XOl5lDZw2r0ziShzVDghSsoJD9HB+hlATjKOKNZOpF13IKAjKN6
 H8OIpVYtZ81dBIq0mjP+W5ROYiHYrzUNZsx2jfZtb+XdjGo+MA7C2l1ph/en8+brnwAN
 gx9vbBWn2NXMC4uMXPrMXBtwXDUNgmncTMRho1fgT/Ik64HIwRWV5N46B0LxaPK/HHnB
 ZOU6VgRsKaqfuD+xCNG4jeLltP48aG+Kh/55Navvpp9bJMzGNnB5/GJ5PfYwckZx3PKg
 5TLq37Zq3vya0+RnyZboFzmcHPPmfWbmIdxvMgW0m/JS4nj6WSHeRbmjy3sP1U40FZyQ
 3X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741892800; x=1742497600;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2lCqlsM5gY+6rfzYzWKfFpeMTG5edwRquGqECgvsrFw=;
 b=X6l4ExrkWSoIqAD2APzp0XkflW7OADbsGhYUTIiOXfPvnuI7kiAiSMAnJJ5C0l6qd5
 itcrhNyseDp9U8j2JV1DplrTHq3Xy+BdsVQ9SssFaSBgez/qkywJnkfEJ4sJLcad6tr2
 sCX97ZyIFbp3ky7/29OQxMNwrj6bKDeiLt9XZ8JYyhQ/71eH9hxyv6kMx3Z7Z/hz6mdt
 QfzKFc2CVi2WsrllZJSmciGoY0ZvsAI8of/d4IBOEJN9LDwmRpBFTrgZtIP05K65Js3U
 WX+BI9n0EAzvxzC/gIhSOlF+mMFk4HvPNEWS4AzNasdLq3VlPGpVA31vE2++v23hXtcF
 +b7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfKkgkyKAE5NjfxtbgJnm29fUJ1dt8KWgQ7AGD0a7NGTMpLqzYQp+DCXXtTGEk3qc0JqLSXW5/05OZ@nongnu.org
X-Gm-Message-State: AOJu0Yzy3mbiWTAblgjIkasujtB/WXZ3GZelimX3XTsGkkqLYHrgqIs0
 cboZUnqBZXLMD4EjYWJkTL1g8u6nhuGfgobtFA9vWnb4WILTy1w28JwnY05bnNo=
X-Gm-Gg: ASbGncuxP+znRJup3FVU+ScPPYezzPQcbIptjNJrwWOJuQ5TQ2c3CgvCgs2OCxwaTS3
 mrSoHs2hBGynx7foWj9aiZmqzrKuTdjRjxlLqnq0/CiQT2/Yb66y+sdF2C2WnCXiigwhtyVUnD3
 sjvbVKxEIShMumLo+tZ6z1ontTIrJwmKV+vCCNaWRBG8EjTM9m762VWt2/YGUEcCuv8LpU6W1bW
 ifq544LLfFLFtQs9rt1Q1YSI1bSH13ST7vv3W9DcBNmafUCjI4d4jiBLFBnOidlUqlv+E/pqxKF
 nw5BbPgQ6tRMkwqvV0JgUjyJw3B98J2zXFv4jTVovTk0D8vezWXIBdMSpDZ+mewummNCNU7wNjW
 GzwxdRYvX
X-Google-Smtp-Source: AGHT+IFjSlxpvB+luzALZdp/EKxXLDUCIy2lLB/laJ7XyuwoN7UEPjz2VIRHElkMGM4FJGYZMtkwow==
X-Received: by 2002:a17:903:1a10:b0:224:1609:a747 with SMTP id
 d9443c01a7336-225dd86d12emr9502585ad.31.1741892800733; 
 Thu, 13 Mar 2025 12:06:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68883e6sm17062105ad.8.2025.03.13.12.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 12:06:40 -0700 (PDT)
Message-ID: <e1216ec5-c542-4a7d-a3d7-880e7e57130e@linaro.org>
Date: Thu, 13 Mar 2025 12:06:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
To: ltaylorsimpson@gmail.com, =?UTF-8?Q?=27Philippe_Mathieu-Daud=C3=A9=27?=
 <philmd@linaro.org>, 'Brian Cain' <brian.cain@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sidneym@quicinc.com, 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-29-brian.cain@oss.qualcomm.com>
 <44e23197-a2ec-4477-a4b8-a526f83e47c2@linaro.org>
 <b84bcd2d-9974-41f0-b9f5-2d416ed16d0d@oss.qualcomm.com>
 <67b33d51-b8c8-421c-8aba-efa9a0b46bf5@linaro.org>
 <008601db9448$601bc370$20534a50$@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <008601db9448$601bc370$20534a50$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/13/25 11:47, ltaylorsimpson@gmail.com wrote:
> What we are trying to model is an instance of a Hexagon that has a number of threads and some resources that are shared.  The shared resources include the TLB and global S registers.  The initial thought was to tie the shared resources to the thread with cpu_index == 0.  If we were to model a Qualcomm SoC, there would be multiple ARM cores and multiple Hexagon instances.  Each Hexagon instance would have distinct shared resources.  So, you are correct that using cpu_index is not going to scale.
> 
> What is the recommended way to model this?  I see a "nr_threads" field in CPUCore but no clear way to find the threads.  PPC has some cores that add a "threads" field.  Should we follow this approach?

I recommend that the shared resources be modeled as a separate Object,
which is linked via object_property_add_link to all of the cpus that use it.

The linking would be under the control of the board model and/or the SoC model.


r~

