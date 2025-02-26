Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E246C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 07:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnBTO-0006vX-4e; Wed, 26 Feb 2025 02:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnBTK-0006qq-A7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:04:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnBTH-0006kg-Nv
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740553482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4lLv76qtCHDb1sEcD34lVJ41Yg8wDCAR/UTLOyYsabY=;
 b=W8uz3k6wFkOiNEFTXCWpagjEiqHv4PrE/8ji9ATxQ6bjp27WK4eMcP0WTwsBqONJjxTd2N
 hVhhvUw2vRB5HZg3kyz5sSOrDhbQgqfNJXw/fkKS+02SvuaeZrw4JwZ0uZtay6QFiYpQSI
 KXkUuQcFwIu+8wYEcFFxxrWTQNbIdAU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-xt-gknasO4G_jqDJ6_3cnA-1; Wed, 26 Feb 2025 02:04:39 -0500
X-MC-Unique: xt-gknasO4G_jqDJ6_3cnA-1
X-Mimecast-MFC-AGG-ID: xt-gknasO4G_jqDJ6_3cnA_1740553478
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f28a4647eso2706323f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740553478; x=1741158278;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4lLv76qtCHDb1sEcD34lVJ41Yg8wDCAR/UTLOyYsabY=;
 b=RnZFKCXCdrlbt+M9DbKVO9Mgn1bC/PsYU6B+FMVGm1oMtvJaTIp4WnzP+IMOTjEeQ9
 tLbz/Uku2ONND3Z+rElXTIvVRy/YuBA0w+U8cwBat1AYPMEbVOHvxcuWGwE7kDbTTvAC
 cIoEq6cIZAaFN5qzIEZsDWQfSm86jObxYHBtj7+90SMnREGAMOhg+TsCmZE1q7XLs0pR
 iolq9osox9ufnc5tmenZdfHgKeJuHs4LTFaOyPGku4JhlX2r9Gqwv5q4T4bdH/KBtVYg
 ogzpcfhMLQiCT+LLxYw8iG9J/AHcwYJF5dkY1XRh8wxfFCVEl5CWFng69KAvg7AUtSAE
 i5OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWonvrlpam6GsmkNCtwNgccXvgUnDfqBnI0KiY60NB9Wp1AXJWJa/up0F1byzQN3aqlE2ywrl1H9kAc@nongnu.org
X-Gm-Message-State: AOJu0YwCGxCvoufqukkK09b42bTcavklXA67NoJp2RdB4CmfXmBh+cqN
 WuDloYudHs2S4afM5FoHCig9pJaYkz3iFJg/aKJukOrlJdiRD9xYMTW6kvJ+aCLneBL/ygTBAKR
 f80S4YS7IZB0BP9B3OQWNxc80po002gx75AVy8mhz2wgpHypC+HVPcswIiVAq
X-Gm-Gg: ASbGncv3UvlkaEZOZ6rW7wyOD6xgAZ3NSsG/PEA1QI6I6jKRnH/iogHHCVx9EylhBki
 7pwRzeASbHu6P6vX3E2twyDNx3U4sR0SMYI1Vwq11ZnkngpftxID6aqqWUkqXWLhwWyunOLHNO6
 sxySkslnh+XkZjJmcTbXZtHfDZ/qZIvu00qJRkShJ1rfedKbSJLDOFPja1T8CBt+pXtsWa+ZNoe
 cRjebpgdtrktpMrl4sw7aG6eeLQDLtd/Y65m9WbwCFoKVoSYkN9hsQDf0dXFGyANxBpcpkquH4H
 graz+FHGCszSmCNznqCTFguTSR0X0lrKglvBrxzurLg4KZU=
X-Received: by 2002:a05:6000:4027:b0:38f:4b2c:2475 with SMTP id
 ffacd0b85a97d-390cc602f0cmr4678451f8f.20.1740553478344; 
 Tue, 25 Feb 2025 23:04:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQdfA+RFNCUaFigecEDBXXDoFZpkS8ggSpIq51Z7cOKua/olP+hXMGwR2UMlk3K69tpVIyCg==
