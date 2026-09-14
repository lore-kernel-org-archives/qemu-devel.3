Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C4EC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CFb-00082f-SO; Mon, 14 Sep 2026 15:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CFa-00081y-0G
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:21:58 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CFY-0002EJ-KM
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:21:57 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2dd1dcdcf95so1659645ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789413715; x=1790018515; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ko50Md4z7IGddVBrZNocirDoF+rrWLv6Gp1p6sC26EM=;
 b=KWEAJ5xl/cS+4L1eOonBUqsneri6Cc+63ljx7P3znsXrCPiBy8Kt2aIFowzUgxvAVW
 QtrUIARLjBrqgCnfjmsj1GOS3wdxeIQrXLx5jdOBJgcF8LfS2mJqFmmm7ITrBB096vqv
 LbN5wkkBnwIYn1aCc4Cpkjd5W2sMKhVBTs/k4fuUYLSBQFZvMYtjqTkloUgyueCQEPAM
 NtZ6gr+zB8hsTJ+gMmXfJHAxRRLqZ1SYE/rKhIuJgSFQ37+gZxu9MmfyR5tqdQCOkzyu
 Mj2OH76FckEbvmIvNRnGiVNVc7oFUBPJ0l4jDnz59G7vPavccNc+Om+RVrKgsuCrRONa
 dzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789413715; x=1790018515;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ko50Md4z7IGddVBrZNocirDoF+rrWLv6Gp1p6sC26EM=;
 b=hjgdyE84ntLQnP42qeqVkzDq7Lq5A849v3Si3XvLh70vS6omVAPQwXA8ufi+nEadd7
 pXO4enNOKNGxzVg+ck5ICp4pB0Vn07NztieQbpOCVTQwjOE5UvtJnUfALSY8hZXs/9+K
 lm6f9Il1C3etLlBWAug/BYmYwn1hXSP/bZWEPUEQyQoqKgVC0u7IkvAYWxNr6HGgib+D
 auG3iJAK0fyNqOdC1Oweky5lbXc9c9QjQ+SFsRLuLFfKF0JkY94Zshppj4xmGgAwEib2
 PXPHHWIK3RFyI/lWTLqpiPe1iqhk8V4vWZI2ezJy4FkaZSWI8XLZ5LBWerwB4UvATphN
 H84Q==
X-Gm-Message-State: AFuF++npzPgElwDTct5uS53pgMYohT3/DCfpMXSdlIl/e1eRhha2/zT8
 6ARaofF+wSAUIjdcYQxHtNrmw5X7FIAbGg29qqXg56mdmbNMTQaC0wUukcK5kKpG/3wALc8ZhML
 AkGIIOl4=
X-Gm-Gg: AYBFou3dYj8Py95YveS+cjppf2HmTCoCH+3ATnXCcSLlk27+3EvjP+LMKkhvbZPu0Oc
 yO2nMaw52LF98zrjyClFsIRcFYuXNrsd52f8Xo+DYaez/90hj5BLzTsSPgJ8A7mQeCDe+ru8FMm
 o/+dqGRosIGsFDEjTk3FWp0qjpyocTKMxaAtnHTehf3CeB1svl5KR89aU3oO037sNqOkN56f9H0
 /ubAO5Td839u9kTFrJSonTkfxkrMRehYPPuqUbHH2u7ZM2v3tqJYL+lNFQw6w02Acu27FaDFAFP
 GnBk5zVIHsRQP+PMb1cPsC5tR+6bN6nKH082LOEmx1IZh139JccjZgQYX3zQD+RRThJn93H5TTV
 46bw2KwHLZ36F9A5fVYpQEptuYhLQ1BCH7U6RK20SrC+2gMn6Hszo0yCp0rn0rprcxgGDd/MxBM
 0/7qi6h6OSKX1uBpm5FHQp9Z+yfXW28WN5XZPJZ3QkgVvRiZK3DoE8WEhiZZrlOM9fBmjK98Bu/
 U5QaoZV9/0da5C3uyQTzMbUApF7XLO4X8UsvbGxyeDW4RV2Sb/NYFsUz1DTvA==
X-Received: by 2002:a17:902:fc8d:b0:2d7:1cbd:9ceb with SMTP id
 d9443c01a7336-2dd7651b9ecmr9715215ad.12.1789413715012; 
 Mon, 14 Sep 2026 12:21:55 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e4fb3esm27746771eec.7.2026.09.14.12.21.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:21:54 -0700 (PDT)
Message-ID: <6334ed73-2176-418a-a156-6864e2818ea4@linaro.org>
Date: Mon, 14 Sep 2026 09:21:52 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/14] system: check security for machine types
To: qemu-devel@nongnu.org
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-7-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910103628.2326622-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 9/10/26 00:36, Daniel P. Berrangé wrote:
> This wires up the machine creation code to apply the compat policy
> security check.
> 
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   system/vl.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

