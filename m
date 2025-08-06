Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDD6C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhjI-0005ct-LS; Wed, 06 Aug 2025 13:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujhKQ-0005EZ-JQ
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:49:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujhKO-0002H4-Ra
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:49:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-454f428038eso1109355e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754498962; x=1755103762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G/IkzaX4jKGRMA+i2Ktavn4JsZl67/autyTljYzlV2g=;
 b=Tuk/NNPI1koL4pW82q0LwWyjFLb0P4X7hNEiECJZhw0HOFrlHZBjYivoNyPPm5NNmo
 E5uUwAuA+phUvRT7TCEU7jBDs8QrcXhKi4hrw360a5ZZSZgSLu6l9kKRDTZ+zFCS0mZd
 tn9wOi9iHFY92B6jbfX4HLS89DR3dAkDc3Tfs77dxtpOB+An3iIMGtiRVbCk7WaIGAfb
 +xLs22cTT+kipcJ8s91it6cd2BVWxQtxbguEYXvfWI9fPxFufkLmcYU2B7RFuJi7/MdT
 gOQDgJ6ksv2jhTamCEe2hm1PG9XHstuZcVbuoWgd+RHL/ToDET+XFy6rtXVgRHPx3OOk
 VaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754498962; x=1755103762;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G/IkzaX4jKGRMA+i2Ktavn4JsZl67/autyTljYzlV2g=;
 b=dd7nxlOUdE3XhuXw9kcs6VQbIJ+lUPLFcqAo3iNTsu5mPpRQ13yorpc7b8ixUOrcY0
 iQONWMQ47kwaVb+oOz3rEpbLz1J9fc0j6hyczMK52FPoGcfo992ehJm8quaGa8Lci4Jk
 nmMT4DNYCd2MjfwzNlqKhFbgcRUsZiszzpGFHxNLLA/KLI517vpIEDjFhdWsCKwiV+Rg
 tlDDbLuYBJF08z6mA6Xg+60OYknqXYj6hdiaxJQDhq60pc7Ou57rGjYI0sBRwnI0Uxov
 TS3LHC2BhQDCADSpbxlwmYT0Nw9ziSLKO36kc8cQWEowUWCaqdbw7cHl4JjqUfPeOxZL
 HhMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6xPVnCWqLCnRsi3QPIVzH9O9hTiD18Jm6pmm3t9n8gYsshWerqLXniHQJFSthudh2ixL1M5JMGp2N@nongnu.org
X-Gm-Message-State: AOJu0YyHkDLqkrh4IWTvcs8i8RwEVe1+p+oq+pp+9Q80sZkkdeFrJ7i4
 tTJoeg6YIJEmVYxYgsGMK66aEYIy9nXzhuv5FZZsjgqfTGQK8fEWGl/u38aPvh+E1Cc=
X-Gm-Gg: ASbGncuP6Er01yhsL2nFyKbiXVEENwGSoQu1MiRHZRWxwhDQP4YyaKBwpz/Hwip4y+B
 yv53Ak2Wxmrp1M0pIzdQNT+j6wOGs/s3E9VNMxMmKFooADk6TAHW0V1rNwBmfpcxTIEj+SknEuV
 bxWva04VLNHddjXV6ayAbgiRpDlwB+G9wP1DktkeGM78ABtW8/OrFdHeATeaLc2xYcdIuFuhsNQ
 orLzsFifxK0EUWBkF807xyhlSHah+M6cZ6AffM93tQnnMd+78aDCrk0fgsM0hj/u1iDRogCch6I
 7zVlIeDFU4SkuJ08piJ79vFwH9dHdS3nnd7nvqK993s29J4UnZKcbJO2tywTs7/gOxIFqCBMLJm
 qgrjFDbZ4mRBdu2IotbobzAOy59711otixZU/5vHG+oP/YAVHX5Yq0G/BCZ2BY3sYKf2DC6ZR8k
 Aw
X-Google-Smtp-Source: AGHT+IG08PgWcvVT3UCfrEUHlpiv9B6nwRDBYC+9mW2NdYr7AnzGFzCzXGYIzFh8gK7WEzK3DY5noQ==
X-Received: by 2002:a05:600c:840f:b0:459:d709:e5d4 with SMTP id
 5b1f17b1804b1-459e6fb8315mr38204015e9.0.1754498962260; 
 Wed, 06 Aug 2025 09:49:22 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abed3sm23467152f8f.10.2025.08.06.09.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 09:49:21 -0700 (PDT)
Message-ID: <51c33c4e-6c19-423c-9c69-9a61302d5a90@linaro.org>
Date: Wed, 6 Aug 2025 18:49:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] virtio-net: make VirtIONet.vlans an array instead
 of a pointer
To: Michael Tokarev <mjt@tls.msk.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
References: <20250802142115.41638-1-mjt@tls.msk.ru>
 <20250803085443.318611-1-mjt@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250803085443.318611-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 3/8/25 10:54, Michael Tokarev wrote:
> This field is a fixed-size buffer (number of elements is MAX_VLAN,
> known at build time).  There's no need to allocate it dynamically,
> it can be made an integral part of VirtIONet structure.
> 
> This field is the only user of VMSTATE_BUFFER_POINTER_UNSAFE() macro.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
> v2: use VMSTATE_BUFFER_UNSAFE instead of VMSTATE_BUFFER
>      as suggested by Akihiko Odaki.
>      Only the first patch is resent, patch 2/2 is the same.
> 
>   hw/net/virtio-net.c            | 9 ++++-----
>   include/hw/virtio/virtio-net.h | 2 +-
>   2 files changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


