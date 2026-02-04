Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499A7E83EF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnYQl-0000Qx-Bz; Wed, 04 Feb 2026 03:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnYQj-0000Qc-Lj
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:40:10 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnYQh-0007nW-LC
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:40:09 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E8C4D806F6;
 Wed, 04 Feb 2026 11:40:03 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:52d::1:1f] (unknown
 [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2ek6ml0A68c0-TknfrTjr; Wed, 04 Feb 2026 11:40:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770194403;
 bh=E7RYQ2p+pwBmkTencEi+WwWoST99oW5FWARzjjJJts0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=jbepWVgNDncVRMtmmqUXHbRSCaUUUdaQbOB7AFtceHGeBOu6QUXyL0sjK2EeGJnCo
 9iVNIyj/MYrXFO+4fx1tAY3/a+R6zXcnHEgdsh77dotidD09skoGzIHXgU639bW81/
 KT40Zn5dlICmSI9niTH3l+BCAvr2mvjiANkoJZxI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e87c2ed1-7ec6-490a-8ef9-37dee8b67eac@yandex-team.ru>
Date: Wed, 4 Feb 2026 11:40:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] net: introduce net_parse_fds()
To: "Chaney, Ben" <bchaney@akamai.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "d-tatianin@yandex-team.ru" <d-tatianin@yandex-team.ru>,
 "davydov-max@yandex-team.ru" <davydov-max@yandex-team.ru>,
 "i.maximets@ovn.org" <i.maximets@ovn.org>
References: <777C1460-24C2-48CC-9B38-34A5FE022007@akamai.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <777C1460-24C2-48CC-9B38-34A5FE022007@akamai.com>
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

On 03.02.26 22:29, Chaney, Ben wrote:
> 
> 
>> - if (opts->has_queues && (opts->queues < 0 || opts->queues > UINT_MAX)) {
>> + if (opts->has_queues && (opts->queues < 0 || opts->queues > INT_MAX)) {
> 
> This change should be part of the first patch (although probably we should use
> MAX_TAP_QUEUES instead anyway).
> 

MAX_TAP_QUEUES goes away with the series, so INT_MAX is correct limit

(hmm, or may be, simply change queues type to be smaller in QAPI interface?)

> 
> +int net_parse_fds(const char *fds_param, int **fds, int expected_nfds,
> + Error **errp)
> +{
> + g_auto(GStrv) fdnames = g_strsplit(fds_param, ":", -1);
> + unsigned nfds = g_strv_length(fdnames);
> + int i;
> +
>> + if (nfds > INT_MAX) {
>> + error_setg(errp, "fds parameter exceeds maximum of %d", INT_MAX);
>> + return -1;
> 
> This should probably be  MAX_TAP_QUEUES also
> 
> 
>> + }
>> +
>> + if (expected_nfds && nfds != expected_nfds) {
>> + error_setg(errp, "expected %u socket fds, got %u", expected_nfds, nfds);
>> + return -1;
>> + }
>> +
>> + *fds = g_new(int, nfds);
>> +
>> + for (i = 0; i < nfds; i++) {
>> + (*fds)[i] = monitor_fd_param(monitor_cur(), fdnames[i], errp);
>> + if ((*fds)[i] == -1) {
>> + net_free_fds(*fds, i);
>> + *fds = NULL;
>> + return -1;
>> + }
>> + }
>> +
>> + return nfds;
>> +}
> 
> I don't like the implicit cast to signed here.
> Is it possible to be more consistent with typing?
> 

OK. If no other mentions on this thing, I'll change them all (queues, nfds) to int.
I don't like these implicit casts too.


-- 
Best regards,
Vladimir

