Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43719EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDvK-0007GA-IL; Tue, 10 Sep 2024 23:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDvI-00077B-7e
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:21:40 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDvG-0000Xd-K4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:21:39 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-201d5af11a4so66561585ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726024897; x=1726629697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h2X7KXIDvvyVBw6vY3XpHizKumMHLRsBK0Os86z3yg8=;
 b=eZCLzk0S7UsPGwWMGchqiJVroLKmXsJ3AFux1QuOuCdp1a7MdcEPQLqtfVsMraU2km
 t92MESgPWm5FiMj7rfmgArpSks1Wn9UeO6BJwpwIqAm7q+OPINYWbKg/SIpg0MaOOJIw
 GnvsP58Bua6p2Ghe35wwxBol8V/aVMt4OmzNYsds/bgGnnKLRjppUxGeWmCjYXnmuwTS
 BqfN239Tw8Xo2rW37gBrbWXsiSl8QfVegP6lkHueNaR7mMETehTbfzG6o/75sy5JPyPB
 Pt3ij+A9VA3fiSAqLWXkYcETNND2cP2xjquT9PLVYAwEA1Hg7i/xsZwi7JG0UHuCV4dC
 7OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726024897; x=1726629697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h2X7KXIDvvyVBw6vY3XpHizKumMHLRsBK0Os86z3yg8=;
 b=iW08sVekX0IiHPPLrQBPFf8/FxHZni5mf6LXfXhsjlMhss1lCFXyx+yjIg0rqQr0lg
 /H0q4hKKu1BiaViosYZYT1cFjcBc5zul6/VjjQ0qVepiFmYU52ik2EFuvxk7QI/hhUMr
 M+/Fbe3BMLE/yn80HCaIrT0+d6UqI5sqlFzQp0AePygx9tIa+ogggU90wX15lkWDC72A
 MuLsiNKJ9ggZ96WN2jaHeEtTbfQgQj5LbYsvUpBEHNaafQhBXjloBNBgyn8utEYPk6CF
 RteqXc2lTy7BUL8j8dmcnIi3Wm/e07iOX1BGA3zwAZX+6989N75apt0Rolsifkr/Yf49
 +PJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk0U2XiggeeeXxujc+Bm1pLp4e5ajCa6O1/QM/C+pPdROd4E8KDTMzbE5AO4d4obia7Wa4AbeqYWnE@nongnu.org
X-Gm-Message-State: AOJu0YyUpbODCzk5T5KdnUaWfIItx6nId9PQR1Ti+/JxcdPVeexEpUz4
 /xHA/GmtM4uiJc42zPfVQRkkH/CcgOMup1GVbxqM3BEObA4bIbD3KNpzM8dsfCjMi327vmu8uP3
 o
X-Google-Smtp-Source: AGHT+IEMp6CBnR4BmyJPD4qtLzGEQjCgamPYF2KEbfvmAfsHyhpIxVKVEwTLs6P8asiqwayAoqCSnQ==
X-Received: by 2002:a17:903:94c:b0:206:b4cf:3107 with SMTP id
 d9443c01a7336-2074c6e1105mr42352155ad.49.1726024896958; 
 Tue, 10 Sep 2024 20:21:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e324bbsm54936815ad.87.2024.09.10.20.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:21:36 -0700 (PDT)
Message-ID: <dcae7437-928b-487a-b777-e051c88c1e51@linaro.org>
Date: Tue, 10 Sep 2024 20:21:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/39] hw/net: replace assert(false) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-18-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-18-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/net/e1000e_core.c | 2 +-
>   hw/net/igb_core.c    | 2 +-
>   hw/net/net_rx_pkt.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

