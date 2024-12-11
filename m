Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE36E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 19:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLSR0-0000CE-O3; Wed, 11 Dec 2024 14:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLSQz-0000Bg-0t
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 14:31:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLSQx-00074t-3k
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 14:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733945500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=b4jN8hIxrNCaKxtZGHehGLbpngRMb26EnWEY46/unmM=;
 b=VyzNN7uATCBq7fao+S1esn2tI62Ywo0VzuTwNYfP8vWn0lRTwINqobPwK9uQfPUnxDoBtN
 HsOPwTBXTvC5V3wNjqdeSeUyIKKpiw0spvbFCRIADeda7V+JxEYiQtv1e+aPLt1YbfmcV5
 zUXE1hUlCBrLIlR0/I9snm9hSiOkhfE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-ynTfxu_hOK2J1022vZy9XA-1; Wed, 11 Dec 2024 14:31:39 -0500
X-MC-Unique: ynTfxu_hOK2J1022vZy9XA-1
X-Mimecast-MFC-AGG-ID: ynTfxu_hOK2J1022vZy9XA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385e2579507so3942759f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 11:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733945498; x=1734550298;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b4jN8hIxrNCaKxtZGHehGLbpngRMb26EnWEY46/unmM=;
 b=qHf6yXPMvjJ8QMo6xqLodXilRDJ/RNdW2+keoU77s4p93lKC+4q5CblEbqkcA+4HPb
 InyWc2O31TfZvRun/U1ghcLiBcEIKvf2YVQZ1Qc14TV9XhjlbFvn1zLT7m6a0+A/BeSE
 DE6mxmLF1LzjqR1ujV4BuRHoasyQVgh8uqKR44467OV3dGz2ToO+1SZ11KBn/U71bQkU
 oU578ZESjTJmm8A+qJOidyPyzSgvvbAIhvFbWm0oNGkQFNVoBuYg3IHn2FSWu9n/bb7O
 AlNHchZoB1M9K9ibALE/1ie9OcmqN3EbuwrwQ0PLI+58iXwjk3AMtZcsTDH0WQO+Ntqy
 zlEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAxvxuA+4mkg5oG2PSS9gjXFsDtemqeFldWDg2z23WramX7leQ/ZqLeXuuhnrta4ENYPOi9ehafCze@nongnu.org
X-Gm-Message-State: AOJu0Yy5rgSTib99BKHo70qcGs7aLKM6Tmi6+2eeWcSEnmTCkD9XVnmY
 QctQla3ivyDavwKvSF3PiItHREVteMdNTmUKPTAVmHgEEQYaMXwklETqdNFDAsS7y5W95l2SyoE
 J3M+64Vi8zjIkXRepoEDV1pnELn1sgEhHgyWffmwLDJrx0gogPwP6
X-Gm-Gg: ASbGncv/MUPuBZWVRXe7MZ9HCxlEtFlkv/Q+dvmwlw5+62f7fUKTaHneARM5+oG7lez
 AHW/onLe72YigxS4gXUQD8vhKhVMjM0w8LCTyFLyaaFtsu3quBOF+OWq/vprDD4JmYZoE+lB0qh
 9HwSix8HVH22xJ7gSctmATqHVgW5xeYT4Uf84H7Z1oIyTj58IYXbvYjwku9z8YT5OeoXoeH2aPV
 FdM2xjamwYyAyV9eJEuzQiucPF18A+iZvTEREyzqEK+qbLixxtJTvuEin/K0N0R6mFuNKismvv9
 QZ86BNY=
X-Received: by 2002:a05:6000:70b:b0:385:e170:d5b8 with SMTP id
 ffacd0b85a97d-387876af36amr621557f8f.42.1733945497996; 
 Wed, 11 Dec 2024 11:31:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETMzmKL3Z7OQYVOZ5Dcr893cKuA05AA1DXYaSlvWMK5LZ52gVIckWcwYNJshLIaGLn3u0jEA==
X-Received: by 2002:a05:6000:70b:b0:385:e170:d5b8 with SMTP id
 ffacd0b85a97d-387876af36amr621539f8f.42.1733945497630; 
 Wed, 11 Dec 2024 11:31:37 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436199f6896sm45238395e9.14.2024.12.11.11.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 11:31:37 -0800 (PST)
Message-ID: <58575b88-15ae-4bea-a191-8ec6dc579162@redhat.com>
Date: Wed, 11 Dec 2024 20:31:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/31] tests/functional: remove many unused imports
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241211172648.2893097-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> Identified using 'pylint --disable=all --enable=W0611'
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py              | 1 -
>   tests/functional/qemu_test/tesseract.py          | 1 -
>   tests/functional/qemu_test/tuxruntest.py         | 3 +--
>   tests/functional/test_aarch64_aspeed.py          | 1 -
>   tests/functional/test_aarch64_sbsaref_alpine.py  | 1 -
>   tests/functional/test_aarch64_sbsaref_freebsd.py | 1 -
>   tests/functional/test_acpi_bits.py               | 2 --
>   tests/functional/test_arm_aspeed.py              | 1 -
>   tests/functional/test_arm_bpim2u.py              | 2 +-
>   tests/functional/test_arm_collie.py              | 2 +-
>   tests/functional/test_arm_cubieboard.py          | 1 -
>   tests/functional/test_arm_orangepi.py            | 2 +-
>   tests/functional/test_arm_smdkc210.py            | 3 +--
>   tests/functional/test_arm_sx1.py                 | 2 +-
>   tests/functional/test_microblaze_s3adsp1800.py   | 1 -
>   tests/functional/test_ppc_amiga.py               | 2 +-
>   tests/functional/test_virtio_gpu.py              | 1 -
>   tests/lcitool/libvirt-ci                         | 2 +-
>   18 files changed, 8 insertions(+), 21 deletions(-)
...
> diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> index 9ad3f70bde..0f11966131 160000
> --- a/tests/lcitool/libvirt-ci
> +++ b/tests/lcitool/libvirt-ci
> @@ -1 +1 @@
> -Subproject commit 9ad3f70bde9865d5ad18f36d256d472e72b5cbf3
> +Subproject commit 0f119661317333038e91b6fb9d0381a6934dcd0c

That one seems unintentional?

  Thomas


