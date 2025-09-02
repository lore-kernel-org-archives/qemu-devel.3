Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764E8CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utRMa-0001PB-GG; Tue, 02 Sep 2025 09:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utRMX-0001N8-4l
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:47:54 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utRMN-0001dB-CK
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:47:52 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-61cd6089262so8684905a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756820859; x=1757425659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TMKZgSE+4Wp4wamuyoH8DQR+QfTMZIlLwtNLdejvYFo=;
 b=dL77aIExDy+pl1jHGZqTfE/BTHf7D6Q1RtesXsDtBZPus4TAvjL0IKkkQpeQgBRSFK
 r2kd9d1xiQv9z69Rlq06wWYykCrJSHbM6WM4XIoSdouYZX282KX5ODfHo1KYyc++0H2Z
 W1H7unYe9EmkUPr2+s9S8pfonY0U6+M2SK4I7KWz0yhUJJUuOkLS/nA/72HrclAB7uPM
 SaAcWOqf+ZKYZBkPbN5dYq0cNPQdUvYg9UFk291T6UfLXiZz6064KcZE44MgOZMOkIfn
 FyYFeLfwDthbp2OkY+TosA4Yqe3HS2DolR7W+j5DASlHN3DO1loXcw0HIAJ+WTfKV+jz
 uewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756820860; x=1757425660;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TMKZgSE+4Wp4wamuyoH8DQR+QfTMZIlLwtNLdejvYFo=;
 b=v18vSHMNirkHQJIIX1mKMXcQzN1JQerkK2EPNXv6SQtBq/NbakaeK7yOOeMabAr/V9
 JGazF2Azk8PIFwkBIgAzN0mu59U4UAv+tNjxUbAS1McbClPrHApuq112Oeur07WJRqBi
 eV2yr6dyAEBSTKXRSGojTom3lDTfxAlNJif2VyDSP75DxfVtJlbXze2nVMzcIYwQmgFh
 kuaoisYO3UGxrYx8qJVgS9mIJUWnhGuJW1R+ifsGxSyR/XtsL2mQbtB7rHVU7C7Uf7Yv
 JQvKut3yhMNJnLJWQfRqsMEMm1UIdsnFN91A6pTqZGsvluXA4xqlO4itzl6iGiUB9o1F
 s0Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKAXuFqkNx1TOneqsBT/zev+nudfeVGzu2Gw+unklLy3vU8L84xunLVhzyNiq2B1/3bZj4hhVIpP30@nongnu.org
X-Gm-Message-State: AOJu0YwBU09OL4bKRaUQRb+K66cR+iT/Zuz9pKHvf1KBpj0yPfpWiYlP
 O//It3sV9TiY5FxUOC8CqFkfpY19naEu6hDWQW0mML4yj5g4p3eM4d45/WXiFDN67XyxGSPwvl1
 bNYf3ZiI=
X-Gm-Gg: ASbGncuR4Q9cIiyINYRAo8kbTSRLL6RoqhJkNRjBO7W4EovhE02H4/UyQdEOX85q05s
 91rg2x536W+ACOEX4EK8AGDMpF9uvgROFulB5qiobSyZHIj8H4iD3ixt6rekNTMf0dcj26I6Gwn
 d09TYW2bWK5/8jYdNewFHYlV48b/bKc7x37CZiUIsUJiuWLvxGHzXM/duhByCAwAEN2vwEz2D9g
 h5WN9fhsFw97hcBHnr8kCnMWETAjnmB0pwv7/zfSuHtDAgED7IeYxdOY4TRrN9oYMNbkTYbeIxN
 yn1cUJxhcJB8SvgmwEYyLsVu66lqd5XmPSDW4uWsbB4R3MZA2NTS/JeaihSVxsxtFvyg2fsZ9Mx
 FHE0CKQvIscxhpbwY/pAZRBYGt8Q+qLlD/xgaw73VqDL+wmmt2usDYHSH6qyHGdKT7Nb1ssTFut
 0G2/aBUA==
X-Google-Smtp-Source: AGHT+IHxuurW6/mIjZX/ZXVlp2SPvqFc059y+3sKSzBEb0ejJKIIvz1K8Io4ygR5ABPNZPBt7IcQvA==
X-Received: by 2002:a05:6402:4407:b0:61e:ae59:5f07 with SMTP id
 4fb4d7f45d1cf-61eae5973f6mr3891821a12.20.1756820859574; 
 Tue, 02 Sep 2025 06:47:39 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc214bacsm9882275a12.16.2025.09.02.06.47.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 06:47:39 -0700 (PDT)
Message-ID: <2585d9dc-d7d4-49ca-844b-53ffecb49d70@linaro.org>
Date: Tue, 2 Sep 2025 15:47:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Testing patches for 2025-09-01
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20250901115300.2541937-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250901115300.2541937-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/1/25 21:52, Markus Armbruster wrote:
> The following changes since commit 91589bcd9fee0e66b241d04e5f37cd4f218187a2:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2025-08-31 09:08:09 +1000)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-tests-2025-09-01
> 
> for you to fetch changes up to c9a1ea9c52e6462ad5c7814f3abd65baa69dc4ce:
> 
>    Revert "tests/qtest: use qos_printf instead of g_test_message" (2025-09-01 13:44:28 +0200)
> 
> ----------------------------------------------------------------
> Testing patches for 2025-09-01


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

