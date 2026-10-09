Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49602CA6012
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF82F-00031O-Bp; Fri, 09 Oct 2026 06:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF82D-00030f-GH
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 06:41:05 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF82B-0000xa-Qf
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 06:41:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48b03f23305so5094298f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791542462; x=1792147262; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uuHHVEc7v2aHvl0dOKGIXWAVjpYX/4TOUa9J1JewbxM=;
 b=y37Yt1bHHoDovbDaXgfYxQpG0sOlOpJG9vkqvXy5Kh/Vs2rG6NwbzdfKa5rNSiGSRd
 cw7O9Du+7Yl/eiytbD2LMUnJEE8CXm00A69P2Ume74u6IhM85JeVXflNBssazOUzPlnq
 tffRZ/RIAElETtyLhOCN6synqSmXGXEN7d12Bz8urfo6nAIY8OprMR/IWTzpdKg0IRlS
 a9NYkfnUL68j4pKYAE8S5hGkNJOHsWK96TTbWFOM1GirzWfDcST98k7nhLSWMn4Inw4l
 6IhEpTIMWoWTK/eq7zVW7HhgE4CM+OUwB3XEjl2OvpoP5Z8IcJj1iYAfpqsWx9RIbCV/
 jY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791542462; x=1792147262;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uuHHVEc7v2aHvl0dOKGIXWAVjpYX/4TOUa9J1JewbxM=;
 b=DJ2qI0IceTJVgYSH+RivI6tJrt078aL8nUGZdTnFL3dkpiSuY0JZksrpJn0ceJj2zd
 yfa6jQhbfa3sntJPitmnonZ70QLwYSzIYiQUEI4EFMsz/KdrhfBmQPBTwqTnLhQjlmhg
 uc5LPde0vhoClVFANL66CCClFtVulsnpDFkNWKZpHKci/VriW5BIo719tjrz++e16xDn
 ONwU5y00ZsjIo+0ifGTVwej5/wLNRc9HPpRl+mtWmri4X3vU5qT9VSmutYpCZIlQIEm5
 7A6KgdyHaMSZbqQnbhtdr6s+V33wP5E2xybnvvVfmHZJ8IGhhHFfC+7wkT1Rsz1hXKq5
 4qaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzx+svq/2NY4xWyEC57d4Cb7HPAhXQpNK9yEqbH1EOMCuOEeRdZh+LiXOurZg/vqGoEA4Y0GyNvOob7@nongnu.org
X-Gm-Message-State: AFq9FYIocQP9omAI/6Z0LCCKzMFa+UKylnClDK0+W9ZefMnxs2KyTxNm
 UxBWoR9nP9SY2Zdy6F1UMj5Cd2ujMolxweqIilBYzr7e7FGov6xmkxTcMVSPiDI+uaY=
X-Gm-Gg: AYBFou27cc8qXlY+HB1Sv3n8Q/WR0DXS6aHVNcx2TaSX7A9anm20CMeRHuTfHOQQeC9
 QAQLiDQ6NueHRuRIQHsYtw0t+bgKfr29aEZARNXz+lxu1JpNShG5j7y9pTDdxGK3HZ9Jf8MGCcI
 Zsy/tVQyoH/UmUc1wl7xBGq8fLxBHkVsy6Q14Eq9bIxoYUNDkEE8iH/H4VQ7ptPN88teKnlo5RQ
 UMwOB19EWPIGE33xTzojxmiq9UwFIm679i4u+tJh0aUdr/EQShAIa14upgvlcjkQfrutWh+M6vf
 3soxuwQgOfmNsZOmpmncJYwF7tCYYRXnb0ZI+Ee3E7mhTqG4oh915g4WpWgjByFNRISDJKftmop
 7AGZyhcoxr3pET2AlEZlXKG7NvqUgAnjmQNNpuDxopShlrhBUy06nKmhrSgaBw0BpEPy26nDpui
 5eSt2l9y0p8+DSiDbM4gG99i5tGR+pe3OqHlSRAjz9fsDnsI/MKWMR13fP0PFiEIbFrvXjBzkzk
 wqEqsXIA+y2dj5oaRsKtHN5BQFRJerAHlO1O1qfV+0Y+cGu1ONGvswJ
X-Received: by 2002:a05:6000:1788:b0:488:8a5d:ffbe with SMTP id
 ffacd0b85a97d-48dbaaed914mr2959446f8f.33.1791542461837; 
 Fri, 09 Oct 2026 03:41:01 -0700 (PDT)
Received: from ?IPV6:2a00:1e:e082:2901:3b09:79c6:5d4f:163a?
 ([2a00:1e:e082:2901:3b09:79c6:5d4f:163a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dba033a0fsm2646712f8f.14.2026.10.09.03.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 03:41:01 -0700 (PDT)
Message-ID: <45a86ce8-6db9-4636-b64f-577469a50901@linaro.org>
Date: Fri, 9 Oct 2026 12:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/15] qemu-nbd: Support -s and -l at the same time
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20261008131216.2437896-17-eblake@redhat.com>
 <20261008131216.2437896-19-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261008131216.2437896-19-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

On 10/8/26 15:11, Eric Blake wrote:
> @@ -1155,13 +1165,17 @@ int main(int argc, char **argv)
> 
>       blk_set_enable_write_cache(blk, !writethrough);
> 
> +    orig_bs = bs;
> +    if (flags & BDRV_O_SNAPSHOT) {
> +        orig_bs = bs->backing->bs;
> +    }

tsan complains:

../qemu-nbd.c:1170:23: error: reading variable 'backing' requires 
holding mutex 'graph_lock' [-Werror,-Wthread-safety-analysis]

https://gitlab.com/qemu-project/qemu/-/jobs/17055360066


r~

