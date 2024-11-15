Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08538D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzb0-0001w7-NP; Fri, 15 Nov 2024 11:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tBzay-0001vJ-0l; Fri, 15 Nov 2024 11:54:56 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tBzaw-0003xq-HL; Fri, 15 Nov 2024 11:54:55 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53da6801c6dso832061e87.0; 
 Fri, 15 Nov 2024 08:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731689692; x=1732294492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8DICAeEQPMgA29RWwkNHlrcqH+eAuCXE5P6QjQMrtDE=;
 b=OZOJRoo2l+Kucr876QI1eoyZNUUWzZmGiD20m1ERwZuntaUN2IbpOZb/vq2251UnoG
 w1GM3NBx0ZgwNKjM2whF8SoUVKka01YYaUTNL55Ft4kSNCgX8fdlaTFtyfVgJnlthKW+
 eFhSJ6qtio9JBiBr2U7+1uSph3hJp3qusAer1L6NPyeMxRJQpMEz7KreHruLZfL4XWf/
 KFPLMzpPhitbaf47jY1BfZbDTBNd2A7Tis0uGVmfhsOV2ZBdUxwKCnASwJwG9CEEsXsn
 SSw9ZboTVha+Vk3wb8AhZD50M8S/TJ8RaZpzSYIlWkgqlVKKCRyqp5Qgus7wEGlCEq56
 LfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731689692; x=1732294492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8DICAeEQPMgA29RWwkNHlrcqH+eAuCXE5P6QjQMrtDE=;
 b=LOFmbpplrg/DsUpyU1oyhuxMNBZFk0+tNJwf2gzLQbKbME2P7ahgYA4jAdtZKU3s97
 KcuFo6JNnqXboTf9Mvot6yTIUVtMqEx9NmwWsR02Oz/j93kziXhDH3OOoNnouDk8iMNB
 YsgBfN5iT6vqYhPzt2lKxSn89PtgYDtXl7PUM05ElG27jTUtkWxDc7lmzMc72GmkvZ38
 X6SpkAJ28if092OiwTKVLC58Hl3wR+29RC8+uMZCm+rC8xfzMSi721LbbVBzPZvWLATj
 9zEMtFTyG6wuI/N/CY45N3wsMMZUtFWgjZNWoydAIaPXRji5TfpIkVat/IBXm9OuN6pD
 OxrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU95BXrO8waFYKnvAAh37nvGO8OfDPuUTP55WcqzlwJIJTGLHia6/P/xrYBb2ubaCKIUgm5BvfgYy5@nongnu.org
X-Gm-Message-State: AOJu0Yzt50PkcU3kSDQhwJcOtct0fMctnrMUfBK237v5tyq3Pc9vx/Le
 FIgYj6xLsw3SpuqLGuJ1JJR+QyI/+CGLiS5yGWlZ5mtEKFs88M2xEVSETQff
X-Google-Smtp-Source: AGHT+IHnluJK5/H+//8O3peYuhJhA3KWH7rzg9OZXIOvHk1o09r2tzoBOjImJpHU4NrBuSxPFV6atg==
X-Received: by 2002:a05:6512:3043:b0:53d:ab21:4e17 with SMTP id
 2adb3069b0e04-53dab3c50eamr1788184e87.55.1731689692042; 
 Fri, 15 Nov 2024 08:54:52 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:90b:6639:2dc0:6fb5:8401?
 ([2a00:1370:8180:90b:6639:2dc0:6fb5:8401])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53da64fbb9bsm634603e87.37.2024.11.15.08.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 08:54:51 -0800 (PST)
Message-ID: <6303c5ee-e6f9-48f7-9cd4-f78680c2e785@gmail.com>
Date: Fri, 15 Nov 2024 19:54:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm/ptw: respect sctlr.{u}wxn in get_phys_addr_v6
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20241114165900.6399-1-paskripkin@gmail.com>
 <20241114165953.6894-1-paskripkin@gmail.com>
 <CAFEAcA9i+YmGj5tznoc9FQkDQKqN4vx_0grOjh_ZFGyj-aPgng@mail.gmail.com>
Content-Language: en-US
From: Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAFEAcA9i+YmGj5tznoc9FQkDQKqN4vx_0grOjh_ZFGyj-aPgng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=paskripkin@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Peter,

Peter Maydell <peter.maydell@linaro.org> says:
> On Thu, 14 Nov 2024 at 16:59, Pavel Skripkin <paskripkin@gmail.com> wrote:
>>
>> get_phys_addr_v6() is used for decoding armv7's short descriptor format.
>> Based on ARM ARM AArch32.S1SDHasPermissionsFault(), WXN should be
>> respected in !LPAE mode as well.
>>
>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
>> ---
>>  target/arm/ptw.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
> 
> Instead of this, would it be possible to have get_phys_addr_v6()
> call get_S1prot() (replacing most of the existing open-coded
> handling of PAN, simple vs classing AP model, etc) ? I haven't
> looked at the fine detail, so we might need to tweak get_S1prot()
> if it's missing logic that only matters in the short-descriptor
> case, but I think that would be better than having two places
> that need updating for new architectural features.
> 

I also thought about that, but suspected there was a reason it was not 
used at the first place.

Will take a look, if it's possible.

> For instance, we are also missing the handling for SCR.SIF with
> short descriptors which you can see in the S1SDHasPermissionsFault()
> pseudocode and which we would get if we could make the
> short-descriptor code call get_S1Prot().
> 
> Couple of minor notes for v2:
>   * if you're sending a multi-patch patchset, please use a
>     cover-letter email. Some of our automated tooling gets
>     confused by multi-patch patches without cover letters
>     (and, conversely, by single-patches with cover letters)
>   * our coding style says all if() statements should have
>     braces, even for single-line bodies
> 


Thanks for guidance!



With regards,
Pavel Skripkin

