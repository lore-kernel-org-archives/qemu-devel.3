Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBCDC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrSX-0007uE-AE; Mon, 06 Jul 2026 18:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgrSU-0007u2-Oq
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:06:34 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgrST-0006DO-9Z
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:06:34 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso14305425ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783375591; x=1783980391; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=octfXJgwPtLFbmGUdY0xGOXJJzBiwnKJrfNK2PUvb8U=;
 b=o6cJB1hI+C5nUJvSCSQroQ10igYK4uxg23LISGBwGn+bY2yaEVYB50pxkn4IVsEvaB
 LmtpyR34FxGCAy042pshLjly7A5KRLNfc01XMxTHFXpjFsTZTZyHcSKMmE6nheRSu23H
 erKgdqHo6psMLsh+OkhzCOlhjc235LWtpRHUaSjL0B9wA8hqDCeZMBksNo+Q825YgKtH
 vTrUc6r+UFNmmmOqYGeBd1481NYKMNq4iW4E4gjiYdw1YngS4VhGL0Qf8DU4LhVrikYm
 E5E4Pbmk+ci6QGi5rRo8Rfw2toUSjkrY7IH025Gg6rvOJcTWXr9tpcnRlkblR6AyfOEu
 kfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783375591; x=1783980391;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=octfXJgwPtLFbmGUdY0xGOXJJzBiwnKJrfNK2PUvb8U=;
 b=DGPyaxfQkNr1QQ4LbfXqzHsjtnNqll8hqBz+eJoplI+9BoyQMCtDUOjJEnMWG3doPS
 83N3vxE4gN8+9pnNsC9mZbCy4uD5rvZIxdvcz+nERZuaCanVXu+fY1gTwUY8lqqeWubl
 R98ssrrhjcWRIkvmBYKTPekfDMeUcm1E+d5G3EA8g+i1YrGKE77PS7qeZrw8XycZALEW
 Ip2hBU2Nb+qVySuNThuyOXy6WgGWJadoRnw3L7bEDNe22wJenOMgNh8ExnFGuWM3JHp6
 yWMJi7aVfie+l227RzEWV4n6Yzf75ZasInCz3JSK/qSe1ryIQPffGOutukdYxclvyCBV
 Az+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRvjYZFXm8XsOUnB2eESBW/SqNmXSWWBaIMN9mFGO1HXOOPBrpFwr+jJ9AxZ/GcFFAO8gLQZWkqCIt@nongnu.org
X-Gm-Message-State: AOJu0YwHPVnRrFH/kFTc22MuEJK3ij5T5DN3Jnc7B76a0611yt4eZJRi
 YpHJL9zFfnG6W5RO1NrF8s+a40nMJkdlXFa6hsRa7GCQfO6Zyc9fK1f2NLqT+wL5BCQ=
X-Gm-Gg: AfdE7cnTalEV8LHjy6FinaQa5RbXHYeYeGB73Xc0ENKwsCZzXP1vtTVqTrwN1IJyyTP
 ChbxWy6l6UaYy5dN3dIPbIj8D2dD2iYfNPe6Ylry8VsuO457AC53nFlc4t5ZNh8VOCeQwlZtBW4
 AOBpULNoqrgBUA3n//XgZjnlV3yXpQE2oY1WxfhDQNm8HQP9Bx+iVVRCyXhyApF6xI568JAHpZ9
 iMgv2NtS8NoH6eOTr8k8WvpZ/iay4V0hV5K7w8VKG0TmBiVH6Zv/QofamvLuFfqgVoQrOZdZEkU
 EK+x9l+eyht04lCsXxpfisLwcTdPQ1MXeV4AvkDwXndHzzAPuTzGksNm8oVfzjFAITlipI1SDGC
 FN3w7WiD0UYub435FMArmWi7TTZpXFEb7GATx+lPJtg0usH6OUfXNBAH+SI0FZs+agillxUMP+U
 Pspybzjn+7wWAoHalrw36jh16XEKKSndF4+MwungOW1nsbj5wAEcIjHPQ=
X-Received: by 2002:a17:90b:3905:b0:37f:9cdf:f03c with SMTP id
 98e67ed59e1d1-38757894378mr2262163a91.31.1783375590941; 
 Mon, 06 Jul 2026 15:06:30 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-387ce882ca3sm57877a91.0.2026.07.06.15.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 15:06:30 -0700 (PDT)
Message-ID: <8eae6f79-87a7-43bf-bfdd-a558944d7b65@linaro.org>
Date: Mon, 6 Jul 2026 15:06:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: docker-image-debian-all-test-cross errors
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <4b08f4e2-2274-409a-86d8-469c73e21579@linaro.org>
 <7e3536cd-8f02-420c-a85d-3cc027fcd660@ilande.co.uk>
 <f5df268a-cc86-4a8a-aa5b-91c005244a2a@linaro.org>
 <aktogcyff5Xinh5X@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <aktogcyff5Xinh5X@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 7/6/26 01:34, Daniel P. Berrangé wrote:
> Note QEMU will preferentially to use 'podman' if both docker and
> podman are installed. So 'docker builder prune' might be purging
> the wrong cache.  Try 'podman builder prune', or manually run
> "podman pull docker.io/library/debian:13-slim" to force refresh
> the base image.

Thanks, that did it.

r~

