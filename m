Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52561E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 20:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRH4R-00008S-B4; Fri, 27 Dec 2024 15:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRH4H-00005E-6D
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:36:21 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRH4C-0006uM-Mp
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:36:17 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so5740793f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 12:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735331775; x=1735936575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bJBzFpT7aUuy2BWNtvX33lOSAzbJvJLAWdbFR1icwUE=;
 b=Qj6Wlz31XY4y9JhmaY8SH3jfoR5DTRJqtSKfrPcm9Kz2m/PHq806qhMT3A2Rdl4GVr
 D6qZUYKGu1ZFyK9GlBIpEsOJ7RQhxfIsR/87RHpjURdFSDuzuFwY3qDPMhpLztqTMhnc
 mSW1HNJQeMlx7vBIdFtOkQDwIDXWt4IwLarDtZr7ZD3tfUinHoaGrXwAYz3xxlrTAu1g
 RgB8SBvZNnVupEE6UzTeRrTuEVpUu+5QIybjLODmGWN92lyYTEaS0+QSUQv5+F57dmx8
 bCx+hsrUWQVi2HFOt4kM52+FgckUHQ+B4SjR2IgcoIAs55sl2/Y7oK/Qr7OeU2WxInu4
 wPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735331775; x=1735936575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bJBzFpT7aUuy2BWNtvX33lOSAzbJvJLAWdbFR1icwUE=;
 b=aLHsUP3keSMatfl4ZEjHQFyUkhO9BG9leTk8bSi/8VpSJEs8jwQ/Zr4PQQ+utHEG8N
 l3Yp2bGKgSleOKvwiqiodEgcMRF50F2vfoGV4TXol2jHcudOL4nAN2RVvHvkU6lft8eO
 3S1dgU+5XQ9jilsLFsubPzCVRpekPnLkxDkOA1GvIG0Ifp6niPajibHWrn+/EpHIv4HI
 hfszpJvki3Qj78lMhVJpyP9slHyXhz/lv1n+3jxe+2CoUViFfSZ3e23ef0YK9bU8LNtG
 RUJZJZZ0s1R8NYGI1khipkhGI2Uyo7XUNZpFyiONtx/cqdhsD3WlB6n5EtIZM25EDU82
 Y/pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEgInEB2289BbMRYunoFyhvtSwCIdnSp3O/lOD7TR5ESjM/gqxP9z+Bz4LKiQkuzHX13UfzICCpZkY@nongnu.org
X-Gm-Message-State: AOJu0YzMIi4JtIyAfRIpIzmXvgykwbOdgC0JxaUzeXX1h6EH6YiFsDtd
 9HtgomlgmHV6sCen2FkrG1qxfTxJrwINdowrYVf+KfMtZLVGwHqGgcBjZAWvIrE=
X-Gm-Gg: ASbGncuT3hCkfuKmMnkVMNNfbc5O2WEjmYKDRDjDquapJiwREZ2g4SuJilQckKVWImc
 c4JLvcQGYneBPXt94QKA1fSSp1QHwUrpOw0iRfK3zoq0qwsx/VmNM9i727l7yKEwm3uTxkEdTKl
 Qd/QEiOGpyqwW52CYbScetLqOw5ZmpxYIhwpwfW9DPpqzr6CKGWOr7RH25wBxZiN0a43jfSkH+9
 R5zDXtoHxw1OeyfghrxAjoooWmSq1mtux1m9DRRWG3/JdPV99RawihwKPA8QQBs6m+cOvFfcZY7
 9ZPtrTqFdMl3LNyvsf2j5Rka
X-Google-Smtp-Source: AGHT+IHEExWh8P/Fs7GXDRSswUG/flN6CCrniwRZM9ozusP2KjufDudnImZHN3Q1FUc4lRg4dRuvqg==
X-Received: by 2002:a05:6000:1787:b0:386:3c21:b1ff with SMTP id
 ffacd0b85a97d-38a2240ffc3mr20593891f8f.58.1735331774957; 
 Fri, 27 Dec 2024 12:36:14 -0800 (PST)
Received: from [192.168.69.103] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436604e9c2csm277021315e9.43.2024.12.27.12.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Dec 2024 12:36:14 -0800 (PST)
Message-ID: <2ceda358-adce-42bd-9f29-9a2e441361f0@linaro.org>
Date: Fri, 27 Dec 2024 21:36:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 14/14] hw/vmapple/vmapple: Add vmapple machine type
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, akihiko.odaki@daynix.com,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
References: <20241223221645.29911-1-phil@philjordan.eu>
 <20241223221645.29911-15-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241223221645.29911-15-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 23/12/24 23:16, Phil Dennis-Jordan wrote:

> Known issues:
>   - Keyboard and mouse/tablet input is laggy. The reason for this is
>     that macOS's XHCI driver seems to expect interrupter mapping to
>     be disabled when MSI/MSI-X is unavailable. I have found a
>     workaround but discovered a bunch of other XHCI spec non-compliance
>     in the process, so I'm fixing all of those in a separate patch
>     set.

Should we wait for your XHCI fixes series to get reviewed first
so I can base this series on top (removing this comment) when merging?

