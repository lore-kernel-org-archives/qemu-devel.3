Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BC6CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIWG-0007c7-B9; Thu, 15 Oct 2026 06:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHIW8-0007ba-T6
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:16:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHIW5-0002Nz-UA
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:16:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1ad2e2391so20773215e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792059412; x=1792664212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j+ho3eZAykYHTNcMhKzS1hZjZRUt5Z/ez0TMcgJut2E=;
 b=tmRZUt9Gw1wSNKWehHnarSXkngAjpGKPq3CwqCgFtvjQdKssYmdmpxNR8UqIWmkYU0
 5pvDl9BVDhSAISv7WYT4IXNOnN/S4mDMEHMpCvdo6u1AqQLvpEDOnvipRjCSwv4VkKzK
 6FS9nQDkqriOizqKLd60AXNkIL5en3n6rGgyI7ar/VuzQMXyytpNVwMSA7nc1i/uYvV2
 vU6F0yaqBc2OSIcXlaKs6TYBcs6JTih0yHopD2j2UV/RDRiDIJtM869OMFCHHrXVi7NU
 rlKZFpVLO5IhEyEIgxcb48iwEoD6GcZHuBV5zRLN+ODLiyH3jrIeSyy75Q9me0qXVduF
 gRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792059412; x=1792664212;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j+ho3eZAykYHTNcMhKzS1hZjZRUt5Z/ez0TMcgJut2E=;
 b=qyaGiKUvkBsmGw78KtVv6SIghi8iS+Md/qmj1l3kLiCJyv2W+cSzPO8JjT+IqBy7zm
 /tOgysuGFiEmDcf3E5YAw8IulRSuxuFmpirdBkqxAzk6ASi2CSE5ClbCN+j9JtjgJVZr
 dY8CAzSGx065i0BwNm31L40/uNvl3bJiOjzVrKi3aW+VHhLRUctricD8tz8pcuhS5Ajn
 0uTCXSji9sLbnCJhhP0Hy4OHSI3OGkDqIkJCE7Sg6E/giXATQWB632NUgdxPgR0vFjXT
 7mHcd1aXDTdPGIro1NHOHs5leUavV6AernpzoSQEGKDFAfo139nUfiCFTsjrKkbHE7+J
 0vOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlC2dMiP4Jyky9WK1tQZ9RMd6Y03wlpGim5jxtYHeUqUcVlgreBshVd8lOzZj07CD4Essz4ajaDKmT@nongnu.org
X-Gm-Message-State: AFq9FYJWTQA/Gq4txXRCNUXKFaKFcyYLSiDF7d8YqVODVvpnbOTHt2hd
 kuea4t5856ZWaIk2r4IJEsvYOZhZ+RZ/C/vaec7CWxj/a6MCYxM20A92SVXKst5OSgI=
X-Gm-Gg: AYBFou18kBRVALpvi4IeUzJdN21SqfgjlixSO2AZnv18S6aqQAb6uq/9IZGvdWuHYUY
 fc7kOlkz4F1CjpiouDQXbCOupT/NvMRKnJH/0JiE+pROABMvhVj3O/iJOnvArEscsDVhu7Zv29S
 MejDiyvulSx12LXItGCE1ZjQBvRvCzk465phHumBA54TXkW/QdN5OEjtnaQcxPmyYCX6Dk6XHcG
 DRXcP0VvFLjdzLGkMdfi8ZXhFpGCoULUWbcqpdef1yxR5pprrrI2dk4ZMxrBZ9sDSa9vtN3r3Ul
 wjvj160mrhMH9HjeNjGYzY03KANY3+bjD0dmk2fza0jLqT3eggJmnz6Cxf58j1dXWMUY+N/QiiQ
 GnwLiuUDx6cbqEeD4fFFZN9pr4W/C29YRYcuS95DdaVZ6FpUsbpzCO0rYeb34Wxja/NdsrQA39w
 JqyhC1RMfmJuChf9vwCSwCPjjLn7nBROAhYf6/pPbZAN7Umlo5aQlHd6VKc+nhaND85bakuZtkQ
 sdBemOmWypyiqaBeaxistPHwbcwa9jOBpAQkmLXrl+GPwhyouYUGDDKuqfoLiZf02kE8jX1ww8C
 J7GuyAAInVYY3YPzKunOOzsgZNloDXK9c/QKr9Yf3MA=
X-Received: by 2002:a05:600c:8b70:b0:4a0:108:3b48 with SMTP id
 5b1f17b1804b1-4a18e4a174amr377909595e9.7.1792059411858; 
 Thu, 15 Oct 2026 03:16:51 -0700 (PDT)
Received: from ?IPV6:2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860?
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bdbb4a30sm57319715e9.15.2026.10.15.03.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 03:16:51 -0700 (PDT)
Message-ID: <6cf70acd-8fb1-4b0c-b4b4-eb013bb4d007@linaro.org>
Date: Thu, 15 Oct 2026 12:16:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/arm: hold bql when SEV sets the event_register
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20261012134840.1051969-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261012134840.1051969-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

On 10/12/26 15:48, Alex Bennée wrote:
>   void HELPER(sev)(CPUARMState *env)
>   {
>       CPUState *cs = env_cpu(env);
> +
> +    BQL_LOCK_GUARD();
> +
>       CPU_FOREACH(cs) {

As an aside, cs is used here as a loop variable. Initializing it from 
env is pointless, and we can in fact remove the env argument.


r~

