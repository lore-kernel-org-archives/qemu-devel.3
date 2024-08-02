Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229E3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 10:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZpQh-0005PE-RG; Fri, 02 Aug 2024 06:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZpQf-0005Hj-Ew; Fri, 02 Aug 2024 06:22:33 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZpQb-0005df-In; Fri, 02 Aug 2024 06:22:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:2287:0:640:bdb:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0439460DAB;
 Fri,  2 Aug 2024 13:22:24 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b725::1:34] (unknown
 [2a02:6b8:b081:b725::1:34])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MMVIMj2g74Y0-r64fm5OD; Fri, 02 Aug 2024 13:22:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1722594143;
 bh=GM3QPe9asR8jjs2PyWJ73NAjOVguxe8Y7L1iAJFvbzA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=KknFu322maEXE2phpfVbhiJfJcvSWyD2ebCYi+QDRbfXmJOq5Sb9RJP2DAG7onIVh
 rGSq6P7XnBJd0f9J2zZdRnzSokMIknYE/FldKClYBT27mTVcWqu4SBpWRiYErQvfel
 mnLxQ1jsmwfiIgjK0Leu5yppFpN8YWKNATxD+pg8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3b6cbb23-beb8-4ec6-9907-0fa6425fec27@yandex-team.ru>
Date: Fri, 2 Aug 2024 13:22:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] block: refactor commit_run for multiple write types
To: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20240713215644.742244-1-libvirt-e6954efa@volkihar.be>
 <20240713215644.742244-3-libvirt-e6954efa@volkihar.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240713215644.742244-3-libvirt-e6954efa@volkihar.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14.07.24 00:56, Vincent Vanlaer wrote:
> Signed-off-by: Vincent Vanlaer<libvirt-e6954efa@volkihar.be>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Honestly, I don't like this (mostly preexisting, but your patch make the problem more obvious) code for its "nested success path"

if (ret >= 0) {
   ret = ...
   if (ret >= 0) {

    ...


That's because we have the same complex error handling for all these errors. If refactor the commit_run(), I'd move get-block-status together with "if (copy)" block to separate function commmit_iteration(), which would have more readable style of error reporting, like:

ret = ...
if (ret < 0) {
    return ret;
}

ret = ...
if (ret < 0) {
    return ret;
}

  
-- 
Best regards,
Vladimir


