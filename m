Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF72CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 06:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDGJ6-0000yk-A9; Mon, 27 Oct 2025 02:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDGJ2-0000qA-RQ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 02:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDGIx-0003XK-6b
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 02:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761544921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FVIpKJ0ZQdga10anyGfvciZy4tdq+yEL28P8kQ3jiZA=;
 b=AsI5RbUOtIBkLBQnZJbVO5LRCo7XsMaun4cnfCzJ5G66DzNWtXCmrQIIL/t/9S+AJpSS/r
 v71Q3YTS2sslqhE+VRkUAd6drNFXfnbe2wv3+yu0urrofnCTrkch3b//8b5Avj6ROXCkZB
 0+B9/DWS4qTej7QEf7PcsChyri2UPcA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-hkj-_AWsN_-5OqAi9BjJEQ-1; Mon, 27 Oct 2025 02:01:56 -0400
X-MC-Unique: hkj-_AWsN_-5OqAi9BjJEQ-1
X-Mimecast-MFC-AGG-ID: hkj-_AWsN_-5OqAi9BjJEQ_1761544914
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-476b8c02445so14206975e9.1
 for <qemu-devel@nongnu.org>; Sun, 26 Oct 2025 23:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761544913; x=1762149713;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FVIpKJ0ZQdga10anyGfvciZy4tdq+yEL28P8kQ3jiZA=;
 b=f5GhIaNW21i/XXjVKfooR227TrZIDG0rsLIrrIBaConbdLimuoKph8oenhDUCupTIF
 BXisHc5qMYb2lxWMGzM0Z8+pGjDWD3FFRWbQMnuYyZop+t/5/mX848GaTj7K6U4Z5ubm
 N7b07CWHkiKrGmuL6+cNQGplqPCwE6yNQcbECpSlnyjKVkx6BpXtPXITkFxwKawCLm4e
 z7XlcB/2iRoVbZrkmJUzQS+LQrAvPdInUk6JoYsnJtQ1u5CJ7cg4HjV4uZITVTRF/GEx
 dSMAD04DnSGErxv9kToBW7Yfmc6BVvCOEdVgaH8jg7/8qpk26EkO1iZP7/ps9VB1J3Jy
 6zcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsPRi4B3qqxVbvVnLs4MWo0Wg7mKwjWYrW6zjVa7PTNjaXwhtzweFQTWiYeMnKqWdTe6BO1k00bNsu@nongnu.org
X-Gm-Message-State: AOJu0Yxo8kIyOLmrjOoqZt9cS5222BFnOsCm2cUJdiwBepc2UqatVCMe
 YWKaDYLhpHwTTn73WC8TEL7Yl2LofmkvmfrnnH0SU+E/NYzG/qZtcGpERSdwn9Xxqa6/FXlIUKw
 pcAAA1Z1pVrywGA9PeqEwxo338xWkiMW0VZaJWmQVz9uP7ICOUvR1ANQu
X-Gm-Gg: ASbGncvhaJ637zUDweHXEZEk1KhO84m5QHW3PIILINR7DnCEI8pTayzuj8VkPRXYReO
 /zmXwYR+5EHjrb9YGFL/SIHXJsxOiwEPBpn6ddyxYi4Odn00dLMpQovbtuZ5QH4bsGeygmlfgQu
 q+M4AMUPJSZBJPteY+4utb84L31FGXXmG/dNIGgXwL30ELmQ3aFrq+PnmU+xgoZnVdkWDw83Iz3
 twRe3LW4oq6fouZHvBvAV6FqxUEiuFCx9cD1s95lcYjnpMg7PNL7bNY8R9MBVbSa4kJZtxYu8m3
 SP2cMAmh4LGc9q6ifhr/QxEUxn2Ba85WIjDCL5/eFLOVN0AJnAZLz3+NO/y0jY/mtlHYiZtl7jC
 EC1BYCskAgr8p5zXzuPhzjjnsbVFhZEpIQNUZnuM=
X-Received: by 2002:a05:600c:6094:b0:477:1326:7b4b with SMTP id
 5b1f17b1804b1-47713267bbbmr6807865e9.19.1761544913107; 
 Sun, 26 Oct 2025 23:01:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJb33BJEzIzefMiAc87nuL7O+OEzdAtkOP+o0l5zR4g7I5eJ2J+nDHJ+KtW/tQUk2OVXIXLQ==
X-Received: by 2002:a05:600c:6094:b0:477:1326:7b4b with SMTP id
 5b1f17b1804b1-47713267bbbmr6807625e9.19.1761544912678; 
 Sun, 26 Oct 2025 23:01:52 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-081.pools.arcor-ip.net.
 [47.64.113.81]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd494d5csm117453685e9.9.2025.10.26.23.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Oct 2025 23:01:51 -0700 (PDT)
Message-ID: <8e332026-49b6-4389-bbc5-5713d8f3cc1d@redhat.com>
Date: Mon, 27 Oct 2025 07:01:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional/.../testcase.py: better socketdir
 cleanup
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
References: <20251025165809.930670-1-vsementsov@yandex-team.ru>
 <20251025165809.930670-2-vsementsov@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251025165809.930670-2-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/10/2025 18.58, Vladimir Sementsov-Ogievskiy wrote:
> TemporaryDirectory prefer explicit call to .cleanup() (or
> use context manager). Otherwise it may produce a warning like:
> 
>     /usr/lib/python3.10/tempfile.py:1008: \
>       ResourceWarning: Implicitly cleaning up \
>       <TemporaryDirectory '/tmp/qemu_func_test_sock_4esmf5ba'>
> 
> Currently, the only test using socket_dir() is
> tests/functional/x86_64/test_vfio_user_client.py, and it does
> print this warning, at least with python 3.10.12. With this commit,
> the warning disappears.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   tests/functional/qemu_test/testcase.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 2c0abde395..a122acb560 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -233,7 +233,7 @@ def tearDown(self):
>           if "QEMU_TEST_KEEP_SCRATCH" not in os.environ:
>               shutil.rmtree(self.workdir)
>           if self.socketdir is not None:
> -            shutil.rmtree(self.socketdir.name)
> +            self.socketdir.cleanup()
>               self.socketdir = None
>           self.machinelog.removeHandler(self._log_fh)
>           self.log.removeHandler(self._log_fh)

Reviewed-by: Thomas Huth <thuth@redhat.com>


