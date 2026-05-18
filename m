Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9413CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0ee-000575-Qq; Mon, 18 May 2026 12:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wP0ec-00056E-SB
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wP0eb-0004v2-63
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779121036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=okXwibi0kB6V6aWii44xEzmaCt/XQFZPzGZ1J/0PZxo=;
 b=Zu18DvMgb9BrA0IWUC3EC6a0fXiCAZAryH+nIEN7zcd0dGMxNBm9eIVOOPbTyfbOWsMxa+
 MhvkC38c22dOFeEoAvVaLuFoyQCCf1o9qd/n33geCeLs64vsUQ2rE48XLCFQeK4v5o4WAk
 PFvaySi59nsiClC36/7vkyFJizvDcL4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-KA8IK8m4OxqgBDcXszQpzQ-1; Mon, 18 May 2026 12:17:14 -0400
X-MC-Unique: KA8IK8m4OxqgBDcXszQpzQ-1
X-Mimecast-MFC-AGG-ID: KA8IK8m4OxqgBDcXszQpzQ_1779121033
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fd9c22b8fso20683385e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779121033; x=1779725833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=okXwibi0kB6V6aWii44xEzmaCt/XQFZPzGZ1J/0PZxo=;
 b=lIURIktv/evCD3+KJohbf/dA1iEJvI73K2s5deov4EITAfV3qGhP4BWd/xCyvSAL8P
 BCQCtvtkM/JaaLMZxWYU/tRHejVAQYPxPpHHSlT1CF7nxT3rzsFagy5SqdulRlR3ZEyC
 gKEPjWTfJVNu6Qsj0qLHxRJ+UfvFSLKbAnQkanU9XXFAJHyd3c72hRy0HxGIwbOCPnMS
 eZ0a3kCIiMoW6nGyUufr57XckDcxrMCRE8QkWxJYYePcUoZIB0Hs/i9Lu7LtZOVpxH7X
 OqKmCnhW1pUu2jsr9xsdP3LnQUHEuC2wxi1IcgJUi3r1/YZqBcltu+ovu2oidRbtjEfJ
 /O5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779121033; x=1779725833;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okXwibi0kB6V6aWii44xEzmaCt/XQFZPzGZ1J/0PZxo=;
 b=aLaUXQ9Ag2rFaMhx+IiyVWcbMrwSn5GyBzZvK0daa2w8FP7ND2ympQvOfmsJrWOfbP
 nP48c6aeXG/PoOYVLYJ5xngAk+JDgE/FVktTO3hTvu7tv9tmBuapzm5VEYsjEoNKa5Bm
 3nXMNv2LdsfmCC/1WDDNl/M7g/E9CyG73zj+dSxczjAt94jtGkgyN3XUM90cIbfiPODi
 DWp1QW5S3upo9lGA/eRv7v7AdnmiMAbyVF/cpKS4JROX+JztOKBNATBsJwnIJz2CE1Sr
 EYKza8DbLKeAx/cHmpw9DuGaoxC9VhjWNf6Iv9HBz8bYD/FoDol/KS2yiHjii5w/4UWz
 gD5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TXH367bxQ569D75L+lkiPiULrD7UHJtIsvqsZpv32g4MIyrics7/jXdZ2QQX1juVIcaieV6OBgenu@nongnu.org
X-Gm-Message-State: AOJu0YyZeLk67zBfzZN3Dtjaegui5jr7YvGpCCxQd0ltvduKeGY7ktiM
 GbGpS0PKoHDBCa5JF0Qj+MRDilL5rsiEmiwnWX2pd82B4ewMb9CpSdP17223MeQknLr2QwROatw
 Or9geEbIQAIZAEF18a7WZ2TpwDJ1SW3Vyb0zSr/IVek8WFmHhq8gpqVOd
X-Gm-Gg: Acq92OHrO6koK+liGBYMozjbQYDVkW6cYrNO+Q+d6YVB1FQKhktlcUM4CqfZAfKqesp
 +k1Eda1ZrOaOGEADGf670C740F+6aQkZ0DeOXzi32mnT5Sqq5DSGzS6c7YOzO01kNWploBpasFu
 mUFGXeVXNxtUrvuC6GgBQfm4A8jcjr5CwF3R3PCg9oamCK0HvWbzzegGmNtWt2Tq87YbZ/mY0VR
 6G0I+SVtG1/z2h/XyuVWaQfJxmYTsqTw3titQU/wySKo7NYOSUs/uYrYfOnEIZ3y1KS3BcznyUW
 eGktEjM18BoCr6IYEWKSSAGB0w6CPZPggO2Ne0+JzUs42457l0L+eS7/7/JQLeEc/ynuW0tPOtl
 lafX8UemiGRZxUOpJCjH2mPJ8Td/l
X-Received: by 2002:a05:600c:4e47:b0:48e:707f:cdfd with SMTP id
 5b1f17b1804b1-48fe60e54f4mr262070545e9.2.1779121033106; 
 Mon, 18 May 2026 09:17:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4e47:b0:48e:707f:cdfd with SMTP id
 5b1f17b1804b1-48fe60e54f4mr262070145e9.2.1779121032706; 
 Mon, 18 May 2026 09:17:12 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.83]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ff43f8799sm154475145e9.2.2026.05.18.09.17.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 09:17:12 -0700 (PDT)
Message-ID: <817da89d-fb6d-438e-be39-43714c81475f@redhat.com>
Date: Mon, 18 May 2026 18:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/16] iotests: use 'driver' as collective term for
 either format or protocol
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Kevin Wolf
 <kwolf@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260518160051.903616-1-berrange@redhat.com>
 <20260518160051.903616-12-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260518160051.903616-12-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/05/2026 18.00, Daniel P. Berrangé wrote:
> The I/O tests integration previously exclusively tested block formats
> and now also covers the NBD protocol. Replace references to 'format'
> with 'driver', as a generic term to collectively apply to either a
> format or protocol.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/devel/testing/main.rst    | 13 +++++++------
>   tests/Makefile.include         |  4 ++--
>   tests/qemu-iotests/meson.build | 24 ++++++++++++------------
>   3 files changed, 21 insertions(+), 20 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