X-Received: by 2002:a05:6000:4027:b0:38f:4b2c:2475 with SMTP id
 ffacd0b85a97d-390cc602f0cmr4678432f8f.20.1740553477999; 
 Tue, 25 Feb 2025 23:04:37 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8e70c8sm4492344f8f.76.2025.02.25.23.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 23:04:37 -0800 (PST)
Message-ID: <5bfbf2f3-584b-4f46-9568-a48afc1e84f5@redhat.com>
Date: Wed, 26 Feb 2025 08:04:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Replace the ppc64 e500 advent calendar
 test
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
References: <20250226065013.196052-1-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250226065013.196052-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 26/02/2025 07.50, Cédric Le Goater wrote:
> Replace the advent calendar test with a buildroot image built with
> qemu_ppc64_e5500_defconfig.

When picking this up, I'll add a "Unlike the advent calendar image, this 
newer buildroot image supports networking, too, so we can check whether it 
gets assigned with an IP address" as justification for the replacement, ok?

> Boot a ppce500 machine from kernel and
> disk, test network and poweroff. Add '-no-shutdown' to the command
> line to avoid exiting from QEMU as it seems to bother the functional
> framework.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>


> ---
>   tests/functional/test_ppc64_e500.py | 33 +++++++++++++++++++++++------
>   1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/test_ppc64_e500.py
> index b92fe0b0e75e..9ce7ae6c4798 100755
> --- a/tests/functional/test_ppc64_e500.py
> +++ b/tests/functional/test_ppc64_e500.py
> @@ -5,20 +5,39 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
>   from qemu_test import LinuxKernelTest, Asset
> +from qemu_test import exec_command_and_wait_for_pattern
>   
>   
>   class E500Test(LinuxKernelTest):
>   
> -    ASSET_DAY19 = Asset(
> -        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day19.tar.xz',
> -        '20b1bb5a8488c664defbb5d283addc91a05335a936c63b3f5ff7eee74b725755')
> +    ASSET_BR2_E5500_UIMAGE = Asset(
> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc64_e5500-2023.11-8-gdcd9f0f6eb-20240104/uImage',
> +        '2478187c455d6cca3984e9dfde9c635d824ea16236b85fd6b4809f744706deda')
>   
> -    def test_ppc64_e500(self):
> +    ASSET_BR2_E5500_ROOTFS = Asset(
> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main//buildroot/qemu_ppc64_e5500-2023.11-8-gdcd9f0f6eb-20240104/rootfs.ext2',
> +        '9035ef97237c84c7522baaff17d25cdfca4bb7a053d5e296e902919473423d76')
> +
> +    def test_ppc64_e500_buildroot(self):
>           self.set_machine('ppce500')
>           self.cpu = 'e5500'
> -        self.archive_extract(self.ASSET_DAY19)
> -        self.launch_kernel(self.scratch_file('day19', 'uImage'),
> -                           wait_for='QEMU advent calendar')
> +
> +        uimage_path = self.ASSET_BR2_E5500_UIMAGE.fetch()
> +        rootfs_path = self.ASSET_BR2_E5500_ROOTFS.fetch()
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', uimage_path,
> +                         '-append', 'root=/dev/vda',
> +                         '-drive', f'file={rootfs_path},if=virtio,format=raw',
> +                         '-snapshot', '-no-shutdown')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('Linux version')
> +        self.wait_for_console_pattern('/init as init process')
> +        self.wait_for_console_pattern('lease of 10.0.2.15')
> +        self.wait_for_console_pattern('buildroot login:')
> +        exec_command_and_wait_for_pattern(self, 'root', '#')
> +        exec_command_and_wait_for_pattern(self, 'poweroff', 'Power down')
>   
>   if __name__ == '__main__':
>       LinuxKernelTest.main()


