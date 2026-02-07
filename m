Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93824EE0ADC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voiaI-00019F-P0; Sat, 07 Feb 2026 08:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1voiaG-00018j-T0
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:42:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1voiaF-0002mr-88
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770471766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W8OisJpRxYve1TVsihBY5EFx069uyfydRLrtqZq8bAc=;
 b=QqKZyGN5M2NdUnuiW4e3p0VFyUtxOUzWVBHRDyQjvYqeFyCBt57DAjxB+spCVysPmMv3nK
 mKHtiTvjfPY8O8cNf0Njb9v89fv7WzdBlPIdzlDwSttCh+ny6FdiWuW+vcRDba7MSuE4Dd
 cQvcB+Kfd/oqK/N/EnX0hlxq+CAZoTU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-ebvRzyYZOX-w1iLPG8xJ-g-1; Sat, 07 Feb 2026 08:42:44 -0500
X-MC-Unique: ebvRzyYZOX-w1iLPG8xJ-g-1
X-Mimecast-MFC-AGG-ID: ebvRzyYZOX-w1iLPG8xJ-g_1770471763
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-482eec44485so24329855e9.3
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 05:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770471763; x=1771076563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W8OisJpRxYve1TVsihBY5EFx069uyfydRLrtqZq8bAc=;
 b=EzXr2i1wArsyWU1w/eZ83QyqNxg7yjMd2Ws3YC2HzoAeKLce0xNfY7mNwAwaHifAyJ
 phgOqt3X54aZfg3XSpKGNexGEi7sb6SqRY8opNKeBKObsFwRwCVyuwDKztUblwYkePWf
 QhjQAtfbT5ovrwwsRGhxtH5eHr0+JZa+SITUTCX4alerHha8TyEobQCH++N13jO4xrvT
 jwa/ib4pKcr1cYUB3L2Xnnji44sgpw3sfEsnnPsYgTqmeTvVfiUpfzrLhSOLGF37JZhC
 HOhk1k/ZyMCfvfCFP467JChuDFH7IClC5TuZ9yhhcjSQXJFCMmWd6AGCB/ZslBMzb5xn
 0qDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770471763; x=1771076563;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W8OisJpRxYve1TVsihBY5EFx069uyfydRLrtqZq8bAc=;
 b=ATvqaq6fJem7k+gDkpk3l+vHk78EuIYUulS27sOfyaJ+YeHLFOv2FF1N9QX+fbltv8
 jV82HyQsnkuWP3gBg9C4jfjfcwg6y3Zeny68n+LOWB1HS1OEgJC4n6P1MOsjUg1cSgoM
 wSSTB9FqtjR16h9G56AoIMjtIgfUK9K0KfuSnHezLeZa5pyDLfayh9DlKRsRCoUNLBiP
 2eHKROCxvz504M1M7OvdX45fMFSJSHktHNOAzjb+xbpnDPOkOMsmv13/4VzThy8yAbLk
 n2PgGvKTptuu7MHnoE1Vsdb7h9wBO5cRtu4qFqdR+rsx6VBjNQycKIdvvWnexnIfmFNe
 CexQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLC8RROEkJTuBy+RDbAkM/Ltdn4heDkWI9kU4ZNNaoWcTq+O+X2jMcGrX/HX+jon/69EcJgpjkOC4G@nongnu.org
X-Gm-Message-State: AOJu0YzvQSUfV5b8SSm5VudmJXwP6oLbImxPGB5mrXGKnPd1hh90INNG
 vZeeObh7bFklT2ef2FbqYrrikqSc6yqFmfersJ1DvXYIxxJvGvaOt4+MVy0/kG7WegilyfQ0txl
 Ufn9+736q7c7fUTjGpDGs0jN8NT/yBM+WWGLqHjqPvqQye5UemQNpCZGB
