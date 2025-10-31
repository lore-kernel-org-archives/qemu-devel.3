Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D30CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElFz-0005Ir-B7; Fri, 31 Oct 2025 05:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vElFs-0005IQ-QJ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vElFo-000161-Il
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761902221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yIsvVMX7XYjn+xEn6I2l4X63Z11s2y3+uL83F8brPS4=;
 b=Y1MbuKXbLBoglXNSNB97a94zRLoHkonCAZfxUGLsyHHjec0kQfDwe2x/oGTD9no3Y8AxL2
 SK7H9zdNaUXeSlF85TWuSKhbgmjU6Kru9/e3Nrelfh10MHE9E2sYKOT2ZMtTP8Q2OU06y5
 6Oze0QrNNWlAEqu5Nh0yqrqp2YSzG1A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-cLDcCDN8NdaIlUrFOThFxg-1; Fri, 31 Oct 2025 05:16:59 -0400
X-MC-Unique: cLDcCDN8NdaIlUrFOThFxg-1
X-Mimecast-MFC-AGG-ID: cLDcCDN8NdaIlUrFOThFxg_1761902218
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3f384f10762so2164752f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761902218; x=1762507018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yIsvVMX7XYjn+xEn6I2l4X63Z11s2y3+uL83F8brPS4=;
 b=EormoQJqxCLve/wtjEop8+PCHY7XbShAwQRru9sMUmt9rNqSpEiIEvnrAu2tMJraE4
 HIO5TgQwh2snZ/koJ6Bg99/Lr2s5a4xHexqhRKIzippCL+Vo4ckNtRRBVS3wJvcESkKk
 NTD8498DSeQKxqMHrNV4Gml0C9k9TVxye99Mv3FXlTPz7sSjwQ6Nq1ejTaviRY6HMfu6
 vvEB595dBJ94h+kBdr6sqefyDuudoI6oMVZ0xcOnTRIRQnWoEu+tvq4iPZy+AVp+AgPI
 /pSzSTPYYWXb3GgDD3IIiD9GGYqITqoNlYKao1p0ouGWruIF3WD1eGDqwtBFcLt5/nxv
 75ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3PdP957jkzoHgLbm71DvLh72IpF871KwjSlG//bisnD4NRSuJlVyWDPutednRLBeyLsaDDw4kgV2E@nongnu.org
X-Gm-Message-State: AOJu0YxSvnUC5oa/3LE+b5jr0K9ziaVLT+qfMEJrwzOZucL7hCkXIc3r
 X3R3mI82N38YOrHk2RehW/VCVmWXS2Y/gt1VfxFK/KYJinzcTiRm7VI6gV0jyWx6J9V3wJQEPza
 ypTDN0QGd6tb6IBbIEPVKd9XsfC46ly3E9zgCX8T+87Gn8qqa1ktO1fdJ
X-Gm-Gg: ASbGncuNzf7F8WJze7J+XMFrHQF2o6axSLfx6yl/hXvu+jPBFXDoEJkWRqoPCeWeKC4
 cJKtBjoC6Rh4SjKWZgeOZJqZEe0suJvne0yA1Iq1uCYl1LCskbJ+Z+Ow9ghyQAwIO8L1EH05cB7
 eDirVbaUuaqARyiAiAzfY9Ncuhtj1fVbQOCUFtTxYjPQHMoA1bdL8QbCJUkzx9vm1Bt2J40K13M
 49/EHDDWh8najUc3dp+omxkzD1wgGY0+2hXyfBYQS5lcmsrTx2rAhNBBiylpfpUhINKg+h8ixIV
 NreP89HlQwSFWuOJElef8g9n8TctfIjRyFrRBToZePY17FtQXmIfTdLcfQU8BUt2oj57ET+O3Y5
 bgSp5dzMf3Do11jISRUy/JCZdpy3G6SpsrCN2gnLZGOV1f0RLAYBqpdNUsR5Dz49dB5AX6jRsEO
 uh4LWX/XDF5s5CFA4D8diiqttxn3/L
X-Received: by 2002:a05:600c:8b66:b0:475:ddf7:995e with SMTP id
 5b1f17b1804b1-477307b865amr23996465e9.12.1761902217971; 
 Fri, 31 Oct 2025 02:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVLS9n0P9SJi9TQPiulX1rjMpLPmZ42NKXf6FTnqEBitRg/kjGirlcXLxtHlSk/9YJReFS8g==
X-Received: by 2002:a05:600c:8b66:b0:475:ddf7:995e with SMTP id
 5b1f17b1804b1-477307b865amr23996115e9.12.1761902217498; 
 Fri, 31 Oct 2025 02:16:57 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47733023256sm22702185e9.17.2025.10.31.02.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 02:16:56 -0700 (PDT)
Message-ID: <51b4f94a-fcd5-4043-943b-2b43e9366433@redhat.com>
Date: Fri, 31 Oct 2025 10:16:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] gluster: Do not move coroutine into BDS context
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-7-hreitz@redhat.com> <aQJKl_QCyJiwfOZn@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aQJKl_QCyJiwfOZn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29.10.25 18:10, Kevin Wolf wrote:
> Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
>> The request coroutine may not run in the BDS AioContext.  We should wake
>> it in its own context, not move it.
>>
>> With that, we can remove GlusterAIOCB.aio_context.
>>
>> Also add a comment why aio_co_schedule() is safe to use in this way.
>>
>> **Note:** Due to a lack of a gluster set-up, I have not tested this
>> commit.  It seemed safe enough to send anyway, just maybe not to
>> qemu-stable.  To be clear, I don’t know of any user-visible bugs that
>> would arise from the state without this patch; the request coroutine is
>> moved into the main BDS AioContext, which feels wrong, but I’m not sure
>> whether it can actually produce hard bugs.
> Doesn't moving into a different AioContext mean that everything down to
> the AIO callback in the guest device runs in a different thread? That's
> definitely a big no-no for virtio-scsi, and I think also for virtio-blk.

It does, yes.

>> I’ll leave it to others’ opinions whether to keep or drop this patch
>> under these circumstances.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> It looks trivially correct (famous last words...) and the bugs not
> unlikely to be hit, so I'd say keep it.
>
> I have no idea if the gluster library is actually thread safe, but if it
> isn't, that breaks before gluster_finish_aiocb(). After reentering the
> coroutine, the library isn't called any more.

OK.

Hanna


