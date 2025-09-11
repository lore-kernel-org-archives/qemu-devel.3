Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4FACAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 17:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwlT0-0004Zz-J3; Thu, 11 Sep 2025 13:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlSw-0004ZB-4t
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 13:52:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlSu-0002dX-HU
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 13:52:13 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45b9c35bc0aso8798875e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757613131; x=1758217931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z5hTueIFTsXet+IHeyLQsu3av3Sa6CMMWAFG15WxQRM=;
 b=XaOvQCmXVZG1JP4/pq4a2F/LKVcSRmnMR9S3aqIxJN0rnWU9aAt7KpByP1YxMajBRV
 HrWsNC5JBGJqsyIVdN+7yY7g+DK8/01BCiAoMN369CrN2M3hLknfZH+j1F+MzbPnMgeb
 UNal3NO8xoS/lgQ7udX/qxe1Q2HOeeWnEwFWByZJTD4WYldZtv6do6oRUD7jM7D1Y7zS
 /OBCNq7ymZhKeWEAVBmtGbBrnkG4rSywC9MiQENo0uEBfXSx7rbCwLfOUCRmmGdexJGW
 dqNVYci4J9n9iRFk57thitYAI9vXM82bLVwDv1ho4ix/8T+vbUz4jfHp0WnZUeMXuF+R
 cPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757613131; x=1758217931;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z5hTueIFTsXet+IHeyLQsu3av3Sa6CMMWAFG15WxQRM=;
 b=bzzhOWd3acZj9jpwTEg9VuIbYtJJ5eSpmH1IjSZvK7kfCaNgUxpDfXtvb+DGvcpKi0
 QYL2b8lh0P6ArAphZjqSNvPUeAXxu3lZHioK23Z5oHMSscyNNzxY6RNSaTHZPrAIxGrb
 bIuOdMCXgDUWuJ4xpMGWxX80/GIfcL8itU9QmwgeJezUT5IZnZ0YZVfhfA+DnITCiCIu
 NdTts0HypeznKoiI24RsiEJ//G6LTMYdjZ0eysGklw5j1zRYV1DaX8iGAotx90I1Dxrv
 U2Bbj3qJJhv+Q5qddvY3Ni4M3wCTvUpJqKSSwbXOUknQ9iomZx98PIUlB5ku/LG8xW21
 5Cew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdEU4kqNVCo+UDvhaQB797tXwInEn34Qrwe4oaH9NA3fLdQ9+MZ3SdQ+osBNVLvvLf9+wM5sDKwXZ2@nongnu.org
X-Gm-Message-State: AOJu0YwQLB4ZOj6QYdAcj0Qvk8Fk30PNsnkxjSqyGunHEfT/g88nXLZO
 r8Ailfn2P68F0a9BcGUu/XHgpAnITIcqbQBg+WnoPiVRXxROxg8VSIqosVJxoBrx0f4=
X-Gm-Gg: ASbGncsnraGN9ePp5sV8HbCob8qZfVJTwDdlmqy1OqCVYRd9lf8vzlOnk3MpfWCCro/
 2zJQdATvEIhWyr0mc7F1Yt7EcrgfNgSEKhIZ6y6nefy+3dMT/ETHhMqQDfjBUYTuIUMqoFFGmhB
 qQi/fqS+xb/pm/ib/4Qujgp7MuJzcOwHTX7Qcff3y4t9j7lpviGZK7MPBhmsl4yGHNoEfhl3DJH
 CXMO6brmcYimrhkfHsXclH2wnKBQ7WglFGegogFhMP7L5RP3WukXmkr9CYU4jPUjBrxXrV+x6UI
 75MvkqCwB4TYgJR2+fwl0j9xt04R+IJirfgUjvqOQaXEsCPGUrDCQws2cKgoZCcNcuVYN0YLxjT
 cg/60ZKtKjDJG153CYcnmT3X9BGPkXWpSHUYhi5jUYWW3duhSMW66ruy9nB1Eidsz0rTK
X-Google-Smtp-Source: AGHT+IHlkQJUMOIPRJKN3H5tmmnBIfOm1P2Wrnuu64g6j/hYrC0pCmWpjiyQqSd1urlJaCvoUge9hw==
X-Received: by 2002:a05:600c:1d2a:b0:45c:b5f7:c6e7 with SMTP id
 5b1f17b1804b1-45f215641ddmr334125e9.0.1757613130538; 
 Thu, 11 Sep 2025 10:52:10 -0700 (PDT)
Received: from [172.16.30.12] (ipnet-92-225.static.simnet.is. [157.157.92.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e3a91504fsm19249905e9.13.2025.09.11.10.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 10:52:09 -0700 (PDT)
Message-ID: <cc61c14a-d0b0-4c16-83fe-e98af1640b8c@linaro.org>
Date: Thu, 11 Sep 2025 17:52:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/20] monitor: introduce monitor_cur_hmp() function
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-13-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-13-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

On 9/10/25 18:03, Daniel P. Berrangé wrote:
> A number of callers use monitor_cur() followed by !monitor_cur_is_qmp().
> 
> This is undesirable because monitor_cur_is_qmp() will itself call
> monitor_cur() again, and monitor_cur() must acquire locks and do
> hash table lookups. Introducing a monitor_cur_hmp() helper will
> combine the two operations into one reducing cost.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   include/monitor/monitor.h      |  1 +
>   monitor/monitor.c              | 14 ++++++++++++++
>   stubs/monitor-core.c           |  5 +++++
>   tests/unit/test-util-sockets.c |  1 +
>   4 files changed, 21 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

