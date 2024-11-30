Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C193D735EE
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 06:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHGnp-0008QR-GG; Sat, 30 Nov 2024 01:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGnA-00083z-5U
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:17:27 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGmr-0003AZ-L7
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:17:04 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2153a73edd5so10947775ad.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 22:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732947419; x=1733552219;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SMWMQmaQNFbs3p5wPSSszQIsEvcT+kEUXSJDlAfkhFg=;
 b=OQ9uEgERxgHrwzbNTU6aRTmtjnKIlWGtIuHjJl5Wj5bhPsYlh5iuL8h9d/toTuKWuB
 Hq1G8kEJ+9/TtMhChBSyBGmzrTfNIFDN3Epo1Pg2kIQ2TlDWGEineusHBlK6p6XcP4QA
 MqM4ELAkUZGe7dB2o0dblpr4Jcwo6Cgkgt5jSJUwT9rF56CHKInVPLga36RZSYVY1mQA
 Dh9rqPvWm+UYPtVno2vdGEig2dhxJj7Pw7JWFBTnh74ny6LLYI6DABtyn4lHbJCUvTkl
 QrJjuK5OPAtlFdg236w0tlJ9arffG/2r+hCNm6jHyIlqcbOQU5UY4b1e1lSxmm5Fqh3O
 zYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732947419; x=1733552219;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SMWMQmaQNFbs3p5wPSSszQIsEvcT+kEUXSJDlAfkhFg=;
 b=QXm60mxACNUWNjbSyvuBLqY4ppihxP+SYLQIuKuCvEX6iFIN/kqczI/Dv0AlYJFqw5
 uGBTuFTkwllxLb24NOzVvPV+FvsFceJlrvqfHXs5As2JMryDeMXfD1qzRJZcC17p3yhB
 NUGoXJeJUrFVAjsJNq4fI71Uq4KP+icEUHw3OVycl/qXAE6Cf2UP+FFCOo0yMa71YcUI
 Hu1cuMaWaCLchYFwFWbntzuRcWanswfm0Uo7Usm84MB0fG2s+PQPxgFiNEZlGTyho/9S
 rNSAnH5aovqS/AHFi4AQInJOimS4lLKW8RHlf5D17ckQRchskGn0FYThLu84B7ugjFlX
 Y9KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJBqdCEU65ma1XpSTRwwjIWRhfB7Ol/WQEeSxZRINOFaPL32C0vrZ/QdcMWoEaiCHBulD5Cgzzf+Tq@nongnu.org
X-Gm-Message-State: AOJu0YybXhytaoLQRAM+7m6wFA/DmiTXphntncAeLYl4uQa/Wy1EopUM
 xc7v97KBpdyFnZnN6FO3Df5mTAkypiqcfLfTQ5Sa85ENq+X3MbgE0rtbKtRVHSQ=
X-Gm-Gg: ASbGncuelMr13uLQuzxNYu2jbxIstcEObKnuieuD9zITNcziwmJ9fUt523hUTWMkCUh
 1bcfAIo1KFo06izj/aNYF+FUxQU+fbY4V2YwKZ5Uj5s/P5R2lbv8vkFHAvJy4oXZHcsL0IMHAoa
 Esu/mrSUxDQo2hFTXe5Os4G9clntYWZ/cuRGME4w38eQtSl+bi6pEqifX7UmjLCviwarfH2AVD2
 Ou1UQaPfxzi3CtW4p1juFPzf0/t96b3K1ck+kAz+vaUpprLKrh7ofdRgC7Zahc=
X-Google-Smtp-Source: AGHT+IHdgLpmBQWQf82JwBGq8q7QIpIow/7LNwAgRaz0kozm05KgQe9esf+MmtJnS5oK3ZpDikNylw==
X-Received: by 2002:a17:902:e881:b0:20c:c086:4998 with SMTP id
 d9443c01a7336-21501f622a5mr127905335ad.55.1732947419396; 
 Fri, 29 Nov 2024 22:16:59 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215475446e0sm19259595ad.92.2024.11.29.22.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 22:16:59 -0800 (PST)
Message-ID: <68b1a9fc-3a73-4c6a-92df-af69d20ce59b@daynix.com>
Date: Sat, 30 Nov 2024 15:16:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 11/15] hw/vmapple/bdif: Introduce vmapple backdoor
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
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu,
 Alexander Graf <graf@amazon.com>
References: <20241129152506.59390-1-phil@philjordan.eu>
 <20241129152506.59390-12-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241129152506.59390-12-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

On 2024/11/30 0:25, Phil Dennis-Jordan wrote:
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
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>

