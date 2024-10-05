Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ED2CF8869
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 01:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swtKp-0003v8-Mk; Fri, 04 Oct 2024 21:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtKn-0003uO-Do
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:11:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtKl-0004SH-Tb
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:11:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20b78ee6298so17510855ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 18:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728090707; x=1728695507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D7UQm6DL0s5HXHwVotYce7ubE+bc7/wYsUc2wrNKYZY=;
 b=LyMPjrOorzm07vAXjK5MVuTIIKuOL9o/G1VF0h+tQzWfEOWv/cM/6x3J70lqtrtSOI
 xayo0j+KnKDXN65VDfS68mp+rOPRM16aD6aoezDQAbWlUbvUuEOglgzdbug50TlTkHzr
 Dtmvb3AuyNyFcKTL+wxoONoyL2bo+j8Dmulio/HxUiNXXyppVVDN01EKbANpVtan7R/r
 zNH22tMIkFrHT6UM18RGKs7gFBeN9O0ejgsYdYF5an54xyxNZ7RqESP+GAPn5gA63bMl
 F52Ljpn8jLJJ2klGwfjdvYce2MIIohL798apKRBRGe2gkRu/QV2/8MLJo3mxLhLuSFvB
 Fv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728090707; x=1728695507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D7UQm6DL0s5HXHwVotYce7ubE+bc7/wYsUc2wrNKYZY=;
 b=K2XUteiVTykpNV2Bwcg+DKIV3P4zuhn+quvUFHqHDvpG7AEefDvnPPRtIUp45IUXLR
 ZTVuP61BhpRURXXfmqwJO2s4q0qeJnShbclI1TKc3HIL94LhPOUUR9h1hCQoAIvwsTBn
 +u/N8NaF6ANM3O60WtpcD6gKIcOy4LvtMc0QHz6PK73oqhSNfBfwxd/rVO+nx91bjAuf
 TqzyUXGVwF9s11Ox3l9+eVBHlp7i0BlgW/aUT17wc8SFytS/NaxkfxtLvcIC7pqA62QA
 0ptn+IkKRJazWwG7e3f/SHTvSEHZdhFzaBQ9LsEHaNUGZMKNJDRTsLDCwnl9RvC/jhi4
 BDcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Vn63OVIDPVZNFtnVDwLOWvadobGTcIGtqfxFc76GvZuIyWGOrjODplc3bpV5qDzNA9hYpQNtUGyn@nongnu.org
X-Gm-Message-State: AOJu0Yz+Zs3OzAoDTHSNISOpGkfPbGko0PDAmCB6hmsfPjW4+jfhSdcp
 GOVsy41z3UiLO9OB7x9+MmUM87JRVVij1rejDbE4S6I4z1XlEO20qSeNPvZZoR3tyvZE+S6ymTk
 j
X-Google-Smtp-Source: AGHT+IHP9/Vv+29z6kUYHdihQ6HuXxVqZu35QBpe8bNo+11TJXQiKoqdUh4OF7B1B3F3Ap6dSEInxA==
X-Received: by 2002:a17:902:ea0a:b0:1fb:1afb:b864 with SMTP id
 d9443c01a7336-20bfde546d0mr83710245ad.5.1728090706716; 
 Fri, 04 Oct 2024 18:11:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138af98fsm4463525ad.35.2024.10.04.18.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 18:11:46 -0700 (PDT)
Message-ID: <8076946b-0a25-4124-9b60-9cd0696b47ba@linaro.org>
Date: Fri, 4 Oct 2024 18:11:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/25] target/s390x: Replace ldtul_p() -> ldq_p()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <20241004163042.85922-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004163042.85922-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 10/4/24 09:30, Philippe Mathieu-Daudé wrote:
> The S390X  target is only built for 64-bit.
> Using ldtul_p() is pointless, replace by ldq_p().
> 
> Mechanical change doing:
> 
>    $ sed -i -e 's/ldtul_p/ldq_p/' $(git grep -wl ldtul_p target/s390x/)
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/s390x/gdbstub.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

