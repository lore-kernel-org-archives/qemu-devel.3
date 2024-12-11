Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE6DE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 19:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLSRx-0000lm-1M; Wed, 11 Dec 2024 14:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLSRv-0000lH-NA
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 14:32:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLSRu-00077x-6M
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 14:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733945561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FBVYuHqb3R5UdhkamEh4p1tR90idtA2ZFTJj/zbr3FU=;
 b=WedGOZwJeZ6ZzuisYe0D7bYAKIVY4aO404UAIWy5BzdftQ1nsr0hbRTHjlKnu27jFePcOP
 dW2OdTUBSFoWN2gNVnctuhpvHqlNapUU43747hrBOOQmcDWg5F89xC1hjssTvP8VYPZ3iS
 GyZJbO0Apa9W3KpyLJNhj5gl+9UIeoI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-E-eTL-SpPcmj-acjwf90ag-1; Wed, 11 Dec 2024 14:32:40 -0500
X-MC-Unique: E-eTL-SpPcmj-acjwf90ag-1
X-Mimecast-MFC-AGG-ID: E-eTL-SpPcmj-acjwf90ag
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434efe65e62so27829515e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 11:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733945559; x=1734550359;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FBVYuHqb3R5UdhkamEh4p1tR90idtA2ZFTJj/zbr3FU=;
 b=SlLDMVMCJoc6vRPOmd28D19AkhYMp6BSSrpusOce8sGq5knbcWsMBzFieTWuiYdKr7
 IyRUY+1hJrfLc/PFDDnHD4xiebgJULM5y5CrCyD6HWXT7qDoRYx4rhViQuBnR/ffwWrR
 cLGG3ABvtItjGtrPHag5G1xE5oVWKa7Cs4nVG7k6b+fApx8lULO3bc3sRFWWF2GgRZrh
 T5Epp9cV1gaWLEXTQK8R+iDd+9QxchwbJ8+QyjmS1S3INTAy8rGmYuPEzr4UfHlnJ24z
 94svOd3Iv7Kb8piSnBiUuUHcXseVYXcKKIkEPuhicCYtZI8I3dzMOxmb6dg6VGzjALpx
 w8SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJxUgXbu2Aq3NFggzoiRUINxVi3g+he4FfNofWzJLOLB2fexkEV1u28KFZF48B/eye8dDz7SNa3xh6@nongnu.org
X-Gm-Message-State: AOJu0YwT9IYsIfqHlIAxKSKazB/U4HjPjxvJpSzJs/iIY6rKxRZHjjWZ
 wBLj/Y+uRhtGY/5zoCV4WWnlTmL3ZCGR7PzXre4GNGI0CoL7FZyntuht9SaXO6jkMBpXn3L/E8B
 PX8/2h33949NRppmN6EaDNQwUl/htiwk97WO98Yo1e6icx2ij7LJi
X-Gm-Gg: ASbGncss8IhPkBWHVUTCV+/qFFf817wbhtS/7WK0J4T3xHwSx/Wp2dP2ReGDrtjK32q
 s4olZgCwOtYd4LRWn4SWSmxEOi7jFDSZfFV4D7CKD2sItdqGTHKUFusnYsfwkuMz1p9LcoMxF6T
 GzvBZ7kBPrybd0zOKmBF0e1s88v9cqj9DOUIl6qiMmex1dvvMEs8JGdt+cv5Atc+GiIt2ljJBE9
 bOYbJiIk84oqzO627nqi/uX4CXORJuF1MvnuPZOlKF+SOxZzRds8M/KSE9urb02ocOqR1fcgoKY
 kJMoEr4=
X-Received: by 2002:a05:600c:468a:b0:434:f0df:a14 with SMTP id
 5b1f17b1804b1-4361c34623dmr35417315e9.2.1733945558778; 
 Wed, 11 Dec 2024 11:32:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXLQNcUzNWLFYnuOSybi7i5C6ykA/K2hb7YsiCH1Yf8af/wrKQJNYnNyQnBTWShfvps18E9Q==
X-Received: by 2002:a05:600c:468a:b0:434:f0df:a14 with SMTP id
 5b1f17b1804b1-4361c34623dmr35417195e9.2.1733945558453; 
 Wed, 11 Dec 2024 11:32:38 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436199f6896sm45257795e9.14.2024.12.11.11.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 11:32:38 -0800 (PST)
Message-ID: <20576d67-2b9c-48b3-9eb0-753038b91b29@redhat.com>
Date: Wed, 11 Dec 2024 20:32:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/31] tests/functional: simplify 'which' implementation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-5-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241211172648.2893097-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> The 'access' check implies the file exists.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/cmd.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index 4106f1ee7c..600e0509db 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py
> @@ -25,7 +25,7 @@ def which(tool):
>       paths=os.getenv('PATH')
>       for p in paths.split(os.path.pathsep):
>           p = os.path.join(p, tool)
> -        if os.path.exists(p) and os.access(p, os.X_OK):
> +        if os.access(p, os.X_OK):
>               return p
>       return None

Reviewed-by: Thomas Huth <thuth@redhat.com>


