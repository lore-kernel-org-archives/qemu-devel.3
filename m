Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1F6EB26F5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 18:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vps1n-0000Gd-W0; Tue, 10 Feb 2026 13:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vps1m-0000GT-7L
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 12:59:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vps1j-0001Ml-Hu
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 12:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770746393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZV4XwfYXGn6CqVn5W1WEKZis7/D9Mj+J10JFIW2B2YA=;
 b=BUU3mNhHFtvfRJzvekG1zDVp2FUYIfW0GY1ETjWrg5jqnbIYHwwOyGC/xNAw6QoWWbUSey
 F/GPdHMaEruYoHzAeWb0lN6L3V1/SWdYPP4VRvEBWqbZHe6QvbTzt9U8vWPL7O1RVJ0gtP
 +KtgoWh6Bm/2f6catWo9s+PZBJ273ic=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-jJEH1V5kNoWDsPhUaZIW1g-1; Tue, 10 Feb 2026 12:59:52 -0500
X-MC-Unique: jJEH1V5kNoWDsPhUaZIW1g-1
X-Mimecast-MFC-AGG-ID: jJEH1V5kNoWDsPhUaZIW1g_1770746391
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-483101623e9so10061385e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 09:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770746391; x=1771351191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZV4XwfYXGn6CqVn5W1WEKZis7/D9Mj+J10JFIW2B2YA=;
 b=ZBuYQhVGBYlVrR3bEXXsfZeFkOLoCHXtxl6s8CiFfPrIFMN4LLsBhFmQfthXkdimnk
 1Wvu8r7xL3r2qNYFw8HRM+w+QBOj7P6tPTuu1ua7HuNJkMpmIbTIoDFoA/vLrX4MfdGc
 nLa1onwDR4zj4SobcVEBLTnnFoKFBnpSV42HwjZPdA6lMEIVexM1aT/zxN/kd/7gI7O7
 6bxIzUhZr+gU7Ajb2AboxO/keZT8MPKhx+FOMujdAv+F1c3Me1fpMpek+cnb4DB+qND5
 7rj2rDc8nL1jIDxHFel9dIhcg2smhALcAjL8n5doq0SKWULRxGdkCa4fpu3QSPkMuPVi
 /pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770746391; x=1771351191;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZV4XwfYXGn6CqVn5W1WEKZis7/D9Mj+J10JFIW2B2YA=;
 b=LW0lXSeY/G+ZrESvaT+YspDCsZotqnA231yJf3PZNhDZh2lzLpnR3IIeIUK211c64J
 Rhn5TwsIpVZTCNsCMzWs7R07TSI7e2V0sffD9izmyh/xiInHiK+0vAAXQm4VTH6vSmjg
 +n35Rr9BrMJ0Ipzt1DSIyMR9BZQkWMfn6wTcsCU2HgTRJRPVX9pbE9/4f/P6DyrjIMio
 d9dT6v/98AnQ7U06U4GMhq8UGhX8RyYMQ6qGJIt7hscB2MWaBdgpGAB8tIHqe3ioHcCW
 AaOFV+1cgOBjY8ToJ/LgOAwyMrE27Q+xv5RywkZIruQ7vZLD2l0rY/8bIjnvSrjBobcp
 IuRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuIwIlNFKorynqoTdz68vyHvEcvIKTTHTzyUOcJSh8LR7J8WG9aQIhbJ84825q+m6eEA26r42dQVwz@nongnu.org
X-Gm-Message-State: AOJu0YypjQsSBUv4gafNGK0Y+CWJ28+hahKBnsxfiC8C9sRLIJhTIFR9
 LPeqvXwQaNn/GSi+l+1voZPOfIYmdxMrVakJYtpYuowq6f9IWSFXoz6Zt5QtJO4u25mu5Q/Udvu
 xvua7ep0clyzfTQOmMAw2k/5x/tN0yOFktqqkWSq6U4RbAd0G8Bb8zuS7
X-Gm-Gg: AZuq6aI3QgBGu2QFx5VvGNeXnDP1gbcPJX30HoIC7Wx0/cvharshRWmzobylhX6T3nH
 KJUdjiXJvmbSI3PUPij1nGJ8tw7u0JPpQThOJJqnQRw3WTbl0Xzwz60Bh+o/LsI2Hmzw4ck9WAb
 tYpL/iZQ1rTWjyYT6wg2pG8XwbAFGExHAuN7EAEsDjrm80JlqdOCqX3hi1ZtZ0e+1/n6hCwm0dS
 XPH1h/96cLxhj4q5DjdrZCDgv6knIUxnmy453PYYRLmFKZJSa3lh8OXhXVOE/R3tOyAW0nGTtel
 6EZJCnigcEllzetYNg0FbaO6V0/fe4+tKc6TeHt9PmzlFJcHbP9sW69eUXUAzQpFLDWP2OzL/y1
 OOzFSSBvSo1LJ0ua5WKAHjfoCowxSFnw4+tZruaOdiXTAHFe6DspebX2hhXHIathSFW4M6WUbgh
 5g5JSTQ4X9tVyEC/2/40ITo2QI1g==
X-Received: by 2002:a05:600c:3e12:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-48320180a1emr229082615e9.0.1770746390688; 
 Tue, 10 Feb 2026 09:59:50 -0800 (PST)
X-Received: by 2002:a05:600c:3e12:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-48320180a1emr229082285e9.0.1770746390273; 
 Tue, 10 Feb 2026 09:59:50 -0800 (PST)
Received: from [192.168.10.81] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4834d82a4afsm155993975e9.11.2026.02.10.09.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 09:59:49 -0800 (PST)
Message-ID: <63a590ed-907a-4fa2-88da-b1be0cdda6c9@redhat.com>
Date: Tue, 10 Feb 2026 18:59:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: don't access 'cxx' object without checking cpp lang
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260210173355.776365-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260210173355.776365-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/10/26 18:33, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 2d114e9018..9ad16d1998 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3194,7 +3194,7 @@ if host_os == 'windows'
>   endif
>   
>   # Detect if ConvertStringToBSTR has been defined in _com_util namespace
> -if host_os == 'windows'
> +if host_os == 'windows' and 'cpp' in all_languages
>     has_convert_string_to_bstr = cxx.links('''
>       #include <comutil.h>
>       int main() {

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


