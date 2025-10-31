Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081F1CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElyu-0001Hw-E2; Fri, 31 Oct 2025 06:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vElya-00014F-9e
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:03:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vElyK-0001p3-2h
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:03:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso1263358f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 03:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761904979; x=1762509779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EPPGCtoA5Mm0eWevCeVOVOdz/NCwj4tLvxy7/WABrCE=;
 b=UGeXhKc8bygajCK6r6PGidwUX4jcfXbBfplrRFcq6c69AYsXMe7pRkkiHaAccFR78V
 CJxUi0Zolu/FvKXvM0c8MuHYwRP7hLufcNvjvKiNECyiHfPU6VOBX14qaf2s5g6Sa1wu
 CRYQnOBjo8eXyziF+TyizfFzv4QzGRPnvj/N0i1vtWJGVaSZ51q6w6sjIr0lp4I31TiO
 b6yGeg3XlNDDdy6kFDCgipZ1NDStYMBKYf10Kx4v/JQFi9LZuF4jxaqRe6/DUeTFpYma
 Q+Hij5Be/CIhufLeDvn9O69VlJMlGDsLxrSxFUMuJypqTHc2fLWxtM0iHMbkHTqO2ZXY
 pj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761904979; x=1762509779;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EPPGCtoA5Mm0eWevCeVOVOdz/NCwj4tLvxy7/WABrCE=;
 b=b3uBGJrv8HajxlMHVUYuaT3ZwTK9291QVkQNMIkBXN5zd/ZE1rL9LnuRhQgpugHVAG
 3jAdSEQUQmtBquLHkbHtx05SuBXTltfOEa/8yiPl2nmxCU2hezLi4znDuwiJTQEELAwC
 w0ftyDvfzFc3NcQCGHvDS6szmwiVQDGrwwJ+x3aOg/uVlkysw/sJIsZ64kelXfkZKZNj
 4XyU9FMZdlVAKf6i7Oo5KJwYumlHPrzTH0UqoteiQRiK8EEDZ0SVb4DXfTtOTuL/zuYv
 HTNv3KQ3yOHpsTz3Ie/1h5gIVfhO5UUFnEayJxzyCDj2niocmfwyuGLacAonmzfgnCbl
 VyFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP0tRjWNPvOE1aNK8iTlFn2CDQSUzrt9DE1s3S+e/Z9EEpxBR8zxJ890kH29x2SV7bKGlrfEokh2Ro@nongnu.org
X-Gm-Message-State: AOJu0YxZTNhupaBxXIdoPUV14WR+WiNuqC0Vpr7pauQPOBny/NL08epZ
 MH5AwI9cZH1fsDr5G+0sB1TD/W8M55kUKq+JLK8QvIcbNb9a3OgUBhdI8xm3i4BfNag=
X-Gm-Gg: ASbGnctU95ghy9gND6V10e0c8a3m+1MNbu27ncAI80Kw/F66t1BrNaXOiu2N4U864So
 p+HbAKJwG44hLhNcfCRpuNdgmiU0QnRsHiDn6HeUu4liLZpqn3u0n3cBR0zp1lNXY9Hx/XG11k6
 drkEgIofaDqZbCDzVQjY8CVVDJz/MQh0kXINIDYAdcXKjRRkCsryv4f2r07+jQwqHQLBdH8AIB5
 0/raf8odZ5O8PW6oDsqPcIuLM9bZ79cRAXWsXYExoiBetC9xE5rCERqK3lSdx5verbJ0idnD/Ah
 fPd2hlcZzPr3pCyrWZqXZe6MkY1wecXAtpGc1O+aCyhhyZVVvBk7LaCVw0oapJJ9adk2E9aSacT
 jRgVgqN+3AJxBTOSw+gaWXvi+fsvWt0K6cbFlzQ+99a8Fm4siDQrRjkYteD8DZZ/USpii/0QSXA
 5gtAr869Szi7oeLFNLDdxcUKyM4DUURh0AcPKXcU3KliYL3UwCKt12Ovw=
X-Google-Smtp-Source: AGHT+IF7oEGUes0n74IUTmwY0fcEq1HJCsrs3IzRKBkuDREmfhLTgqboNKG0yjml5c1Qvdmhxcrhxg==
X-Received: by 2002:a05:600c:3b1f:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-477308a8988mr26106325e9.37.1761904979399; 
 Fri, 31 Oct 2025 03:02:59 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47728a96897sm86211335e9.11.2025.10.31.03.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 03:02:58 -0700 (PDT)
Message-ID: <2082a538-db12-4975-a90a-c2353a0842da@linaro.org>
Date: Fri, 31 Oct 2025 11:02:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] qga/qapi-schema: Clean up whitespace between
 definitions
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, kchamart@redhat.com, mst@redhat.com,
 sgarzare@redhat.com
References: <20251031094751.2817932-1-armbru@redhat.com>
 <20251031094751.2817932-6-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251031094751.2817932-6-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 31/10/25 10:47, Markus Armbruster wrote:
> Consistently separate definitions with a single blank line.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qga/qapi-schema.json | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


