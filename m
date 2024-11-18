Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4004ED4920F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD0wl-0000ud-Ef; Mon, 18 Nov 2024 07:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD0wk-0000uH-1N
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:33:38 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD0wi-0003WB-Ef
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:33:37 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-432d9bb168cso23512375e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731933214; x=1732538014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nGg2eK6wTyqA9lcCKvM26995UkQxhpHyN1kHub7HXIA=;
 b=lV4q8wqV1FlRVNtQo43D+TiKobeGVip3kvFQmqi7TW1dqh8yIjK9dF+OjSPWzSsKn2
 j7enrtJAlE3MASndMg5nm0M5hHGQq1yjWpL95LHFpaFK0d8+WsSTen3ZFJ5U98Yz1WJF
 qsUEmYeNa7cwnGZ7G6MowAFfLdaJTtt0sh9r8YYSW7QLBtuQ7LuGt+AE8CoTlJQhb4wB
 ZMWY4NfUGPmGHLcrO01kxgROZkaiIVMiMgF14bsQrYxrlzYA/7dUhS0eCRKIpEt9hnJw
 3YjjtMe8VpeMHZFy+lbO8lKYIBXVC2n7NwR3SbTdu+uSty1jmI8uN3+7SAft0Kwxp0ov
 zYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731933214; x=1732538014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nGg2eK6wTyqA9lcCKvM26995UkQxhpHyN1kHub7HXIA=;
 b=jYZSmX8BZJlx+arztj++zs6eSWmr1Z6V0KOSGjiceVRN4QpL0cgWHJEjXjozhQFAPl
 3zh7JH6vsuyefgrg6u6fxZ6fechxL1C75a+/pgn0H0chB2Tr/Fpiu5XpoEIJCfPSQkOd
 rYFmoE/V+WutBGnQtmLAAZ2VrPfOy7XhtT52yeM2S3dp9tFfP7CP+qJmslRs1liqOx4f
 Y1LqvwvlZyDbJSJrlKL65TgYDPT2H4O7iLf0qJMAk4aMdWVphWSIlOacbrsI++9VnpX7
 dLUHiSo0ra5qn1cRFE+vGDDljJJg9oA9xGUkCdTkJ+ykvTCc/Vi/wZQsvOraUxeW3AIM
 PVCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5PzVndTERtpfpIyrOqgy/f3T/oGHPnSb2orNwsGnQ7BrvQgzSwtdynXk/WuoYpftwPeDOcJo65RzY@nongnu.org
X-Gm-Message-State: AOJu0YwEM563IShz30TGwki8imkIBv0S8ntWbXt3R5s4mbeAvC+j0rDj
 tk/8xBFrOR2Ouc4NjSheSEdaBf8dfF/JSJhtbOFkVEU1thhWNyvcJ6PhGfFFebQ=
X-Google-Smtp-Source: AGHT+IHB4iextuuphKkUqQAgnWYG/yDgBXWB4/i1Un3KrXt8Krpj/ZIF0WjatP7Ek1mS11bra8zWfg==
X-Received: by 2002:a05:600c:1f88:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-432def7e5e8mr96698635e9.0.1731933214124; 
 Mon, 18 Nov 2024 04:33:34 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac0aef0sm156980065e9.28.2024.11.18.04.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 04:33:33 -0800 (PST)
Message-ID: <c98e31f1-2017-48bf-bf3e-02594d58a8e4@linaro.org>
Date: Mon, 18 Nov 2024 13:33:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 10/10] usb-hub: Fix handling port power control
 messages
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org
References: <20241112170152.217664-1-linux@roeck-us.net>
 <20241112170152.217664-11-linux@roeck-us.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112170152.217664-11-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 12/11/24 17:01, Guenter Roeck wrote:
> The ClearPortFeature control message fails for PORT_POWER because there
> is no break; at the end of the case statement, causing it to fall through
> to the failure handler. Add the missing break; to solve the problem.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Change from RFC:
>      New patch
> 
>   hw/usb/dev-hub.c | 1 +
>   1 file changed, 1 insertion(+)

Fixes: 1cc403eb21 ("usb-hub: emulate per port power switching")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



