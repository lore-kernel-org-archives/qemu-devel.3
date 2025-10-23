Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE40CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwQw-0002bn-C3; Thu, 23 Oct 2025 10:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwQf-0002Vi-Ls
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:36:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwQd-0002fp-VL
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:36:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so7622405e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761230194; x=1761834994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c+ThxEWVQxXshxqXktgAOdE159T4weVKPrTjmJTbNVU=;
 b=cG8/e9Cq4uLAHw4A0HbOymcNWdvY20VHdFgqAEomIM/Hhg4nRdqlf7OolwFxyjgQB3
 XS/b9BZm+B2foGr7VyOSfnbQYkdbPp+e/zvbhtTg170E2GinrwVf3U8oTtjgWCu7/xq0
 ajCUg/YVYfFNXh2sUl/y3psfg1oAS9uIG/g9wVoGdmPNwI4focai2QwTyaYYexIKzWJb
 P0kh05tgnXXNiE8jJifJ4ou6Sfhl5zAM9BnphnC25BNa00DhLv6za9FWGG4NxWDw4QBj
 Em37KJL4FpkN0r7viICRi300oT17WkibSdMgC/PiUHh2v1jy/gFYmLkylbdB+bJYPg18
 35ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761230194; x=1761834994;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c+ThxEWVQxXshxqXktgAOdE159T4weVKPrTjmJTbNVU=;
 b=a5HAh1PI86mAOnEjW7ptR9EvlV2fMfpoPwCu7b4APQMvlhVzOU9ycQNMJ/N6X1yfut
 YWUIpM8P55TJUewAN8zI880mPZNsZJExTmQYyzjdkZcSOxGN1w5UBvgrrd8HWksCUwpB
 8+pGq+2s5tDT3x3sKA6U8t6UiBI4dkqUa2KrRhlOXRKegs3XgstE5ihkzAzzygU1fBJ5
 uoS0bfR5oAcn4Z6Bpk8d3q1bB6TllIya3hECteze2X3FhaBhP1eJqKFAjOwT9QUnL2lE
 oev+dxMrku+5FqjRZqXf5Olmvjs+RvKT+KfB54l51X70Jd8QKAFTrdTfjYpRCsCHO9sy
 KZbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnALpZdekoWroAF4QNGrPs5F7xljJYHpVdz/ndPBIaF3cUrKQKGNIS8EARlHURh2bzxghBnfA2TkvQ@nongnu.org
X-Gm-Message-State: AOJu0YwgUCnn7zM93x7VUdo80JwfW6WQdaONI00/qXeOLY14PVf3550v
 GCa8hewpSuG4b9KE+kiK30EZFEQFZ3eis9VbrreH6uU+qt2H3h+S82S/IlvfmoCN+/I=
X-Gm-Gg: ASbGncuoMcXiB5SvS/yua6cJ2sq9qoEHrAp3tpXD4XW3wuy5cTI+mTzAKu6qRbeMwwV
 WIeVYb3RYc4LjbvRd1brJfY8X8eteciTFSUIcj3BpgJfTzpP4Nt08XcUiNIY33MEn/G7ma+rZ2h
 y/K9fCYMEPyd03YPRfhS7a0r2YElMMngrVeBRA7kPXZWH9kDzd5T4nHmf/l+kOEnZpKLKDxe7us
 bBiBK6HE3T0CEAGv2xl/xa2gRtPEs1dtfMPD5K8/1KTFPG5JtAb9bXmF/9Sbgdc8b9srZEQXPlk
 a0Cj1zVx1VR65iw4KsBufShu5qFAeEZxWoe68P+AaoSKIOVAQfWSiZHZvUvQxbSUEjpgczaDJ8W
 f/OKLTKQY6qruPaxR+QjDzutm6utvMkhtbDKTAnWBJrzr7W13ZJr+IkelMZSVoG/A+bL8owoBdr
 6+94+cZssIKX+R3VwPuUpxRQ1YispyeGd1uS8IArj9Ifc=
X-Google-Smtp-Source: AGHT+IGnVq+Eh7IMDGf93RkkUKHcAzokWuI1lz6BXAvirp33kuvtAn/gcYi5lYmfkNQWKJQoax2yaw==
X-Received: by 2002:a05:600c:3492:b0:46e:3193:fecb with SMTP id
 5b1f17b1804b1-471179193c3mr168961225e9.27.1761230194450; 
 Thu, 23 Oct 2025 07:36:34 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47494b365adsm62172975e9.6.2025.10.23.07.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 07:36:33 -0700 (PDT)
Message-ID: <e6df234c-6229-45e6-9aea-e03d9eb6d023@linaro.org>
Date: Thu, 23 Oct 2025 16:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs/about/deprecated.rst: document isapc deprecation
 for modern x86 CPU models
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, imammedo@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org
References: <20251023142926.964718-1-mark.caveayland@nutanix.com>
 <20251023142926.964718-3-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023142926.964718-3-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 23/10/25 16:28, Mark Cave-Ayland wrote:
> Add a new paragraph in the "Backwards compatibility" section documenting that
> using modern x86 CPU models with the isapc machine is deprecated, and will be
> rejected in a future release.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   docs/about/deprecated.rst | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


