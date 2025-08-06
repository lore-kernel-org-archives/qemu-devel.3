Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167BFC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhfz-0004Q4-9d; Wed, 06 Aug 2025 13:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujgtU-0005ix-Ly
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:21:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujgtS-0006tM-TP
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:21:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-458bece40fcso796875e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754497292; x=1755102092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZGa1sHVZSagYKWld3bN0hVlGS1xHr54lBXbLOBCh3S4=;
 b=LUe4fBBKzLzJk7zOxE3/IFbJ/5aCdN68ZxovstMSBUqhu6H4of+OvcZhPRdmwMRqKf
 o5Al+pD2dNSWYWIVlWOgzvFZxFk9bYQ2YTHmYLESDwJGm/8WpYYY9b/gR+JRufQrGxPA
 /YzJNXGMJWD5PFWsiSt/LVw7YDR3FpKOH+aeoSHw5cPisKG4dT39+LYAxTlUYOTwuseh
 reBpmRTZ0cRwZu+32pD5/cl0YJ5cFEKJ/0ZufnXxW7mBH70oMJbccRQS7so4wwLm+lsr
 crGkfQx662+H8o5jZmkEGYV39S9xpIFb8VBaXfahP7ydcT76wpnAzLaIl0dqXomlRUcm
 f/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754497292; x=1755102092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZGa1sHVZSagYKWld3bN0hVlGS1xHr54lBXbLOBCh3S4=;
 b=ckIQcZLxIK0wbBW/MwGxn2igsxhSG6cTWL5RnoohfftZ6XkdRnaxGllx1myJ7T7M8u
 wBytknX5QSsQgtxdd7WXBWF6dKCAQeNMRszTSk00fnRZAHYDWC3ix+J9egiajM7rwsA5
 aGg3bXOAhkTM2t5wTMjcgSAql5TsA2eIcL6VEEVC9qxxTqvQcU0JxCrnEIxeDBmkWHPl
 WwLw/qjQXq+38EsjHx04fKnI5MkBhnZlb89zKDaZr1K7Ci1dU0Rj9PKVYcE0xgmbEEUq
 TtVPldU5/mn6jcTVioJURGoTkSpLOA5mXlBRScrLAKVZSilba9nLJVsTQn08jtcb7bvS
 1NXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb4EjnqOIj7hYiRlYUQCE390SL6WI5g/2BCuZt+EKtVLquZjzjOXDdJl7UXqbswQtOaSqyz0wJZGQh@nongnu.org
X-Gm-Message-State: AOJu0YxfFiF3PaFhjrriVVoyj+0CwZwNHaChwPwbLSDXjJC2josnOLzZ
 hiZTRH4ObqOUyQOnKWW3u21ICRa9t9KOz22aH0oEqlDbfwIGb2Ak9kvr/95Yy4ZfBEE=
X-Gm-Gg: ASbGncuuxEScG4EjDCL7+1uaxkY5zAIlj894bGrhohBWqZOWSlO77EPxgYAatOZn8b4
 YdSp9AlAANBYigQSu9eRXXfT8upIIC03/h66zeu064o55tzV0IeZwS2UsXV3htSSZ4JiXPMoQoK
 Oe5Iz8+W9I34lAYV1xMKkyPM6DhlAOtQ7qoTGjNGAjOX4mqbLtC6+QAPts15faLFukfJjDhAGg6
 7rXPdR9b/y8Ata8Lr1zfScHEDJfhtwlc8tzGrzppjfO4CwejWEzVujq/CBPmmfQv+DPxP9LdUAu
 o0VQe9w7G2DFWvyBwYjFkLvrrurF/cgrO0IOHu3GoPRAAer+pzkePl9zU8Sz+sLsZ0Y24stCq9J
 Xxwsu6tWjUIa0ls04be1ztBzZQT9Kl+KThxnGI7Jo2t8ZZBDScS2SfumhPKdZ89jp9vdhagTHHu
 rx
X-Google-Smtp-Source: AGHT+IEuvnP1gyT5makkCXLjgOy0S/c8VFGaOaBGbAWLOu53wMrWkeS3TsHhOR/nAh+ePtcx3VS6Gg==
X-Received: by 2002:a05:600c:8b06:b0:456:13b6:4b18 with SMTP id
 5b1f17b1804b1-459e79efa95mr34446885e9.31.1754497292129; 
 Wed, 06 Aug 2025 09:21:32 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e58542f3sm54441135e9.10.2025.08.06.09.21.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 09:21:31 -0700 (PDT)
Message-ID: <0215c941-26b6-44b6-a05c-c1cc2b0551a8@linaro.org>
Date: Wed, 6 Aug 2025 18:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1754494089.git.ktokunaga.mail@gmail.com>
 <112b6882f9bd370deffb8637116fc44e043c250f.1754494089.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <112b6882f9bd370deffb8637116fc44e043c250f.1754494089.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 6/8/25 17:49, Kohei Tokunaga wrote:
> Currently there are some engines that don't support wasm64 (e.g. unsupported
> on Safari[1]). To mitigate this issue, the configure script allows the user
> to use Emscripten's compatibility feature, "-sMEMORY64=2" flag[2].
> 
> Emscripten's "-sMEMORY64=2" flag still enables 64bit pointers in C code. But
> this flag lowers the output binary into wasm32, with limiting the maximum
> memory size to 4GB. So QEMU can run on wasm32 engines.
> 
> [1] https://webassembly.org/features/
> [2] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   configure | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


