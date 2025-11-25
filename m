Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D63CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmQR-0001Cs-4r; Tue, 25 Nov 2025 01:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmQA-00014t-Mu
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:21:02 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmQ7-0002zy-Ut
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:21:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477b91680f8so40362055e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 22:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764051657; x=1764656457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IHdaIX7rwIeWEffIotS9OpDD12xZA8o++Mo+VV+T6/Y=;
 b=lZgOzDjXdhfkgWqB6AyvyRgAdo3t5K6pgQ48+dPoQ2CAW5ecJKAmbCLS9yzpQLkfoX
 GM847LsOG/RZMMjMuOvQIgtWIEWK6I+lomOxO9W5qihPmSrHVhgMJgNzQGRVELk78PCd
 WTMruD7kbZwryxSzuY8qa+OltRqlVMISzzfkwtyyXWA9rsCd3A1sZ678xNzzR9qrm3GY
 L6uBzw9oCGSGzBbi0PSBKuhRRRjYEEKfoaxLSgnrIQ7dc1YyrtVgOytZQu+jjeKgJxqd
 lwgGcMOB0lO83/JZXwjNVFdAg35vPBj5Mdwoorvw0TY8d1LirWIjaaFrpSAzu/ebaVY6
 gSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764051657; x=1764656457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IHdaIX7rwIeWEffIotS9OpDD12xZA8o++Mo+VV+T6/Y=;
 b=VnAMB1FhtvliQIWFiSY7oXIwQvvQtpfcNZ+AwZA7BaNOyagbIlz8kiiosh1dJG56Qy
 yiksQ2JDr1R+9ivwBJrKBEECi+IKxOw8BBio55gSfFjIXOWSVPCz4iCclAoLMnXf/6Oj
 N6muAt9U+8lncFxc3+anDap/B98vMF+P7YhzRgppisPt2XO7dXc4F5ZB1CI3CCRmGxgR
 QAdfTVb+NvsiAZ1iyHjSgqvay6kE4DFwDDUAKGt9zIBHvrZGK7G2vQekhKE8UpDeQAon
 cWq2901gHzqBjaI8xsdotHOgFbVW/wX0ik+JWPoBcI8KwA5bpAGpr7l/kMX70rbdv9j9
 vLPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGLdCuxFB+QTCVo8uLrI0rMv3ZXiYj7EahHeqFSFd0roEXdyRrgPGoW/m0ld2HHBsXhcHXYohoGmeG@nongnu.org
X-Gm-Message-State: AOJu0Yx25cDRILLOztsEi5uDzQ/dzgNqP2poXgk+fGY2+NRAz0ciIl9U
 kX/P5SY/jlI4O9tCTPfC01GxY5q65obxcVxyI5OLgljNvofRQlvDKCY2iRIgG419MQ4=
X-Gm-Gg: ASbGncvGXkblVMLHSqv+swp2rqKgcfBhjJvYqJ/3/TVWIRq0zCVuj0FnlCK7isBlCmM
 HDBO61WgPZeOGPZLRBq2ZwDQKdjFQ5Rr7Hyq8gkNtDLSMs88ewp4jUelgC5oaDbixotrEdlpggo
 3+k5MLGf+fXmq/HmS6hHpkqiZVOmzPFQ3Oy7HN77HygvGfpXFNcC7ctCASJAHmbd0/+y+EWHz6X
 Rv5fbhkOXAw1NYQHwRfG4UwtVbK4XYyZGq3dh9QEHQA74K9sNgmNFAwdAwZImxZ4No4Gf19xVzQ
 EwKdvsKn5Qraejbpl7tzCNLis9GDkHSeRVLylgDQJvnk7yVd/gyQejek4N76sUG10c+ZZPbvFZS
 zZ6gOEKPKhsyyrOryJldOP/OOqdz6gQVSOJklb/7uTh4cGzb/ifBJrfAxz20GBe/cFuau6igue8
 1/PveadJRfwrtWX0JVPf5niLbLaBEW0g2/+Ep7XGYSuZXS9e45sWU3sw==
X-Google-Smtp-Source: AGHT+IGHe0GiKC1Okv4GPlfi6I2wY+Fb1eNjMNxPpHleM142ga2JmmwQ8xf+kkSIPlYpCGBLlQhrpQ==
X-Received: by 2002:a05:600c:45d1:b0:475:dae5:d972 with SMTP id
 5b1f17b1804b1-477c1123afcmr152637055e9.23.1764051657266; 
 Mon, 24 Nov 2025 22:20:57 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479052a7330sm7911945e9.3.2025.11.24.22.20.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 22:20:56 -0800 (PST)
Message-ID: <ff36ffaa-1a17-41b0-bed2-0fa38fead91e@linaro.org>
Date: Tue, 25 Nov 2025 07:20:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] net/slirp: Improve file open error message
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
 <20251121121438.1249498-12-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-12-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
> This error reports failure to create a temporary file, and
> error_setg_file_open() would probably be too terse, so merely switch
> to error_setg_errno() to add errno information.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   net/slirp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


