Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8F2CFD368
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmOo-0007gK-JD; Tue, 25 Nov 2025 01:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmOm-0007fF-6L
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:19:36 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmOj-0002WI-LI
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:19:35 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so42172085e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 22:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764051572; x=1764656372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ayCvkqAvPPz9n6xMxwdSlHGHuKgh4PUChBb7KqLIT+Q=;
 b=kGeHMWjNSLMNj8Td7E+OMl8EfYh1fyXt1ylgeJI/Q/EjqNHdzSn+SuSCTYSS8izen2
 nSSfadLxiy3Q/I2/S69LkeYvXTHL+9kMy9XGsizDIaxAL94Ala9/XYk80JRw8mOY5oCu
 ez4go5Q4rdwvvChLwxNOczvayVC4kNSRWLDMOOuMOZQb6+VLRk8i2HsX+cw0mUjPxzve
 VaAemBzZ7pGmDDbm6M61rMcL8E9fv81NqqXckrS2vUq1qHkza9wCAjUWZLdSA+cXsIYr
 iL703fHx2rNmQ8FCIgUq4zj3OY0bCsYL+52qct8bebADX6W3O1w4X3iNLTwnMTW57xMk
 rHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764051572; x=1764656372;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ayCvkqAvPPz9n6xMxwdSlHGHuKgh4PUChBb7KqLIT+Q=;
 b=a8TzFmLzc8vT0uxinKinyNUYsFw17Mmvf8N8ug68Tm2F8cQkb1d0yxpf6A9eCmjx3+
 9VZrWdkliH8j5xXtvJrkI6y5aD4Ladgl04U5lZbbN1xLu776Hks67DmzIxS4+Fot72R+
 XV4J8nEML1kT3RWDMqzxrNW8nLzDjL3gXsjr/e+bJyRYXEOfIhgxQfZqsym6erTok1an
 PhPh0uqC+syMf2GMquuGL7Bq62K8ToH6SUyOdavCUQLcLAmm3vgGpwKsO06LzfYGGM32
 D2bJtrxjheYEGe18n6mQxLbYan2aIqwJPgs5dRo/q7/nYOmtKI4LeaiO9mlVGJ7k0a9t
 onLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS9dS7eCItYXL905LPxOEWWPW9W8BmnJdQL+If0FNwAo23cyeLX43ZXSL+/nFJGynNUzOEmi0uglvF@nongnu.org
X-Gm-Message-State: AOJu0Yw9QCxOCl4/h+b0xBrEwttmG7QifSp5TqZSS1ssTmGKa+oDO3Wf
 HzEBlsR6nrY7XxD9eEeQiPw4GzRVSK9uzysbGJpuJ9yomYDqPz4IwWyfkdRHI44Tnbw=
X-Gm-Gg: ASbGncv/vLNWU3NqHrwGLs1WVtleHZbvA8aqwn8KwxEC0Qo+Dh2JV2DSvU0sEb/lfQs
 Dsejv4Nil4J4F2FRxVL7EFLCm5rTgmT3oPmGw4XeYzoTnkLgkZzfuKBxYl1cM2e3C1Xk/guceUZ
 leFEPG0gApjxFgls6urW1HvJrJJCWkNN60+LuOkt776PBYDpiqyniSh/68xwwYtdxC03NzyvKKs
 PjZPabFWIB10zw6+HbA3FpZFcRIzaavHVuiuZF7h783LgEppRp0ZcVwxqgnJ/4L3U2uz2J1yyBd
 Xtv8LnxmK/Pzz26jWBpfC7WJEodWWv5GGIvYU52sKL1wFkFiYuzpHEqB4H3cXQSvhTw6Iwqylbq
 HWmhkJPryDUY6zu/BuDrPxoHWY/eogQ8JMdYG5NG1oEOmVHkrftA443xyJ2qnkxqOaQn2Qq/6vm
 +SaRKqxzRYB2fenwwE+sfYwGNOGUsKFeI6J5slnVIarsInE76sHdXvFg==
X-Google-Smtp-Source: AGHT+IGCGhdbHAxDlOenXxyfRDqxklvPY0q7ajM0L7BLu8g1ZJkCYTA/gCYbTbb1g7QtxJ0wSEDH8Q==
X-Received: by 2002:a05:600c:8b37:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-47904b1ab30mr12611775e9.16.1764051571921; 
 Mon, 24 Nov 2025 22:19:31 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3b4eb2sm230183655e9.12.2025.11.24.22.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 22:19:31 -0800 (PST)
Message-ID: <786d2523-7e15-4a41-afef-ee97adcc414a@linaro.org>
Date: Tue, 25 Nov 2025 07:19:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] net/tap: Use error_setg_file_open() for a better
 error message
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
 <20251121121438.1249498-9-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-9-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
> The error message changes from
> 
>      tap: open vhost char device failed
> 
> to
> 
>      Could not open '/dev/vhost-net': REASON
> 
> I think the exact file name is more useful to know than the file's
> purpose.
> 
> We could put back the "tap: " prefix with error_prepend().  Not
> worth the bother.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   net/tap.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


