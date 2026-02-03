Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2BDE8305D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAmn-0004vx-Ly; Tue, 03 Feb 2026 02:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnAmj-0004qq-Dd
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:25:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnAmh-0001m1-Lx
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770103513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u3D6QhZEOvienqiM/eISUkPT9ArlXrWtyjI69livpVs=;
 b=Q3Av0v1BpYntQl/EAi1nJnMpVicszUJ/INijhRV5SHwWMI27ScADCUPcJocBX9JKxSg1La
 FkRMrX1yLSo2rTg3ChCrtvIIDJ/c6aTiKPPwgFod100scl02jWWCCy66FZjLK5VkoZb2DM
 U16HdkPcd/QFdduLMQB5LayaRr9+esc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-v-tFl35ZPoKasSUkUYtnXg-1; Tue, 03 Feb 2026 02:25:12 -0500
X-MC-Unique: v-tFl35ZPoKasSUkUYtnXg-1
X-Mimecast-MFC-AGG-ID: v-tFl35ZPoKasSUkUYtnXg_1770103511
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47edf8ba319so55908245e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 23:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770103511; x=1770708311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=u3D6QhZEOvienqiM/eISUkPT9ArlXrWtyjI69livpVs=;
 b=mfR06xKJA/yxIsULeKSjR5V1JcvKyzZjM0C+pPPlqh5RSfxnyTJDDpX5v+woePPczj
 VrNlc0DYRGTxc+uW5/8NqJglFS2F5ge9GlKQo8HSZDyu3Kwb2Z/6bxUWbGhAzex1h4wC
 Y9NnfNVa56Ghik+DpsDtARq54FpYDylgcmEibeNjTl/nRb7UFvDDXxfWpw2ydM2AMbp9
 beCkmb89NKFzz8I/rxjfFyj9HoqfLITo8/OSIACa2cwGF1jS/MB4RFIkp/wKiw5zOkP2
 aUE3ZrGwixOL3UPCH+M1ua8YRmX5TfYsuE4c0oiEgQCuPlpvGIQduShDvkuopaoDgdud
 qzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770103511; x=1770708311;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3D6QhZEOvienqiM/eISUkPT9ArlXrWtyjI69livpVs=;
 b=HFwqk5woUuTzvPRn/Vq4SObBN6MeWQQ/opFvBeby+cJF0qrQNgGQQVyg6HGZlMnuCP
 /WGaB+Wu6fSMrp/vSQXjFk0ow1ZUeOyYjW+cLA4NN6LIl9AzwX7+9hxs/1MUU9i3Mu+V
 XzP8qaXpOTooO+lQbtkfC5qF10r058cSZ8PuS8lExq5YTHDMsZTEphAFBLkF7tdupaCi
 v+Gi+wE33Wunz/9PGuvfhd2fF6yYQI9XpT32nbT1eajnyYSk0REYd00pC47zgg1qICqW
 Mdt84hLFSmYa//0BtRUiVesSc1+eEyEaCbYTh5e6syXp+1jOhdn9NLO4FkzrCyBh6GdD
 m4OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/ZZ9wK93bKcXbr0TlanItF1NJ5qFLhIWOIykbBCUrtF6liOKlnch4Kz86tguEhqqzUjGoma4jl7YU@nongnu.org
X-Gm-Message-State: AOJu0YwQXDGGbU2EOny9LtD2Ifi4BX6I6DzzHUEReZVTZfZP4JKm5CwU
 sEhoJAnuSHZAnnA6+k3lpo84YFss/i7crrDXh/fiVKpdahnVHqolOaEpFSRQOL/eQYLeDw9Gi4N
 hRjCjdBHU/O71iVrJhsnwuHUf36gPm4erXLr8ZZKhEE92Sjo3aOK2GczX
X-Gm-Gg: AZuq6aLSUW7efss8+JM3F5jUr99GoHpOhsStDVkgHTplqWymmlUIFAPeN8mOKseXAEZ
 YySn1/QMl7Ff5Dl8B1lku5viQVZI6ccsXueC2k4RQJwcKt+3r1AZjsGdKcwiDCy6bJ6twqifJSg
 KxfWNO4a7IMyci7ZJ5DPXbaUwR0Up4saA8DSrJ8ZwFZs8pAHTcasRYuIg19GCr68T5QBuLRZtXY
 hqeuyOXGdNbd6QpfwKHRyLN5iav1wPuLhBOftVePdrRFtXX51XNMetrGsXFE3tiNA6lWsRv0Tm7
 vRK7N+vtP4uAHk2v4A8wiVhGLsM78as2N81+o0/VXYIgsjU8bZT8YLsNCveYP4VGCLnn7ePDBRt
 sBsJsnOU=
X-Received: by 2002:a05:600c:6814:b0:480:699c:abe9 with SMTP id
 5b1f17b1804b1-482db4b21c6mr157620685e9.37.1770103510923; 
 Mon, 02 Feb 2026 23:25:10 -0800 (PST)
X-Received: by 2002:a05:600c:6814:b0:480:699c:abe9 with SMTP id
 5b1f17b1804b1-482db4b21c6mr157620445e9.37.1770103510526; 
 Mon, 02 Feb 2026 23:25:10 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830512d634sm66547215e9.8.2026.02.02.23.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 23:25:09 -0800 (PST)
Message-ID: <6a8954ce-7af2-4828-ab8d-9eb80469f263@redhat.com>
Date: Tue, 3 Feb 2026 08:25:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] meson-buildoptions: Remove duplicated entry of --gdb
 in the help text
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260202174123.1943748-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260202174123.1943748-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 02/02/2026 18.41, Alex Bennée wrote:
> Since --gdb has recently been added to meson_options.txt, the help
> text shows up twice in the output of "./configure --help":
> 
>   $ ./configure --help | grep gdb
>     --gdb=GDB-path           gdb to use for gdbstub tests [/usr/bin/gdb]
>     --gdb=VALUE              Path to GDB
> 
> As the probed value is of interest we want to keep the configure text
> so make meson-buildoptions able to handle deferring to configure.
> 
> Fixes: b46b3818cf8 ("tests/functional: Provide GDB to the functional tests")
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> AJB:
>    - This is an alternative take on Thomas's approach in 20260114155355.82096-1-thuth@redhat.com
> ---
>   scripts/meson-buildoptions.py | 9 ++++++++-
>   scripts/meson-buildoptions.sh | 1 -
>   2 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>


