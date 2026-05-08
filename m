Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C733CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 13:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLL1W-00058R-IE; Fri, 08 May 2026 09:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wLL1P-00057W-ST
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wLL1M-0006sA-38
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778246015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+p2xIRxOQYUjJ36EqLtGzkoE7p8fG1OPlXVBzR9jtEE=;
 b=e8XjQcywCDzcL7rG516lzXNjEkT3VyrWCOPRM9E9Z5qQ7tTXyxhm0WzW3x+CpU5yQerU+a
 hg4fiRm1Hrx1zCS7oBA0hYF0hXughU53uUICpdL16TxoVUTstWy6A7ZL5A43AkpPHHJZpo
 IGaLQcwIWFNGjlw74zRVdg1rpqBk+Tw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-6OSxvXE7PCWP3jUukFlxNw-1; Fri, 08 May 2026 09:13:31 -0400
X-MC-Unique: 6OSxvXE7PCWP3jUukFlxNw-1
X-Mimecast-MFC-AGG-ID: 6OSxvXE7PCWP3jUukFlxNw_1778246010
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-449dcfe8005so1681526f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 06:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778246010; x=1778850810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+p2xIRxOQYUjJ36EqLtGzkoE7p8fG1OPlXVBzR9jtEE=;
 b=sQ1x7UmEyCDN6M0FHaDbKZPA7NuClEAhPzcC1AJYWcId0oZEF+7y/xYkg4zYQOVIb6
 u110iy2uWnjDL5sPp578Oytt1YVOWiCLS2lsaLX9RYFCyRkt87UrUBugY1WRvYP7ssxV
 XhHwc7mmTWp7T5xvstTuW+wdIJTOMg98J40p/Fll18n8VX/C+j45AkpfGGvf1hmD03zs
 5yvKvLXkw3wA76twO3+exKQWAPkLWA0kqvrqI7kLk5Qc+lXFpoAW0MNLoyuYvxrTJGoy
 iPhcnE2NlaNdxsR95Fm1tq/96SphlmKaI1vsdNwtRpO9JG2E0zf+9Nl7pTuV4xccEsoD
 KNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778246010; x=1778850810;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+p2xIRxOQYUjJ36EqLtGzkoE7p8fG1OPlXVBzR9jtEE=;
 b=p9OiN5AT5lLcRGBR5wK4OVJauZD/UzXbfjhbefosMJkYi1Ck2jLYRi+eJsBqAjqkMv
 f3yG1Ug+GuSPOX4Ox4Y5hIg0MCwp3PQpEQGwqGKhTvMi1J/GeZDkbRl64+GGffc5lDOO
 nlxGSVv7aV1N5V+4vYb2yi8ZVbsAaF8X/KFYyvKHQ0uTpk90zU4KXbmRyWfR4t2BYnws
 pmzYBVf2Kvv58lrRXFvgBDsjWQqyiF6nTlHihtISF7bTqxRpeuNjOfoNeNAijqFdEbaO
 pQbGn7Ea8pP9/BwxnPE3HbesfQQHNYPxmXa/cibZA1mFoG8i+wrpPOkuDFmNoZeZHxbO
 CnGQ==
X-Gm-Message-State: AOJu0Yws1xveoq5dRtOKwl+xiSu0wn3zysuSQuE9Eu5/KpOHG/iC7ER4
 zQLISlKPx8p2QgbTM50KeD+arRSOGIZUCIpJLBaf6Qbvt3TuAcu5XFtt7uTeIzW5Uz6oQbHYRwQ
 NyGT4uMDEWxmqUVjHMkb+Bj28xJsYcBXdmo9Bt82tLYB4hvZrkwoj1Jw7
X-Gm-Gg: AeBDievQ/FHU9Xs1breTSa9sDbog1syX0rmj/rOU4qrInRw5J4zAyUC1ZRsHpDYtpBi
 J/Gn8oyTCit95PCG0KslJx8YsA1Dvd/Q2TDFbq6Nx6oELEkCTzrjBtCz4tHjk+rnEPVje/iTt8L
 Larx+VagrkIpAnuqwBECTMG7dOwiG8CSQBuQl85ECVKPfroS3GxvOTdrmTOWGzCrEeIc1M3vRsA
 1er8YtCFoexS1NK8CWufUvjEk1qrjLF4K1KvTO18AFUEbmxW/HefowNUCr95sLPYIHIVCOe4mDD
 NWxRIACWQhUQZfXYuapIaIQ80THssblyXc0givLIu8DCVSfAB+XNlJVPlEtJZzvA98ys8f+z3wO
 v7hToBqwzJXPIzEheM68WPh3mKcxkE0sh5xz5hHx1m8Zn4hg6dbkfTqGzdW9RwdgH3suqMbkaaY
 S/IEj62JI3l86xc4H2rjifErXSawOI9BSKTNBjY0oKZqjHiwn6FF7LQfU44OjWAA==
