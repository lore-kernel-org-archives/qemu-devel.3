Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBA2CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 05:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOUnk-0007Cq-QU; Thu, 27 Nov 2025 00:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOUnj-0007CE-3z
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 00:44:19 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOUnh-0005mT-4e
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 00:44:18 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so2923205e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 21:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764222255; x=1764827055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=orUd2fzuLo38ncoSZTdN92II7Z9IDs7NVMqp7hm0RQE=;
 b=no77FM3PYHzi5pV5eOMgK/Z6NqGLpOb5k/zC5ninI0BeqlauQXRtjTWnsG6RQAeb1Z
 ysTaL9T9YC/lggLCG7XaSNM67VWPXMTGt7a31Zdh3hxfHmIw7e2d7zw0U+dGEo7VqWhx
 IDu/o0DMM/JfvLtQI8LQVSmH1Iiig9bnnMdd14rXd2F+b6M0otHx5a6uPnOsFsZYkzfZ
 2dxhDPJh1MeGavJuAAWUPZfYcQfGBtx1QW46iE/taL8qbzCK+3ou2i7CeyMhvoUEhM5x
 PG78ZauY14q989CkRNx19k5xggC7NVekhT8FriMf+1Mh6iqjtvl0f13QpOVJ3sPMamux
 86ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764222255; x=1764827055;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=orUd2fzuLo38ncoSZTdN92II7Z9IDs7NVMqp7hm0RQE=;
 b=EBLISBGLPsJvBAiKIQwYRVXZdoxmlD62/jZ2IxrR0hqBGbQkiQPzYVf5TqTQpAovXu
 QoosDHJIPVrHKVoIfV+NKxJxZYPgwSed0bAPxkqx2bFKTOj+o7iez/B/ZuPcgImwwhCf
 yy1o33Z0/7NDyZ+ioyuAvB0mJfandzdhk89VWEvS1RAJX3wdfDaZqmFjEIX5nVr17bYO
 f7b7i5kCCtTkkA3jAnaDkScXyQcByJRgJXs1Gk5Aj8/GjFTIYNV9ojgGvIal1WGt2TXG
 NFJz/2UPUIBTz4KpDG2eaiW7d1G1jMuGWpd7WvV0UWteBazVeIYRxPa5dch4KAHZERV1
 vtuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUPRmG8ffIYm/+JGYfCD1AFmDVrl0finsTFn5A91cfOt8+3W7rMKfP7fIJ5LHGySthAaBXq86a8Upt@nongnu.org
X-Gm-Message-State: AOJu0YyMt7P0B4HNlfUO6IKJ2brIwTqtmW0RyNka71l3Nk1IJ51YOJaq
 KJbyMFc8bTYOUdK9YToouaFiLnuKuSJEluUAUmbA67/d/cpF+B8JT4Uod5tRhcyF6OQ=
X-Gm-Gg: ASbGncsL35TfgNInvul6+kkkidxGBRcDTYag8rh8ZcqSlN7fZwYgsADRhgrZ4Jn2Frz
 HP9Vi+KKzu2bbmaU6CUgMx3cVTiVkIBZCqXweTqBi+3F1zatmAUScZ+at8zRnXElFifdpTrmLXp
 /utkUqqSFFmYq1gWveiwvcbdJNsH3LbU2ubAyZ8UHQuVz8B6RYiupgl9tTlWVNJSoSw8Xf1ULbs
 3yzS9g9Hshb3eif6NuZhueg7vxtoptmOswX8jR8EKE5wUGGKnGqePXetmL1A447AKf07VgvNRvS
 N70XW7TvauPGPA+auiioRMAilB8rNVAlWuC9w+57GVSHtYaxK6xIIsrhzPfkOqmotE54SgZxljj
 mdVmhdHWEz8PmRKKUIzGgV5gBfRQxxeaZolssHEcSF0XiCcudsK5TAFbrXNo45yREJrvYqRgS8I
 /tmtv/zeLLKsM3bQf6ayDgauMOm4dmiQEbpY7o3sGYYBtA1DtEZIEE08S9jcDcPuJq
X-Google-Smtp-Source: AGHT+IGbfslHgB8VnGsVA+rLuRAG6iaeKuWiMZC15d3mx0pqWzofq/KU6UjG72pZq5vMcJNu50IU1A==
X-Received: by 2002:a05:600c:3ba8:b0:477:af8d:203a with SMTP id
 5b1f17b1804b1-47904b24076mr91688905e9.27.1764222254957; 
 Wed, 26 Nov 2025 21:44:14 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479052d95absm59529755e9.5.2025.11.26.21.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 21:44:13 -0800 (PST)
Message-ID: <9317b74f-ecf5-4e81-9f5d-a75c926fc144@linaro.org>
Date: Thu, 27 Nov 2025 06:44:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] move pcap structs to header file
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20251126142559.4081483-1-kraxel@redhat.com>
 <20251126142559.4081483-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251126142559.4081483-2-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 26/11/25 15:25, Gerd Hoffmann wrote:
> Allow reusing them elsewhere in qemu.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   include/qemu/pcap.h | 27 +++++++++++++++++++++++++++
>   hw/usb/pcap.c       | 24 +-----------------------
>   2 files changed, 28 insertions(+), 23 deletions(-)
>   create mode 100644 include/qemu/pcap.h
> 
> diff --git a/include/qemu/pcap.h b/include/qemu/pcap.h
> new file mode 100644
> index 000000000000..48e6070ffe04
> --- /dev/null
> +++ b/include/qemu/pcap.h
> @@ -0,0 +1,27 @@
> +#ifndef QEMU_PCAP_H
> +#define QEMU_PCAP_H

Missing SPDX license identifier.

> +
> +#define PCAP_MAGIC                   0xa1b2c3d4
> +#define PCAP_MAJOR                   2
> +#define PCAP_MINOR                   4
> +
> +/* https://wiki.wireshark.org/Development/LibpcapFileFormat */
> +
> +struct pcap_hdr {
> +    uint32_t magic_number;   /* magic number */
> +    uint16_t version_major;  /* major version number */
> +    uint16_t version_minor;  /* minor version number */
> +    int32_t  thiszone;       /* GMT to local correction */
> +    uint32_t sigfigs;        /* accuracy of timestamps */
> +    uint32_t snaplen;        /* max length of captured packets, in octets */
> +    uint32_t network;        /* data link type */
> +};
> +
> +struct pcaprec_hdr {
> +    uint32_t ts_sec;         /* timestamp seconds */
> +    uint32_t ts_usec;        /* timestamp microseconds */
> +    uint32_t incl_len;       /* number of octets of packet saved in file */
> +    uint32_t orig_len;       /* actual length of packet */
> +};

Maybe good opportunity to add QEMU_PACKED?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


