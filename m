Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F484E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 06:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLGKU-0005GR-5B; Wed, 11 Dec 2024 01:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLGKG-00050o-Cw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:36:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLGKC-0000Vl-Av
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733898955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mwwII47FzMH3c6sdP6KixaDvcq0h43mBlBIhqiZ1WHs=;
 b=E3IiP713xLAkwvtk4+0AUYEwHZxLm9nyi410q+y9s8JG06SwJ0ri56rmnlNQWQTdQmQeQU
 YM2Adx3u+BVvHxQlvN5v4+4SeovGYgkKJwa6uhu90b8mKKxt8f7yqYlPMzG6YN/XAlW+jd
 5Q+DeQI4jCrdPfFKdjEBLnQxMOqqsDA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-09bRY3yzPeSPbTHtMVhfyA-1; Wed, 11 Dec 2024 01:35:53 -0500
X-MC-Unique: 09bRY3yzPeSPbTHtMVhfyA-1
X-Mimecast-MFC-AGG-ID: 09bRY3yzPeSPbTHtMVhfyA
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa6732a1af5so17701466b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 22:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733898952; x=1734503752;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mwwII47FzMH3c6sdP6KixaDvcq0h43mBlBIhqiZ1WHs=;
 b=YnE86rNuGmYd/SsZXbgPM3HQPFAre/kNK5dkkAALH+SuXpwYs1dasWY+Cf1j3UuTul
 E5C1eVyB8pzJ5aTW+ijB/AUf8algXz1V8CALl4jq6T/Hx+o+0eEUVzfP5DHc0Nc0uvSK
 6tqXIBKMvYmSVbfgp8aeZ4EU3HXJMp+NsPeSmR6GmwBISKKSp2EzjK3BAgQyHYyzSh1K
 vDOslUzLJiuvezhQaZ9//n2lkEhLfGiCaKffCC2aTboA0mdYMEwBf8x8Rlvsm2ouUR6l
 TXhDfJ/37x4cebeGTRABTRlfyfZEeqFX3eCCgqWnOr9yLXw0i+yWvvUUBJZEKQWrD5Kd
 3uLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrXjeIlBOVi6EqtMQAotmTucISwSV41TWLGV0hCm4+dy/lZQgzUFEo9jrHRdeKA2tJqaiVl0ryLRjN@nongnu.org
X-Gm-Message-State: AOJu0Yx7uj/RtPpe2pDSTD0JjWxX7jY2mE5s1ve2XCoBYUaKqnieXi3M
 fNWCBjTvQ9iZqx05PkcKEmMWEkb9PUIYBcUC3gg3ekbMY4iWC+MhxwBX8OMcXVp9D5qvmjwWZR9
 ID2vN2a58ObVPzkttdPvXleENgmkJJf2IOw2meweUEBySMH9dXO6A
X-Gm-Gg: ASbGncuFt4/0KkOTZDMFQGyYHNfmFMwGJUWNLRl5XmtSLrMQbVui99YmizYVYg3UQ4i
 LCyzATqKkIp3L5CGlABESEhM+gL6g381TjLTklAq0LWpzSuDG5DUD2wUEfw2QaOp/wz+rMXKMr5
 sUXAwr0RdSZbL/7/zQrRrJNYUggYyNmuVNCQpx0qCYltuIpXlrVZ12a52mfCiRtgWyv8iu3jC5N
 pm5QxljWSMzyX4qBB3ZfURsgWwzA/zdQ5TfumtbfBdFSPhB8wRZf2WRz3ne7IA7EzffxOKyYj1Z
 SqfWhzg=
X-Received: by 2002:a17:906:9d2:b0:aa6:8520:718b with SMTP id
 a640c23a62f3a-aa6b13df104mr128411166b.56.1733898951897; 
 Tue, 10 Dec 2024 22:35:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPDRytx+OCplNRZaojW+UEBhohTLgYRmcJ2b4g60OKoGa8+cwhuWENmzx3gTMj24dSjGCyWw==
X-Received: by 2002:a17:906:9d2:b0:aa6:8520:718b with SMTP id
 a640c23a62f3a-aa6b13df104mr128408766b.56.1733898951489; 
 Tue, 10 Dec 2024 22:35:51 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67f4c4ae4sm469717066b.111.2024.12.10.22.35.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 22:35:51 -0800 (PST)
Message-ID: <cd066448-3224-4517-b48f-c98c10b99304@redhat.com>
Date: Wed, 11 Dec 2024 07:35:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/20] system/qtest: properly feedback results of
 clock_[step|set]
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Eric Farman
 <farman@linux.ibm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
 <20241210204349.723590-19-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241210204349.723590-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 10/12/2024 21.43, Alex Bennée wrote:
> Time will not advance if the system is paused or there are no timer
> events set for the future. In absence of pending timer events
> advancing time would make no difference the system state. Attempting
> to do so would be a bug and the test or device under test would need
> fixing.
> 
> Tighten up the result reporting to `FAIL` if time was not advanced.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2687
> ---
>   system/qtest.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/system/qtest.c b/system/qtest.c
> index 12703a2045..d9501153a4 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -78,6 +78,11 @@ static void *qtest_server_send_opaque;
>    * let you adjust the value of the clock (monotonically).  All the commands
>    * return the current value of the clock in nanoseconds.
>    *
> + * If the commands FAIL then time wasn't advanced which is likely
> + * because the machine was in a paused state or no timer events exist
> + * in the future. This will cause qtest to abort and the test will
> + * need to check its assumptions.
> + *
>    * .. code-block:: none
>    *
>    *  > clock_step
> @@ -710,7 +715,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>               qtest_sendf(chr, "OK little\n");
>           }
>       } else if (qtest_enabled() && strcmp(words[0], "clock_step") == 0) {
> -        int64_t ns;
> +        int64_t old_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        int64_t ns, new_ns;
>   
>           if (words[1]) {
>               int ret = qemu_strtoi64(words[1], NULL, 0, &ns);
> @@ -719,11 +725,10 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>               ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
>                                               QEMU_TIMER_ATTR_ALL);
>           }
> -        qemu_clock_advance_virtual_time(
> -            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ns);
> +        new_ns = qemu_clock_advance_virtual_time(old_ns + ns);
>           qtest_send_prefix(chr);
> -        qtest_sendf(chr, "OK %"PRIi64"\n",
> -                    (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        qtest_sendf(chr, "%s %"PRIi64"\n",
> +                    new_ns > old_ns ? "OK" : "FAIL", new_ns);
>       } else if (strcmp(words[0], "module_load") == 0) {
>           Error *local_err = NULL;
>           int rv;
> @@ -740,16 +745,16 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>               qtest_sendf(chr, "FAIL\n");
>           }
>       } else if (qtest_enabled() && strcmp(words[0], "clock_set") == 0) {
> -        int64_t ns;
> +        int64_t ns, new_ns;
>           int ret;
>   
>           g_assert(words[1]);
>           ret = qemu_strtoi64(words[1], NULL, 0, &ns);
>           g_assert(ret == 0);
> -        qemu_clock_advance_virtual_time(ns);
> +        new_ns = qemu_clock_advance_virtual_time(ns);
>           qtest_send_prefix(chr);
> -        qtest_sendf(chr, "OK %"PRIi64"\n",
> -                    (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +        qtest_sendf(chr, "%s %"PRIi64"\n",
> +                    new_ns == ns ? "OK" : "FAIL", new_ns);
>       } else if (process_command_cb && process_command_cb(chr, words)) {
>           /* Command got consumed by the callback handler */
>       } else {

Reviewed-by: Thomas Huth <thuth@redhat.com>


