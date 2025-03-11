Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51059C2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts4mg-0003Ve-Cz; Tue, 11 Mar 2025 14:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts4md-0003V1-ES
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:56:55 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts4mX-0007mX-9Q
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:56:55 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff04f36fd2so9908404a91.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741719406; x=1742324206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2FGJR3OFZHYZRlflYXi3dDqCcp+55mpMUge8uADooeM=;
 b=ERLpCIakqaAEwcyfQz+f+Jf5PbdD3olsP05jfSi01/dSoATGybm+ASYIhruzhwapHP
 eOWG01OpebewJ8yLuwpI4+Ub+VEQTiUQC+k/Zwo3rgJJ1JMGA37eToXQddC0onDGsVe0
 xb6TOo8q49O8X6XClCxJsGD41sSnVgAsbAk7KDiMNE40Byspy+Xyuvv+MJyMZFMZ5X79
 6fwYFhOZx7YgLoVyNMZjzdoSo1HBOR2hGyHJDusv700VbgXOFiOLfQKw/dyV3OX+75zY
 eLMU8gNZv8mSdaFznUl4dcMMEL2g3nJAUA6lXDHgeryS37MDJLdxdy8cpQia3fJjTnSW
 bN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741719406; x=1742324206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2FGJR3OFZHYZRlflYXi3dDqCcp+55mpMUge8uADooeM=;
 b=heANKAtSz7DXDJ5qzAESR3N9VCicinn+kGJHVx1oEeqU6l2iJYxyUt1DvqCnGc5hHn
 1vviD/VdZc2/aHOuBJzigebbRhh4otX3+A4iRbJ8ay84ow1fkVGo7mWcjaRHi0wF/6aW
 ZxghQ/Kfu0zjbcKboGhcaveGLHZWDB2yx9+UqCD2h65qJdsReWunJic7MUelYTC6oYC+
 Q3trQSNwUx1QQJO0+qjT35IznxjgEOyf3vGucleRpn84FGQ4RjKlGdMxZpTnmaIwDODv
 rCK11w+38ycU2YTv9RmRbe57PdlABj+MhtdUm3010+c719n5m6jJmSnf9TBNPg3xQ5zs
 2Mhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULpqC8BWIfMUHebp+oepWTAR7wwGBqZgharrEow7gHGCWGvFcOio4nZQ2zpVLFnqd4h7q/wdxcPRtx@nongnu.org
X-Gm-Message-State: AOJu0Yx7f+x5LRf3t6ms6S+GMjkvJtXd02tIGFm1xcNXj6NG1HaHH2Ks
 sLDghAhtktKkS6oqliVoSQercOPiDFpKm5GqG3Sx70q2paUzVYmpmBaDiJhwrS8=
X-Gm-Gg: ASbGncs3jM/AMdWO9/h/EISIqfigDQvGR9H7kaYLFDr6oPmYgebRfV+gEwr2w4Zdsv5
 TiIuVh38WkESXOPnK4hsj0Z7lg+lf5EV70tAavcUXdq38DavIjXHW55XTFviBUh7ac3wjrxUb3d
 LCm1ZZg2FQ8IsY5d/5ouLLG3y5Q9PnX8BA5LGKoIlupzijdeozpGtaKOsCvVTdJr4gTftItQJMz
 bZ/t+5KQQZ5b39qZuYlHsl8k9K99Kz5VOolwKwpL6Pj9N/qZp1AbMFrctnkwRbzluuG54JIlQF5
 JWTl6ySymFmBDSdDydlBHxy+Y6W7IS4j9tAgYLJPXG5/fngANO2c25aaCxJ8ehpzK/XyFp98711
 7G0tLbHHf
X-Google-Smtp-Source: AGHT+IEJrbifPG0KoLo+9R5h6LoFtHOE5qe4DzPjx5dJymwxddV1CBRFZYa8SjbQYBXHBg8H2ac5nQ==
X-Received: by 2002:a05:6a21:6b04:b0:1f5:5903:edd3 with SMTP id
 adf61e73a8af0-1f55903f155mr21643279637.11.1741719406462; 
 Tue, 11 Mar 2025 11:56:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af557999afasm26204a12.59.2025.03.11.11.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 11:56:46 -0700 (PDT)
Message-ID: <e454ab52-fb0e-4698-bbc4-06350db10a1b@linaro.org>
Date: Tue, 11 Mar 2025 11:56:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] arm/cpu: Store id_pfr0/1/2 into the idregs array
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-11-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311162824.199721-11-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 3/11/25 09:28, Cornelia Huck wrote:
> From: Eric Auger<eric.auger@redhat.com>
> 
> Signed-off-by: Eric Auger<eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   hw/intc/armv7m_nvic.c     |   5 +-
>   target/arm/cpu-features.h |  10 ++--
>   target/arm/cpu.c          |   8 +--
>   target/arm/cpu.h          |   3 -
>   target/arm/cpu64.c        |   8 +--
>   target/arm/helper.c       |   8 +--
>   target/arm/kvm.c          |   3 +-
>   target/arm/tcg/cpu-v7m.c  | 120 +++++++++++++++++++-------------------
>   target/arm/tcg/cpu32.c    |  52 ++++++++---------
>   target/arm/tcg/cpu64.c    |  44 +++++++-------
>   10 files changed, 128 insertions(+), 133 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

