Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0868DCDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6E3-0006AA-LI; Tue, 23 Jun 2026 14:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc6Dw-00069c-D8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:51:53 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc6Du-0002HT-SK
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:51:52 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-37c6cd1ac98so265960a91.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782240709; x=1782845509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pCnrg6NBLQf2EeY2ecoHPzcybxx8zZH6QXmtPMfHZo0=;
 b=Z/2VLo7EiZb8xbKNo7NDvB08oJshRU/fNibzqbGK2VcSNNYdhR9Pgl+XeYjSkcmBv4
 bpIS94e9CFMvPM4+JKIYZbxjZimi1Mkij+u7HVG2YY5nE3vDU9KG5CyNGo2uKcc5WjSa
 5kTzt6X/ukzxprz0oOXzAkqmlMYFhMxofj2TUlGp+e/ML2+16ROA9rmt6CHUaNfaKfRM
 WpTdow3jWB2Vhi3Ux/Dskq4hCpSQ4Ej9jyYyhH4dkBZ34IVWcxBFwNiRydaebdALJsB2
 Q192OrEwkbFZOXRb+m9mvoI3R0WP+4PhCf4+TObUYFCv3XIRiwU+Lfnak+9+T4woYGfn
 M3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782240709; x=1782845509;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pCnrg6NBLQf2EeY2ecoHPzcybxx8zZH6QXmtPMfHZo0=;
 b=J69BJRblBpdwM/33mvBnTlsUCjoLUbEF4T0vzgD9IkmA83+UvznMtyPDzy+YFqovTC
 Z8M1z7rMLjoFRNTW0oaebxa7NS8vZbtWs+v65zi6ampAMAsPW4/CT3O3GBC4i0ANXvO3
 mQxkxAHQ//L7he8RO0cPVNbhnPfcrCalT4GJf1zTuiEgWGxEjliUNdMkJBN5LTiV97jv
 yyktJv1TNvlvvj9OiWRcyDUkcl+iF18GyxOjUHcNC7+Rm3telkkzxIpZK85ztuBI+ca/
 hHlQZKWDCIh0TY5NbOOMgqYe0fj4httZxFoZWoCCwA5C5UWFKvNGY4afvw3xs7+lqoTS
 C1EQ==
X-Gm-Message-State: AOJu0YwbshbfJ/M+2IoJoZ0FMHLtjxQCDRGQBWNP8B/mlZ0/YMnd9qFJ
 c4t5y+AN/pWhvEpk2p9uJet3u8u3zKRHFxLEVaAosG0pHaPbggRAC0sLOtsta1tJFbVVOduVJvl
 9HbzT
X-Gm-Gg: AfdE7ckxbElpttEpzipcKWAjUi04YsdBA5MPFqvvEHkN+C6qKY1GXJajSYRQ53p8rJq
 m1sSUmn4x+0kPZpvnaa8sdWxTQ5+gqA+yIH3yjpOXyn/0worm29FU6KwboC6Ra+6D3HtGHeyqiC
 d/fzP30RaPgEckEKHnSYYnAvT6BahWLzdq9Y/DSQIgFCfCpXR2BYXw5NniIVHnJT1kAZnfziA6U
 4l5i2jCrVuZqQ7FsT1r3AeyVuFxDVSjK/41gXJcjkrxy3LXRlEc5Zhb+8Vkj/b62CO/faRKG332
 2XEGdzcIbKWwu4ModM3RHh996AW0OYmpFU1/VhhtC0zIF8kLZ4MmziVLyoCKzWOG/lztQRsGmcL
 InyY9HOLontCqlUsg48XvlwvQMjXUdLb8dqWJ699H0gdMzqnUw6zirZ+/rd/LdoNBwh913Mxfsw
 wBBusFsAwL85xjAM2spit2yG/9VFLQgawcpQxWtp6uxJG3RMiJYKqqxSXBMw==
X-Received: by 2002:a17:90b:4a52:b0:37c:a92b:466b with SMTP id
 98e67ed59e1d1-37dd0b19529mr5001836a91.0.1782240709166; 
 Tue, 23 Jun 2026 11:51:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37de3cc7727sm74208a91.6.2026.06.23.11.51.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 11:51:48 -0700 (PDT)
Message-ID: <f051d3a5-7e4b-44f4-8f90-10e5225047d4@linaro.org>
Date: Tue, 23 Jun 2026 11:51:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/40] bsd-user: Add os-file.h with pipe2, chflagsat,
 close_range, and more
To: qemu-devel@nongnu.org
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
 <20260620-misc-2026q2-v3-9-f6ce23ad8dda@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260620-misc-2026q2-v3-9-f6ce23ad8dda@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 6/20/26 21:19, Warner Losh wrote:
> Add FreeBSD-specific file operation shims: pipe2, chflagsat,
> close_range, copy_file_range, and __specialfd. Also add the
> safe_copy_file_range and safe_ppoll syscall wrappers and the
> target_specialfd_eventfd type definitions.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Assisted-by: Claude Opus 4.6 (1M context)
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-file.h    | 129 ++++++++++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |   7 +++
>   2 files changed, 136 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

