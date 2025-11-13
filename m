Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF83FCD5BCE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 11:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJVcF-0002aZ-JK; Thu, 13 Nov 2025 06:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJVbw-0002WK-23
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:35:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJVbs-0007tC-OV
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763033726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OapG27k40i29rMBd+IHFgWVqFL0GhgDUXBclZ0jQMq0=;
 b=T/Uro5F/tU2bNGEJMYo+ZrQxmawQuUiHyMQJn3QW8uvKrxnpL5//Y32Q9fR5qZ377mV1BN
 LwAP5oA467BKbJcTzsrJ+qT6g9bw0fw9kZBhDwVmyafh7P19HYMZpZSFSwPLe3lXp3nJHp
 I8Ws/jn0lTn1RY1IK1fdjG1mTo+FdS0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-yS5UfqQFO7ejRRShYmfvPQ-1; Thu, 13 Nov 2025 06:35:25 -0500
X-MC-Unique: yS5UfqQFO7ejRRShYmfvPQ-1
X-Mimecast-MFC-AGG-ID: yS5UfqQFO7ejRRShYmfvPQ_1763033724
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b3c965ce5so522271f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 03:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763033724; x=1763638524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OapG27k40i29rMBd+IHFgWVqFL0GhgDUXBclZ0jQMq0=;
 b=kfEVh6WbP+YL3kV/jufdhf1MKsgJRIfcOpSQE3z4PPpwHKZfGU7Igigo9xrXZOLY/2
 vTf9Kkyne9rIE6O1TZXxtUcTL6IjcUP7p2ay4aGMkmTvwRT8jlknCYT7OQ3UFLK4jaLl
 QtSl1T1cVnX+8ystU2Lzl6UPaBottU8P45rUIbB2D4KiAAHdseZO7YfxN89dLraif7YD
 ZBet43iXnF07P204/0o2chlSLG61d25xzn+Hb6Rw8BzOONmmhTEWzGGDQzriDRtkt+DK
 xzP3ntYsj31PJXSsjRlwWxxp2EoMWZlKAdKukaFOV4MFQcxbIvDlaGVK7B3xZvTojhgl
 OFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763033724; x=1763638524;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OapG27k40i29rMBd+IHFgWVqFL0GhgDUXBclZ0jQMq0=;
 b=e6SU57d/JcfraDdjGqpXkCCVuYRWDQKJSnArhcRcCOd5Yf/T+Fj3fe9gZVbGv6gb5C
 9xUszF0ic0bT7nzuqZX+1XIqeqPWoSYxKVYaC8RSE/+WN48u8LM2Oq7UfTeY/uG7zNXa
 xsyrbbvyrOs7lDMIoCU2iIXuEWf8gD/7xoftqlWkmFhFH4U/KoZBAniDc4/2fmeeZ3T2
 uzyOG/ttCf8tNGQiOhCe5E68kkG7UQFw1DGLbJL8Kr9GWbai1z6p2KQpvoohRxyXc092
 N55jxG1EucD6jrTs1dToUc7BrwEz2TSMnMqkItHQ592nmB9oCxhRDN+7Z99P3f0cOzZ3
 lXTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnIspDwAl1ZmcM7J44zJUi8NvslRP/BMYjZtmuMiGmg/6kRfNAXl2xNmzd5htpIOzZSQshf00qIWUy@nongnu.org
X-Gm-Message-State: AOJu0YyVzLiTBdwpbqMvpPpdwZYkLS6kOTDK+dfCryNdL83EAcrj3t8J
 hLQiyGBF0XfWtCAAOjQoPcKsK1Nh+1ZD4wCP3QGpRsJIEYHhvN1e/3BtoWQvzAe9QtPZ9LgyBJm
 OFDP1ie2fntrTXQBSYWeL53PbkLvQiYleXKr0O4ixceQ/KgJzPtJpU3W+
X-Gm-Gg: ASbGncsbFgn0ScoiOo1aI+mkp1NwQioPQq7TslMQjlHLceqLcMwdnPytEKeow5t2GVQ
 8eZ15hxMAohz3PriCA7GnrsU5yU5VR03t6HE1nStgS/j3oTaD0ma3tjISXZ2/sP1p6e2Sit1n2J
 +2ctrRe1wtQc8w6Lg8QQRndcb/eJ8ag8A6q9sFksHYo7FjM8gieuW+s0xFWOyjdQZoJSpWVkS2w
 F7k3FvJRiPjfnF5iCWM5eRzyA5cArStnRCywaCbiKmSN9Y4oVR2PxkWmGPgvoIB808yqGapd69I
 VPYVYW1c4CroXPWjOj5Vm2JRlCvpz6g9X/1c4P3oNL4p4SX0PeZ5HA+mMrahgviF6EIfmPM=
X-Received: by 2002:a05:6000:2481:b0:429:cda2:9ffd with SMTP id
 ffacd0b85a97d-42b4bb8f004mr4864950f8f.9.1763033723875; 
 Thu, 13 Nov 2025 03:35:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER3tzSmUJdqaqywOISgoI3LKPqeHG1nYv6nyZHZZs54QSn+nF/kWQWyjFOn+sEqdjWw4iDLg==
