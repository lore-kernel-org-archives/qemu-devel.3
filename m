Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C639FCF318A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 10:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLfLu-0001Zl-HX; Wed, 19 Nov 2025 05:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLfLZ-0001Us-E7
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:23:36 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLfLX-00024l-Fv
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:23:33 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b427cda88so4663126f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 02:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763547808; x=1764152608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YMNdMfgL+dB7r6DfRvrBzGm/xaMxaKdHYnYfphsi0B4=;
 b=E8Zxb9qSF0U0Rer4mR7tmE/4RtgfKY2af7ypr0hyh2eUehKqo2AIkVUSkwmepMlaiu
 xs51bBQUPc1CBFy3dFLCCHOxjkFo6zjmO3rBhYqnaOjP0B7cxoJmdnfSlSZKhy1wpB8H
 GGzkIC3XBH43Hr1aFYC9x1PVj1F55Ekbyk8vG37uluiU26mQzGh5zjabgTe0s63rLmHS
 eRWQQ9uEac1/fCwaZrkvwr/QSNatpnMW1Va5Guo1cJCW93BgDTaDWVyohyuXZRrf35KN
 1dOy8nCxLM4m0gHPmxo6yrDQb5EM2RBeXb+nz+3F6CM6kbJmtX0S7Rhovf6pwt3Qumbp
 YfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763547808; x=1764152608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YMNdMfgL+dB7r6DfRvrBzGm/xaMxaKdHYnYfphsi0B4=;
 b=RGJzt9Mb9VdPUy4htEP3xNrHQSVkWTV40S0rCxi2NZPRQli+T3iElsjBGMX4I3CT8S
 MMGgUdonqLk00lrk87+mgL5VZNEZUuN/sxhmlsvWSaZ8/I3+3wa5xbXFnB6dlvAZXTO5
 xB2tvwPftAIB6A2KPu5yx8kkwAuIKbpuWurV5fEp+JW/Zxc0/ILEaqJUFx8WlNbwZSIw
 16FIQ78Y0zp2/GnUjzcMJaAwNkq7qCCJzYzJf3AMv/9oOmxCZkyZCCpT4IKTFNgW/TrJ
 ku5+BPyiPxj9v6x1V4ZrVUljly2PaYtgkiMnyGBl/1NYbhgSsxKbhZz4xOqO6Cnm7100
 MTIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXau26PFtk7q1P3faAgnVLdT5DxtZP+f1t8c4EIVbvSlm7QOiQka455zTME4hMmwdyjDc75WM3i9gcs@nongnu.org
X-Gm-Message-State: AOJu0YxYMEsb0Ffqj2sZ+GRjSko+fTXfupJNuSNVoo/xM7TrEP27SjFJ
 mSdl0TcMkREbyfTc9wgz2q2SjStMb4lW2DwtR2kpP7u8SKt4lmqCxYhMcE6GpPo5EVE=
X-Gm-Gg: ASbGncsC4sRJBWKp5Fl9Q18tKkfdFo7JlHiU7auW+MV+EXPc78uIsDbBMLpn5jFzGOv
 MjqIiYw9WMlJgmKYm80Hyy9S7jDm8KU73mUsDx7B7suwfrbyatLAEzYMwTSZHt1rJSy+/UI2aft
 otLqtYIGi7RXbDfUSVbV5zXgM1fg60kTnUnVughieHEiDxAeOZnpRuUqiSwJiyFChd0Kh4nDAcQ
 EccbJzFcHx6TsGlcI2tePHVniNc2k0mJ/PpfnaIns0s1HsrJexWzd9ka3RMk2ax2wch+LTLPzC5
 egqbdUdZLDGImh9uDX1w30DSGO0Kqoh2hH0qypSIiF1LOWLkg9vi0KCWbbD0waaSaHBSIBPJD/N
 GjQT/jIStaUqrG2iJOxgSWzVoi2fF7gx6UIvfYuSF063ymc8iosiEqQWP7e7I6TAnb7h3hzUEp1
 bVNSUuvgG60Dbl8Cv6aD+onuPp5BQpqv3hdGvR+bCPYwAMqHYUHnv4RcGdvx0jpRhh
X-Google-Smtp-Source: AGHT+IF4I6ibrnvnJ3/UOsl5QiNU87RYr9gbByYdgexnCcp6UG0osjc6U7QggVRve/EhqjjuL82AEg==
X-Received: by 2002:a05:6000:1884:b0:429:edd0:29c with SMTP id
 ffacd0b85a97d-42b5933949emr17965587f8f.19.1763547808170; 
 Wed, 19 Nov 2025 02:23:28 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae2dsm37443573f8f.5.2025.11.19.02.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 02:23:27 -0800 (PST)
Message-ID: <0a385c85-698c-4e19-98a8-71e5ed818f59@linaro.org>
Date: Wed, 19 Nov 2025 11:23:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 12/15]
 tests/functional/aarch64/test_reverse_debug: Fix issues reported by pylint
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Glenn Miles <milesg@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20251119082636.43286-1-thuth@redhat.com>
 <20251119082636.43286-13-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251119082636.43286-13-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 19/11/25 09:26, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Don't use underscores in CamelCase names and drop an unused import.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/aarch64/test_reverse_debug.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


