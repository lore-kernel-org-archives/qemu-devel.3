Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5FFC3601E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0gU6-0004v4-MV; Fri, 04 Apr 2025 08:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0gU3-0004uO-Hk
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0gTy-0001j4-Mv
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743770953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+L807oY1LoYwis4mVa576wX+wUmhV2gszFfi6UhrxQ=;
 b=YoHRb2qtsVMTql55AWxUrHr79ZLxMxe673UsRrE8M+jWgInUq6JFBlCfS2FfTsnZEeoido
 owZzLXdqPVTwkINFsCXvjE2vrwfLYDVMQKgceWmeVNIlipUsl22w21/GxybUkdsjvwb2dz
 uqn3DOQqDZHBqDzM93LKXg1o+xYwTKo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-E-bQmSocPXmUiPIjnu4pbg-1; Fri, 04 Apr 2025 08:49:11 -0400
X-MC-Unique: E-bQmSocPXmUiPIjnu4pbg-1
X-Mimecast-MFC-AGG-ID: E-bQmSocPXmUiPIjnu4pbg_1743770950
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cec217977so13116515e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 05:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743770950; x=1744375750;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w+L807oY1LoYwis4mVa576wX+wUmhV2gszFfi6UhrxQ=;
 b=jHNU+FLVC42wts27/D96FqOyt+hJ4aHLUvp1Z5sLjZQyHJ4MZsHMlf1BeE1VaF/X9M
 8Eqd/C8/HsgnS/WOX4ALD9t0N++t9n0tshgsnUm3TSYdaCNeF2kU/0vvg9DjFv1SoKex
 ewcnMv/4u3IYo73b32pNwKhkHw7WkZPv5BUmwkL0BlfSUFVcZ3uMgXT1VceQ85jejq92
 yrM419aP7ulPjqbPktmrEkthMQbxAE69+e3ypHDDxzcAM6fw4HvYgzWLdszKK20Y+4RL
 RXUUNhEA7oCcniPHCy6Q3EOwtmwprUwbZNC9qQs7VkGQ03agi6qnOGzA0RCJntby3Uj0
 tuUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQIexNALMTQgWB7F1NzH8CnuRipqA3w7/nVp5CfzjhSMLVwabH748xndRKgo0rOqEsWpmGB9Olpa/o@nongnu.org
X-Gm-Message-State: AOJu0YymI0LG5b/PW/2mbLg3y9WO8+C5Vw9mHnDxpNhnjUO1sTm3UH2Q
 cExXDOR9wHTypPxWYP0rjQxKRhaQCdatTE7OfvWtfaJKB1GZkskW5LfoJyYcFI19YIGS4J+uw9+
 cBM3Bn1oeqgujT2v4ns5CAaGdr1h0ft/yp5YgZ5lDCYVMTd7GuGPi
X-Gm-Gg: ASbGncvyuKHiHgRbaJBMA/hyUMauw11E2qpb+s5E6ieYj1w72CFxT7/ExAU2UtC7CuL
 hwVJF5wh3kl4V/VW8Viqlf0DnotntxDJ2yD8bcEIIxMG016re6glsTPR9rdFJGIyHbjFoa73Tzj
 L38H2hzKBS37nfDsahg8dAY5w2lp8fwApqO3m6ONw5ik2vAqq4hnE6LAovwkGhhV3noaaGN8X/a
 wu1A9vSGJfPYwGuEWk0yqIoYrgKCZBxbnUgpJuyuF+hGmhhAKS9N4u9RCDqmJ2qiYp66dIef304
 g04ptPaUipp1iX0MB76MbygprAfPVYP7hmnZmSWr6hQUoQH4bfF7k176h3t3vTj5hsLB/6stcT4
 EFmvnw2f7ZFMhV4TjOZIx4pNKUIU430XCEI2EtKD0VDZW
