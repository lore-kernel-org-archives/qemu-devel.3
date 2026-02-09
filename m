Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C368EF070A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 05:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpJah-0003Zi-Cc; Mon, 09 Feb 2026 00:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJXH-0002fP-SI
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:10:11 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJXG-0008La-6o
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:10:11 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-352e3d18fa7so2237983a91.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 21:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770613808; x=1771218608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ez0KbiUmHsGmKxLCydKiW+szslJ24QUs5LKPic1PHs8=;
 b=InQoMXa4OhSMJNjjDxM9L76xivSNNquMLuxOY21GTN2/FiYjWJ5/pb9vxN0ycjMRhH
 OfXrUbA3emu61hGTneQVW/z9hA8tLTYVfRmzXlmPVT2Jt5iii3P9GSwJj54SowdJ8oyL
 5KEqJVu9X/yIHGAX80Go69T1iPq50abPZbGKJv2wK0W8AryfF2phjNl2/FVRYfNwn114
 h176N7yXzkYYZO/mALhlWzg7Y3CkDsbv+4jnuaAcV2/BkMy4Q2NuqGDKQC8ngLRYQK88
 jF29SQ1kZV4rJkigY50NRqJjRbPw2CSIDo0WMjfN86DO2dhDxBO9sJEs47fIXW15UVv+
 dxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770613808; x=1771218608;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ez0KbiUmHsGmKxLCydKiW+szslJ24QUs5LKPic1PHs8=;
 b=glSsRSL6h8ATqqRAf7XruCPio7stM0xR2rLoJlcMzTPkU5KWcx/hdU8IsdSoIAIc6D
 zsvo+9STq5N7Cj8xx03Vl5fOx8EMVRLVC9oWX238/OfJC/9dxDxklUiObc1YH2G0Mzn8
 0QDcoyd/+aK5bDq+PnNhJSqFvd4Ror4haN0MMuFjBcv381JlUQald1gnUat66gUm9sqU
 4v4gCXn63lkaCp9017mZ08zBGBYXD955sGyqW9ri759oGe/ftg99qKZnHsOmCBDoJLNU
 TkkeWP0KrrrmDzuv+qXG0NNe4QEXmQRGI9kVUmKNU+IaxC+0BwSxCANiNRvHSwC4eyUZ
 UVow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRiQBGMlQbkcZUqZzwucb7wO8Htjaxq2ko0mQPFHEYPQDr2ZT2BJ1c+zDzpBKPJKe+xdGZTutiXpdn@nongnu.org
X-Gm-Message-State: AOJu0YzTpcmyMVz5iyMdmPVOGnnKEWAi32dDqOACOpkmHbbipKaUE2k6
 7lc+9IIp09Et6QNi39AgTxUDoUYC/cDOIXA1b9cu+UP83rpC5Pg+1MAwhBAK8obgpWQ=
X-Gm-Gg: AZuq6aIxo64T4jLh6skHYZyPjr5DKzfoY3J2S2uejyU9uGgWhHSCDTsh3JeSHMou2Dg
 s6L8JvUj68IblswKJ3MIa5aZ1G23Vkw2ZdMer+dZ9kirN6500OhrXQjS/G2HGyU/RdXhMsibdYo
 o3D167oTPcXWhWe7/hndasnVonnBu8gw+NOONkMB3mcAoxvjR2cS2tEVz/9kP0RBS209zwSNCu0
 0rjNhu1ASxBznhuzjVOh/sqwshkw7Ec+Aa6gykfF/zQTQnq0+O4yB66VV3oRVH7pF3vIH36aZoi
 YqBz+7P9CdtMzme2taM/j7+LfzQ/qFrotCkYQYfVhBSYb95rbbfnd2B+q5sPPIZFnbUqFNIoUCm
 aIELm9OmRFMqgpl7VToGY0TzRezLxt1GsAJEP0Ss6XtW+LlDLwuiCUlfpXqpQNVafQN/lNgTDji
 zJF3HdQWBvBEEb3C/ZZTIlx/IPg5El770+BmIOYr2nFF2Io4vlrb7UCZjSqCa09x8=
X-Received: by 2002:a17:90b:3c8b:b0:352:e27e:79c5 with SMTP id
 98e67ed59e1d1-354b3cfeca9mr8506333a91.31.1770613808280; 
 Sun, 08 Feb 2026 21:10:08 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82441674f53sm8508078b3a.1.2026.02.08.21.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 21:10:07 -0800 (PST)
Message-ID: <da237fc4-3ae9-42b2-a6a2-e1a9b05c53dc@linaro.org>
Date: Mon, 9 Feb 2026 15:10:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] hw/virtio: Constify virtio_is_big_endian() argument
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 qemu-ppc@nongnu.org
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
 <20260206221908.1451528-2-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260206221908.1451528-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 2/7/26 08:19, Pierrick Bouvier wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> VirtIODevice argument is accessed read-only, make it const.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/virtio/virtio.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 27cd98d2fe1..65872f2c54c 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -468,7 +468,7 @@ static inline bool virtio_host_has_feature(VirtIODevice *vdev,
>       return virtio_has_feature(vdev->host_features, fbit);
>   }
>   
> -static inline bool virtio_is_big_endian(VirtIODevice *vdev)
> +static inline bool virtio_is_big_endian(const VirtIODevice *vdev)
>   {
>       if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>           assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);


