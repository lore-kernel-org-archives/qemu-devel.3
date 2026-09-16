Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06D2C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 04:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6hik-0002Zj-L0; Wed, 16 Sep 2026 00:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x6hig-0002ZT-UT
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 00:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x6hid-000267-3t
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 00:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789534681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QPHp2Pg6jXRUz1xxLHdm/GQy5X+3PMurIOYcaEuDtKA=;
 b=JmN9NceP7YIFV4BgomGrbMBfb8VOiuGzGPnMybWoi697unXrFb3nwl6E0sCAKz2Jpshg67
 oRNhJjzRL0x1eXxefg1dg4xAwhKDQWqigh01jvP8HuE3X2XW1gDmaWpnKAcWnHJk85axDQ
 THDvoTUcYsicWk/3eluhcC2YrkfhxwQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-Ak7RZjiPM2SWqljcfXaQHQ-1; Wed, 16 Sep 2026 00:57:59 -0400
X-MC-Unique: Ak7RZjiPM2SWqljcfXaQHQ-1
X-Mimecast-MFC-AGG-ID: Ak7RZjiPM2SWqljcfXaQHQ_1789534678
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e661c6440so30804445e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 21:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789534678; x=1790139478; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QPHp2Pg6jXRUz1xxLHdm/GQy5X+3PMurIOYcaEuDtKA=;
 b=keRhzwCzYFJOSgQ1tBJK7U/fyiJ9DTO0I3q2yx2yKnoyYpkhZAc5SKYVKMJfx9LlRj
 WeCS07brclRl1XqmqRJ0bdVEC5mm4uIm5OJ+h8avEWE/rvTg3EtoIplCzYfdvrOKsCe9
 PDFP/lf47Qinx7AVMqMB/0DVY+zitfuQkCBoaDuwRdZAvxcWMkug4oQzMYAsZTc578Oz
 rr9pKaO67hc6fRgaj11NsqPUGEwSI+xlz7jTKmi1IfutHELC5TUu8E79Ye+YBqKxpyPT
 8jJlF9WUY4GUOocO60TV9XvFl5NIpOW3ZY2ihd+D57kmO5RIP/0NywYFzNFuc17CklJ8
 wCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789534678; x=1790139478;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QPHp2Pg6jXRUz1xxLHdm/GQy5X+3PMurIOYcaEuDtKA=;
 b=Q8EJ0WZDH6PtNIEAHSsBev3wKuOEXhG6tgh1uQXdyw8us8nJOnqPP9UwA/t/ImYVKp
 gd4vq6nsKVSuzqaZqAwBXAyHNY0xyOXQuOyyvbp8BHqZZNP3wv+cjAy56M04Wpa73BsN
 GvWDQ9l/GE/GqP1wSMyBFSHseSnNeC6beWuwVlBceLb2BL1+lAnPGuhcY4YFl13B41pZ
 9H6hae3kgbro81LbT9IVNGuwAD92afbRo3tYNTecHEFKUDsm8ljAMoNh1IPJ1qMLFNLn
 icJzsmEY8e9lCmNQxO7LbwfLXRobRYNTVQrqHSfcrkLs3SQn2WuRfJ5haEgaUI5So2Oh
 XMMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwacuE0tK2rNM9jzF/qKaLvdsdpGFjGIlmqSztrMb6Y4qlhWUS1W8DC0sujTiOmMrDUK+W/ImwZhWRS@nongnu.org
X-Gm-Message-State: AFuF++nRNTKV76y2wu8MiNzYW5yfEfKnu0x7p/tSO24Y+5VaXGclCPOK
 5xlj5gTebesCp4s1snyHbQglk06NETEc1f1obGudp5nR1R5FZWHbEDUXeftkrP+Zs3/oghDA0hv
 OslidmZnuv58MvjvXuDus4ccFTYdrV0mX+EGJIz5uEY1m7y/6fo3rZPHS
