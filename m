Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9191EC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKuEY-0002WS-0b; Fri, 30 May 2025 03:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKuEW-0002Vv-0F
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:32:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKuEU-0000eu-56
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748590368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CLsoL0HK4AavaKwNDPWsVsKSwNjh/+hLW0DrcH8zfoQ=;
 b=CqXDBr4TWzy85UHvx32a1wjf3myD9pTKeN5qYMuKQp+rnNuKtdw2ToCbFM54AfZuQmaZ9k
 E3UE7YfPafN4dCfgCt9TiP5PhZTyvTte0Y1w/vh0ARjq7183++KWPmgidwYsykpqtkUCdv
 673D1EAPn1tLLW6Ek5DwUuuWPt0y5WM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-dbWJWoNeN8mp7NvJ_-lQVg-1; Fri, 30 May 2025 03:32:46 -0400
X-MC-Unique: dbWJWoNeN8mp7NvJ_-lQVg-1
X-Mimecast-MFC-AGG-ID: dbWJWoNeN8mp7NvJ_-lQVg_1748590365
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad5271a051eso149963666b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748590365; x=1749195165;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CLsoL0HK4AavaKwNDPWsVsKSwNjh/+hLW0DrcH8zfoQ=;
 b=LmV8X0dpLixDEe5+QkXupw2hZNhaLbySnnIzKSGZ/Sh4UVSWv/Mq605mwywmTS38ha
 lrcBACHpC/vN3t8JcmTkydfQXI/1V4+bokZZMeqxM8+GVFRapGC7hIpMeJOd6oDCD6UR
 2j8+4JvxFosBG3zauJBgaDCkde82swO4FtUWYOVW1SzhGdoyV2StbG2z2/QYZn06X/ra
 D+UCdNMoHZlDuOHcPVx3WZmpc6SToAkuygwbJvcOaDIaLfaTQlPwremxOAggSg8uf+Zb
 OgoCpERevqBOitjmCFQX7Uazr8y36tOTu8eWhIbG+1T/0e37WQn8nCkwNY4vCd8aOHn0
 MMLQ==
X-Gm-Message-State: AOJu0YzuONB2K9E22hEYfkL667DIBbPW9PerYnKjrQIaIpTddpLbo+he
 ofIlDhCTM70+wdljSTx0pj7TMLaTcGqaiLcO9vLUzwGXzTy7ziCsY1AePMIwcq/Wm8PE8Q7iv+I
 qxS9mVlofqnpl7hfqfoCvC39eUQXB5fuCt9rBzfXC6LH1C+hVn0Zg06ttQdMua9Z8omw=
X-Gm-Gg: ASbGncsWQFsiQeWghQdhJ0oYAQKUz53AdSTRSP/J0CKhxkkon+2J8L66V6AU586S6ts
 9DGKpfE2EwssNnhyspIkon0O/W++Q7fQnDQNznxni5dVUpmyoRv9BL8AsZrBk+Jbr1j9xgxesLA
 UPnar19FAorGdKBlBzj7o9eoJU1WzT5uTc/uWezB5Fa1RivrANVDhi4Rt0NCCr0YTcQUL9ZR1ew
 ox0mX0cnDC9hbrB9GNuYu2xn9ctvA9f1vdp9f+KDCy6aBK+C8AeOYJ2xrtPIE3sEm/LwHxIyshT
 cJrrqmQh81w/dGiAD9J0BraaZrFhJbSenwPqdEeguCJ5yWqvQVuP
X-Received: by 2002:a17:907:971d:b0:ad8:9b5d:2c2f with SMTP id
 a640c23a62f3a-adb322b357emr220273166b.4.1748590364389; 
 Fri, 30 May 2025 00:32:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/gEIeT6o39zOHO+RkLWYWgTX/G51yfGsqDt4+zcA14708+7XvaFbyJx/RFsk/QsV4HCIFvA==
X-Received: by 2002:a17:907:971d:b0:ad8:9b5d:2c2f with SMTP id
 a640c23a62f3a-adb322b357emr220271966b.4.1748590363976; 
 Fri, 30 May 2025 00:32:43 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net.
 [47.64.112.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82becbsm279932566b.39.2025.05.30.00.32.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 May 2025 00:32:43 -0700 (PDT)
Message-ID: <8770ba4d-31c8-4b44-b6c6-4829b5963705@redhat.com>
Date: Fri, 30 May 2025 09:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/25] Functional tests, Microblaze endianness & pc/q35
 cleanups
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250528202442.18315-1-thuth@redhat.com>
 <20250529152658.GA62516@fedora>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250529152658.GA62516@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 29/05/2025 17.26, Stefan Hajnoczi wrote:
> On Wed, May 28, 2025 at 10:24:42PM +0200, Thomas Huth wrote:
>>   Hi Stefan!
>>
>> The following changes since commit 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e:
>>
>>    Merge tag 'pull-aspeed-20250526' of https://github.com/legoater/qemu into staging (2025-05-26 10:16:59 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2025-05-28v2
>>
>> for you to fetch changes up to 51c214b7c27096e3516aedf6befd69dc6d75b4ac:
>>
>>    tests/unit/test-util-sockets: fix mem-leak on error object (2025-05-28 22:16:26 +0200)
>>
>> ----------------------------------------------------------------
>> * Functional tests improvements
>> * Endianness improvements/clean-ups for the Microblaze machines
>> * Remove obsolete -2.4 and -2.5 i440fx and q35 machine types and related code
>>
>> v2: Dropped the memlock test patches
> 
> Please take a look at the following CI failure:
> 
> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 QTEST_QEMU_BINARY=./qemu-system-microblaze QTEST_QEMU_IMG=./qemu-img UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 G_TEST_DBUS_DAEMON=/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 RUST_BACKTRACE=1 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon PYTHON=/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/build/pyvenv/bin/python3 MALLOC_PERTURB_=57 MESON_TEST_ITERATION=1 /home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/build/tests/qtest/test-netfilter --tap -k
> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> stderr:
> munmap_chunk(): invalid pointer
> ../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> (test program exited with status code -6)
> 
> More info here:
> https://gitlab.com/qemu-project/qemu/-/jobs/10190886460#L5038

Drat, I think I missed:

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c 
b/hw/microblaze/petalogix_s3adsp1800_mmu.c
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -187,6 +187,7 @@ static const TypeInfo 
petalogix_s3adsp1800_machine_types[] = {
          .name           = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
          .parent         = TYPE_MACHINE,
          .class_init     = petalogix_s3adsp1800_machine_class_init,
+        .instance_size  = sizeof(S3Adsp1800MachineState),
      },
  };

... I'll respin the PR with that fix included.

  Thomas


