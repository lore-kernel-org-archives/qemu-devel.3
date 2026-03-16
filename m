Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E473F53D6E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Aw9-0002fE-Ad; Mon, 16 Mar 2026 12:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2Aw0-0002eM-1i
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2Avq-0001Fr-5g
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773679000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EqOimejTM9mvEizXqbCOw+9aAkMsBtv0nDU+WYZYDto=;
 b=cpLzSa7MeZk+Km5umJTReSmdWN62WmgW8s4ZEVOJ0qjEUZUXg7f7s6gdWO63NzaO7Pi7YD
 WDYiXgIKynLa6xufApyXJ1RjeYuwDsHKUuUtPAMxmXORCNFMuWPjjbmrEK+86zjS+PIvh2
 rzrMrrZ0UCofndnrDtUz/v44v1NuQI4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-tbFmlm1ROcmuhzU0TLZ2Ew-1; Mon, 16 Mar 2026 12:36:38 -0400
X-MC-Unique: tbFmlm1ROcmuhzU0TLZ2Ew-1
X-Mimecast-MFC-AGG-ID: tbFmlm1ROcmuhzU0TLZ2Ew_1773678997
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439a85832c0so4164998f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773678997; x=1774283797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EqOimejTM9mvEizXqbCOw+9aAkMsBtv0nDU+WYZYDto=;
 b=eFqaOSz9es7th3NLyw3Y+qmqod5D8G74XtO9Zzl44UYcV/c/WxAM5zlu4K8OhInaph
 sjXPhol4AjtA5OIrpuUVzTrvtlm2CgCfwLuKi5yYJVxP7xb28rWniV1sMjZFbi5QXhuw
 azMbu3ZOcnoHYZ8RRu61ER/SQN1bAVwZCcogVOKrUZ/MpyhRn3R4pWTiH9iHQkVDXqS1
 gJNmODKhNK+Saz6jqbj9YGEM10ICOP6FAUYwsNsSKKyau/Bbrpsz+r9Wl9mUL8ohCAF2
 qwaIgiHcXsQUJ1q8jDG1AvdQFLVc3GK24t6hY8sA2N1tNH8whtMKzt8dNNzjukkd2Wtm
 XGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773678997; x=1774283797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EqOimejTM9mvEizXqbCOw+9aAkMsBtv0nDU+WYZYDto=;
 b=hMG5ZY7d+fNVlzqgP3ise3aJoPa3i7xD8y7e2m2DjenbntlRrZOXW1DAECeB6m5L/R
 2uzUaDaS6jxC0BTpnUS4EcBtODyBKf016qjOsmenDB603L4PNMq1m15sC/7I74KlPFSo
 AD7kRYXkHmPT87S/9VRn5ij8Vg6ntHKGKdaE6r+yXk/QAa7Yyh3u3lPhSI4mnW/lgoqR
 X8/1zM2X9+HndMuXqb/OsxgjHzv0CAIOD746uAq8uPv98stUGsC0/EiBzA5qQC/jLGgN
 w4CfsgvzAcg7B6BO9ybkPMGZ+QehP3Zkhvf/skhi6WiPqx1mB+96MvkrkyBtFECmb5v4
 vX9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnE0HJGUJvzW+arebfsbutuJNApnTt081z7slK7ZlDyD9grsY0mMG68ESiTt8jMj7NWPHw/mkMzEXM@nongnu.org
X-Gm-Message-State: AOJu0YwWK9nwhfGaUEyXlMmF161GyDnhPi8getYtussdxoyKXgMWH2Ql
 XGra6CUJYH/iprmWUB1Czq56Ef+9cj1wovUDjbzfTV7xbD+W+xtqHgKM9XM9LCvEv2eWlBHosii
 qcZQweM2ITX9+KUIN7zNFdTZsIAdlIk5XA9WoimDxBBBq4M2Ov/dOTs28
X-Gm-Gg: ATEYQzzvDxC2TR4ql/QiwhFCFkJckNSr7yM/pw9jTVejbsXvLZLrTHF0D6uKT3u246p
 8OTVO06u92VB7Pcj0EQzF/1B/dmtQtbFM4v1FN2mwe4rrCWsfcII8H80T3yq9H7yiwNKYMsWFsU
 zZhdopAbPvXYGfeub/p/Enx97cu6LD0eqZiMg6IC0fO5SF+DvOnn5QFA9JKU4yA2QmsStu55SRT
 Un83tMwKZcfJOVtNUWA66NUSIx1JQAtC42uaNBhsSMm7u/IT1nj1tVnMPX79jXIpRdElYp25Oe+
 PMrBuEPpvl8iMkhgxBg7wjI2UBdIKVLPDA9btAhRTYsC2Cax0VbX+PNmScamHq6DefCjsGq1Obb
 rgTyex8jji7seyHCkVYm68wseu5JZMCod2c76OteFFghf51frMMT+tMcVMLy2bC2goOf8HlEois
 +JjOv6j7KwmAXYO7V9Xmgng5La/W8tPfqDle9xzcOINtp24Zxx/Rw=
X-Received: by 2002:a05:6000:288c:b0:439:ac8f:5db1 with SMTP id
 ffacd0b85a97d-43a04d79bdbmr25500987f8f.15.1773678997117; 
 Mon, 16 Mar 2026 09:36:37 -0700 (PDT)
X-Received: by 2002:a05:6000:288c:b0:439:ac8f:5db1 with SMTP id
 ffacd0b85a97d-43a04d79bdbmr25500914f8f.15.1773678996573; 
 Mon, 16 Mar 2026 09:36:36 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d02c:3210:ed4b:e671:ceb9?
 (p200300cfd737d02c3210ed4be671ceb9.dip0.t-ipconnect.de.
 [2003:cf:d737:d02c:3210:ed4b:e671:ceb9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe226473sm43387206f8f.32.2026.03.16.09.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 09:36:35 -0700 (PDT)
Message-ID: <27535351-955f-4aed-b335-2b2832c4b89f@redhat.com>
Date: Mon, 16 Mar 2026 17:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] Fix race condition in
 throttle_group_restart_queue()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Jorge Merlino <jorge.merlino@canonical.com>, Kevin Wolf
 <kwolf@redhat.com>, qemu-block@nongnu.org
References: <cover.1773316842.git.berto@igalia.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <cover.1773316842.git.berto@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12.03.26 13:11, Alberto Garcia wrote:
> Hi,
>
> In the previous patch I forgot to relax the assertion for case 2.
>
> If we're restarting the queue when another tgm has a timer armed I
> don't think we can guarantee that when the timer fires it won't set a
> new timer on our own tgm before we reach the assertion.
>
> I think that the assertion should depend on reset_timer_armed:
>
> - If it's true, no one else can arm a timer so the assertion holds.
> - If it's false, it is possible for the other tgm to arm our timer.
>    The assertion would fail in this case, but I think it's harmless
>    because even if it would fire at the same time the logic in
>    throttle_group_restart_queue_entry() is protected by the lock.
>
> Berto
>
> Alberto Garcia (1):
>    throttle-group: Fix race condition in throttle_group_restart_queue()
>
>   block/throttle-groups.c | 79 +++++++++++++++++++++++++++++++----------
>   1 file changed, 60 insertions(+), 19 deletions(-)

Thanks, applied to my block branch:

https://gitlab.com/hreitz/qemu/-/commits/block

Hanna


