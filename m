Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41633D31A08
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 07:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgIDR-0004eB-S3; Thu, 15 Jan 2026 02:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgIDQ-0004d0-10
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 02:56:24 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgIDO-0002o7-L7
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 02:56:23 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a09d981507so3805665ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 23:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768463781; x=1769068581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qvSxvzFQdbcXzJb4lGNhulQQJhcGCTokFA1T1vLJv5I=;
 b=drD56ju+dTqeOicxF11s2s2jF8QeL/ry+Bz96gocyQUxM0DUT0lWMHA1zsH+DwIeuK
 mSD1zzdu3UP718MUH+6ivfEtyc9hhzggDYT5zZGuK2f5v+zot1+JVt+T1yXUNISqyqwY
 6htNXylu0i0O/oRHvJikS9aN8CB5c28QDSZMuc3Uek1Va1I1yQQPkqB2/NBr+Q9tpZnd
 XOJFRepQfwghZSUuFusQwV9fWBEG6KqpEroD2Dv7083tDXrew9YIK0Q98mR3EdH54XKw
 Zm/R7En8m32/+itUTyM2TxRAZGwWXbMayziWoS/b36uCdJ/edO5zNsMTHNCa9QQNUTT1
 OP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768463781; x=1769068581;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qvSxvzFQdbcXzJb4lGNhulQQJhcGCTokFA1T1vLJv5I=;
 b=knHUQUVrHsuLk/dewZXtMqxAbsXYODJUi67Gtpt0nW3A+YhjGsjeKhixKPj/Ut8gB6
 AYml25Kz41jyMutLgaOHsTuIVAL5dFCswvn9fXpEoD6gOvfRNcZUisWY7BdT3uZ1uVRa
 /tS8/7m1BSQ5uTO9re8Xsb/3ZcfoD0SIzs+dUXMezHN62ySJ85hq8CwPIOfWql94yZSP
 IL3ir+RBnD8IFrm3r5K2l8esKg38lV0PdjEZkydd1riXiZGIdmCK+Fm+x6Sp3rdQawXu
 QF26uw1oDUbsI3+If/00JpvreENo7gOrp8/IjwbNvleqwgfIaLXALiKqQIU6zB3bz/n6
 cjtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK2Xq5k7QQ6c++PasJ5IGkJuwPiUFyYOIImnnK8GApAym3F6hP/Wdg0KqtEWfzFJbzA/2eMi6AMfGy@nongnu.org
X-Gm-Message-State: AOJu0Yzb3yLRPjav7jxPxACk4L4vmjTr6g2rD1UIJ540K+zBZCtsOybz
 IhkGUInjadXTe2GA3uD8IMtXTzkcKTLzMy50HI1+IeyWaStU0XAsAJkbHRgtLOzADsrcEc36hs5
 cvzCP72Jwdw==
X-Gm-Gg: AY/fxX7eiTQLCMo4ITb4JfIi5dPIYBRFlRslEmKj+eZaI0L6RM46UmvTVynkFOcoPzQ
 kWeD3NtnpAJ52l5Ob+H6IYNhKsSSP/rJ2/bFZSW+WkaaEkgxKlMhx29rSEw72cpu/iQZTzRjVqb
 bT0PT91Se7xyQ5DhYyazdcrWFRYqktH98tMk18x5fwP0KkT5+7x7mF7ET32M2wGIcU3WrR+lCDS
 zXwpJ4q218u3UI888cn6755vq2wbCKbvs6C71tH3iZuPLqhJ5747i8udUXMMrM6Ia9sSBlxjI0J
 qpxIUPGgzmFCWGyDNlCkGp1wcw+v/SNpreYCpkmsYBz1EwHEVyar2tZM/lbNjG4O4Vr3sfY27On
 EFoOWzqFSJFGJluVVQuT1VzJwIir8BBvg07YsFEpVG/iMWBco3oUYI4kbliIRIwmp9ymVmXmOX0
 J1964LrkzvLlEqYxWmcP+LkvoO64U7gA==
X-Received: by 2002:a17:902:ea09:b0:29f:2734:837d with SMTP id
 d9443c01a7336-2a700a51209mr22315625ad.28.1768463780413; 
 Wed, 14 Jan 2026 23:56:20 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd2954sm79703625ad.86.2026.01.14.23.56.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 23:56:19 -0800 (PST)
Message-ID: <a0f94a78-b368-4cfb-adb2-339fa50f19e5@linaro.org>
Date: Thu, 15 Jan 2026 18:56:11 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] M68k for 11.0 patches
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20260113100320.1009608-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260113100320.1009608-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/13/26 21:03, Laurent Vivier wrote:
> The following changes since commit b254e486242466dad881fc2bbfa215f1b67cd30f:
> 
>    Merge tag 'pull-riscv-to-apply-20260109' ofhttps://github.com/alistair23/qemu into staging (2026-01-10 10:31:57 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/vivier/qemu-m68k.git tags/m68k-for-11.0-pull-request
> 
> for you to fetch changes up to cad529260a8503b79d76589f1427ee592e31a801:
> 
>    target/m68k: Improve CHK and CHK2; implement CMP2 (2026-01-12 16:26:48 +0100)
> 
> ----------------------------------------------------------------
> Pull request for M68K emulation (20250113)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

