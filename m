Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B111C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVgJ-0003wx-O6; Mon, 26 Feb 2024 02:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1reVg7-0003q0-NI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:45:37 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1reVg4-0006Ae-TR
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:45:34 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5d81b08d6f2so2860830a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 23:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708933529; x=1709538329;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QOdDluXPuLljtdvR+/B4mCq3loLA5ffXM/3O5deycYA=;
 b=S6LSUbXxtei89YPjfvb8FptSZKvbhUv4aDbf9gi/mlCk11x5ZGSppwB8fOjJjyCM1M
 PAtjGldZohdmdg9p77O5yN0jVfL8NnFrMIZecYi53bpPF7Qv470c8pX8fZIINXuIxRF9
 KJwu2WmcSSCY7uruxwzkNY0gZtFdSORiUcKxu+Z8xiNh1aHC4baOXK4ooZG4g3eo6lKn
 wCIMhKgEz3LZzTtXp0CaBJW2H3cPsOfC3A4/rd9fMkKrlqFOcfC1fAw6raW7l4bX54sF
 aZVrr2lsSPz4Pxo9rYvRksoaYLje1N/qHAJn42tz5doVtAMK4VP/eTRYmYxLePfS9JNQ
 MEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708933529; x=1709538329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QOdDluXPuLljtdvR+/B4mCq3loLA5ffXM/3O5deycYA=;
 b=SXVw0iNSE4MeBtb6B31hMSxlbdUMKG/lESdpG/qk+a8CL5BVL6U4ksu0gr8kMmwiKn
 Q7o21o3K3n6SwB44L2Om/e0sR/xTlbVU+EcW7Rf1muHTmyknz39hudKtHOAn74l+bof5
 9SKJMB5Q4Q76+xL9p5b9yVH4S5fL3iy7fc3FSQoupk0UuDcuovyTjABzzYsWc1Y/Ehce
 YfuSFRRIpmMS/xbNmCrIpb09hD3yGIue1LtCZdl7UjmMKvuCeWHnITdCP/52GI0mbYIh
 7JGy1I107XH7hk991yt1VG3Z4/+iEPqEcYZxfrnhy6g2jm66I/3F2x6qTMKyoA2fGLOo
 YR/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbyCCUm5qA8NjxbwA8oc63sfCLIyVBL1uH8AQ0t5rUbfJMVn5jUjlimV66ZGLi7lV4yU8W1U4ulEc8UybR4cBr4DqD2zI=
X-Gm-Message-State: AOJu0YxQ1juFdhAzvrtmVC4NzEDlkNvLJp5iAYhvM1QaRSHRKs1Ghosk
 SrYzgxACZI+IV0p2OthtSBg/kS+OgfepldomhDu6uY2eSGqFR9VRvqGu+zoCwTw=
X-Google-Smtp-Source: AGHT+IHr8E7M59XwdRPV12qcpkm+G6akmr7Q8x1vDh9KYTs+VOpfSs9rCDNz3knFIyc4lTzji2LAXA==
X-Received: by 2002:a05:6a20:9f45:b0:1a0:dfdf:2b16 with SMTP id
 ml5-20020a056a209f4500b001a0dfdf2b16mr10597690pzb.43.1708933529375; 
 Sun, 25 Feb 2024 23:45:29 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a1709028a9100b001d8e41b3f95sm3314284plo.51.2024.02.25.23.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 23:45:29 -0800 (PST)
Message-ID: <4d8e342f-cbf9-49e5-8797-f6635996c8f4@daynix.com>
Date: Mon, 26 Feb 2024 16:45:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Free argv
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Steve Sistare <steven.sistare@oracle.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20240225-argv-v1-1-a11e772884d9@daynix.com> <ZdwKNYI-uhkXJ4B5@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZdwKNYI-uhkXJ4B5@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/26 12:49, Peter Xu wrote:
> On Sun, Feb 25, 2024 at 02:54:01PM +0900, Akihiko Odaki wrote:
>> exec_start_outgoing_migration() and exec_start_incoming_migration()
>> leak argv because it uses g_steal_pointer() is used to pass argv
>> qio_channel_command_new_spawn() while it does not free argv either.
>>
>> Removing g_steal_pointer() is not sufficient though because argv is
>> typed g_auto(GStrv), which means the array of strings *and strings* will
>> be freed. The strings are only borrowed from the caller of
>> exec_start_outgoing_migration() and exec_start_incoming_migration() so
>> freeing them result in double-free.
>>
>> Instead, type argv as g_autofree char **. This ensures only the array
>> of strings will be freed and the strings won't be freed. Also, remove
>> unnecessary casts according to the new type.
>>
>> Fixes: cbab4face57b ("migration: convert exec backend to accept MigrateAddress.")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> This should conflict with Steve's other series:
> 
> https://lore.kernel.org/r/1708638470-114846-1-git-send-email-steven.sistare@oracle.com
> 
> Considering this can be stable material, should be easier if we have the
> other series rebased on top of this, even if that was sent first..
> 
> Steve, do you still plan to repost your series?  Maybe you can review it &
> pick this up into your series?  Then whoever pick up your series will pick
> up both (Markus will?)?

Patch "migration: simplify exec migration functions" included in the 
series fixes the identical problem:
https://lore.kernel.org/all/1708638470-114846-6-git-send-email-steven.sistare@oracle.com/

I withdraw my patch as duplicate.

Regards,
Akihiko Odaki

