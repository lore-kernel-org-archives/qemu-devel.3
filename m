Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6A6D5B16E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 14:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV9Pu-0004of-8D; Mon, 15 Dec 2025 09:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vV9Pm-0004ni-3W
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vV9Pk-0005Nu-9N
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765808342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OvgLDvxrJ67GK1yRSHsVCSFPRJpDyApYmtZaMcssZ8Y=;
 b=HwfI4LBwgM3BxoS3x7J5Thr8/+bADtY0G95kaeKbRr+jL900Ha4649BfvhhT3lYSoOAdHT
 Ltq0lRVwqVn0bKDQDtaiLS1RHWc0cZWNJMdWxAZSKeOi4khHwdI86u12tlTvsMBbCJ9wfJ
 u7dJEND9b+bkqx1mS6a3Vu+a5j2IZ7Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-LpyiaffVPpGRcl7PcuOxdw-1; Mon, 15 Dec 2025 09:19:01 -0500
X-MC-Unique: LpyiaffVPpGRcl7PcuOxdw-1
X-Mimecast-MFC-AGG-ID: LpyiaffVPpGRcl7PcuOxdw_1765808340
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430ffc4dc83so510424f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 06:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765808340; x=1766413140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OvgLDvxrJ67GK1yRSHsVCSFPRJpDyApYmtZaMcssZ8Y=;
 b=Trl1yiDVuph5QGJgQ6do59Mq1oZ9DV5jZQwRIKZMba8OmheB3v3Yd64ZbVa3kxjHat
 fywD2TikfA54lTF16HmQK5M6tVmLZMq1v+j/NB+ThZ0TRvF/wP93aEEID2ahIw9/AbNP
 3R/5gE29b8nGEHBNTQ3VrWDpZAxo0mALRfgd7W1HelkOydvJafVbVGl3lx0o7XdiQZQa
 DQdmRNAkFr1Hj9QEkUtflqly15VRawvBgl8fZqgJ/IhYfYk7gPb61/Q8y4gJba6fVfv2
 fj/cVyCJ06lJg+zPE9FVDFvZeyCjAs5hNWD9JY1Bm42IzOEvVMS3HygB1oyiZRcwM2Te
 JXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765808340; x=1766413140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OvgLDvxrJ67GK1yRSHsVCSFPRJpDyApYmtZaMcssZ8Y=;
 b=JJWjHDrHOrmNZuxXEncLKuxLzHcWWL5pJN2qiFc7luF2DXaRwHSsrog8SJrlsDaNMR
 6ZhvOTzgHroiEIw3GOfhcX6lpRW1UZdNnH/Go4P9vContsiV32tlbrtpk/c2CINjDYSP
 KQHBjGHUNKcYloelDGTco0CQz/WUSHdPRf6App3ay59CBwIojp4zAdAAbO1xBqbriVYf
 gCOBEMcBtkROHUWJxrJLWKPHyXeCM/aSS/GMZyAEJyGX+wdi6mLxkwZB/NorkKYzb6TJ
 6xfMgzp/p/ud3EkNOG9/frnQFGLoxFCQSzT+2bJjj+WSSpXHZAfYlXRlEqMxM91LvHTT
 ncew==
X-Gm-Message-State: AOJu0Yz6n7JtfKVuoxyee5TAHHjoaNErS8b/YeVD7LrLj0GnuxsKDREh
 ss9GB+89Bb/mQGeXyfqTr1PyUs8/b8N6lEddO7bGF5fPppFyMor7RxXMQbzob5wdUdEOE7uP+aH
 smcEV3uc0Bb6XC6Y5GMfwctKLl0qZT6klToeF7mkSrgI2dk1lgw9wrZZz
X-Gm-Gg: AY/fxX4wKbZS+8k2inoxS6y3270aot7pMy3mF9sfLeJ525MGE4Pq2W7EXuFXiT5SaIK
 iU98rI4q0li/lhwbHjhP3WgkHUwMMe1zvPqFvfltFo3cql5GMtCw7flg+UaiB37UOnuvACFpMBy
 UwjG/KmXEcQyd8WHJJYLnnu4+83YYjArKLj/qo0+SI4UxWOt7SJBg3jKgbSYntNwbWpJWWdW48g
 2UTvMYn8HEgN25oNwm2aUyhaijsov4LznhWEep4M0sUPDcbDCc5wjs/l7sQqUxXDxmR17QQaUYb
 yOLPSHKy94wczctCrKGdAgxNa72kjkObgiSpEeOqpiIubk82/qPXE1SbBYP/4sOD7eWB/E6+u0n
 9Db6sAX7vqHuQUUKXepBGeyoTVB7Yv3x1FXdQ09WRC8Jpp/jAoF6gTQINMHDel3vslzyTnHOw/G
 S/sNDHU7E3eSqWZ8sSm6oY4IAEnCiAzjN5jrQUwXo=
