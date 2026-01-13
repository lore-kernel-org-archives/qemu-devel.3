Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C812D29DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaqW-0000pT-1Z; Tue, 13 Jan 2026 04:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfaqQ-0000J5-CO
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfaqM-0003NU-6u
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/Y5sLLwtp5CKOTcyJsY3vbxgNPhNOZkAMdCM9/XB47g=;
 b=XvGBOL8swV7SPGXQHGpzhDmlrmY4u4OLy3kirt19cQeqWFuD4PIYvi32NR1Dpvcb4Blo1P
 v2FYto6JH86XHTzl7NiMcwjECBrvmDAyrghBvGCRsYTcaLnj5VvRlxRF4pMMDbRXOkey+D
 gUhpsb46OgOsMvYZztcjdQMNVqZf1kQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-3POR138vOCKEJDlnTYfcdw-1; Tue, 13 Jan 2026 04:37:40 -0500
X-MC-Unique: 3POR138vOCKEJDlnTYfcdw-1
X-Mimecast-MFC-AGG-ID: 3POR138vOCKEJDlnTYfcdw_1768297059
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477a1e2b372so67732245e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 01:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768297059; x=1768901859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/Y5sLLwtp5CKOTcyJsY3vbxgNPhNOZkAMdCM9/XB47g=;
 b=QMYmaAsFaassEYudKZU6f0/bAsZkS6Nnpo5AzS/cMcLtQV3AaxWHL9V72LtCgf+Asp
 9cOcUbBsndbdkC7wgBNHBr/7bbqr+d8ZVwjRf2FXRSodPQT0uQGwviGQDwZ6nyzV/h1z
 UwRZGHDKN5S9OUtvtB76XbZ/LhgGPNNOTqUv9RyvAP0XMmh5hfwaLg7/cBiUpTS3cLAd
 LF+nyXOoDbZzmnM0CgMesc2+C6RO3k4XBp0HmYuvoyAc3tyZEUJG2i4Cm8TSvtoUkRCr
 RIQahWXWnFJvjY3ZJQ0dAP/xbxrSyM//ZF4WsWn8cr2JJzzvauOhIF/QmRsx79GTFcG9
 nREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768297059; x=1768901859;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Y5sLLwtp5CKOTcyJsY3vbxgNPhNOZkAMdCM9/XB47g=;
 b=kQeFhev36npUUbNmN1pi8j5pIdIBtOAYZ/ww+YRx+6ZWevpwHLYFPBTmy1c0VF7ZfM
 eTGmBCApENSeXwCvRz7cZFrUYEiGGfa0yzaQbSva0yIxo/w+UJLig56laXxrxj1+inJR
 TP3sZ2f9jUGmYwkfsQR/x8NWCwPnSV9pMCSUlsIp12giFyznEGGBCn6GnFCpZY6esiA1
 LE05lVyemFIlan6WujJZtkPKvw9nKBFgC1QNQDzffXDvfkPMK1ptVHp69fMbU+uzd3cp
 n7OmASRTGRsulr0nMy39Le+1p+b2pUwk6RRjm91RrHrNQG87d2ZahhdKOERENFmU+p9s
 LNIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx8mNHRDJSAxxz4GuAELqtI1fr8axeRhqNk9kIbP42PcgXlbp1tPEZMHv+oBlL8G6GrpG3bnPBEQDB@nongnu.org
X-Gm-Message-State: AOJu0YyeXfx21cFqGYwNhxVe1gxlM4CVPYF79dOWnGuhojx2+RsOoGsK
 ZBgFLjEtzjiDPyRq7tbLfpPpEC+Htyv9Ci6DXdFBcVXVCadCOd3eV6JEKF82e1hiyoZRcecsQFR
 kmH2BrFnTrANfFLa0kaim+i6DSH5+qa/uxsDTn3tRaaN75ei5Pczhi/SZ
