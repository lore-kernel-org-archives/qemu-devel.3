Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3530BCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVx7-00063B-TZ; Mon, 24 Nov 2025 07:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVtJ-0002dX-9L
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:42:04 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVtF-00084R-AU
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:41:59 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so26670845e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763988112; x=1764592912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zf90rc5mivwSDjSLztZSrMw0UJxM/sRqkZXzQnucTwk=;
 b=sTXJbCbfL687bEAgEQT8Ls5of5c91VyVg7AUM+ewc0nkaMKw8bwyj2bH9xTOMcv83k
 HAE4YPA02G7zncfnP0X1m5txh7e17iBhT31nKRW4HivuN/VXEHXcW+YykgbvGOrE37Ng
 PpeLEmRtv+mujz4m/MLk5i7ffR25Sj6uIrOLBdz5nD/u6ax6jcjuEufixRl6kbBIrQwy
 mqgqBVi09xHM9ZMQrxJ537j9Ru19jgxsserMxI1FMyVusHIJWh7CV2M2/1N2s+fxNi0d
 OnrjYs82KyO/Qw5SA1jkVLqME7OcZUrxTNXgPNO/8UlpnNOh9jLjXBA42rSD8FYEPs1J
 d2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763988112; x=1764592912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zf90rc5mivwSDjSLztZSrMw0UJxM/sRqkZXzQnucTwk=;
 b=r0QwTVY9NBNTPPomgeKl+AO7IRf6yofOkSgbl5Mfh7td29I3KvwahI3cywI+xklHt/
 STMmlMbm7rP5DTUIDBA8HDLPbMp40woDGIb7iMx9uhzISbH3aoY8VSJVfhB0gNH39tKZ
 iNifgGlMtbEI2LZ+816H4CM5I+HEGl8Tv1bhhExeHOOl088hvPJai8v3j3f1dmQ7No0v
 DWZ4QsNUGrMdZJh2utg22V/7Pufp3N98XmIvPhbfp+0cmkrkD8RtHCrNMgneZ+PnTYns
 eYBwtDVCtOsiQotjIBLUvtSlpnxg72uBooWvP0W7ZOzibRJMLt9QRxxZsTdAYALK2OTv
 GvqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuOdgx/RdS+UIJORXPHQBSgz46Cf2pJoFbx+x4ekCVnhhw5LExebWdaLoRyRABAGfIjQyUU6HcJv+E@nongnu.org
X-Gm-Message-State: AOJu0YyOrb0fvAvcuoMHIxocw8IOnQck7N+k9DpQNB4zTzBqHyZgwo1o
 qO5qwbKEp5zc8cKM88cbLDTuOLbI/6TyNXecAcOy51OC+eyjuxbNHq1KIjJ17nK/Hhg=
X-Gm-Gg: ASbGncuIXS0yDlK60+hWrV2Mlmpmi7qOKiWZPbjad08KhGPv4DTx+23v+Knm/JT018R
 myYqbc2sT0hbSjDfMY+NhRwiLfBAP23H1DQiXZF2RMw92RX2pKpG5ghAxZUm9KinD7lcZ7jyYhq
 NEL045pQGoaOxMGoOh4ZbjWXs2/FlE0KNFzEHLjSnq9BzT1lZiFk63GnHnGDqPk34q2gtcqF/NA
 mBjZXRU6OGSKaq/VsvPejwrCBe9HagV0BqIo7leGViOwHZPCQaVsLWRDvp677ox7Alq5qu2ZUbW
 1Lw7qr9fuAS7cP/x69F/Kach/eIAwwKQT9y9QJtUzdA3HFD2WmzoT7v3tvOBXbTaK5IbE7hLfDq
 C++ZWhVRTJ0/oucqA4fiAqhfuINA4ECFXWfqkzsizOsbCXPozJLSl08EEKjgo+g/VpTucCSJ5YV
 gfNImWLk6TnrFi+2Oalh8f2tDtBV/x79OPE9i6jJPVK5hBn2wlMAOxsSrtlg8=
X-Google-Smtp-Source: AGHT+IEOO0hPWjLNp7SJAc7+eLaPEC5cQkBYp/A9KvWjjPEf5Qfu10Is/dVFBwMqsHbMgH7lr6TNwQ==
X-Received: by 2002:a05:600c:45cf:b0:471:1716:11c4 with SMTP id
 5b1f17b1804b1-477c01ebc94mr116800765e9.34.1763988112570; 
 Mon, 24 Nov 2025 04:41:52 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf198a67sm204393845e9.0.2025.11.24.04.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 04:41:51 -0800 (PST)
Message-ID: <0cd6c984-f90a-4cd7-adfc-add9bf0de619@linaro.org>
Date: Mon, 24 Nov 2025 13:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add support for zboot images compressed with zstd
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Paul Burton
 <paulburton@kernel.org>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20251124123521.1058183-1-daan.j.demeyer@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251124123521.1058183-1-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 24/11/25 13:35, Daan De Meyer wrote:
> Fedora arm64 has an EFI_ZBOOT kernel image compressed
> with zstd. Let's make sure we can use it for direct kernel
> boot with qemu.
> 
> Daan De Meyer (4):
>    Rename LOAD_IMAGE_MAX_GUNZIP_BYTES to
>      LOAD_IMAGE_MAX_DECOMPRESSED_BYTES
>    Rename UBOOT_MAX_GUNZIP_BYTES to UBOOT_MAX_DECOMPRESSED_BYTES
>    Use g_autofree in unpack_efi_zboot_image()
>    Add support for zboot images compressed with zstd

Thanks, queued for 11.0.

