Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C3CC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 12:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1EO-0005DK-5t; Thu, 06 Feb 2025 07:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tg1EM-0005D7-Qx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 07:43:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tg1EK-0007EJ-Us
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 07:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738845820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y/OwopBBNyKJ/kQy5IFaaN55alWlxzu1qw9/wgFVZq0=;
 b=RpcywkeoPXd72svPz2Pil5CzIJd2xXFBft7sXLhHB6lyXbLcNbqIvJpEvCFqEV0Qw4Ak7p
 Yso29WHg223Of1wq23+FYGeiFY3MvJkglUPU88c8464xNibh9AqsIYDIQIREik4n/wJg95
 Ub7h4s/lB2SL0Zdj5Zpj5lPEqzaw/Ek=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-i87fecFNMPqV8xeQeiH-eQ-1; Thu, 06 Feb 2025 07:43:36 -0500
X-MC-Unique: i87fecFNMPqV8xeQeiH-eQ-1
X-Mimecast-MFC-AGG-ID: i87fecFNMPqV8xeQeiH-eQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43624b08181so4702805e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 04:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845815; x=1739450615;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/OwopBBNyKJ/kQy5IFaaN55alWlxzu1qw9/wgFVZq0=;
 b=s5cfmW1Y+auMPCaYLVLSP4uYxIaiixu4qMT5AHUhUFjjFQoenkPEiA+FfZjIPg29Ea
 udQVz/plrpOza2SnDs1wZ1hPxRdE306VhD1NvAC9DbUhBoz6sT1TnBag2/IVq8qpC0O6
 AejVj/mCMWvrxj2pR+oOK2CEest3308D4+HKmu1v4hX1VRntXeDl/7Eqh7MpbVDPopAw
 3v+QDGaC4m25t24GUB60Qc3iFc2TRRxtCC7PrPK9U1WUky5RcB7hXtIsuLAk5Edok4dI
 BNn/v3n+kGWGukMaVy4hrZgntSz7Dyi75ndWPzBijBkvJ11bGrJ/1Ypx/BDmgzWvYyOc
 JkwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkREb/z7QHZChmqgYH5LkTYQwP1TrfZpzbP4S3ZdXIUBbhndLTn1bglG6rvWVDO3d/oOE4SmLbxqS7@nongnu.org
X-Gm-Message-State: AOJu0YywUb6xOhurpYlM7DgPjraSIuaKiAnohHvxBAEIaTuo4tYjDmGU
 fp9YMx5/5stC4a8SWcGTWR3visb+znzEtfhX3i1D29AH/PBgsNnQ94b1eAchRuixdqFb6n5X6X9
 bIopN3AEEHLZUr0/cbgibvfvDjHSbTQ8N9SiWcUharXJs8BmOa/99
X-Gm-Gg: ASbGnctDgkz+SaU4gsEfm2GB7lIZ5WUEeF91d4G8HUCmRd9f1YuQFpvPLs/86aSgNQk
 HDPMOIC8/fG0aeLjIG1Rdswjt5pPbdySOmmZghzeVElNXJ4ZQZKW+mrhbESq9EVF+Izzf+cXM49
 yjSz83gWxW/Co8b8Yq8QRlsd/8aUbkiXqJOZ/W7OtUbk3EaL0jm6ogGBARhdAsLgJ4sowqW3FjO
 8Uj1HcGWPx7M1LUGwPZ7SStiIYPGtQPDnpX+aiesP0TiFWvnoJBQqr5Wr8eA4Ps6qjltfH0tllj
 BshSxhK2DBkh7GGDC3M0CHOzkTgfCavJf/8r
X-Received: by 2002:a05:600c:5249:b0:434:fddf:5c06 with SMTP id
 5b1f17b1804b1-43912d10a71mr24340575e9.1.1738845815473; 
 Thu, 06 Feb 2025 04:43:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnIzIguPv5oZ22QuL7Fb0AAR2mn4hjAUdal3lXLjVWWK5Vixk+ajIo667aZtuGaJRoGS3Bmw==
X-Received: by 2002:a05:600c:5249:b0:434:fddf:5c06 with SMTP id
 5b1f17b1804b1-43912d10a71mr24340415e9.1.1738845815045; 
 Thu, 06 Feb 2025 04:43:35 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd35bd6sm1622359f8f.22.2025.02.06.04.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 04:43:34 -0800 (PST)
Message-ID: <b01c179e-e68b-4035-85d0-db1630a9ef1a@redhat.com>
Date: Thu, 6 Feb 2025 13:43:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/16] tests/functional: Move microblaze tests to
 common parent class
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250206113321.94906-1-philmd@linaro.org>
 <20250206113321.94906-16-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250206113321.94906-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 06/02/2025 12.33, Philippe Mathieu-Daudé wrote:
> Move the xmaton and ballerina tests to the parent class.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   .../functional/test_microblaze_s3adsp1800.py  | 27 +++++++++++++++++--
>   .../test_microblazeel_s3adsp1800.py           | 26 +-----------------
>   2 files changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
> index 2eff31f13a7..0447097c048 100755
> --- a/tests/functional/test_microblaze_s3adsp1800.py
> +++ b/tests/functional/test_microblaze_s3adsp1800.py
> @@ -7,6 +7,8 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later. See the COPYING file in the top-level directory.
>   
> +import time
> +from qemu_test import exec_command, exec_command_and_wait_for_pattern
>   from qemu_test import QemuSystemTest, Asset
>   from qemu_test import wait_for_console_pattern
>   
> @@ -15,13 +17,15 @@ class MicroblazeMachine(QemuSystemTest):
>   
>       timeout = 90
>   
> -class MicroblazeBigEndianMachine(MicroblazeMachine):
> -
>       ASSET_IMAGE_BE = Asset(
>           ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
>            'day17.tar.xz'),
>           '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
>   
> +    ASSET_IMAGE_LE = Asset(
> +        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
> +        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
> +
>       def do_ballerina_be_test(self, machine):
>           self.set_machine(machine)
>           self.archive_extract(self.ASSET_IMAGE_BE)
> @@ -36,6 +40,25 @@ def do_ballerina_be_test(self, machine):
>           # message, that's why we don't test for a later string here. This
>           # needs some investigation by a microblaze wizard one day...
>   
> +    def do_xmaton_le_test(self, machine):
> +        self.require_netdev('user')
> +        self.set_machine(machine)
> +        self.archive_extract(self.ASSET_IMAGE_LE)
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
> +        tftproot = self.scratch_file('day13')
> +        self.vm.add_args('-nic', f'user,tftp={tftproot}')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
> +        time.sleep(0.1)
> +        exec_command(self, 'root')
> +        time.sleep(0.1)

Not related to your patch, but we should try to remember to also rework this 
code to run without the sleeps here - it should now be possible since we 
reworked the console code to also work with partial lines.

For this patch here:
Reviewed-by: Thomas Huth <thuth@redhat.com>


