Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD801D58D55
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFaPk-0003DM-Cw; Mon, 25 Nov 2024 09:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFaPa-0003BI-6l
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:50:03 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFaPX-0004bS-QN
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:50:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a10588f3so5881515e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732546197; x=1733150997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tc5LnuLllGpjp6P/blJEhjyQ5ysxLb95rGV+9PCZXGU=;
 b=u+mzm3FFjv7+mKhSPnVDJf5pJZblbaHTTLB+x5CYkWKYh5/tlFgJJLmhrQObtFKQlb
 WAD2OOoRBo5LynpLYJcmTLLIiWS3FUtRfz8JOo36bbN5qrLZRGUh4zPmwfhpigTL0HRG
 5Hk9ebA0ZLPadX8NTXgXK343Nl84U9RO+oSBmlQicDw2pwSg5f0ZS1FfZurGc4nCCBdP
 e9QGsZ9dvYNnCQ0/cmzkxHKOoiFECj2sUV0zxI/CNjWbIq99O2KH26h0DVp6KU+PvpvF
 p2+zG4xG8E5K9rukj0qbOPfsZOqBR1G6pOVGmWK5MKnFPwDxPYkjmSb9uqkN6u4GLC1q
 Hr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732546197; x=1733150997;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tc5LnuLllGpjp6P/blJEhjyQ5ysxLb95rGV+9PCZXGU=;
 b=C+G9c+2GoSl6flo7bQfOvd28eMoCkK8ugJ4q1cJLIocpsC+T2yI/MEewB0Ld3R8CFZ
 088C/x0J/lWiiPvZy321LqkHiczFTpDWiBlp5CXj7FIXR8hopv4MLvTbS532jA6iDd0v
 AMBjvtBbDFqvr0WcXgT67IwdH4Kva4vn5FcJSPWOM/do6L8jb2kSFiq7vSKWOg3c7iGc
 7+hG15+LAnBxfEq0gQSdfVwhRHDCtzHqkPDDl40cORBYSXGhYA0SKauc5mi3wFcZUQRJ
 8F9e7/pXj4FFJ6ndauCNLGCnJSM4bcxqWEwGKngpvuVs7akQUtdw3MuoDG4wpcbbsKE3
 K+Sw==
X-Gm-Message-State: AOJu0Yzf1qD+erDQXCe91ptrHros13dwEFrTlg7RY74JrT9Q7F0Cpp0M
 L30qk18mHDXfKsbDN6p7C6lEOg+lLhSLjDQAgEznbDBdCkhkvJ8Q3MyUJimLnps=
X-Gm-Gg: ASbGncswnfAiTGaMztvevO6Z0YpOggKun8h33uhxh6dYYNByMOwjNbINapDliE2JXzc
 JzkZgRG/yLlCcC6IBe3sPjKeL9vCafmb8sjLa7qTO7OF+2MKlbQK4RZRW8+LUD6x49b6mChgatx
 oLVoqPHu75LVPNzSxpuxnTRcp+jKNn7Ele27H8EOGs8GoE6I7sz873rAFmc7EiUxQVYC13T26d3
 kJHd6LOYzV37cw1pQhINerz8IzNuyVhYe97H5c/Hv5BFd4TqP3IUvqR7RVPlJcOZQ==
X-Google-Smtp-Source: AGHT+IED5k1O3nbvzkJ1DH2/mMToRCPIbNYWrryyXGaeVZLFIPfay/fk5Y9wh9Jp+29gWVcJuaS/DA==
X-Received: by 2002:a05:600c:1d1e:b0:434:a1d3:a30f with SMTP id
 5b1f17b1804b1-434a1d3a4ecmr14475935e9.6.1732546197259; 
 Mon, 25 Nov 2024 06:49:57 -0800 (PST)
Received: from [192.168.69.146] ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349d3f4b7bsm60218105e9.6.2024.11.25.06.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 06:49:56 -0800 (PST)
Message-ID: <748eb21d-4b73-4d2a-8058-b3a79d4fb802@linaro.org>
Date: Mon, 25 Nov 2024 15:49:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 0/8] hw/boards: Remove legacy
 MachineClass::pci_allow_0_address flag
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Alexander Gordeev <agordeev@redhat.com>
References: <20241125140535.4526-1-philmd@linaro.org>
 <CAFEAcA9vS-9u282Jr+_QaGZT6vD4cpmh0wjuYPQSPLZQw30e4Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9vS-9u282Jr+_QaGZT6vD4cpmh0wjuYPQSPLZQw30e4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 25/11/24 15:14, Peter Maydell wrote:
> On Mon, 25 Nov 2024 at 14:06, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> This series aims to remove a legacy field from
>> MachineClass.
>>
>> Rather than a global exposed to all machines,
>> use a pci-bus specific flag on each machine
>> requiering it.
> 
> Should this be a property of the PCI controller, rather
> than on the PCI bus? Presumably on the machines that
> don't allow a 0 PCI BAR address this happens because the
> PCI controller refuses to map BARs at that address.
> 
> TBH the commit message for e402463073 suggests to me
> that "allow address zero" should be the default and
> either specific machines should forbid it or else we
> should figure out what goes wrong with them, if the
> problem is caused by some bug in QEMU. The commit message's
> mention of "fix PCI memory priorities" suggests to me
> that this is a QEMU bug, and that it ought to be possible
> to have the machine set up such that you *can* map the
> BAR at address 0, it's merely invisible to the guest because
> some other machine devices have higher priority and are
> visible "on top" of it instead.

You are probably right, the following comment ...:

  pcibus_t pci_bar_address(PCIDevice *d,
                           int reg, uint8_t type, pcibus_t size)
  {
      ...
      /* NOTE: we do not support wrapping */
      /* XXX: as we cannot support really dynamic
         mappings, we handle specific values as invalid
         mappings. */
      if (last_addr <= new_addr || last_addr == PCI_BAR_UNMAPPED ||
          (!allow_0_address && new_addr == 0)) {
          return PCI_BAR_UNMAPPED;
      }

... is from 20 years ago at the beginning of PCI in QEMU, commit
0ac32c8375 ("PCI interrupt support - PCI BIOS interrupt remapping
- more accurate memory mapping - 'info pci' monitor command") which
suggest the implementation is incomplete here.

