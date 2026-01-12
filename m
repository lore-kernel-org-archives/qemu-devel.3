Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1633C9EC93
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfImp-0004ny-GG; Mon, 12 Jan 2026 09:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfImn-0004md-Sz
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:20:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfImm-0004wn-CT
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768227646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bM7pQ7/2ST6jkt2mAHP7beyh5/3JJGyTKgnumNGbqjE=;
 b=Pg+Nrqdmzp9bovWxiYwilmX/JPXEO3NlyDHojfkkkUG5Enqd/DOp3ONqPOmRPNjifN0PX1
 PaXU2HRnkOpakKjF0wpE13yb/Ez+fR3/EVFZOUxAByUU0QBHsDr3K0S5cNpFUy25UxyWBf
 kgGcPigNYqcTO12OK+/FtzoJoR9La0M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-u2B3t6isNkqwXHsZDHYAQg-1; Mon, 12 Jan 2026 09:20:45 -0500
X-MC-Unique: u2B3t6isNkqwXHsZDHYAQg-1
X-Mimecast-MFC-AGG-ID: u2B3t6isNkqwXHsZDHYAQg_1768227644
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779ecc3cc8so45292055e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768227644; x=1768832444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bM7pQ7/2ST6jkt2mAHP7beyh5/3JJGyTKgnumNGbqjE=;
 b=m8lm6oWAS0N/1PVAzizoX1h49OAgH6mcR3w5tZKXaoUTY9icjxoctrrsMjEAYjerf5
 9V/sdlNB7y6Z9G48WKeA4zhhHrIDdH19sh/cFJ4qmdHUUuMh7ahxHkBbff3xuEDKRmye
 BvFgH5sXdFQt3FySCSvetEhATRSfoz5LdqwnEj+4960TiTel96VwPiEThtYFit/f2C6V
 yiAnzr3ldbteBT6zm3p0AWyvEIeI6Rb8V8+cuUAT+mX944hg52vV2pEhFAVyuexQuVLk
 a1YpWZLND7zG1TXEACBDTo4nxQSE2Gn7d3Tsb2PWBqJGYSoBL6Sn8BA032EbV6sf5f1R
 kleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768227644; x=1768832444;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bM7pQ7/2ST6jkt2mAHP7beyh5/3JJGyTKgnumNGbqjE=;
 b=G7ug+K8LLQkghn7nf1w5D0GteJJVR2eSzk5FtbRwzUM74R4wd2JOFRHvoWlP7yJyOD
 b+fcv7j81w4YmP/5DAYiJh6qvsEirTOHb5EAkEr9Vx4GWm+sE4+DCylt/nwcJo+vm8o3
 Rf8JKJxzNyG+xlReJrxr2dGXu/AUhiRO7IepSzYNjuhX52taDvEAcPSTnjq7nNbpw5x/
 bEGckmblOTfucI84aXrc7czYzAm9yjj3BLUtcjCb6I4Ka6foF+gGFQflSM85AM9JJonE
 q5njzSYRw7hG68jVMsKhpBsQSeYlW+apyP6E9BVImOG0qCiKk6mIJSEJT4WgyFlfcOOe
 zIEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3bBr4q/CXBXbDgyqui4cN/W+jxUeekzXN6pDFl5wOz2flxkqCjx0Re3JW6MyZLJF75mK7EaehWrh6@nongnu.org
X-Gm-Message-State: AOJu0YxZb/P8RE3TDg3nY3oSJ85m8qugtBxL+//UFdOSTMUE5PWmLscj
 nGo6MoRnfER/MEoFU9gKwEa4YJuQLQn4rhaZtQUffOtcdvCQL+JbwJOkAdEMkY5H72ItduQ9j+y
 ymmF9aeFkEnF1CUkAWIaPTpjtMP2VmJY6X2ymBDTEOoX4lfKDdB1EcJUH
X-Gm-Gg: AY/fxX5nXL3hsusReJ8zJ+VGyjMSt+uSRYeR0H3UUIhBq5s+UZ+GuczLxf+ouIHqzOA
 jMy9VdgK48lSa3/vwKBqTLVznetExtYr8+90Xcqqm7FB17QRz0qOzol5yWHnCamRPfu+EohPi80
 B9bmhZV3ygZCYng1jyGaWCUUO1PNjjBxwF2qf1kem4YARWC+vcnICxwrZFnruVakbeQRxcX8eYz
 jrOzk2maDQ8Y0NEmXb+V/M5sP/3D5aNuHcSo/WEtheFOLw0drQdrbNlrAnuSVg7jA9DLGnIB7Ly
 J9ww5PZsd7HTE4gQE8+E9yaQH9Jb8IrJ3kkzGzKLlNcB9C7d+u2FPLDKMn+tEkndBPeTETeXDJY
 e6P7t60La1sWXxdjmuScnhc5tPxEL3qhEgLkbjrGEoIuidUTwjvmn/06MXeWawCGhGA37q/kATG
 r4vaiLinMrU/1vBQ==
X-Received: by 2002:a05:600c:4fc3:b0:477:569c:34e9 with SMTP id
 5b1f17b1804b1-47d84b3b9e6mr229775655e9.23.1768227643906; 
 Mon, 12 Jan 2026 06:20:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQp7hejExk9+Qrf723RqxGVW2VzsDBsbER7EDPCXAynd8MXmjZsIZizoEz6czt2nwLzZz6tQ==
X-Received: by 2002:a05:600c:4fc3:b0:477:569c:34e9 with SMTP id
 5b1f17b1804b1-47d84b3b9e6mr229775095e9.23.1768227643309; 
 Mon, 12 Jan 2026 06:20:43 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47ec5d95edbsm140093435e9.3.2026.01.12.06.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 06:20:42 -0800 (PST)
Message-ID: <810068f3-5d9c-4b15-b27e-dc7b6a09aa33@redhat.com>
Date: Mon, 12 Jan 2026 15:20:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: meson.build:1:0: ERROR: prefix value '/qemu' must be an absolute
 path
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <e2f01894-dc75-411a-89ad-43af02847d41@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <e2f01894-dc75-411a-89ad-43af02847d41@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/12/26 13:39, Thomas Huth wrote:
> 
>   Hi,
> 
> looks like something in the latest version of MinGW (maybe the update to 
> Python 3.13?)

Yes, that is it.

> causes our meson configuration to fail, see e.g.:
> 
>   https://gitlab.com/qemu-project/qemu/-/jobs/12672816538#L397
> 
>   meson.build:1:0: ERROR: prefix value '/qemu' must be an absolute path
> 
> I guess this is similar to https://github.com/mesonbuild/meson/ 
> issues/14303 ... but the weird thing is that we don't use "--prefix" in 
> our build, so I wonder where this /qemu is coming from?

That's pretty obscure indeed, it comes from configs/meson/windows.txt.

> Does anybody have got an idea how to fix this?

Removing the prefix='/qemu' line in configs/meson/windows.txt should 
work.  Commit d17f305a264 ("configure: use a platform-neutral prefix", 
2020-09-30) says that the NSIS installer doesn't care.

I'm testing the change, and will also look at a fix in Meson.  Probably 
it seemed hard in 2020, since I just opened a bug 
(https://github.com/mesonbuild/meson/issues/7577), but maybe things have 
changed.

Paolo


