Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B465EE7DF16
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 18:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmyGM-0001hg-Dt; Mon, 02 Feb 2026 13:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vmyGK-0001hS-Ti
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 13:03:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vmyGJ-0000Q4-By
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 13:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770055378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4B3KeeCQxLYPVjUccYfLTgm0JJojw4O2H3f+tzwFwiE=;
 b=Hm516yV/xoTxoOAFhECqOg/bIMnJKGPkGoGIFqBvB6lEf8LkKabfG0tEe7wDAx1zht1xkH
 q192EAhNfedYceK3EFg8DeR+4evHp+xdN8wjeSYaKwX9eseMvkNnnHBVMXGC/o2c00pN+4
 IqKw+gx4DoQOdEby5ceVaHa293H4mLQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-1tnemoLzPQK0KsufC7aASg-1; Mon, 02 Feb 2026 13:02:57 -0500
X-MC-Unique: 1tnemoLzPQK0KsufC7aASg-1
X-Mimecast-MFC-AGG-ID: 1tnemoLzPQK0KsufC7aASg_1770055376
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430f5dcd4cdso3947101f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 10:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770055375; x=1770660175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4B3KeeCQxLYPVjUccYfLTgm0JJojw4O2H3f+tzwFwiE=;
 b=txONZZ3+wciycXmRpHRNOJ7cMnMFY2SXdZKT5XbpPB7lDRdXNdUVk0NNZGtlcCu1Xb
 QhZ0ig0NcU77AJoAd+32YCHxk1LPnGC5Neox4revAM3NV9B/zZxFS/0EvLw/dJOfIu2/
 VBYhMl72uI6pnBzEoSVt53KEe9pLmMhibglBVzk/6iKe3HTNPqjveeqGsaPo3MSaV2jM
 a8VlvdYwKba/DxDnySG1gXGQGWu6z5cBBhzS5RNZa3HyM6k57CiAN4P6xCGjbEGkWW5d
 s9dmzgcQBlEGKPAIce39hIA5swUMxWIIwBw1yOLleWq6aE/8ONqY5lYsa19Pv43wqnLD
 Xzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770055375; x=1770660175;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4B3KeeCQxLYPVjUccYfLTgm0JJojw4O2H3f+tzwFwiE=;
 b=AMgdus4miQQVyn1ghAMO0KcS59IArlRGgLpbxqVd7Ro2oq3OM8wDT+UUx4u0YZjW7J
 BJQFQ3mntTma1xl9zOYz9w9+giwv5FZIMTwI8GhVIo2yu3h5H1VzoJmSVimEed1qqdMt
 BsBFIEGO/4uv8CjgeCUaNCU64mN7pUygcWvT5DqL3JeaZUfIwkA76e8eDcsbHHFMLwOC
 jgtw9e4V6xWsrVOpwHogfkJNUpTgD9PP28koQwuerjya+pQgXGQ6vwtjIJpeeT+G+7/D
 txOGuC7Nvj1nsoYdGsOu4wOS5hj/zksyLunhGWlrEpjb+XqTwbhp5Oj7E3OGBbsX31p9
 jhMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlXKdON6KYfRwTbx7SyQyXSOgU8Guldg1YG3GfGYCC6tKsDn+F+4bCxlRPI+AycKGOWgEOYaA3Kc1b@nongnu.org
X-Gm-Message-State: AOJu0Yzol4Db+K7/TQ+n5l0rRj/HvzjMb/rW7N/SRS1HsoZKoceGgbUN
 IZ0h/ssJYYpu77zMmkYhPw/VJiQn7MgdYQXXcZ4UnE7hZxdo3Qjr3mHuXgO8zU+i+WlrYCt2XZV
 q4FjlXqCWPpGqXWO7Slzdm1SuJeARZMVI5xOsiHPPL9O1r4ZcdKSZ6pb5KMOyrB7k
X-Gm-Gg: AZuq6aKpOrDnMhBuB5AOCueaFnbZoKtxZzeFe7K8/ovPBCumOGw5QrzZscHmKKzCWwa
 D9wz1+MRVmSYAViWjfCjcXcjL8PbTOqAcH/6Rv53TgM90Qkfz0eDIkVKVftLHn6cKxJOFzKjcH5
 1ddtybzM2OdyzA9WxOdpoISGsxc8SPYFniIK6t35g3ENmhUhl1PTuSFBKE5DojPn79BSMiEaJqc
 OYsCfL4CGYRc+RjKvuwCVi80GPzxP4ZuIZN2e9H25UwvDw0/fXqgvT9Kwq+H2KIcZ7PMSTiSHJt
 RU/L51ft0bDfqQNpz+7JPXfElv7SX1ZHkHbtDKgHdbf9MkFiWo2nC2OkEG/BDaGRkxXjrWeve8p
 3k5dI7KiJH7hXU3bcmHlaqKjsWiVk2FTt/aDBh0iTQrLJnfySL8rcJK5pqhTnheDey5eBYI+IW7
 CGxtWv6A4HCOGbTg==
X-Received: by 2002:a05:6000:1ac8:b0:432:c37c:d83a with SMTP id
 ffacd0b85a97d-435f3a86321mr18913729f8f.15.1770055374733; 
 Mon, 02 Feb 2026 10:02:54 -0800 (PST)
X-Received: by 2002:a05:6000:1ac8:b0:432:c37c:d83a with SMTP id
 ffacd0b85a97d-435f3a86321mr18913678f8f.15.1770055374374; 
 Mon, 02 Feb 2026 10:02:54 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm45383869f8f.7.2026.02.02.10.02.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 10:02:53 -0800 (PST)
Message-ID: <03a759aa-d24d-43aa-bb97-b65f8e80bf66@redhat.com>
Date: Mon, 2 Feb 2026 19:02:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Makefile: add python script dependency for
 meson-buildoptions.sh
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20260202174849.1949691-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260202174849.1949691-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/2/26 18:48, Alex Bennée wrote:
> If we update the script we should also make sure we regenerate the
> help text.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Yes, this is correct.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 9fb55dcf330..54547a37b1a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -130,7 +130,7 @@ Makefile.mtest: build.ninja scripts/mtest2make.py
>   
>   .PHONY: update-buildoptions
>   all update-buildoptions: $(SRC_PATH)/scripts/meson-buildoptions.sh
> -$(SRC_PATH)/scripts/meson-buildoptions.sh: $(SRC_PATH)/meson_options.txt
> +$(SRC_PATH)/scripts/meson-buildoptions.sh: $(SRC_PATH)/meson_options.txt $(SRC_PATH)/scripts/meson-buildoptions.py
>   	$(MESON) introspect --buildoptions $(SRC_PATH)/meson.build | $(PYTHON) \
>   	  scripts/meson-buildoptions.py > $@.tmp && mv $@.tmp $@
>   endif


