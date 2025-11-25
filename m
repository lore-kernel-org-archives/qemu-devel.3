Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F67CFD368
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmL7-0004WA-NJ; Tue, 25 Nov 2025 01:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmL4-0004UV-Ll
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:15:47 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmL2-0001vW-2F
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:15:46 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42b566859ecso4493894f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 22:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764051341; x=1764656141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0f/9Y7JR60Swip/dFOGxc5iPJjQDRvPRSNeJxakP8wk=;
 b=HcOd4FK431JVDzh8QNCqgpEhZ8lPc8Zh5xfuYaIAZrlsFQ8T3ZL00XoZbP/8TtaC5j
 UXqiQM1Uv8/pvCbsqg7Yjgqoux+0bOoLiJ4I6mVEKTWWmV6fXTGtEDwNuGcFcndikbg0
 N4VG9R4EJQ3GWQeNz8Z5wasQZbDb0lnrYiMMt3JlsdhGKZMQ0cvNzQ6JJCzgze/3XLT8
 fycFZrozf7w68+U7ElKtu7jagRaVoDf5amvYdoOQfa3h/WnlCME7MmKV6bBbYSQnkShq
 8124bqh0sDB9aeUF0uJVKXNnJoZuwb1nmhGPZfyuFHMUc0YHOtLRDqwX+mOZ4mbo/IIG
 YgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764051341; x=1764656141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0f/9Y7JR60Swip/dFOGxc5iPJjQDRvPRSNeJxakP8wk=;
 b=cyfQcXBCHRLJWmMom03yYxUij5Abmb9xp93rfKaBq4vr9BbGH/gqxkKeT3UnzTGx/6
 gV2zqrd+/mYTxBl3cuTB55qQOhYXcU6l5Bur7x06JkKV/kASe5qw+DKWpK9hxQL5wFP8
 0C1GQ1iOl9KtroSlWHUZtKtgKPB/xfUOoNY/GDfRWJdfHoOUKzbTZMUnfRlk6pelhh8z
 TGKK7mEvfi8XtHGk4lXKfOooEAXSm/HDEhMrTyZhUJEP5CYzpNduT2SYYPz0hL08zBOm
 SlCzY0nIY7bhSCmkHMUdmOMF+hB6J9Z87d3Z84JCHEx8VYo82cV7T+glYV7PXskY2rUu
 yDnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc/IrjF0O5qFQqweiioPBHx3Sy+RJAhfMl5Wyq5AgdCYN+FH+JYUiC9PzE5S24zJ5UfP5flUjLh3rD@nongnu.org
X-Gm-Message-State: AOJu0Yzq61mhyu/eqpcSS/84jsc2cS+6myhWLVbMBvepjgbPBa2Utb5e
 xf0EWPHkhMEHHnpF3DQ5vDUvt79RR861GJ85WPYsM/vIYJyX8p84d5Hw5Un9dN0EkS4=
X-Gm-Gg: ASbGncseoILYTNWnCTSnB7W6ROZoUu/djfWC35swFtyC/98pIirLS7ny759U0dTkIoI
 w5YdRKcLuSkifWhB7ANJZWrG3pM06RsTbjBdcQe7t50ZL4ewRAPcSxBcRa+xz3DfQ7BjTZeoEJx
 /8YK0mXomzXN4qrH1bE7uDOPBQLGBQhE6+TMWCRy9h8mb8UQZsSxO9WYKHrmGjaSS2G1+fbfDeW
 m6qTqjF7+ljX4KCvZINmjaTqv26HOGlGfRboEE59UXKkfHPbBcmoTyet2SZu0uQgQns2MH+ch5b
 f0a/zSauXG690xV8NUi5tzh3V3rhMtjUttWlBk+i8ctx6nEPjks/pRc+xN91/BR/m8A9U+XbPqp
 nDU2to/1+hFry0beStf+UM5ForTw866g80+mWMUhQ0GI3gOKzuFGtI7qmAZ0S79GLjdlGK+mf3j
 YvLbqJgt+UUU6PFLMcs6yAlQ1mI9nl1H+zq6kuy4pbhoNwr7/OAO/p0A==
X-Google-Smtp-Source: AGHT+IHZNFdwNkAyt39hw1XEKeec2HDhjScGvIOI1PKKSdFRbVG0BYsnK8PrGv30KDcQUn6wPGJ2MA==
X-Received: by 2002:a05:6000:4028:b0:42b:3366:632a with SMTP id
 ffacd0b85a97d-42e0f355caamr1135311f8f.39.1764051341155; 
 Mon, 24 Nov 2025 22:15:41 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e574sm32156895f8f.3.2025.11.24.22.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 22:15:40 -0800 (PST)
Message-ID: <7984cbbd-905e-4e03-84fa-1cc2a1261a80@linaro.org>
Date: Tue, 25 Nov 2025 07:15:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] error: Strip trailing '\n' from error string
 arguments (again)
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, alistair.francis@wdc.com,
 stefanb@linux.vnet.ibm.com, kwolf@redhat.com, hreitz@redhat.com,
 sw@weilnetz.de, qemu_oss@crudebyte.com, groug@kaod.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com,
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 sgarzare@redhat.com, pbonzini@redhat.com, fam@euphon.net, alex@shazbot.org,
 clg@redhat.com, peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 dave@treblig.org, jasowang@redhat.com, samuel.thibault@ens-lyon.org,
 michael.roth@amd.com, kkostiuk@redhat.com, zhao1.liu@intel.com,
 mtosatti@redhat.com, rathc@linux.ibm.com, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, marcandre.lureau@redhat.com,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org
References: <20251121121438.1249498-1-armbru@redhat.com>
 <20251121121438.1249498-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 21/11/25 13:14, Markus Armbruster wrote:
> Tracked down with scripts/coccinelle/err-bad-newline.cocci.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/audio/es1370.c | 2 +-
>   ui/gtk.c          | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


