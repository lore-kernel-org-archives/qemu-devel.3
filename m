Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F43FEC0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57Eh-0003Pm-82; Tue, 24 Mar 2026 15:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>)
 id 1w57E9-0003Dk-JB; Tue, 24 Mar 2026 15:15:51 -0400
Received: from butterfly.birch.relay.mailchannels.net ([23.83.209.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>)
 id 1w57E6-0002JO-S4; Tue, 24 Mar 2026 15:15:44 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 73351162CED;
 Tue, 24 Mar 2026 19:15:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com
 (trex-green-4.trex.outbound.svc.cluster.local [100.121.5.127])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 0564D162ECD;
 Tue, 24 Mar 2026 19:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1774379738;
 b=xEXlkzdS5dyywTJPZMy6Kfj3+WBqFzyRxzakdzcw0Z9+c/7sn6mTPPx5x9grxV1tIDqCtL
 D7A1ZW0SsjIFicv8Ty2WCb5NMBj50Q6nGVCkedXM1TDLkNkUPL9yGNiWMyoUPONIcFwiiW
 wkQ+VQrSskrKgDCwEFfZJ+5BgXMUsEj8QbKxuJIN3do6PbKpELjTyLMgVUfEBY2jIFHD8B
 pgKjswn+8aXpAlgDWxKRikWPwslSZhWmwefEefKfzpWUHxrU97f/jPLIRCEq0bNfqRzK0X
 FcbJILuEITNM/ad07wh7vDZBXg232lNZ9DoLxojVFa5naqsPkndiPWAHL6shGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1774379738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=BbTqBTO2UNWPJmUNpZ6hRnWiEKplaybPDOvBvM88LqY=;
 b=M+8Oy4Ht1OV1wIyxCrapg5V5zHwyBzPYR/wBp11FXAHMVcolC3H6J1Yl/kQtL7i5Q32Ns/
 UaMLsYW+Os6ma+NVLHlBSXRey6GHneoaAiXZL83OqNOWudL9yreLEK7yo3tWSSJMFe2Hgc
 wiYvRTdwthnMaw4ECjJGYeT9XPYIBMzKsx+Fqtwo+8KIwuc/Hzi3VziIHirKasl5wr6pEt
 EsTjdWLZUZHkGZ8xkpGh0FswAvzsR0mDIr+vnKMj9vcsSDAEzb0Hj2bVBzrTeei+tPlABu
 f51XcBM9vKcawUeU7bbBo8LAq7tkfv8AcaGFiKQUCi2v2UvQUMXpNPqMX24BYA==
ARC-Authentication-Results: i=1; rspamd-6d4cb6745-pzlz2;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stupid-Little: 799cf3030fc11620_1774379738279_1125417871
X-MC-Loop-Signature: 1774379738279:2983996870
X-MC-Ingress-Time: 1774379738278
Received: from pdx1-sub0-mail-a247.dreamhost.com (sub5.mail.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.121.5.127 (trex/7.1.5); Tue, 24 Mar 2026 19:15:38 +0000
Received: from offworld (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4fgKWF0XLZz106Q;
 Tue, 24 Mar 2026 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1774379737;
 bh=BbTqBTO2UNWPJmUNpZ6hRnWiEKplaybPDOvBvM88LqY=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=b7m73sP6PclTbWah+3lOvakn3mLBZx2WeiYTj5zFc7VWCeujm/RukXnSpHHN3oFip
 KvNQWG7YKRaNK3OaaeecqJuguV0DXkRGgzGvnoCOfv+K5Rqtyza8mjkLGs9Czf68IW
 i9c4MLP27cFW/9JE8oKGEIGa/G3ieBuND8SHax+5P2Ni1c6VPNzC+SOlD54TQZZZkD
 7q260MwJOp2sggonePUFRvzpcJnBMu7aISX/tr40WBaVHiDrFyD7nRrQoJBCyp8EZ3
 zWrXioC8PQnCsNuThs9bEfTKycYQthwiCUD5OuTfw29XmDuxLp5wA4vHazBE2an3bW
 bBIkjZ2muTS6g==
Date: Tue, 24 Mar 2026 12:15:34 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: mst@redhat.com, jonathan.cameron@huawei.com, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v3 -qemu 0/2] hw/cxl: Media Operation Discovery fixlets
Message-ID: <20260324191534.uc3tnircy6fse7cw@offworld>
References: <20260319184256.3762391-1-dave@stgolabs.net>
 <96061f5f-cdda-4bf1-9ab4-97400fcc9344@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <96061f5f-cdda-4bf1-9ab4-97400fcc9344@tls.msk.ru>
User-Agent: NeoMutt/20220429
Received-SPF: softfail client-ip=23.83.209.27; envelope-from=dave@stgolabs.net;
 helo=butterfly.birch.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

On Tue, 24 Mar 2026, Michael Tokarev wrote:

>On 19.03.2026 21:42, Davidlohr Bueso wrote:
>>Hello,
>>
>>Changes from v2: indent fix in patch 1. Added reviewed+fixes tags.
>>Changes from v1: cleaned up comments in patch 2.
>>
>>While working on the driver side of this, I tripped on two qemu issues
>>around discovery semantics. I think this is the first time these code
>>paths are exercised.
>>
>>Davidlohr Bueso (2):
>>   hw/cxl: Respect Media Operation max ops discovery semantics
>>   hw/cxl: Exclude Discovery from Media Operation Discovery output
>
>Hi!
>
>I'm picking this series up for qemu-stable (10.2.x).
>

Yes, please do. Thanks!

