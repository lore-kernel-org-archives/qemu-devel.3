Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20A1CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJBW-0002SY-AA; Sun, 04 Oct 2026 06:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xDJBQ-0002SI-68
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:11:04 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xDJBO-00024L-J1
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:11:03 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-4a1706a2b24so1079355e9.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791108660; x=1791713460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YHryqTyf9XNcFGp/AMYKHxgM98QuaR14XphRGZqe/dI=;
 b=WDL2OsEScqfNjygR9LR4GnsdpaytoDheHIrzMVRELXtbIfd4I2wN+tbbDUff7WqiS4
 kqYU3v5ti7abf/sG9xIh5x86LielukKRDoazF0OO2peC6KoxMm/7WF+Y8cRxxVMO/GYJ
 GODkWxYBMtQ/vbuf9cKi2g/zxSuJoYy9m0Dd3grVsl+vYlC/yI8e+/hJod8Fk8upVggA
 KuAWMiVPWnyw7FL52O5jwvlEbSOAoRqHBPdCuCQhCASuYxknG2dJldkefa9R3947A1KJ
 chaXvzhu2HjdMnnzsxZPRpcnPgsPqojnvc+Vt/0lJw98wpBxhVSCI+rJ/HODUB7pnvaL
 mXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791108660; x=1791713460;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YHryqTyf9XNcFGp/AMYKHxgM98QuaR14XphRGZqe/dI=;
 b=VbK0NsAclojtfyb8f3O77YGfF4+nFc0yF0hKOJve7UjXPRk6RP1hilW+/nrEqAnwjS
 ONWxAMCmwP6l7MXKh79eJQdjal06jaZ0Tb7e/0XvjQ/7aYyOv2ygbd9LBwPIY5o5Gq5o
 0929sRATsecbxKJkd917Q3JdZhY3F2BAW0ccG4fLYWaHwa72UhFetSxm50NETVA88xNY
 qy5SDMjDXAKhGXeNBRpDOmT4k0nFhfOJRQeSX+rJjT7fsngXT7Mv1rKflAWujUnCR2BN
 8Tb1rYUctyASx5gUwqoADAq00WNc9pNNnThwLXLKuoIv6HV1icAOiEEsvmoz7Mn78nRq
 JUEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7SGD16Ss6iFB0Ps8pGDyVbbXO8RWWdnSViVLyx3zPMR/ykgeJfOvf/SN2VLeTAXM3xnbRNKi0A17N@nongnu.org
X-Gm-Message-State: AFuF++m51aCDDqyMB3XdSSSDmcpgwc+ulg/d52gjFe1Q0kNYE+XqVegl
 4l3jArluGRdN3ATiGid8zXxAoWM8HHJCLc3g72C44FHye4PZSstPmzhO/a2Jm/7kv18=
X-Gm-Gg: AYBFou2bc3+FDEAgMv2+Ly5rwYfXnd0vUIxGg3JLEuIe821CYr8xt6deGDRNuX/CeHN
 hXzChfET9OmPCHwkQL3k7J0PXP+WW995HRrq6eOWak23d/L9oef6q/NBEkfFr2ALR1ku1AwHY9W
 Jdq9HlTnt5V85DNx3tADKTAq58u/3K1WgJZ4hGyyivvDachgb2O7t7ogUjYaTe6K6xJlxOOulPI
 bBvktTvix0s9y4nnemuYmqraE5JyOfYKyGtzS+5siWkAiNMFKCWJWLOz0yTm5iVq1j4RkQyQrjE
 He9ACuOTNzwO6wXxeAO6OnL/+xrENQiPnUBHLeGGWoGBvJ2bR0fozeGn9NIP6f2iQUpcnanyWpq
 05cAL6jVaH8g9dbrdowC97Kap7gWkkItDKJqlKfgdPon3Jh2wIHJbSPtnaw6IueNyBaw4RbtJVj
 lIZaRRpgJGqwxq/IWfC3Di+35QPNLTd40lnZ/jH1/Ed6B+sY+jn74M/r8Tvz1bgo3sZW55nRmi6
 tky9kqJOdSfO9MJaVfeZbOpm1FZFHEsWy/7RX+TJQ==
X-Received: by 2002:a05:600c:1d05:b0:49c:c0d4:53d9 with SMTP id
 5b1f17b1804b1-4a16c4772c5mr47954595e9.14.1791108660053; 
 Sun, 04 Oct 2026 03:11:00 -0700 (PDT)
Received: from [10.9.5.233] (vpn-konference.ms.mff.cuni.cz. [195.113.20.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38105239sm22786083f8f.33.2026.10.04.03.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Oct 2026 03:10:59 -0700 (PDT)
Message-ID: <55e8f68b-10af-4bd3-9a23-cf21a826e2bf@linaro.org>
Date: Sun, 4 Oct 2026 12:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] HPPA A400 updates
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Craig Lalley <mr_lalley@yahoo.com>, Helge Deller <deller@gmx.de>
References: <20261002215014.45371-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261002215014.45371-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm2-x10.google.com
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

On 10/2/26 23:50, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit efa3b9d5ac8024078225e1ab434411fdfe53b457:
> 
>    Merge tag 'pbouvier/pr/tcg-tests-20260925' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-09-25 11:52:47 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/hppa-a400-updates-pull-request
> 
> for you to fetch changes up to 1f22bd961e7a512a59fb289daf218298e19ddf50:
> 
>    hw/hppa: Place the CPU at HPA 0xfffa0000 and fw_cfg at 0xfffb0000 (2026-10-02 23:39:28 +0200)
> 
> ----------------------------------------------------------------
> HPPA updates for A400 and new SeaBIOS
> 
> A new SeaBIOS-hppa version 26 with many fixes, and some updates
> regarding the A400 machine. Main goal is still to get MPE
> functional on the A400 machines.

Applied, thanks.

r~