X-Gm-Gg: AYBFou3t9wtZdWLDe8sZqMn/5V+VPGKLy6oHa+Jg+tuVZ7Pzby4pzt74wJ9AgFCWvp4
 gw6tGIg1r+JkeU2u9G67DmuHLZrblnWbBLL6x4T1rvEkr+7Ultdhn8dCRfNafp7OLlOOJYZWoZD
 ZMidg96yRHcej8NVCLqM95ushMIfNby/G2UEBTR28ZtGesXWUtkj7jiXKCp6bxPVUgxlalTxeR7
 ZixpKC69w+q3p6eG/N0nVBihgKuEodpICKl5fbALP9dXRjJMjcm7e0eslFgiFq/XxgRInVGQvbg
 f9XQhsOaJtfy7SoML8qN3k4idpYMbZHVlMcDRt5RAhrtyYkSP2/eKNQDrhlC9qARfts6ueXD8Kw
 UNY8SLumpMRroXJdxDI4C3CNGkrYD
X-Received: by 2002:a05:600c:4e0a:b0:49d:1fd8:b874 with SMTP id
 5b1f17b1804b1-49eb7325452mr7795285e9.19.1789534677833; 
 Tue, 15 Sep 2026 21:57:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0a:b0:49d:1fd8:b874 with SMTP id
 5b1f17b1804b1-49eb7325452mr7795095e9.19.1789534677505; 
 Tue, 15 Sep 2026 21:57:57 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-41-176-3.web.vodafone.de. [109.41.176.3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fe7esm3813626f8f.6.2026.09.15.21.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 21:57:56 -0700 (PDT)
Message-ID: <e22f13f9-5cfa-48aa-bc37-bb9bb2d1c5ba@redhat.com>
Date: Wed, 16 Sep 2026 06:57:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] tests/functional: cover the BQL watchdog
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-11-den@openvz.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260915203455.580999-11-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/09/2026 22.34, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> Hold the BQL from the main thread and check that the watchdog says so.
> 
> human-monitor-command is not a coroutine command, so a write issued
> through it runs to completion under AIO_WAIT_WHILE() in the main
> thread, which keeps the BQL for as long as the backend takes to answer.
> Point that at a null-co node with a latency ten times the deadline and
> the hold is both long enough to report and short enough to end on its
> own.
> 
> Arm the watchdog after launch rather than on the command line, because
> machine creation takes the BQL in bursts of its own and a deadline this
> short is meant for the hold, not for startup.
> 
> Check the quiet case too. A counter that stops distinguishing a held
> lock from a free one would report a hang on a healthy qemu, and that
> failure is invisible to a test that only looks for the report.
...
> diff --git a/tests/functional/generic/test_bql_watchdog.py b/tests/functional/generic/test_bql_watchdog.py
> new file mode 100755
> index 0000000000..193dad15e3
> --- /dev/null
> +++ b/tests/functional/generic/test_bql_watchdog.py
> @@ -0,0 +1,60 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Test the BQL watchdog against a main thread blocked on IO.
> +#
> +# Copyright (C) 2026 Virtuozzo International GmbH
> +
> +from qemu_test import QemuSystemTest
> +
> +deadline_ms = 100
> +hold_ns = 1000 * 1000 * 1000
> +
> +
> +class BqlWatchdog(QemuSystemTest):
> +
> +    def setUp(self):
> +        super().setUp()
> +        self.set_machine('none')
> +        self.vm.add_args('-nodefaults')
> +        self.vm.add_args('-blockdev',
> +                         f'driver=null-co,node-name=null0,size=1048576,'
> +                         f'latency-ns={hold_ns}')
> +        self.vm.launch()
> +
> +    def arm(self, ms):

Maybe it's just me (so feel free to ignore this comment), but when reading 
"arm" I'm thinking of qemu-system-arm ... maybe call the function 
"enable_wd" or so instead?

> +        self.vm.cmd('qom-set', path='/machine',
> +                    property='bql-watchdog-ms', value=ms)
> +
> +    def hold_the_bql(self):
> +        """
> +        human-monitor-command is not a coroutine command, so the write runs
> +        to completion under AIO_WAIT_WHILE() in the main thread, which keeps
> +        the BQL for as long as null-co takes to answer.
> +        """
> +        self.vm.cmd('human-monitor-command',
> +                    command_line='qemu-io null0 "write 0 4k"')

HMP has recently been made optional, you likely need a 
self.skipTestIfNoHMP() somewhere now to make sure that this test does not 
fail if HMP has not been compiled into the binary. See also:

  https://gitlab.com/qemu-project/qemu/-/commit/6a0195cd57b231c2047232c8

  Thomas


