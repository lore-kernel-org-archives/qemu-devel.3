Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E88CAC5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 20:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyyrW-0002zw-GS; Wed, 17 Sep 2025 16:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyyrG-0002vW-1g
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:34:31 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyyrB-0005DC-Eh
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:34:28 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso180036a12.3
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 13:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758141263; x=1758746063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wmnZdckKf6SKipVris/TNM9OcIAeoL2j2+rosJ+cvp4=;
 b=QhS0dhSk8UZa41TVGxjXCCq/3RHjHu6EXByGVkZ9ZErTpaVR9uVpsCL+eamfBooyi9
 8yU5gAWDvupUDAl9NyDh9nvIdgzwZsrp8ORl1qaNCl53h2USv/BzCND+OeH07wCHmD8A
 0t+PAyetlr/dSNpYYeEzzvxy4xb/NzIq7NKKZazQzdc5J+jzwccs3O6sU4BpdekO37g2
 fTI79809vL7WHj9GMKYoLsPOaOK1Y6JdQxbZ7XBnbUODbKpGz+hHzUUPICgo37ceqy9l
 VgJNSO4JkSGHJlIsXLFKxLvED56ZAXnf5vU82LEZkZCcf2yGrB0JAof1HC0gsmQn05sM
 4KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758141263; x=1758746063;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wmnZdckKf6SKipVris/TNM9OcIAeoL2j2+rosJ+cvp4=;
 b=OCo++8XE3eXrjWgFcREU8suYWKEOBdW7AYg0hrRisGrxvCQ6PBNnTqZg1Tqo2QygXg
 MmxIqRq0F3T8tnqPUJVQkEvPSYjmLSxyhuckW4Dum3PcZiIK5MJgupmSa2FMZD/nRHNO
 8KS23bbP7AK+hkABmxnr2XrxB1wTrCge7QKhvTYdxmu0pWIXNI89HYUntcZIOl2wPjlA
 Z/F2cUifoOkR3lj24lMJ9S3cGvs8ymt9Clb6TK5ZTHRykHl6V2wxYZq8FS+KtqODYpX9
 qAswSGdvqXkRqzpmRS/a3UsnsCRPKaMHQ+il+6o5fMhquCOLnQ51PeO4ZxwYQFqcJ38I
 hl+g==
X-Gm-Message-State: AOJu0YxjqJrJRWZC76JKlKobiKsyHCPneOKolqH/k58iFElPCGPXsi5d
 BKlDvde0B3hDpUlGgc/r94evO/Fra1xrr1L91vpDoC7Ba1BhjzE8cmywmGzHuuC2fUrW3t8Fc7a
 a/TWJ
X-Gm-Gg: ASbGncuyzyyUqZ/lmyVDXEXfjylcbW2/J5v5f7Kpeb8F46ntDXrtZjix7pUD8lqzKHb
 yTzrg88Xq7xqJ+a9FTCdlH2NWFq+o2th8L6ifwBt0O1UoYbFtcJ3gIkdiSC6X0ZeG6WYF+sSYwr
 m++sfwZIcFjyUAp7V5O+FivSsWCPq60K2VX/UoSVdSKNyazfj/10e7QxKSSQJHm2SohS3ihhBf/
 3lFK7/ozRwKjYG3l++6mmRemQdLmEfyQMxX0W2v4ALiUd1irZ0byeGRpaVoQomKg0FgvSV5TXxe
 +1aynm80NXS1gLOTiNFrl+8giuS60JjXJqFRm/Se08GGh4OustjPclfZlcZu7EtcOf1kSWrdFYc
 o7JV23IqIF7BFOvW+gX003R9l1fjcmsMhv8N7V5etT/IXLXeA8co0b51qdJLAuBw9bg==
X-Google-Smtp-Source: AGHT+IGcYu3GymUddxmxSFQ8DnRj9O5MhjyE4RiRrm05gy6OinXoZtO8IABQ1KhA4P+sVVNL6iKthQ==
X-Received: by 2002:a17:90b:3c8d:b0:330:604a:1012 with SMTP id
 98e67ed59e1d1-330604a1205mr769576a91.31.1758141263333; 
 Wed, 17 Sep 2025 13:34:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33060803335sm339748a91.24.2025.09.17.13.34.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 13:34:22 -0700 (PDT)
Message-ID: <e871527f-49df-4435-9460-cb1813991e80@linaro.org>
Date: Wed, 17 Sep 2025 13:34:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] ui/spice-core: Clean up error reporting
To: qemu-devel@nongnu.org
References: <20250917115207.1730186-1-armbru@redhat.com>
 <20250917115207.1730186-8-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250917115207.1730186-8-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 9/17/25 04:52, Markus Armbruster wrote:
> watch_add() reports _open_osfhandle() failure with
> error_setg(&error_warn, ...).  error_setg_win32(&error_warn, ...) is
> undesirable just like error_setg(&error_fatal, ...) and
> error_setg(&error_abort, ...) are.  Replace by warn_report().
> 
> The failure should probably be an error, but this function implements
> a callback that doesn't take Error **.  I believe the failure will
> make spice_server_init() fail in qemu_spice_init(), which is treated
> as a fatal error.  The warning here provides more detail than the
> error message there.
> 
> Cc: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> ---
>   ui/spice-core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

