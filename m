Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F4EE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 16:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXk58-00087E-04; Tue, 14 Jan 2025 11:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXk56-00086m-Aj
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:47:56 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXk54-0000ys-Qv
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:47:56 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38634c35129so4023447f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 08:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736873272; x=1737478072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W8nkdLleRZqm1ZZ+mUXtvsEwLRWxuvmC13kfjjvEjR4=;
 b=Au28dYmbq/NltcpPjT9RwFGooOow8g85G17uk1x7mPxZhb0oGreiXICGar9WMIKt6t
 VFIRlP2PBL6eG5czhxa8VhTRlxgRCYWaZIta2LHwPVByRDZSGZywJ7oOiYNld64GqFJ/
 EDPPTDezJxQzS+/eSixNoNoPl76xgXm2JimV3gF/dZsu7UEGF8Ww/UxIKJMuw/wqyrTb
 WDsXka8DfyVoZdKfi06y0AtvR7PpFz6G6pTrbDrpz0urME2H7zwyA7gosZnGfQMfG04K
 qeDXgqaBSxEbJAdfGysmY4mRkQT/NdAMZGv0hauKxmLnxHBh94hmLV6lGwZ8qXrxgHSM
 LnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736873272; x=1737478072;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W8nkdLleRZqm1ZZ+mUXtvsEwLRWxuvmC13kfjjvEjR4=;
 b=GIK2mVpX16dicFWTndbalg1XgHF3KN8bkezS18hBwJaBJ1872/Jfp+nq5QsOL4Q6qD
 zsjhU6bUMwgD5hi5uTQLb6xy/I501v7R90F/E4tNlMl31wJvs39wvtsiaJrSKO4Yn47Q
 ZdTWb2HGDMleEJs/HaniMDFVStKrmr7+y1zSivbjrt1Z0NknmxibeGbw5EYz4XjFdFUV
 Tr/wsR0KDJo7zvfyPHfq9b6E1qfdj/deMV5FQTrc45eMZp/wH/YW5qQnpaktAek3qYpY
 wIg6jOjDV4xhpiEctakRzZ14st4fE3DKPxpbUM6XZCM8htrFdv+rKjUt+wzLzmult7PP
 LzmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYTIS6l3qvWsYbFLooOuePn6pq7OtSISVnIikldd91umFBWugbGz5GNQtK7vviLh10dWDrWGsfCOji@nongnu.org
X-Gm-Message-State: AOJu0Yw7v3///YxaNTv7uX04rZFNbKpURrzh6/DkMOL1B+9/dvgIidZQ
 rmNFBlh5cZ71a+cfziDz8BboWOrdqNIiRzQQIrmPzlWFT2W+tOpGqvrEVqwGPYo=
X-Gm-Gg: ASbGnctOD2IlCYpdPjRTCR3XZSdkZ5f4mkkpQ0CroQePbkgY5/ycRFt7iA5wDPZi5gj
 zyemNGRh1s9oRhhVmCjwBwXFjwC8YnswA2cnH7NPPBRvhTc1Q2/NKSSyzemEj0uLeYv3xIaklXh
 V1UPYPFSqXv88mm7aUHicJzrWEoo0qCf94qS+Yd/sXDUBeOFCNq2zTAhtFSg6RSEmQmHUxORC9X
 KoAFqnm8chxG4CQRfgsUgJV9XMYeHQlTyju3UXt02QGbbNMSnW6W38I0zBxxjEepvBlKkflms6r
 xPyHtoPFJkxd0d+lI/NkbkVq
X-Google-Smtp-Source: AGHT+IE16sfu/SQ0DsLow8Q8MB9x8muqby6ZMloQx9q9oe2iM4Iis3YltSnM/qJufQ7YPEvQMD++3g==
X-Received: by 2002:a5d:64ed:0:b0:38a:4b8a:e477 with SMTP id
 ffacd0b85a97d-38a87306a84mr24022055f8f.22.1736873272479; 
 Tue, 14 Jan 2025 08:47:52 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bdc0d8e4bsm6259457f8f.42.2025.01.14.08.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 08:47:51 -0800 (PST)
Message-ID: <71845f0c-e644-48e9-a520-95134d7c7798@linaro.org>
Date: Tue, 14 Jan 2025 17:47:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: fix -Werror=maybe-uninitialized
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20250114104811.2612846-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250114104811.2612846-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/1/25 11:48, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ../migration/savevm.c: In function ‘qemu_savevm_state_complete_precopy_non_iterable’:
> ../migration/savevm.c:1560:20: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>   1560 |             return ret;
>        |                    ^~~
> 
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   migration/savevm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index c929da1ca5..6e56d4cf1d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1557,7 +1557,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>               migrate_set_error(ms, local_err);
>               error_report_err(local_err);
>               qemu_file_set_error(f, -EFAULT);
> -            return ret;
> +            return -1;

Preferably reducing 'ret' scope:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           }
>       }
>       if (!in_postcopy) {