X-Received: by 2002:a05:6000:2f83:b0:42b:4233:1d6 with SMTP id
 ffacd0b85a97d-42fb46e48b3mr10069350f8f.34.1765808339914; 
 Mon, 15 Dec 2025 06:18:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmgU2TUCgxC1xs5risPEwHEBDj4OI7BCvCbIcrbpg3qhW8Lt6rOK7poh23eHVHy43kkWq1fg==
X-Received: by 2002:a05:6000:2f83:b0:42b:4233:1d6 with SMTP id
 ffacd0b85a97d-42fb46e48b3mr10069322f8f.34.1765808339437; 
 Mon, 15 Dec 2025 06:18:59 -0800 (PST)
Received: from ?IPV6:2003:cf:d717:1f21:7615:7dc4:a8a4:2b71?
 (p200300cfd7171f2176157dc4a8a42b71.dip0.t-ipconnect.de.
 [2003:cf:d717:1f21:7615:7dc4:a8a4:2b71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b9b6bfsm29307112f8f.43.2025.12.15.06.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 06:18:58 -0800 (PST)
Message-ID: <1c410195-acf1-4f72-a9d7-a58e58c9cff9@redhat.com>
Date: Mon, 15 Dec 2025 15:18:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.2] Revert "nvme: Fix coroutine waking"
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?=
 <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
References: <20251215141540.88915-1-hreitz@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20251215141540.88915-1-hreitz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15.12.25 15:15, Hanna Czenczek wrote:
> This reverts commit 0f142cbd919fcb6cea7aa176f7e4939925806dd9.

Sorry, in my joy to have found the root cause (I’ve tested a fix 
specifically for that on Lukáš’s testing machine), I forgot to add the 
v2 changelog:

The code didn’t change in v2, only the commit message did, specifically 
to note what the root cause is and why reverting fixes the issue.

Hanna

> Said commit changed the replay_bh_schedule_oneshot_event() in
> nvme_rw_cb() to aio_co_wake(), allowing the request coroutine to be
> entered directly (instead of only being scheduled for later execution).
> This can cause the device to become stalled like so:
>
> It is possible that after completion the request coroutine goes on to
> submit another request without yielding, e.g. a flush after a write to
> emulate FUA.  This will likely cause a nested nvme_process_completion()
> call because nvme_rw_cb() itself is called from there.
>
> (After submitting a request, we invoke nvme_process_completion() through
> defer_call(); but the fact that nvme_process_completion() ran in the
> first place indicates that we are not in a call-deferring section, so
> defer_call() will call nvme_process_completion() immediately.)
>
> If this inner nvme_process_completion() loop then processes any
> completions, it will write the final completion queue (CQ) head index to
> the CQ head doorbell, and subsequently execution will return to the
> outer nvme_process_completion() loop.  Even if this loop now finds no
> further completions, it still processed at least one completion before,
> or it would not have called the nvme_rw_cb() which led to nesting.
> Therefore, it will now write the exact same CQ head index value to the
> doorbell, which effectively is an unrecoverable error[1].
>
> Therefore, nesting of nvme_process_completion() does not work at this
> point.  Reverting said commit removes the nesting (by scheduling the
> request coroutine instead of entering it immediately), and so fixes the
> stall.
>
> On the downside, reverting said commit breaks multiqueue for nvme, but
> better to have single-queue working than neither.  For 11.0, we will
> have a solution that makes both work.
>
> A side note: There is a comment in nvme_process_completion() above
> qemu_bh_schedule() that claims nesting works, as long as it is done
> through the completion_bh.  I am quite sure that is not true, for two
> reasons:
> - The problem described above, which is even worse when going through
>    nvme_process_completion_bh() because that function unconditionally
>    writes to the CQ head doorbell,
> - nvme_process_completion_bh() never takes q->lock, so
>    nvme_process_completion() unlocking it will likely abort.
>
> Given the lack of reports of such aborts, I believe that completion_bh
> simply is unused in practice.
>
> [1] See the NVMe Base Specification revision 2.3, page 180, figure 152:
>      “Invalid Doorbell Write Value: A host attempted to write an invalid
>      doorbell value. Some possible causes of this error are: [...] the
>      value written is the same as the previously written doorbell value.”
>
>      To even be notified of this error, we would need to send an
>      Asynchronous Event Request to the admin queue (p. 178ff), which we
>      don’t do, and then to handle it, we would need to delete and
>      recreate the queue (p. 88, section 3.3.1.2 Queue Usage).
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Lukáš Doktor <ldoktor@redhat.com>
> Tested-by: Lukáš Doktor <ldoktor@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>   block/nvme.c | 56 +++++++++++++++++++++++++---------------------------
>   1 file changed, 27 insertions(+), 29 deletions(-)


