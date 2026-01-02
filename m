Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB92E9410B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 09:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbb6z-00058V-7F; Fri, 02 Jan 2026 04:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vbb6q-000551-Ls
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 04:06:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vbb6m-0003eT-LS
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 04:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767344768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1i3GnS0GvgkoImo7R6lJeHgFpJBrVOVvBnJONNem4VY=;
 b=O3j51JmDg1LaTrCEYzgMvClmmomp5wV88hgMqHXzyQt2+MT9XV4uGuHgAckcJa2mlYyd87
 ROzKgzAct6rPYjijYCwWuwL4rc2jJAfObQZLcISUWk5khdBNOAB7B5OmkJX/bXt4ltGM9k
 I7NftGem/4PW4mJr2MX5TZdcfiDkKCQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-FEVM2sz_OUq6k3iUWMui9w-1; Fri, 02 Jan 2026 04:06:06 -0500
X-MC-Unique: FEVM2sz_OUq6k3iUWMui9w-1
X-Mimecast-MFC-AGG-ID: FEVM2sz_OUq6k3iUWMui9w_1767344765
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43284edbbc8so3027487f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 01:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767344765; x=1767949565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1i3GnS0GvgkoImo7R6lJeHgFpJBrVOVvBnJONNem4VY=;
 b=LuiqnbPAo7SnjoPcciivIo6qTqLpuatQEo07Ya9rA4Un9Asq2xHdOdauxd4sv4PhOs
 VAlVrchSXfsd8RB4IprtH+MT0Jam0EDhaxTdMeu82RzllB5yhgzEZL1Mjrt0wRzBbAjo
 S0v83Vnway/yH3lOtWlVSGk97ijRznW1UVkqA5H0lM0wH92ZmQDMKe60z4yFCOB+Ot7A
 eGeo9k5+UmBPuFLsJA0k7SzyVKK5JknundWaDdorSZQup214JJZGLcjl7AxmCu2TrB74
 3cjczFYaOfs0H0dS+ET+8QQTkzs8f7m+2giJGBbHbcSdzqaQFBmmGpdoHZRhjcsSAUd4
 GlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767344765; x=1767949565;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1i3GnS0GvgkoImo7R6lJeHgFpJBrVOVvBnJONNem4VY=;
 b=b0msyhIM6+XU0vrgl1XVnshrMGZewBsE9lMSLxFywyU6LhGryFpzl9Y1wH0Nkh3jtW
 UIKQLROteOMXn7Zn8ELgwrG/ywariJVsY06xNbcAF0t4aLxi3RVDyxlAoZcWYQ20+r8T
 XWS6gEPlLT+C67lr8uBGSvnw+ws51RuYsAPqs9799yvUXOLF09swXaG4Naub0CO99X95
 5DP/EWWHtGv0FEOaQg1KkjNLKZMqtpTiI6zMfDvbOtxQHlSlV8pD/zzfneyxScNobm1R
 nzJN0ScYBmTvyoHP9W27N0hSuQsSlEt6O5efNAscluKgDH8rK2e4MlRG7nLwpYf6Wj+x
 R9Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKTmPvLvzSLWrfMmMt3QUcxk5Ci52Xv7EwEOUOaV12FCSZrLKXQ+nOaNmDlvDHFj1eCYwTE6DfwsTA@nongnu.org
X-Gm-Message-State: AOJu0YypexTlVvFzq++W0v5i05lpvmccbOjrxd/gfhq52kpAHLjOHadc
 JxY3YqJU0Ki7t0VhF8UDcXDl7+u/Uwjsc8NKZtcni8t0E3Qol9EXABgd5RaGyZbMSH/tYpaXRbb
 zw6OGiuOVZ7CA31KfrW+FusrNQqZ5tIHSGH9iSwFfa7hkbvk1MCrQHx55
X-Gm-Gg: AY/fxX6KeZLT1A19TnWzuMxEIQXhbqOHdlpvZvf7xp1Rtc6aUXhvW5Ma0vMB+7YEDqH
 U6zwx+FMTqE8vyANA2PJX3IwiyEVOO7CwJEu6s6VgDo6yF2FV3lRaJc950xGDgPNoI/5qRe2srd
 y5jzVuz4ETPH+SBpxQtLNQv+xILaFM/xP8NpJVxfR/+TeXa0fVsSZCDcTpx3thF/IM0geB2/P0s
 yec6KfMa5sOUHLIAbMlAAcOos/v79OoodwK08vprb3Ebe53wIJfLcNtApDjdNHdggj4bFn5TtX+
 GBKTC5LEIXy5XJcTos/AKKTyBssQfk6xuko7jvl49Spk6OuWwfFO0LCGcNKcYmBQEDce3EiFTB1
 oToug2Rs=
X-Received: by 2002:a5d:5d03:0:b0:431:1ae:a3d0 with SMTP id
 ffacd0b85a97d-4324e4cc063mr49633730f8f.25.1767344765404; 
 Fri, 02 Jan 2026 01:06:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiQk/MU7zSY6tHBESbB6nrHV/ZgxEqrQegoM2jHKarGEmlt2B9/3yZ/Y9uwPdtLrAY1+JgqQ==
X-Received: by 2002:a5d:5d03:0:b0:431:1ae:a3d0 with SMTP id
 ffacd0b85a97d-4324e4cc063mr49633689f8f.25.1767344764967; 
 Fri, 02 Jan 2026 01:06:04 -0800 (PST)
Received: from [192.168.0.8] ([47.64.114.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea226d1sm85678172f8f.13.2026.01.02.01.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 01:06:04 -0800 (PST)
Message-ID: <97d1ac72-a057-4f5d-ba5c-0dce90091647@redhat.com>
Date: Fri, 2 Jan 2026 10:06:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] MAINTAINERS: Add EEPROM 93xx section
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, alex.bennee@linaro.org, Stefan Weil <sw@weilnetz.de>
References: <20251220173336.3781377-1-armbru@redhat.com>
 <20251220173336.3781377-4-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251220173336.3781377-4-armbru@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 20/12/2025 18.33, Markus Armbruster wrote:
> Stefan Weil volunteered to serve as maintainer.  Thanks!
> 
> Cc: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 746cca7ae9..3efc943c9b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2706,6 +2706,12 @@ F: hw/nvram/chrp_nvram.c
>   F: include/hw/nvram/chrp_nvram.h
>   F: tests/qtest/prom-env-test.c
>   
> +EEPROM 93xx
> +M: Stefan Weil <sw@weilnetz.de>
> +S: Maintained
> +F: hw/nvram/eeprom93xx.c
> +F: include/hw/nvram/eeprom93xx.h
> +
>   VM Generation ID
>   S: Orphan
>   R: Ani Sinha <ani@anisinha.ca>

Reviewed-by: Thomas Huth <thuth@redhat.com>


