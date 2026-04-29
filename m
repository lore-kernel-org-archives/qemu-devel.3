Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C1FFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC7s-0002CJ-FW; Wed, 29 Apr 2026 17:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIC7k-0001UB-BO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:07:13 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIC7i-0003yq-04
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:07:12 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35da9c0c007so166146a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777496828; x=1778101628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+dzUFNSSesW62gQcIG+WdwMO0/PUjXTzosaVNqk8UaM=;
 b=R3jxBHxQLmhHmXOOhKH+JMTXd0rvuVqBGI+BgJpJxhlBsGJyxE6dlMTe8ZFbYsDAcv
 389t33o3xOHsv1evGhYnr2pVtwHRUIWtvvS1V+6P15gXeOeSmzFHSTeqX4i3bWBoQpFO
 ouHANVlRsn0n9n8at5gkXEUsZey8OQr+89IEkHJpf8yAfQcBCB7aLekQP6O1GEmOWmEv
 KuMxd1HsulJ1r+S61IcPj59CVhrtrz0O2Ip9Nqt8IT+pCvx1GDU8HLIKTYJm84U/I4C3
 5XpW7/tNsZqz0XYOLgEOg0YGjDusrDtcjdkGyWQvdh++8a6HSf81TyOFNRTRHN4qEzWv
 eMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777496828; x=1778101628;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+dzUFNSSesW62gQcIG+WdwMO0/PUjXTzosaVNqk8UaM=;
 b=QLQIR5uoAZ6NP8azd/MzM6NgaSNffd8p1hWFuahydgOm5hDWZNyxayJ0gcgsN18y26
 zsxvjf5rORGC/s/i/gW2XRgUptPvM2Yt557iUPO88QRvjOoarLEvxfM2Q4oU2w2YR/1j
 USW+127zJxzK9fUfNzR/9s/AsLYSKZ07VjE2t0bM1ge7dVL6zCiqkD6qTXkk1b9DlNbc
 xghJ3kHqG2dkZcP95uveftXfo0/qGrjGMV6QJZUjT6hTLeKwmy/OzZDN4ueBErGCiX4d
 5mOK8eMNi99tEb2bAVjYj8Yp/OA2Xli0riMpX6Mhd+KX9Drs4hXeMmZ+IK7EIHH65U3r
 ut7A==
X-Gm-Message-State: AOJu0Yxt3lcY4tWpJ9AEwnFelsfgeqoVGBWl8dUZWZt3jAFYGZ6F9YX7
 MviATR/SH3LgrSt6g4I1NFbip8k6VCLHiaaSvjMEjJm9WKpFlhZf2xsa46oIXTg+we7pMI/V9Ca
 +oshnYyQ=
X-Gm-Gg: AeBDietcCRLVFwcX58JhtaprXoUQnait2xXMcpbL3kKRC8p8g5GZ2ImTQnM5OsjKixE
 Paqmo99QhT5nSeSK6QHcTgLNQlTrCtQUO/uDWF2QLvbf/c9BpBna3H9bN+UjJFFl/1oLdih6ifI
 FnV3a4qepoRti8rxK/z9g1qMMeuhR3bQoF1g9CV8pjrD03MoYwq3ge3y8rS/3JIRmdpOSNb00Q7
 OzMyGjhegp82T7VgU4Ev/2kFf9OtnN9n8ZM0BAezCx+gM5wiE1azmizo6+u0fQPo1AgHn8NH1Pl
 RnfcM5OwK9HqFCgtl9E1fFwvN1iq7tDuufVLQtOXhG1/vnkFJ6VqwPm9qtQfkVE/aaZRWsehTDU
 Yq/Kuwu0bLQHEqr1rFcZSJQYo4TBxqAwPSOkUmj4xQ4K7UQR8k/ex++UjIDmekYOrCLZP/YiEcF
 sqIHZkeflNWHHWBzXK5vFqwEr/h0bmobW3L8KQ7qefz5ROmZs6exKZ
X-Received: by 2002:a17:90a:e18c:b0:356:2c7b:c026 with SMTP id
 98e67ed59e1d1-364921bf8famr10148188a91.23.1777496827943; 
 Wed, 29 Apr 2026 14:07:07 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364be00b168sm494951a91.12.2026.04.29.14.07.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 14:07:07 -0700 (PDT)
Message-ID: <81772bda-5aed-43a0-ab2d-ac9b95b518d5@linaro.org>
Date: Thu, 30 Apr 2026 07:07:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qom/object: merge double hash table traversal in
 object_property_del_child
To: qemu-devel@nongnu.org
References: <20260429062004.36582-1-guobin@linux.alibaba.com>
 <20260429062004.36582-2-guobin@linux.alibaba.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260429062004.36582-2-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 4/29/26 16:20, Bin Guo wrote:
> object_property_del_child() previously performed two full iterations
> over obj->properties: the first to find the matching child property and
> call its release callback, the second to find the same property again
> and remove it from the hash table.
> 
> Merge the two loops into one: when the matching property is found, call
> the release callback and immediately remove the entry via
> g_hash_table_iter_remove(), then break.  This halves the number of hash
> table operations in the common case and avoids the redundant second scan.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   qom/object.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index f981e27044..9c0e8dfd02 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -629,13 +629,6 @@ static void object_property_del_child(Object *obj, Object *child)
>                   prop->release(obj, prop->name, prop->opaque);
>                   prop->release = NULL;
>               }
> -            break;
> -        }
> -    }
> -    g_hash_table_iter_init(&iter, obj->properties);
> -    while (g_hash_table_iter_next(&iter, &key, &value)) {
> -        prop = value;
> -        if (object_property_is_child(prop) && prop->opaque == child) {
>               g_hash_table_iter_remove(&iter);
>               break;
>           }

Fixes: b604a854e84 ("qom: Replace object property list with GHashTable")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

