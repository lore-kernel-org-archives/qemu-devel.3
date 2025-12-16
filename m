Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B5ED609AF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 15:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVWvo-00045f-6h; Tue, 16 Dec 2025 10:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1vVWvV-000422-FE
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 10:25:30 -0500
Received: from shrimp.cherry.relay.mailchannels.net ([23.83.223.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1vVWvL-0002ZV-NA
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 10:25:22 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id AF794161525;
 Tue, 16 Dec 2025 15:24:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a258.dreamhost.com
 (100-103-169-129.trex-nlb.outbound.svc.cluster.local [100.103.169.129])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 63F60161D72;
 Tue, 16 Dec 2025 15:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1765898698;
 b=+FFLEATeKvtx9uMf9WDlQWZtIoThhsuW/cWSWMuCxj5SiBj8vsgteVG/RH5R5stEsWgmCe
 YxddGBLB8BpHpRPwBnXjtZgEJxUQHvT9hxgu93EZxLqvtRPMMjr8sdrzvpB371vwiY/tT7
 Es8EmECoCWXaMOpVue7XH/AerJIrZ+zcbTs/bbZwp1g/fxBolEDvCl8caloKUwMY6gztzp
 A6nOJFm/5ZS0zGSzz27e+2hdMgQie4iLzhw6ywdQ+eDWe9enQKvvT9zVisXNH+v+dSx8gM
 oq5zKpL5mVvviZHCIiDAYc9i3SJUeYI/Fw1FhjzCJiy22m/DbfByk6r3wgjcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1765898698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=V6cZ6hVfzbwD0/szhv0n+m7UeoPuCzz7r4RjXAaVA5g=;
 b=jzCK7ZJYdIxar32KGty6fkRgG2GaT+mG2GpnM9NPH76nniidV02O1IeynuNweZeT2ITnGi
 JOqiWDVuLGS01kdiE/fhIGsw2nd75OSmyXdoMqbG1Dzwa7mnbi2Sdf7FzxGl/7UrLGjc5b
 tvpnAzcWBF4kpmmtQr3YyePHrI5mfvruvD4uy7MgGu0IGO3OGR4IkioTH8ZE/3E+7VgvD2
 V4+ZSqZIS+ZBtCLboh7AB2tNTHQuJ6gMSeq3FjF1G2Ze6YdRcbjYr5wiVm1Gmlsr5sj4nQ
 3piE1nfFSLHHbXpa9J3N0cgr4CnkgHPXUzMEw0dCK1UHm6g4DQFXdq8VKwdlVw==
ARC-Authentication-Results: i=1; rspamd-659888d77d-4crmn;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Bubble: 55f6989866ea5fff_1765898699456_3183201204
X-MC-Loop-Signature: 1765898699456:1131494184
X-MC-Ingress-Time: 1765898699455
Received: from pdx1-sub0-mail-a258.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.103.169.129 (trex/7.1.3); Tue, 16 Dec 2025 15:24:59 +0000
Received: from offworld (unknown [205.220.129.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a258.dreamhost.com (Postfix) with ESMTPSA id 4dW11s0lfqz1066;
 Tue, 16 Dec 2025 07:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1765898698;
 bh=V6cZ6hVfzbwD0/szhv0n+m7UeoPuCzz7r4RjXAaVA5g=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=q3xv1VoSocvjp4cr4gvq5+vyjvzd+7Ko1SItkU5jmyG1MbobTMVeJzpfdNo76kZCT
 IKUtI8f63uMp4LlD3I1OYcz9Gp1xGDiWjjQ+B3h8AjEtV3wazdr3VEKsp2Vha2rn4E
 orPZOQLSZYC2cGbrfYC4+lkTtEx+BLMPLxXATHHzQzvmonABo+ry8RCP+3yr9t4Y23
 BgL3duuy0cyRivj5/IHUl/Ep2VDuVy1a7w/XygS0AAowlMPGERhPimKB2BrzZPqYSe
 2Xt7Q8WeJ2ugh1n4ZGqU1R3JM0hJHAARigCjl0fNCYhoeY5OUBwx5jyjb3Wq+vxVQQ
 NOQE/lmweNlfw==
Date: Tue, 16 Dec 2025 07:24:11 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Markus Armbruster <armbru@redhat.com>
Cc: jonathan.cameron@huawei.com, ira.weiny@intel.com, alucerop@amd.com,
 a.manzanares@samsung.com, dongjoo.seo1@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
Message-ID: <20251216152411.mlx5tgsdwnjss7ku@offworld>
References: <20251103195209.1319917-1-dave@stgolabs.net>
 <87cy4esysa.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87cy4esysa.fsf@pond.sub.org>
User-Agent: NeoMutt/20220429
Received-SPF: softfail client-ip=23.83.223.164; envelope-from=dave@stgolabs.net;
 helo=shrimp.cherry.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, 16 Dec 2025, Markus Armbruster wrote:

>Davidlohr Bueso <dave@stgolabs.net> writes:
>
>> The following allows support for component basic back invalidation discovery
>> and config, by exposing the BI routing table and decoder registers. Instead
>> of going the type2[0] route, this series proposes adding support for type3
>> hdm-db, which allows a more direct way of supporting BI in qemu.
>
>[...]
>
>> Applies against branch 'origin/cxl-2025-10-03-draft' from Jonathan's repository.
>
>URL?

That would be:
      https://gitlab.com/jic23/qemu/-/commits/cxl-2025-10-03-draft


