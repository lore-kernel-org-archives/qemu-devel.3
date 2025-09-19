Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF3ACAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYc0-0007ev-6j; Fri, 19 Sep 2025 06:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzYby-0007e3-9t; Fri, 19 Sep 2025 06:45:06 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzYbt-0003tH-LC; Fri, 19 Sep 2025 06:45:05 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7268680B0A;
 Fri, 19 Sep 2025 13:44:54 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a72::1:38] (unknown
 [2a02:6bf:8080:a72::1:38])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id riQA0U1Gna60-j2D2bLMJ; Fri, 19 Sep 2025 13:44:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758278694;
 bh=F09edft7YaQymcxDKkLfbveodyxSViH4N4UkF/w1BaQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=V5Bql0G4aO5Ke1O3Cn2zRdk9JissuF64jX/f6OmNqXhr0jVn+OMzpnMLrXL3NomCx
 jH6IK69xumupHrDefhYaqjz0ytACKA9VDOwakNKG6gu3+BfO1qJMDeZDmjivsO/YdO
 ntbLPs2QaGLfv8vIJQUmvBxI7AkA1RfDBsR8fNRU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0a96b12b-5c51-4e45-bec7-679c2f588fa4@yandex-team.ru>
Date: Fri, 19 Sep 2025 13:44:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/13] util/vhost-user-server: vu_message_read():
 improve error handling
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20250916131403.368343-1-vsementsov@yandex-team.ru>
 <20250916131403.368343-14-vsementsov@yandex-team.ru>
 <aMmHUW5nqZf1RxTb@redhat.com>
 <ea5f1352-e1f8-409e-a0cb-9568585628f1@yandex-team.ru>
 <aM0v-Gr0TTAllYmF@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aM0v-Gr0TTAllYmF@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 19.09.25 13:27, Daniel P. Berrangé wrote:
> On Wed, Sep 17, 2025 at 01:13:15PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 16.09.25 18:50, Daniel P. Berrangé wrote:
>>> On Tue, Sep 16, 2025 at 04:14:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> 1. Drop extra error_report_err(NULL), it will just crash, if we get
>>>> here.
>>>>
>>>> 2. Get and report error of qemu_set_blocking(), instead of aborting.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>    util/vhost-user-server.c | 17 +++++++++++------
>>>>    1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>
>>
>> Thanks a lot!
>>
>> Now the whole series is reviewed. Will you queue it
>> (together with base "[PATCH v4 0/2] save qemu-file incoming non-blocking fds")?
>> Or we should wait for ACCs from other maintainers?
> 
> I'm queuing it, with fixes for the minor problems I pointed out.
> 
> If possible, try to feed big patch series through gitlab.com CI in
> your own qemu.git fork before sending to catch all edge cases.
> 

Thanks! I'll try do it with "[PATCH v5 00/19] virtio-net: live-TAP local migration".

-- 
Best regards,
Vladimir

