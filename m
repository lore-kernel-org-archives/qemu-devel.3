Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857F8CF6BEA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 03:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdKRr-0004IG-OZ; Tue, 06 Jan 2026 22:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdKRo-0004Hc-Sj
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:43:00 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdKRn-0006ma-Gh
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 22:43:00 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso13749995ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 19:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767757378; x=1768362178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VCx7taj1ij0XG//zg6LWvnjcr1H8exWc5ufwaH4z2sY=;
 b=GtusbpfHa20uQ6dbvmvAvV4R1Hdp5evaAHhZ5bVPD3SeuK9cdVDJijJq/yfXvMbZIC
 B87TCzQ5SKrFbQZaUnO7Fnwnr6jSB8NqrolBE9oNHwzOXsVBj14mFqKwcxgoiefu6mln
 FTTUQZ+q6XE8iHuP9UMZe4l5BmnSqvznJuJ+ZuP4jf3zeBvy7QSn4nsxRfdvvhMvaXFY
 A7F1+Lqgo0FGLzSy2Yjzq5LDXQ9iFiM1Iv2mtawtn7PXYHMM/xEidkGN7zgHvKLys+UF
 WRj/6jNIYntkldBnXltQp9KWOXyzA7hxSk18hgP+XQngMQqeN6eemX3aW1Gw9zyVzrT1
 p/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767757378; x=1768362178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VCx7taj1ij0XG//zg6LWvnjcr1H8exWc5ufwaH4z2sY=;
 b=dB8HpVvZUIgmlar1nKNVPoLsPetyEHws09iJqu9dpobEC0HGl2syR2SMRcQAwReUmI
 BClx2Ldzgmk5yx0CjpdXvkG5J+bkuF7fFmQhZvewoaGJWwgeHkFhO2mn27oCeym21QIm
 TghycDUEWUp9m1wepqXGkj9Wh3i0W/e1K083EE/kJeH+7SJ4OYOWqzQb+llm+/aFEho6
 c6XhD3NW6OlWCpHQlte9rgUaEnhOG2nfc6JqBR+Env1Sk7cbqOwMFd2Fse4XIM0jUX0K
 Nww1VyJcf2JPUxsa1wzZnTzIC5gsttFLHlI2XI3qA5LjN6LYNn1insgQYI6uvKpWwWYY
 +ATQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8oNO+L9kBJZCf2EYwEQG43DGE9PItEiMhT7lFQYtwsq0ZYr1AozA022VStJHiJ59UNHnxzAGwUhoS@nongnu.org
X-Gm-Message-State: AOJu0YwZzJj8t8+YJ/vY4N32G0ErQ4NX21TRVaC+0U4BQ2qtWPOS1AiT
 2VDcbQPWQT9+hyOsHrdKCQj4iq+3j1QNh9eajfkH4RcsuBJfLCaMJ3GdjU+uALBIMB8=
X-Gm-Gg: AY/fxX7nDXdCdsKMXp1XymBTydADzp+Eb3DCKE6lHqjYKLVA9L/8G1eTwFOTw+D/gYz
 8+ocIedKFrJcnaTW9DDXMKZw3XiqxbnQ1aLWCYb1YwpPZ2bwjdiL032ZMzdokULJ2ghnvjPPaG0
 Lrab11Q3gBBG27NWYbViabcSJxxKjWpweVvwlLfPR6Ru6Uzz1oWXBIBtPv+WUaK7sACo+IbDaeC
 rM7rsF/4iaJAxfObPrrTfalFMFiqe3JCDgpJzuAQeIMQUDv7x7Yhtlyk9gBtNDajq+GoaYRwgP5
 DK7N+SewvjLt3nHJK+rr/rwytMSrvWdJrBLuN4qfMmei27uyKYcEm8JXT3TqKf38x6MhYTN8F/d
 VuT5+X18F0tSejt/RocWhre8TRw2AO7lWSNA3cjVJVYPdElTpDw0T/ZmDwx/LeZjqMUB7s+oGA/
 iyi1jNJ5M1x8HkC2uzAzimO6J2zdf8aKxgzSaCP32DBM+9sR2ZfLNR3JXt
X-Google-Smtp-Source: AGHT+IFp7fGgqPnQyPec77F8Pt3OdLhimcbR7QzefiUkzSvOnJksxl41Q6g2zmBf0H0XwYfuKzYJoQ==
X-Received: by 2002:a17:903:178e:b0:2a0:c884:7f09 with SMTP id
 d9443c01a7336-2a3ee47f081mr10700145ad.38.1767757378037; 
 Tue, 06 Jan 2026 19:42:58 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2de0sm35054175ad.50.2026.01.06.19.42.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 19:42:57 -0800 (PST)
Message-ID: <bb0b5636-214f-474a-9921-4a33b839140e@linaro.org>
Date: Tue, 6 Jan 2026 19:42:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/microblaze: Replace TARGET_BIG_ENDIAN ->
 target_big_endian()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260106235333.22752-1-philmd@linaro.org>
 <20260106235333.22752-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260106235333.22752-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/6/26 3:53 PM, Philippe Mathieu-Daudé wrote:
> Check endianness at runtime to remove the target-specific
> TARGET_BIG_ENDIAN definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/microblaze/petalogix_s3adsp1800_mmu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

