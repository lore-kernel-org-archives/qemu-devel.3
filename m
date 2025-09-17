Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1346FCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 18:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uywbH-0001v1-4Y; Wed, 17 Sep 2025 14:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uywbA-0001u8-5N
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:09:45 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uywb8-0001n7-Bw
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:09:43 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-32e372c413aso190297a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 11:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758132580; x=1758737380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+CHHqy1q2Np6y8kC1B803/GokQnv2ZjPTd5z1TDLId8=;
 b=iNwzzMoL5jR+z2JmvWIiEyjS1i+Zykzmw13dTjEuBMIsa2nY0oi/cky6i474YX1VkU
 tMgoalxwclZCcpw4LnS/nwjsh1iNWg+nVM/fPDq2fDQkP89wYrBxo+pqpHHS3wJoPquQ
 z66GmI25DtL6nC49LT9hEvk3FxTsZfikL0hZprsuwsRM2ID4xdiHC5C56I11MZFifna2
 ou4ROtBZ389rt/NsBVuVxjyp3ruTUk7oUBuQjRg7bv9l8GxVPYEcYi2SqMq6aY2EpHm7
 KzQ49pV6ksO2KPRKeTA30yCY/1CEKIGBLtjBG/+uRv+8t7NhnMjyuRumKoMARFA61Vxs
 DZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758132580; x=1758737380;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+CHHqy1q2Np6y8kC1B803/GokQnv2ZjPTd5z1TDLId8=;
 b=Z1RYVSH1Jl0FQxfAPEd98qINNlMAhXG51PO3xCKOc3p/3PmHec6IzfjQyOn0W9I9vl
 77K5/UB6sZb1EBZpWu2bnwGa6278loNSd9PDvAexnlH6MNdkCZeVRYYfU6fgxo+oVSgr
 rSc40pcdbvzytYQR14uTI2MRegIaZVmqFp3Do6mRsgjqyb9MnfwQtbBMpnkXN6OuAOk/
 0IbxeD0JtnzuquoHAQHbj1CDBELrz9Yth+J98NpNnOqUgP1CyNX8hdjTvknzjOKk22Wp
 NGyq9fqCac3LlkATgjJKcgReI5LUJ2lyqDIEFdfp5NlujdSV/tL/PGjWYGpuW+R4XuUo
 m9TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8ISsPd+xWp8ebTz24lLByA3Iyphu2MT4hmbpBjP4GaIE4Wx1HtXkCXk2max1IGhWNP/GyYI2kg7iy@nongnu.org
X-Gm-Message-State: AOJu0YwV+Y4YPMlNqrdjaV8y1wvBnokZVfZ5sQWt89pLHPSlWVFH56Jq
 eVmX4ObmOV2TAyPypM5r74KUvf2pA6SQld1Ki0Ce2Q8eWS06JME/S0fZcYyWECoa30s=
X-Gm-Gg: ASbGnctIo3TfazY8/6Fc8xjzPVrPdXJT1Lk4Uu3T5v1mfa5eC6RCxuMeCF4LK2yPkHR
 RjX1NdZto7iEKIh0ytQ1yS5PeOuPXkF19acCmn4QdO/kkaIRci8zjTB1D981n2oxtuu/3/RBkKz
 cAKSqgHVLO6wLkVpsjArY0UHDWgrAEGAwHalm5D36VhJ6qt1Qwv6P9VzbxsKGMYMEp7HoJh4i08
 ciDF7E4uwZ1BcuwnB3Mj+bigjA6SlmT0Cu8eWznAHYXg+3bGHdUSy8M4NMF/SrwGwIIeYd4bTzh
 6qKlmaJNMsvWKBfU1I7xw7x8fh106yjANAm+KGOfhgIzrrHsfnIVRJNJa+t7AgvVIy0iUCiCSli
 AMYPveC8tWafU2fteOvUA2FW+Vg7osg/ZT9vH
X-Google-Smtp-Source: AGHT+IGe6n0R/c8vj1aZqIeMbVARfhIxaRvLAcHcuj5TJ/ZTpYL29pRtAmIFo/TFS/TISv7vOqSjIA==
X-Received: by 2002:a17:90b:2d8c:b0:32e:1ff5:5af4 with SMTP id
 98e67ed59e1d1-32ee3fa63bbmr3546851a91.35.1758132580488; 
 Wed, 17 Sep 2025 11:09:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32ed26876ffsm3106713a91.3.2025.09.17.11.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 11:09:40 -0700 (PDT)
Message-ID: <9ec1f289-58f8-4537-90e1-89eeb9bd72e6@linaro.org>
Date: Wed, 17 Sep 2025 11:09:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/8] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>
References: <20250916175108.139627-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250916175108.139627-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 9/16/25 10:51, Stefan Hajnoczi wrote:
> The following changes since commit 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d:
> 
>    Merge tag 'pull-request-2025-09-09' ofhttps://gitlab.com/thuth/qemu into staging (2025-09-11 12:41:01 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
> 
> for you to fetch changes up to 2c27d8523927b0965b7b3d265eee3baf9a15c9c8:
> 
>    tracetool-test: allow to run in parallel (2025-09-16 13:31:40 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Daniel's updated tracetool test suite that doesn't break Windows CI.


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

