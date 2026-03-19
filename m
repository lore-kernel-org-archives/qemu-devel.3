Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1E61075275
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38ll-0006du-Mn; Thu, 19 Mar 2026 04:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w38li-0006aT-4q
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w38lf-0000Kk-Jz
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773909010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROz1EIPTG3foMg7BwtsMwRyIo6psphGItQIQ0124oM8=;
 b=Uh2A+v0XI0RsmFV9D0/VpRhPGNeh2JTv3ocDANXLVOaekEvwuzfKO+dDjZqtzxBOR3qtQD
 cIV/fdYdPe6H3wPjZ/AtsuCTSIoW4LaQFNfejit6kVn6vYeomKPRoN6MKsdw5FTEJFqyX+
 6gqiUhQB1Sjde+MAGNNCagbULNbxvFM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-wSErEmzsPp2IRRdDsAjVtw-1; Thu, 19 Mar 2026 04:30:08 -0400
X-MC-Unique: wSErEmzsPp2IRRdDsAjVtw-1
X-Mimecast-MFC-AGG-ID: wSErEmzsPp2IRRdDsAjVtw_1773909007
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b4730dad8so638146f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773909007; x=1774513807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ROz1EIPTG3foMg7BwtsMwRyIo6psphGItQIQ0124oM8=;
 b=ss+crYslwfazuE2ASisbwmVL/EdPjezlGF+jsKqYj9maqORXgCBzJ+GPiPU+Ha7TcX
 3vt+6U+06fwYn0QgwXsS1eYh1oGWk7BZE6NGwY8l8Zx+e5duksp5Wrvum/KLM+ulmkST
 bDS5fXRn+TXPZSqKmwLySFyvRxfWAI8u9HtCi22V7SMXJgKE7XcidlUCW2ancAq92pkJ
 zqzHarmWJwcIFxQ4DYiRvzpUcQivcvz4V5N7I91IpX0Bp8bDR13bk064EoWnjIF9yK0b
 x710GBaYp0N84ML2eaYnK0P0rNDdGxJTD/0j1aXJscl+NONZ4gsG/KEGQcbBSWxTU8d9
 ldbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773909007; x=1774513807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ROz1EIPTG3foMg7BwtsMwRyIo6psphGItQIQ0124oM8=;
 b=gJ3dHogPx/A+9Pyu/9hFCi7UD5Qsqek1VRhHB9Go0cdO4k9DInue6J4SoAhpiDWPvx
 2juQK286RuLTcjuw1mt19DSWBgJ0vRoEN55+QT9u873gYmA0Rfoy/h9TfczxZ5xbDiuu
 D4+RppXupXuSHY36w/4p1833RKP6MAI6QvrBvW58ViwOua4H22VENSnrxaXbJA4buBj9
 H4jWU0FZYXseKWm60BwKlHu1Ub9RaFPOiAUS4ax2yhp17Dyy85aEzKGqyGB9aW1g+Z99
 bdR4RjG7mJ3zBcEILfJsEK7ybrdEPvCdMcZvou8iKrPV4GIJgll5tAueQP9mof3GlBmd
 CVPQ==
X-Gm-Message-State: AOJu0YzW7eWBWIv/3K/21YC8Ge8/F0VH/6g8R4Ef349BndPVjjrqa8ax
 K2HR6x/Oj2JKqTaDkXHy843lbEOluav31K9DSMLdoCYoUYv5nDXNDVSJOVLHZlsLxU3EU1WRouW
 3tsZJYlxU3i+3tiBI9x07DPVb2l4kvFU++lE5fnTnlOy4YR0qmw8Cp3Cp
X-Gm-Gg: ATEYQzz6ULvoV98xnsBmCL/uUvInCiPxexb5yVoUE5PxW+w+OH45+Nqiwg9rfB2RY+u
 xvb3LNduaBaJBGnFFWfwJ+n1xgeccwj3A9K/M4qdYlznZOOCi9YD7PIAIjv1tcgHku+HLcNDhq1
 nj8AS9F11gzxFMUoBKDmvxeaIpHJaFOMLs+wKg/3O0Yf1ESdEdLG+ppYBFJZkVcAxEf5LgeDm72
 2Yb//nMypWIcc9wFnfJOs8AnEUgspdh97yk6NKBEdoWexbWeMr/vek3E9tW7Bw5VPgF4bfYIN/i
 wlK6AWL7Gzo4AVM+KbGrwVMYkqPaVgB9SO6YfpoS7nK1ep/A6JDKNJwngA7qiY/tNyKli/ISUL7
 kR2yH+/d3jBqgqAWaYB7x98nDtHpJMSNAxozCO9DykmnMNs91jOCs5qlMGJAbdCBN/396tvkF69
 D6M/E5Nb5riCsz69mVXJzwIU+MZUYX9Fb+OPkyUfI9ow4aW0E+
X-Received: by 2002:a05:6000:609:b0:43b:498f:dcf0 with SMTP id
 ffacd0b85a97d-43b527a3b93mr11321420f8f.9.1773909007223; 
 Thu, 19 Mar 2026 01:30:07 -0700 (PDT)
X-Received: by 2002:a05:6000:609:b0:43b:498f:dcf0 with SMTP id
 ffacd0b85a97d-43b527a3b93mr11321330f8f.9.1773909006549; 
 Thu, 19 Mar 2026 01:30:06 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d033:4b9:bf78:3d26:f60b?
 (p200300cfd737d03304b9bf783d26f60b.dip0.t-ipconnect.de.
 [2003:cf:d737:d033:4b9:bf78:3d26:f60b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b5189221dsm14400011f8f.23.2026.03.19.01.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 01:30:05 -0700 (PDT)
Message-ID: <a9e0575b-428e-42a6-b8bf-9d37b59d64e0@redhat.com>
Date: Thu, 19 Mar 2026 09:30:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Block layer patches
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260317134521.112121-1-hreitz@redhat.com>
 <7e3a45c4-a7bf-4679-8799-7f482fd9334c@tls.msk.ru>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <7e3a45c4-a7bf-4679-8799-7f482fd9334c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 18.03.26 21:35, Michael Tokarev wrote:
> On 17.03.2026 16:45, Hanna Czenczek wrote:
> []
>> Block layer patches for rc0
>>
>> - Fix race condition in throttle-group code triggering an assertion
>>    failure
>> - Fix assertion failure in mirror job when issuing job-complete twice
>>
>> ----------------------------------------------------------------
>> Alberto Garcia (1):
>>    throttle-group: Fix race condition in throttle_group_restart_queue()
>>
>> Fiona Ebner (1):
>>    block/mirror: fix assertion failure upon duplicate complete for job
>>      using 'replaces'
>>
>>   block/mirror.c          | 28 ++++++++-------
>>   block/throttle-groups.c | 79 +++++++++++++++++++++++++++++++----------
>>   2 files changed, 75 insertions(+), 32 deletions(-)
>
> Is it not qemu-stable material?
> The amount of changes is a bit too high though.

The mirror one should be simple enough, the throttle-groups one… I think 
it still is good.

> I'm picking it up for the currently active stable branches, please
> let me know if I shouldn't.

Yes, thanks!

Hanna


