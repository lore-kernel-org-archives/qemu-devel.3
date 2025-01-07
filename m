Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CBCE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 09:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV5hx-0003Eg-RA; Tue, 07 Jan 2025 04:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tV5hv-0003E7-Qm
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 04:17:04 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tV5hu-0004V7-AE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 04:17:03 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ef72924e53so22339318a91.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 01:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736241421; x=1736846221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L8hhEqlHQ0AEGQDSWr47PnNloF147kADH/G/AhG0a7M=;
 b=XBtOt9TjSZdnrHxvY9+0RH1GMU1xzTfX3/pN4ptvOPUTDmiKls5v8fKwqW/ST65pDz
 1DP/dKLM11PhZeJvZtg6vsKuc/n5FhftalimGrbfjGMh+HSElpGLFKWAftDJu0yqSBfh
 BQjzCB5eQPogHayflbA4kvtAbyvobeXh7w2uFL6XvFm5sCv/9ELN5alsW4j8BhxbmXqC
 kmMUvwG3w0MZsTmS2DY7dQJtSL5NG5fuYIfXm+D+i7P2CRQkBdbbX4e7dkqbGB1gqG6s
 CapUM5yil76pDO4Z2vLBAsyVDmJHJXwP0ZMA27rbWcwS4RKMo4uODPvFPKbvvXpM4x8n
 PLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736241421; x=1736846221;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L8hhEqlHQ0AEGQDSWr47PnNloF147kADH/G/AhG0a7M=;
 b=tvqRSRaV8eNVnbHsDROtgbaZJMKCTM6m95dThuoMTcbowvqesBr13ofoQhhPtYH/oK
 gbP38rwvScZZcfrjfs3LO9OwPoYEv+62rwo6Nlsz/0p2eDZyTZ1RejpIWRiBahxe2Qng
 KjkrjJcBoWTmUJZ7tkR/h74JDQFIeFtPn8tPXeeqEc3jbUVByZoK8ENmJVQShxd6q1YF
 VMfVpRJndW1QC6nRfsaaRBUHqi6Zq1GU6Wo7EOq6Z58GmQLN0IyvZ7OhfCvjFcntkjqv
 lVIoMwe4rU9JELYY5wd0ZZ1Z9BGECrdiYsahTjvV7QZfsN98ysbRzmFI+C5JApDgxDrb
 EO6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXICGyYD8AXEH9E2jipUTvw2CaDSHulQBYO0DbJ86opBeXTtSkV1yQPVxSDewp13lq48dLDKk0bUYVP@nongnu.org
X-Gm-Message-State: AOJu0YzX7mBjfPhmxhxVngdwEKHj+sUJSu2Uwb9GJnB7RyMEDBGIL/Qm
 bIbBO2t/WTZsqGbWpgIilNKXdL0Xljj3bREw1l2wSEVPvVN3we+F
X-Gm-Gg: ASbGncthHS8Rs1todZYKuBvi1Pojo43lVZ8gyAwCLYd6eNZ1OOYosKiUU6aC6XNTY32
 2/py/yL1HiBNmiGdAVLVZuwTArX0CnAKWCp8o6gUyVz+/57me/v0Rn8hkOXvy/IbqJivwsQE1sQ
 Fxjo5zCFtS0vpbRdjzt5jLvAXMEhwUp5WQmojJRO4fAOYDBYnMsLerdFedKOmc4HD5wY6YzBEtN
 D4+DHaREGNsRXd0EvNi7PROyTb1mI13YMMTZJ3POOMWuAvEL9nvIayH5sQHMDtDLZZX2lI=
X-Google-Smtp-Source: AGHT+IFLYpv8mg4Z6dvH+Mw1fYfR7+f1gLVR2c93t43MCku0Jfr8r3sbiRGr1mEWVocYdjhe5dff4w==
X-Received: by 2002:a05:6a00:39a3:b0:729:1c0f:b94a with SMTP id
 d2e1a72fcca58-72abdeb9c0dmr91695070b3a.23.1736241420753; 
 Tue, 07 Jan 2025 01:17:00 -0800 (PST)
Received: from [192.168.0.22] ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842ddb09b2asm30053765a12.57.2025.01.07.01.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 01:17:00 -0800 (PST)
Message-ID: <a59dd0e0-12a6-4fb7-9494-23cfd653ade9@gmail.com>
Date: Tue, 7 Jan 2025 18:17:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ufs: Adjust value to match CPU's endian format
Content-Language: ko
To: keosung.park@samsung.com, Jeuk Kim <jeuk20.kim@samsung.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <CGME20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3@epcms2p2>
 <20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3@epcms2p2>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3@epcms2p2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 1/7/2025 5:43 PM, Keoseong Park wrote:
> In ufs_write_attr_value(), the value parameter is handled in the CPU's
> endian format but provided in big-endian format by the caller. Thus, it
> is converted to the CPU's endian format. The related test code is also
> fixed to reflect this change.
>
> Fixes: 7c85332a2b3e ("hw/ufs: minor bug fixes related to ufs-test")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
> ---
>   hw/ufs/ufs.c           | 2 +-
>   tests/qtest/ufs-test.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index 8d26d13791..428fe927ad 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -1164,7 +1164,7 @@ static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
>           value = ufs_read_attr_value(u, idn);
>           ret = UFS_QUERY_RESULT_SUCCESS;
>       } else {
> -        value = req->req_upiu.qr.value;
> +        value = be32_to_cpu(req->req_upiu.qr.value);
>           ret = ufs_write_attr_value(u, idn, value);
>       }
>       req->rsp_upiu.qr.value = cpu_to_be32(value);
> diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
> index 60199abbee..1f860b41c0 100644
> --- a/tests/qtest/ufs-test.c
> +++ b/tests/qtest/ufs-test.c
> @@ -145,7 +145,7 @@ static void ufs_send_query(QUfs *ufs, uint8_t slot, uint8_t query_function,
>       req_upiu.qr.idn = idn;
>       req_upiu.qr.index = index;
>       req_upiu.qr.selector = selector;
> -    req_upiu.qr.value = attr_value;
> +    req_upiu.qr.value = cpu_to_be32(attr_value);
>       req_upiu.qr.length = UFS_QUERY_DESC_MAX_SIZE;
>       qtest_memwrite(ufs->dev.bus->qts, req_upiu_addr, &req_upiu,
>                      sizeof(req_upiu));


Thank you for your contribution.

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>

