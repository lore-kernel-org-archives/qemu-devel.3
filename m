Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C649F8DFC5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDU0Y-0006Oo-C0; Thu, 16 Apr 2026 17:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDU0U-0006Nq-JW
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:12:14 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDU0T-0003rp-0g
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:12:14 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43cf8d550bdso7704058f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776373931; x=1776978731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h7HtmNeSlzJlliYd6IcLHgFl48vgsg/j4igni+zIcOk=;
 b=rPUQqqVf9RE5D1A31W6tkYQ81FetEdraWG5ea/btf57M1+lP5LRp/GuVYGgSa+fgm+
 AwG3Nuxe+20q1LR/NcMBVZkIm8O4pOh5fuNqrjn/ONUI7eVfPPsTKKepx7A4yEaC2dlX
 1fkr6wYHo6DwfSuJWR9hinLc3fPcB8jtfHhdebM46Z14k8flbep2vPPyUz5Eqv7Ua0Q4
 nr8o4S6KC6o4lnaC0QwyZ1oUam3g3w/epS3H1xSYEkbBsIb25s5e8/R4c/Gtxxm/xQk9
 g2fma8+fbgHt3TmEVEEgO3LwOFd/adw6uzHYC9DZP6vcAC0gVup0SyCR3ojB0o1MaFO4
 rDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373931; x=1776978731;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h7HtmNeSlzJlliYd6IcLHgFl48vgsg/j4igni+zIcOk=;
 b=DUAdzT2WZ8Ad7kI0DbGIY9RrxIqJOQaHWZU7co//W+9OKINlK6iP9P6EOKllbmO6k+
 1Z7L7buNpmumTLJezbCZqhxcEVTNb5vx80IAdoyuvLNiwpNoLBLfE4Am9k1ZXIiWfZL1
 HywNHPtYoG0KGCBgJup1dk+HjTghY9BOYKVMnoo2SIYF2QCth76TDwrlpYOwicRahVS+
 TX1izae7Dvw1/PM/voRqoBiNjalQhPGOLYRTI/eHsz2eATBxDqo4xnklbGQjH89epChz
 eIm6KSxaYuknVq/C+MxR3E4w4MmikMUPU7Vx+Gl4ocZuJgJnLGLjcyDX8PZIwqsh8AsS
 Z4CQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bgIRcxwQtFvC5zqo05KY8os0A3QzIGSO51b/eG+gIMns7q67LKPxLQ23auG2CivzEbxUcsNgY8Yyw@nongnu.org
X-Gm-Message-State: AOJu0Yy1JJETvU1Bim2KinMWBu6x9mdw7mm0lJQQ38xFQ6k8YMdo5/4e
 WfiZ+3k6XDLfVPSuxXfo2A/PQrXqomJZCGw1IVyuRCB+1dGaydMMPndHPyDXwu0e5CM=
X-Gm-Gg: AeBDietzERTtPDkkAiqlBDY7pLwyhAWzu1ApIcPSmURU+Yp7+5KZJGyOCrXfFpwLwVh
 7qJvnz2NIegY/5JH6dJvhUcPWV7Pl+Xk1Np+9gGPiC6B3sFk7wBymMiOQz+yEJA0MlE5cwEukO8
 KWmkDh6lqGewhm9lysYpKGbHaROGFwSMZJSnWu/nVxo3SUdiujz/VbYZIx8EtUQj956zpPQUQO4
 E00wXrwZ0wSlppNNWToPMndZcvTXxOfNQF0Tc4agveXhtLSkK7uKYnQVs5oYMEIqnVfZMKmE56U
 yd4tWHpL9rlBKX1s0fkprtL/6bQglDhvm/HxDZsUHe4zyP2j947Ioi8PxYYRtmUZ3AEvXb0ujfy
 2CLvSqfuGCWtaQ0+viPnBNxoQUTCNBZ7K7NPb2uXZ21QztOW2cnVLx7iRYygNaRt1NFfsKgzwZo
 Tp0AEK48LNwoEpm4TLV0khn5QB3G50bL+c4QMHB7v++EsXFteDXZjycnz053eSyACn0n2Ve4jDa
 yu2
X-Received: by 2002:a05:6000:4283:b0:43d:7b85:6c95 with SMTP id
 ffacd0b85a97d-43fe3e144d7mr133108f8f.33.1776373931421; 
 Thu, 16 Apr 2026 14:12:11 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead401ca0sm14626190f8f.36.2026.04.16.14.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 14:12:10 -0700 (PDT)
Message-ID: <b33a0552-7202-48f3-a6c3-89157e54312e@linaro.org>
Date: Thu, 16 Apr 2026 23:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] hw/hexagon: Add globalreg model
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-2-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416210305.2255579-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 16/4/26 23:02, Brian Cain wrote:
> Some of the system registers are shared among all threads
> in the core.  This object contains the representation and
> interface to the system registers.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Sid Manning <sid.manning@oss.qualcomm.com>
> ---
>   include/hw/hexagon/hexagon_globalreg.h |  56 ++++++
>   hw/hexagon/hexagon_globalreg.c         | 240 +++++++++++++++++++++++++
>   2 files changed, 296 insertions(+)
>   create mode 100644 include/hw/hexagon/hexagon_globalreg.h
>   create mode 100644 hw/hexagon/hexagon_globalreg.c

Assuming you'll end merging this:

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