X-Gm-Gg: AZuq6aLsnHSOuMEFZw3S8CYAt/HAywMxHfmYQoRYU8gV+62QJ5+4VljDy077JYGa9Ih
 s293cO4mYF26+0Jpl1DuicnZ72co9mfAZm5XTjcWSx86MaQauyNxdK7TngxJki+VDfQSM75W18j
 f4TED7AiSCEdoKiPFiFStbOL8a9iQ4DHeUX7G5cEXAg09hPrl2cBFHrC7ob3REwFCYBdgtrG7x4
 o8YBtrZYEsrKltx8kqHUuL39Igfa3r9nIUjHt1yZdJn2L+7FgYgfXhOcTsLajiAptxjRGdjfJbH
 9oMetXiWY3OymypYWzJhRNNo+7YAI0jhwGBdvXE6f1vO9erxr6fUy656r0rCOkzJj0xugDzg7Fc
 O9wT6gCIv56mG8cNDynapYiwWcFgOfyKXbLEoU88U55Wq+3Ki8VcUq4xN+99mcZGahsYGGYVD93
 vBhy6L40NUv8ZrbR/kDBHoD3sI9WaeFlg9beRPTfrJog==
X-Received: by 2002:a05:600c:5253:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-483201ee7f4mr83257285e9.15.1770471763243; 
 Sat, 07 Feb 2026 05:42:43 -0800 (PST)
X-Received: by 2002:a05:600c:5253:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-483201ee7f4mr83256915e9.15.1770471762823; 
 Sat, 07 Feb 2026 05:42:42 -0800 (PST)
Received: from [10.58.49.123] (93-44-32-35.ip95.fastwebnet.it. [93.44.32.35])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436296b2110sm12850055f8f.3.2026.02.07.05.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Feb 2026 05:42:42 -0800 (PST)
Message-ID: <d5c37f7b-cbc5-45fc-a0e3-dd2fe4368b14@redhat.com>
Date: Sat, 7 Feb 2026 14:42:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] scsi: persistent reservation live migration
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Qing Wang <qinwang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Hannes Reinecke
 <hare@suse.de>, pkrempa@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Alberto Faria <afaria@redhat.com>
References: <20260129212035.219676-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260129212035.219676-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/29/26 22:20, Stefan Hajnoczi wrote:
> v3:
> - Use warn_report_err() instead of suppressing errors [Daniel Berrangé]
> - Wrap lines exceeding 80 characters
> 
> v2:
> - Add user documentation [Paolo]
> - Send PREEMPT on the source if migration fails. This rollback operation
>    ensures the source regains access to the LUN even if migration fails after
>    the destination issues its own PREEMPT.
> 
> Live migration does not work for SCSI Persistent Reservations acquired on
> scsi-block devices. This patch series migrates the reservation key and
> reservation type so that the destination QEMU can take over the persistent
> reservation with the PREEMPT service action upon live migration.
> 
> The approach involves snooping PERSISTENT RESERVE OUT replies and tracking the
> scsi-block device's current reservation key and reservation type. In most cases
> this involves no additional SCSI commands. This approach isn't perfect: if
> another machine modifies the reservation on the physical LUN, then QEMU's state
> becomes stale. Persistent reservations are inherently cooperative, so this is
> acceptable as long as real applications don't run into problems.
> 
> I am also working on a test suite called pr-tests that runs sg_persist(8)
> commands across multiple machines in order to exercise various scenarios:
> https://gitlab.com/stefanha/pr-tests

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

> Stefan Hajnoczi (5):
>    scsi: generalize scsi_SG_IO_FROM_DEV() to scsi_SG_IO()
>    scsi: add error reporting to scsi_SG_IO()
>    scsi: track SCSI reservation state for live migration
>    scsi: save/load SCSI reservation state
>    docs: add SCSI migrate-pr documentation
> 
>   docs/system/device-emulation.rst        |   1 +
>   docs/system/devices/scsi/index.rst      |  10 +
>   docs/system/devices/scsi/migrate-pr.rst |  54 +++++
>   include/hw/scsi/scsi.h                  |  15 +-
>   include/scsi/constants.h                |  21 ++
>   hw/core/machine.c                       |   4 +-
>   hw/scsi/scsi-bus.c                      |   3 +
>   hw/scsi/scsi-disk.c                     |  90 +++++++-
>   hw/scsi/scsi-generic.c                  | 291 +++++++++++++++++++++++-
>   hw/scsi/trace-events                    |   2 +
>   10 files changed, 476 insertions(+), 15 deletions(-)
>   create mode 100644 docs/system/devices/scsi/index.rst
>   create mode 100644 docs/system/devices/scsi/migrate-pr.rst
> 


