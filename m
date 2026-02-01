Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855AFE6529E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgdb-0003Rt-O5; Sun, 01 Feb 2026 18:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgdZ-0003R7-VO
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:13:49 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgdY-0007aw-ED
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:13:49 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso28096305e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769987627; x=1770592427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IpoV4CtWQMhR6ccftsw6rK1K0I3VOvpUSNFkYKJSS0E=;
 b=g6cnsMA9rVWV/WNz4ePik5C8VKVQS0QjT+4MCdx6loRr7ExwPPrBrh/S33RzsQzxXo
 bgnDxlPwB5WyurL82zUutHn2Ey3vI/jjvo4p5XLx5AbZ8DY13iLTDiutUrT7SSYEWgpD
 Mn+LvibtsnZbhUl4di7nXE/g2vS3vY77dDIepQoKTCuN8ngsk0JV99IxGJrbBygduL/g
 fTyS28dtVpdXWUVPPjqwK9eOhD7EQi1NdC9NByxETgJmG60gQXQIAyRROQp8uezCiRP1
 Sl4S1ToK8/kW5QI3BA+3jy3w/JPzDtnI8gowtGb2yi0/4uK+YtTGBqHcMHSOKI53OZk/
 XhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769987627; x=1770592427;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IpoV4CtWQMhR6ccftsw6rK1K0I3VOvpUSNFkYKJSS0E=;
 b=GPPXw6c/HiJtcupatmh9o/4y6OQto4aHSbdgEUfLALUL+f+8SXfSiKGa2MnJUCfuzq
 jU/TkN3wpIcz1cOoeL3xEKh3Z/2Uc1jnqRTyXPpdYfdoGXvzQ2icXShl7gBygWn0bx0v
 9v/uEF5CEd+4nHLaG2AA32A26ViybGp3x+J3ZdwjA9BuYXDD4jGgjueJYw9xCHdFXmot
 007rkZgmUe6Q5QcaSXLJwAxrgvgEV7pM2Q2GKYXKoHs2Ivr7a64IZfnKDamivC4TO7YI
 bGdYI6ffmxgEKz6wqsA2hIgYMhBh0xnq7HE8uuXCVIiHS0L+HaJ6J4Dzl+fNEB+1wiLd
 GMbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpyRbOMpnhTf9Xy00pRTCqmMsc75rsF1j2MYVd1Vg3cxcU6VDY/+0jG22zn0zQkWviCx+yv6wTyyvL@nongnu.org
X-Gm-Message-State: AOJu0YxezX0rgLt847ZCpYstA5dVn3q0hPhOGnbtzIWRZnzGEStGnOje
 n/wNJxWZn9jLZH1HrVg0AXSrFl6uN/7RwER8XewgMtnlqrXuEwKao8Fgf7I4eWgxlgo=
X-Gm-Gg: AZuq6aJc20eqCo1BTMwgPmbQUu9m/dEdoWJFuRvIkRU+tzo5+0A2pS7y91VeOaRuw1Z
 0RHWVEjgQQgZWgUdvs67kJQ+BoGz0EvYFD3RgaUWpj6Pw4P8PKn2sywplWvoG00ViTqLHtN5oWn
 6AcewYGu8pC4SjTzwwT6KOp2jDarQ+HlGaOP1+bW6A0rsOtQNonQsI8tuX0R5ZtTolP7a0wwFFv
 9TUNNspULIIeQmVutNnxvoCNySLa6awYtWDmBv+yJrqshGEAMj+fq5biOgePOps2Ih3HBCjhluj
 RPhysV3x8gsiZczuFFg7bzId8D/nsXeaO/N+mm/rLgx8WXNKpxzKGFRU+SEdjzDTzcbieqn5AYX
 5LEXiEylxz/se95mwznEKYW+S0CrIYztiqhLhUHfkLoNjwq+Vx6CXz0HzBKKw3iWBYdrlrXXuA4
 49hYEtBaVRtLCL6ske8NNIft0AKjnNvxThPBc3BWP4xyACr97xOjz3ag==
X-Received: by 2002:a05:600c:1d03:b0:477:7f4a:44b4 with SMTP id
 5b1f17b1804b1-482db4567d6mr140740435e9.1.1769987626759; 
 Sun, 01 Feb 2026 15:13:46 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c4f3edsm402147645e9.15.2026.02.01.15.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 15:13:46 -0800 (PST)
Message-ID: <b9ed56d8-8064-4095-b27c-f5335fee708b@linaro.org>
Date: Mon, 2 Feb 2026 00:13:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] hw/virtio/: make all compilation units common
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-7-pierrick.bouvier@linaro.org>
 <41492c36-9207-449a-b1d4-beb980d494c7@linaro.org>
In-Reply-To: <41492c36-9207-449a-b1d4-beb980d494c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 1/2/26 23:28, Philippe Mathieu-Daudé wrote:
> On 31/1/26 03:01, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/virtio/meson.build | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


