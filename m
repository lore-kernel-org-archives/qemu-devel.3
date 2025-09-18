Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C5ACAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 13:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzEGV-0006YW-Qs; Thu, 18 Sep 2025 09:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzEGU-0006Xt-NJ
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 09:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzEGT-00063i-2C
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 09:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758200491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LM/c6M6JwMjwwJVV0h1DsTYreg7ozLVnlbm5dmxWV8Q=;
 b=JVOtFvzbhxA8vQYxurAxzqGFtZBBFTZZfM3bmaDBwUklyCC3VQWaTFtKrpz9AQc+RzfWq2
 BIkkmqOc9de6elpWo6NsUev6entvu6oOUbWqICckG/vD/zkjGi5iS1nXaFmpsc/gbqi+nO
 SpRFx1dXmvyz3Q9d7viacNuihICCgQc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490--O8eIl7QOrCuwRBR9hxYfg-1; Thu, 18 Sep 2025 09:01:30 -0400
X-MC-Unique: -O8eIl7QOrCuwRBR9hxYfg-1
X-Mimecast-MFC-AGG-ID: -O8eIl7QOrCuwRBR9hxYfg_1758200489
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b467f5173so8237325e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 06:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758200488; x=1758805288;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LM/c6M6JwMjwwJVV0h1DsTYreg7ozLVnlbm5dmxWV8Q=;
 b=AI2WYM6SnbiXoqZzUxMOHLhUC90mUtsMKyxUD3xymshGXBnsKCguwqTW7B/lyAcEmw
 2WE52PtNmwsQh16SXSz9bdVOiDVkXXw5bde90mymzp4u/tqkx1LMvE7vM4ZDjNpmTn3U
 C01oLyPLNEwk6HtPS+pw5HRvWSN1Yg5jQ6zMov1E1uZIHzrJYl9GhckSmXz+zEK+5BLg
 o/bG9UnzAUTu3/4lhto3X35zRbHOxrD46GfU6tfQIUCUo2zgSTJBKHln3sajx1mQCKMK
 Wg+PlrMxKSpnvEgQZD9u3He10vzPvrXce0TxQRPzjNnL7x3eB84DOPHuBKnpTLY4YhUM
 O0hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdWi5M1AiGE+4LxWzAky+ryA+yQjJSfj93znCByz/+JJHDUkKqApO2IpS2fA9myCwWhNz0Xp/DygAg@nongnu.org
X-Gm-Message-State: AOJu0YyFycdNNMVe9vJGsl/iLtsQuEpzlZp2Iq7O/qpIE7jia+nYxIq5
 adlHT4olDlCnNTuLjIwScCQcELTrwXITjVPxsbKEXEDIKfG0UPgC+eUZHRGqSJ8wPbU5lT5dcmm
 d+/A4TuzyypAVx4y2y5j8Q7c93frs+D4OzA9o6Fl7JNN8vcmm2ovVBr2o
X-Gm-Gg: ASbGncuiVDE/LY/8QdsFiqnxFvdd5Pe0CogKtv8Uj0+VAFYmIu5FlQe2GwVFBQdE25F
 kZHR1m3UEW0mgt46P150JDDOdFNTWM7k0R0BgYHaib/AHseq45GLxHHirqP5bZC9Ir1jOjPjREn
 4o8NJC+vL6REEkHZ9NYtYGQErUWCKOjGplI4cv/QjKp9xsWq1CWTrPUAmtyTUai4qNBXnrFkHKr
 6rcRWjTPfFlmtPigS3gMxnfMyoOt0lykzPKv0i8PR/X+9FyYifORZezrvtUfXkCGIB1blAOc7mc
 sNXOWZ0Lyq4SNXabnx/0ENJ7IbtJ/hnV8YjxwuF6Gp+Tw0iKvF2kydT/eUMBekAXyP4fQ7dsQxv
 YUmXkyw==
X-Received: by 2002:adf:eec6:0:b0:3ed:c9c0:73ce with SMTP id
 ffacd0b85a97d-3edc9c074dcmr2265486f8f.32.1758200488053; 
 Thu, 18 Sep 2025 06:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbi5zs4FC7Ajto0gd4k3e73tDvkMpnRGUy3Vu7vQHhRNsijRgRn0VrGlvFac0per7lTa6wXQ==
X-Received: by 2002:adf:eec6:0:b0:3ed:c9c0:73ce with SMTP id
 ffacd0b85a97d-3edc9c074dcmr2265447f8f.32.1758200487416; 
 Thu, 18 Sep 2025 06:01:27 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee141e9cf7sm1482565f8f.12.2025.09.18.06.01.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 06:01:26 -0700 (PDT)
Message-ID: <c42b22a2-31d1-443c-952e-e8439f333e45@redhat.com>
Date: Thu, 18 Sep 2025 15:01:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: treat unknown exceptions as
 transient faults
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20250918125746.1165658-1-berrange@redhat.com>
 <20250918125746.1165658-3-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250918125746.1165658-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/09/2025 14.57, Daniel P. Berrangé wrote:
> To maximise the robustness of the functional tests we want to treat most
> asset download failures as non-fatal to the test suite. Instead it
> should just skip the tests which need that particular asset. The only
> time aim to make it fatal is for 404 errors which are highly likely to
> reflect genuine problems to be fixed.
> 
> We catch certain exception classes and handle them as transient errors,
> but unfortunately it is proving difficult to predict what exception
> classes urlopen() is capable of raising, with new possibilities being
> discovered.
> 
> To provide a fail-safe, treat the generic Exception class as being a
> transient error too. This may well mask certain genuine bugs, but it is
> preferrable to prioritize running the test suite to the greatest extent
> practical.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index f8b87d2153..2971a989d1 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -188,7 +188,8 @@ def fetch(self):
>                   continue
>               except Exception as e:
>                   tmp_cache_file.unlink()
> -                raise AssetError(self, "Unable to download: %s" % e)
> +                raise AssetError(self, "Unable to download: %s" % e,
> +                                 transient=True)
>   
>           if not os.path.exists(tmp_cache_file):
>               raise AssetError(self, "Download retries exceeded", transient=True)

Reviewed-by: Thomas Huth <thuth@redhat.com>


