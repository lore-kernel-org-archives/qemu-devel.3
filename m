Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69D2CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmTl-0004Tq-NQ; Tue, 25 Nov 2025 01:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmTU-0004Qh-Vh
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:24:29 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmTS-0003TE-HD
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:24:28 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso38434015e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 22:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764051865; x=1764656665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vq1z7uETBPWyiFMQkSi+G7SH23QCq9t1LMUTYPMDnpc=;
 b=UY25TzbACojPkGnY6vTt4W1y22wz4Jsh3sx0XTC9k0gy2yK8B2n4efDZjByG8wwazW
 567LCm0Yzmioc8Z/Ed1OhmkrKZL2wV00yCI1vlvyz+Ijrlk/qNo8Pxxgc4U+rtULflFI
 1y+TwykxNTiBgxymbiohTrISdbPsZEdnWshpi0nU+yZ91uKPLNs8gcFOuaIW69ISNCV/
 RLFtedqauSrIc2FzjOJMxIv8hzGRsohzTH7WFQKOfDbE+hFKbX1GRYDUOxw6MC+iGgjA
 9+0R4boJvODyMGUwGwawJmhUJNr00+5eJK9pY36hURk1sx1VWlAuwZ+2wjaqDyXjhDMa
 hhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764051865; x=1764656665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vq1z7uETBPWyiFMQkSi+G7SH23QCq9t1LMUTYPMDnpc=;
 b=RdegjgCNQnK25KT749ZdmBcppm+MIhM861dAGJIRHZ1BQFOySLhhSwYmTeFZrAz9MB
 Eg1SecIOFJapSGpsfhRrqVLYOAQBqvt56nKHQT3IkmIjUslbk7Nf441Ionng9f9IsZ9J
 g2QRI+OF6E5AYIhGgXoLcq2f9+CtvP14LgjdppSM4l9zh8CoxVF/Bm2Sg/wVsnF7HS7d
 Bupl4GDimEHUVewBlgVBnpiOV0lG3vAX0wTl+7Q3619/iBdVz81ddKoS4W/sXA9tuwMF
 jcgpuKeeUxk026Eg+ywi8HKgBettdNQEPQcHwfLS4PExjIlNNZtNjk+nBPWKjE9IpkvJ
 9Gfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuzjx5qMODz7Ju914sMnocWQdjh9NYPt/nDoDfn7SzWGohqIUfNlAD7keHf/5QYXmrfHbcp1kA97jJ@nongnu.org
X-Gm-Message-State: AOJu0YwjBr/uu6XK6aM48l9W1I2vh5uhujxsZsY1wjQl5wlwO1TYXYKU
 RSaCZpLWcMUO/N8BGTm4U+rwx7KeAXPXdC1asTC8I/YKwFztmblmgtWaQEK1ecm3URI=
X-Gm-Gg: ASbGncsnBR3OmRGT+yobLUSph0uqaZIr1/q5u4oTAzQ/iMfN4u6XT3JDYQDg4GbniIR
 UPO50lfCs+/GDI6HwkHlRf6HcBoMhk/qzmcY8l4OHQlIBkCBbgBhAP0Ww514z1o7IHEs+yeQxAu
 4T83e1wyNZRqoFmxkKDk2ZbdbhwJYNu90eFLXSPrRatXfz5i4p67DVsg+Vu5BPZZvHjkrQQyrem
 7l5fUN0dTOF8g7tl7Mx/EhCBQmRl72QoENw7/IX2GBuU2ffmuZAVn7EXyU4WItHyYZwVbDbYgbq
 mNuNWGm0v9FVnMboqL+DPfTIZzuNolk8vgKiaQ1lAyFfZMZVPwaccGXzwHizaJ4JiyEOA5ELlTg
 wKxT3YMpNMJ3Dx0kJ1kmk7YwmfKqKpF3kqusCc1EQqHXxx8ms5mIBFBaNY2JGGgvL5A+jAh1oo7
 AmlPUS6ZDa8Bpt5JwcwlF8IbPL7BtAAc5nGKqntPrERcJs8scJslPpjhV+0gEZpPvS
X-Google-Smtp-Source: AGHT+IEaf9VPAlvbB+DJWu+zfTWBlEbYA/AGQ5BPVvtwmDg4JvdCIECBmvF4Zcsn6awffVSNfsJ6Hw==
X-Received: by 2002:a05:6000:228a:b0:429:cc39:99c0 with SMTP id
 ffacd0b85a97d-42cc12f1bddmr17201116f8f.1.1764051865045; 
 Mon, 24 Nov 2025 22:24:25 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8d97sm31796036f8f.42.2025.11.24.22.24.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 22:24:24 -0800 (PST)
Message-ID: <f356b3c8-ed08-4ec9-93c8-dc9dc6accc59@linaro.org>
Date: Tue, 25 Nov 2025 07:24:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] qga/commands-win32: Use error_setg_win32() for
 better error messages
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
 <20251121121438.1249498-15-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-15-armbru@redhat.com>
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

On 21/11/25 13:14, Markus Armbruster wrote:
> We include numeric GetLastError() codes in error messages in a few
> places, like this:
> 
>      error_setg(errp, "GRIPE: %d", (int)GetLastError());
> 
> Show text instead, like this:
> 
>      error_setg_win32(errp, GetLastError(), "GRIPE");
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qga/commands-win32.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


