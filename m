Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AF7CD6E5F
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTnUm-0002Kg-SK; Sun, 31 May 2026 17:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnUl-0002KE-JU
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:14:55 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnUk-00054C-42
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:14:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490426d72f7so83046765e9.3
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780262092; x=1780866892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GC26qijtq+5/YjaYroUAqe0d2zUcLKKCmsBjOkkY6lk=;
 b=W4T2qvm1anH9XjbUcdxDMckaKBB2D9YqFMvAIF3/2qUT8mmZkEay/8mYRtfU68oA5K
 sFzPvOEfnZ4urxWMO3BjPBInYN7kiDp6VfvJc+I2P9l6Wso0XgsNYgMdskuv9+4GG6tv
 jWyccdXLroPI7as5WHNFYdWKRjNZoOoHSEPX6/iSowDbbKhGQWiunNhKasiI/MYCWuVw
 /mfa/S9QyMpdkXePBXi6yvQBJRbHY3G5hzFUZ+9e4r1uSB/GzeCX42yPeOU1rg6761Jx
 kUnxfoKya/W4oNPOvcz0Jz0FilW38qmQw8oADCDBanNz6lUDN2uK3lDE1fj8Wh1wKJ8Y
 EAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780262092; x=1780866892;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GC26qijtq+5/YjaYroUAqe0d2zUcLKKCmsBjOkkY6lk=;
 b=kchWJj55o5ai/30G7jftqBK3FRVXvfYqIJG3KKAKenkLh6A3a2IZMNObakp+N/idi6
 Psjio2vG0xkzHm+/6DqnUwJnb9os5xW7a1300Scde2HBZQ6Nn8In2AIOSYb8LjA180Af
 iGLROB5NxVk2WgT6+GUhGWxrwmxK+4sZApHyruqUIHOPmRQTINCbrkeQmh72xzt3Vu8b
 7ocBTbZNZtdKwzevjp6KVO2L7HSBJ3qjx3lUi51RcM8wLTijJQ/6zDfTuABrqnFx3zGG
 7P9Cvhoq2CrYQKuS67IBj2fXbD3xTRYIKcxUa1JYIs6AYW3WI+TRkrriObUIA6yCy3Zl
 aikw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sUVTubxnb/hBsUkZpgs0coXKPem/PAgQBXFRv8U9HLHqrO37QYHk5B0z92gfEnXB+7IMXDwQU/DDf@nongnu.org
X-Gm-Message-State: AOJu0Yy3Q2tiwlXd6/lZIMJku9anpnNc6oLp0mFF+f/V9aLZvofXkpDk
 6Hbuk4kGVusJa0SiDnhdIo/ACxDx3VeE4/tEQYQ8CBiyeVvcMeQlXgIffo1xigAkqeQ=
X-Gm-Gg: Acq92OHyt0H0INr6CK/qxzda+T9gdo2Ywr7IWMkQesnD12wraFInQ2ZYW7EepICqDU7
 mkluUmIAtVV9CYnwvuqxHeQ2qG6jogEYa4DyyAbOHxhh2JuKZ54Y0qZXXWt4xWLeNxjr97U2JsI
 ozSOuEsAQ/VbMG+6NHRrXiiYF/EdanN1inT2DDXkMosDspOOLExMlsxpcwTdT8NZ0c86hBGZUhf
 QklDBVVjFnfe95Eud9QwUxtAg0mYkaiWb8wXyP48i2cFJ2zX7sy/0p8Rh3Y/tKV8Q4uI+4S/A9K
 clZwwhoGqW8VItfDYkuPXB6W6X5mJ4DKQSa4WJSdx3WbcoUxY6cE7T9q3PJFe96EbdiTJuIGSYp
 woNyof2dE9hRYD1GdQjOhHMUXGm8O4KZiiHeeMotmhPTrPYhAmp82gVdvl3I3UKHoHOCY3+VDru
 YlD7u6fxOIP9rqiA8QgwFxbORBr5oxVB+8YLpoZ0Bqq/68C+dUN+r4Dkw4yo1phJcxNqZNy/t7C
 ogo
X-Received: by 2002:a05:600d:4453:10b0:490:6869:ef13 with SMTP id
 5b1f17b1804b1-490a2918e9fmr106300055e9.14.1780262092515; 
 Sun, 31 May 2026 14:14:52 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0f74fasm87954635e9.4.2026.05.31.14.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:14:51 -0700 (PDT)
Message-ID: <81922d15-a603-473d-b532-c52c3697b4ce@linaro.org>
Date: Sun, 25 May 2025 17:06:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] docs: remove legacy QAPI manual generator
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Fan Ni <fan.ni@samsung.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Igor Mammedov <imammedo@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Mads Ynddal <mads@ynddal.dk>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250522170219.58058-1-jsnow@redhat.com>
 <20250522170219.58058-3-jsnow@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250522170219.58058-3-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 22/5/25 18:02, John Snow wrote:
> Thanks for your service!
> 
> Remove the old qapidoc and the option to enable the transmogrifier,
> leaving the transmogrifier as the ONLY qapi doc generator. This has the
> side effect of converting the tests to use the new system, too.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   docs/interop/qemu-ga-ref.rst                 |   1 -
>   docs/interop/qemu-qmp-ref.rst                |   1 -
>   docs/interop/qemu-storage-daemon-qmp-ref.rst |   1 -
>   docs/sphinx/qapidoc.py                       |  25 +-
>   docs/sphinx/qapidoc_legacy.py                | 440 -------------------
>   python/tests/qapi-isort.sh                   |   2 +-
>   6 files changed, 2 insertions(+), 468 deletions(-)
>   delete mode 100644 docs/sphinx/qapidoc_legacy.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


