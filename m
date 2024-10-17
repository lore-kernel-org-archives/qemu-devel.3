Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E4AD37485
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 13:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1QSu-0005zY-FH; Thu, 17 Oct 2024 09:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1QSt-0005zI-K4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 09:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1QSr-00040m-B7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 09:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729171371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xbplN+/Ifik3OynRBaINhEZgyBpX+Rtd4y6ee8O1WF4=;
 b=bJ8jb4X1Fo7rnVsB7kYFQyWYUzn0GxM4X/mlJRXKYcOb9YQl/VA79JWrbQ9gyjWyz2xvfR
 mDfHKwVzoawLJcgxSCUbdSW3xKy8EM9E4P7XoG3x7yE0vyjLzeM8O2qFDxeId/qDLhhPsK
 h7wfCR569Qyy4YTZrhdQhQDI+nyhCNw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-18KnFr2RP-GnXN3OP7w-Nw-1; Thu, 17 Oct 2024 09:22:49 -0400
X-MC-Unique: 18KnFr2RP-GnXN3OP7w-Nw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d5a3afa84so416814f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 06:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729171368; x=1729776168;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xbplN+/Ifik3OynRBaINhEZgyBpX+Rtd4y6ee8O1WF4=;
 b=mx3Oy8rcVjTWDALNjmPCMRMb9FdZPPZ3RQ7sZMSgSVKsikbjDYAUkVPj6nXDan/wBi
 7v+fd2+TvDglp/d2wLI8E2EyG8iwTM4PGm0MdDeBaezdmw3WfnIx30yYSE2s9pNvsbd5
 5ZrSvQDARCg+b/0PYlp/rzaUCzTHEXCUde3nRmMCqaYEx/8LpLKsMjt/1QM9yPIx62tw
 kq6ReskNOpbhEA7S+1JUN2Ho4TW0o3YufeNflY8fqYnwtd2+Jj4AsjIqthTZLtZXq5gO
 LdaTFk3C18ZoDWgRh+BSRojKtDEP7iDOt+GTDIKsClIoS2cydLk1gOqVEwMZJ4QeikWE
 WWWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiC3gIkTPRxFmc/luggfv/NtRcA4rL6f10Ka1zrIIp9Ucmu4E3CfILAzubbCAEbxyL8SyaUszEQu88@nongnu.org
X-Gm-Message-State: AOJu0YwHG/JZnNeNyMC5pYQZuNM/pdUEztBgFZjcg2YKW8mzcoczPav3
 v2g0LM0u0Vnys7f0qK4Hc235FBjawsMWO/0zYGCa8zleBLUy1+EQ/ub0f5e0w83cWTopVGMPgK0
 ITQHKaTEjoGYPmZNyABcWsOg/ILmGDNTVbOScSV9W/1lFK6sApjTX
X-Received: by 2002:adf:e44e:0:b0:37d:54d0:1f20 with SMTP id
 ffacd0b85a97d-37d5ff2f180mr10952555f8f.24.1729171368482; 
 Thu, 17 Oct 2024 06:22:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn+JXF3D4ig/yqDcdEY9vURtYAtd5JXIN6AQcxpf4BIaNyLYoUzkiGiXPsrmGAqCTEVYvaZQ==
X-Received: by 2002:adf:e44e:0:b0:37d:54d0:1f20 with SMTP id
 ffacd0b85a97d-37d5ff2f180mr10952532f8f.24.1729171368087; 
 Thu, 17 Oct 2024 06:22:48 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c4061bsm26128735e9.25.2024.10.17.06.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 06:22:47 -0700 (PDT)
Message-ID: <2ef501ab-df75-418b-9c94-df47b9389723@redhat.com>
Date: Thu, 17 Oct 2024 15:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] riscv: char: Avoid dropped charecters
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org
Cc: Bin Meng <bmeng.cn@gmail.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 atishp@rivosinc.com, dbarboza@ventanamicro.com
References: <20240910045419.1252277-1-alistair.francis@wdc.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240910045419.1252277-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/09/2024 06.54, Alistair Francis wrote:
> This series fixes: https://gitlab.com/qemu-project/qemu/-/issues/2114
> 
> This converts the RISC-V charecter device callers of qemu_chr_fe_write()
> to either use qemu_chr_fe_write_all() or to call qemu_chr_fe_write() async
> and act on the return value.
> 
> v4:
>   - Drop the unused char_tx_time
>   - Update the migration in vmstate_sifive_uart
> v3:
>   - Fixup spelling
> v2:
>   - Use Fifo8 for the Sifive UART instead of a custom FIFO
> 
> Alistair Francis (2):
>    hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
>    hw/char: sifive_uart: Print uart characters async

  Hi!

What's the status of these patches? Are they good to go, or do they still 
need more work? (I'm asking because I'd like to convert 
tests/avocado/riscv_opensbi.py to the functional test framework, but it 
would be good to have the problem with the dropped characters fixed first)

  Thanks,
   Thomas


