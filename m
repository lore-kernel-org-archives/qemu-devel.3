Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E76CCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 07:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLG8e-0001kv-Dt; Tue, 18 Nov 2025 02:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLG8Z-0001kI-AM
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:28:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLG8X-00070e-92
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763450904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wGpupxMGnNcGjuuvqtXSaPbOS7efqiPqW69FMlPt8ds=;
 b=Ibau+wfzK2GRa4FXFlktCJyMQCDNffyZt9HWfxf96UWZndmdDWJm5mrkTRSWmkCsW1aiLG
 c9DVbycn3SiGPmxYXsN044fd4g7TS3mSOfzJIFRkDzxhrcrMplWX73PeC6kRj707U+Ba4Z
 PsRODBZ8fxuzm0Lb/M9H0ZX0KDSqfMQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-zpcPJKTUOf6-mlJ8HEwd3A-1; Tue, 18 Nov 2025 02:28:22 -0500
X-MC-Unique: zpcPJKTUOf6-mlJ8HEwd3A-1
X-Mimecast-MFC-AGG-ID: zpcPJKTUOf6-mlJ8HEwd3A_1763450901
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779da35d27so19185195e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 23:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763450901; x=1764055701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wGpupxMGnNcGjuuvqtXSaPbOS7efqiPqW69FMlPt8ds=;
 b=OS1KnEMTwhtk28o7DqeiIDEXfygBT/uElWb0XjY8WN7fs9SudhRoDatUlFGILi/3Ss
 ugE1KOP571SZxXb/wTY9OyTuxtWezyc/NwFbz6rJxp0mQyolbW8XRQDTcMzX4TeuGzHA
 EDU52wT8dQO1+KmCfLZIbrnIiH+eF3YM2sVnmbPSPQa40qjWM+QXfsGBCPqUBcAriAaz
 s6geADNkD+o1PyWOIYGWsU07et/aP1Ph/ww+Z732NJA1TjvOSQvC57Pk/vDnMTosjuPI
 q1l1Qmz+9wHG9pozpdX8m5QEZLWXNmWiuDkpFf8i7OkDFol4w6VfWw5pFIHpdbyqEd/G
 E5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763450901; x=1764055701;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGpupxMGnNcGjuuvqtXSaPbOS7efqiPqW69FMlPt8ds=;
 b=GxEVqLGsYFN+Mkn9DU6PWHVfq0LIbGa+rPKQyGfeGLbl/e2u0B+22MgnjKQfKK8g03
 rvXl3tXmcymbX7uR8j3FUQ018ImscZvq/yIeQhFsCsTH+VQJi+nWKad/94g8uDbH9zZY
 M2AaT0KAf47s4hnBIx/X3E+VFQTYKZ2lBB0e80U73nC7/jAnZDhL1EmSSOTUyhSZ6cB+
 0oRAli8PSI6qH6kMuFWPe8ohN900XqGXojAPhvW3l55BRHSXRW6SRCcbHrBq572OuULf
 9ivzGpCpq+k4bAiFuLm9M//wijKMTiDhvyojCbiHGcSz0WDFkwU3JNUmGf8Ez4JnpBNk
 kWZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg2edlOLJbbPaEeX57lQy5SktDtvD9UeM+mF+qIY2rROZD3621J0fGfngc+t7VOYqbVrVPmtD1qPJd@nongnu.org
X-Gm-Message-State: AOJu0Yx6FXhZNNwij/Yu8VjCe91SyHh7QCpMH5FxfCBwQULBGeAFj0FM
 NyGRyOShaJrf9pmZPbljrJ3XElrDwBT+5MnNANjtLM2AZXOC9Qg2WJlmmWb43YiVyNNADL0KfqT
 H6c658mjA94y6Ci29M1aqJkM25Y0XPQd/KMLk5nFazrN+ywmiXk0yATE2
X-Gm-Gg: ASbGncu5s7uA4F2yepL1drw0TxJcIp97BIq3Bt/WKv9E8xnZaFjtquldxv3HYWuzCL2
 nPxzrS7CCgfivaCjv9WnEo16v1Iv4EVTqaCcNhZ8ahbDVWJAWN4+8Ux+UesK68iiXED1hIFB8rQ
 OlV/AdjXgWEV6GSUWpokKBWwYjr8Jfj3duE+bokOzE7D0aonHdP3L5xTtH56nJfG3d1JCvmwG1x
 Dud1yEF5ST0oFBVChM5odKKpmdvsbqiwyHGtWTJgzZqq1dm6bcfsLtO5suLA4qCuPJGT/KBsz/F
 RL+NqzYp3AfxHWb+zS3yzUFn6ua2Gz3+U1I+WqwzoVAIkGDsLBzjeWdROt+VqcaA9qyt8BknhwO
 whEjXMpQ=
X-Received: by 2002:a05:600c:1986:b0:477:28c1:26ce with SMTP id
 5b1f17b1804b1-4778fe41be4mr133978375e9.7.1763450901034; 
 Mon, 17 Nov 2025 23:28:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBxIRjtmRgli6x4FPtIWeyqAKfsaMirXZL0GLIbTnW1BdJtaRajgNpsQmRJA3Dzy0/sOOxQw==
X-Received: by 2002:a05:600c:1986:b0:477:28c1:26ce with SMTP id
 5b1f17b1804b1-4778fe41be4mr133978115e9.7.1763450900596; 
 Mon, 17 Nov 2025 23:28:20 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e442c2sm357437635e9.7.2025.11.17.23.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 23:28:20 -0800 (PST)
Message-ID: <838dee9e-0bae-4ac5-b524-3c3b93c5eeef@redhat.com>
Date: Tue, 18 Nov 2025 08:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] python/qapi: add an ignore for Pylint 4.x
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-3-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251117185131.953681-3-jsnow@redhat.com>
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

On 17/11/2025 19.51, John Snow wrote:
> Pylint 4.x wants to use a different regex for _Stub for some reason;
> just silence this.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qapi/introspect.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 89ee5d5f176..7e28de2279a 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -59,7 +59,7 @@
>   #
>   # Sadly, mypy does not support recursive types; so the _Stub alias is used to
>   # mark the imprecision in the type model where we'd otherwise use JSONValue.
> -_Stub = Any
> +_Stub = Any  # pylint: disable=invalid-name
>   _Scalar = Union[str, bool, None]
>   _NonScalar = Union[Dict[str, _Stub], List[_Stub]]
>   _Value = Union[_Scalar, _NonScalar]

Reviewed-by: Thomas Huth <thuth@redhat.com>


