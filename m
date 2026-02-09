Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EB7EF06FE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 01:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpGQd-000585-SN; Sun, 08 Feb 2026 20:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpGQb-00057x-Nt
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 20:51:05 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpGQa-0002Gf-0r
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 20:51:05 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c698873a1deso1908395a12.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 17:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770601862; x=1771206662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2eE4rz3D3/NhnaIHHFK/7dN1a2eyjvptA6gvdGwk/7U=;
 b=p30XwNpO7d0XyuuHg8eWnWCgns9rb+oVs1FLvyA1JasJiaIXZea/x5syjtEn9Rd6q4
 1W1mbHCzNjcQBfj+MrQtY6ESq5TNZWGvoUvbz1k1tRTcWtTLgFwQmc6Ot0f4FN5T+LDf
 jScvFjTPZgtg9HYQE8Yo8u7QKAsds95VK17p8upoIZHMyzlcwzKUsOqWNFs+74wvUWBy
 cVegZNfol0Q6UBs4Be0bb5TbQSJ9VUiC0P9TiYE54/mWhHdpnJKM9P8B0ReWDhO8sYfu
 mLyZ9fWNOkXxP5rDjUPFff+6fkRAnAaCC3I5SGxe+cQZvMARycmOyq5jx9aVYK84Gf7g
 1/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770601862; x=1771206662;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2eE4rz3D3/NhnaIHHFK/7dN1a2eyjvptA6gvdGwk/7U=;
 b=fMe7kdmbULiDb5N/SJ2d/f0dQNFXNrcVrzIx0hdxll2McXRznle/ZDd25Z/0P/KxrX
 kyVBrmqRWd0OaAmJkoXnTXOSqZEO8O0Izard0e0NcCI8DBPMD/WT0pmHDHvZbPm0eD63
 mxZOWlN+T2htNmHtsLAiY67Jrse9OaPHa50lyjm4A9evZ/Gk+NVX2nbLS5Ags2OzGxF7
 njsFzryKk1xzPdRiVaAqjJ8SuXfpmxsudPabCJCBt6i9Qoi1HfXE/N/dCymz0tUAx1bA
 JmlgTsvE3QPyOfWD+nu+phsnE1enV7K9sv8QfDLEaef2HlUQZUCwgZOOEOPn5drBiiHw
 DANQ==
X-Gm-Message-State: AOJu0YxG5XQUNGC19YZTS+2gNS4R+NB8Wr8RO0hSm+jrxaR0ZeLZ+Sff
 xre/Dn6ybXdKm9KRWx54Cjxmtl5TCZv4HQAUj8X9eAcX8lDqzsfsquX26AmATWt1EHHF4vz3X7z
 N6mVrhkU=
X-Gm-Gg: AZuq6aLoEO+Yn+K67u5bsqEco06Y4cxj2ItKjQZl7SF1mlUj0qf7hTae42iUOZB9Rb/
 wGSryPj0q8Z4SSbhp1QQcEXnhrWCNZakLHx/lmNG+vS9wwXZzIYEzlhZd/fMySf52ojvCDfMfS+
 NzeZw/HhWs2YQ/HwDBVpNjQedBq4PvXbmRhJj9WokWEAcuWkzMQoPbQ3FSagIPW19mUkdiU0AY8
 UEYxVUUxLtopPuZ4hxfsZS3vibq8oOLLpTKU6LsI+f13mBZ31h7WzkO6rXQLsSwAjzzKdVmHNnR
 70+aRtLTQQQdEuknRJCqtzuDxyezAmSVCb3KowwEiTyYEcopbnTdsm93EKEpY+DkI8kxjYZ1yvE
 l3zUmduMBKQik48UzYhfFlL90CyztiDwE9a1YqE/8OGOnrSqmeQJp2Wz94F+cxyTT5DKo2dDeWX
 IAYaxFvQrU9nEfNomE7ZB8ZFSqrYDPEhNRqWnqvjsaK77/fLgajyQDK7oBdjGkQpc=
X-Received: by 2002:a05:6a20:394b:b0:366:2341:4980 with SMTP id
 adf61e73a8af0-393acf9950fmr8884867637.11.1770601862008; 
 Sun, 08 Feb 2026 17:51:02 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354bcf67079sm3088626a91.11.2026.02.08.17.51.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 17:51:01 -0800 (PST)
Message-ID: <829510bd-38e7-4f5f-93ee-e2de708f67d8@linaro.org>
Date: Mon, 9 Feb 2026 11:50:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/24] bsd-user: Add target_to_host_semid_ds for
 semctl(2)
To: qemu-devel@nongnu.org
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-9-58e5fcfdb84f@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260208-bsd-user-claude-v2-9-58e5fcfdb84f@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 2/9/26 05:26, Warner Losh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Add target_to_host_semid_ds() to convert target struct semid_ds to host
> format for semctl(2) IPC_SET operations.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Mikael Urankar<mikael.urankar@gmail.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

