Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBA0F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ibe-0004qG-A8; Mon, 23 Mar 2026 12:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4ibY-0004fW-Dn
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4ibX-0001Gh-3x
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774285094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUWGViB32r2kspts1qLuvK+wo8kfLDK/qAArChUb4Xg=;
 b=MW9+ERFpReUTuNWfRaAC34zp8R/q7ckNp88HaQltuT1VnBD5A3Crc0UAYxNYwxvieXp9i2
 frVaAnxG6EWU0ZQClkgl34m1WCfKgL9kjfTnXSWrzIKG0YLhzZ7D7K98jbTFHFQD+JUjrG
 LCFNWxx2JVS0kCVuOFcV9d5qyjVkhMU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-UPdlSRv6P_m0-Uo75XKH1w-1; Mon, 23 Mar 2026 12:58:12 -0400
X-MC-Unique: UPdlSRv6P_m0-Uo75XKH1w-1
X-Mimecast-MFC-AGG-ID: UPdlSRv6P_m0-Uo75XKH1w_1774285091
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439ae2cba40so345915f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774285091; x=1774889891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HUWGViB32r2kspts1qLuvK+wo8kfLDK/qAArChUb4Xg=;
 b=cj4TN8YfbzqJ5SIUIzUp5gfE4gVkNgYwrosY/PgmgV6YKp5YqnlpgagVHJehMpiJ3V
 j4KKGpDr6VzcPq+Hddy+qAgd/YcAtWpge8JCjGyqai2DoABNClVdFaByDkbH0MftKSjU
 WoFFT0mXOPePCwBX548TZ4qdkKEr8wQCIIKQpMEnIHOYjBcFWVy3thgaJDGVXNo9urw3
 2a/bsTY6lEwY34NEFcTlMyuUqmtlNiRcJPmw0M6vvU+SSObGzcPW6UY2/Pl15FVX/MQ0
 4f9GsWlxpA1qkU8beYjEvPXFxwoXuYlRIgnWuYxOmaZ6Vl2waqhtatBjLQgfkDVu29zB
 jh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774285091; x=1774889891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HUWGViB32r2kspts1qLuvK+wo8kfLDK/qAArChUb4Xg=;
 b=T5s2sdLsuyOzGTBkHFpzqvc9Jmetg4SZQgNIdI3VyxBW84xyRvPqd7GgGyaNr3wgSj
 GSVAFlsy8Nr1y1PbQzPel20LOOWHtbx7A69N8W2eqbxqxTlD2HBH1EGSjvpP3fb9nTKv
 yHdnw/7y9rCkFKOIaLEMcCaYr/soe3LbJAUuPvMf/DHPuFE62J/YgMBRjsCUUz5YNXt5
 9/miDcQPjakfZMjTn47kffzSs71APxi2mb66y9IhyyFa7LgrPsc1AlsovG16Ova4cuba
 IzW2epGOFHFqOQimVldWQAl5f5BQezHApwlWTvyDoAd0OEZkBbXVGFV4ww53Iu1dZAKQ
 i3Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcKCh22MMNd08h5cDhQyni1L8G9AhPhE8//ZB54oXUWhEbWvSUmoTW+xLSqwX51wVkma+XlSlUkPM3@nongnu.org
X-Gm-Message-State: AOJu0YxpxAS6oC2klN2UAemm4DfOW6kt46KVhDQAW5orW8nnsSlyDXE6
 8wSXD5R77BXG1mlpun6xegWLsfPZdWewehV4DL7lJ0xhueBqYWywro9O4aoUgtcaFsUp5wQ7My5
 BiHTuJqJOXkDgdyj64S1kzijdMqrXiFy/q7z/KbfMsML4Odg+fZcPkU8m
X-Gm-Gg: ATEYQzx/wxT3vHrdc0WXyi/ExZkvWRdVH+TPr8LBVPtCLep+8aZbruhZNfJEb2a2T++
 3BdNRtMU70m+PAADtKRhU7zeYSYUCVhAgoeBVTYQ3VRRUVY/RW2ybIFD1wI10gMXu0pKSbAtGNX
 2w2BLcj6smiwcTNg8b5mmEosiAFQM3yL7oxh5xsz5X70c+/oSFy7/9XfM93juijKltVXQMy7jWI
 vjbwrmdiKwar0sMMOUlmI5PG1RAK76p085LQoUh7bTI7Xso0aXbGB0WGPulNi5uq9/GZ3hFhGr+
 +4m1vr0blOK63e8perjmfpwXfxoPuTYmOPvrXEsR116PZTU1N7TYft2iWE4xmeWQiVMWJauTkr9
 Y260LZTDNRxta/jCjKJegs1U7hD1mKVP1iOYasac4eY/OCJAFFetRZDeoUfZaT4kykE9o06v3Rq
 DRptiQHt752x1PoyKIq1WKRAtO1q9D6YXZChzV/LCFrcoieeZ8J3Y=
X-Received: by 2002:a05:600c:474f:b0:485:3b34:2f62 with SMTP id
 5b1f17b1804b1-486feddb659mr184874195e9.14.1774285091164; 
 Mon, 23 Mar 2026 09:58:11 -0700 (PDT)
X-Received: by 2002:a05:600c:474f:b0:485:3b34:2f62 with SMTP id
 5b1f17b1804b1-486feddb659mr184873875e9.14.1774285090707; 
 Mon, 23 Mar 2026 09:58:10 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d03c:df99:cbc9:b444:8cfa?
 (p200300cfd737d03cdf99cbc9b4448cfa.dip0.t-ipconnect.de.
 [2003:cf:d737:d03c:df99:cbc9:b444:8cfa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe82a030sm315526325e9.10.2026.03.23.09.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 09:58:10 -0700 (PDT)
Message-ID: <aa395c95-5f84-41e9-901c-a1226451bec6@redhat.com>
Date: Mon, 23 Mar 2026 17:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iotests/041: add test for duplicate job-complete
 with throttled target
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
References: <20260318165446.709541-1-f.ebner@proxmox.com>
 <20260318165446.709541-3-f.ebner@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260318165446.709541-3-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 18.03.26 17:54, Fiona Ebner wrote:
> This would fail without commit 9ac85f4cc7 ("block/mirror: fix
> assertion failure upon duplicate complete for job using 'replaces'").
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   tests/qemu-iotests/041     | 31 +++++++++++++++++++++++++++++++
>   tests/qemu-iotests/041.out |  4 ++--
>   2 files changed, 33 insertions(+), 2 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


