Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA44ECCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 06:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8vJ6-0004uM-K2; Wed, 15 Oct 2025 02:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8vJ0-0004tW-Sm
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:48:14 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8vIs-0006Ad-6m
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:48:14 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E51ED80871;
 Wed, 15 Oct 2025 09:47:56 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a94::1:15] (unknown
 [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id tlJDki0NvuQ0-pXRAe5ca; Wed, 15 Oct 2025 09:47:56 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760510876;
 bh=pNQQ7ZHrkvJs/T5Kt4MI9397eTxRRe5PXbpYozaldsg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MUq/QJ6FFUDX7FK8XJMYQL+rP1+i9t8uDH6i2bTqSt4HmwiGK8VyASuRu7jld3IZH
 lEmfQX+sN7a6I7kxxJsdBtQanyHKIb5nKLVTFcRNIex0b///DbS13A2yGdEtGWQqW7
 Z7a3NOAbWXCjsR1GyDDOgjAFHrKkU1xcDcd/U3NA=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a5f39738-0df4-4715-8ad9-763ddf206430@yandex-team.ru>
Date: Wed, 15 Oct 2025 09:47:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] chardev/char: split chardev_init_logfd() out of
 qemu_char_open()
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, qemu-devel@nongnu.org, raphael@enfabrica.net,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20251014152644.954762-1-vsementsov@yandex-team.ru>
 <20251014152644.954762-3-vsementsov@yandex-team.ru>
 <87bjm8k6y8.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87bjm8k6y8.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 15.10.25 09:35, Markus Armbruster wrote:
> The subject says "split chardev_init_logfd() out of qemu_char_open()".
> What the actually does is factor chardev_init_common() out of
> qemu_char_open().  Has the commit message gone stale?
> 

Oh, right, I've renamed the function in v3.

-- 
Best regards,
Vladimir

