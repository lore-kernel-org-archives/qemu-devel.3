Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D7CE83047
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 03:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn6rw-00050O-36; Mon, 02 Feb 2026 22:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6rt-0004zC-Tl
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:14:21 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6rr-0007VB-TH
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:14:21 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a8a7269547so49837175ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 19:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770088458; x=1770693258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k8y0Ur4c1ycmWmli80FOWvHrOLOPYukHs01JFDWgQW8=;
 b=EgNEivWRcqA/PDcgtKbz8zPFY/DtrP/gv9AB/+mJ6Y1slb+0gRBt3WY2XRUIrTlNZe
 yP9B4ivS/5lq7s/ERwfDn7Avmj7WqvyIUas6hO+dySqr9pZNVLPfsQHpmuasjs1e1akh
 DykskQk7+2ljOZzN9JLWgXzVoiaBCYqHsWmkR+LiCgKihVfnOhBdrM1Zj/+k6Q1J0fGB
 xH0I5lcoqa2KpaCRL5v7UpKTbqyo2jmhhK50BJDXlypuoLNVPODB/S5noLA+Uflopamj
 p/gyNRWeNHbx4cq8rEY0KiMzISGTPFuObOe5IX9QVgqB2U3yZNkDPrX32BFR5/mcNIWS
 vu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770088458; x=1770693258;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k8y0Ur4c1ycmWmli80FOWvHrOLOPYukHs01JFDWgQW8=;
 b=sILI3YWMrCkq68sNwyZLRPlkcdeZaW83p1pvFZsggY65Cwj58KH2PdeesupTojDc9R
 lI+w/awk8cJEQIhZT8CluaYYp3NpnjSkvpI6/i2PEzfQLeuwv5JRYwfk0/yttN0UI3fv
 xSaz/QIbA6lgvKjUOe+E93S6KnAJwK5/oMfGbsWR7Kf051yFXeXM590wqVQDAc95NVO7
 DwJvVfE+A+9Mp3yrXLWDhj/ZEdKIL3DALlZHG7k7ok/RpH2KVq2FYQvOc13mFm3qPeWD
 BLyvppmaAYaj8HlOi3FlCOI83ZJqwCTyIYCqtr8r2aSuywOWieEUQ/w6U3MnoZ6t6YIL
 ahag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp5vgYt14hKuiDlhQOh+WceSWBojX/52Aw8ezBlaAmDfEyrewFvep9aLC7ZzPmDokkE0NiOtebAyIc@nongnu.org
X-Gm-Message-State: AOJu0Yz2yV1cWQgAl+d0N8I97Iz2u3EtmodImpJ2mH8K8oZKHph5wcVe
 y0c+hOzAVg2haIYFKxOGADQdB2naOdv/KzBKjbG4GOdNVTprC8eN0RknxekbcNGMlZ4=
X-Gm-Gg: AZuq6aIQ998+svvwp3AgZbdIq45z4eHJLpCNZ6U8eysnX3mvmxK2K4w/CnI2LFacfAd
 9iRdTmGE631ZHPgc6NyfVefWWAw7qdO8I/TG8+zKwzQXjFeyBiGjiWShExNjamnljE9oWsiAI3+
 OnuDFT+qcdudbhBTitpf5l0Q7vYDF+tGWErHdmYejfN8MsXzEp+/Xj6D+PZMfmYMbxpDR6VvhOr
 AQVXg+x8f7ABVPqejAp8aavuXKqCR5HtRx5bSLHe2wQy4ucfb6X+MqydYqV3XnvVphNY2v2jvR1
 5LsBPCiI9pwHFyn4gbqFRsbEEMEby2EL2OLmJ6M8zW+krh3MSGOCmKLWDUSWfqma1RN5dTf1WL0
 8mdkVT3mug1GadWS3+YeA2c0x2ImVTymtAVm55hBntDX9zLMk57oxNktYiJy4NtvcJq3lXrf6oU
 MfZ2YDP781HoTdbW8G2Ka2rYzhoRYwQAkDUHJJWtLUHsc/tLfL04fb4YHKU4M7R2t1gNMObWsmE
 B641JczB00ufVGyEHsnR79WJnD48s2ojMclyg11YQ==
X-Received: by 2002:a17:903:1cb:b0:2a0:de4f:c9b with SMTP id
 d9443c01a7336-2a8d959aa6cmr137909145ad.4.1770088458248; 
 Mon, 02 Feb 2026 19:14:18 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b426e3csm166594315ad.44.2026.02.02.19.14.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 19:14:17 -0800 (PST)
Message-ID: <d9114c73-e1b5-4e2b-8b11-b7023c206f38@linaro.org>
Date: Tue, 3 Feb 2026 13:14:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] target/arm: Don't let 'sme=on' downgrade SME
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
 <20260202133353.2231685-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202133353.2231685-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/2/26 23:33, Peter Maydell wrote:
> In our handling of the boolean 'sme' CPU property, we write this 0/1
> value directly to ID_AA64PFR1_EL1.SME.  This worked when the only
> valid values in that field were 0 (for no SME) and 1 (for SME1).
> However, with the addition of SME2 the SME field can now also read 2.
> This means that "-cpu max,sme=on" will result in an inconsistent set
> of ID registers, where ID_AA64PFR1_EL1.SME claims SME1 but
> ID_AA64SMFR0_EL1.SMEver claims SME2p1.  This isn't a valid thing to
> report, and confuses Linux into reporting SME2 to userspace but not
> actually enabling userspace access for it.
> 
> Fix this bug by having arm_cpu_sme_finalize() fix up the
> ID_AA64PFR1_EL1.SME field to match ID_AA64SMFR0.SMEver.  This means
> the "sme" property's semantics are "off" for "no SME" and "on" for
> "enable at whatever the default SME version this CPU provides is".
> 
> Update the documentation to clarify what 'sve=on' and 'sme=on' do.
> (We don't have the equivalent bug for 'sve=on' because
> ID_AA64PFR0_EL1.SVE only has 0 and 1 as valid values, but the
> semantics of the property are the same.)
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/system/arm/cpu-features.rst | 10 ++++++++++
>   target/arm/cpu64.c               | 15 +++++++++++++++
>   2 files changed, 25 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

