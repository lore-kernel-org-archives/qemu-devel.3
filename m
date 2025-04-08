Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBB9C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 12:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u27xI-0006HH-BT; Tue, 08 Apr 2025 08:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u27x7-0006E6-Uz
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 08:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u27x4-0006TH-Ro
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 08:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744114870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJ4iptmE+8l6XtWLUsKaSmj1ERaXSG6B++V8k4sw/Dg=;
 b=Z9u5/UtsThdasv00On5ortQz1huI1G2ixzboDyHsVDlFisnZ3b/mDyt5CAwCd4Rt4pjk+O
 L0Q1BjM6PIiNkcB6jRhDb4RtYayQKwLHr/ZImUk9aFo+ErVvkpbL/KmAQrfF1aK2JyNLfa
 MfPiecWxhrvPFIpaZVjY4p0dhDC8hdA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-YYwbe3h2NpqNwY4USR1bVQ-1; Tue, 08 Apr 2025 08:21:06 -0400
X-MC-Unique: YYwbe3h2NpqNwY4USR1bVQ-1
X-Mimecast-MFC-AGG-ID: YYwbe3h2NpqNwY4USR1bVQ_1744114864
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so31857275e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 05:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744114864; x=1744719664;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TJ4iptmE+8l6XtWLUsKaSmj1ERaXSG6B++V8k4sw/Dg=;
 b=oQIpjDgs6NseTYJPPj59uTyDEL59yEd6fauVaeKlF7AiIgoLFR4iyLlOF364c8DbSK
 wg7PUQGvNw8h7QkJjVae1QfjCqdWXywYEPVP/vGUD1GPFBbMnPy/oZr+CU8qEX/cyXgC
 /YE3Tz8ZJVlo4FIW1/4bc11Jq0UaLivEGWmIeamQ5Dg0FYX40miuhbBLTwl2klomQaqJ
 16RybLamHZdfpfyX7QUpgKJX9G7uRJ52XNzdFPBATG67cOCtpJkW0k25T3zateAGyMYS
 WY+uSjyof7atUKOvr4Y3jDQPZYbh6wPGguBvd0NrSVt9/JKQyooPXc1uGmFnMoqkJ7A8
 qmyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjxNOJDq116Q6I7GXjoFGrluYSyQ8Uv5FeYA9InuVAPq4qU5qAiI4x6WJXQhlaMQUmhZnGflJIiNb4@nongnu.org
X-Gm-Message-State: AOJu0YyCndorLlpXqjbN17u9dQjQKKS3agYS81puh0j+3WMmlkSe9kXG
 D1HKnvExKXVPS6LfV/uoDg9ZUkh29Z53kG/Sq0UJ+Tdg/zanoWqGl8+yoJu0IfuLVLtLYimk9Ax
 tMtAnF3gY3MTT4orCuHmHSjd5/q1B9+esqv/yJgiTL3lm2p1TVp4S
X-Gm-Gg: ASbGncsP0fiAhvPdPGMiylYivCmOn4i09nXb2/1Da2gQSGcBaECSZvsemdmAFIKxOQR
 iNj+fleXNjj9/CmPw/bpBIw2fXq4sV/3Jm2dpLpN9lOuETaavsvpcL8G+th3EZy7Wxh2K7eXaq9
 UIA82fKce1Y6ozXVBDKpBYXoScYXImfxyz+NKPzGFjA+9TKutoTXeG+7NIaMYZ9RXUHOOFH+LyQ
 BhqsBs4AwB3fjJjnYR4X/3s43jtPlmWTqSi4XR/u7qrs7J6Qaahvfy5SmCZn46CY3apB4Z8V41r
 ULejfIB1Kf7epCz2GFvRIH5SKIuO87bDjvz04hFkemTdWZdHQZAZGag5M/owC8w42lt8ShAVoDT
 aoz+caJzO8QPqgmA5ogw8ToC+UStrCHDB/bsv62MSYA==
X-Received: by 2002:a05:600c:698c:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-43ed0bc790dmr169569765e9.8.1744114864534; 
 Tue, 08 Apr 2025 05:21:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMhO+qTvI5oJm8EmJv4N8lZHhfWhqCdyhyhRbF54YBpombAy8VDbWcYFrks0Jkj/3TyRBlrg==
X-Received: by 2002:a05:600c:698c:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-43ed0bc790dmr169569575e9.8.1744114864182; 
 Tue, 08 Apr 2025 05:21:04 -0700 (PDT)
Received: from ?IPV6:2003:cf:d732:e461:97f7:52b:6be2:2597?
 (p200300cfd732e46197f7052b6be22597.dip0.t-ipconnect.de.
 [2003:cf:d732:e461:97f7:52b:6be2:2597])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a67b7sm14464378f8f.25.2025.04.08.05.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 05:21:02 -0700 (PDT)
Message-ID: <5700038e-a0a7-4bcd-bf7a-ea159a7de43d@redhat.com>
Date: Tue, 8 Apr 2025 14:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0] scsi-disk: Apply error policy for host_status
 errors again
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20250407155949.44736-1-kwolf@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250407155949.44736-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 07.04.25 17:59, Kevin Wolf wrote:
> Originally, all failed SG_IO requests called scsi_handle_rw_error() to
> apply the configured error policy. However, commit f3126d65, which was
> supposed to be a mere refactoring for scsi-disk.c, broke this and
> accidentally completed the SCSI request without considering the error
> policy any more if the error was signalled in the host_status field.
>
> Apart from the commit message not describing the chance as intended,
> errors indicated in host_status are also obviously backend errors and
> not something the guest must deal with indepdently of the error policy.

*independently

> This behaviour means that some recoverable errors (such as a path error
> in multipath configurations) were reported to the guest anyway, which
> might not expect it and might consider its disk broken.
>
> Make sure that we apply the error policy again for host_status errors,
> too. This addresses an existing FIXME comment and allows us to remove
> some comments warning that callbacks weren't always called. With this
> fix, they are called in all cases again.
>
> The return value passed to the request callback doesn't have more free
> values that could be used to indicate host_status errors as well as SAM
> status codes and negative errno. Store the value in the host_status
> field of the SCSIRequest instead and use -ENODEV as the return value (if
> a path hasn't been reachable for a while, blk_aio_ioctl() will return
> -ENODEV instead of just setting host_status, so just reuse it here -
> it's not necessarily entirely accurate, but it's as good as any errno).
>
> Cc: qemu-stable@nongnu.org
> Fixes: f3126d65b393 ('scsi: move host_status handling into SCSI drivers')
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   hw/scsi/scsi-disk.c | 39 +++++++++++++++++++++++++--------------
>   1 file changed, 25 insertions(+), 14 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


