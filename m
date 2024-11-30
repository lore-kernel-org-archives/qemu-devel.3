Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E84DD735FF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 10:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHKm2-0008Fw-Hu; Sat, 30 Nov 2024 05:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tHKm0-0008Fn-VN
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 05:32:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tHKls-0003XU-Rv
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 05:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732962735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BuScY0i44dwMhBJDwp697o2jc2BBxoMz2hYfn8Y2Fmo=;
 b=eXWwiTboWwbThRtZIOiC6GTkCgSAKmfQ+u4+hSZVXTWHm6TFcpCA7Fm0BbwDIslj+a26G9
 4+KCpQBilBxvCsjDCmhBF7ec1n3hpmtyh4+grk5FCPn78gKtO72zMmmQ7AtzcyNbXg4Lcm
 UTeTlnrj1eYVr1wmEroa45UrOt05+uY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-cq7QGIzbORGzA5tA4cZ93Q-1; Sat, 30 Nov 2024 05:32:11 -0500
X-MC-Unique: cq7QGIzbORGzA5tA4cZ93Q-1
X-Mimecast-MFC-AGG-ID: cq7QGIzbORGzA5tA4cZ93Q
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5cffa805c94so1811576a12.1
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2024 02:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732962730; x=1733567530;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuScY0i44dwMhBJDwp697o2jc2BBxoMz2hYfn8Y2Fmo=;
 b=QJO/DbHUQbOe9Trq/ixKUptNVnf7gBYZUln4HJENjsKasDqnnMnHpapLG4CTB20fXA
 1XhK1u0QbV0yqdNMuo5cnKWojEt0/HTLIk4bWMyERTP1XplHAq0WTIsSQ+ZFzdcWqSV6
 pSaJ0aZyGKxXaNgJaM32E1+kMQg6xfnALq2xfokkbJe4PcgCoVKKrNucrREMBRBsB/k7
 /4s3ZP8cmDW7rXdrrxuwgHc981JHEgriuf7GJxHaIQcj0R08ULETYzbJV0OkCHfQWWCo
 ZZWFib1BDjsxsDu7/mg1jgycm1jKc4EFLW6rLDraF/lCYVp2U2Zeo6ixDy6Aw7ru5Xwz
 KErg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQEOFfOYQyIAAC3eMMdzHK/bPpJL/fDB+1x1/mvIxKXfSyf3uZdxtHZZS3FSPlAIsbg+uoz4/P6yWh@nongnu.org
X-Gm-Message-State: AOJu0YzEkDM+1L9VRWmDfybID9BO6r1a/bM0iSqVFvN1V6w14Mu8CfvH
 bgZrctD16fpygcD2OSy0D8R8d0QjXD9MvD3mIXoEhSVVGfhXS3VhoMLATrCMy8+yzNvYPRxii4S
 picutkBoIMOKg3FhLzjLbYcJCL8Wl4SurOZE2iSIBQzoEMcHUfMK9
X-Gm-Gg: ASbGnctaqQQtPBkmBm/2PWrIxsHlBgxjbwWiXX5a761V6oDzjGz4ArvrmKfoXl0eY3t
 qR6Y2Ka8Mysg3uu6x+GcBKPuEITxc/08XLN82IhoD9j8hK3BnaFfTmk1IFqoXYUlSuiyPF8d1JG
 5m10npF1jTCgFjs1EBJN6wBV0bH9122X6OBm/fAcaN0NL34jjOhkUkWhhc6Rbgmq+U7ZK2tMD3s
 A3EsodaOg3J5mKmvyhvG69w1bAHhpsJWQoei0ZgJF7NQwtC0ox5AY3hM8G2eA+yigcO1grhi3cL
 QyblBA==
X-Received: by 2002:a05:6402:3891:b0:5d0:96db:da4d with SMTP id
 4fb4d7f45d1cf-5d096dbdad8mr11042204a12.18.1732962730677; 
 Sat, 30 Nov 2024 02:32:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvtR8vBwhqtEdQO/drjAJazwNUL6qI8SNjCke3T+zp2tkABB/hmo67zMb8DzPrSDVuGCZ7lw==
X-Received: by 2002:a05:6402:3891:b0:5d0:96db:da4d with SMTP id
 4fb4d7f45d1cf-5d096dbdad8mr11042192a12.18.1732962730307; 
 Sat, 30 Nov 2024 02:32:10 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-143.web.vodafone.de.
 [109.42.48.143]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d097eb9bbcsm2662565a12.79.2024.11.30.02.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2024 02:32:09 -0800 (PST)
Message-ID: <71168aed-9952-4dfe-afbb-be28bc2f6501@redhat.com>
Date: Sat, 30 Nov 2024 11:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] tests/functional: remove redundant 'rmtree' call
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-15-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> Everything in the scratch directory is automatically purged. Calling
> 'rmtree' again breaks the ability to optionally preserve the scratch
> directory contents.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/test_sh4eb_r2d.py | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/tests/functional/test_sh4eb_r2d.py b/tests/functional/test_sh4eb_r2d.py
> index dd2500dc33..38ee55cf4c 100755
> --- a/tests/functional/test_sh4eb_r2d.py
> +++ b/tests/functional/test_sh4eb_r2d.py
> @@ -4,8 +4,6 @@
>   #
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
> -import shutil
> -
>   from qemu_test import (LinuxKernelTest, Asset,
>                          exec_command_and_wait_for_pattern)
>   from qemu_test.utils import archive_extract
> @@ -25,7 +23,6 @@ def test_sh4eb_r2d(self):
>                              initrd=self.scratch_file('sh4eb', 'initramfs.cpio.gz'),
>                              console_index=1, wait_for='Type exit when done')
>           exec_command_and_wait_for_pattern(self, 'exit', 'Restarting system')
> -        shutil.rmtree(self.scratch_file('sh4eb'))

Reviewed-by: Thomas Huth <thuth@redhat.com>


