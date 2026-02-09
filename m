Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7879DEF06FC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpGak-00070x-34; Sun, 08 Feb 2026 21:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpGai-00070p-MZ
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:01:32 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpGah-0004Or-5Y
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:01:32 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-81e821c3d4eso3365186b3a.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 18:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770602489; x=1771207289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=69DGvaWDWc9u21cVlbRrK6OVBcbt4x20a8ckSeY18yQ=;
 b=t8IZE0IV/Nw7tUKUMA9yTYaErLkFAcZ/YYfE3yBXATqjDPt9h387zhuzmcl56Cqgf/
 UUkQRhiXXHIiSted4cbUNvCF2FJdMufE0plrOvHIfoOu9vRUneYus9pax/gG7IqihMPq
 JpLxXsjdQhQVufOmGOomRsF7IJHjBiWllbRIgf0x5JF8csAXLt9b1S9hjuJ+DoY5qU8I
 heS4MTreQH6DijQ5w4FYSz/kpXVfhw5URIXod9p/PQqBuVip4jhU9sQK+c6ftTnZFlGK
 jDdHkavRr6NR04ofPw85Ew1tYuNMn+Ty8H+edLqMKzobNy6aQUa4NEfX9MTD1fBpZqUl
 GgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770602489; x=1771207289;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=69DGvaWDWc9u21cVlbRrK6OVBcbt4x20a8ckSeY18yQ=;
 b=u6f23v0SXuA6V/oSrpE5sI4OZFihaOIoZdJA9meTfHHNKfrpgAnxMAfahTTGKPeTPz
 DjFuX6VHZrBVSFAXaQOgh7gzqezZJsKZnpEY5/Jjp6RxsyD1Ae8qyx3NcQqg+zBGTMTC
 5wQlU4trY0N1KLKPdZIoezm2RyLYgI6NoiPdcenuN79h3cIX2iN4Heok/Dw61m26gzf3
 vAdI3YHMaNs3T3UwJ9WoMTNA2B+AFyKj7En5/eLObtC94/8E+NYVg+76ktSslvYrTjOn
 8OZ7VfMyhvXc+ciJjV1yrIyhVwibKkT/X8GvRyQpplOJ7Mi51mtrg2Z6QvMjkK/N7Onq
 frWA==
X-Gm-Message-State: AOJu0YyW0d0fahxE0JFq8K5eo2uHMX24QwpampJRFGZtYwiyv3fnpB4H
 LIYQM9OUnJl7NuCzizH/Us20/OTgps7JKvt+lk4qCulp/OQnJJnM1KImbLZ3Cfj0tar8N/8oFba
 UFnIqefI=
X-Gm-Gg: AZuq6aLA2sHpB4MlSlgRuJ04Vivwv256wVRGDDTww+Pf5LJQjkN289NYllute/uIqdH
 /eF41EOWEhaHG2aHvsTNcrK7uFY48zw18mJ7Dujp7zMiJCtvcgmpBELbaV+vx6i2i6qgXGMxxis
 AgwgdXnYzeod7WlvVduDnP28z6GzS/Q+srmTToyq5zKAGd0is4xmWKhL/b1os60iEDMr7cCx5C4
 5dqJaoUgclAmi+OK/If0WyVZ9/IzEMXg+cBiac1hNbg85+KITubmdDGVLHTTnzmObkB0+wWQXe+
 7Cglg/VSfdGr1l3TWYDajhE8nHDBr5lT3bX53imz47YHsjBWWxtbuLY2kP+FAdtT0tYCb+MUi3C
 rkefn3ThXhbwqK+m9xEPyIPSvIsM2fECbJlw1H7UeODNlSaM2zWcMWYuPPTsIXI86zT3Iu0ZbG1
 iCQdEhyD74XINPdkrO/1EV6m7lSULMF5e/3mGh5b2UEWoxiQSOIqXQrSkjUiBQkMY=
X-Received: by 2002:a05:6a00:9098:b0:823:120a:d09a with SMTP id
 d2e1a72fcca58-82441655aa8mr7875453b3a.31.1770602488966; 
 Sun, 08 Feb 2026 18:01:28 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824418a70fesm8207629b3a.45.2026.02.08.18.01.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 18:01:28 -0800 (PST)
Message-ID: <a7253e6b-8d19-48a9-84ed-7e0ff828eaae@linaro.org>
Date: Mon, 9 Feb 2026 12:01:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/24] bsd-user: Add target_to_host_msqid_ds for
 msgctl(2)
To: qemu-devel@nongnu.org
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-11-58e5fcfdb84f@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260208-bsd-user-claude-v2-11-58e5fcfdb84f@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
> Add target_to_host_msqid_ds() to convert target struct msqid_ds to host
> format for msgctl(2) IPC_SET operations. Uses memset to zero the struct
> rather than directly accessing kernel-only members. Handles FreeBSD
> 64-bit time_t except on i386.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Brooks Davis<brooks@one-eyed-alien.net>
> Signed-off-by: Sean Bruno<sbruno@FreeBSD.org>
> Signed-off-by: Mikael Urankar<mikael.urankar@gmail.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

