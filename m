Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25201C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 16:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp9Ki-0001MA-9E; Tue, 26 Mar 2024 12:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rp9Kg-0001Lm-8r
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:07:26 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rp9Ke-0006NW-BI
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:07:25 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e0189323b4so43787265ad.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711469242; x=1712074042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K1/ETFHfBAHRt5SRZc6zEItAUnr14wWoBgrXhWnHPBY=;
 b=cJ1yXuWbbstxvtsOHYI7vUpGyQtbHZt4vLxlO+PX9B99CqNRFcMHrPnyQT/ruXR6th
 QA74BP0eZzAv1Jdh58Wi17UZm2oLt+9NziPraZp3LmnWfVN8MW82bR3od+3zMgq1QdAv
 G7mk2KG8eHPwHupMUANNs40T7AkmsDTo3AvvfSILRgweW6lKsso+mRdglh9qaMtv74Qo
 fGAubfPSl9jq6UfBsmQS3xiVxpnBvnaaJSAb9H37/iyAfUNmmryMI78RNMjSpj0yFUPa
 5W05Ffr9hsirLvIOH5+lUpF223B3rkDOf9ZiDK4SsB87l+11fwAPJ13p60kmwZsT4iqt
 kGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711469242; x=1712074042;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K1/ETFHfBAHRt5SRZc6zEItAUnr14wWoBgrXhWnHPBY=;
 b=CNe8cARtgvHsjt7gMhOZqD1tKM1h1yKHra9nunVdNnvuM/A1cCo9rOdseyzHMV/neE
 RAdjVxW7M/69IsSyu01DnYYUebGObOXe4aEgSSLLTY+dWe9TBSok0M9UT1NF/qhmdJfP
 l/rrj78cWEA2ru/DMvWZd+lOiigkpEmNAIbf7s50feWC5OFmIjhaW+NcWlYeCmGHGwwf
 YDG2RVVtDiee0b8G46Kb2udWAGRxSMoIbiJf9Urg91sjPOwWkVl0thtxLsZg7miSHk6K
 ck17tlE4Ly37v51H0yVXh6DNGqCVOAFGExDR9Wno9SK1FzM47JnQFLJ/wOnbHLHViHMy
 4rZA==
X-Gm-Message-State: AOJu0YwNxWhNrcMrFd1CGNQB3cr5PAnImGkmzrixexXmuluVFo2Nc9ha
 /z+3Ct6AsVlhzpeCZH1//W83VKpY3/3JeqQIJU1LTkqvVWrq4xkcNsvcQZaNs00=
X-Google-Smtp-Source: AGHT+IFOiQXDjTc5piSK4auV/59xQbo9M+Ua0aep0ccPRSL/stFuBjEJRL1ZEE3tAgX9CkgH6IOxRw==
X-Received: by 2002:a17:902:fc45:b0:1e0:9c35:e07f with SMTP id
 me5-20020a170902fc4500b001e09c35e07fmr213631plb.34.1711469240492; 
 Tue, 26 Mar 2024 09:07:20 -0700 (PDT)
Received: from [192.168.68.110] ([177.45.186.241])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a17090322c600b001e0b5d49fc7sm5015962plg.161.2024.03.26.09.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 09:07:20 -0700 (PDT)
Message-ID: <087af5f3-dfcd-4888-936c-0ffdd955459a@ventanamicro.com>
Date: Tue, 26 Mar 2024 13:07:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 0/3] qtest/virtio-9p-test.c: fix slow tests
Content-Language: en-US
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, alistair.francis@wdc.com,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com
References: <20240326132606.686025-1-dbarboza@ventanamicro.com>
 <20240326165550.05d083da@bahia>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240326165550.05d083da@bahia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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



On 3/26/24 12:55, Greg Kurz wrote:
> Bom dia Daniel !

Bonne après-midi !

