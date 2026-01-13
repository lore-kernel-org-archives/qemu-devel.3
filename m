Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752EED2D0FD
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 14:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfexd-0007Hl-Ix; Tue, 13 Jan 2026 09:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vfewg-0006QE-9O
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:00:35 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vfewe-0001Cg-JQ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:00:30 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so76481885e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 06:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768312827; x=1768917627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Zac00euugjIftyT7AIVVB1b7PyfaqNBS3tcrkWDujE=;
 b=y/krsT8JRt+kgXHMepb5mVcmn74uV4K2wi3wBhX0rjO9/BygDNVmzWjXpkgeIrFkUm
 qkPzvzd4xwL71o7ZHbEoUwJJCAG0J1okR1K/UwSgxHhsBHpL6TsB8g9vh5VBiCZRhRa+
 /YN2JBiQU3AMZlk6a1Dy/ItLeSfNZDW+vrOT1aauGywisbTDBfI8FB8+7hQM/Ha4rjeM
 clz01KFde8WGPkkT1z6cccbOxNVuIZuJoGLfthX23/ObqofwthZoFXFnPujIVjzc/vYQ
 jvB9gI2SYNPpthMW2/Vepi8x0EWXPH4SShNZPTB+MjC5tLyQ2Du39nX+U/fYVZqetgDt
 dxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768312827; x=1768917627;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Zac00euugjIftyT7AIVVB1b7PyfaqNBS3tcrkWDujE=;
 b=HFg0goCRCGVQw6gKvnGe3hOD416tngOViHCfGnfcJAhSBafiq1zOI3GT1cfakd85zc
 PIcTaFBThvi3uCx+XEsZRf12y7tRnutbbbDxe4QC5dZkVods2I+1wZKK2k4u4IwzcTGk
 fCYX2Q7k5/P/UUvzrixjyNUSfm4QntNyvSZhqIGv595fV6yNfX8X6T7uaCLNjRyDSejY
 THf147/6MXCNaLWGNTho7mHZurKz8lgzz7XKeOrD123YCiQeJ2nFm32v+6w8I6xzIYy8
 YkKs55dcQg+G4CXBVHuhFpqDMrnuOv7i6vYcc4TorI41uRutIc0roqFtZTeppOWCGji7
 gGaA==
X-Gm-Message-State: AOJu0YxOhKBmMWtrUUoclA7HZu5fF45SzLjz42aPrFFlAxinwMGv5u/4
 WechxNF5viRCVEs+NtsBvDnngd9r7VAoF1KArTdVJPjugxjH8YSp4fKViD3Qf1EWVvQ=
X-Gm-Gg: AY/fxX66bAqqugeFIxxZjx/fy9AXF7s3gCcKC3q//bUI0nKyCI2qxQCcLUqsogFDdse
 GPJzTVyfcjMCKEwCM6BLbFGvwB3orLbd15cCP3guTLmbv4lEEjBkPiFaBan33+q5+M6z1jr2LYD
 yb1cWmQjMXv0HtegoxdQuOLlL/oR0Hx4fOOMbuXJz0Bz1LF29u+2zAvwY3SAkVKysum680ct177
 iPRGadlyidHoGZEM/t0MgaS7qAxIY4gXL0drWHLsj8rHhoZDo65jChp4lOcP4kiRhFre3/a0r/i
 RsipVHaN8jN+3jHwwPmLAYbpbHMrHXJzSBTAZ2Ll+bpL5wuXEXuxILaxF4e817T9DFTlj6aCoSm
 zQXzYBOVOcdRbbupxEH4lj66hJPrW/sJx/FVrZEADsQwVLYvYBspkKqNaFoeY+ZGhxk0nTjA72b
 KwTvxDbw01WgHMHAR8dV4GqQ==
X-Google-Smtp-Source: AGHT+IFjYYBwq43MslnARq043/5r3kfg4K3nsGx1cQwDKi40tlDkO9QL60vpnkPn+oV1n+kQAQQDzA==
X-Received: by 2002:a05:6000:420c:b0:42f:bad7:af76 with SMTP id
 ffacd0b85a97d-432c3775a39mr28025812f8f.15.1768312827019; 
 Tue, 13 Jan 2026 06:00:27 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df96asm43589627f8f.28.2026.01.13.06.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 06:00:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB40A5F805;
 Tue, 13 Jan 2026 14:00:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>,  Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,  Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Joel Stanley <joel@jms.id.au>,  "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH] tests/functional: migrate aspeed_rainier image
In-Reply-To: <1c0e0499-97a7-4b3a-a116-a7c781d23a5b@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Tue, 13 Jan 2026 14:15:45 +0100")
References: <20260113115138.3171479-1-alex.bennee@linaro.org>
 <1c0e0499-97a7-4b3a-a116-a7c781d23a5b@kaod.org>
User-Agent: mu4e 1.12.15-pre1; emacs 30.1
Date: Tue, 13 Jan 2026 14:00:25 +0000
Message-ID: <87jyxlk3ye.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 1/13/26 12:51, Alex Benn=C3=A9e wrote:
>> fileserver.linaro.org is going away, migrate to the new share server.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/functional/arm/test_aspeed_rainier.py | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>> diff --git a/tests/functional/arm/test_aspeed_rainier.py
>> b/tests/functional/arm/test_aspeed_rainier.py
>> index 602d6194ac8..025e5751dc7 100755
>> --- a/tests/functional/arm/test_aspeed_rainier.py
>> +++ b/tests/functional/arm/test_aspeed_rainier.py
>> @@ -9,10 +9,8 @@
>>     class RainierMachine(AspeedTest):
>>   -    ASSET_RAINIER_EMMC =3D Asset(
>> -        ('https://fileserver.linaro.org/s/B6pJTwWEkzSDi36/download/'
>> -         'mmc-p10bmc-20240617.qcow2'),
>> -        'd523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd9=
0b')
>> +    ASSET_RAINIER_EMMC =3D Asset('https://share.linaro.org/downloadFile=
?id=3DPaCHfyerwpSr0CV',
>> +                               'd523fb478d2b84d5adc5658d08502bc64b14869=
55683814f89c6137518acd90b')
>>         def test_arm_aspeed_emmc_boot(self):
>>           self.set_machine('rainier-bmc')
>
> An alternate location is :
>
>   https://kaod.org/qemu/aspeed/rainier/mmc-p10bmc-20240617.qcow2

As that keeps the filename as Peter asked for I have sent v2:

  20260113135941.3361163-1-alex.bennee@linaro.org

>
> It is backed by OVH in Europe.
>
> Thanks,
>
> C.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

