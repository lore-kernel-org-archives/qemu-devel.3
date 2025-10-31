Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB42CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmjW-0002Ol-Sd; Fri, 31 Oct 2025 06:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEmjT-0002N7-S9
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:51:48 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEmjH-0002hX-I3
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:51:47 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4270a3464bcso1517586f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 03:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761907890; x=1762512690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h+FnkYZFDp4Lw292UW1n71WG3c/3Nki6YoZZ9R9Pp2M=;
 b=Z2MtubhCfcpFqxlGpD/w/KeEo6Kv/GRj/ZqcXKNBh/BNEPf7sEh1qToqintxDJmIDr
 fRSDFLsDl+O92kisn+jhKjxG7xSm4WlL5GWiD2ogrLBauIvHGe8k/GzLHkc6M812cZLI
 d4XGkRbqFi1btn5/0aB6BLl6M85tseuRPsJdyy4epw7cUsTxuySUOs0g8fg7Txb1Sgri
 K+z9LgYtfn+wY/h+dkO2G41rqJeIpsu59JOsI66XJWfVKW67SvDXFRDMOoZU9eDXCqd7
 YkpxhVn93FVkA8zp4bw+28HgYNJ6oy72kfbutxLJynTDSTElFmi4mch9G74qMZBvmz2L
 6kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761907890; x=1762512690;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h+FnkYZFDp4Lw292UW1n71WG3c/3Nki6YoZZ9R9Pp2M=;
 b=vu4CFHfDi++AQxVz9KaRADBn6ibaQiH/qDknjRHj+bTBjJFsEIKck/LbkLs7BLEvC8
 r+UO1TJvmN1jphg7pn9XWx+r8l4K9WFLVYu/b4ykcjno8EQBlVnHxhEarU0I79O+FpyQ
 f/jYYkEXx67iEVjMZAl/m4+Tm98wfMo9/vTqJWe+Y5jUWLdSX4lKQsnKQyo4TX3/sgzK
 T73blDs4uv6ks6ZwlfurIBGOxM/L68PgmzblDocUhUcg5RC7jl75OPQY6JFd5kLeT/X3
 n3KE7SddqdtKthqTSAvq4RoNQ++z8UEYX1RfNSqYA7Ukync2yu4/vIBuuNs/LVBoSSzm
 uOQg==
X-Gm-Message-State: AOJu0YzPWgnTrh2xa5al8iWIjAffXtTEyzMvYKahmQRZoYfpUKp6x+Z2
 vlu+dWjiO81Zjpvr95X1AbFM4FTaKiHbIAbppZeEgy0uwtDBnfgEbwPxtp+V1B1f6Wg=
X-Gm-Gg: ASbGnctgeRJ/PZu/xFhI4y5wAnPet5YRctpVhbjI8gFoxAOm+WcVW/7l2KapRC2lTlc
 KCyrrd6Miy2zq2Lad3FsOm72oGkKlLvU4LnIR7+my8CVCthVBpxatwAOOKgcKOT9cDfgRF1ZY6C
 /NNHUda6hlqbzYf+EV5USrqR0+VNbf2kzYHo63llgeHp9KrnoSr66LzUg03aeHXYGK5YZ5iAr3J
 Aejl7dAIlmI2N3xIZvCy41qrtDy9rZFexzDm1AO4Av835/RpFJGX6zJR+4z6WtxFVzkMpadr0aE
 9vlNke2xnOz6QnjBW/flNeEKHk6XMxOGjYFpIY54UVmtbyZiq8QMKhee+uv1d3qFu4DCgG66Prj
 4wOwjoI7kWgN5DVU3D01D+AUUybJ0wkkmnnMdQHlIE9mRvDONa8qKbA/yj+5oZSVcLHX+v5XioP
 ETA0KUmKZRsVWd7dg+efOSqnasRB/G9S/cKevJ1hG/gAaYmW3T9247vUE=
X-Google-Smtp-Source: AGHT+IEOeJDIw15a3psdx2TelkDf96UtBc8hzl4XXKhv7GHOCpFC2/8U5kacyy0pDc0PbDY5OdloBg==
X-Received: by 2002:a05:6000:1a89:b0:428:5673:11d8 with SMTP id
 ffacd0b85a97d-429bd682cbdmr2545137f8f.23.1761907890219; 
 Fri, 31 Oct 2025 03:51:30 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13eae16sm2872142f8f.32.2025.10.31.03.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 03:51:29 -0700 (PDT)
Message-ID: <0942717b-214f-4e08-9e2a-6b87ded991c9@linaro.org>
Date: Fri, 31 Oct 2025 11:51:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/27] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC
 machines
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jason Wang <jasowang@redhat.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20251031113344.7cb11540@imammedo-mac>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251031113344.7cb11540@imammedo-mac>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Igor,

On 31/10/25 11:33, Igor Mammedov wrote:
> On Thu,  8 May 2025 15:35:23 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
> Are you planning to resping it?
> (if yes, I can provide you with a fixed 2/27 patch that removes all legacy cpu hp leftovers)

Sorry, no, I already burned all the x86 credits I had for 2025 :S

Zhao kindly offered to help with respin :)

Regards,

Phil.