> 
> On Tue, 26 Mar 2024 10:26:03 -0300
> Daniel Henrique Barboza <dbarboza@ventanamicro.com> wrote:
> 
>> Hi,
>>
>> Thomas reported in [1] a problem that happened with the RISC-V machine
>> where some tests from virtio-9p-test.c were failing with '-m slow', i.e.
>> enabling slow tests.
>>
>> In the end it wasn't a RISC-V specific problem. It just so happens that
>> the recently added riscv machine nodes runs the tests from
>> virtio-9p-test two times for each qos-test run: one with the
>> virtio-9p-device device and another with the virtio-9p-pci. The temp dir
>> for these tests is being created at the start of qos-test and removed
>> only at the end of qos-test, and the tests are leaving dirs and files
>> behind. virtio-9-device tests run first, creates stuff in the temp dir,
>> then when virtio-9p-pci tests runs again it'll fail because the previous
>> run left created dirs and files in the same temp dir. Here's a run that
>> exemplifies the problem:
>>
>> $ MALLOC_PERTURB_=21 V=2 QTEST_QEMU_BINARY=./qemu-system-riscv64 ./tests/qtest/qos-test -m slow
>> (...)
>> # starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-621710.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-621710.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M virt,aclint=on,aia=aplic-imsic -fsdev local,id=fsdev0,path='/home/danielhb/work/qemu/build/qtest-9p-local-7E16K2',security_model=mapped-xattr -device virtio-9p-device,fsdev=fsdev0,mount_tag=qtest -accel qtest
>> ( goes ok ...)
>> # starting QEMU: exec ./qemu-system-riscv64 -qtest unix:/tmp/qtest-621710.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-621710.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M virt,aclint=on,aia=aplic-imsic -fsdev local,id=fsdev0,path='/home/danielhb/work/qemu/build/qtest-9p-local-7E16K2',security_model=mapped-xattr -device virtio-9p-pci,fsdev=fsdev0,addr=04.0,mount_tag=qtest -accel qtest
>> ok 168 /riscv64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/config
>> Received response 7 (RLERROR) instead of 73 (RMKDIR)
>> Rlerror has errno 17 (File exists)
>> **
>> ERROR:../tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: assertion failed (hdr.id == id): (7 == 73)
>>
>> As we can see we're running both 'virtio-9p-device' tests and 'virtio-9p-pci'
>> tests using the same '/home/danielhb/work/qemu/build/qtest-9p-local-7E16K2'
>> temp dir.
>>
> 
> 
> Good catch ! I'll try to find some time to review.
> 
>> The quick fix I came up with was to make each test clean themselves up
>> after each run. The tests were also consolidated, i.e. fewer tests with the
>> same coverage, because the 'unlikat' tests were doing the same thing the
>> 'create' tests were doing but removing stuff after. Might as well keep just
>> the 'unlikat' tests.
>>
> 
> As long as coverage is preserved, I'm fine with consolidation of the
> checks. In any case, last call goes to Christian.
> 
>> I also went ahead and reverted 558f5c42efd ("tests/9pfs: Mark "local"
>> tests as "slow"") after realizing that the problem I was fixing is also
>> the same problem that this patch was trying to working around with the
>> skip [2]. I validated this change in this Gitlab pipeline:
>>
> 
> Are you sure with that ? Issues look very similar indeed but not
> exactly the same.

We can skip this revert if we're not sure about it. Gitlab passed with it but
perhaps this isn't evidence enough. I'll let you guys decide.


Thanks,

Daniel

> 
> Cheers,
> 
> --
> Greg
> 
>> https://gitlab.com/danielhb/qemu/-/pipelines/1227953967
>>
>> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html
>> [2] https://lists.nongnu.org/archive/html/qemu-devel/2020-11/msg05510.html
>>
>> Daniel Henrique Barboza (3):
>>    qtest/virtio-9p-test.c: consolidate create dir, file and symlink tests
>>    qtest/virtio-9p-test.c: consolidate hardlink tests
>>    qtest/virtio-9p-test.c: remove g_test_slow() gate
>>
>>   tests/qtest/virtio-9p-test.c | 155 +++++++++++------------------------
>>   1 file changed, 48 insertions(+), 107 deletions(-)
>>

