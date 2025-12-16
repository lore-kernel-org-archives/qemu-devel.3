Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E3BD5B87A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 01:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVJc9-00080H-Rp; Mon, 15 Dec 2025 20:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1vVJc7-0007zr-9z
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 20:12:31 -0500
Received: from cyan.elm.relay.mailchannels.net ([23.83.212.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1vVJc5-00047J-RH
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 20:12:31 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 968382221C7;
 Tue, 16 Dec 2025 01:12:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com
 (trex-green-2.trex.outbound.svc.cluster.local [100.108.184.183])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 4666F222170;
 Tue, 16 Dec 2025 01:12:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1765847546;
 b=Fd2uTwQakHWywm9oxgWURUQdg4gGjh2s2GdFj5vd1iWuD5wnC1kovR9zXcxKZOacYpa04U
 8zVDKYpkv3VCVE6glWv/nAjqrZu7LIHx8ji0A3DKF7fBoQe6i7+eJBOBgZFNH6W0dV5tU2
 B3BDNFC4pPb/Y1RZ6+swJGzbJ9+zxKxjYLr4cNEMG72yL0Of8OPVmGQuLYGXQyzh661dVc
 JUmvtlfaAEpZzO5RBFIabLHWmzTRczMBT+dy6gD0LuZpJWmX9mRpr0SEmXkiCcg2QACayh
 BoYIzRXc48lEIlblqVDsUrQCVE06GDmvlOtvhh0bi+fLQLWAE4Mc6SGIHAWUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1765847546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=27X+0lsG8lLYVdgLxuU9xn6aGmW52A2UJLm2XZMWYgQ=;
 b=HyvmrIS5iQvIpAk8d29svDh0tJIJ9PirD/LGH/jxZiyzHOEgQEzBanXDmEePEZUILNuggW
 iY7xyCmxrxvz77u1T7r9tr+2jPnsEajHW1STslBqCqYdoEeRhmd91P7RVfx+cgR7yW9nif
 PjxGmr5tSPTNeSocY0ZvrdftdIDKlqKzix5GsZNFniOCENcnx3t3awzftZvQHr+Yt5wqMF
 llxz0+d3Gqg1TXpUaIlDLf5sTzcoQrwfh4Rq21CVG+oH5LjDxFPWr2QQ4vy+YwaUWF3zMO
 /TBrxjGrj358jZ7TAJtdqjq9yfZGaZEIVecBMapCIAtNu2VAJi2jUS4/ruK4Rw==
ARC-Authentication-Results: i=1; rspamd-6ccd5b4cc5-9bzp5;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Industry-Chemical: 4789de36710ea059_1765847546497_4048344186
X-MC-Loop-Signature: 1765847546497:1204676025
X-MC-Ingress-Time: 1765847546497
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.108.184.183 (trex/7.1.3); Tue, 16 Dec 2025 01:12:26 +0000
Received: from offworld (p7838222-ipoefx.ipoe.ocn.ne.jp [123.225.39.221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4dVf6c4HyczyrD; 
 Mon, 15 Dec 2025 17:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1765847546;
 bh=27X+0lsG8lLYVdgLxuU9xn6aGmW52A2UJLm2XZMWYgQ=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=jjql1rs+KG6Clfi1YAZ39wF9MauIGiT/HQIJs4XmMnShCvWx1w0nOHBcMhW+RUsDa
 3Xg0dpSm0GWFQFsiEUk3ryZWwuHYP8W68Osw/xW+4mX9SrwL5taiAni+gJo64d1bLZ
 0ZMGTmV+josVFyJbGvtK/VMcTVyE+xv4RE7Lc7cx0bfDAp/GuKOpE1Cc4ZyeIo3zm3
 4Uwm4OxU2OULqiyPbuqGeXxczLlbiljbSsPZVn7qf4RyxyQZaVFhUAAJBwW3E0fL9g
 QUe1RXZTp+IWn8nFqozDMqTotyFKYh3E20w2TtznKKhLktFLqf3/W82eUoAEZeTPeR
 l1BcQQoShRG7Q==
Date: Mon, 15 Dec 2025 17:12:11 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
 dongjoo.seo1@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, armbru@redhat.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
Message-ID: <20251216011211.anwnw25ot6n3euhq@offworld>
References: <20251103195209.1319917-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251103195209.1319917-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429
Received-SPF: softfail client-ip=23.83.212.47; envelope-from=dave@stgolabs.net;
 helo=cyan.elm.relay.mailchannels.net
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

ping? If there are no further issues, could this be picked up into
your jic23 tree?

Thanks,
Davidlohr

