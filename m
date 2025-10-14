Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B185DCCD193
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 17:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8jDh-0003tR-DV; Tue, 14 Oct 2025 13:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8jDe-0003tF-Lg
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:53:54 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8jDb-000478-5x
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:53:54 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b609a32a9b6so3324974a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 10:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760464426; x=1761069226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t0tmAiM337Pp9Kn2FXjsiPOir3KblHnvBbauK6Zk0m0=;
 b=N/7QZGap2LSrmn1vArtGQUSck5RcLIDf1n88snhgYyERv0FagPIhtPVmDQ454n4xWg
 OPLmLDnLHmxfN12Y3pM+YCl9FhtfKbunKySvRCLYIuwTfjjkNRAOSaseBAGZegrUVwL+
 NHpx9gqOFKAPwEgvPOkwgxcFnf+CtuVhfxKvzocfgCYEayxVeuSF+vX4I+fYyHpQDYa3
 Z9ufdk7pQLJ05RNvluo+pMluEIJhHwrF6bwvP5lLtTg7V7oCrknZSHoqoVQhX2uE+eq0
 VXQ4dkiCqxD6eN+kKTDWZXOFxH/1IpJytQ63KKKQlyAxx3wN+HZ62sEJJzksoeLgZQI0
 C+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760464426; x=1761069226;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t0tmAiM337Pp9Kn2FXjsiPOir3KblHnvBbauK6Zk0m0=;
 b=n5iWrTsoIR6sTXdwAgWhqTxpfmBmCrYfUeZjKMySuh7h9F/eW8dtsxNYx/f7hu9bLM
 J7tL93IgCtI/wBeagpLg2epxykhlWqcV9wuwV4jCaEgY8TyOT1jllTSxWUEeACXGhiZo
 8sV0TDVquQgaPjXKV2fov+c5X/OeNciFcHlJi4TzaBhuFqTTgUJu/N1lCTtm3JSsnIG7
 SYwc63EybiCWAhkpd+wkpPrl4Lu1cnPaPR6ARX6qH6vusMf5YmilbhQAmbCRLpz9SibN
 hNDOaRHjba1Sd47yak6UrpZCk1IXoEIzYMSPoNy+RV1HsDw8n+02/jYpiqTKgIyFfopS
 +/4Q==
X-Gm-Message-State: AOJu0YyAYClyOOyExevvKykCNt/dw6ceySfnv4Qz+xrecv65vulZ66/G
 +qmL5o1o/MD7Hd47pnfx/stTa28o/GVPTUYB6bo2t12yke1TPte3vud69Lky3cmK/v19ty377l4
 UmmZbPPE=
X-Gm-Gg: ASbGncvjPVv3iEQ78rsw9ueX1Icj4m4jPFj6mbZgP0R+1MTL+UeLzFfWwPbUDBNZNFx
 3uMlS8DAMI4nHquv9+N12rVoKOxvSakcXaa/NUD/FkYXyDGBpmSiXS35MOfT3/9RNO7MGvB45+0
 +bWftn+lGRdScOZ10LhLDVdSxF+KXAGjizk177+ab0PDwCRxmIHVSKKjaLe6mlNvfdAC578fXvo
 UmAKHAAfUZ9pm8zNe0H5PkLz6/F2JapjYvX9+SBVrKNHZv32xrk73k9giWLKz7F0utNcSyBW0CL
 gJub6SYDvdO/o4Oa3Y9/kcX/40vG+I1njgiPjjitq7VQ9gjlulm/VTjEL0iLJRkfDfhkau8wFDi
 8UYqxFXJE1/WGLJZL87lq4F42OVG89vTy2pHstYOmJICloBe6gn39koyH04s=
X-Google-Smtp-Source: AGHT+IG98yvBzY1L6yLBRfVFtWf5eMTcbb05DqsKN7Zg8VHzwiKa3Cz7DYZFjmK823OOs38IABah8g==
X-Received: by 2002:a17:903:2ece:b0:267:cdb8:c683 with SMTP id
 d9443c01a7336-290272679e7mr322560985ad.27.1760464426368; 
 Tue, 14 Oct 2025 10:53:46 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f4ad6esm169901905ad.109.2025.10.14.10.53.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 10:53:45 -0700 (PDT)
Message-ID: <cf89f7fd-0d8b-466c-a696-d3e84cf1bb2d@linaro.org>
Date: Tue, 14 Oct 2025 10:53:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] testing/next - arm custom runner tweaks
To: qemu-devel@nongnu.org
References: <20251014104323.3023714-1-alex.bennee@linaro.org>
 <c5003498-7914-4d94-bb79-0851c49c47a1@redhat.com>
 <874is1l7db.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <874is1l7db.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 10/14/25 10:29, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 14/10/2025 12.43, Alex Bennée wrote:
>>> This isn't quite ready yet as there is an in-flight MR for libvirt-ci
>>> and the final patch has to manually drop a couple of packages which
>>> don't cleanly install. I don't know if we should deal with that
>>> upstream or in the lcitool metadata. For reference the two packages
>>> are:
>>>     libcurl4-gnutls-dev:armhf
>>>     libglusterfs-dev:armhf
>>
>> FYI, glusterfs is deprecated in QEMU since a while:
>>
>>   https://gitlab.com/qemu-project/qemu/-/commit/b873463821343c6f702c4195f2168790b09cf44e
>>
>> ... so you could also add a patch that removes it from QEMU now, I
>> guess.
> 
> I can do that.
> 
> 
> Richard and Phillipe reminded me that we are due to drop 32 bit hosts
> real soon now so maybe I should just remove the runner and the hacks
> needed to get it working?

I think that's for the best.


r~

