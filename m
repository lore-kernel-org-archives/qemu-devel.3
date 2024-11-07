Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A64D5AE6E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 07:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8wkF-0007pD-TU; Thu, 07 Nov 2024 02:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t8wkD-0007oN-Sm
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 02:15:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t8wkB-0001Cn-5H
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 02:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730963749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=muVvUflshFw9HCU+uBiIHAkL4hmzm/ox7npunST/FE8=;
 b=XSvbB5REErpQk2N2AAWX90oYr9N/JsmcbQw6o+tZpxtALpAvfomkVmBw/qmDmtLQJxwfcR
 t61VFq9i/w+x5bEHv9JODxj4wMnAExq+vK34rZ+Mb2QTCRbD4/nrCx1A4bf1Bj2lStoL8m
 qqHl3TSkNWDU1B8kWx63yFLpvc65WZY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-XOF7LkShM7m8Z84-j0Gulw-1; Thu, 07 Nov 2024 02:15:45 -0500
X-MC-Unique: XOF7LkShM7m8Z84-j0Gulw-1
X-Mimecast-MFC-AGG-ID: XOF7LkShM7m8Z84-j0Gulw
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-718058978bdso800304a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 23:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730963744; x=1731568544;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muVvUflshFw9HCU+uBiIHAkL4hmzm/ox7npunST/FE8=;
 b=vaQBIMrSrlOjjxBbFxhsRFQhmwOvphx6re27WIMF5z0KnqQe5htDQ/igFkvu+H3NF6
 QuMHmxUJ+NHdNyu8EIIaBzA4msrHUBfsQ/8b8/o9uDAEECWkCNdwrQBWhiBfB4jMEdbq
 CiUT1VYIjjt+lBI4kLT8s5Fk3Hp13knYtR5evk85XSrswS5Rg6cTTRY9BSxP4D51Ask3
 dmXR5WaUHpIbWXZ1ViHxeq3TQM2JB1dPwm5o5SyL2wgQ7IMVLmjH8FyHTeoCZXhREYJ/
 KIAW1LuKW2aFxr8Wzgl8brtEGIbA5b+79Hq4+A6C5eNtCPBbs4cVVH2+y8fYy8sT2/V9
 5RbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvvyfPWU/bm1XUjS5n8dFE7Pjk3cgN29yYdiBw9e5G47xL/aCwpAGzXC2TkDuEQXx0RwdYqW7qD28C@nongnu.org
X-Gm-Message-State: AOJu0Yz9iwvB6A1owPgl/lAACojplu76KQlfep9sEF2wvbhvW1Uk29A3
 93QBSLuY4GF1yD4F0fPEUD0dJeBPa4X9EuM/Tp7kbR9/uJs1+sIIQlVo6fJO+iSXmLHmnboOV8X
 LcHFdGdfGKKmg/MaS3ZEFbXhhYuQGBGPLWX7MFK3l7UD1vUvqhey8
X-Received: by 2002:a05:6830:448e:b0:718:ced:90cb with SMTP id
 46e09a7af769-719ca18fb65mr19890569a34.9.1730963744342; 
 Wed, 06 Nov 2024 23:15:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT0YmfJNFekAbjfpoe34WY8rwDZ0GCsLh12KCiu/8fyjIOWCKaCptcprTG75c1O6J6fxGXwA==
X-Received: by 2002:a05:6830:448e:b0:718:ced:90cb with SMTP id
 46e09a7af769-719ca18fb65mr19890555a34.9.1730963744039; 
 Wed, 06 Nov 2024 23:15:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a107eb5f6sm172200a34.11.2024.11.06.23.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 23:15:43 -0800 (PST)
Message-ID: <69d5ac04-35b6-4b90-9031-888e8747bd09@redhat.com>
Date: Thu, 7 Nov 2024 08:15:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: Adjust path for swtpm state to use path under
 /var/tmp/
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, lena.voytek@canonical.com,
 Stefan Berger <stefanb@linux.ibm.com>
References: <20241106180751.6859-1-stefanb@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241106180751.6859-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On 11/6/24 19:07, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> To avoid AppArmor-related test failures when functional test are run from
> somewhere under /mnt, adjust the path to swtpm's state to use an AppArmor-
> supported path, such as /var/tmp, which is provided by the python function
> tempfile.TemporaryDirectory().
> 
> An update to swtpm's AppArmor profile is also being done to support /var/tmp.
> 
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com/
> Link: https://github.com/stefanberger/swtpm/pull/944
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Fixes: f04cb2d00d5c ("tests/functional: Convert most Aspeed machine tests")


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   tests/functional/test_arm_aspeed.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
> index 9761fc06a4..a574b1e521 100644
> --- a/tests/functional/test_arm_aspeed.py
> +++ b/tests/functional/test_arm_aspeed.py
> @@ -227,11 +227,11 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
>   
>           image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
>   
> -        socket_dir = tempfile.TemporaryDirectory(prefix="qemu_")
> -        socket = os.path.join(socket_dir.name, 'swtpm-socket')
> +        tpmstate_dir = tempfile.TemporaryDirectory(prefix="qemu_")
> +        socket = os.path.join(tpmstate_dir.name, 'swtpm-socket')
>   
>           subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
> -                        '--tpmstate', f'dir={self.vm.temp_dir}',
> +                        '--tpmstate', f'dir={tpmstate_dir.name}',
>                           '--ctrl', f'type=unixio,path={socket}'])
>   
>           self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')


