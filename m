Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D90CFD37F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqI2-00036J-8z; Tue, 25 Nov 2025 05:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqHu-0002x5-7G
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:28:47 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqHp-0005k3-1h
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:28:43 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-64162c04f90so8871861a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764066518; x=1764671318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s1upGUE7YIUICVmJUED5d5whRme8CL9poQ2KbESMmuo=;
 b=q/Ax3b+/4qIhuEOW9sU2poEUkZPSqC5dNcX1mzxP66hNNPaxHNbJa4Dz3b+0HbR+cx
 9/98QdTFHmUyqvL4PhXVMNGlngvNxxl7bizt/2rFFQGjEEjuyjFVyBy+cw5Uz912j7Hg
 5TE0llJve0lvTjhBKbqv3oRrIpEPtNRC6OoSwXJdG+5oGMmycsVqqYplLaFXswqw5FSL
 7lE21j5Cp1iJyIsgV+yuH9XHjYpEbawWO7HIB4zZnUKS6Yp6S02/vy8xgIQvjyiZeY+3
 XCg01sqdk/eMx52ykCHTgGgGexHJtbGNOYqXC7k/CSdksK0CLSepPafnPqMlaFXnmnzz
 p+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764066518; x=1764671318;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s1upGUE7YIUICVmJUED5d5whRme8CL9poQ2KbESMmuo=;
 b=rwXpnhnJEHmn039Bkinw2F1b/1vZ19aaCJEXpEEWKSCOwKxppgUq4dPKRcS+ebcJ44
 C90e/uMHvho6YnNq6lRR1nnAKna8+EHpwoLyc6I6NDKJdOVydKbiiA9JAqzx4AUJwvQO
 0MEUGiPXkmLKNeoLLI/qJzTWQ6X1KjEWEiIrI/m0F8LSaduL3O1jAh+VSTdWgc9AIQ8o
 O4YJT7eNIu2t8LxE0cNxdgbnrb0+MrMe3rQMfHs8y4b3rx27g1dPVUss+OGXbtY/+EtT
 sDrX/6D1sps8LmzEhCC5ShfAxqUfjxHiDNsmFZ8bOBhHOB8anV0mOgRj6BdHNaq/V6z7
 2L9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvd2YcZmiDrPZfPNoXEcjj37oO9IIix2o2i7f6qkPOlO81Em6X+dUklSBXKkWq98GMA1iUJiuq+fr0@nongnu.org
X-Gm-Message-State: AOJu0YxOq1XUCpK20YspFOu5/cqUhmbPFBfGO8/sbj3M2zvwcugdU+gQ
 0S8lNYygzKI3fgbrxwwOsnilY5/rUe/afrsTqTuWwcaf8S7hoJkYS1Ge6xuxNUT3UKY=
X-Gm-Gg: ASbGncsi+J/4W+6L07W0AXd/c379sf5csYGLcwZHsGH9FkEMHfMxyFquRYMYEQNIxA9
 RzG9SoAm574XEkPbGvZEpXCNco2Sj99QJuKAQU6LnGOc7TSyejJ5d1TbrVj0V7ecVv26iZ3xaPj
 o+wSvb9Aa/7mdoATHHwsD7GIlHbgDdsaxsCuvAoCGOxZzPyQsiZGDW6oz+2RoL6lGGOPBcEzlMf
 wYYePTWA2L2Gw/s/DD9z1DrODZ2xTWGqlPHInD9wB6SfPEMThTBNdgpoP0PyPtu7DeslP5UVk/q
 3uux1u+Gthb0U7Cki6wOJAK0M2LLUxSt2wq1dctbmrXn+JzN39YHRjJc1essXvN1wImCw7b8JW1
 Yz4vtTbDQ93TOGVrmbPenmVz6K4T19HHeIidAYJtOUZkvSmITFsakev0kF/+0D0C4sLm4orm39o
 Z9yMCWmyKTYqFT2dne7HjLXzOJAb7Xyk8YSJlJphJCHqzWJ85KYBoVUw==
X-Google-Smtp-Source: AGHT+IF59L37GgnGAgNCiHvqRTLRI2aTvHyr6yOsdF3ewgBPJ+5ZCFL6F0XLm22Mv4gcL1oVkiKNmQ==
X-Received: by 2002:a17:906:fe0a:b0:b73:8bd4:8fb with SMTP id
 a640c23a62f3a-b76717322d4mr1729884566b.42.1764066517609; 
 Tue, 25 Nov 2025 02:28:37 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7654d3bfcesm1536852566b.15.2025.11.25.02.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 02:28:37 -0800 (PST)
Message-ID: <b9cd0110-4a91-4ef5-a139-2dcd45b2a0cc@linaro.org>
Date: Tue, 25 Nov 2025 11:28:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] blkdebug: Use error_setg_file_open() for a
 better error message
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
 <20251121121438.1249498-10-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-10-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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
>      Could not read blkdebug config file: REASON
> 
> to
> 
>      Could not open 'FNAME': REASON
> 
> I think the exact file name is more useful to know than the file's
> purpose.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   block/blkdebug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


