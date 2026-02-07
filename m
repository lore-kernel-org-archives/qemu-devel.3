Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D63EE0AE0
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voia1-00014v-NV; Sat, 07 Feb 2026 08:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1voiZz-00014m-4w
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:42:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1voiZw-0002hX-M8
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770471745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W8OisJpRxYve1TVsihBY5EFx069uyfydRLrtqZq8bAc=;
 b=dIOoroA00bCKskiF98p5J3hBCR6kD4yVHUg44mn3J2fccb1gN1OZTduqfVKE0kwc69KRc4
 sFVeyBY3HUFEjPUtbaMJuIcLCdleCf13w27bf+kLIcVNdKEg8QsYIv1AnepGN5G62vVNuG
 osHmFEGmFN8ex+oj+VMDflcl3lMIIDQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-IUImrB3jN_u9SVsOXJt5eA-1; Sat, 07 Feb 2026 08:42:24 -0500
X-MC-Unique: IUImrB3jN_u9SVsOXJt5eA-1
X-Mimecast-MFC-AGG-ID: IUImrB3jN_u9SVsOXJt5eA_1770471743
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4361765dc85so2760485f8f.0
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 05:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770471743; x=1771076543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:fcc:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W8OisJpRxYve1TVsihBY5EFx069uyfydRLrtqZq8bAc=;
 b=lFEYvzUjr7WxwrjjY6Gbbv9cEtkJRZ+kPXGa7q9FseAdKrbX6vunWjJu7SD1vrXTkY
 U3czecHCmt91SQYz+TU2/o0TDGwhbQWxr/82Exs7aqOgVZiMbvpuRPt4JZ00e2la644E
 K1jIwIrJWb4fKdatcsaNd/raiSRsTMyweurkeCo7PYb7uF2FqcBVTob3Jk74qwJTNO0p
 BOvzfK/SHs+Mn3x6u55sa4pXpTf+RGJeBFMVioHVOaRTl/WCS8X17ztvzCACb+4sLQcf
 9D3KdLjuvfmLMKToUrNU7j63cjwaxFG4D5WFAmtmI3M/ZuobglORD7qbjuJ/bb0XgF5d
 3sCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770471743; x=1771076543;
 h=content-transfer-encoding:in-reply-to:fcc:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W8OisJpRxYve1TVsihBY5EFx069uyfydRLrtqZq8bAc=;
 b=mO6Q6z/1guwA/IYWtO5xlKRUX3y2/+CA+sAx72xgMU15SBaNKxPCdiTxsW6N+5rCtB
 RNPnKcyrypNfPbkYbfSXB+9LmYBEyqlirsEcFg6RLEDWq/PYJ69DFRMF9Tlwo6K/XwUT
 5v9mbaGQfZNI05FAVm6/r3aCnk1qR2usqfG8zr72uW1nyrga/irSLq749ETRMpCDKFru
 FZ3FtqNvSsZmwCepdwwFwC3A4sEOBjpYUMMTeWTQagDwgaY0AHjSVdwJOccneT92J0ts
 4OefOlOzzqF+JN+ZtxRfU0tzCQreXgTIA6L1hQOEGtK2oiUOetiHzeHVkpLzEnxjKBrO
 I9Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGkslL3wLhlIDSosJxIO2Wyf2rZ6FCrhHDI4R978R1CncwuSKTS+0VzE55nqva2HiRJyk5KIc9bwIQ@nongnu.org
X-Gm-Message-State: AOJu0Ywjn41lEAyGeCPeLa2fVhk952lFk4zEkJdArMRsk/yvr9Kr3AfW
 KZ9kAC9FnSkSI3rj4KaF36cRBRNiLwVAy8GGRbSj14mFnklyjP4aQbfnaxrpWRMe4Fy1jQYtgmf
 CMPrGE8xCrHQ5IC0z9SRu6ks1SyWlUORee1ARBwjKAfJ7Cc26bWgEvYSjtfNmtJhy
X-Gm-Gg: AZuq6aKZNkKvgBF94std+AA0swvDchEbx4BkjX/aJcPDuWUoHoheDrFfO9zoYQFa1iZ
 1Lq8+IwborVEbS+D7PmsXiUDWJXrxEknBYcemH/eh0AVBzOnc8oM2GuQ2npGspBGUoB19iC6dLg
 wnyTN7rpfg/0uKakmwZL+5gcyCgmd7OUh52cu9IbTg3eeUgXcI0B/KMp9F+1rFrNbaVWTrm3fTi
 h71uVXBMcxTwS1LxzcIFcABqgMj+ZivXZvYH5dLL1Gqjg4fM8K/ozfmt7bHAQNfY5coQd0lkBMx
 wTDAMHjQBqvAO2eyV/71eJfQ6mf6VQsEkCuU9GQHSjO4F7cH0jIOkJ5WIFA66rLQ9+wnsFN0tJb
 +lYS/SaFDFlj/oryop8g05E9RzY3T3JLUS4GjRxIsnumV3Ky+dSn7uNMT2nknWvPHS5GXaWF8m2
 ZYNPEzBstOcQ5GSlAQgEo6RoU4iAx/6o1b/n9+QLADOQ==
X-Received: by 2002:a05:6000:240e:b0:436:23a2:5e25 with SMTP id
 ffacd0b85a97d-4362938fe8dmr9309689f8f.44.1770471742732; 
 Sat, 07 Feb 2026 05:42:22 -0800 (PST)
X-Received: by 2002:a05:6000:240e:b0:436:23a2:5e25 with SMTP id
 ffacd0b85a97d-4362938fe8dmr9309659f8f.44.1770471742213; 
 Sat, 07 Feb 2026 05:42:22 -0800 (PST)
Received: from [10.58.49.123] (93-44-32-35.ip95.fastwebnet.it. [93.44.32.35])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436296bd4a1sm12761505f8f.17.2026.02.07.05.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Feb 2026 05:42:21 -0800 (PST)
Message-ID: <9ab2b8ac-525d-48c5-b42a-c732dae75668@redhat.com>
Date: Sat, 7 Feb 2026 14:42:20 +0100
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
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=0
X-Identity-Key: id7
Fcc: imap://pbonzini%40redhat.com@imap.gmail.com/[Gmail]/Sent Mail
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


