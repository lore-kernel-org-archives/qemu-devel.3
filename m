Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F36FE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 11:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM3k2-0002YA-Qv; Fri, 13 Dec 2024 06:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM3jy-0002Xt-14
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:21:51 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM3jt-00086g-7n
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:21:49 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so1220379f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 03:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734088901; x=1734693701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mx6gkbGgfjhXVTIGaZmBfpDJUapUXso1NoODbOzac5U=;
 b=JE89/Nb/3g3Xh+ki2MZpCTvsQ/2411Ry07BQv2Dcr/xrzW1ME/pNupD5ZUAL6bMGox
 gRlL6iISvqBerXgr63LByyYwB79AicvTTLsZHchcoDZsAg8jgdIT9oX24fGCg3dUU9Mo
 19HH85LjJ8P+SNcXpSNYHosefWWKgN9Kmg6v6mPB2znmrNgN/rrPr0xHuyQI0WOTuSeM
 VQrUTcQvcb8dnOv5T17N4nEohpAwPWT99xL0+IgaSObzvBKg1zF2z/Gm3klq3p/Iw+Ms
 tbh8WIYVwSHEb+4Vk1Hi38sQKxLZgZ8F43t51pGKkEXYK2Bf3u1Spvuv79RsoSW5qCua
 qhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734088901; x=1734693701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mx6gkbGgfjhXVTIGaZmBfpDJUapUXso1NoODbOzac5U=;
 b=d2GCTcZlpM8L7s3dmIt/vi5xetc+0WNM32NilXvoMm8UlTVadZj1q2llZv5epSJzdt
 q65lWDHxg98p/68tQeIpfJTyQybqPOyTZUQ6OrSJ6RW/aOqDofFFjc/oI/Rilx/8kdV/
 ug8xdRL0qEDaUtF8hGKeqz0g2JabIJokGQiM53BH3piIdoT4fIUbsXvNwmReSceI3q3W
 2rjHrq6s71SW0w3gkBxs8E6vP5W8yYpsQm0LXaQqhocheiEFRxUde2Jsvn6WZPLqU+GI
 r9cO3fqd1H1XyzEwKyRNRqmorcUNOKaayjX+yoCYg0DAbcHU+a/H51z7KGr2gLlfGbdV
 E18A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdFfUfhtAUJY4ptxQuHrsO87jFb5yxWb4HVEsuvKyNK85q3V+arcFGqFq34WtjKAW/Dq/gbuTZFMt7@nongnu.org
X-Gm-Message-State: AOJu0Yxn5p0HQHFv4csSs94qKzuA92sgNIYsvpJzcTtI+bgn4drk3JMo
 40nRnQ4wp4jr6KQFfQahdlZzlfEsO4WFwtyZe+2A4yURSx0ZiAXsKXD2nSOd0IM=
X-Gm-Gg: ASbGncuquVBYIlocIBE6jTlE35CtxJOBAQ9T+S2brPdfpzDU/4QReqfsdEb1JpPit65
 uyb8lAtxu0HjzelXRfdMN61h8HievDRNncw8nja4bTu6PmkeyKd8zNk9MdXY/UKFydPsOrfGJyd
 TJ5dk2pTEszquLjK23D+LcUbeoZbD8cR2C/RbzFT8BARqKQ56/K3Ks8ArTHsxm0GxCetCDQwvHg
 D5O9DngaSSKoPlX6DgeVimZAH7uS+z07pkA/qYfXfJCsq1gtvny41nSasovpbvrvGib79pQcpj1
 X+bUnFfvUcNMasJlb+4/KeAa
X-Google-Smtp-Source: AGHT+IE4zDwP05f1wioY7FokR0t6f821b9Plm0ABioPg9ZhxXPSWCtimkHkskOqhUZTABMvIpB1NNg==
X-Received: by 2002:a05:6000:144c:b0:386:3835:9fec with SMTP id
 ffacd0b85a97d-3888e0b9871mr1603935f8f.44.1734088901449; 
 Fri, 13 Dec 2024 03:21:41 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a4fb6sm6776969f8f.35.2024.12.13.03.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 03:21:40 -0800 (PST)
Message-ID: <2c665768-5af6-41f7-801f-99c681de4f74@linaro.org>
Date: Fri, 13 Dec 2024 12:21:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] hw/nvram/fw_cfg: Move PCI bus methods out
To: Jiahui Cen <cenjiahui@huawei.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Bernhard Beschow <shentey@gmail.com>
References: <20241206181352.6836-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241206181352.6836-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 6/12/24 19:13, Philippe Mathieu-Daudé wrote:
> In order to keep fw_cfg device model clean, remove the PCI
> bus specific code. Instead, the equivalent functionality is
> implemented within the PCI_BUS object in hw/pci/,
> implementing TYPE_FW_CFG_DATA_GENERATOR_INTERFACE.
> 
> Philippe Mathieu-Daudé (6):
>    hw/nvram/fw_cfg: Rename fw_cfg_add_[file]_from_generator()
>    hw/nvram/fw_cfg: Pass QOM parent to fw_cfg_add_file_from_generator()
>    hw/pci: Have PCI_BUS implement TYPE_FW_CFG_DATA_GENERATOR_INTERFACE
>    hw/pci: Add pci_bus_add_fw_cfg_extra_pci_roots() helper
>    hw: Use pci_bus_add_fw_cfg_extra_pci_roots()
>    hw/nvram/fw_cfg: Remove fw_cfg_add_extra_pci_roots()

ping

