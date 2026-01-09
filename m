Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E541ED26D60
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 15:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veEhI-0004uS-Ec; Fri, 09 Jan 2026 10:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1veEhG-0004rK-8q
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:46:42 -0500
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1veEhE-00037S-LS
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:46:42 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id D232916317E;
 Fri, 09 Jan 2026 15:46:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com
 (100-106-231-41.trex-nlb.outbound.svc.cluster.local [100.106.231.41])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 4B960162FD3;
 Fri, 09 Jan 2026 15:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1767973597;
 b=dVMm87EfdDHmgwqh7B3rQBTEIEeHajmcCJTy0oKdY+WAFUm1ZQcFIpTSSPmVnySlecAr6A
 Fn80G0mHs4OUNwd+fvFGwhLz6cHBVaDfqm7eJG8rv37vyZoXDuc/8QIO4ZcH5M5BCUsfS3
 XxHnaX0tzXjn3EMlIHnHCCr+B34SOMAxWWH098UeDw7w4fG/zKFsNvUDKOcFpjL0WI4ttX
 Y156Bno4HKH9qzHCXXgIVKUCFaqyXaanBzgH9BjV7vleluK4Z7DIm3uV2OPRMZTX2d8zZV
 YuTd/ejBkG02xRcNWX+0JeTTgg1R9vAfveMjbgDH+BImGBjvfgAaGhEPwkk/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1767973597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=J0YeUc4uZZA2rzhUqoWGUw/nFVZmcYYQTo66go1yg8E=;
 b=2ZayUipMnHi2VOlMaDMTrp5Y3WN3I7aKUilkg0rsLoxNmxOSAuXNwAmtcCrnYulwR7zbFO
 UnFihNNFkBhPQAKUHlC5l1PKvbW221i7aq3eLW94mVrW8KeIijTy7OiXK6k6jVtaE35m3Y
 CSlUNsgiibR5f4U4gNBNIY/uNs8PTqQ93CwxWRmHuiGiBaCevWFZXGXFpnUNHB0oGc+Xbr
 W7WtooM4nf1hIWfLLUPcxSsBVHrDlT8vpn0Hetz97pIK3BXJH6C9R1pcFh0XjUcpNIyk56
 NKfH36m1RftrxWN/ucDMtkGQIs2DIPVpy9tROafBwcaI1CmBwcyEGxcDLVzetg==
ARC-Authentication-Results: i=1; rspamd-79549fd459-rc7kr;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stupid-Hook: 5c9ef3ea29fb9407_1767973597585_3337697369
X-MC-Loop-Signature: 1767973597585:308863095
X-MC-Ingress-Time: 1767973597585
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.106.231.41 (trex/7.1.3); Fri, 09 Jan 2026 15:46:37 +0000
Received: from offworld (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4dnmND4tnDz1041;
 Fri,  9 Jan 2026 07:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1767973597;
 bh=J0YeUc4uZZA2rzhUqoWGUw/nFVZmcYYQTo66go1yg8E=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=HvNRI1i9PSYWbvZynYM4yT1TvU2epPqgAx7ysZIyk7Z/25qPbbNE2h1+0CNiZpLmI
 AzA4bTHGCSizfLR+IIXOtU+7VrL6dpwbbV6l3tlc+E20BGBMLwntex/+QH2lQ3eJjq
 SnN+8JuVe9WPbw1sDpwm1mkXNIF4zkq9tGw1wW2dyNHHKOpImfNZOUZ62R7E/mb0mG
 NrkjvVchz4AhmdpJvIvsL86eUFp08M9mqDmDSpTibHtjZ6bIK3rZgb7+AhCrWViaev
 xIii4GKXLd4BajDZRv/GrzHAJ+mDwkgiMW32FZG7z2lQnwW9H8TbOVQXyfmol+QYl8
 VEyoIlBYI40bA==
Date: Fri, 9 Jan 2026 07:46:34 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org,
 Ravi Shankar <venkataravis@micron.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v5 4/7] hw/cxl: Update CXL Fixed Memory Window ACPI
 description to include Back Invalidate support.
Message-ID: <20260109154634.3cgy47ylfqkpupup@offworld>
References: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
 <20260109144511.557781-5-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260109144511.557781-5-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20220429
Received-SPF: softfail client-ip=23.83.222.61; envelope-from=dave@stgolabs.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

On Fri, 09 Jan 2026, Jonathan Cameron wrote:

>Defaults for these windows has always been to enable anything QEMU supports.
>With the addition of back invalidate support it is necessary to specify that
>host windows support this.
>
>CXL emulation is currently only suitable for software stack verification.
>The relaxation of the restrictions on this window to include BI have no
>affect on the OS until BI capable devices are added and until now these
>have not existed. As such no backwards compatibility impacts are expected
>from this change.
>
>Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

