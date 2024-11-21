Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AE3E6400C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tED3c-0001Sz-Cn; Thu, 21 Nov 2024 14:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tED3b-0001Sl-82
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tED3Z-0006VJ-OG
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732218097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U+74IKXBfX76Hsz8vjGkl972OkUA9XQ4WAykI0zzAQw=;
 b=WOOKno0zI0iUzEbWdxX6GutzT0i7qdQWGJrbvfyyzBA0O/2byNE3DVHrRYq2NV8nlNPEgP
 J5YJwxWzk/NajLJbrWVHIBduM9BizUkoh+4l1Z4di3aUOb1QuXy24ZUyarjkbx0Loyxi5q
 fVr79SSpbirLElQ1wtuT3H/Bo1wkmVE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Ksw3KfzDMaiTLMW1n-BmNw-1; Thu, 21 Nov 2024 14:41:35 -0500
X-MC-Unique: Ksw3KfzDMaiTLMW1n-BmNw-1
X-Mimecast-MFC-AGG-ID: Ksw3KfzDMaiTLMW1n-BmNw
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539e03bfd4aso819159e87.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732218094; x=1732822894;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U+74IKXBfX76Hsz8vjGkl972OkUA9XQ4WAykI0zzAQw=;
 b=CtoY3BPkKqUrav9sKCrphkmRVAhMz1lQ5qo2bqIzSdl/eadzEx/OVzeYBz16uSbacT
 K5tKsJKWHCei39ygxRY+/jCVtn76nz3UysZvuGdXhIMwYIRl7pt9n+IIolhrWfPrztPw
 SyxYgIHTQmaVUACoDdNmn5YNoCc+/83TUvQZAjRP3m7ajpZX2HO5S9LC7sFvxGay/Y6+
 YJWMsseSUwKq4BqmvoCRtzmgj8bdh7VkhteljFmYHe90/XKGzokO6xVD9t/1HAt004Sj
 ZIZAuodKwQKEpQnXf4U+WCtEvXPlo7LRQhBYrYReREGfC2wLvhxdRaTgTkfjqQMqcps8
 pFyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR3OayeWAk50WK3tBMSKpLnh1f/OGmabFVZws8tgOyRmDJWDz2ZScXjQ81uP2TjAghZqUGux1zeJ8g@nongnu.org
X-Gm-Message-State: AOJu0Ywv2htogFVFSvEwE8bahcfN2YgTbDG3vezIyNQ/cU3Hj3VQMjkc
 6zCIhwR7iHGnsw6h68bMUbIvWGLjCAzIyEIQ+bI2T9lOfmnffo0OP4Oh1VQfNA9zV7f/GNuoROW
 lgHeXEVVLiXiS+gDNPvC9b3+h2JEXk9z1fukKfvXPxreAWOTfeNrV
X-Gm-Gg: ASbGnctQ+8Gflwprx0mrb7i4MDFOsp20oM0MNSWDBpNTKkt9W7nYvA7sHadiSCT9gLo
 IdwI/7l+9reXIkKbEfiCan1YlzG0/pY17OWLFIAqIOzrYUvvGHYVEMWY21wgujgNBTDeIZi0fQY
 scKcUaxISQBGLVoByFNlSWE7+ien0NHJS1qlA8eiMuZ+9tKpQgZwxHScsLEfVQCiVZvt8Bj2lXk
 I7L7EEQAnWCVHQnPQ5Z49nj5/s02jg/lsjKWt+PozeSioNUYv+Kxxc9riTtD0Zapl5SmoR8v92F
 cNM=
X-Received: by 2002:a05:6512:3e09:b0:539:9524:92bc with SMTP id
 2adb3069b0e04-53dc136de98mr4591524e87.55.1732218093831; 
 Thu, 21 Nov 2024 11:41:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAOv2Hbg1AVnnkEQijZMhiu4NsYBIUOxDyDjgKet5h5h526Pk9yCTnwALxfPQSanrlKmQmkA==
X-Received: by 2002:a05:6512:3e09:b0:539:9524:92bc with SMTP id
 2adb3069b0e04-53dc136de98mr4591490e87.55.1732218093423; 
 Thu, 21 Nov 2024 11:41:33 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-70.web.vodafone.de. [109.42.51.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b2f5402sm7750366b.68.2024.11.21.11.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 11:41:33 -0800 (PST)
Message-ID: <abaf7618-96dc-416a-b0dc-2ead6c16e45b@redhat.com>
Date: Thu, 21 Nov 2024 20:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/39] tests/functional: add a QMP backdoor for debugging
 stalled tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-s390x@nongnu.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
 <20241121165806.476008-18-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241121165806.476008-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
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

On 21/11/2024 17.57, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> Support the QEMU_TEST_QMP_BACKDOOR=backdoor.sock env variable as a
> way to get a QMP backdoor for debugging a stalled QEMU test. Most
> typically this would be used if running the tests directly:
> 
>   $ QEMU_TEST_QMP_BACKDOOR=backdoor.sock \
>     QEMU_TEST_QEMU_BINARY=./build/qemu-system-arm \
>     PYTHONPATH=./python \
>     ./tests/functional/test_arm_tuxrun.py
> 
> And then, when the test stalls, in a second shell run:
> 
>   $ ./scripts/qmp/qmp-shell backdoor.sock
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20241121154218.1423005-18-berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/testing/functional.rst      | 10 ++++++++++
>   tests/functional/qemu_test/testcase.py |  7 +++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
> index 6b5d0c5b98..b8ad7b0bf7 100644
> --- a/docs/devel/testing/functional.rst
> +++ b/docs/devel/testing/functional.rst
> @@ -176,6 +176,16 @@ primarily depend on the value of the ``qemu_bin`` class attribute.
>   If it is not explicitly set by the test code, its default value will
>   be the result the QEMU_TEST_QEMU_BINARY environment variable.
>   
> +Debugging hung QEMU
> +^^^^^^^^^^^^^^^^^^^
> +
> +When test cases go wrong it may be helpful to debug a stalled QEMU
> +process. While the QEMUMachine class owns the primary QMP monitor
> +socket, it is possible to request a second QMP monitor be created
> +by setting the ``QEMU_TEST_QMP_BACKDOOR`` env variable to refer
> +to a UNIX socket name. The ``qmp-shell`` command can then be
> +attached to the stalled QEMU to examine its live state.
> +
>   Attribute reference
>   -------------------
>   
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index e2a329c3e5..fceafb32b0 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -175,6 +175,13 @@ def _new_vm(self, name, *args):
>                            log_dir=self.logdir)
>           self.log.debug('QEMUMachine "%s" created', name)
>           self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
> +
> +        sockpath = os.environ.get("QEMU_TEST_QMP_BACKDOOR", None)
> +        if sockpath is not None:
> +            vm.add_args("-chardev",
> +                        f"socket,id=backdoor,path={sockpath},server=on,wait=off",
> +                        "-mon", "chardev=backdoor,mode=control")
> +
>           if args:
>               vm.add_args(*args)
>           return vm

Reviewed-by: Thomas Huth <thuth@redhat.com>


