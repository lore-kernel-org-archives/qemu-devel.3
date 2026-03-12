Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC08106ACE3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ly5-0005Ta-Bv; Thu, 12 Mar 2026 15:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jorge.merlino@canonical.com>)
 id 1w0ly3-0005TG-QA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:45:11 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jorge.merlino@canonical.com>)
 id 1w0ly1-00018s-Ae
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:45:11 -0400
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BACCD3F1CC
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1773344706;
 bh=06I1nqkBOqM3AgiC7in7DRy/JaGWSgBaQ+zRsY8okDg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=mHl/jz6Fst5bHI0v2MorTdW/gt+lPIv6BtApOd8yxM2ET2DmrX6YM+oGW+/IQcSiE
 71/wremY14rVYqLKeNVNJhRyeFXhnUcqwTeO7dyRAewIk87qlRDMNQdMJF8Of31VgN
 KxOUryJjq4Ftv1cdojo1kpXzQPGEPte4U5H8CN4d1LvIxUyGhG0OPgQvMsD04hSTqy
 z6BgcQPxyFiu3ZDp9+V7jRjfoCfeA2pkmjr7NNiX8fm7K/XUvxgVAYV2y4ujBicKcq
 yd2hljR2RBF+TjiBI8rGnw0m3q5HW6eG5cHDGlNgrlhRbg9fXwsZT/9289xDQjcfHP
 kfaCWriAn0UQZ9r/Ug2nXfZyi8nFo2Gr7RlT4yQRxRih6CKzQJJDoyjZg2SztwJuXE
 Hs+HJ1+L7IxTlugHK48eK4uMUe/U1sckNHJpz9fIALxUycWP0BUH0Kz9c/taRuwB3v
 7cfXOuYDzAjWws/E4CO5dXGJCp6GvQWO3OOsEch7jkhLi67L3bh5F/Kwt9x7efIIy+
 hvv5jOPByk8R9lES/A6AJ4bkTa+8y3bbYsDZ81KdlX0ZxmF0JENW35Q1I/6qX/UOCZ
 Qmaocgk9oue2N/taUbEUhvFw5hvRZ4bBEM7vFGcQMd2YGIAatGPPcjJykmCJTds69s
 lMjtehf/tmhOk18YoUBQL39A=
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bdf75bc88fso1762779eec.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 12:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773344705; x=1773949505;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=06I1nqkBOqM3AgiC7in7DRy/JaGWSgBaQ+zRsY8okDg=;
 b=WD3WgzQ6afYT7MK/VG1L4fL1mgE474aoslFYZEaJThpMY13rV2MGJwDqIhytYWDRUh
 tc8TYhCbo0wqwL1kYtnBJEJO/Qb/pLHj3AGusDgJMNPyD8wvQgAsNXQvbURTyYbSYnBp
 83O2Jq5h2mePH9L5bc+WkDZ+elALhF0qlvpnasQKlk+JI4s4qrcEbELWW6Pbc9jjDzoY
 K5ZkxvPvhQcTOO5EnSLpja/IOsDCa3B83SDNYoDmadbR8wISzYwZNnQl2S7VMUe96NI2
 vA3JUGQxmvMtxjvElF8FjDvuWi835OTS6aou+cOeZxI6aypcWiMEdq5XRRIkL4ZAgA1z
 AisA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7uQdgCY6t4KzD/v8uEDJNGXuYf9cRqTTPRMEx+H6VolUqeOrkeuHlRXQWWriOdJ6jMcsjLf9ARGOv@nongnu.org
X-Gm-Message-State: AOJu0YxKiLHwJFujxnEtwVwciCAF+unX3Uz6pmBVppwKhHPfccSPRR1L
 oRlZ5ZjoqxE5cPTqMfZBy71MvTkpQ9aiDOT6cCKH7X29VUI4QgvTS0p/+dJ5NzLRNknOmrceFG7
 i25Tb7ti0Mf2A6AxAwz3fXEoqY28SrV4B7HtjePhdg5UsenGh5RKbXR0dKAf3teP8wZYAJeuk
X-Gm-Gg: ATEYQzyhW8sN3OicKKHCriPGXsolHABGkbygYUG45Bij9cRlb4Z5QueAvNOszoiBVKr
 IdInIeCF9E7Er0FW5Sz/6xa/xLn8m/kKpcF2JAM09sPWwfS3PD3P+uMRiHHIStbomZSRcrmvpdU
 eTZvyctmmpezx5zeAY2rPMj/v7xrBpPdpv6c4GiPRp/zavS9RIdzeo4IUcbvg93SIfiyTgccZkj
 R6avVzcebPTdE0Y6UxaE7GiUfg+S89/8ewlDPVUQnMA7i4g90mI8CJ6QTwthHu4LFgm2BQkyx5Z
 tb4uzlCk8hWUOEyzg3T65ezV/aXftfi9EcXLU9ulEWZr/H/vrdWtGORvuwc6HFx3Y8BHPwdg/zf
 Trb1Zcgrrzc/bXYukxlEbEUA/k5QW5g7ibHNdqg8dQpeznv3SwayG
X-Received: by 2002:a05:7022:628b:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-128f3e06b8emr349744c88.34.1773344705248; 
 Thu, 12 Mar 2026 12:45:05 -0700 (PDT)
X-Received: by 2002:a05:7022:628b:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-128f3e06b8emr349732c88.34.1773344704796; 
 Thu, 12 Mar 2026 12:45:04 -0700 (PDT)
Received: from ?IPV6:2001:67c:1562:8007::aac:4084?
 ([2001:67c:1562:8007::aac:4084]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128f462b6a4sm574875c88.14.2026.03.12.12.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 12:45:04 -0700 (PDT)
Message-ID: <74b0692e-27a1-4dd1-a0cd-3a50ebd02aea@canonical.com>
Date: Thu, 12 Mar 2026 16:44:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] throttle-group: Fix race condition in
 throttle_group_restart_queue()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>
References: <cover.1773316842.git.berto@igalia.com>
 <825598ef34ad384d936da19d634eda75598508f7.1773316842.git.berto@igalia.com>
Content-Language: en-US, es-UY
From: Jorge Merlino <jorge.merlino@canonical.com>
In-Reply-To: <825598ef34ad384d936da19d634eda75598508f7.1773316842.git.berto@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=jorge.merlino@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/3/26 9:12, Alberto Garcia wrote:
> When a timer is fired a pending I/O request is restarted and
> tg->any_timer_armed is reset so other requests can be scheduled.
> 
> However we're resetting any_timer_armed first in timer_cb() before
> the request is actually restarted, and there's a window between both
> moments in which another thread can arm the same timer, hitting an
> assertion in throttle_group_restart_queue().
> 
> This can be solved by deferring the reset of tg->any_timer_armed to
> the moment when the queue is actually restarted, which is protected by
> tg->lock, preventing other threads from arming the timer before that.
> 
> In addition to that, throttle_group_restart_tgm() is also updated to
> hold tg->lock while the timer is being inspected. Here we consider
> three different scenarios:
> 
> - If the tgm has a timer set, fire it immediately
> - If another tgm has a timer set, restart the queue anyway
> - If there is no timer set in this group then simulate a timer that
>    fires immediately, by setting tg->any_timer_armed in order to
>    prevent other threads from arming a timer in the meantime.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3194
> Signed-off-by: Alberto Garcia <berto@igalia.com>
Just writing to confirm that this patch works fine in my reproducer for 
the bug.

Jorge