X-Received: by 2002:a05:600c:c1a:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-43ecfa06fd2mr36194475e9.30.1743770950516; 
 Fri, 04 Apr 2025 05:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFprqGacxIa+2rsFn6Gq4fNsof5ZMg8wZIe9z8h2PQ4v013RnlS9TKBj3qzTrwHCS+ABrO4/w==
X-Received: by 2002:a05:600c:c1a:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-43ecfa06fd2mr36194125e9.30.1743770950030; 
 Fri, 04 Apr 2025 05:49:10 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d66:d61a:f3cf:3494:9981?
 (p200300cfd74f9d66d61af3cf34949981.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d66:d61a:f3cf:3494:9981])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a9bcfsm4367008f8f.33.2025.04.04.05.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 05:49:09 -0700 (PDT)
Message-ID: <c3f70137-afd2-448b-8aa9-de14bef25224@redhat.com>
Date: Fri, 4 Apr 2025 14:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
To: Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com> <20250327155557.GN37458@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250327155557.GN37458@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27.03.25 16:55, Stefan Hajnoczi wrote:
> On Tue, Mar 25, 2025 at 05:06:54PM +0100, Hanna Czenczek wrote:
>> FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
>> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
>>
>> We can use this to implement multi-threading.
>>
>> Note that the interface presented here differs from the multi-queue
>> interface of virtio-blk: The latter maps virtqueues to iothreads, which
>> allows processing multiple virtqueues in a single iothread.  The
>> equivalent (processing multiple FDs in a single iothread) would not make
>> sense for FUSE because those FDs are used in a round-robin fashion by
>> the FUSE kernel driver.  Putting two of them into a single iothread will
>> just create a bottleneck.
> This text might be outdated. virtio-blk's new iothread-vq-mapping
> parameter provides the "array of iothreads" mentioned below and a way to
> assign virtqueues to those IOThreads.

Ah, yes.  The difference is still that with FUSE, there is no such 
assignment, because it wouldn’t make sense.  But I can change s/maps 
virtqueues/allows mapping virtqueues/, and s/differs from/is only a 
subset of/, if that’s alright.

>> Therefore, all we need is an array of iothreads, and we will create one
>> "queue" (FD) per thread.
>>
>> These are the benchmark results when using four threads (compared to a
>> single thread); note that fio still only uses a single job, but
>> performance can still be improved because of said round-robin usage for
>> the queues.  (Not in the sync case, though, in which case I guess it
>> just adds overhead.)
> Interesting. FUSE-over-io_uring seems to be different from
> FUSE_DEV_IOC_CLONE here. It doesn't do round-robin. It uses CPU affinity
> instead, handing requests to the io_uring context associated with the
> current CPU when possible.

Do you think that should have implications for the QAPI interface?

[...]

>>   qapi/block-export.json |   8 +-
>>   block/export/fuse.c    | 214 +++++++++++++++++++++++++++++++++--------
>>   2 files changed, 179 insertions(+), 43 deletions(-)
>>
>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>> index c783e01a53..0bdd5992eb 100644
>> --- a/qapi/block-export.json
>> +++ b/qapi/block-export.json
>> @@ -179,12 +179,18 @@
>>   #     mount the export with allow_other, and if that fails, try again
>>   #     without.  (since 6.1; default: auto)
>>   #
>> +# @iothreads: Enables multi-threading: Handle requests in each of the
>> +#     given iothreads (instead of the block device's iothread, or the
>> +#     export's "main" iothread).  For this, the FUSE FD is duplicated so
>> +#     there is one FD per iothread.  (since 10.1)
> This option isn't FUSE-specific but FUSE is the first export type to
> support it. Please add it to BlockExportOptions instead and refuse
> export creation when the export type only supports 1 IOThread.

Makes sense.  I’ll try to go with what Kevin suggested, i.e. have 
@iothread be an alternate type.

Hanna

>
> Eric: Are you interested in implementing support for multiple IOThreads
> in the NBD export? I remember some time ago we talked about NBD
> multi-conn support, although maybe that was for the client rather than
> the server.


