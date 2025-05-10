Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6650C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 04:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDbo9-0007RN-3c; Sat, 10 May 2025 00:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDbo7-0007Qb-99
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:27:27 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDbo5-0005dJ-Kr
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:27:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so24986865ad.2
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746851244; x=1747456044;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zwaaisldWu+crKb8p3S59yyBtmj9tL5gizYgTjTvJKY=;
 b=RHj33QVw0grvnMIGn1ttrFZxrfSf5IT2QzaBZrDg1O/jgRhoy09IWfoDH4Z77m5bTq
 6oUdSNHQEp/mYjmt29CWqG3VRIDWG+0N4DvEoW5PktfW1ljrYQ0GOdwJ1th4ZIppPXPv
 yQlqjBtO9X7OeE20iw2iTiJBVAW6rr7hMVZO5X8A9BdnBJmwRC3+ZB60eueHanG19dM8
 AjV362yOp9vfdFighb6Iwl/w8N0R260pynI9pkiDYBAkzqy81p2BPi1+TfPEct5uyWIZ
 EPXejPEr35FhVGIYX3UvMWmTzn3AyV7vJDEo48xhOGgvdlPxbMq9mMd3i/mk/wD3WsEu
 bmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746851244; x=1747456044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zwaaisldWu+crKb8p3S59yyBtmj9tL5gizYgTjTvJKY=;
 b=tU/ddlPMUsmyipYyXPY6ldINoely4W6wqNLZZQ/2nXe8s947HHMMzy5u18r87NSi65
 y5uulpm2ODKuH4nweTCoVZmACv83vG19sBmVKgZWvAshXwMUGwWiMbPvcyfuoiutFxx5
 +UYpX2wH6sdaDsLvwPYBDdrsX87oW85/gAATSOB3A4Ssy7fwC7BN/j5ini0TE0Butrue
 XyIPkHHnqHvFA8OTSO18Aw6rMnRDuT6cB4bNGdDFxm9olacFeI2w8MGIM2DVy7g5PX9q
 W7SgeEVI0iUrilc4WXjUH/s7I/I8XRHHX/SvWE8zS3DyakNBwyLOHRBgFIwtaywAsRPy
 oqSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3KqzfRy3DGfU8TRKK1mqHI2flowc+0crjwBsulMuKN8ZL6JOTBvs+q5uwtAUklOL56BICXx0tiW12@nongnu.org
X-Gm-Message-State: AOJu0YxpyhoHYjcX+S4S19OyQTTtK6eUjIRy/QdIp8eUpQ6s3Yr9t1kP
 zGTCHtkCcPOPPZ494ThkLdKiU35kdMw1DsMx/2+qVMfX+BHRMJ70kYLeWd6E/8hG3zMuXB1cUY/
 c
X-Gm-Gg: ASbGncuw8mgk0QMVFX+diJtYc4JTcJBDORAh3DLc0l8ocAdlfvOHrmY7/Zz6KL3UTxI
 bOy77ffDXw4Z/5D2zfAz3QdqCjov5mMn3RiqGqyBGRwZsmIxhvpWUdKluep5yeKZTDx+EBve8Y/
 xqz3rg0dvSkPP7ZICEJmSRj7qL56X5KVMVVi8MRBFA7qoXtLeIoII125scAjUEL+M+z1gbmJogg
 EqM3ky295MC3CYJdzDCBum4unzA4kNLfKrgLfLYl/OIDBPSI3E2iI06DNbgNbnH/Iqzd0KU30cb
 lgedGyfXIc10unt68hcHgn3ys7aL0BWxDnlfpKaknr+bq13/ILJ5x6S55/37NA==
X-Google-Smtp-Source: AGHT+IFoRlWbA6JdbvkTaMpnDwUcpeWAAU4yZj/9ELmRDcplPGFPy+HSf/bgPqd+2CkKujxT7cAOcg==
X-Received: by 2002:a17:902:e545:b0:224:1943:c5c with SMTP id
 d9443c01a7336-22fc8b4109amr90049365ad.15.1746851244250; 
 Fri, 09 May 2025 21:27:24 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82bfa06sm25344445ad.251.2025.05.09.21.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 21:27:23 -0700 (PDT)
Message-ID: <005c8cfc-7a46-4350-af81-46112ad5eb9f@daynix.com>
Date: Sat, 10 May 2025 13:27:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] Running with --enable-ubsan leads to a qtest
 failure
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Nabih Estefan
 <nabihestefan@google.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
 <20250506125715.232872-5-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250506125715.232872-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I think the subject should tell what this patch does and perhaps the 
underlying problem it solves instead of the symptom. It may be nice to 
have a prefix "tests/qtest/libqos/igb:" to comply the convention.

On 2025/05/06 21:57, Alex Bennée wrote:
> From: Nabih Estefan <nabihestefan@google.com>
> 
>    ../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned address 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment
> 
> Instead of straight casting the uint8_t array, we use use ldl_le_p and
> lduw_l_p to assure alignment is correct against uint32_t and uint16_t.

It does not assure an alignment is correct but instead performs an 
unaligned access.

> 
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Tested-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20250429155621.2028198-1-nabihestefan@google.com>
> [AJB: fix commit message, remove unneeded casts]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/qtest/libqos/igb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
> index f40c4ec4cd..7df9272069 100644
> --- a/tests/qtest/libqos/igb.c
> +++ b/tests/qtest/libqos/igb.c
> @@ -104,10 +104,10 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
>       e1000e_macreg_write(&d->e1000e, E1000_RDT(0), 0);
>       e1000e_macreg_write(&d->e1000e, E1000_RDH(0), 0);
>       e1000e_macreg_write(&d->e1000e, E1000_RA,
> -                        le32_to_cpu(*(uint32_t *)address));
> +                        ldl_le_p(address));
>       e1000e_macreg_write(&d->e1000e, E1000_RA + 4,
>                           E1000_RAH_AV | E1000_RAH_POOL_1 |
> -                        le16_to_cpu(*(uint16_t *)(address + 4)));
> +                        lduw_le_p((address + 4)));

This line has are extra parentheses.

>   
>       /* Set supported receive descriptor mode */
>       e1000e_macreg_write(&d->e1000e,


