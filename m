Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAB3E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 17:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL43k-0002uK-8x; Tue, 10 Dec 2024 12:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tL43b-0002tP-05
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:29:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tL43Z-0004CB-2U
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733851796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=71MbXDNVwJ5ZktUszK7FUCyFCzBhqiAN2mjyLYNV8mo=;
 b=SU2faCQN8LPlCzXyn3778bosMlrsoNmjnvJxovaVcSwFzChVoIny870DyrhZ1E00/ceL1s
 99a4UTpfX0klsi+NnpgUGfPeycKujtxxHGNefsmbZju2gzvagcDXr1z1Z20ennIJniUwk2
 1SbiUm9XH//r/gDM8GbQR8suebBdQKc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-4WVM_JsGO7WqqcZ9ca0Guw-1; Tue, 10 Dec 2024 12:29:54 -0500
X-MC-Unique: 4WVM_JsGO7WqqcZ9ca0Guw-1
X-Mimecast-MFC-AGG-ID: 4WVM_JsGO7WqqcZ9ca0Guw
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4674a45cfffso95583181cf.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 09:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733851794; x=1734456594;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=71MbXDNVwJ5ZktUszK7FUCyFCzBhqiAN2mjyLYNV8mo=;
 b=PBPlaMtWbUIafvPH5sPyUtqz8NRyP4GWOXizPeWQd1OzoOmVmGetrCKcboo8TX0T8p
 Mt5nRgVJ18T5QlKjCfBk72efAPDqkjEAS0K4ShOfdt9qV6E3cHjCxnvwoY8sAlytDWUM
 PvCNnds6xbBHucvmAenAAvUCWUwL721J0HRYxCsqaivgnvs9rpGluuNMumaXHmGa4IA8
 NM5y+hXbu0nAbW7z49GpOm1eI9snx0qIzC7UCP0tw5qQASSaWTl8vKoffrpitSmlfbWJ
 uOiPkTkmin+P/ly2OaW9YG+QHkrbxbOu7vL8LpjEtRm06qD+PeXR6M4JPgv42HnGoi3b
 1LpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2LQc3G+WMCy6pisUF0k/R41p0bw+YBfW3hMq1SyNuYN61cGp7d8fhOxoJl+pKxZE49oECKEVcLR+j@nongnu.org
X-Gm-Message-State: AOJu0Yz+8xygfYXRYJhn7iIiEe09c+BNBuToU+Mt8RGSjBYNAtGYkTNO
 7WU7jvlxWMqukKzd94k0Y9l0H4ZWci+LUNtq0VamqPms4oUAwtd/ty75PDehSSScm9YFPXbe65Q
 fgk915UnpFwVurzxSyclaBP6l5iJddKKubO+BY2paKjA1ZLM/89oz
X-Gm-Gg: ASbGnct+8ncc5JAau3KZ9e0udhZqqL9txMP4iQ8KNIeLKF4o4PrXBOSp9DfUYUMvHr1
 EB6p5MnyafAcAi31fqw9EUN64bYXr5a2QFoyB0w3Q03jFzbCsFn8iWIOJWCgN20on0zpY2uiS0v
 t0EMJTTSH6hg/uB9GK9B+vIXjkkvm9KpA3OYFilNKv/VkeOWz3NjimVzeSj9dumjCP6ev3U66ZC
 XBrL0ahceS0Eh1H1tsvFNAXw6PHggfL+Th2KwL3KxmXXVs2L3+F4ruTAlbszhMzFkl3Fsc2P6VU
 v5pQIj0=
X-Received: by 2002:ac8:7f42:0:b0:466:957c:ab22 with SMTP id
 d75a77b69052e-46771feb82emr93170771cf.43.1733851794212; 
 Tue, 10 Dec 2024 09:29:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnB1UztSR3gUFb1wEsRRI7De3JGIp+CrS4YqnpYQaoXFCzUnj8O9yNwKrsbNofB+TTMmxqww==
X-Received: by 2002:ac8:7f42:0:b0:466:957c:ab22 with SMTP id
 d75a77b69052e-46771feb82emr93170301cf.43.1733851793888; 
 Tue, 10 Dec 2024 09:29:53 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4676e091d95sm16633601cf.12.2024.12.10.09.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 09:29:53 -0800 (PST)
Message-ID: <ffe542bb-310c-4616-b0ca-13182f849fd1@redhat.com>
Date: Tue, 10 Dec 2024 18:29:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] crypto: run qcrypto_pbkdf2_count_iters in a new thread
To: Tiago Pasqualini <tiago.pasqualini@canonical.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com
References: <20240904235230.199672-1-tiago.pasqualini@canonical.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240904235230.199672-1-tiago.pasqualini@canonical.com>
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

