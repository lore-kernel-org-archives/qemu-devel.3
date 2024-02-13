Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9AAC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZra0-0006wt-Si; Tue, 13 Feb 2024 07:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrZS-0006pc-W4
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:07:31 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZrZR-0002N0-AM
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:07:30 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e0a608a36bso1760999b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707826047; x=1708430847;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AJ1DbwIfMVWDBYdsESCAoEZP3PgsJXdlIovOpw5e8E4=;
 b=OEj9knA/bSIWJwyXZ136foOMVINkuZNkrfgCqEZ31f7azhGEaNQC30o40jPPAxuSxt
 d+7+Zsnj4d7WOzzvbJDNNOpOFJMTl7c14IZjBVN3PzJEaSd+W0K6jfCaybA4WOpPL5NC
 OsuXFAMw76YjDNbq7zmDg9vQUVbICQt9GGZMMiTkFHV6q+hi4tI3DnmMlP54lXm2t5c7
 S/Jd7tHdnmIUuwwh9Nu/wRCoyOhYZLXsrisfcqucLSJfGfUY5il8HJk2WBeSmB/utPt6
 BYqSQ2gO3cuEhpWoUHs/aPC3snW2psCQs8b5C9gFpRRFScPNogIx7A9cNrgkasT0gZdY
 Mxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707826047; x=1708430847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AJ1DbwIfMVWDBYdsESCAoEZP3PgsJXdlIovOpw5e8E4=;
 b=k4jE/jCNfS0U7B1hAwuG+saJJnXaJoCebqrrYlMz+lM2la03ePLu/fNA8ikRh2tjJx
 vBxMhXtYKd7HiBG+MzPZnhp0AUaEVBqPF3ugNHXZ83UkySKaG/puxk7+S/+gUkkoC2Cz
 gwZdRffJKlHCncRRHtTV+qywmeMB1fhvoC9IAn8FJW3FEe6ezfSAA4Ax1QIK08jXCW5Q
 /mg56olZ6pIdJMoo+r8491RE02KvF9kFTWL4E4Rrn81qotgFu/OwRBqm/NTb3+zxY6+T
 apgK0U3L8VpjTKOKdapvytQrxc9tuO2FHO2NDgycOMB5HqcTVZGNX6mMsHvPYacEm3Wk
 0SvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGXhIxhPOa0Jb5EMVHJ+1r2l4ZssTRCjDfEkExdPclAPszV9yI6kLbJjpCqGsRK3VeU/I5zA1uLixd+Yuyqfv6nqghEHE=
X-Gm-Message-State: AOJu0YxnwXYD+sPnHfXLUFhfAjn59VpfbtAoIE84yqQSLbTTy9Qy3/lK
 fDQkHBN7vXx4ETZtSjQUlpF64QC7kLBUWg5DjnRuGsIhxZRC3b3Jf5x5sIxPV4g=
X-Google-Smtp-Source: AGHT+IHxCELmt6Xjv5f54svCdoCWpz72tZ1GLD3u6QeG1ae5akbyYzlaT60JbwOm9ZnK6Q75VpfVqA==
X-Received: by 2002:a05:6a21:6802:b0:19e:c1da:cbb7 with SMTP id
 wr2-20020a056a21680200b0019ec1dacbb7mr12334632pzb.27.1707826047169; 
 Tue, 13 Feb 2024 04:07:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXps6/t44GRiXBmX7YCbjo5g5v9RBYMQoZDsx6EaYh8bl3iORDI9aC6ugkPCtiUyoqjfPuaz7gYghXr/rA1hyqEbLtFzF7Rf/9TdVCWH5kp6g8csdd5QD0K12aoqDc/PUN1p8y2BdJk0gOiVzb+ViNUw5EsACtDn+M4UpH6OsRvK6xbaYMSX70fLksSXADso9KCBfFOkzS4aG8vXh/aRaf4eddqCH82avRG4Hwe5VayrRS0XDzkCeZF+hCrGqFQozhpHnGBh/9kbth98swaJM60WGNQqh6ZnYFp01u/Dpz40EZIRf+6yvwe0nF06U2rLsffMbjp6uohs5oFy9OxFD+Bh84CDr8RxwjMsyyhUyH53WRo8UMNvgQBGjke5rY+LLw2yDkNby0r0PSoTm+w4bLljoN7tGJZABHcYQ==
Received: from [157.82.207.134] ([157.82.207.134])
 by smtp.gmail.com with ESMTPSA id
 r9-20020aa79ec9000000b006e04dd8876csm7143037pfq.210.2024.02.13.04.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 04:07:26 -0800 (PST)
Message-ID: <0fcdd67e-97cf-47b5-9d6c-c9c19e93deac@daynix.com>
Date: Tue, 13 Feb 2024 21:07:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] hw/pci: Determine if rombar is explicitly enabled
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
 <20240212-reuse-v3-2-8017b689ce7f@daynix.com>
 <20240213055006-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240213055006-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/13 19:52, Michael S. Tsirkin wrote:
> On Mon, Feb 12, 2024 at 07:20:30PM +0900, Akihiko Odaki wrote:
>> vfio determines if rombar is explicitly enabled by inspecting QDict.
>> Inspecting QDict is not nice because QDict is untyped and depends on the
>> details on the external interface. Add an infrastructure to determine if
>> rombar is explicitly enabled to hw/pci.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/hw/pci/pci_device.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
>> index d3dd0f64b273..7564e9536dbd 100644
>> --- a/include/hw/pci/pci_device.h
>> +++ b/include/hw/pci/pci_device.h
>> @@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
>>       return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
>>   }
>>   
>> +static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
>> +{
>> +    return dev->rom_bar > 0;
>> +}
>> +
> 
> I don't get it. rom_bar is uint32_t if it's set to "-1" is is still >0.
> 
> How was this patchset tested?

I was careless forgot to test v3. I'll revert this line into what v2 had.

