Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7ABE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBqk-0002MC-KG; Thu, 19 Dec 2024 03:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tOBqd-0002LN-Ln
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:25:35 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tOBqb-0002JB-8Q
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:25:31 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-728eedfca37so595822b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1734596727; x=1735201527;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o67QXlwUSaMvrSq2RNzS6auV65CBM03JHc8UWQQqHC0=;
 b=UozECgo1bLUOMxAHxSN0T4V53vkKLk8rY0pUTZvuZc1fL5y53eTQiGQyg77wLqy98w
 /pg0ZXkgYwvZNKrU2D01AueWVsfOAfhZeZ0Rxkx45WXVlRhgvvEkye4qPhyLBhDzGtwW
 4dfzY82AFqZ416LWSICoj07X3ty7QnkzTtuRZsJ+jP1s6EyYtus6W7ZyC2wlZpomHdej
 vkBIenr4JeAlfadLaWo2EVQC9i0/fj2azNeMXhZljP4ih8wuX7ofJX5SJziz6NLiBySX
 SGINvrm7W5GaxAAtWGMXmy2m+mmvHD0qj373+cgt7gus+21x5/n3lNtuZrLbyhWGctMp
 fdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734596727; x=1735201527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o67QXlwUSaMvrSq2RNzS6auV65CBM03JHc8UWQQqHC0=;
 b=sI3r/1U6owbA12jsOByRU8fZvnlQC+ME68k3WofJgJqhnPsL0Tk4L/qlppRxBkWpkD
 QSsPkmQG7aNx8b60MGojdUOPjtgnmGlVmC2DHvOqCmc51Kpr+stqHKK5dzKGLYqQZPfu
 fpYVyvq3qAjwboNqey2GWDsF/H287hxQg8P0Y3r9ZH93Yfv+3ewNp1JwWfGlh0mW0Ii6
 FemdwJ2tZbEiTmUtCtdMG/YQqUQ2gcfZliae+MAmN4tYo8/dWtMphOuWWTy1Cfiy/EtM
 Cv16+3b2e7e8IYcW+gEa0qFUlMKj650Aeobw4Wx2s6kuibKR1PGIhzcSq495eTlV73KT
 91Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPRkTDMA1P+UTEdqTPQ09pOc/qC0F3rdJvG+sDIXUyfhEeqHeRPTaTH2TcEo6FIEF6DhxkfABDCJuC@nongnu.org
X-Gm-Message-State: AOJu0Yy5C0dg8boI2+x2hz80ZCcb7GD5sKlWaUworWHGXfWegFqeEzbI
 QdYjXqBSGNE8eoJNQ9rFATbiREoH4fmPbW+XvxmM3hyZ8GtuDqQdWVIuaz8e824=
X-Gm-Gg: ASbGncvsd8Jtsf1ZIM/0bPZQd8eptMqZOGT8eA2A5355hyHF9IXh18FAyu1DACynfuV
 Dm4IrI65xTy9DBil+DP+4iZ6o2tpiXUV7KI8Zj/6kCtOe6vdRzy+nsRJoHBymAoyioi7Q7vNL4a
 S34vUUcMZ9vke9WZmN8UWW4hf3zEL/GWj5/P253giGoiCpC7rB6gpUcH6PJGRqqHg22xmuu9l/g
 eWiTTxsmay81mbt/7NeDjCVGUXo6Bj3PYocu+on1jPbefSm5hzkhWStHjtPJXW4g6c=
X-Google-Smtp-Source: AGHT+IFQJijP415U6JCAjCp82uq02Rg1oj+u9Wub9o3NGSctFU+2+abvxdsWCEhdbfKwmOkWOvHyhA==
X-Received: by 2002:a05:6a20:7faa:b0:1e1:3970:d75a with SMTP id
 adf61e73a8af0-1e5c74f3244mr3839079637.9.1734596726802; 
 Thu, 19 Dec 2024 00:25:26 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad90b2dcsm731694b3a.171.2024.12.19.00.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 00:25:26 -0800 (PST)
Message-ID: <6c0ed1a4-d416-4d52-bbfd-40faadac35c4@daynix.com>
Date: Thu, 19 Dec 2024 17:25:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/71] hw/net: Constify all Property
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Pavel Pisa
 <pisa@cmp.felk.cvut.cz>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Bernhard Beschow <shentey@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Helge Deller <deller@gmx.de>, Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sven Schnelle <svens@stackframe.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Rob Herring <robh@kernel.org>, "open list:Allwinner-a10"
 <qemu-arm@nongnu.org>, "open list:e500" <qemu-ppc@nongnu.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-46-richard.henderson@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241213190750.2513964-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/12/14 4:07, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

