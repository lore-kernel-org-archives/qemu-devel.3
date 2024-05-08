Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6FAC25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 21:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4oex-0004Vs-Hn; Wed, 08 May 2024 17:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4oep-0004F0-Nk
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:17:01 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4oen-0007c4-AJ
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:16:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-349545c3eb8so94304f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715203016; x=1715807816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2emLFOcz8NBT5lpJD5lhxOGmvEJslyehYxldhnKZt64=;
 b=GJUhoXXNk8u8F/pEAGtIJyTKLrXBKIeQpoO5vD0DBsHw72GVr9WWJeAnrt91I/Fvx7
 i2Oz1RFfG6L3YyqWiOzNARROb4ob5nsCJaAL8cJ633OpsYsxBCWnRMvo7WAVpxSZujKg
 HnTTkWjOw678ak7l5jTdy8SvwC3hRlaUlB9F9Jr44zfMIbm75OnboU/yLNM8xWWlta9H
 IU1vvqNh0LjfohFOYmcaFQWPc5gauY2KmWlBbERLqFN4v+0TNcs+B2P3xzZWA6BIgS5V
 BwBZ5Ku+fhNYMMnDLEssSPCdvpNMiUc116x35DuH9EFEYM6t2Bh9EgGH6UaHy+mOjEnq
 l3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715203016; x=1715807816;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2emLFOcz8NBT5lpJD5lhxOGmvEJslyehYxldhnKZt64=;
 b=pMve0zCbpaS/EIiZBiHzc7xoENT9X85Yi35XDfBEzeAbW/6xmJZGQ5HqdAGJYoQAha
 MuCOstJxFd0mY6inSce3zf69QXe+CZakzj4auSdjIIhIUObGoqoqFWYpBvC5YUarUvf+
 in1CK9NQPlyJWwOOTEvkw9kqLrya9IpL/ksD/M2jNYjILhxhbDeQafwJdNfXimBukfs7
 cejMHBwEYQ8Z0paYd8Pbdt6IQJxbrHlwPhWLvZXp5CtUhvJma0w+nEI9ptwyCL4HlgQ3
 X2DXP8xEbcqckGHbthtFwEVeqyVq6vsPqV07y7D32pfAHrUK8DvyjdyvmbWcAV2/Id22
 Bbzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh+xfdnshbWOCE1K+57DW2AIKmMBl6BAtdtNGt+uEO8gS0K4MZGSa5XxUTFdn1AMAlhLXw0GzwMq1dKxTP0VXXe/ut8qE=
X-Gm-Message-State: AOJu0YxDw1eLMC9HiyFcc14keqQz54DxiQefWgaja1g23QVrcAFWgzVm
 gsFEXb6UGu2PWxlH7WgNxptigf8futOEI8j0rs112HxH8ew+9gWZ0dDkTIFdxa0=
X-Google-Smtp-Source: AGHT+IFqEqAsjJyypAjOKh8VsFryP1ATQFUab+GrinUxGp0iud8B4uFgcboOiQWp40Nku8U+FCSTug==
X-Received: by 2002:a5d:510a:0:b0:34c:bf58:abde with SMTP id
 ffacd0b85a97d-34fcade2e38mr2553597f8f.27.1715203015827; 
 Wed, 08 May 2024 14:16:55 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 p12-20020adfe60c000000b0034ccd06a6a3sm16192223wrm.18.2024.05.08.14.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 14:16:55 -0700 (PDT)
Message-ID: <94bb9721-831a-4572-9e00-94540203e5b7@linaro.org>
Date: Wed, 8 May 2024 23:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Support message-based DMA in vfio-user server
To: Mattias Nissler <mnissler@rivosinc.com>, jag.raman@oracle.com,
 peterx@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, john.levon@nutanix.com,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240507143431.464382-1-mnissler@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507143431.464382-1-mnissler@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 7/5/24 16:34, Mattias Nissler wrote:
> This series adds basic support for message-based DMA in qemu's vfio-user
> server. This is useful for cases where the client does not provide file
> descriptors for accessing system memory via memory mappings. My motivating use
> case is to hook up device models as PCIe endpoints to a hardware design. This
> works by bridging the PCIe transaction layer to vfio-user, and the endpoint
> does not access memory directly, but sends memory requests TLPs to the hardware
> design in order to perform DMA.

Patches 1-3 & 7 queued to hw-misc tree, thanks.

