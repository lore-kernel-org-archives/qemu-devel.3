Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F48E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuQz-00030W-Tx; Wed, 18 Dec 2024 08:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuQr-0002qr-8P
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:49:46 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuQm-0008Fs-Dp
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:49:44 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21634338cfdso78450015ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529779; x=1735134579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HE/9d/cFdxWTYCPwJD9J908Zjsq7ggKxcfecUlhRfPo=;
 b=GIlTKEbmtIATcc4l39V/A8oiCLjx2fLDvSGo0a8knff/Ilh5mYq5vsiMnOSdavwGi+
 eRIIzMw8mw8x/tV11PlR7jj9L43DMpL4I5/BUeM0jVJ7z/z9OYXGZhUb1Z8aup4FMK6z
 Pdkzvd4GQPyVF5oVja4SvjeOj5d5dwdsJRewV3XmY3Ba1rzXKoWAGjaQ81rVW6R2Pgqr
 md1EVg1i20YrSu3GZf7bVbYIuAkW7jPtxXiJNwZfIceCeFi8JPHY+mn08ivrshhTlpIG
 9W4NES/FQ6Jmmrwo2hvrNfhALm8MCj89PI1ZMvx/T3k2Z9sVXWn8Fsp+jdJkIRbShhv2
 DiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529779; x=1735134579;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HE/9d/cFdxWTYCPwJD9J908Zjsq7ggKxcfecUlhRfPo=;
 b=P66HKJWVhJQ0IaplIRF/b+ZUoe8MV/yMXqVogqSKCqxrjQfAUSUE+jmftfGUv6DkXy
 tF5RTFmtmllDZSLzU9VWaw18mpzvbXU4wE8Zn7p9E8fm8974NzpJQdrsWnanWp8id9tz
 gxnRt+NbGrmLDzRHWS3jt1/T3VvaTzCZPUkNLCJJ9aer/42UwT0XYt0L6woW7jGDYh+n
 uXjGbcnjtxdCTtb0oXKzeS34vWDsmyamU0QoPGpnkaSP0zJGudeVUV4XmmXi98Lg88MF
 /PCeu9BFD0c8je4kJ9HQTVo67NxvErL6/Qo4E/L2uH/87+39z3oipN33DrcIp9DJxEpp
 53yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDCTYVX6oeKZUcrC+bHoV28stDBXCOWjecglwLwN1JLdbKGZ0FJo7csXonsplgkooEafhivU1qpjwW@nongnu.org
X-Gm-Message-State: AOJu0YyORJCm/DsdIF9QW+z1KtJyxBEzKDVsgNnJuL9kX/u9ehfRj9j0
 2QK/GTt8VYY/mt1cb956vU+o2nbzKLheuviI1AS4G3u4Ru9xRKuQl/eN9yikSwr0wrtq9GtVlRf
 W
X-Gm-Gg: ASbGncsF+WF+C+BvqyTPwklrRalOXOmBF9zXDkmEGjPhrlvjwIivk5Pnfm1T1STAm7O
 SK8cDgSfksuEX37Pbp5aKzwqZQf0selnJoarqyVRByqN086ELsP4Yor3gkOXGmD4cdn5SoX70fw
 Xsfe/2K5v8aEaCz4D+e07CiQ2bUiFE5RQ9kkzaSWex+fXgOHZPTItP8/VS8F1g03iNcss4qF1FU
 c0hN9pzkXn6mq6Z9OXqhXU4ivqFNMecVoKtckXVj5WTZG7DOh7QqhhNZz1g//N9yipBiDED
X-Google-Smtp-Source: AGHT+IGyJtTyV6Fu1uLeDfMPdr1+wplBhjwj6Y42LsKWjvKO2jZXqn43NQhGZu7+ZhXg4IkiNxNJXw==
X-Received: by 2002:a17:902:d48b:b0:215:a18f:88a8 with SMTP id
 d9443c01a7336-218d727da57mr32212495ad.51.1734529778970; 
 Wed, 18 Dec 2024 05:49:38 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1db5de1sm76224345ad.19.2024.12.18.05.49.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:49:38 -0800 (PST)
Message-ID: <c6f1e820-736d-4eca-a6fc-d1e74dff7e80@linaro.org>
Date: Wed, 18 Dec 2024 14:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/24] hw/virtio: Remove empty Property lists
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20241218134251.4724-1-richard.henderson@linaro.org>
 <20241218134251.4724-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218134251.4724-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x630.google.com
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

On 18/12/24 14:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/virtio/vdpa-dev-pci.c       | 5 -----
>   hw/virtio/vhost-user-snd-pci.c | 5 -----
>   2 files changed, 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


