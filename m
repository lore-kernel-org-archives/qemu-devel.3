Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AFECAC5A8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 11:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzDFQ-0007JA-HD; Thu, 18 Sep 2025 07:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uzDFM-00078f-JR
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:56:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uzDFJ-0004oq-SA
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:56:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45e03730f83so4168935e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758196575; x=1758801375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ea4dGLZwkNAAjB6aRS/oVWq8L6qzJHadECqmXARy89A=;
 b=KPx+iMM9ZQEGQeTuwDW/WJ63Z+mwphiSCu7LeFClH52pn4EBG4A+6aBjlDd8YTt8X4
 WeJoMWywqANbGV0QsbEBuAo3j7H+B8Y64fLW9PEupr7kXUPqDJrBNXBvkKhedmdDdpTj
 witkmlJSn7mqk+DvCtZqlPYx7/BxNKRjWCdEueVkqskvnOBsgk7EGQ1dSKUI96mjtwU7
 HzC+Rcp1fc2DjBGRCJehLpUH0ZDR4damy4AB3tev7rPlO3FcN2ty7NYWdrM6/dSAgKcG
 dUf/33xyMhwaD6Mvapf7pgxPMAOu/qUMZ1wUQzwTOkCFl5iH6e2MEURrVUbyWYkSUIQC
 MjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758196575; x=1758801375;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ea4dGLZwkNAAjB6aRS/oVWq8L6qzJHadECqmXARy89A=;
 b=AqwxtbvBdiPD60or1rgTv22XL5Ca43VL7n9sY+ejnWehLCUs1O+IKSS5hT72lfm57c
 bpBTgeAUIm5JJGsaZZNgG4YfMbFb0ph//dJIr4wc2Ws+Bm1rCmRioLZcVUW5Kp/0WwwV
 cul/GnfN5LCJXDxwstVFoMrwKxCG8yVQ120LQ9780ePSEwJL9pUh/dthffwXLgyfFPjN
 NVzpkvPFTSJJDIDiAb+buKmsITbd9lacn26rwCBCQVi6C8us+EPIi9JFzDvPnuFOt/mP
 8Qb0OPzy3kAKaiLHrzAGQVAhExbV5eCFz/tq5iR9oJzEoXMc4TFXniXY847pUKWjh7TQ
 MySQ==
X-Gm-Message-State: AOJu0Yx4lCpjveEiXEOsvylq29GQyOTNvEy/RxIhFK5IquZf8oBKq9Rf
 FW2sb2TeQDoHQfD40Y41fZDyRQNTdStOtaFyDluP7ufGBQjAjiNFx19I55kwkK+nrhw=
X-Gm-Gg: ASbGncv/0gC3firjkGs+p/cRJqLmGZUCooP48pgKkr4rPiwYlpGBeJ3Ul5VX4Eb1VCP
 oOsAX905WH3MuEAnz1KRt+7FTr4FkGpsRlPchD1YlHaFmSt5ZFRqDmcWb5bf390Ct5aO33ktR7H
 gK+amzz1OK2P6714yIVNM2paQ+kzciLpTPEEYa6zv21aJu/AYPiJWecd5XYW+uwZe5PZPmBwPJs
 rthgyDrvrHs7i16QoQN8O8YyIwjHm1/6mvO8g/lMN/Uzwrm9we7cYycc+9XoEr/BeGX8sSYdyAv
 6c/e0J2AWLl+k4dxFoE7Fq3YI6h27kp0TYWzi72oo5cy2ClTd0U/c2IpeifnbPsJYGTTeRwBeEs
 O8o3e8FCZhTSQ4BD7wW4pmTdEXHjodSXszRRZUue/SQ==
X-Google-Smtp-Source: AGHT+IGVamkNTcu9utD5pHxzuFfZ+jhfrZ9TwzK/0zXfYIby6q9QLkSPedCiw9zxurwYCpq6P6JcTQ==
X-Received: by 2002:a05:600c:1991:b0:45f:2869:c3b2 with SMTP id
 5b1f17b1804b1-462072d723emr55655395e9.33.1758196574857; 
 Thu, 18 Sep 2025 04:56:14 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f16272e4sm43170925e9.9.2025.09.18.04.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 04:56:14 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F02FC5F8AC;
 Thu, 18 Sep 2025 12:56:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Alistair Francis
 <alistair.francis@wdc.com>,  Weiwei Li <liwei1518@gmail.com>,  Palmer
 Dabbelt <palmer@dabbelt.com>,  qemu-riscv@nongnu.org,
 richard.henderson@linaro.org,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  philmd@linaro.org,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 00/12] single-binary: compile once semihosting
In-Reply-To: <20250822150058.18692-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Fri, 22 Aug 2025 08:00:46 -0700")
References: <20250822150058.18692-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Thu, 18 Sep 2025 12:56:12 +0100
Message-ID: <87ms6sm0tf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This series compiles once semihosting files in system mode.
> The most complicated file was semihosting/arm-compat-semi.c, which was ca=
refully
> cleaned in easy to understand steps.

Queued to semihosting/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