X-Gm-Gg: AY/fxX6Krlg8HXuslaOJVamaNw//U2w1NKXPb1xW9a3ZYA6qMmKf0F0QVtZjYJBIMaU
 82/hXR2ySwg1n+BP3oydsSYQqmfyzAU51QX1u1OsgDYfUgcooqzofzjhEkFyTDW+k8xJ7Ns6m5t
 Rmr49anWxxHtEOWSaYBtRv8aQ6i/Q0CI55avdWXXlnZEgaDwTindEZ7bGnj+eUjVGimrHlbxBs4
 KmgQpcDD0L4CbbNaN5qhmdBxXf4xvGalyRAJ3W+FgaBrURVrVwL/5VGU1mrCFFcOoElVUG3UN/I
 Hgz5qXAeO3ox0coPD9SQZtkANighAdrS2wNfaGiiHo7F6sLb2AIhB2BtgOxqwHh0pt8YfE62OiA
 lR7Iib+k=
X-Received: by 2002:a05:600c:8b43:b0:479:1ac2:f9b8 with SMTP id
 5b1f17b1804b1-47d84b33b7bmr246996905e9.21.1768297058834; 
 Tue, 13 Jan 2026 01:37:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/rTiqugTwEkgznUPQXMi8WEH/oyvf4Vzkm4auDcyPtxQowyNElLzMZDIEfpDy7NlnJIfrDw==
X-Received: by 2002:a05:600c:8b43:b0:479:1ac2:f9b8 with SMTP id
 5b1f17b1804b1-47d84b33b7bmr246996535e9.21.1768297058411; 
 Tue, 13 Jan 2026 01:37:38 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ed9feb7d6sm10987665e9.6.2026.01.13.01.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 01:37:37 -0800 (PST)
Message-ID: <9d8945df-414c-46f3-8d3c-7c3e2cae2eaf@redhat.com>
Date: Tue, 13 Jan 2026 10:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 27/29] tests/functional/s390x: Add secure IPL
 functional test
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-28-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-28-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Add functional test for secure IPL.

Thanks a lot for adding the test, I think this will be helpful!

> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
...
> diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional/s390x/test_secure_ipl.py
> new file mode 100644
> index 0000000000..c4c7ec3897
> --- /dev/null
> +++ b/tests/functional/s390x/test_secure_ipl.py
> @@ -0,0 +1,140 @@
> +#!/usr/bin/env python3
> +#
> +# s390x Secure IPL functional test: validates secure-boot verification results
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os

As far as I can see, you never use any function from "os", so you can drop 
that import.

> +import time
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import exec_command_and_wait_for_pattern, exec_command
> +from qemu_test import wait_for_console_pattern, skipBigDataTest
> +from qemu.utils import kvm_available, tcg_available

You never use kvm_available or tcg_available, so please drop that import.

> +class S390xSecureIpl(QemuSystemTest):
> +    ASSET_F40_QCOW2 = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/'
> +         'fedora-secondary/releases/40/Server/s390x/images/'
> +         'Fedora-Server-KVM-40-1.14.s390x.qcow2'),
> +        '091c232a7301be14e19c76ce9a0c1cbd2be2c4157884a731e1fc4f89e7455a5f')
> +
> +    # Boot a temporary VM to set up secure IPL image:
> +    # - Create certificate
> +    # - Sign stage3 binary and kernel
> +    # - Run zipl
> +    # - Extract certificate
> +    # Small delay added to allow the guest prompt/filesystem updates to settle
> +    def setup_s390x_secure_ipl(self):
> +        temp_vm = self.get_vm(name='sipl_setup')
> +        temp_vm.set_machine('s390-ccw-virtio')
> +        self.require_accelerator('kvm')

I'd maybe move the self.require_accelerator('kvm') to the beginning of the 
test_s390x_secure_ipl() function already.

