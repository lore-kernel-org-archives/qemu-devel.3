Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C301D3CCB8
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 07:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgI4P-0000Py-Jn; Thu, 15 Jan 2026 02:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vgI4N-0000LQ-Is
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 02:47:03 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vgI4L-0000Dp-5S
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 02:47:03 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-81dab89f286so283854b3a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 23:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1768463219; x=1769068019; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iWVDSq5OiKVUBelC41swZQyGgJPE67IaiLiNcaOZ7Og=;
 b=FrAmkSvVDUx6M+vwfvTCeC5pR/MqAvFQiQnOfIuD38aH6jePSpNqOzByRpZ7HYFp7S
 XqgW5CrykcG8mM7CRXa0qI5NpXdhiAgoL2EA05SwsfjcksPSSarf0N1JMbMT4WN9KZ0D
 0HyikGiVCPORzjhUsFVOw8m2FiHsQqX8MvJUiztZH90gkjzehYk6ZD9saD1TsUWRx+qK
 o0ovKrEHopNjCdMpXz4KqptFHbQB7N7qX2GeqdKX8j9WjshUfn3lHA8AyeN47BLgEiou
 pRwmFCoKib1GNTDYZcoevT5P/nbtEvU+G3aS9FN8H5vr8mlJVA4AB7LqAmybKTastGLf
 feAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768463219; x=1769068019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWVDSq5OiKVUBelC41swZQyGgJPE67IaiLiNcaOZ7Og=;
 b=XCCelq6tzJDmLY+CQ37D0/A3E3E7UyLwEaY6QSKjFo+AClF8KTIHH4pSMFE9jifOAf
 +OUGE5AoCnu96ZlamaPJFwuJ3HZXeYL/KHVrEsKptq7BbzX0L0L6qZbzQo4FUcWpj/Gz
 tikpzHNcGBAin8TSjzMH6QHyIazvFpWoHJJhjCtYtZQhR+DtwMgn7cf0rWa4tIK3sCyW
 +yE+Cnj67FbgPAOppvvUgFgw/napmar87nVxkasPWY+xt4VTl74PPZSCdtdoXMyAIWrb
 xidatnmMPKcWG8qTvjUQrP0bbbsAq5faL+JW/e7d+KHTzbWua3rIeORQSWKEUdKc5Xiv
 2HXg==
X-Gm-Message-State: AOJu0YyxyPyor/bf1hfngdEorU796BKsD2Bn/1/NMDS6F4KQ6XqP9nXv
 h4L4OorsiVYZ1BHc3LB2xZMRqUx0vUQPvVTWlma+AGPCMBYNLIVS5zqG0p2nyTCRwc0=
X-Gm-Gg: AY/fxX5JTyCojsVQu/19An9EQfBOjGYXgsgRA4JgzFamLSryCh/dCi6kix9bBed/Jid
 HzBdOWHwGeY90+46269Y85UCwHqLcFhGcijcIKNcV/zXi1cF48nhrz8mVNH7asEN2qxeAxcYrbr
 CKXLIpD/NVqzb7rNWAKvYKKo18JNIx4WVX4Dz2itz2Gf01ljiljUZ2hSRHgAi0wA/tIyP3kx0UU
 Og+6K3ozSHWacPDV6bUMb2QhIo23jl9GWnLx7UJmJELdfhFS63h/9z9jWs0yy49KBAUxwRUBgzp
 Jsb7StPwLw8maQ6JNA94KKMelHVmvvSZdafhPRa+34C/k3015M63EyeqCmRB9MMqZc7oDADA59T
 LwagnHFGo2kDGsdq3B45URucoufGeouK2oU1vFcmdTzzyxRFdPKzY+8hSo+w2iE7Olj7t+mEghI
 OUWVd0DZ6gbvNwgEByLtZMjiTcD6onLZpYJ0YysYzCd7zKi1eZE0IY
X-Received: by 2002:a05:6a20:748e:b0:37e:4396:146e with SMTP id
 adf61e73a8af0-38bed217235mr5824216637.74.1768463219607; 
 Wed, 14 Jan 2026 23:46:59 -0800 (PST)
Received: from sifive.com ([136.226.240.171]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd2acdsm242430245ad.89.2026.01.14.23.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 23:46:59 -0800 (PST)
Date: Thu, 15 Jan 2026 15:46:48 +0800
From: Max Chou <max.chou@sifive.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 02/18] fpu/softfloat: Add OCP(Open Compute Project) OFP8
 data type
Message-ID: <aWiYk0zUruMI7uU6@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
 <20260108151650.16329-3-max.chou@sifive.com>
 <CAGL8uCX46bm9DsT2Tk=roW8VucY--G5fc10PuqJ=aQgo7y5+8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGL8uCX46bm9DsT2Tk=roW8VucY--G5fc10PuqJ=aQgo7y5+8g@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42c.google.com
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

On 2026-01-09 15:29, Chao Liu wrote:
> Open Compute Platform -> Open Compute Project
> 

Thanks. Will fix it at v2.

rnax


