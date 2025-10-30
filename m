Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D86ACCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 09:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOcv-0006cd-Cy; Thu, 30 Oct 2025 05:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEOcp-0006c6-2f
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEOcl-00018f-6O
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761815229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HK5KGJUtyGacq2JZ/rntUpqp7CfkiIVklMhSsKJob2c=;
 b=TFoICh3VVM2BqnNjpi26t+6/Iq/e1/8x26dOzRG5lxUhjndmlbIOmdF7k2PPP8HgD1FwSb
 wV4UzYZxVL9piotsKHeL8zdAjVwnCwmBQhgGe+qqlWDOFnEQdoXG2k7B7m2ySHtwZGqLyD
 DNYD25Ejc+e6FpoY0KpXzpANiZV3myk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-hZqWQQcvMmackM9g2fgemw-1; Thu, 30 Oct 2025 05:07:07 -0400
X-MC-Unique: hZqWQQcvMmackM9g2fgemw-1
X-Mimecast-MFC-AGG-ID: hZqWQQcvMmackM9g2fgemw_1761815226
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4256fae4b46so927397f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 02:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761815226; x=1762420026;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HK5KGJUtyGacq2JZ/rntUpqp7CfkiIVklMhSsKJob2c=;
 b=HHRMP5tJLN/6klh+FGBA143nsDQr/nuVP0y52WwqPJf5DqJ84nVmg2g2ygv4yUBKkP
 eXYzUjaN1FaIeYGBZe1lDbwgspY2hhXUoiQgbIlZgNowh7Q83KgwxxeJh/WbcPot4hpq
 6lPFUBsk6i60l5y2KHZ4H4gCXtENqpEVLQjm8ho2ImKv0bEWXikFSNFTJ84jC4J1ixGB
 /BKqEZcqA7IZZ/DpnFn4rk9Hf7xAcRPshn+gBilQ65+i+zBVf5EFhAkjUOfTkfotGNaZ
 sPAFnFIp8hY5AwDxFa8vnEZvqUNDHnFrPGezHkf+4e1nz1wiJbfK8YSytGvk1wm/ptUb
 2/yg==
X-Gm-Message-State: AOJu0YzPuizz7E/Unxfu80gc15BEt0AF67fGFsSEtI16yVIED3LCvgLn
 E4mJ79onFTEafsud2z3oQyMVjUZckMfinjN8WmdQCnWchpo/1QHn8+0NzZ8/zB+PKY/xLylz0gN
 y9PEwq85GwAOYlKT4UHW2eovQO0cmR1vISCTX/NQcTyVL3Wc5BgNlfyOY
X-Gm-Gg: ASbGncsQIE+AMpfHN3BXZghIHaReNFuESaLGapAyx9zTxUju+XJrdZhaMR85ywKek54
 fPIoGFQXkuDO+CsdUm+2f/3z7MxsIAtLUpemq6EJ9n1ddFusSw50hXfS5PpAW3DJceOF9ikRRFr
 AkA/Dajx/G/ZG6qFb1rN1bi5RWuzKDCjmQXbN/6ySmBJefwYJmr7/GYFPk7WiyssimPUdLQdSeO
 s9vxNvgJIG4UyQNupRYSFrihG/+xgi87rKwrEksVgXB1mADhKRqN8rkOucXsWeBP/sL17AH1g8J
 gn09L/zaVivwO61GUSZQyVqFspitBLVo7rQUj8QEZqrDlgfORpQWr7pmsuzPMjzT7g1p2zw=
X-Received: by 2002:a05:600c:530f:b0:471:13fc:4ad3 with SMTP id
 5b1f17b1804b1-477266f37dfmr23497815e9.2.1761815225924; 
 Thu, 30 Oct 2025 02:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPKk6GzwKeLf2EgbSEhEx0LdBaCh0sqOlFzpULhKvjNN90+7ph8kG8uyZC7UUAjK9wPiElZA==
X-Received: by 2002:a05:600c:530f:b0:471:13fc:4ad3 with SMTP id
 5b1f17b1804b1-477266f37dfmr23497415e9.2.1761815225482; 
 Thu, 30 Oct 2025 02:07:05 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289b396dsm28187075e9.11.2025.10.30.02.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 02:07:04 -0700 (PDT)
Message-ID: <a0c828b6-61ca-4be4-9e08-591a89c28500@redhat.com>
Date: Thu, 30 Oct 2025 10:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/12] tests/functional: Test whether the
 vmstate-static-checker script works fine
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20250924063956.519792-1-thuth@redhat.com>
 <20250924063956.519792-5-thuth@redhat.com> <aQIBVcKRMDUjeeqK@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aQIBVcKRMDUjeeqK@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 29/10/2025 12.58, Daniel P. Berrangé wrote:
> On Wed, Sep 24, 2025 at 08:39:48AM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> We've got two vmstate dump files in the repository which are meant
>> for verifying whether the vmstate-static-checker.py works as expected.
>> Since running this manually is a cumbersome job, let's add an automated
>> test for this instead that runs the script with the two dump files
>> and checks for the expected output.
> 
> This job always fails on Fedora 43, because the vmstate script
> output includes python deprecation warnings:
> 
>    2025-10-29 11:53:55,097 - INFO: vmstate-static-checker output:
>    /var/home/berrange/src/virt/qemu/tests/functional/../../scripts/vmstate-static-checker.py:385: PendingDeprecationWarning: FileType is deprecated. Simply open files after parsing arguments.
>      parser.add_argument('-s', '--src', type=argparse.FileType('r'),
>    /var/home/berrange/src/virt/qemu/tests/functional/../../scripts/vmstate-static-checker.py:388: PendingDeprecationWarning: FileType is deprecated. Simply open files after parsing arguments.
>      parser.add_argument('-d', '--dest', type=argparse.FileType('r'),

Thanks for the heads-up, I guess we should now rather use type=pathlib.Path 
in this script instead. I'll try to come up with a patch...

  Thomas


