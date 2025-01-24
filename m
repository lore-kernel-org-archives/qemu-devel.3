Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DDAC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNoh-0000N1-3K; Fri, 24 Jan 2025 12:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNoa-0000Fk-DE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:49:58 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNoY-000481-WA
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:49:56 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21636268e43so52088685ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737740994; x=1738345794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lprcsEJqJA0BXBRgOLBnGo/4d0TSDe5lsDDbo6MJfjY=;
 b=n3q5rLXcnXRNfc4EzOaAzDv/gfJcjHCP7VL/L//5wTXZZd6+4eCNqOAWF43ZIU61Cp
 4j1cv5onWzuhXqQC/Rnme4mIH8YySh3RFp+pqZqzKNQ5fqjcaqwfdoieeGpdRg2fDJ7s
 U6nDxXC91UKpfqRZESXFaufqQ24/RmY6yE9G4PAZRe1wohHFYyu9mxZ8ZnOH8e0t/baA
 vdoP/ggNG6B4vtyokSolFIxE+zppGEh5hcAUHFUck3aVtVHMVxYjZx0l8P52b+jtdOnF
 YSqPLvePEggvFL6PY7H0Bm2zv0PU7cMEnyiNWD5ZLnwef1/SwGvANM5vdtZLsvo81J+q
 jqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737740994; x=1738345794;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lprcsEJqJA0BXBRgOLBnGo/4d0TSDe5lsDDbo6MJfjY=;
 b=SxKS9UGwGsJOIzKsDVrFhXCEVQoVfSV2KgtgLVFK+DSPgUk+LQR09RWxnjwla3NiT+
 CTb75BPD8gn/RIxBCaf6/TR2ofxiQRd1lH2D2SDZHoeuuTbLXR3t4TRsAUe3+gzwuK8w
 vGi5bzKoHAVXjOTG1zg76K5buBvP0Pd+9PFkmyrIWSJc7svOld2tmDbxCHHHcoSuF9xY
 TwvGpoErADObjmkTnTXdjPKTilSEcqgDh3KkM2XwTkm+vmBLpz/vkXun979p/cj3q52Y
 K1Tg7YuuI2t7Cq4r1L06f3/Grla1mUvK5DCZ7kTQ9d3uXPOXQbRmIunPT/GjHIg+Mb6U
 x47w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1JOeGkdWrJ6CYULOlc4kQtnKDnq8rw6o/EgIMcBWhLqf0Q5rc4hqaCWQKHhYyphm8WosVEYxPjvnK@nongnu.org
X-Gm-Message-State: AOJu0YykluADcaLG1z6BVQlvIRPym4bHv5z7wdOI+CbjLzQfMot/Dd/f
 WPe3l5XXYvECQpSKJY+vkFROjRaGwZZOesNLhnwYs+LHFipU0jbIKmMboSjdNtA=
X-Gm-Gg: ASbGncsrDWQ8tHEW8lz9Ysltwhc5pgAnoJ7Q6WaNcMK6sh5vNV1Y2e3wEPh8h82uLP/
 wiTtf+K4js6ho12M3IBh6YTamaBR1lu+9I9eU9puHsQQJ18CyrJFNezaB8Zu+y5BNSbFV1s26Z2
 4iCAZtGxbz+A1O5MfiVn0ZfC8JYgTcpn3gsryJW7bog33WbXBEKaUL7YJ4fUDewUcv4sKaP/RxB
 iFn1K1cA5TT/2c+pjkRPH9yxTJZYlugRKW86y9fnaVdxE0UaFwnq6sTNE2olA2uLeJM0p/yaW/Q
 VcHKlg8aLDDEvQPlYYalCcpAvKh+XyZqooQo3dejJqKWUX4JbcWrif+7pQrutpDbtw==
X-Google-Smtp-Source: AGHT+IHNnOk1zfZWM/6f3gH4mUbHpY6w8pktKT2uxF9mFZ+o4N7JimLKAlUMYLv5Pi8Rqfg0UhKdvw==
X-Received: by 2002:a17:902:c946:b0:215:8f2e:eeda with SMTP id
 d9443c01a7336-21c35609304mr426878185ad.52.1737740993836; 
 Fri, 24 Jan 2025 09:49:53 -0800 (PST)
Received: from ?IPV6:2607:fb90:c9e1:9829:9eed:533c:6788:9f4a?
 ([2607:fb90:c9e1:9829:9eed:533c:6788:9f4a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9c9fdsm19325595ad.4.2025.01.24.09.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:49:53 -0800 (PST)
Message-ID: <c6850a53-8f19-4fb1-8117-a9a3589d3806@linaro.org>
Date: Fri, 24 Jan 2025 09:49:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/hppa: Support up to 256 GiB RAM on 64-bit machines
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20250122180913.18667-1-deller@kernel.org>
 <20250122180913.18667-2-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250122180913.18667-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/22/25 10:09, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Allow up to 256 GB RAM, which is the maximum a rp8440 machine (the very
> last 64-bit PA-RISC machine) physically supports.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/hppa/hppa_hardware.h |  2 ++
>   hw/hppa/machine.c       | 26 +++++++++++++++++++-------
>   2 files changed, 21 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

