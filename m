Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79539D735F3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 06:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHGox-0002UQ-6w; Sat, 30 Nov 2024 01:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGor-00023r-KR
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:19:07 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGoo-0003zb-VQ
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:19:05 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-214f6ed9f17so22484185ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 22:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732947541; x=1733552341;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F7eEVoPnO2WKUyPFuL4ubctiQXe1HKtwH5FMNFuU+30=;
 b=TIxnsgtVri2untZh4/5G21XY7/c7cPfWBY+XF5dyH86Zl4uunz9/cU/DPLMvXECxKq
 PK1Q+g9XSnL7Byn3a270S2yZ0eXa/nBTY0Hv5TTbgq16lVQkCoRPcTKUYECqbkJieiH8
 9Z24PjOPJj0bNPa2Vsi1bqyuirard4xqsR2nZg6mL72YY85BWjMOaWNJYBkbrhgFLGQ4
 a3Jfo5MlLMGJbQfV+ZwsTaKMdifsJpxd3Q6RxIswIEeBdiqZ7SQhyKDqcobAfaQ0g5fz
 4vbeXIeQPmt78oyvBgkyU8Nl/xQskYRBL3UN2Xh9PUCE8DQ95SS1BoYYJsUTU9iJqPaL
 kqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732947541; x=1733552341;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F7eEVoPnO2WKUyPFuL4ubctiQXe1HKtwH5FMNFuU+30=;
 b=gKTOVmEWcvK/OgzP1orKPaYkkbD25Eq1HCh/zZAInab9n31Dww+R18LYaqrRhfNo6c
 fXvt0pGkNCJmZEigLI5fc9gN96X1qDKc3+PkTu8hCuj8H1ivDhTZ4O6DgMPWLqxgGSRO
 ai22KGvpbXJOlvjFtiyFglKH7B4t6qXsO28tOLnmxW6JdfPVgbBAx2SNEITNOU+q0QnH
 VAxW350HnZlBanT7J6ggYBZ1lZpYYsRsN4DlEQYyshotqtTCl364VulZLgRzWi2aF6Kk
 DvFkkm4VyqAk1VCgAxI/aYkSVWpDNluVwlI0U+xsjnDOO1NIhixdQpvHBbvvome95vi/
 iNkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6koQ4stP0nF/FRl/2Dy4VrVm7obzegsLzxqwx4+ypFeBL3LsmOOCcaMdwAiNzozyZSPOlBqYJiMf5@nongnu.org
X-Gm-Message-State: AOJu0Yy3vJ7MuCtHdyV6Uv6Y1Hq1LORqSEK2dJh7OQg1lNN1aHO3E+wc
 BT/8b6yVI6LcytBih/1WhypPjTtNBlSS44qpujG0TUsKbUBm6mk2c2iI/zh6hBg=
X-Gm-Gg: ASbGncs9Iu5eoiBpibAvbkoCz3EtyY8hE7I9DBgAPecLRnFag6uWz51I78TAPX9WrOO
 Mg3uq3DeddRuM1p+oBee8IDzvItS7vGAo8xyHBkVzqIRMHGPVz44E8D4rClF4UKGnyMFT/3wHXC
 oaumAlT/UBck94EtC2cF9LiS4zTLf5wdrw+8ylW2pd03M/QdH2e1BxBDIN8luoVRxSn/3WIojEq
 Z+8SEG2ON3IDnISwT5240KDbPenIOBCO7CDtC6AfFn26Emd8stbcpuqrPC0gso=
X-Google-Smtp-Source: AGHT+IFLqqaBUgl6riliWebUXPUYDh35roHwCuLbYjrzZVvhqmzY0tnQgLHbDWt7XU8ZV0r1UbInPw==
X-Received: by 2002:a17:902:f60c:b0:20b:5645:d860 with SMTP id
 d9443c01a7336-21501d6192bmr215183985ad.36.1732947541473; 
 Fri, 29 Nov 2024 22:19:01 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215341064e2sm32108515ad.137.2024.11.29.22.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 22:19:01 -0800 (PST)
Message-ID: <64c65beb-f79f-482b-b239-f050960b01e0@daynix.com>
Date: Sat, 30 Nov 2024 15:18:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 13/15] hw/vmapple/virtio-blk: Add support for apple
 virtio-blk
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
 <20241129152506.59390-14-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241129152506.59390-14-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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
> Apple has its own virtio-blk PCI device ID where it deviates from the
> official virtio-pci spec slightly: It puts a new "apple type"
> field at a static offset in config space and introduces a new barrier
> command.
> 
> This patch first creates a mechanism for virtio-blk downstream classes to
> handle unknown commands. It then creates such a downstream class and a new
> vmapple-virtio-blk-pci class which support the additional apple type config
> identifier as well as the barrier command.
> 
> The 'aux' or 'root' device type are selected using the 'variant' property.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>

