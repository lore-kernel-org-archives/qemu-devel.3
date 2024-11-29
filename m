Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10D5D6EC0A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 13:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH13v-0003hd-9d; Fri, 29 Nov 2024 08:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tH13s-0003gm-Ex
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:29:32 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tH13W-0001MU-IR
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:29:29 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-29680f21217so991251fac.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 05:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732886947; x=1733491747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dQkFijo8KhpeJmVU9OMLc0DU2VxNTADZ1C48cceEMEU=;
 b=voBzaoRjPf47JUQGQ3lbmo3pkG2pDz+EZKZC3EkAlgBo205r6eBMNT7cKhN4skqv3M
 Ldk6u4KWTc5rTNBMFl2zU62EYhgf2FIDomNgmRK0p8wzOs/0KUh8tSDsRCdT8CJd2mCO
 qkjgJ37TOnZ0huDYjFVQLioTz12piG275AEvYhvH6QeE0Q7Pq+1BhdL6oYR8RWuWH9Wi
 fQvjCgN1WaFHHAcqpvI7KJBSZIQw5/3RdABRNYSJfMEL9xgbaoiKLX2uijHZP8GcRRPY
 9mG369mhvol6HzGafI0b/1liECTLgNa0hQ6YaJIJwB0Na8J1v2D4QbuBNjhaDydSvVXN
 VPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732886947; x=1733491747;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dQkFijo8KhpeJmVU9OMLc0DU2VxNTADZ1C48cceEMEU=;
 b=G4rHrSBVuhBA4TQ+5yX1ovw+O6IOVZE2apflDog6X4b2PlKm2E9EnFcvgKvDTh2buC
 dgiGPpjn3bpihmSfiiic4IT+cWkIypOjqpwoqv6+zUWlK2lRuXB1U03kKNb91KEgktM6
 MzJRoGpCt032d7xfXQNHwwnisSxdQw/O3BnOmqAlaQJrgedatSFjvmCAo6enkG7Cbeh+
 B0KO0/qHT6BTIq5iERFFlD/wmG6cvmrRP9TE0tIkfmKAdvR3XKlRHEAoAuAtmHOGXTfM
 hQLvP5ZAgEHSYsHlsw6JHh9PzOlFGDkfSnWGMGh5QlsNogrqxMIzkace7iLX+D5s1QLP
 O1VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUko26wcxikGW+zyBinK6ZeeRZ4dZQHAkfe86oqYc0438KvooZZVar4IYbHco7rqUSQbeKE/5HZXemN@nongnu.org
X-Gm-Message-State: AOJu0Yw8e896fPF1ewJ1NPhRyZjNnOjWYdhWjHLaKJNyUWShu9p28/WF
 oJMXuNOSKBSfupriopM1zazwH8FY+JDy9OwN/JtmgoHZpb3Bm5ywM5vZvDCM9Kk=
X-Gm-Gg: ASbGncsEXjNjcRfE79LL01ibzW9zRXOZcy8fdHQ8KPoJ0FTLBO2WPebLjeX7QWI8oSR
 BMirTtoPh/F2vbvr1aOLEG4oX1WQRt5vC17ekWH76uJTE6l3vkRLL7b+K0ZfxVVSsAiqSwzggkH
 v9WaK4bYKy0z/Gvw2ebltvBngIpUmVt53wUDiGOhc+5+hekFj4OdMnalp5PXv7p/lki0UWWQQR+
 +RxDEiE3jb1SgiBFJpzIpaEUZU6OZfgPphwhft3gdXWiCVY6seqEnrOv0rKZdAbGIRJWZdBqtyP
 Tzj580m4SwmC1eZDPur3qwc6iMqt
X-Google-Smtp-Source: AGHT+IGFsSpQp3b/TFzDH+mDEWU3phllBAXYGYobYJ7wOTFk86/sFmJ6BeQZDXyCiz1xpO5v/eIx7Q==
X-Received: by 2002:a05:6871:288:b0:277:fe14:e68c with SMTP id
 586e51a60fabf-29dc4304a53mr9072662fac.33.1732886946787; 
 Fri, 29 Nov 2024 05:29:06 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29de9bd87d9sm992701fac.50.2024.11.29.05.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 05:29:06 -0800 (PST)
Message-ID: <56210680-d6db-4618-92d3-60af0c999241@linaro.org>
Date: Fri, 29 Nov 2024 07:29:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] plugins: optimize cpu_index code generation
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20241128213843.1023080-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128213843.1023080-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

On 11/28/24 15:38, Pierrick Bouvier wrote:
> When running with a single vcpu, we can return a constant instead of a
> load when accessing cpu_index.
> A side effect is that all tcg operations using it are optimized, most
> notably scoreboard access.
> When running a simple loop in user-mode, the speedup is around 20%.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> 
> ---
> 
> v2:
> - no need to do a flush, as user-mode already does it when spawning a
>    second cpu (to honor CF_PARALLEL flags).
> - change condition detection to use CF_PARALLEL instead
> ---
>   accel/tcg/plugin-gen.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