X-Received: by 2002:a05:6000:2481:b0:429:cda2:9ffd with SMTP id
 ffacd0b85a97d-42b4bb8f004mr4864916f8f.9.1763033723380; 
 Thu, 13 Nov 2025 03:35:23 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b14bsm3291894f8f.9.2025.11.13.03.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Nov 2025 03:35:23 -0800 (PST)
Message-ID: <5d4b5bca-75cc-4edb-bd3d-810c3e6698f9@redhat.com>
Date: Thu, 13 Nov 2025 12:35:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/x86_64/test_virtio_gpu: Fix various
 issues reported by pylint
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251113113019.488204-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251113113019.488204-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 13/11/2025 12.30, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Use the recommended order for import statements, specify the kind of
> exceptions that we try to catch, use f-strings where it makes sense,
> rewrite the vug_log_file part with a proper "with" statement and
> fix some FIXMEs by checking for the availability of the devices, etc.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Use a "with" block also for the subprocess.Popen() part
> 
>   tests/functional/x86_64/test_virtio_gpu.py | 57 +++++++++++-----------
>   1 file changed, 29 insertions(+), 28 deletions(-)
> 
> diff --git a/tests/functional/x86_64/test_virtio_gpu.py b/tests/functional/x86_64/test_virtio_gpu.py
> index be96de24da2..8c9f2350e69 100755
> --- a/tests/functional/x86_64/test_virtio_gpu.py
> +++ b/tests/functional/x86_64/test_virtio_gpu.py
> @@ -5,22 +5,23 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   
> +import os
> +import socket
> +import subprocess
>   
>   from qemu_test import QemuSystemTest, Asset
>   from qemu_test import wait_for_console_pattern
>   from qemu_test import exec_command_and_wait_for_pattern
>   from qemu_test import is_readable_executable_file
>   
> -
> -import os
> -import socket
> -import subprocess
> +from qemu.machine.machine import VMLaunchFailure
>   
>   
>   def pick_default_vug_bin(test):
>       bld_dir_path = test.build_file("contrib", "vhost-user-gpu", "vhost-user-gpu")
>       if is_readable_executable_file(bld_dir_path):
>           return bld_dir_path
> +    return None
>   
>   
>   class VirtioGPUx86(QemuSystemTest):
> @@ -46,8 +47,8 @@ def wait_for_console_pattern(self, success_message, vm=None):
>           )
>   
>       def test_virtio_vga_virgl(self):
> -        # FIXME: should check presence of virtio, virgl etc
>           self.require_accelerator('kvm')
> +        self.require_device('virtio-vga-gl')
>   
>           kernel_path = self.ASSET_KERNEL.fetch()
>           initrd_path = self.ASSET_INITRD.fetch()
> @@ -68,7 +69,7 @@ def test_virtio_vga_virgl(self):
>           )
>           try:
>               self.vm.launch()
> -        except:
> +        except VMLaunchFailure:
>               # TODO: probably fails because we are missing the VirGL features
>               self.skipTest("VirGL not enabled?")
>   
> @@ -78,8 +79,8 @@ def test_virtio_vga_virgl(self):
>           )
>   
>       def test_vhost_user_vga_virgl(self):
> -        # FIXME: should check presence of vhost-user-gpu, virgl, memfd etc
>           self.require_accelerator('kvm')
> +        self.require_device('vhost-user-vga')
>   
>           vug = pick_default_vug_bin(self)
>           if not vug:
> @@ -95,27 +96,30 @@ def test_vhost_user_vga_virgl(self):
>           os.set_inheritable(qemu_sock.fileno(), True)
>           os.set_inheritable(vug_sock.fileno(), True)
>   
> -        self._vug_log_path = self.log_file("vhost-user-gpu.log")
> -        self._vug_log_file = open(self._vug_log_path, "wb")
> -        self.log.info('Complete vhost-user-gpu.log file can be '
> -                      'found at %s', self._vug_log_path)
> -
> -        vugp = subprocess.Popen(
> -            [vug, "--virgl", "--fd=%d" % vug_sock.fileno()],
> -            stdin=subprocess.DEVNULL,
> -            stdout=self._vug_log_file,
> -            stderr=subprocess.STDOUT,
> -            shell=False,
> -            close_fds=False,
> -        )
> -        self._vug_log_file.close()
> -
> +        vug_log_path = self.log_file("vhost-user-gpu.log")
> +        self.log.info('Complete vhost-user-gpu.log file can be found at %s',
> +                      vug_log_path)
> +        with open(vug_log_path, "wb") as vug_log_file:
> +            with subprocess.Popen([vug, "--virgl", f"--fd={vug_sock.fileno()}"],
> +                                  stdin=subprocess.DEVNULL,
> +                                  stdout=vug_log_file,
> +                                  stderr=subprocess.STDOUT,
> +                                  shell=False,
> +                                  close_fds=False) as vugp:
> +                 self._test_vhost_user_vga_virgl(vug, qemu_sock,
> +                                                kernel_path, initrd_path)
> +                 qemu_sock.close()
> +                 vug_sock.close()
> +                 vugp.terminate()
> +
> +    def _test_vhost_user_vga_virgl(self, vug, qemu_sock,
> +                                                kernel_path, initrd_path):

Never mind, this causes another new pylint warning about an unused parameter 
... I'll send a v3... sorry for the fuzz.

  Thomas


