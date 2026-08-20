Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE697C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx1lt-00029C-Vc; Thu, 20 Aug 2026 08:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wx1lr-00027c-DU; Thu, 20 Aug 2026 08:21:23 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wx1lo-0000x5-VC; Thu, 20 Aug 2026 08:21:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id D7550C04DF;
 Thu, 20 Aug 2026 15:21:13 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:642::1:11] (unknown
 [2a02:6bf:8080:642::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id DLWVkQFaeeA0-c6Mb77hO; Thu, 20 Aug 2026 15:21:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787228473;
 bh=kwlpdc1rzjdWoEmonGobE71tlSJiCR4IEsBb4Kaaw04=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=g/hM7zT6A/pFG0GFaggnN7mJhanmXCJ11gl4AnVziJ8bOfIgQAQa8JoCrCNpOQNMK
 bqczf70bwt4m15KErIb2WRrPHWnHeSm5AVcKpD2lYwrRgaZwQbBgy92/bQY6/oJVF3
 rSgBhPzKkE1rtO5hhufNdHLA9KGIvgUAfCAgc1H8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f593671e-5328-4780-a2c4-c69e66255d18@yandex-team.ru>
Date: Thu, 20 Aug 2026 15:21:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] block/nbd: never index requests[] with an
 unchecked cookie
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260820115228.587427-1-den@openvz.org>
 <20260820115228.587427-3-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260820115228.587427-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20.08.26 14:52, Denis V. Lunev wrote:
> From: Denis V. Lunev<den@openvz.org>
> 
> Cookies are converted into indices of s->requests[] in several places
> and the result is used right away, without any check:
> 
>      int i = COOKIE_TO_INDEX(cookie);
>      ...
>      return nbd_co_receive_offset_data_payload(s, s->requests[i].offset,
> 
> COOKIE_TO_INDEX() subtracts one, so a zero cookie becomes an index of
> -1 and the access lands in front of the array. This is undefined and,
> depending on the type of the index and on what the compiler has put
> there, it can as well pass silently: at the site above i is signed, so
> even a plain i < MAX_NBD_REQUESTS check would happily let -1 through.
> 
> Route every conversion through a helper which hands out the slot only
> for a cookie in range and owned by a request in flight, so that the
> check can not be forgotten again. The helper reports through an Error,
> as the one cookie which is not ours to trust, the one taken from the
> wire in nbd_receive_replies(), is a protocol error rather than an
> internal inconsistency and has to stay a channel error. Every other
> cookie is one we have issued and still own, so a bad value there is a
> bug in this file, which is what &error_abort spells out.
> 
> The cookie of the reply in flight goes through the helper as well. It
> is not an unchecked value either: it has passed the check on the wire
> path, or it has been cleared by the previous commit.
> 
> Cc: Eric Blake<eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> Signed-off-by: Denis V. Lunev<den@openvz.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

