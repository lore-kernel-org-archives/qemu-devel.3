Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DF6ECD989
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo2XN-0002NS-RF; Thu, 05 Feb 2026 11:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vo2XF-0002IU-TZ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:48:55 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vo2XC-0000EE-FK
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:48:52 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a94450ae14so6977785ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 08:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770310129; x=1770914929; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lBfoXA8+8rxPbZRbGLtHrCPhskQGduMTTaikmUpm+As=;
 b=HT48To7VbVdBnxRpbcf1xeJx7K5ikG1qCXhVw/22p+l98pZwMp9N87qfNJbE00Qr3S
 xC+z5XHuYP4uW25ILn392J0sEdKmOly3Mxz8GcTZIMNoqHOU4L2nqyDp5fEmZ57dsIAK
 k0iNTnxs6X8YZ4u3u/48me/M77Y/zRtpp2cs4t6Ks8iDFw7mINSwx55IIERKSMDm/Qs0
 Km1FdZu3GQ4MOmt43LG+0RozpDQnftImpU+JsARCGRsVkJJ6b2oGmA7QSuZiYhBOJNWa
 NB1peK49O8/CZIaMGYxJ3LOcJVGnNYK+W69hQQV0quHsq/0nu+0rgBrHyMyqKs3P2pZy
 wmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770310129; x=1770914929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBfoXA8+8rxPbZRbGLtHrCPhskQGduMTTaikmUpm+As=;
 b=QYj//TtP3MULkfGxIL0x1kEHLgD69E+L1ZcCp3N5dFiDC9D/tkwymhg04GaGJ699mH
 oMbHYgaRc3Rb8M7nc/HQp21T+QvFo7tY03TR0BxWDEVNOKcmUxCG7UtJKkCYplre76K+
 DJpyymE+Q0PGr/DStSHBpIjisVAk1YNWbwP9Sd05MMDALesOM+b7lBLZx4Gvs+qIzaZV
 t31ZcZItJPQMp4Sn05hQvSPMgw6LQztIAO3gc9KRLHjv89a9y307gYW+QheWF84k/VsG
 rfhFAPm6oQWkuSyq6vQyW+L+TS+Q6Bt9yL3zz7RarBvJ6qLEaA1pKSATZVVWzT2+ocO2
 n3rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy2rn1+VZaB7uzgN8OqiheBnSvsW0GLGk8vQwEBFs0GmQaMZ+Sggy9TirVT/p526a0e4X/nPonxm9M@nongnu.org
X-Gm-Message-State: AOJu0YynNJbSCWJa0H3Cl5UR9GRy+wxslNHgcWgjTIpVh11vc5XwfyEy
 rSACEx9Zj602KNNTUbZ+01+UgrdS6ViFHz+5bZTGdB2xFHTbH1ih1JzzTpTjN/BNxSA=
X-Gm-Gg: AZuq6aIszASyaxvx8i9kPLBR6OE5mlarZHRfWjqwKQWNZApxTJ8dKj3s3O9JpCYJEgX
 7yhJNHfx6nPZI10GZ4w6JKmAhmy9sGB2X0WSbvFnX3d3I3kh1bsnKJMgWN/fPdVilxrxJZ7fgZw
 MHWE8p2xWOsIi62LQ/RnVA6XHougfyiMU/vgPPnA7sUZLXlkS0e186miDrsis+UuhGCuMP+1aZz
 EkjmxXHFm5YILuDjZhTQyziKWOH6FwA+/pStNyQrAUEy9i9HlkkXsj6eXnyHYj7rux7Azqh+n+L
 Gpq+ZHB6jj0qCEvGp4trEEOBxSzJzTiDbdXVSYn7tu3TW/AJW9UueX4kbReWius7tL1l5tzp9o/
 m1EEwIQ0Nd/F3dA2AwXTEdSWCpWDnn8k3qGX1CqJQj141xpnBpiQQIX/HoN5EY8CyJHPziQmwwY
 cUMYThX8zQSL4XBieM9tIHna07BwnmqFqYFdwix7Zoyjj9Xj4X9WUu
X-Received: by 2002:a17:902:ef03:b0:2a0:9d16:5fb4 with SMTP id
 d9443c01a7336-2a933d1fd23mr72603215ad.18.1770310128906; 
 Thu, 05 Feb 2026 08:48:48 -0800 (PST)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a93394e286sm57512225ad.54.2026.02.05.08.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 08:48:48 -0800 (PST)
Date: Fri, 6 Feb 2026 00:48:42 +0800
From: Max Chou <max.chou@sifive.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 05/19] fpu/softfloat: Support OCP(Open Compute
 Project) OFP8 data type
Message-ID: <aYTHQBd4V3syYqsM@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
 <20260204051756.667397-6-max.chou@sifive.com>
 <aYSUzRnX4ImNeaVT@ZEVORN-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYSUzRnX4ImNeaVT@ZEVORN-PC.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x636.google.com
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

On 2026-02-05 21:21, Chao Liu wrote:
> Hi Max,
> 
> I've been testing the OCP FP8 implementation by writing
> a simple test suite in tests/fp/ that covers various boundary cases for E4M3,
> E5M2, E2M1, and BFloat16 formats. During testing, I found some issues in the
> float_class_inf handling in partsN(uncanon_sat).
>

Hi Liu,

Ooops looks like my random test cases miss the cases that input is InF
from v2.
Thanks for pointing out this issue.
Richard has provided a v4 for the softfloat part, which is better and
clearer than v3. I intend to address this issue based on that one.
And I'll seperate the riscv isa part to another v4 based on the
softfloat v4.

Thanks,
rnax

