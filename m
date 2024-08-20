Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3AEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 22:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgXcT-0005cK-HR; Tue, 20 Aug 2024 18:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgXcP-0005GU-6b
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:46:27 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgXcN-0000ys-HO
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:46:24 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70d1c655141so3958979b3a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 15:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724193982; x=1724798782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E5am9T9XGm8V3OIBEPNkMZMgFodLsVp7fDCfYAInsHI=;
 b=TCLa7MSz06RUytjZOVZUVs1Kx0GlihmHorfGAoFU5pLGBJ+/LS3cwKrUxxtsMQCEAx
 Gjed9dvS3nMWy99NG923THXF/KSSqa/vQ2H4o3xrh40YFY3CWCF+7uBZMopQ1l3uNYDs
 KFIWGzyuKHd8V50GcxdI+Br7nk16RZz30oz/Cr+IgcXTI+E8FwFxtdytBgo/Qf9jHwUc
 UOMqauG9yHlyvE+mebtwuBwmNVmRtDPra4BK/WoLUlX4JcJJN0PxWU9XBZbEBRhCxkX8
 M4YQ9aqUEchFQmmMG2tuiUBT8yM6sEBPq3Es6QkUHu4C5hNc1WCSfbrHOGAUxqi9tc+F
 JuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724193982; x=1724798782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E5am9T9XGm8V3OIBEPNkMZMgFodLsVp7fDCfYAInsHI=;
 b=S5RB+Lv3i5STbmgmJ5XP9t7KTiH1sMHZYst0ONqAao322QiZXdSWyMbmC22Zd47RDU
 YmCq877NW8QknFCkOn7zy0WJBrRqUZq74jMrTBAMxzgx67tjtMrAo1k+Gjd07tzIXOdA
 I2TVY5yXaMZADAcrDqCGa9DY/PZBORjD/eGZ9ssA460KDx+F1Vq5MSiihE5kQ8KCxCCS
 t45SAdWzJhrW7+VXJG7S5Zr3xGSrH/a/Tawo6vW38P6eKe0MitRqX95qLV3kB95aGfA8
 pMdB8YCUSMkoV5F1eGpXC0m3kpRNFieeS78KwGxX0nzQIzPhnGIVxKEZtifadqQUu+VB
 crkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCOZ3TooQGQh09/0huDmPxwk7+/+0gVBKg2UJvFPDn6BomRtNBfAGRAjWXBWBgaLi3n9/NYheRn9gY@nongnu.org
X-Gm-Message-State: AOJu0Yz9G+khfSE01Ax9pb2YtyZvQ/m1ZDvP2kTJPXGbgMriiO/9VoOB
 sNpqPofplyJfH+gein465LcHU792Vvo+4I7ApSy3QCPVq8qtxufxVTJzvQmEqXg6JX+O2aqbX5z
 NNmE=
X-Google-Smtp-Source: AGHT+IFb59HN3F3M7iQrXsaxElzgmgatMW7HocRgTf61+TUaAQmdfCNMzwp5Xll14+kuFicLnH4rkA==
X-Received: by 2002:a05:6a20:c886:b0:1c4:8876:2ae with SMTP id
 adf61e73a8af0-1cad81639demr1025856637.41.1724193981733; 
 Tue, 20 Aug 2024 15:46:21 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aef5229sm8749152b3a.107.2024.08.20.15.46.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 15:46:21 -0700 (PDT)
Message-ID: <6c46089f-e1c2-48bd-9f3e-ae8e8e4f54f6@linaro.org>
Date: Wed, 21 Aug 2024 08:46:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] virtio: regression fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1724151593.git.mst@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1724151593.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/20/24 21:01, Michael S. Tsirkin wrote:
> The following changes since commit 76277cf82f0e1123bd69ec59d22014b8f78485ec:
> 
>    Merge tag 'hw-misc-20240820' ofhttps://github.com/philmd/qemu into staging (2024-08-20 09:17:41 +1000)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to a8e63ff289d137197ad7a701a587cc432872d798:
> 
>    virtio-pci: Fix the use of an uninitialized irqfd (2024-08-20 06:57:47 -0400)
> 
> ----------------------------------------------------------------
> virtio: regression fixes
> 
> 3 small patches to make sure we don't ship regressions.


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

