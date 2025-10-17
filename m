Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7BBCCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 08:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9g96-00014Q-57; Fri, 17 Oct 2025 04:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1v9g8x-00013Z-87
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:49:00 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1v9g8s-0005dC-4z
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:48:57 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-362e291924aso12888741fa.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 01:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760690931; x=1761295731; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kKB4yQ1CEdIhJDYLxJpP2+X3Y/kzNOW0KePOaAmRC9s=;
 b=EAgeWvO+tkxG4YOC7+2H1P1eogdXf367E2jZPfnVYxuxTZ6LkugyLqa4Mo9YLC4ME+
 yfAk5WMGZRIbgzLIFpAKY/gD+FrS57Nw1or0eGyhueaQxHkFoMTBG2kL3Su8+AR51AFx
 3r3/FUPzs5vY/j5V8MCft/vB+51u5gvE2EWux7jGoyvxYc5uBZjaIxM6qq1B7J1W09an
 S6ywBiFqaJb53ulbh+abb5rv6DrD+RUai72m5EAbbuJ5xBHeijC97cYLQaRMOWspt1fP
 cn4U+qPWu3+1xbKkftEAr4jJE7ZatdP9k9jj8QOKtICbuMXA4BcajWJABqH1yY+KEcAh
 geUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760690931; x=1761295731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kKB4yQ1CEdIhJDYLxJpP2+X3Y/kzNOW0KePOaAmRC9s=;
 b=PKmXHcQBHEi8+ybF6kIW4p0wZTYkPkBetqr6QE8hHaV/Sk2gTvGt68X/jZ8tZrlpP4
 kfXsO+i1zM0pHdVLgNq/KdtiQrTRsTC4ye8MzDRSnupD9WJvkkSjIjT891NsTFvxcOeC
 9+CI0cNIhH3FEJ0fikNrnQ5GNNWfczllhp08hInD1qIXHFQruyItU8ClQX8rD3LUku/9
 1VH6/TPUTtI/cqxe+TFXnoi6shCQWXDMoUpH7zRImrF09B/XSxdwB5SGYszmg2OI11dq
 /D1IBNHFKtH3r72jddbdQmiwajx3hHJEC0ZUF6h8h08jeMEaSr+kwf1BbSfJpIHlhRM3
 RZrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh+62S3/gMCK+mo+7ijVzYyAwi2LmvYXXIIxtI+Cgi7FaWNR5lkVSSXwz754Vd7BD8lTSpLasLTly7@nongnu.org
X-Gm-Message-State: AOJu0YwqD6wMCpHS/9xYOelWZraadoJO1QF8psppZgZplr/35NuOAJs8
 cRyTGFrz9JtVOxb4paUrUWilayUUr3i0UIM7kMQ9oKnPziQzgjMq5Cz3/fq8ldstma7SnW5AUzX
 iy+qWjsEmSIzrzl4h1bqlmYE/xmYPE5MaRU1LZqe2vw==
X-Gm-Gg: ASbGnct1m3+1n06h0gICNsUKnkYw1rcYvGC+ZjrpzjAoip02pLOEoobqlmhpS0hr7wN
 aaYMDUO7Tb8RyQftmSjllvCqOyVQYshyi7V+KY03UNNQtGZcf7dhpCSKFb3UaGoQOPT9iTB2x9M
 N+ThxAixn0CnAdVKQctYVhfTpH5MB6JEmIqclfIqrdWcwTn/FqZO4RGaWebOEktM6wKCzFvOEtJ
 ED8bRjmDXww9WCvwjQelltuf6M5GIv9O83PZsfNX85POobtZ6YFv8p5AnuuPkjgT5k1PY7WkjvE
 zdmeaw==
X-Google-Smtp-Source: AGHT+IG4k65O71asJCL6E/CldgOm3nUH469QX5GS8KFVkXWXKGt8ggS/iD3RXgzo07G6YmzdsGjjBFbaiWpuwUNcOE4=
X-Received: by 2002:a05:651c:982:b0:36d:86b8:c57d with SMTP id
 38308e7fff4ca-3779772ac96mr11562771fa.1.1760690926464; Fri, 17 Oct 2025
 01:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-22-skolothumtho@nvidia.com>
In-Reply-To: <20250929133643.38961-22-skolothumtho@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 17 Oct 2025 16:48:35 +0800
X-Gm-Features: AS18NWDhZs1ga3V8_u_-nExC4rJxQqoCbJlEd5-ZtRx-SGG4amb5y8sU7YEkL-g
Message-ID: <CABQgh9EJMuVNHoi3iCW73mrC=y07djR8QoPAn8wN6+rL30iadw@mail.gmail.com>
Subject: Re: [PATCH v4 21/27] hw/arm/smmuv3-accel: Add a property to specify
 RIL support
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com, 
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com, 
 smostafa@google.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com, 
 jonathan.cameron@huawei.com, zhenzhong.duan@intel.com, yi.l.liu@intel.com, 
 shameerkolothum@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lj1-x22b.google.com
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

On Mon, 29 Sept 2025 at 21:40, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
> Currently QEMU SMMUv3 has RIL support by default. But if accelerated mode
> is enabled, RIL has to be compatible with host SMMUv3 support.
>
> Add a property so that the user can specify this.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

If ril=off is not specified, the guest kernel will not boot up, is
this expected?

Fail with log:
qemu-system-aarch64: -device
vfio-pci,host=0000:75:00.1,bus=pcie.0,iommufd=iommufd0:
 vfio 0000:75:00.1: Failed to set vIOMMU: Host SUMMUv3 differs in
Range Invalidation support

Thanks