On 05/09/2024 01.52, Tiago Pasqualini wrote:
> CPU time accounting in the kernel has been demonstrated to have a
> sawtooth pattern[1][2]. This can cause the getrusage system call to
> not be as accurate as we are expecting, which can cause this calculation
> to stall.
> 
> The kernel discussions shows that this inaccuracy happens when CPU time
> gets big enough, so this patch changes qcrypto_pbkdf2_count_iters to run
> in a fresh thread to avoid this inaccuracy. It also adds a sanity check
> to fail the process if CPU time is not accounted.
> 
> [1] https://lore.kernel.org/lkml/159231011694.16989.16351419333851309713.tip-bot2@tip-bot2/
> [2] https://lore.kernel.org/lkml/20221226031010.4079885-1-maxing.lan@bytedance.com/t/#m1c7f2fdc0ea742776a70fd1aa2a2e414c437f534
> 
> Resolves: #2398
> Signed-off-by: Tiago Pasqualini <tiago.pasqualini@canonical.com>
> ---
>   crypto/pbkdf.c | 53 +++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/crypto/pbkdf.c b/crypto/pbkdf.c
> index 8d198c152c..d1c06ef3ed 100644
> --- a/crypto/pbkdf.c
> +++ b/crypto/pbkdf.c
> @@ -19,6 +19,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/thread.h"
>   #include "qapi/error.h"
>   #include "crypto/pbkdf.h"
>   #ifndef _WIN32
> @@ -85,12 +86,28 @@ static int qcrypto_pbkdf2_get_thread_cpu(unsigned long long *val_ms,
>   #endif
>   }
>   
> -uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
> -                                    const uint8_t *key, size_t nkey,
> -                                    const uint8_t *salt, size_t nsalt,
> -                                    size_t nout,
> -                                    Error **errp)
> +typedef struct CountItersData {
> +    QCryptoHashAlgorithm hash;
> +    const uint8_t *key;
> +    size_t nkey;
> +    const uint8_t *salt;
> +    size_t nsalt;
> +    size_t nout;
> +    uint64_t iterations;
> +    Error **errp;
> +} CountItersData;
> +
> +static void *threaded_qcrypto_pbkdf2_count_iters(void *data)
>   {
> +    CountItersData *iters_data = (CountItersData *) data;
> +    QCryptoHashAlgorithm hash = iters_data->hash;
> +    const uint8_t *key = iters_data->key;
> +    size_t nkey = iters_data->nkey;
> +    const uint8_t *salt = iters_data->salt;
> +    size_t nsalt = iters_data->nsalt;
> +    size_t nout = iters_data->nout;
> +    Error **errp = iters_data->errp;
> +
>       uint64_t ret = -1;
>       g_autofree uint8_t *out = g_new(uint8_t, nout);
>       uint64_t iterations = (1 << 15);
> @@ -114,7 +131,10 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
>   
>           delta_ms = end_ms - start_ms;
>   
> -        if (delta_ms > 500) {
> +        if (delta_ms == 0) { /* sanity check */
> +            error_setg(errp, "Unable to get accurate CPU usage");

  Hi!

While running "make check -j12 SPEED=slow" on a s390x host, I got:

   3/657 qemu:unit / test-crypto-block 
          ERROR            0.27s   killed by signal 6 SIGABRT
 >>> G_TEST_SLOW=1 
UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 
MALLOC_PERTURB_=150 G_TEST_BUILDDIR=/home/thuth/s390x/qemu/tests/unit 
MESON_TEST_ITERATION=1 
MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 
ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 
G_TEST_SRCDIR=/home/thuth/devel/qemu/tests/unit 
/home/thuth/s390x/qemu/tests/unit/test-crypto-block --tap -k
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― 
✀ 
―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
stderr:
Unexpected error in threaded_qcrypto_pbkdf2_count_iters() at 
../../devel/qemu/crypto/pbkdf.c:135:
/home/thuth/s390x/qemu/tests/unit/test-crypto-block: Unable to get accurate 
CPU usage

(test program exited with status code -6)

TAP parsing error: Too few tests run (expected 27, got 1)
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――

Could we handle this more gracefully, please? I don't think that this should 
fail the unit tests, should it?

  Thomas


> +            goto cleanup;
> +        } else if (delta_ms > 500) {
>               break;
>           } else if (delta_ms < 100) {
>               iterations = iterations * 10;
> @@ -129,5 +149,24 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
>   
>    cleanup:
>       memset(out, 0, nout);
> -    return ret;
> +    iters_data->iterations = ret;
> +    return NULL;
> +}
> +
> +uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
> +                                    const uint8_t *key, size_t nkey,
> +                                    const uint8_t *salt, size_t nsalt,
> +                                    size_t nout,
> +                                    Error **errp)
> +{
> +    CountItersData data = {
> +        hash, key, nkey, salt, nsalt, nout, 0, errp
> +    };
> +    QemuThread thread;
> +
> +    qemu_thread_create(&thread, "pbkdf2", threaded_qcrypto_pbkdf2_count_iters,
> +                       &data, QEMU_THREAD_JOINABLE);
> +    qemu_thread_join(&thread);
> +
> +    return data.iterations;
>   }


