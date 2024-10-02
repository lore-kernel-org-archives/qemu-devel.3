Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CB2CF319C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuwh-0007j4-W1; Wed, 02 Oct 2024 04:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svuwg-0007ib-CF
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svuwe-0006B5-Jo
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727858571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RbFtn9FhGqAxcHKtxZb72MHdP4zhZ+jCp7w1UDuexB8=;
 b=Zkdx4vD2lTRI7luQz6EvhXbBr6f0B1tGZT5uib5qrWEi99mAS4Vqkw1z+Ab/za58jjfzxQ
 NVb/jFcLQnYiMVnFymbwQG3lLrR170EmW1S1qog8zRNpETg3k7hyPE0LM5JjZDwSMQxpPd
 M6DM5qanuUZv9yuxFFRmGrvfWSIwzJU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-l_1QSqJeNiunDgvDim_V2g-1; Wed, 02 Oct 2024 04:42:50 -0400
X-MC-Unique: l_1QSqJeNiunDgvDim_V2g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37cd6655ef0so1836990f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 01:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727858569; x=1728463369;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RbFtn9FhGqAxcHKtxZb72MHdP4zhZ+jCp7w1UDuexB8=;
 b=Nn+XbAml7lV4/MP2WbULVMm6QNbRV0nI433Aa7E0jY7Ugc/yzMvbvf2ZzzHiG8/YrB
 SqzS0HAxIvBfl6YZFVoJ5lJL5b0vEKciiXato5/ZvnWgXB2Un+QkyffTO2AcjmMvXxYp
 Jl3UAi2+NbnAT2sBJ3bGLr71EoYD/EU42VmThxkpinA0MM04XsGqzzBcBzHMEQ/hgrwn
 zJ/SoO/v4YN7AlQPOQBkTH07yrwevFcsZ2s+3P9cMz56vpGp5owTsN8glQkGSrwSqOva
 lgMXJXHHrdxduPtkWV6/MfBRkdpcvMENWWpTCWPEy3fd6cjBlEGrFcOplYSnGWt0HXGc
 rC/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyUQxVOI55edzxZf1IqUynD2Y1o3hK35rCB0Y4uaCKykfFDr/c3s2sPMqqzOUiZxykporpPU89UKDV@nongnu.org
X-Gm-Message-State: AOJu0Yxsm8+y0YSg+KsNw3tO9PWZAJyO4XKthZIIaqRZDegRlgq2gh1N
 0ibZDXEkHd0DBkvvy6XcgKaHRI0Cf19EYoxs0O4vNhTS83KCntWHqhqk35AMGgh1DsC+61VGf8p
 W0HjfhKIZOYF02Mgchy8z9PbArfkLiVn1HlmOr0wd+0H9G+NRnNpE
X-Received: by 2002:adf:fb0f:0:b0:37c:d23f:e465 with SMTP id
 ffacd0b85a97d-37cfba12331mr1269450f8f.55.1727858569412; 
 Wed, 02 Oct 2024 01:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUW8zPw6jW+WZzfsSVL83REpK7hpycIdAjoTgQ05VgVGw2hKLF4Pgyb3I/UHQ+9ne5gwnj5g==
X-Received: by 2002:adf:fb0f:0:b0:37c:d23f:e465 with SMTP id
 ffacd0b85a97d-37cfba12331mr1269259f8f.55.1727858562835; 
 Wed, 02 Oct 2024 01:42:42 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57429e5sm13443890f8f.98.2024.10.02.01.42.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 01:42:42 -0700 (PDT)
Message-ID: <b5c138db-2632-4ae4-bb65-afaf20aa89b9@redhat.com>
Date: Wed, 2 Oct 2024 10:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/22] -Werror=maybe-uninitialized fixes
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 02/10/2024 10.36, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The following changes since commit 718780d20470c66a3a36d036b29148d5809dc855:
> 
>    Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu into staging (2024-10-01 11:34:07 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/warn-pull-request
> 
> for you to fetch changes up to baad82ecfb27474f17f4318502725622ab7170fc:
> 
>    qom/object: fix -Werror=maybe-uninitialized (2024-10-02 11:36:12 +0400)
> 
> ----------------------------------------------------------------
> -Werror=maybe-uninitialized fixes
> 
> ----------------------------------------------------------------
> 
> Marc-André Lureau (22):
>    util/coroutine: fix -Werror=maybe-uninitialized false-positive
>    util/timer: fix -Werror=maybe-uninitialized false-positive
>    hw/qxl: fix -Werror=maybe-uninitialized false-positives
>    nbd: fix -Werror=maybe-uninitialized false-positive
>    block/mirror: fix -Werror=maybe-uninitialized false-positive
>    block/mirror: fix -Werror=maybe-uninitialized false-positive
>    block/stream: fix -Werror=maybe-uninitialized false-positives
>    hw/ahci: fix -Werror=maybe-uninitialized false-positive
>    hw/vhost-scsi: fix -Werror=maybe-uninitialized
>    hw/sdhci: fix -Werror=maybe-uninitialized false-positive
>    block/block-copy: fix -Werror=maybe-uninitialized false-positive
>    migration: fix -Werror=maybe-uninitialized false-positives
>    hw/virtio-blk: fix -Werror=maybe-uninitialized false-positive
>    migration: fix -Werror=maybe-uninitialized false-positive
>    linux-user/hppa: fix -Werror=maybe-uninitialized false-positive
>    target/loongarch: fix -Werror=maybe-uninitialized false-positive
>    tests: fix -Werror=maybe-uninitialized false-positive
>    hw/virtio: fix -Werror=maybe-uninitialized
>    hw/virtio: freeing leaked memory from vhost_svq_get_buf in
>      vhost_svq_poll
>    block: fix -Werror=maybe-uninitialized false-positive
>    fsdep/9p: fix -Werror=maybe-uninitialized false-positive
>    qom/object: fix -Werror=maybe-uninitialized
> 
>   block/block-copy.c                 |  2 +-
>   block/file-posix.c                 |  2 +-
>   block/mirror.c                     |  8 ++++----
>   block/stream.c                     |  6 +++---
>   fsdev/9p-iov-marshal.c             | 15 ++++++++++++---
>   hw/block/virtio-blk.c              |  2 +-
>   hw/display/qxl.c                   |  4 ++--
>   hw/ide/ahci.c                      |  3 ++-
>   hw/scsi/vhost-scsi.c               |  2 +-
>   hw/sd/sdhci.c                      |  2 +-
>   hw/virtio/vhost-shadow-virtqueue.c |  6 ++++--
>   linux-user/hppa/cpu_loop.c         |  2 ++
>   migration/dirtyrate.c              |  4 ++--
>   migration/migration.c              |  2 +-
>   migration/ram.c                    |  2 +-
>   nbd/client-connection.c            |  2 +-
>   qom/object.c                       |  2 +-
>   target/loongarch/gdbstub.c         | 26 ++++++++++++++------------
>   tests/unit/test-bdrv-drain.c       |  2 +-
>   tests/unit/test-block-iothread.c   |  2 +-
>   util/qemu-coroutine.c              |  2 +-
>   util/qemu-timer.c                  |  6 +++---
>   roms/openbios                      |  2 +-

Replying here as well, so that Peter has a chance to see it:

The update to roms/openbios in patch 03 seems to have slipped in by 
accident, so I'd suggest to fix that first before merging this.

  Thomas


