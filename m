Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B178C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhxJ-0008DR-Ht; Tue, 15 Jul 2025 11:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubhNA-0001uV-M5
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubhN8-0004nq-Nt
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752592509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cJ9tC2RvqxHVufNnGh8NQMVUHDL8vrqcOlS/Qi4iQZ4=;
 b=IjMuTyPvj6fv4YaoyumhVe7qMYy1GDQAKd2yXqFG8SvtBQxvUXMtXfGPq3dHJTG7KgZ5IJ
 SXg8Uz2bgkB5mc6IAPYp0zFYpQZpH8aaWfa5OsQ9+hZRLIAn4dKu75WKHZ/tM8uhFTocE3
 agxAqbagFHblWXunila8im7XBU2XH+s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-ItkKccISOsurVaWVcYBTtA-1; Tue, 15 Jul 2025 11:15:07 -0400
X-MC-Unique: ItkKccISOsurVaWVcYBTtA-1
X-Mimecast-MFC-AGG-ID: ItkKccISOsurVaWVcYBTtA_1752592507
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45597cc95d5so22383545e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 08:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752592507; x=1753197307;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cJ9tC2RvqxHVufNnGh8NQMVUHDL8vrqcOlS/Qi4iQZ4=;
 b=tw3wgocMkYx8LCQwPp8xEsamczgCwSs2kvGmf28o+wkoaUpN/x0Ps7o6ReoUZ3kvfp
 CuEFfBEoaeB+5CU2v7TfTKniprdEdbVuiyDKRlWOyKG0tRv52S8QETy6/a2upVKKJT5M
 occLGNBjlVZt2eZ3YR41gTpYrhVi7mOzqpuviD+rtj5hNAI2Y6Mx6NdLJLjKGfIrFpb8
 0QtCDu9/gKyezdEnAI76CM55NO1WYEsgmMEEdOKjBhTlJl7EgpCUvmHzXrdeBMwBYJOx
 dEGV1UouHInMlabG084J0sH8AbzjOgsjyjhb9g0bgcKv7EELwdy1mNuM1ddyJJPr4wRa
 DGyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWCC5FXR60BxWjKRCSEYS+UxR5P++LBycEzektGrWSYddAfy+umhH+xZaSv3BOAKHVX/QJ/5nqLvft@nongnu.org
X-Gm-Message-State: AOJu0YyVld0S9PXy5oW+ld24CbYnNY4SwgBhBPtnUeD+1hmD5LyIFSna
 3PeRGCvU5nJ8JjQVbUjnmBmBKAn10JyG4ckzlRlUqrnf8LBNSL1YTogh9HZkFHrq638Tdj6lTel
 YQXDZmtMuteMCKZ2n2tzhDs0HvAbnnY/YxxnHO1H3K6SZ2aXcP7wOPzM+
X-Gm-Gg: ASbGncvu9ETkbaAGq2HqGG5ucbIuvtLJZsZpuPdPFjjFYfQ6TvSIapxp4G6qPeABuio
 0n9fDFeqhY8mbHdB1VuJVBGIt64Iipz6MQ1JUiI/a414pGfQnClvhCfJI/BN17p1+gLt7YDA9Zc
 LGXvYJzfPfFpBVvwRDvjxZlqyteXq1J2aBL5a55PvFb6JNO8Q3qv6R3SkzU+liIhnQK9T5URj5J
 7XgiLuP+BZwYHdTQKmXAMLURYaiZ72vcj/CDCwL3TKjMzZJ9QBABIHhajFMriYQ7IzqPzFuu2Gq
 REMWkqxLFZc4D4D3amZH0tbyNw0XWxqTLcshtLJv5Am2hHcqG6cZt1mPL5S/qNZAoJ+kaacjKql
 3iGjE
X-Received: by 2002:a05:600c:46d1:b0:456:e98:9d17 with SMTP id
 5b1f17b1804b1-4560e98a5ccmr108136705e9.5.1752592506724; 
 Tue, 15 Jul 2025 08:15:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjETUo8bGNevG6doonp9aEeJL+Zr4FSNfaYfZTlfU8urXjKSXTaPshUkBE+a4mmRLORT4e9w==
X-Received: by 2002:a05:600c:46d1:b0:456:e98:9d17 with SMTP id
 5b1f17b1804b1-4560e98a5ccmr108136225e9.5.1752592506189; 
 Tue, 15 Jul 2025 08:15:06 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-130.pools.arcor-ip.net.
 [47.64.115.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560f22cd29sm93650345e9.34.2025.07.15.08.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 08:15:05 -0700 (PDT)
Message-ID: <05525b99-030b-4e6e-a7b2-c2086a799d33@redhat.com>
Date: Tue, 15 Jul 2025 17:15:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] functional: always enable all python warnings
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Jagannathan Raman
 <jag.raman@oracle.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-11-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250715143023.1851000-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/07/2025 16.30, Daniel P. Berrangé wrote:
> Of most importance is that this gives us a heads-up if anything
> we rely on has been deprecated. The default python behaviour
> only emits a warning if triggered from __main__ which is very
> limited.
> 
> Setting the env variable further ensures that any python child
> processes will also display warnings.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 71c7160adc..2a78e735f1 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -19,6 +19,7 @@
>   from subprocess import run
>   import sys
>   import tempfile
> +import warnings
>   import unittest
>   import uuid
>   
> @@ -235,6 +236,9 @@ def tearDown(self):
>           self._log_fh.close()
>   
>       def main():
> +        warnings.simplefilter("default")
> +        os.environ["PYTHONWARNINGS"] = "default"
> +
>           path = os.path.basename(sys.argv[0])[:-3]
>   
>           cache = os.environ.get("QEMU_TEST_PRECACHE", None)

Acked-by: Thomas Huth <thuth@redhat.com>


