Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF83C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Brd-0001WB-Kq; Mon, 14 Sep 2026 14:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6BrS-0001S3-1E
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:57:05 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6BrP-0007O2-Oe
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:57:01 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so2370682a91.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789412218; x=1790017018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iErmpFcJi2QdxNS5FRoJHlT8Mi6eTwqMD9ZVS6Tt7dI=;
 b=lURXz1z7KWuw5vy99iF/qqHMCGmP3XwWWnyWwg3IeMhxwfO1F+UE0lTV7JJ+qk65kp
 1RKdFqmAiB2T1jGMvRn8hAShT13vWOJ3WUXUo4KbZCqD3f3ub7oOSeXs5gHUDnoP3F5U
 Je/xbSIPdzPPWx5+Xg4TnoulzALRckOsu0sufXKlpAeTnyFjaAeuQfsP60/fsZxNA/9J
 Oj6lRIUACBasOt5czTQNDMzibO61EjnlP4iysKQzaiBItW9WxluuuPA1r8FZlM0C2QZR
 wHiIdYgLB6SzcaCuj8bKVa++sQYpylUbMRQ+OrIMrU869Y7W0JDL2OxRxWDS8JNgKZRW
 cpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789412218; x=1790017018;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iErmpFcJi2QdxNS5FRoJHlT8Mi6eTwqMD9ZVS6Tt7dI=;
 b=XpqH0Pwzlwx20fkONas7OSCT+v1sJczWwYnKKPWaGylaIjNwppnzpb5l77srS0XWYY
 JFCbrlt1/oQMFsqdZYHl0C+3L5fhwDouV0Bjwa/JEBNGEGmqD7cxza03dckGeuCkbdnx
 R0HtVG3uta/ke1iER+ykjROn3+gVpl4o/TFQjOhfL/rI7Avpj2TyW6JH0EJCy6ISjDJc
 Q8PqyQajBdX9Tl7MHUAuPH5pRuwDZ86nASGRp3XYVfPHRF/ybs7GMd1Urqy/MogXhH2i
 yx8CfS97wrWkNlr0DOIqZrD2JFh88s9St75dUevSBrY+AnwGBDP+W4eD0QGJDA2luzMy
 4Rig==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1hWx0MRS9QpBSWwSnWYgEOsZTQscByt7r7bCIbUxQvAgtU5Z468ujL+cpr8XLI3RwoH5e4wtfpVS8@nongnu.org
X-Gm-Message-State: AFuF++mbZ2Vb/w4d54AqwXqfZe4zYMHtCqvHPATJIo/PcxXvBbIpAEZc
 nbkEa/o27Vvb39mEXWj4g/Quw8niAIsnYROCgxjgxvHAv3OWsGcoKTF+nE8FIXlxtQQ=
X-Gm-Gg: AYBFou1mJn17qwuXOCh+JAfcl+1DSBbJTY5fD8SBNo3UC/ZOo02LYHGo0ehfg6AYEZP
 dUMsRiblEgWVg/w7rfFMgjJaHA5EKDjKoHcewtJ98hhYTqukYPyUJql6GMuAlxSdxaaIbeBBtj+
 W91PH9sz1thBvRZ93AgwPFQQVC8rRMqsDsj36xmxrejP2nUpOL3SPgKkC2iQx+C152TiTE1zZGG
 reicxBaOSf2BhfEN0f6IfMNuuO3OBuQIWyu7H2edfBioXHDFF0LAEFAJPhy8bLmdp9R7E1hIdXZ
 fb2vqLEKrn6lNuOGDK3fjW3TFYV+1pILjYWKHEz6K2hLuY+0FqDpND5FRc6SR8zu8PTG0qjWY/l
 uHeLezKdygG20K9pCB/WV0gaA0sFTnmg7wkA/zjiLaYky/4864LaMayZFLQdKrPSK4ARlQLJ0lT
 o51sA1iAI9gNkMc4EtAJYudHkOXQYCmWDiAWzuqiwMLZVbCsZ/9OYgqt1KzbngIlNpTHY3VcGDJ
 SByxT1RtEVoUAbyL784kJ44SWadwfjQgZ3vMTfJpcMsA8tEAag0o5ShJnnkiQ==
X-Received: by 2002:a17:90a:e704:b0:39a:e002:f192 with SMTP id
 98e67ed59e1d1-39dec0d27f3mr8606682a91.22.1789412217737; 
 Mon, 14 Sep 2026 11:56:57 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e51449sm24284910eec.5.2026.09.14.11.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 11:56:57 -0700 (PDT)
Message-ID: <0f88cc6f-6aae-4b56-85ad-f7be5b2f050c@linaro.org>
Date: Mon, 14 Sep 2026 08:56:53 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/14] qapi: add 'insecure-types' option for -compat
 argument
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-3-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910103628.2326622-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/10/26 00:36, Daniel P. Berrangé wrote:
> This introduces a new 'insecure-types' option for the 'compat'
> argument that accepts three values
> 
>   * accept: Allow any usage
>   * reject: Reject with an error reported
>   * warn: Allow any usage, with a warning reported
> 
> For historical compatibility it defaults to 'accept'.
> 
> The 'reject' and 'warn' values will take effect for any type
> that has been explicitly marked insecure, or is lacking an
> explicit declaration of its security status.
> 
> This new command line option is currently a no-op, but will
> become functional as following patches enable the checks.
> 
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   include/qapi/compat-policy.h |  5 +++++
>   qapi/compat.json             | 23 ++++++++++++++++++++++-
>   qapi/qapi-util.c             | 30 ++++++++++++++++++++++++++++++
>   3 files changed, 57 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

