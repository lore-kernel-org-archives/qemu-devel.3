Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD58D2ED0A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vlN-00019b-OV; Wed, 01 Apr 2026 09:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vlL-00019K-M2
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:37:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vlJ-0007nW-VZ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:37:39 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso57882155e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775050656; x=1775655456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wpm6JndvowYjNhrTOkffgDXMoKKTenhrs4ZJEGRUf8Q=;
 b=G219UoxYgfHAjNFH2Bm6CXuHkaSzHUl+m0gxKR8AkJy0bxDH85LTwAMiDQn0NJWQFa
 kEISjtSQWoGLcLfKujLPunEsw0E5Rknit7PteMWPjN00wFUZKhXSnzIv1Ovxqx+a1Ez5
 OOFfcQ0txkb9RTGaHBpidONraGuI1ZKm7uKe7RdDl5wF1XnbgmJLI++wUJZsBfCw0SZF
 VWLgzgZO6NVcm4UzQzbc7106jcI93H5KwPH6+zat16pkM7Bwpvx6lpgor2IgnbRq1Ara
 S9tSNULsVZVaEPZmZcjigfxPBXPz88pXGVHRJF/uX8kD9lJLZLTItCv85R5xp0UORfAE
 K2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775050656; x=1775655456;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wpm6JndvowYjNhrTOkffgDXMoKKTenhrs4ZJEGRUf8Q=;
 b=VbUWMOH+FPbW5ul4UxT0Lk3QYPqJX0dPADadk1dZgWDKfFbxKMweJALKrDuEFpN7R6
 tOF03tI7b3/MhWCsISKF/cpyr6pdBrROq8OkSaixuf94xCzxnY2Dh76GpPU7NITSd4rm
 R6xsPT2P0xao2cprmy/dsguH1IeigkmOrb+Yf5uvXljRHOJ0tritYrCnfq8FmEPFXW5P
 bM3sLub+MigMkZxFJ2zTU9T0CQXTYaGMAIsTqluMVSS1u5EY0vE3D/vc1hP1Kl8cynvy
 i8i7uu9jLHPHQSEscAP9vqhLkGnm06csLGwEoruIT6O8QM8SaQgQNIZjiwDtne6+PXGR
 N6JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw/CIR+nMDvl/qma9DkIviDvZzG0cAaKnsOW5co+otKLliSYnpQN63L3TucilUB33SfaipYeU1BuCL@nongnu.org
X-Gm-Message-State: AOJu0YxCWTfw+tpd9kuj6As/0fofbX/p9J3CjKfXX7T035jqXmss9/EZ
 QcLxirCCeLKmAnyqOLBFN0ztr9iz5gH7E4NHyu6utHjymT6JvUR0ZjAOZxWpSf9ysi4=
X-Gm-Gg: ATEYQzy7QPgCF41RxBUuet/GbRM7Ws+igLCI+Dd433YvFIglq/s2iZ81VH/91auBmmI
 CxmQqBXUB/tPB1XiocUAljC6SKyRb+umPxFX9S+cbkYBelerzTjbaX1FmnMu9wlXWy9+NYI5CH0
 KZoAriXjhUavTYz55V6M10VHSnRENFWnhY7qHfy0EoQe5MGMBxqSTQd3jb5sjHPvENQZBTr6f4H
 vTrOWCKyUE0dtd6gNU1fGlpuX4GzhG051z4t7ejw1XqRlbJn8vwtaEj8DAnVXzGaIhTUSgcFjts
 1SzsDSPIrubSstwEyjaL3GyVPGZV4JjTfAjy1k9wxogyoCOIOwcMNANF6yXPB11DQLCbvUNBqHl
 U/oAD90+H7vEf0zPDig/fLo0QnxScUAS+i01dIWeCq9fJ5ENDwt+07+c9N3OdKeC9Aqwz20F2dD
 hx5kN7XgCOfqmhsCghy0mo72XcZVGEg1pnuKrTvxB26Z+TVWN6gKzUwVyh5AZ70hsdfw==
X-Received: by 2002:a05:600c:1910:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-48883563149mr58499315e9.10.1775050654203; 
 Wed, 01 Apr 2026 06:37:34 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887ad3fb99sm43899445e9.6.2026.04.01.06.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 06:37:33 -0700 (PDT)
Message-ID: <61828ad6-d1ed-46b2-b888-b03ada0ed17d@linaro.org>
Date: Wed, 1 Apr 2026 15:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/60] ui/console-vc: unify the write path
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-26-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-26-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> VT100 escape responses (DSR) used qemu_chr_be_write() to write directly
> to the chardev backend, bypassing the output FIFO, while keyboard input
> went through the FIFO and flush path. This inconsistency could lead to
> out-of-order delivery when both paths are active.
> 
> Introduce qemu_text_console_write() that pushes data into the output
> FIFO and flushes it, and use it for both keyboard input and VT100
> responses. Remove the now-unnecessary vc_respond_str() helper. Rename
> kbd_send_chars() to qemu_text_console_flush() to better reflect its
> purpose.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

