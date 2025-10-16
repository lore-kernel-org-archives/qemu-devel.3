Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1CECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RZp-0005Ax-2F; Thu, 16 Oct 2025 13:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RZR-000526-6L
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:15:22 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RZI-0004Yd-KV
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:15:19 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7835321bc98so1010292b3a.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 10:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760634909; x=1761239709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tof3EVSvHhBUpVi7ajOyVgIJrNKqbMisVbLCxByvW5s=;
 b=Fqj90toHeOtgQ9OoWG0XX1DbbJeulXW6ioSso58JJqZgCfu1M303Kp/w/goxHqKJPo
 f9N69dAV1sCvkpfe+uR4yZjJl1gRsI9AgNwd/byPzvZWTAFP76LcF2b1aHJ4so4okkoE
 tLvV7JCkZ+ZojYEImtA/ZTq9s4QuXEBxVq7EQaH9xR/Pc5OvovyE1YR0CtNbQClfmNAw
 lO7IzV74vSHtp4gl7LM3pIGqQtKIyPgqgt3EV5GgAALefKRtSDKaaUGxhZ3VvEjAXV6j
 MkoWrG4tsTGillnFnQHudeQS7+/3zPrFrEThYnFeE0u8ziGXl37FEFe8gO9NvdkBKBSg
 7rOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760634909; x=1761239709;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tof3EVSvHhBUpVi7ajOyVgIJrNKqbMisVbLCxByvW5s=;
 b=shmQshTdBrGl7vKHt5XXx9rAHk4OPVFHwP1GebRA5B2AU1Io/GosuhDtzWLGC4bjeO
 GLHBSPH0QnU6naVlwPrDHcMFT6aQcQZGeDlY16h2q8grPpNXmTZ0MUuU/orzvk+NjTwm
 iurAFvTVDA7+LAzTZUhrmdCPVMH5xLZtn5RpqWdP5p+J9xaCVJJMeR2bGdWJAcnMWHKq
 KrPKbs99sLBUqSF7NXzBZA0wIVAxxkqyt8+IcJXY901r6NkN2mw2CFdymnLDf/ocnjEc
 fSxgO67TzHIpmuDCMwubjVoK3UQVxINl5AjzZQC8cmOJMpv9tbYISVHB8/3Lo/Kf8HJB
 Y5Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8TQ5PcHxUBEUhDcDSbMG0uhzYPEoD1Q5WcwQw/KzSnhVlscFTOg7qqanGjaezt9Sl7dMYjqScelim@nongnu.org
X-Gm-Message-State: AOJu0Yw0HO00znb+z+wWaIKwNGK/ySEMxdIPCozw3QTfzqoemlhfL1n4
 KEiBjkWnQXLKcCiKor89woa2sQE4BapX9fNoL4wDjS3iBhyWom6h3SYtdKkRBBg6SPA=
X-Gm-Gg: ASbGncvwp7qgBpVVy5USl6QK1Sn7BU4NtH3jqwsOInvny/4qxw1TsGcIqIsXi8f05YQ
 TNIcfEHytdk4/UTYhCJ3XT0uMaFjyEP6nDnkTWcWk38zW4nglvZ29iIH6nS65qQb46JLiudqkXK
 ZHFyzoXoxtGggagnmGerf7Ru3Ql2AW/Epw9PmCnqbeme9sNPgDmkwiqEYAUPPSBNYR0OAinZB4m
 4kzbqeUWyetJ5gtklGQOKqa5l0syrJ0FncjMFkNafbjFdTrPBgLBVqh4vxk3PyzBLhXV6CFmTDS
 fkXKUP9+2+HkLl9H84cRbjHKzdP+ouuuLOduYTadMUyfWqtnMGbKNi2IZmENiPXN2OXm24fTQDM
 QdEPd68RC3sbpDyKT/OyWQvWLRFOclz4yL5738ffZ6o8y+SHXZIBqsODuSfmD9YsGZLIdT/lvEc
 F5zX/INQKYD3nD
X-Google-Smtp-Source: AGHT+IHfOj2/RGEhI9uYqAiueQ5geH38L5kdOF1sE9vNJMIOJ7LSbEsFzN5vZE3JkIhfd+nJud+MPg==
X-Received: by 2002:a05:6a20:3c8e:b0:334:9c41:bdcb with SMTP id
 adf61e73a8af0-334a86445ddmr785445637.58.1760634909132; 
 Thu, 16 Oct 2025 10:15:09 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b060962sm23224426b3a.1.2025.10.16.10.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 10:15:08 -0700 (PDT)
Message-ID: <faf3cd2b-4961-4d7c-899f-bfaa9f2ee271@linaro.org>
Date: Thu, 16 Oct 2025 10:15:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 23/24] MAINTAINERS: update maintainers for WHPX
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
 <20251016165520.62532-24-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251016165520.62532-24-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 10/16/25 9:55 AM, Mohamed Mediouni wrote:
> And add arm64 files.
> 
>  From Pedro Barbuda (on Teams):
> 
>> we meant to have that switched a while back. you can add me as the maintainer. Pedro Barbuda (pbarbuda@microsoft.com)
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   MAINTAINERS | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


