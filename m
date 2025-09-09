Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F88CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 20:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw5Ja-0002dG-I7; Tue, 09 Sep 2025 16:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uw5JZ-0002cx-2w; Tue, 09 Sep 2025 16:51:45 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uw5JT-00018J-7E; Tue, 09 Sep 2025 16:51:44 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7e872c3a0d5so547635285a.2; 
 Tue, 09 Sep 2025 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757451093; x=1758055893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oW/aqGiOxSWzbT6yvUg2e2n/lmOvVrlQIDdcfxaXiOg=;
 b=Qb0fs+LY7AYVLt8XXlq+sbKj++2ITmCd/nHpCjrwsrtGwjWS2Ni7r3TOBdxdox2OKx
 AYdFg36fOlyPaQ6zFNjFVPS7uZJKPdFei2RXfFDxtS0idT94guQsPV65xw/yqEcCRj/b
 hCkaLVTD5IE1fx93H5wYB0S658Y4JhuQLd29GvURdW0jq99QsI4TwagqMGb3ve3kaVdj
 rD9Kpnf6CxarxWF0KGRQuVsa1u16mtN2C+AZExKDEofQY5xes6yIko6/okUfW1eJmNa+
 szTiwvoLQaou3eI7NoBznbBBZx7fhjE7hlragGpgf88zOwhvuAXnAYrFe3XObJaHXkKu
 iuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757451093; x=1758055893;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oW/aqGiOxSWzbT6yvUg2e2n/lmOvVrlQIDdcfxaXiOg=;
 b=uQjW1Kn3Wjpe6d4SEqJNd0fU5A1T49ysst14W6Fjyifq9NxXScXn+O1w5uWXMXL+MA
 nzbCPVfTUiJKN2P9lIBGWT1JYrG+HbLPzwcCbgOPBGWHRfBHGwl1GyLi7tU14raP79NC
 AU/XpyfkQvlm3YTfkkvxYDnUHHEogAbXK+0b4/yG31ufzQhVJRdDhPq+YkWseKgo8E0o
 OmH5PjFC0zpZionyomdm2jdYA1AECntPfNN7A3OXYeSmYti725VX6Debq4sWvJ0gtF/k
 KNVYtqdhqbzWJNkmUj/4qoMQAMb2yklv9fX2rxpuQcIt5CBYTarvpeasSoCcctyCGNQi
 BDBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwX4qWJBpl9qfAtQ19IMAfyEzwVLXXgNBM5rKbptH7iZNaQXFh800YOQqljmUPoOrEvxrvNPrwPZqk@nongnu.org
X-Gm-Message-State: AOJu0YwYERjHZ0RjDh+ixYaCgzQlUVK72Lu2KJsp3UnppUGVNt8lK7Wm
 JcAwG+Uktr7AudFh0vter8ZUfsox3S6UChEUu0Sitpr5GfpE6p94BN6l
X-Gm-Gg: ASbGncvYhLRy8hm1Wa5JBjX0zsIoE5FWGsTUgHsy+vXkyk9n1Ot21rR3m4SZefNmGlk
 5GE65eW0ZReZFzomP8OZGNt622CDdFeQgciXQ6rvRkJxZADnquhwAuNwy+fXpaqoXaNq55M5tu9
 +3VWrB91WKjdku0Gu9HOYL30qy3ryTvpv+JhfRadNZ3YWs16cezy18C+yfH+gyYhy7uW3lVImGh
 Z6nGJKY6QsRPi+h3S/XcB09dVH7/qrGRWCXD/CZbrOQdan83sYhcsak+aB2F0WQn9js4T3iCSvi
 c77cX5gP3+X0JAkK49OQzJINhL2m5cmZXrUuuCiIKG6qCzg7lw0DGh9Z8c+knfL5Qig0da1J9Tw
 nf3mQNilPrY9jHH4jQnLNan4xzLDgsrW8jDtQrtny5W7GEzIcuMkBmzVKIdfw0gBDAhkqJEFGBA
 CgZNyzE9erYl+c3ibps2n08g==
X-Google-Smtp-Source: AGHT+IHAiKT9phw4jIkLqM43rYDZM5AUiFHF2bRklixahWZVliqhAxrGs7Q9NfaCeyzHaAhDiMqHuQ==
X-Received: by 2002:a05:620a:1a91:b0:7e8:9f7:da5d with SMTP id
 af79cd13be357-813be24afd9mr1310225485a.12.1757451093058; 
 Tue, 09 Sep 2025 13:51:33 -0700 (PDT)
Received: from [10.36.130.207]
 (wn-campus-nat-129-97-124-207.dynamic.uwaterloo.ca. [129.97.124.207])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-73cdb176b21sm73803386d6.72.2025.09.09.13.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 13:51:32 -0700 (PDT)
Message-ID: <128a530b-b375-4019-bfef-9482cc63af37@gmail.com>
Date: Tue, 9 Sep 2025 16:51:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH 3/4] export/fuse: Safe termination for FUSE-uring
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-4-hibriansong@gmail.com>
 <20250909193358.GE218449@fedora>
Content-Language: en-US
In-Reply-To: <20250909193358.GE218449@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/9/25 3:33 PM, Stefan Hajnoczi wrote:
> On Fri, Aug 29, 2025 at 10:50:24PM -0400, Brian Song wrote:
>> @@ -901,24 +941,15 @@ static void fuse_export_shutdown(BlockExport *blk_exp)
>>            */
>>           g_hash_table_remove(exports, exp->mountpoint);
>>       }
>> -}
>> -
>> -static void fuse_export_delete(BlockExport *blk_exp)
>> -{
>> -    FuseExport *exp = container_of(blk_exp, FuseExport, common);
>>   
>> -    for (int i = 0; i < exp->num_queues; i++) {
>> +    for (size_t i = 0; i < exp->num_queues; i++) {
>>           FuseQueue *q = &exp->queues[i];
>>   
>>           /* Queue 0's FD belongs to the FUSE session */
>>           if (i > 0 && q->fuse_fd >= 0) {
>>               close(q->fuse_fd);
> 
> This changes the behavior of the non-io_uring code. Now all fuse fds and
> fuse_session are closed while requests are potentially still being
> processed.
> 
> There is a race condition: if an IOThread is processing a request here
> then it may invoke a system call on q->fuse_fd just after it has been
> closed but not set to -1. If another thread has also opened a new file
> then the fd could be reused, resulting in an accidental write(2) to the
> new file. I'm not sure whether there is a way to trigger this in
> practice, but it looks like a problem waiting to happen.
> 
> Simply setting q->fuse_fd to -1 here doesn't fix the race. It would be
> necessary to stop processing fuse_fd in the thread before closing it
> here or to schedule a BH in each thread so that fuse_fd can be closed
> in the thread that uses the fd.

I get what you mean. This newly introduced cleanup code was originally 
in the deletion section, after the reconf counter decreased to 0, and it 
was meant to cancel the pending SQEs. But now we've moved it to the 
shutdown section, which may introduce a potential problem. How do you 
think we should fix it? This is the last week of GSoC, I'm already busy 
on weekdays since the new term has started.


