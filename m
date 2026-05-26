Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293ABCD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnot-0002VX-B6; Tue, 26 May 2026 05:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRnos-0002VP-FR
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:11:26 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRnor-0003fj-1i
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:11:26 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4526a8170ceso5188499f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779786683; x=1780391483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5ewR9/pJ7zpGsnotvO2ZaYJWAJQz7w2OOLTCNHabvak=;
 b=nJBLF7PavlLqSDgLgs/c3+6hsBnUTBVXM/Qqx9iTYqUCtq5pk3wp71akxEr6OcmfXD
 x7zTbKtO9VEqLA5Q2dQWcfx2ezCqrcwhyLAYF5HPuSjfdIxNpLDZKhlr8xuHXuL0MsNO
 qOFMigwjc8IgRitN56fYPYE9TfZLkyF+f2l8Gt5ZvB3EwwdPc67ubpIlLSuuXqujTkAp
 pO901gis+VoVqfqDg6jso38C2sk6SaDN/bRgRauFO84hDatjGsmfsrenH6Vd0W/YUVGg
 MBd+xtM14W//sUTBCm5304IhWfRGm2Ywl2wD1jFxQ+AIWYuY3mQDFl+0W2BQU1zey4fC
 kF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779786683; x=1780391483;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ewR9/pJ7zpGsnotvO2ZaYJWAJQz7w2OOLTCNHabvak=;
 b=XMP5qHozEyuTwieAqdFh6jFA9P9sQ4uodE2cwROXgqa7E8RreSRh9xRInLcQFUNUG+
 tqf+rLtpnDRUQRlqo+vQxHaDtlMuSWqHydHhedBhnZ4QtIbeH8qhTyIAGveOCkxs0bKR
 T1/bvbpiEUgtd6HeBMCCEssseEvNQzKnpRvdnYUy9JLqTBsKFBTUZ6uHfIoG6OwZDSC2
 sl39lEXlxK5Zy8QAbUysXcp2F6ZYeTXlu3T3mdAUx5vQjw7dYU9nuwWYK2N+2zj2IVrg
 WNDFTVqqPm/ExAA/dX17dA9JOefka/7dmJo7AW5WK+tGlFvExSLBfW/1k3lMjWJwVXIv
 1WRQ==
X-Gm-Message-State: AOJu0YyAgqNpFe6Eyuo1mtKoY9QbtluXUTJi7yHcHjXlqmftoRGdwTdN
 lE6chTyIlzZ4qGpZBimKoOlmgpLl41Yx+HxTTvwyqlwq58/z1fRYX1T6gQrUWr2k+ms=
X-Gm-Gg: Acq92OFeh1Xr/AZpVDfQNSibwpSNT9Dy0O6KNuj/1xhIo0q15faiqP7ZMKOJbhvtc+t
 QaxHQ8bZcDBNAMWz8LjLvlGtwxZw/EbB+vtUapq5ICH7H4D9VD0QQoiTp0bXQOTVNw427mZj4VW
 P0oQ+6z03bpN2wurNmuXW1r+kpCH+C28A39OKg6y6uL75rpK8yjdb64cWicSECOBGg9tXfSOcFc
 A7s83r4bWIRaB1/eYOmmLmiCglQSg3fuCBXLuOp9Sh8p/Q20u8S+XLLqjrU01KD1FGcixp0c42Q
 qshjJDJUV1ssuxtVI7B6GuRB+WX1t+m1V03w4KpbBCQtUpIGbwNaDDoyhpOHH4iVBIpovuPpE/K
 vMtB08E4Gyrjjc7VDuqiPVOJ9uxN2Vl+BtvWW64MJZaCEgXydadE0LYH6OEhpv/pM1+2+IG8bPx
 R9f43NnELh5+6PdrvMQlRopr5qLb+O326SgUYA/P2JXY6D1n/JNHfBM1tNf82MaA5Mgw==
X-Received: by 2002:a05:600c:5298:b0:48f:e230:1d12 with SMTP id
 5b1f17b1804b1-490428dd63emr308841015e9.31.1779786683192; 
 Tue, 26 May 2026 02:11:23 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042ce8722sm105185025e9.34.2026.05.26.02.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 02:11:21 -0700 (PDT)
Message-ID: <cb1a9261-d59d-411b-a066-a9e186f26668@linaro.org>
Date: Tue, 26 May 2026 11:11:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] target/loongarch: Move CSR registers to struct
 CPUSysState
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <20260526065023.1639371-1-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260526065023.1639371-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 26/5/26 08:50, Bibo Mao wrote:
> Here new structure CPUSysState is added in CPULoongArchState, CSR
> registers are move in CPUSysState. In later with LVZ supported, there will
> be two copied of CSR registers, so it is simply to add CPUSysState array.
> 
> Also new field curState is added which points to CPUSysState at
> beginning, and it can be changed during VM exit/enter entry. There is no
> function change, all is code movement or variable rename.

Isn't curState misleading? What about:

-    CPUSysState *cur = get_current_state(env);
+    CSRState *csr = env_csr(env);

