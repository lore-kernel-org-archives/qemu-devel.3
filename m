Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA0AC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBnc-0003GX-75; Fri, 24 Jul 2026 05:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wnBnZ-00039z-RW
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wnBnX-0007R5-7e
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784883745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YOwWWg2zJU4HucI+Lo1Y72WHoe9IM7GcncfGM1IZ0tY=;
 b=GjpEgOe8/6RHIGzztZJCzqvXKNuia5dTFVq1/iVveSk7BMBxjiucfIIlwqf+QwL+jE8/R9
 wFcH5BfAcQmpwmnFNoHil1A/RhOMemEjbxHHs9wnqcHoVzc+8Ex20448qVS1za1fXVq6/b
 080gR65P5qIjUpQ5ChtjA7CWEESXQJs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-48KPopHwM7KcpwTOqSbzNQ-1; Fri, 24 Jul 2026 05:02:24 -0400
X-MC-Unique: 48KPopHwM7KcpwTOqSbzNQ-1
X-Mimecast-MFC-AGG-ID: 48KPopHwM7KcpwTOqSbzNQ_1784883743
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49553d98911so1715385e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784883743; x=1785488543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YOwWWg2zJU4HucI+Lo1Y72WHoe9IM7GcncfGM1IZ0tY=;
 b=bOYpdUggxsgjQ5bgtrZ1+fij005ulF3BgHwykrjZk3jDEQQMp/Oj/FtOZYn4JdHh1L
 +LewAO5/hOznYjBZXpnqfC0TpLcn2f3Qmm8zLQdKsj02/u0c7rMOH2evxQg6x3DIcNFk
 H/FDWG+XVWvKgblEQxBqsYn5Ti1VW58np9fdk/ejOR2METpCekBM6GiVjR5odHhYkxSN
 82wq6S9Wf/2qtTTRQpw9vVQ2v211vanLEgMeg7yxWAcKLfxrNEDsbFiJQc/QU3/7WvLg
 wKnAAcWF+Fh94n8RY3SKHk/KSL1aHpZqFFl0e6kAclVgjiuBah75rhDR6/dp+H7v54kw
 WezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784883743; x=1785488543;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YOwWWg2zJU4HucI+Lo1Y72WHoe9IM7GcncfGM1IZ0tY=;
 b=Ua3/+NjPhaXsRL48OLXW8BBE840MRsr9doWZ67YpSZCdOkdP/6J+KXR6iU58F3W8b7
 5ky16ZEJH18Vi9eu7h6ALuQLm+hC/QCKFmrhIt8zqsn0rVBWPFWCSA4YbrmavWuIba8Q
 AK4Nr45KhRqqCAMBvsL2w+LmRmXRy1SQdpjM1N2Ct8gAnFtnh1lfTFYBHn6qo1R2V1wd
 WoLp7ZAS2C9FCfwaziSUe2RMVVDChbzyrQxB/tYbTukvxQpGHdKzz24RwgngatW8FOtc
 5WFOFe1hgi1pmisXiMP9RZMvBSCdOlLNW1Y0PUmM8Dnt3hEaKd2XFzKU3+snC2FULGZC
 zOCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFAOl4tF6C26Vxpf/jDMwizl9XHodPta3nRaiozz5NOX+2gKJsMRdCqTnk9lwiVWIOIqw8TZlVCLi4@nongnu.org
X-Gm-Message-State: AOJu0YyLykbqGyDG3/S+Mxe56yd4TU0Hyv0eWT0aqy7XFWGEM6a1OcY3
 EPHYrJFjVyU7hsrno8KaNAz7QJaypicVad9640Yw+n4GVQBKme8vFmDLfArDgkeTjhhUcYUFoBT
 5Prq0fDJQzcKzTtgkne6DUjmWI1mMgkRTzhnwBlAaJDUvqU12tpHaUXSN
X-Gm-Gg: AR+sD12LjbN9l1hl7qhE7SzOC7fkl3wm8cOTGe+BBGVOh63UdxG3/CARsGvClKL97bp
 rJRPQd07/p0FMsn5OCOYZUEP22xe5utMHPUWm1uIHqc5GdVmnP2W7c51Rz0tpvsqReKM0jdYIpw
 SGiNl8guXccC3Is3YkEHWbcsD2ihXXqVzhl4aQN7EpRovjDfXmrkoQZfgk2SRbMWJgZgM2dh3k9
 ND0QE3ZyamUGGGwih4yc1BcZNHgdYkHEagIguaqmUJ3ro7GZpv/Dd0E8sfzke+ETxbiH2EhS5lA
 VVwIg5zbivqtoFuwZfek/vZZ9U3G3cpkztj1aE1uIz4rhLLSpxfdEUXyB+i2ZTQR0/R1Zz6fFw=
 =
X-Received: by 2002:a05:600c:26d3:b0:493:f478:4c71 with SMTP id
 5b1f17b1804b1-49574593d20mr44284615e9.7.1784883742643; 
 Fri, 24 Jul 2026 02:02:22 -0700 (PDT)
X-Received: by 2002:a05:600c:26d3:b0:493:f478:4c71 with SMTP id
 5b1f17b1804b1-49574593d20mr44284315e9.7.1784883742233; 
 Fri, 24 Jul 2026 02:02:22 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af78639sm54584925e9.7.2026.07.24.02.02.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 02:02:21 -0700 (PDT)
Message-ID: <3295a8fa-b7c3-4502-a5cd-3dbb67083c19@redhat.com>
Date: Fri, 24 Jul 2026 11:02:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/ppc: skip remote interrupts test if -net
 user not built
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: adityag@linux.ibm.com, amachhiw@linux.ibm.com, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com
References: <20260724085440.520125-1-shivangu@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260724085440.520125-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/07/2026 10.54, Shivang Upadhyay wrote:
> While running remote interrupts test, without libslirp-devel installed,
> facing the following panic logs.
> 
>    File
>      ...
>      raise VMLaunchFailure(
>      ...<3 lines>...
>      ) from exc
>      ...
>          Output: qemu-system-ppc64: -netdev user,id=net0: network backend
> 'user' is not compiled into this binary
> 
> Skipping the test if vm fails to launch.
> 
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   tests/functional/ppc64/test_powernv.py | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
> index bac2017e18..73ba4e7221 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -11,6 +11,8 @@
>   from qemu_test import wait_for_console_pattern
>   from qemu_test import exec_command_and_wait_for_pattern
>   
> +from qemu.machine.machine import VMLaunchFailure
> +
>   class PowernvMachine(LinuxKernelTest):
>   
>       timeout = 90
> @@ -112,7 +114,11 @@ def test_linux_remote_interrupts(self):
>               f'file={rootfs_path},format=raw,if=none,id=drive0,readonly=on',
>               '-append', 'root=/dev/nvme0n1 console=hvc0',
>               '-device', 'nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234')
> -        self.vm.launch()
> +        try:
> +            self.vm.launch()
> +        except VMLaunchFailure:
> +            # Maybe not compiled with netuser backend
> +            self.skipTest(f'Could not find -net user')
>   
>           # Wait for boot to complete
>           console_pattern = 'CPU maps initialized for 1 thread per core'

Please use self.require_netdev('user') instead, like it is already done in 
other tests.

  Thanks,
    Thomas


