Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61408E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuGB-0005WR-T2; Wed, 18 Dec 2024 08:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNuG0-0005Vi-T2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:38:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNuFx-0003l2-Vk
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734529106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M7zHM7Y9cSBpJ02uJavwdBb2BmWbWPAu6CtOVR+z0TA=;
 b=TP371I+exXZiouF3my/WrpTxV9J1oYKeTvw8NqHmSG9NdZXkwE8v7xBktyNeynsiHJr8wD
 Ewf33r5jUTh0y+m6E8zP+fHtW1KJw1aydJFbQU0bP8gtztRfXgVXqGDT6sC6OWXL8oUmsf
 0ckEogv7yE7LS3JOQi8QSC4V4JC8ah8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-K7605qGAO-ajp8DmeOVabQ-1; Wed, 18 Dec 2024 08:38:21 -0500
X-MC-Unique: K7605qGAO-ajp8DmeOVabQ-1
X-Mimecast-MFC-AGG-ID: K7605qGAO-ajp8DmeOVabQ
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467c08e67easo83070061cf.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529101; x=1735133901;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M7zHM7Y9cSBpJ02uJavwdBb2BmWbWPAu6CtOVR+z0TA=;
 b=oFXKVRqtHWLLSwkeQJinnS4Oyrtci6ZZDsSKijYlXLOmfpN1S0Npk6kFzMHfnKBdpK
 N4UJXDQch6pHJkSDUmwmPIKFDgxOvs3sk4tKKoM0w1nC//cSGdPFsi9SMfX3xLz1nJrT
 JhmtoKDEFiFD+PfjptsWID7fpg+Q0Ja6UGSuliuMqJY+tYSIrbVMziGNvqcIWDVxfrVc
 9VRisLVNHu33qxJ2uuhdP0hm6uhzBaJVInzDfFEgy5baXb6K5fv4RbcY+TRCYAkYC8th
 IXlbNrf1AFlVf9EBgvsdNhixeqt68UMmwGRxvQgjqyMrSukSYhTOBYwtzhFf3SBzb6Yc
 KOhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVXuA9vdZdv1bXQ8OJBGNJLtK0nGszJpSm8nSfVHRJrWImqPjKX+bfYMa8DnJxrVhUJPbH4NDRHYWP@nongnu.org
X-Gm-Message-State: AOJu0YycMwOnLCAZWbBpP9MxScYOoisHrTYMzcc3mUFdGQXrJzGlIgwj
 cy5x9ylQj1hRlEr0gttHw3sb4WAZzdHf72TGzxyWC7/my5UQkig+0rDNxsI/AMUXnIlxjToCP5q
 gJnXkVv25CAQtICXiNPAL/4pjJROMle+GUfeg7VKzRlH4MqtGoHMLd8T3Ou1r
X-Gm-Gg: ASbGncsm0tspDb5qvXE2DkFCX35xth6U7C4vB9jWIPokQpIA+m3C2hOIepYGpVmDvIi
 vY0UDkm1ZX/Pzl7qtrpkdSsthU2m872e5XXCQApskD/w/TrEfLfEShWL4u/d8VXZwsDx4A5eO6v
 58Mpx80mh4DqURw+lIZcP2oXBNHkfzMcfrUm8KYKeh1f3fDvdV8BYCSKNwo/fB1/7rWx05Zr+ds
 b/aFneTaDJx/2Zzb0k5MoH35OtJceXKTbx76I8Y/tupRbNrq1fPMiJ//klgV2C6LP+d833NZ4mw
 zJ6wCWgNXA6W
X-Received: by 2002:ac8:5741:0:b0:467:77c0:1c9b with SMTP id
 d75a77b69052e-46908ed2106mr45589421cf.53.1734529100750; 
 Wed, 18 Dec 2024 05:38:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKtcyvCPXYeXTHoYTvH1Vo5L67wSPwTfezJCacWlgopPPaC0UquOedI4h7GpmcSwVHB35aDA==
X-Received: by 2002:ac8:5741:0:b0:467:77c0:1c9b with SMTP id
 d75a77b69052e-46908ed2106mr45589051cf.53.1734529100427; 
 Wed, 18 Dec 2024 05:38:20 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-49-186.web.vodafone.de.
 [109.42.49.186]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2c695basm50451381cf.4.2024.12.18.05.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:38:19 -0800 (PST)
Message-ID: <61cadf31-8656-4216-a345-e364bb85e45b@redhat.com>
Date: Wed, 18 Dec 2024 14:38:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Convert the kvm_xen_guest avocado test
From: Thomas Huth <thuth@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>
References: <20241218113255.232356-1-thuth@redhat.com>
 <9B5DDDDB-769B-4654-BEF1-D3F853EA05E5@infradead.org>
 <31e85f4d-66f2-4790-8597-f43e291bcbea@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <31e85f4d-66f2-4790-8597-f43e291bcbea@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On 18/12/2024 13.40, Thomas Huth wrote:
> On 18/12/2024 12.48, David Woodhouse wrote:
>> On 18 December 2024 12:32:49 CET, Thomas Huth <thuth@redhat.com> wrote:
>>> Use the serial console to execute the commands in the guest instead
>>> of using ssh since we don't have ssh support in the functional
>>> framework yet.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>
>> Hm, but serial is lossy and experience shows that it leads to flaky tests 
>> if the guest (or host) misses bytes. While SSH would just go slower.
> 
> The issue with the serial console should be fixed since:
> 
>   https://gitlab.com/qemu-project/qemu/-/commit/cdad03b74f759857d784e074755
> 
> We didn't see any more issues with all the other tests since that has been 
> merged.

But FWIW, there seems to be another issue with this test. While running it 
multiple times, I sometimes see test_kvm_xen_guest_novector_noapic hanging. 
According to the console output, the guest waits in vain for a device:

2024-12-18 14:32:58,606: Initializing XFRM netlink socket
2024-12-18 14:32:58,607: NET: Registered PF_INET6 protocol family
2024-12-18 14:32:58,609: Segment Routing with IPv6
2024-12-18 14:32:58,609: In-situ OAM (IOAM) with IPv6
2024-12-18 14:32:58,610: NET: Registered PF_PACKET protocol family
2024-12-18 14:32:58,610: 8021q: 802.1Q VLAN Support v1.8
2024-12-18 14:32:58,611: 9pnet: Installing 9P2000 support
2024-12-18 14:32:58,613: NET: Registered PF_VSOCK protocol family
2024-12-18 14:32:58,614: IPI shorthand broadcast: enabled
2024-12-18 14:32:58,619: sched_clock: Marking stable (551147059, 
-6778955)->(590359530, -45991426)
2024-12-18 14:32:59,507: tsc: Refined TSC clocksource calibration: 2495.952 MHz
2024-12-18 14:32:59,508: clocksource: tsc: mask: 0xffffffffffffffff 
max_cycles: 0x23fa49fc138, max_idle_ns: 440795295059 ns
2024-12-18 14:32:59,509: clocksource: Switched to clocksource tsc
2024-12-18 14:33:28,667: xenbus_probe_frontend: Waiting for devices to 
initialise: 25s...20s...15s...10s...5s...0s...

Have you seen this problem before?

  Thomas


