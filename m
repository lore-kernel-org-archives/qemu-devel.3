Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7F71098781
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Zhe-0005qi-69; Fri, 20 Mar 2026 09:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w3ZhY-0005pi-8A
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:15:45 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w3ZhS-0000JX-Jr
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:15:43 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 03CA18071A;
 Fri, 20 Mar 2026 16:15:33 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d40::1:38] (unknown
 [2a02:6bf:8080:d40::1:38])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id UFPwd33ASCg0-53CzRnId; Fri, 20 Mar 2026 16:15:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1774012532;
 bh=7Ld/5qrURxfNh+lay4ALmXwJFYcyj8ttPpN5Ud78dOY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ht4uc79dSg54J4bDV9hXQZ+yp9Q2UVDlP1pCut5cEMkjN5D1PkdDgXJ2y5nZORUw/
 49fIW1RjwSDyp3pTccqO4q63tCU9AmcEFS4SA6Q5qiVe+0H9+/lC2n1YO8o+vNGVrO
 qHZyibeB93OQYUCXYUJGcbaxpxE4Ta0J0RP+da6Y=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <bf8b1a86-8db8-4010-a0d0-f329d4ad591d@yandex-team.ru>
Date: Fri, 20 Mar 2026 16:15:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/8] virtio-net: live-TAP local migration
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, eblake@redhat.com, farosas@suse.de,
 peterx@redhat.com, zhao1.liu@intel.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org, yc-core@yandex-team.ru,
 leiyang@redhat.com, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 th.huth+qemu@posteo.eu, berrange@redhat.com, pbonzini@redhat.com
References: <20260319155333.260341-1-vsementsov@yandex-team.ru>
 <87bjgi96wy.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87bjgi96wy.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 20.03.26 12:39, Markus Armbruster wrote:
> Does not apply on current master for me.  What's your base?
> 

Based-on: <20260318113144.15697-1-vsementsov@yandex-team.ru>
    "[PATCH v4 00/13] net: refactoring and fixes"


Or, branch up-tap-fd-migration-with-bk-opt  at  https://gitlab.com/vsementsov/qemu.git

-- 
Best regards,
Vladimir