X-Received: by 2002:a05:600d:18:b0:488:b811:51c4 with SMTP id
 5b1f17b1804b1-48e51f3c4f4mr158139785e9.25.1778246010042; 
 Fri, 08 May 2026 06:13:30 -0700 (PDT)
X-Received: by 2002:a05:600d:18:b0:488:b811:51c4 with SMTP id
 5b1f17b1804b1-48e51f3c4f4mr158139265e9.25.1778246009568; 
 Fri, 08 May 2026 06:13:29 -0700 (PDT)
Received: from ?IPV6:2003:cf:d713:2001:af32:685a:7b5a:da25?
 (p200300cfd7132001af32685a7b5ada25.dip0.t-ipconnect.de.
 [2003:cf:d713:2001:af32:685a:7b5a:da25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68eef558sm39551625e9.7.2026.05.08.06.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 06:13:29 -0700 (PDT)
Message-ID: <d5c3d3da-5102-4bdc-87bc-9733fb0cbf09@redhat.com>
Date: Fri, 8 May 2026 15:13:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/28] fuse: Manually process requests (without libfuse)
From: Hanna Czenczek <hreitz@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
 <20260310162622.333137-18-kwolf@redhat.com>
 <2493d422-d58a-4409-aee4-e932a4e0a73c@proxmox.com>
 <8ec42109-4123-4cc7-a55e-9aa2576a791c@redhat.com>
Content-Language: en-US
In-Reply-To: <8ec42109-4123-4cc7-a55e-9aa2576a791c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08.05.26 15:06, Hanna Czenczek wrote:
> On 08.05.26 13:55, Fiona Ebner wrote:
>> Dear maintainers,
>>
>> Am 10.03.26 um 6:37 PM schrieb Kevin Wolf:
>>> From: Hanna Czenczek <hreitz@redhat.com>
>>>
>>> Manually read requests from the /dev/fuse FD and process them, without
>>> using libfuse.  This allows us to safely add parallel request 
>>> processing
>>> in coroutines later, without having to worry about libfuse internals.
>>> (Technically, we already have exactly that problem with
>>> read_from_fuse_export()/read_from_fuse_fd() nesting.)
>>>
>>> We will continue to use libfuse for mounting the filesystem; 
>>> fusermount3
>>> is a effectively a helper program of libfuse, so it should know best 
>>> how
>>> to interact with it.  (Doing it manually without libfuse, while doable,
>>> is a bit of a pain, and it is not clear to me how stable the "protocol"
>>> actually is.)
>>>
>>> Take this opportunity of quite a major rewrite to update the Copyright
>>> line with corrected information that has surfaced in the meantime.
>>
>> a colleague ran into another issue with a fuse export, this time in 
>> combination with virt-fw-vars and bisecting points to this patch. 
>> Before commit a94a1d7699 ("fuse: Manually process requests (without 
>> libfuse)") the reproducer [0] completes successfully, after that 
>> commit it hangs at [1]. The issue is still present with current 
>> master. I can dig into the details next week.
>
> On my system, virt-fw-vars opens the file with O_TRUNC (after “INFO: 
> writing raw edk2 varstore...”). It then tries to write to the file, 
> but this returns a short write because the export is not marked as 
> growable, and for some reason, the write is infinitely retried instead 
> of aborting on ret=0 (which should indicate ENOSPC for writes).
>
> Using growable=true makes it work.  (For me :))
>
> For some reason, before said commit, libfuse just did not pass that 
> truncate on. I’ll look into why exactly, but so far I would say the 
> FUSE export behavior is as I would expect it.

Ah, I see. libfuse sets FUSE_CAP_ATOMIC_O_TRUNC, which has O_TRUNC be 
passed on as an open option, but the old export code just ignored all 
open options.

The new code does not set that option, so O_TRUNC is executed as an 
explicit truncate by the kernel, which then *is* executed.

I’m not entirely sure how we should handle it. There is a case to be 
made that with growable=off, it may make sense to ignore O_TRUNC (which 
requires turning on FUSE_CAP_ATOMIC_O_TRUNC again and then continue to 
ignore it). But on the other hand, O_TRUNC is O_TRUNC, and growable=off 
does not explicitly mean “please behave as much as a block device as 
possible”.

What do you suggest?

Hanna


