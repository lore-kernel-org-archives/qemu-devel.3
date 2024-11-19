Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AA5D6007E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 08:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDJo5-000589-JI; Tue, 19 Nov 2024 03:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tDJo4-00057h-7e
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 03:41:56 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tDJo1-0003eF-60
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 03:41:55 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9ec267b879so665460966b.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 00:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732005710; x=1732610510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JtkzK9hIBr/jybUMX4Sfah7yVdSEMxrRCeFdrWaH3cA=;
 b=NsijlBsOx3ETXh+WP7Znok5wuobZG9v0Rt7nehfVV/5R3OcJ44ZQQdIaCZrTGgWWNT
 cBBIH97P7Csy/ER8JrDX1QSpad5E5wYp4KqvWNpMMjZb7g8x9bGGc4W9YhGQdrIcfR+E
 esOtgT7ZDwF7bcByMADWmGyC4gk7mP8IzzcU6csXjGI+/redbkYwn1Ys+8qUsJWi1KQX
 rl7U7ibzfh4Z4SgtxWYM8UjKit0idKtSpOePqwwGLbHKVplQxgS+KysAH7c2373KO9iq
 rvf8EsclWECm0tRLyLH2jjrDwo9aFMq1jmQCj+j7OREygAeKQRXw0stOs4VX+ZFs+mZP
 dgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732005710; x=1732610510;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JtkzK9hIBr/jybUMX4Sfah7yVdSEMxrRCeFdrWaH3cA=;
 b=C2YQlYSJyjv6Qks152TmYEvI2PlUHduktJfEH6JsrUGw+bjOLqLMbU0a4VjiLDnEvZ
 4dP7ep4sN/L/MyL6wVu+pvM7wNA6naAZSa35YKGPfRZn9V32xmd2fvdQKFOsd3+t4K75
 08bfXvUTdaoXZ9FaCYLelQMg5Orv3HTq6PC8wuuSWS0NzRVHZ8OZi4tfqAAM99p91WjZ
 spMgTdZDGdk3oLDSmWC9xKHV+rpAxyFjImi/U8m4a+u2h4LUrVzyPv0bgkbku6VDzrXg
 XG6MCRFAHJGOs3TfCQMBwKKIh9wGEXpDHrdJ87dNyAre189px4E/CD0VDCtnjZEW5OF5
 CrPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMzslkLkuIMwuz8FymVahLlSfQrz/i3unsbwgqpOx+GFlVe/ol7mIXOgC3ncdMaRqU5dab5Q2N5IYu@nongnu.org
X-Gm-Message-State: AOJu0Ywef+ENnT3kEs3SjpFrJdaZKR38q8G3Uj/G6JFjKjOB5zx6k1sg
 IAku+QbfAuuj1ut3ytXv1a4yOI1F/oNGXXyCdd93UHOmRzkNcLGFVz8oA1WxqtY=
X-Google-Smtp-Source: AGHT+IFpOQ3VZindhIGNQzIUrfPPM+R00IWJhIv+8TT0a27qOO0+6v0wealj9KUN4s6cBEL/qOYfVQ==
X-Received: by 2002:a17:907:2688:b0:a99:ce2f:b0ff with SMTP id
 a640c23a62f3a-aa48347616fmr1385767566b.33.1732005710522; 
 Tue, 19 Nov 2024 00:41:50 -0800 (PST)
Received: from [192.168.210.26] (83.11.2.232.ipv4.supernova.orange.pl.
 [83.11.2.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e048f12sm622684466b.173.2024.11.19.00.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 00:41:50 -0800 (PST)
Message-ID: <ce090d62-89a8-4f1a-a864-add24704dd11@linaro.org>
Date: Tue, 19 Nov 2024 09:41:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] docs/devel: add git-publish for patch submitting
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, gustavo.romero@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-3-pierrick.bouvier@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20241118172357.475281-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

W dniu 18.11.2024 o 18:23, Pierrick Bouvier pisze:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/devel/submitting-a-patch.rst | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
> index 349c32ee3a9..953682f20cb 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -237,6 +237,20 @@ attachments can be used as a last resort on a first-time submission.
>   
>   .. _if_you_cannot_send_patch_emails:
>   
> +Use git-publish
> +~~~~~~~~~~~~~~~
> +
> +If you already configured git send-email, you can simply use `git-publish
> +<https://github.com/stefanha/git-publish>`__ to send series.
> +
> +::
> +
> +    $ git checkout master -b my-feature
> +    $ # work on new commits, add your 'Signed-off-by' lines to each
> +    $ git publish
> +    $ ... more work, rebase on master, ...
> +    $ git publish # will send a v2

You recommend 'b4 shazam' in 3/7 patch so why not here? Both 'b4' and 
'git-publish' seem to do same stuff - handle patch series and send them 
upstream.

b4 allows to keep To/Cc emails inside of cover letter which makes it 
easy to not miss anyone needed.

