Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CBCCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 09:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGDPu-0000Vi-NE; Tue, 04 Nov 2025 04:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGDPt-0000VR-06
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:33:29 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGDPq-000087-Iy
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 04:33:28 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 71A95C00D9;
 Tue, 04 Nov 2025 12:33:20 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:95c::1:2] (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IXg6tc1GluQ0-lp780WwW; Tue, 04 Nov 2025 12:33:19 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762248799;
 bh=Czjf1pUI9JCv4WTnksA1o28sX7iHEx4DUbsfqsV1PG4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=nMCiLrdBu43KWlqvKy/3SwunDj13256apHc5E2qh5XA6NRlDo96zgOMnfCyLqA6AB
 m9icwDTOyej+a7kks92aGDUKGZUI5HIFZXMTe6XmO3ggLNXxA22dq7g3J7M3drgcfl
 KLLlyvxewkcu+iirl5ppXbxaPhICSMeHzIJ8Bgtw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <579109a3-8a6d-40de-9e5c-5eb15361122d@yandex-team.ru>
Date: Tue, 4 Nov 2025 12:33:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] chardev/char: introduce .init() + .connect()
 initialization interface
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20251031155914.189112-1-vsementsov@yandex-team.ru>
 <20251031155914.189112-6-vsementsov@yandex-team.ru>
 <CAMxuvaybTyz97Pp1QeTQP1f7D4Gvf-yNRZRCM7zbbEPqgSUYkw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAMxuvaybTyz97Pp1QeTQP1f7D4Gvf-yNRZRCM7zbbEPqgSUYkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 02.11.25 14:37, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Oct 31, 2025 at 7:59 PM Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> wrote:
> 
>     We'll need a possibility to postpone connect step to later point in
>     time to implement backend-transfer migration feature for vhost-user-blk
>     in further commits. Let's start with new char interface for backends.
> 
>     .init() takes QAPI parameters and should parse them, called early
> 
>     .connect() should actually establish a connection, and postponed to
>     the point of attaching to frontend. Called at later point, either
>     at time of attaching frontend, or from qemu_chr_wait_connected().
> 
>     Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>>
>     Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com <mailto:marcandre.lureau@redhat.com>>
>     ---
>       chardev/char-fe.c      |  4 ++++
>       chardev/char.c         | 39 +++++++++++++++++++++++++++++++++++++--
>       include/chardev/char.h | 30 +++++++++++++++++++++++++++++-
>       3 files changed, 70 insertions(+), 3 deletions(-)
> 
>     diff --git a/chardev/char-fe.c b/chardev/char-fe.c
>     index 34b83fc1c4..c67b4d640f 100644
>     --- a/chardev/char-fe.c
>     +++ b/chardev/char-fe.c
>     @@ -193,6 +193,10 @@ bool qemu_chr_fe_init(CharFrontend *c, Chardev *s, Error **errp)
>       {
>           unsigned int tag = 0;
> 
>     +    if (!qemu_chr_connect(s, errp)) {
>     +        return false;
>     +    }
> 
> 
> this should be after "if (s)" condition.
> 
> It is moved in a later patch, but better do it now.

Oh, right, will do.

-- 
Best regards,
Vladimir

