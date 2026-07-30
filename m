Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1979BC55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpSWt-0002qg-Rv; Thu, 30 Jul 2026 11:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wpSWl-0002nu-Gb
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wpSWj-0006rC-Pu
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785424708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TvGuWjt98mMB/5oxypCBoffjP/SiYT1DYDCusE9EVjM=;
 b=NZ52zbSsp78txzAhfCq9zkrlsThoMWxl7LW26/paot260iis+lo0yf+lz67dphmaNyxjA0
 8gGrjPCtBqjypbxPdxNqVJJaiGjT3axoEAuSaElXzCpnidO4DnNVVYBw+Ku8JSpfyksv4w
 HlXaVByACjfpc/IQ+rc48Dj5b8+lNGE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-nO9SrnJyM7GRbFXrc1VyyQ-1; Thu, 30 Jul 2026 11:18:27 -0400
X-MC-Unique: nO9SrnJyM7GRbFXrc1VyyQ-1
X-Mimecast-MFC-AGG-ID: nO9SrnJyM7GRbFXrc1VyyQ_1785424706
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495569acf8dso15444825e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785424706; x=1786029506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TvGuWjt98mMB/5oxypCBoffjP/SiYT1DYDCusE9EVjM=;
 b=oeIcR38Rgg+9twIWSdFyFd7TFUMKNjjTDAyjhSyqBgK5R24R83eNGYH4FhUYKfuxR9
 8JeG6f1HU9cBtlSR5dThoThO7irRxREDFMDXOU8eK4iBr1ky2TlyAY6HMGnepzs9r+p5
 grztLMa+gtE8QjZuv/BNJyeIyo9SSK3bzOkSu7BeJkRXvlQSWxmK35PvCUQ2wr1K/X+2
 l0oXNjIJWvF9gIPDcqfXgxQbJC+Z6W/hp0wXBFgp8LbfYOx29wHPHRUAO8TZk1AhCduk
 +2Gf/DtdSNfulZBmG979cwQBg3POtcBCqJdutbbUoVghlZaj6stuQuFqwyMB/75s19ON
 j4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785424706; x=1786029506;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TvGuWjt98mMB/5oxypCBoffjP/SiYT1DYDCusE9EVjM=;
 b=gsCnYvOeRTUMTh45JvUK4a7B5PwaymNYtqPDvgjt4vbYW5bEo9QzIrIWJeepob3qrh
 0LrimTumJSDtZul3l+iToC8wa3Cr/eDXWfP9beQ5/oQO3HT7YO79aXD3BcZtvYEI+dXV
 mK26A02uArLoEgRb6JR5IJUtUEY8mTww2TJyiKLBihxKLbyEU88CfB6yT12gx7ZSxlwr
 0nu+ED1cLS4Z7O2ainR9WU4onNyznok7iLkgt80tn74dpxDh27qdOqirzX/5VIcDc+qf
 SuwhcKbnMJ1r1/AUuW0e7iocfSFfLA+T1peWUdmbRGudg/WwWoc1P/IimvH43GpLpZA8
 QFfA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWd4xD73yk2xVqmjZHDT7AgaZXIdtbcd1nlboYVQ7IYXcpC/I7tDgTXyjnpDh/TILTuoUyl7i97rC5@nongnu.org
X-Gm-Message-State: AOJu0Yz+PneGE5Cw5m4OuCODWniy7axBmCxWxOt1OaqE3jeQN6co3jbB
 cVTxbT0E6I1pHTVaMmx6rzDj9G4F2KsqeZiVZfKvOPmYoP0RBWpPq2PunJ3nSIcniCki3CgkePG
 jbBfVNdUqDzzi1zO1osizfMkC6cTwkv1LQcjUCGLTWkEYBo5X1967HZN2
X-Gm-Gg: AR+sD12jUwAvAoq4QMuPykK0XQAc6b/lzNEAqJgH65AFBYOwlGIG2ccb7U17jL9x1/z
 dMfxZIiEGBeNQadpVV/BupYkThhJUWUVKQW5VUC6KAiluMpx5T/d6IjSvWniROer0gS8i6rFt5J
 Aae98zNVvBcWbjwyk2zBrf6bTBxQOqzfgPqIt2p782r9DigYiS6SLdMOedQG+PilwIfCoVvG8bV
 QfRRfmZT0x9AvyeNb+ujImanXFRa4D7TytrHErbSLq8SIMq9EW11kQNw68iKCLkQODfKj7pN9SW
 xAUjfMsRR5OuahKf5zwVKpWVC/Nm/vDYBJob0pN6SsMpghvJnJewPeRg
X-Received: by 2002:a05:600c:698e:b0:495:641a:fffe with SMTP id
 5b1f17b1804b1-49804c74936mr13471175e9.39.1785424705900; 
 Thu, 30 Jul 2026 08:18:25 -0700 (PDT)
X-Received: by 2002:a05:600c:698e:b0:495:641a:fffe with SMTP id
 5b1f17b1804b1-49804c74936mr13470535e9.39.1785424705486; 
 Thu, 30 Jul 2026 08:18:25 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.51.53]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498010a0ae3sm71408395e9.9.2026.07.30.08.18.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 08:18:24 -0700 (PDT)
Message-ID: <a753b710-d95a-4592-af73-b7399e4866bc@redhat.com>
Date: Thu, 30 Jul 2026 17:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/8] tests/qtest/ide-test: parametrize the ATAPI CD-ROM
 read test
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260730081325.1816193-1-den@openvz.org>
 <20260730081325.1816193-3-den@openvz.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260730081325.1816193-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/07/2026 10.13, Denis V. Lunev wrote:
> cdrom_pio_impl() and test_cdrom_dma() duplicate the same image setup
> and data-integrity check around two different transfer mechanisms.
> Fold them into a single cdrom_read_impl(nblocks, flags) helper, with a
> CDROM_PIO/CDROM_DMA flag selecting the transfer, so further read
> coverage can be added once for both paths.
> 
> No functional change: /ide/cdrom/pio, pio_large and dma run exactly
> as before.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   tests/qtest/ide-test.c | 146 +++++++++++++++++++----------------------
>   1 file changed, 68 insertions(+), 78 deletions(-)
> 
> diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
> index 721e78170b..0fcfd0688c 100644
> --- a/tests/qtest/ide-test.c
> +++ b/tests/qtest/ide-test.c
> @@ -982,6 +982,7 @@ static void send_scsi_cdb_read10(QPCIDevice *dev, QPCIBar ide_bar,
>       }
>   }
>   
> +
>   static void nsleep(QTestState *qts, int64_t nsecs)
>   {
>       const struct timespec val = { .tv_nsec = nsecs };
The above hunk introduces a white space damage. Please drop it.

  Thanks,
   Thomas


