Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18207EDE994
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 01:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snqA0-0000xo-I7; Mon, 09 Sep 2024 21:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1snq9y-0000wn-Ir
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 21:59:14 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1snq9w-0002x5-BC
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 21:59:14 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso3870311a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 18:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725933546; x=1726538346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gfcHonbYetf09QvQQCHpN1LUfj7Vz/QK9sBOHH6nG54=;
 b=E98+VQJw3x4DouLcPhtjqOeoA1iaUnDqPLGpnzvuDkOQXFFauB8k0XpMLUkVfVp5gB
 IrZQS8LmCEVNV8pCPll2VJNyf64t+LrjI5kftJjkZZ1DFhfkNC7KDfaGUX1UXDjEjNNz
 ctaATNkBnM/HaSBr+kprphz3FJHBwa3Ain+q392NaETcq8sxApPimyp47N1RYMDbubi+
 g3oRiD0Bzs6V7HIZkciOZ/bmEaTH2KijorsXGgsMW1zBSjreuMI9H8+aX2petY9d2ZLS
 CMGkWtCDtpWo5bVNEZPU9fCcwL+O1yi3wNF0rLE9DYpM+xvJQ/a9iKesHIKyK9HqYMUA
 BKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725933546; x=1726538346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gfcHonbYetf09QvQQCHpN1LUfj7Vz/QK9sBOHH6nG54=;
 b=tst9D1ItxGz48nCSt1TCSVdThwbsHqP/CW+soWodQQxlu/QzAeGpQAI/9+xA2fHkZO
 Ui2ZH1uoHosfdrDQYTn2K11EVhWGwAorkZctGhcV0lNMQKTsfX469YM2NOUx9srSY6My
 etZ6q6a7OY3zAxG4qd1TsvLjQSyYX0OsTsGpkF5uZ01sqIcSA0gifqi0/rFrDcJeMXFC
 kqokiTFNmBlTDT4pdzBMGfieF0gB57RWw2fcK5g5oS5au4WDGkuct5YnTFPas2F/Cyuk
 WsFRZy0K+/hiEmKhbe5qS3UON1Fk+FRPgZ4hIuqzhGU/htYOId8AmWDvXCRldJHrx9M9
 GCKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+K9lgL4Ev/hPe4KVepaWh/MdOgBr/kBaasqwtL28QNU3utKGDF+NmtU60LAH5oVDm3EHRHqCSrN95@nongnu.org
X-Gm-Message-State: AOJu0YzTiQ7R5pbSeHBNYd/LHnY4sVjl5FXaNrIRw1RNVoTJhwTq+Hc5
 Ad5UfmA2cjveAdRRcUpK+Mgfkd056SI6zPMH4n1v3Zbo6rEfqM3mYwwdRwLj/PQ=
X-Google-Smtp-Source: AGHT+IG33mkGGNtBqmDJDWEqZyRWiTl/FTdTquYnCK7fmexqNM7f2sgq4+lHl2nac53VPnrxT1bJUQ==
X-Received: by 2002:a05:6a21:1706:b0:1c6:ed5e:241 with SMTP id
 adf61e73a8af0-1cf1d0acadcmr13320550637.15.1725933546432; 
 Mon, 09 Sep 2024 18:59:06 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.14])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d823cf3a98sm3888122a12.23.2024.09.09.18.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 18:59:06 -0700 (PDT)
Message-ID: <4b0d722e-ae34-447a-b54f-3306ecb5a30d@bytedance.com>
Date: Tue, 10 Sep 2024 09:59:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v11 02/10] block/raw: add persistent reservation
 in/out driver
To: Keith Busch <kbusch@kernel.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 k.jensen@samsung.com, Changqi Lu <luchangqi.123@bytedance.com>
References: <20240909113453.64527-1-luchangqi.123@bytedance.com>
 <20240909113453.64527-3-luchangqi.123@bytedance.com>
 <Zt9YJd8ifhG8HJFs@kbusch-mbp>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <Zt9YJd8ifhG8HJFs@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pg1-x52b.google.com
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



On 9/10/24 04:18, Keith Busch wrote:
> On Mon, Sep 09, 2024 at 07:34:45PM +0800, Changqi Lu wrote:
>> +static int coroutine_fn GRAPH_RDLOCK
>> +raw_co_pr_register(BlockDriverState *bs, uint64_t old_key,
>> +                   uint64_t new_key, BlockPrType type,
>> +                   bool ptpl, bool ignore_key)
>> +{
>> +    return bdrv_co_pr_register(bs->file->bs, old_key, new_key,
>> +                               type, ptpl, ignore_key);
>> +}
> 
> The nvme parts look fine, but could you help me understand how this all
> works? I was looking for something utilizing ioctl's, like
> IOC_PR_REGISTER for this one, chained through the file-posix block
> driver. Is this only supposed to work with iscsi?

Hi Keith,

IOC_PR_REGISTER family supports PR OUT direction only in Linux kernel, 
so the command `blkpr` command (from util-linux since v2.39) supports PR 
OUT direction only too.

- In a guest:
* `blkpr` command could test PR OUT commands.
* `sg_persist` command (from sg3-utils) works fine on a SCSI device
* `nvme` command (from nvme-cli) works fine on a NVMe device

- On a host:
* libiscsi supports PR, and LIO/SPDK supports PR from the target side, 
tgt supports uncompleted PR(lack of PTPL), so QEMU libiscsi driver works 
fine.
* `iscsi-pr` command (from libiscsi-bin since v1.20.0) supports the full 
PR family command.
* because of the lack of PR IN commands from linux block layer, so QEMU 
posix block driver can't support PR currently. Once this series is 
merged into QEMU, I think we have a scenario on posix block PR IN 
family, it's a hint to promote it for linux block layer.
* I wrote a user space nvme-of library `libnvmf` 
(https://github.com/bytedance/libnvmf), it does not support PR family 
command, but I don't think it's difficult to support if necessary.
* As far as I know, several private vendor block driver support PR 
family, this QEMU block framework will make the private drivers easy to 
integrate.