> +        self.qcow2_path = self.ASSET_F40_QCOW2.fetch()
> +
> +        temp_vm.set_console()
> +        temp_vm.add_args('-nographic',
> +                         '-accel', 'kvm',
> +                         '-m', '1024',
> +                         '-drive',
> +                         f'id=drive0,if=none,format=qcow2,file={self.qcow2_path}',
> +                         '-device', 'virtio-blk-ccw,drive=drive0,bootindex=1')
> +        temp_vm.launch()
> +
> +        # Initial root account setup (Fedora first boot screen)
> +        self.root_password = 'fedora40password'
> +        wait_for_console_pattern(self, 'Please make a selection from the above',
> +                                 vm=temp_vm)
> +        exec_command_and_wait_for_pattern(self, '4', 'Password:', vm=temp_vm)
> +        exec_command_and_wait_for_pattern(self, self.root_password,
> +                                          'Password (confirm):', vm=temp_vm)
> +        exec_command_and_wait_for_pattern(self, self.root_password,
> +                                    'Please make a selection from the above',
> +                                    vm=temp_vm)
> +
> +        # Login as root
> +        exec_command_and_wait_for_pattern(self, 'c', 'localhost login:', vm=temp_vm)
> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:', vm=temp_vm)
> +        exec_command_and_wait_for_pattern(self, self.root_password,
> +                                          '[root@localhost ~]#', vm=temp_vm)
> +
> +        # Certificate generation
> +        time.sleep(1)
> +        exec_command_and_wait_for_pattern(self,
> +                                         'openssl version', 'OpenSSL 3.2.1 30',
> +                                         vm=temp_vm)
> +        exec_command_and_wait_for_pattern(self,
> +                            'openssl req -new -x509 -newkey rsa:2048 '
> +                            '-keyout mykey.pem -outform PEM -out mycert.pem '
> +                            '-days 36500 -subj "/CN=My Name/" -nodes -verbose',
> +                            'Writing private key to \'mykey.pem\'', vm=temp_vm)
> +
> +        # Install kernel-devel (needed for sign-file)
> +        exec_command_and_wait_for_pattern(self,
> +                                'sudo dnf install kernel-devel-$(uname -r) -y',
> +                                'Complete!', vm=temp_vm)
> +        time.sleep(1)
> +        exec_command_and_wait_for_pattern(self,
> +                                    'ls /usr/src/kernels/$(uname -r)/scripts/',
> +                                    'sign-file', vm=temp_vm)
> +
> +        # Sign stage3 binary and kernel
> +        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-file '
> +                    'sha256 mykey.pem mycert.pem /lib/s390-tools/stage3.bin',
> +                    vm=temp_vm)
> +        time.sleep(1)
> +        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-file '
> +                    'sha256 mykey.pem mycert.pem /boot/vmlinuz-$(uname -r)',
> +                    vm=temp_vm)
> +        time.sleep(1)

Can you maybe work-around the above time.sleep() commands by waiting for the 
shell prompt inbetween?
wait_for_console_pattern(self, '[root@localhost ~]#') or so ?

> +        # Run zipl to prepare for secure boot
> +        exec_command_and_wait_for_pattern(self, 'zipl --secure 1 -VV', 'Done.',
> +                                          vm=temp_vm)
> +
> +        # Extract certificate to host
> +        out = exec_command_and_wait_for_pattern(self, 'cat mycert.pem',
> +                                                '-----END CERTIFICATE-----',
> +                                                vm=temp_vm)
> +        # strip first line to avoid console echo artifacts
> +        cert = "\n".join(out.decode("utf-8").splitlines()[1:])
> +        self.log.info("%s", cert)
> +
> +        self.cert_path = self.scratch_file("mycert.pem")
> +
> +        with open(self.cert_path, 'w') as file_object:

Please add an encoding='utf-8' parameter to open() to avoid a warning from 
pylint.

...
 > +        wait_for_console_pattern(self, verified_output);
 > +        wait_for_console_pattern(self, verified_output);

Please drop the semicolons at the end here.

(Hint: pylint or flake8 can help to detect such coding-style issues)

  Thanks,
   Thomas


