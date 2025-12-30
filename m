Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A89EE4997
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 18:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaeNt-00044z-CF; Tue, 30 Dec 2025 13:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1vaeNi-00043B-Vy
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 13:23:45 -0500
Received: from shrimp.cherry.relay.mailchannels.net ([23.83.223.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1vaeNh-0007Kr-3w
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 13:23:42 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 9C316461267;
 Tue, 30 Dec 2025 18:23:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a201.dreamhost.com
 (100-106-228-128.trex-nlb.outbound.svc.cluster.local [100.106.228.128])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id C6D45461156;
 Tue, 30 Dec 2025 18:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1767119015;
 b=xWsFOtGbqQftInAa+iQxT7SGKv9+Z7FwEAdKlAFaUiTKo1pH90FejEUq1PkEAzqzY8q5xX
 O7/ATI9QSfXxjjhHxmuC0wPtqlFt7AgZzqU6jiXE9EKM8IQGAEJHh9h+SkzxBf7aBd1Iq4
 I5XTbTJOffD3B1CPinHIPtSNTLOo27+21fZX/XXGwy8rX6S09aDk6UfhzcoZAjimJ91MFG
 Ab+dtFI3xZUIZprh/N9KRnvdRlPn6zMDcRAjzoxuELQJ0rjZzXn0TsxrYxpKSNyOljeRID
 o/k0Pw/+sLlMDh/gcVLlibudTKYmR/cIkSSridXDryIhvdo8XlkCs0yxFTpoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1767119015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=+iDD+xLxc7kCEDFRfeZKkGwt71ZkyzmCd6c5SSwl1KU=;
 b=iETiWLf0Trd8NRRor2JGm1WT7rdY+RoXWm8l7luRd5pK/wucpjL9MZMsvb6CT5Xvs3NWjj
 WpHrntntTMjjC79lU5ADyGfRBuNTHtQhqlgZGsoSghswjcMPCPyU8vHBXNbQdQEFaS25Wt
 KdewzPZ7AWKhj4WWiTiowjX39s6V89dJZ+dUetOhJoy0591xSjDH3KObaBudPhhJ2v3OGB
 wHZ7nQ/Bagouxj7UDix2Z8XqS6ceKM58v71R7CcUifpmWWyb16I8W4pB4N3s8zQZtV6eSQ
 h6whNhaWPAaMECX3yZKj3v9hkFojEkD7GLqoJCiBg8Xxy/Ce3Fw0Pep7V8BShg==
ARC-Authentication-Results: i=1; rspamd-69599c6f48-nx9ss;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Drop: 2d6f637b34b6d577_1767119016094_3468609083
X-MC-Loop-Signature: 1767119016094:302333783
X-MC-Ingress-Time: 1767119016093
Received: from pdx1-sub0-mail-a201.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.106.228.128 (trex/7.1.3); Tue, 30 Dec 2025 18:23:36 +0000
Received: from offworld (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a201.dreamhost.com (Postfix) with ESMTPSA id 4dghKy4c40z1w; 
 Tue, 30 Dec 2025 10:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1767119015;
 bh=+iDD+xLxc7kCEDFRfeZKkGwt71ZkyzmCd6c5SSwl1KU=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=A69MqXfhvYJkuZxWNt00DM/UMIExmgH1Hn8wffmblVNEtHORdk0kJQkGnWNr00KTB
 PapJNqz8VHvsgvjAz091oKucDuFZlyJGEpgNu14/PL5/0e1aBIbcbULxV5Scxt5pBH
 Q4+Hkb8r28uuLeTZtd/s3ahlSRdF7gtQKzxV0Q7eeOBYmCjrPByIeOcpS85JcM+Q8Z
 KNnx0WhOAifyWSYUGpFMAHfDCzq61PrM0vp2U33cIr74oeGACfG0e3mLApcOdrOldd
 NSp5B4H0eyzlVVVjQoRVzil0n0s0X9+3m8DKIFXG3/HGv/yTzAQaW2gZdX0E3ATqv8
 GmyW1dr64Y1wQ==
Date: Tue, 30 Dec 2025 10:23:30 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>, ira.weiny@intel.com,
 alucerop@amd.com, a.manzanares@samsung.com,
 dongjoo.seo1@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, armbru@redhat.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
Message-ID: <20251230182330.upui2kkymnlylkh2@offworld>
References: <20251103195209.1319917-1-dave@stgolabs.net>
 <20251216011211.anwnw25ot6n3euhq@offworld>
 <20251217135930.00004616@huawei.com>
 <20251223115325.00000a36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251223115325.00000a36@huawei.com>
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

On Tue, 23 Dec 2025, Jonathan Cameron wrote:

>On Wed, 17 Dec 2025 13:59:30 +0000
>Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
>
>Seems the release has been tagged, so I've just rebased and pushed
>out a draft tree as cxl-2025-12-23-draft
>Draft because it is very very lightly tested so far.

Thank you for picking this up, 'draft' is fine with me :)
However, I am not seeing this new branch in your tree(?)

>
>On that I've merged in these patches with a few tweaks + added the
>table test updates.  If you get a minute to take a look please do.
>
>It's behind a couple of left over series from earlier cycles but my
>intent is to post it for reviews prior to merge shortly.  That
>may not include in the restrictions control qapi as I think that interface
>may need more thought.  For now I've added a patch that just enables
>BI always for CFMWSes.

Makes sense.

Thanks,
Davidlohr

