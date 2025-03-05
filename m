Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B44C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkbm-0005dq-TT; Wed, 05 Mar 2025 04:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpkbi-0005bo-KY
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:00:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpkbg-0005Cq-TL
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741165200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OEEeLhpyKoYYthr1UzdgEWovVj8EQk6WDCv60eR5EAw=;
 b=REyuINJlWjVq0dj3ZgCBrBqIhcDOU0Xg1C0N3r0t612gT45jLjqhZd8Xb8EvdKJgld59yI
 Jqh9CopsexUy/MB9IruVAAh/3EOLE+aqx0QP+MgV9ZiBh/C6Oj/xLFR6DdIxwjxusnYPrH
 ACfTb9vYw1SfCIoEOGXY45pJuhDQXCE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-_3uqVMypOVef0AjaDPsAiA-1; Wed, 05 Mar 2025 03:59:49 -0500
X-MC-Unique: _3uqVMypOVef0AjaDPsAiA-1
X-Mimecast-MFC-AGG-ID: _3uqVMypOVef0AjaDPsAiA_1741165188
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43bd0586a73so6900905e9.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 00:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741165188; x=1741769988;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OEEeLhpyKoYYthr1UzdgEWovVj8EQk6WDCv60eR5EAw=;
 b=FIZc0OAvGr3kT0iqV8Llv9gdE+goe7z+vzRKWM8miE8PpUX56EPHsuECJEdy+QZyHK
 Io56f7PbrXlsW3BnKkoUT7HGwuZhd62/p837MsGL2Mfh28GfH0APs6qA5B1UZLFW5dGq
 JrvCV5Bpg5dzFryCUkOkksbUXl51RDpA7V2q8f0J9fnLAgL/FFsLNMgk/OAsPPPz2mld
 k3C0gE8cI/7OB4EfPmIxnuWSsegUPQxtHBqHoarCUJ9CFgGnEvKsW7pPEMHxeUMTjoja
 8XFqvPBKPLq6WnviRX2Q2TVfFNU4Pf5evUpaIW0DQidiP6TDxn84BhKA26SXRvqkpblR
 efAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHWvwVyetdFPnyb/3DpRceJtkuYT0tF6sRBnKleqSxWtpLOnn4AxSeaCX7E3XdyZ1MLNAR7VFhAFKS@nongnu.org
X-Gm-Message-State: AOJu0YxeWOsy7xDlrQoSBdTOqgv6CSR5rSZSkK0M0qSIG57PqHUAfO88
 yTHbQIrRv40L1UE3NiKH8nZLUtwmEwsScc4UHyeOmDr50ydbzYHJzV8HrULXYqw8ZxYm+wL4QKc
 k9yYV8uB0OGcg/RVNQ8mtVd6F6uOb0QZJHtih89+XJTv1eqF4+BZJ
X-Gm-Gg: ASbGncsKlDedsAJNc+gXxS0280l3r/U9ky/Vs+s2pt4umvOx2+ShHZollH/e5czxcd0
 ztt0mchgCx6mHnQ/jDZmaUQy1fH5C4aIqx3HL5hzryeJaOezPzBbi4R1yU40emfVyjq+amC1Mb9
 sBRgxQf0nkSoLmb0FS33ZEsMZZxrpk2rOVqiKw97b00q2O4vQN+eGtlCwe5jvcroh6vhEVBwr12
 flvYKDoQAMIsY+4JPEcykuOK79BCMqHKnkEOvTp+DPb56+cb2KHOdG2DgPAcIoJlMkAiMgfmDvf
 kruT0Af7NV4zfUIbuo5VxHW6IJm6HiNp5W4lmCGplNGaqwM=
X-Received: by 2002:a05:600c:474b:b0:439:a255:b2ed with SMTP id
 5b1f17b1804b1-43bd29458a0mr14061015e9.9.1741165187823; 
 Wed, 05 Mar 2025 00:59:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfM86MV/efG/HNVfjFUNiO7Ul+yo77k+EzbNhyH2WxEiLjw4cLqiFaBZXebh5y1YGnXTwyMw==
X-Received: by 2002:a05:600c:474b:b0:439:a255:b2ed with SMTP id
 5b1f17b1804b1-43bd29458a0mr14060825e9.9.1741165187428; 
 Wed, 05 Mar 2025 00:59:47 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485ddedsm19953796f8f.89.2025.03.05.00.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 00:59:47 -0800 (PST)
Message-ID: <981640a3-63e9-4a73-b5b5-8a093a529351@redhat.com>
Date: Wed, 5 Mar 2025 09:59:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] tests/functional: reduce tuxrun maxmem to work on
 32-bit hosts
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org
References: <20250228102738.3064045-1-berrange@redhat.com>
 <20250228102738.3064045-5-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250228102738.3064045-5-berrange@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/02/2025 11.27, Daniel P. Berrangé wrote:
> maxmem=4G is too large to address on 32-bit hosts, so reduce it
> to 2G since the tuxrun tests don't actually need such an elevated
> memory limit.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/test_ppc64_tuxrun.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/test_ppc64_tuxrun.py b/tests/functional/test_ppc64_tuxrun.py
> index 05c6162b5e..e8f79c676e 100755
> --- a/tests/functional/test_ppc64_tuxrun.py
> +++ b/tests/functional/test_ppc64_tuxrun.py
> @@ -64,7 +64,7 @@ def ppc64_common_tuxrun(self, kernel_asset, rootfs_asset, prefix):
>                            ',"index":1,"id":"pci.1"}')
>           self.vm.add_args('-device', '{"driver":"spapr-vscsi","id":"scsi1"'
>                            ',"reg":12288}')
> -        self.vm.add_args('-m', '2G,slots=32,maxmem=4G',
> +        self.vm.add_args('-m', '1G,slots=32,maxmem=2G',
>                            '-object', 'memory-backend-ram,id=ram1,size=1G',
>                            '-device', 'pc-dimm,id=dimm1,memdev=ram1')

Reviewed-by: Thomas Huth <thuth@redhat.com>


