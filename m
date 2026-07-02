Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CF3C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLE1-0006rW-6w; Thu, 02 Jul 2026 13:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLDy-0006qS-Ub
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:29:19 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLDw-0007pE-9J
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:29:18 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-37fb17e1435so1510779a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783013355; x=1783618155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BWN/28jR5SeeVCY05G1uO55qNE9LJI17KdegCcKPw34=;
 b=KkFT9YraLDnE+zxo1ANRKMlODf8GRNvJQJDlx7Gjo1os0Ryzik3A1yjXJwqmsGQTwO
 OJiEgDRB2b19j7QyvP/HwCojCgy//qaK6DXA9tdubcg9vTwN6U5jTSRlePSOwBLStytv
 uF1qwLQL545wDkrihI06AyM+lTckwPQy8lu+TkORVpkJ/CMFkuV+eJMep7dEdahqrAPw
 AmMZvZAcxSs/XbbwclTS6WFcxYA0R/MLE96UJ0XjdaMWopiCVkvshg3638tyQPsze0k6
 YrhLYH2IjgIWCrXHbvFEJwcaZKcmpApHWuyDKa/Fyjyayz32EITcFfq8H+chMZw807lI
 XXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783013355; x=1783618155;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BWN/28jR5SeeVCY05G1uO55qNE9LJI17KdegCcKPw34=;
 b=IhE9ng2dqq5kobgG5xLjG9Ki9ITVQiCg5qdoqu/3sp3Lj9M2hV1TG76ZBIShKH2/rq
 t/F9XbbbA11zNugqwTPQ1snEETDXTwwSfO2+QjowODlYc/buMWglOf1TkhJvl5A9iKTY
 V4lvZ+35OyL3La44McNmbXmnpPOzgOMRCbGYlKBJjXCL07NLgwR4sx0n3TunqyojYE5f
 XO6Tf+NnH/3E8DDKLrIqjPuRZ9NGvXKi+JWm58hbspXO1f9gTQGlaNGiGcX1zoh12wGG
 LobwtC6ru8eq3U7RsayBJAraixwtWQG/ffmw7D0Jsrbjhit8YdBiwn1/7tUIOLk8xgha
 Z53Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqu/ClLGY/QAaW4Oj4LXP7L7uyrViE3cG/twAjJnOICaP4N30PlPMCDLfhuETAtuNs4fMwQpnXkIC7l@nongnu.org
X-Gm-Message-State: AOJu0YzO2CI+5xhMlINUPcy1Jg7zg5y0l8JqsLYBt6cY/NVH03Qr2IQO
 w5n3WXQKz8QFYUk5DiW+gnnTNm8q9si8fgSTthSmDa7LIoOTEuevNfS9j8Ferad6NHY=
X-Gm-Gg: AfdE7ckse4UX92M9+QTFDRac5GQuTaWUA9KqMhfMhqblt4OuqUbWHelzxXiNpR3oCyI
 xi217hu3N0VThexwQdd+nuN+Lk9oXa0n/HBYQi9Pg7DwfGtJTAt9bYETk82ZIy2KZ61IMV7Spg7
 6b50zn2aqRR8YAAmN4BNW1zu4P8QZIi2ZhYJNKt2+3ipxpkwGx4eA9vQERipOORBfAO4Kw4d+2k
 WYMQJmYpHPeCNvmwyKOnzZss5jpriqby7JlyNXUtRIfIg2aJ/FwwwzgzGUOYauzfpfhad2Zjl48
 zREpCqsHa+DP5pWL9k7ikvihLScIosc3woor47uyHMZzPO0KLb6d6PsbF4Sf07jPkfqaiq/bYn3
 EPDQLWhpWu6DzpE7BhdbE8Ib5v9rmXzPuJKWZmNpzeljtZpHGRHrN4mjWp+H4zMZtc3pUugZ+a8
 3oE8VP315yNgAOdUQrIyO0L3C/UAVwQvPh1IXb6BPPb1LjPw4Uydy+9xB7uQ==
X-Received: by 2002:a17:90b:3c04:b0:37f:f4ae:5f25 with SMTP id
 98e67ed59e1d1-380aa1c7afdmr6656155a91.20.1783013354606; 
 Thu, 02 Jul 2026 10:29:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38115739a50sm96111a91.2.2026.07.02.10.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:29:14 -0700 (PDT)
Message-ID: <daaa61a7-6c24-47b8-bf61-dbf824197886@linaro.org>
Date: Thu, 2 Jul 2026 10:29:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] accel: Move supports_guest_debug() declaration to
 AccelClass
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-15-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-15-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé<philmd@linaro.org>
> 
> AccelOpsClass is for methods dealing with vCPUs.
> When only dealing with AccelState, AccelClass is sufficient.
> 
> In order to have AccelClass methods instrospect their state,
> we need to pass AccelState by argument.
> 
> Restrict kvm_supports_guest_debug() scope.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Richard Henderson<richard.henderson@linaro.org>
> Reviewed-by: Xiaoyao Li<xiaoyao.li@intel.com>
> Reviewed-by: Zhao Liu<zhao1.liu@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Ideally there wouldn't be two different accel callbacks to init gdbserver state.  But this 
is a small step in the right direction.


r~

