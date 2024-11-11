Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B3FD12D72
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 05:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAMZN-000471-Vf; Mon, 11 Nov 2024 00:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAMYm-000406-Vu
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 00:01:58 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAMYk-0006yt-1C
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 00:01:55 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-720b2d8bb8dso2902782b3a.1
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 21:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731301309; x=1731906109;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3wy0YS8xuNgvcEuaFTNLAE1JbKzanAJRFlX0c1QRyL4=;
 b=qGMGgDeZejOhvkEAf5Uk8UpsDrRb+xwPJrLXNadlt3oj3R45qQQfPql2673+A2vPm4
 cepYXnFwzocSz+Doy7oOjFbxemGkv3Yo+b08bN77wbjMQxmpib3PxXDx78OhXr3zZtGv
 X81eh+XlbswXWFxExtE4pfArL+7EAbia57Gw8s7l3eIAKnrA0gX3Tv0r9BextPsdmkmx
 /ZVzxkecnmsCR8wKeham6bfQFdpR8Xfl9IPqeAy7QIFr/UnNYqgrDvTVNdSzZA1PIl7S
 hHyvf4FKBvxQRyutYfZDbD7IEvpVcVu1F+qmqbeu9CXyoyxqNYarpcUCyc+Z4qDu8/0p
 2+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731301309; x=1731906109;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3wy0YS8xuNgvcEuaFTNLAE1JbKzanAJRFlX0c1QRyL4=;
 b=JlChyAzRiPTg/0I5VrQN2qwD9Wz2EbFGN21BvFtNg0487B5XgqYbaQw6GT/YDkCJqe
 tZIkrueibs1q9BOzjFD8tHRcHeKP/+fdy2hmwZduZc8GZUzf3GNya7a2/pAbKic/ivBF
 ffbDQtkMso3atFLJP8kJZr2E+hxuPFdZcuVVW8/EPaegjbpmEsmRQUYrZUAgWKFUn0af
 tvZYrF1gm4JkYDUEm/2HZblTycbabw26zK+Vq8DGNdQdZba+oVarOMtd5V1vCK7FWu74
 CZMufEPmHjrK4lF1iMY7DiruThmNF9lMcelYBT1OeYp9gOiHKHYeiN3H911byXa3EWDN
 Vo0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnXEteaB9W9ee1krxgR/SJZKj4GtV/U0Mgp6qvokDIaTNZcNUXMOP6AxyAkrr74wxc4KV5/4jAna3u@nongnu.org
X-Gm-Message-State: AOJu0YyT8h8n0gOi5dXyQwCk2S6KabEUTwitA7VCdYrL6BBJjrzJea+B
 LFJ8JmnFKHOb3VwpFfMBoFlcMFHGjYeaRWT6A7kiUlvqDnQcrqWRWBhHcvYIl7U=
X-Google-Smtp-Source: AGHT+IFn+xyGH5vP60eGYsNGVHmBPlLFsjVpdlC/VANpFVoMlPLuDR1U95MPpP6NchUDOLGSX6rdHA==
X-Received: by 2002:a17:902:e750:b0:20e:57c8:6ab3 with SMTP id
 d9443c01a7336-211834e6e10mr140150725ad.4.1731301309171; 
 Sun, 10 Nov 2024 21:01:49 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dde2f7sm67660945ad.77.2024.11.10.21.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 21:01:48 -0800 (PST)
Message-ID: <c92e6962-6f68-4659-87e2-487d1344163a@daynix.com>
Date: Mon, 11 Nov 2024 14:01:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/16] hw/vmapple/bdif: Introduce vmapple backdoor
 interface
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20241110215519.49150-1-phil@philjordan.eu>
 <20241110215519.49150-12-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241110215519.49150-12-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/11/11 6:55, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> The VMApple machine exposes AUX and ROOT block devices (as well as USB OTG
> emulation) via virtio-pci as well as a special, simple backdoor platform
> device.
> 
> This patch implements this backdoor platform device to the best of my
> understanding. I left out any USB OTG parts; they're only needed for
> guest recovery and I don't understand the protocol yet.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

