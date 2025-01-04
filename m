Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1486E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 15:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tU5rn-0005A3-6C; Sat, 04 Jan 2025 10:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tU5rk-00056l-7D
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 10:15:04 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tU5rh-0007J8-1C
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 10:15:03 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so233000855ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 07:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736003699; x=1736608499;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FU8KhsuOqn9kBc9Geg/C01qcucshJGqJzoeDRPZsMuI=;
 b=OKFFU4EQh1bPWgj1N+o5mUl7xw4pwlDKpMy4YrLGsUbFTvORsfvDME6xWyov+uLf5i
 zNwPL0UuNYfgek0YbjhEDx946SEfxOT0bF8a/5METEwPXzFPOWWIUqKpRR6+/YgPUo7k
 fBfxKdQHStTkbwTAGYDNSui0q7eDl/n9L31fWDPRAySB4lu90mRcRHBKV69GMAzELtC0
 wIGes42Y/jNbaHU9hF8YObQLSziOTMYyAKf7OvBPJ/gyY2j30VAcwEGcHBSUNImijJFY
 lR9lYH1aEBSaBlCBnvehd85kkr+IMNBsG4q4BtL2a+1xTzsWrQoYFCRbJaxUhR121nAJ
 neJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736003699; x=1736608499;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FU8KhsuOqn9kBc9Geg/C01qcucshJGqJzoeDRPZsMuI=;
 b=dLezZ1MWwTi8LPcUzaJO+CAM0rdhH5UVJe9mdH0Ie5vpKwQqO6mVotbSaTwnTuBMrQ
 e3db5oijqJwOZrlV2RN9hJSW1qJfaLec1S2zvLJexWzFSEiFPJRrTlqhCc+6dWKvb3an
 U9dd5bjYDlHVPo7YMleVgRNE8TRFwbdEPO3RXL8MJ6e5lklSpZ6ca8z8UBHo6dHaUZSX
 ejYzZb9Vi7Nu6cefdPBURYVA/sFW2HXZ1oQDexdc17obNyQtwWsRp/xQ9P5PU29SJUZQ
 QfXgL3Scc2cMftytwGCC5DPpLYIBmTgf0djxlT3n6soeUofj1Hb/X/rObhFqP81dl+AW
 4bWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIQnd2Kei8bEGiyvuJu60MSHpeYejuVmG1oJmbZygHqgQHJ88rVJTjTO2hlO5rouGl6Ne7fsK2OAQS@nongnu.org
X-Gm-Message-State: AOJu0YwB5cqWKRNAL5nWQV/X2T4pymDrjQNhrEV9jXLb5qjy0Qj+jsIz
 sI32Sv3hOIqjKQAPPb2IxC+RswC6eq1OiEqfkL3BgmqWHeUXUHynJ3OGEACCcQE=
X-Gm-Gg: ASbGncsSnw0Sf10a2JeHDrfucH2QBv9OwB5zC959Fd5AKd6nOoUivQbOEGu/rpvG414
 QhsBkcWk+AAX5Rd/P2kulA9RGO0L2lAuqyy+naGq0j3UZW//i5BxJgABS5Ahj/v06MaS0UK3V75
 qNFGZpaTJVpOLjq7F8tLibIPRAQsFakrQJupmqcOYIs/NsWi73g6W7PYIRsdI2UFCt1ZNK3my5F
 h+8QCMrm8KYCL9u71wHuvrwBiNLPMHpq6V4O7LVZA2isDYE9plOanYihT0Ce1s+x+eDftqjjaTK
 +l4rZw8I1Zf1VHa2J7fMffLJPXD/VgbyWtk=
X-Google-Smtp-Source: AGHT+IHvLoFu8SW3TrNF9hoHcnFd5fO6ixmeLIFvpg+G32HnntIHNSArsvoff/mOAhlIvc3Lplh1QQ==
X-Received: by 2002:a05:6a20:158c:b0:1e1:ce7d:c0cc with SMTP id
 adf61e73a8af0-1e5e081c937mr92420333637.38.1736003699417; 
 Sat, 04 Jan 2025 07:14:59 -0800 (PST)
Received: from ?IPV6:2400:4050:b783:b00:4952:3c52:120a:27e9?
 ([2400:4050:b783:b00:4952:3c52:120a:27e9])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842b8e885dasm26131662a12.48.2025.01.04.07.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 07:14:58 -0800 (PST)
Message-ID: <34ddf42c-8bb1-4155-90cf-69e1032b0437@daynix.com>
Date: Sun, 5 Jan 2025 00:14:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 14/14] hw/vmapple/vmapple: Add vmapple machine type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu,
 Alexander Graf <graf@amazon.com>
References: <20241223221645.29911-1-phil@philjordan.eu>
 <20241223221645.29911-15-phil@philjordan.eu>
 <2ceda358-adce-42bd-9f29-9a2e441361f0@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <2ceda358-adce-42bd-9f29-9a2e441361f0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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

On 2024/12/28 5:36, Philippe Mathieu-Daudé wrote:
> On 23/12/24 23:16, Phil Dennis-Jordan wrote:
> 
>> Known issues:
>>   - Keyboard and mouse/tablet input is laggy. The reason for this is
>>     that macOS's XHCI driver seems to expect interrupter mapping to
>>     be disabled when MSI/MSI-X is unavailable. I have found a
>>     workaround but discovered a bunch of other XHCI spec non-compliance
>>     in the process, so I'm fixing all of those in a separate patch
>>     set.
> 
> Should we wait for your XHCI fixes series to get reviewed first
> so I can base this series on top (removing this comment) when merging?

This series no longer cleanly applies due to patches merged early so 
please rebase it.

It will be nice if you also:
1. rebase this vmapple series onto the xHC series and
2. move "[PATCH v3 6/6] hw/vmapple: XHCI controller's interrupt mapping 
workaround for macOS" into this vmapple series

xHC changes that are not specific to vmapple may be merged early in this 
way. I will be also able to test all vmapple code at once.

Please use Based-on: tag when you post a series that based on another. 
It will create a Git tree that I can use for testing at: 
https://patchew.org/QEMU/
docs/devel/submitting-a-patch.rst describes the details.

Regards,
Akihiko Odaki

