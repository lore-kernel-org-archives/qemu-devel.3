Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742CEC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj1Fm-0006Dv-B2; Mon, 04 Aug 2025 15:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj1EQ-0004WQ-St
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:52:27 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj1EP-0001bE-A1
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:52:26 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76b6422756fso5619811b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754337143; x=1754941943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zne/oFmwJzJDhhVeTrMcH21MUk747mZP/ZoBfHx9v/E=;
 b=JkCzTK/nZLm9KqIRZSOj9/5WM+TO4B4kId7hZ4Yjgcf90zS2XzqyWnlX/Zu+/QW7xy
 Ct+y0HX2w6d7yraw+EAgUf0s2Yal3borU2h6KjttAQc/fCc1J9CowKtrWc+yLiy+kpYb
 ouCtweFGUWo2SkQzjkpmLVpd7M/wj8dKJGyysglvNSDJbluoqjJVxbWMqv/mcBrUIdqW
 JmmBbKzqH2QfYXdSketSdviwDdkYHmNe7qCHCP+wf6hNntD4q3lKud96lMRLQbsq/Cqe
 iG4Xa3DFOFAE297Sk1jRS3zNkahqpGlws9dBM1zHXxIn902E0b7y+t76l0ptFxnHcEay
 vWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754337143; x=1754941943;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zne/oFmwJzJDhhVeTrMcH21MUk747mZP/ZoBfHx9v/E=;
 b=s9YKytY1JdP9oxtiaOZh+w8SaPa9Dh23LR70IMqnuboTkdzLdqEoMUxEAsjNY6RUor
 +6yF50INqdiJwGJdJHZpTlHlhEnbi5ACmVGEanRg2RNszPIR1AfXcjkksQix+98bNWJR
 YvC+zLfJgkECG9iWduK0v93foJKsoAqGwnf4JyFCJ9cVTS49zKq4CnqHoXHOsc6GO5Re
 rSqsF2T/Ak99wtA+PdrBMrHUXZLg0hh+M4eHSyW7dB9aFVrjx20PZMOL9xRQW2ywwb3n
 N5c5L/OZJmRsjU32///0mbCmuqR8qQUJsl1BLtWh9K7UPqe6UFONKHBiQv7H9y3UWrO3
 UsOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4UHj5301DkDU+XyYscgVNs7CmOAyaIiM3FTJpYHzGDb8KhJ2VOAbcIkL47SJe6btX523/9+7QlkW3@nongnu.org
X-Gm-Message-State: AOJu0YysTmUSuJ4SSVI/ICy16UoWwRcTxGsrKKd68Z4yuFCT45qAk6qN
 iRcegXTcgMErMplYPBiQqaaCFEJT6j1gpSP4N0iGAPoqKtlkyIMQKkUWMHFndVHuteA=
X-Gm-Gg: ASbGnctiwOdrtMz0FzuSqHdn1/yaJxEoad5eO8U/HzFddHAgmBXEJYuXn15/R2G9GaJ
 J6g9US8IEN0USNNGjxdva0bDxvRj0Wmn/eeWz7jz9S4RWjodlJ1mT7JFfsz0i7ns1tO/0qTOdlM
 8rmWvPdixm+sMAZ6mwBIUF46rAi3kH4nHZ8Zr0r5ZbXvE5sPj3o+PL3A0nTXSxvRS3ucFITN1Q/
 cP2rxffaB4apxYNHFLS5Pa67GN+odncm5HftQ0Hrjs4H97/ZVjwUZnjqeQrWqD6ArozxzBnULfF
 wW38W8MMzVQ6qEYSpNuCsTJzABOAxXAIfW7U3cJsBMLqejkS41qIM57EqkX91il2S/U2nObXi7f
 Mk0h0iCBWqfHdpMSmeoRIL5l6lOTkp9SZfXvNUq8osUygEA==
X-Google-Smtp-Source: AGHT+IGiSoZsqaIOCL534kzFmD47xYKQpPufDdZFG4geNQ7xeS4xjcw15Xyni/1ov2yIssTGwr7hww==
X-Received: by 2002:a05:6a00:2ea4:b0:76a:d724:d712 with SMTP id
 d2e1a72fcca58-76bec302327mr14177966b3a.3.1754337143565; 
 Mon, 04 Aug 2025 12:52:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbd1a7sm11283644b3a.73.2025.08.04.12.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 12:52:23 -0700 (PDT)
Message-ID: <93a17641-8888-4fb2-9e6d-844e18e60111@linaro.org>
Date: Mon, 4 Aug 2025 12:52:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/17] MAINTAINERS: Add myself as a maintainer for WHPX
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-18-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804142326.72947-18-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
> And add arm64 files.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   MAINTAINERS | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


