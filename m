Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113D8CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6Jv-0008Aj-8o; Tue, 23 Jun 2026 14:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc6Jq-0008AQ-9B
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:57:58 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc6Jo-0002wQ-NC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:57:57 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2bf20f6be6bso1265475ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782241075; x=1782845875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kQ/Y3QMczqb/P5dCe2+1n51QC75HYoO7iVoEfwPieNE=;
 b=s8PlHTfiiZI1woqsyLce0Hp4LQCDw0Ae8ml2HysJU+qRFZBVQixKRi8hlF+PSok58R
 kLO4IaVby0ltt2/Dc+cgPFwVV8+DERTL9vtzQd6TBlnsG2oE9fE21vMi1W+YSjAt9gIE
 G2h9+DtGhdaocBDwueIEtif8p8PNq4u/TvX1/AX/nqoLK/lExG+WcfkyDwsHoCY9Ej1D
 j8xbaCSX4hmj0YRsyfExq3frbwGxtux9fI/6scmC2lCujUpAr5Buz076xvpkN9FxeGlC
 gJ6cJIvy7lWBTqNLP0i1gl5tS3D7R7hJCj9uKKA4oUUxMKta9Q3NHWY8YYWSIJrf68oE
 nYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782241075; x=1782845875;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kQ/Y3QMczqb/P5dCe2+1n51QC75HYoO7iVoEfwPieNE=;
 b=e80y8tN04Xd6ujlGQ+4E/w4v681rigvbPW/vuV60ij4r2AtWxupG36xdMvhObHh+K1
 SUrPjZEGV3R0Bp34A/wOzLa2FkxlFU+p7Qh4A5SDLR7irZRgpZMU8+o0NqpqMMKzUx8O
 +TN60Cs6ynAFLAmCHtskoYaOrAgdz7qPnsSzyaXP8Togqxlwag2fEvrAKUOpWM6uZ4Nc
 YbcrThO95Sby3A/uL2u3O09/QlNHcqQr36UBvj9JiR2PqkzA3e7//eHx7iQ1nL+QqAV2
 m09gN+3zyze+T2Ne6kZ7uCMRleUlvZyLron3pIpT7Z7/mAtZoxRpP8NE82D75GAREisl
 zMwA==
X-Gm-Message-State: AOJu0YyWM0+ms9wUJEItNb4t9ZuB7osqEbWqnplHjQxLnFlP1SDYk+v9
 uM67Nz+etrqu4EBGVw9V8dnPpcz0yHeJf7jEj2hEu6iKUUR8A0Gn2ep+jOef0tVbw51J0fxcuic
 Y7FJz
X-Gm-Gg: AfdE7ck+JtI2pWqy7Wam4GsAdcRb/JoStOAZjg8IqqrvhVnX2Pneixx+HLEZtO2Ccj5
 WNvA+9xRFshqVEr8VNo+HFNtvYXHr10cNhw08CLAEX4Ut7MkIfd3ROHvYWK4zJMjD9g031AzRFg
 py2WAIUciQAeX/7d5U8bbcmNNi6uwX0XJM/t03AZkXFMSyr39IcDpb8hgnUqafMyTXIj1UCZjho
 jM+LFr1dv2BlH02SBuwHztHfNd0kPDuvIIF6Q6JBKXR9uG2mbUx1047LWIRXRBENgndwj3pMmxO
 64xCw3ro49Jlv+XbZOY/hLVi6Co0Jlw26ouFbR5sMgIIMADE6NQaM/VCRt3VZf2zjTz2eZ7127N
 IrJxug7AothqQvX8jwiBJd2jHHVc2vtgNyYac/xNJB9ZJq43QiAVYD3a5OiBWM+YOlvQnz09qG6
 U/7UFOeIT0PoHDaIzmkO5yFgQQm8xnONh+EagPmGNk+BUtKwzEgcgd75Xr9A==
X-Received: by 2002:a17:902:d2c4:b0:2c2:245a:3364 with SMTP id
 d9443c01a7336-2c7e1543bf8mr1364365ad.32.1782241074812; 
 Tue, 23 Jun 2026 11:57:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7436d37absm119669825ad.20.2026.06.23.11.57.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 11:57:54 -0700 (PDT)
Message-ID: <c79f657a-5a72-4b86-8b25-05b52b264cdc@linaro.org>
Date: Tue, 23 Jun 2026 11:57:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/40] bsd-user: Add cpu_copy and make init_task_state
 non-static
To: qemu-devel@nongnu.org
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
 <20260620-misc-2026q2-v3-27-f6ce23ad8dda@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260620-misc-2026q2-v3-27-f6ce23ad8dda@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/20/26 21:20, Warner Losh wrote:
> Add cpu_copy() function for thread creation support and make
> init_task_state() non-static so it can be called from os-thread.c.
> Move cpu_type to file scope so cpu_copy() can access it.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Assisted-by: Claude Opus 4.6 (1M context)
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/main.c | 32 ++++++++++++++++++++++++++++++--
>   bsd-user/qemu.h |  1 +
>   2 files changed, 31 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

