Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326C8C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CGY-0000BS-SH; Mon, 14 Sep 2026 15:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CGX-0000B0-8Y
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:22:57 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CGV-0002IL-Rb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:22:57 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cc4dbcf2b85so1760582a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789413774; x=1790018574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=brEurZzaAqzY+mkmQC6+3KGzTG1CyPr0eAzZ1ls3CDQ=;
 b=dlv+mFW2lHIwZzqtzZt39DmbTuLKbikDv/XuuywO0l3s6+GthHwpuG/yfBQ/D3RbrW
 7Kj+swt9Mk1xrlcUnvo1eCe19qhM+HBQyRIs4EFQbA4XHQLw0oXfVozn+QIQLRqk6di8
 CgCm6a77EdnLUXwe/8KGcmbpvvE4ug23DG15eUNo+X0ylKEUABfrWChIxAUrQTxCHE3Z
 hVwiUl0jpgml2TLmdGQf01nRsHTErdKyuj8H4FwblxbU+N3mwPmvXivye8RX27byRniR
 hIjMrJGXZu1vp9pBnvuctyxBjbFKuQ1jLusZYu9hicI67yDpkfdiMUlEnnhOIOSfl8kR
 qGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789413774; x=1790018574;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=brEurZzaAqzY+mkmQC6+3KGzTG1CyPr0eAzZ1ls3CDQ=;
 b=FE19sadBpzRyWEzmNIfzURXr5em3kR0xK5M8fmIoYO+r3dhtYF/JOWL6221fgQYek5
 s4/hUjAV2Q8wmKuHvaD8uWFD2dQ74ze4W2OzFIF0Mfl6128bAMGs43Bi1QE8ql44cI6V
 ZP35KL8VJUs9wqCbFTCrX7DDKszirXkYy4Gw0u2+AnBmGCgibYQph3rrXlG7pStc/ega
 PSJTHq6S/HNZM71cNeZUIndGJ28vlRZePN4uXFapOg+k9mQV6OLjMkGx7lKC6TdTUNbV
 HZ2oZn82h+FnVE1NYxQ8MQ+Ove02C9lRaIYMkX4JCZ+wm1V0F3oE3tEp6qi8BZzZlSIg
 MDdA==
X-Gm-Message-State: AFuF++nm7Yt3vMNdBDHgB5AwQlczscn7o1PFwTfgT3wm0zkCjuw34/Sj
 eTucID/R5TQXD9rM0SydBkx5ABSbk3k9sGYYZfkftGE2+5llEbKjoHk3lUy/BCBJ49iLt4ceF5z
 dhKGcgOg=
X-Gm-Gg: AYBFou3TDZbA5KLdcOqkelwu02hw7ynbPccxpZ4pWoz/ddct/8SLUo3RglTShA7n5ql
 JVDm9JbZM0kn2PTbBePLc89PrxiXYD6X1VTX+0d9XFQKv6yld4aoMkcxNxcbyW0LRs24Vqcn+81
 L/QPLpwYtCaYQh5RGtJy2Pj4huyAhw1Nj7WZAVFxgTjLLjvYVMRh/BKvJsbU3qx1jM2lACn9Dvz
 rgnQywbMb/MBLLDDOb6MGBNxWaTElszWASCtjzgDGusKyKlIOcUMHIt1dJeoM8oiWARLHXVmVyD
 I2KM7/Dj3UVoexdS/hnAGZBMq/7Uxe3mIhGhZUWKzJ6fdDZn/HxPXDiRWr2QBSxeDEJte96FtUC
 qdqnleAZZtXyATvqiirJGGO+A4pd8C1OXO1PWwBkOW4R/P8sP84L5PBxtJbQJeEQsaaC6100bi3
 AziRhVpZAbfa4RRoGSYCZRPskkkWqbf+cr6Xx2AfCQ6YGv3wvSDFzoiRh4xHBD2j8Yq/IUD5zKQ
 JSsz1RqRlApTA14GJ74eh4Oww0Dl6hR5WgYYSCajlq/PnJkkOoU4YQwVxXGEA==
X-Received: by 2002:a17:90b:4c0e:b0:39d:f615:725e with SMTP id
 98e67ed59e1d1-39df6157e00mr4582356a91.13.1789413774118; 
 Mon, 14 Sep 2026 12:22:54 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b78d59sm25072935c88.8.2026.09.14.12.22.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:22:53 -0700 (PDT)
Message-ID: <8c1a2b23-5ddb-48bd-9ac4-c07b8332e745@linaro.org>
Date: Mon, 14 Sep 2026 09:22:51 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/14] system: check security of device types
To: qemu-devel@nongnu.org
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-9-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910103628.2326622-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 9/10/26 00:36, Daniel P. Berrangé wrote:
> This wires up the DeviceClass types to have their
> security checked when devices are created.
> 
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   system/qdev-monitor.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

