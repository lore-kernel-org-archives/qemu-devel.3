Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945D6C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7QM-0007KV-Gw; Mon, 04 Mar 2024 07:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh7Q1-0007D4-8P
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:27:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh7Pu-0003uU-2n
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709555248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yAal6C6QcRZeDx+OKuVJB0WxPgjjJ68wA/tMc8cqGnA=;
 b=Dl4IKOEYk6F3YQrjLegeSEIcBCRfBov4xB9ZWYQDtFeAnHDWnwPPzWay/gHCW9e3jUmKCz
 HVIJkwXYRWtNXoja4n+tA4iSFvX9LPsZcgonTg1qVS3BdN1o7rWDeLNI8mpKEm1rflZppL
 4pQKtml54UK6COkXo/nJSrnuPPqd2Rw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-nNqTjGWqPi6238sWig6ilQ-1; Mon, 04 Mar 2024 07:27:25 -0500
X-MC-Unique: nNqTjGWqPi6238sWig6ilQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C848185A589;
 Mon,  4 Mar 2024 12:27:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D650492BC7;
 Mon,  4 Mar 2024 12:27:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4235921E6A24; Mon,  4 Mar 2024 13:27:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Fiona Ebner
 <f.ebner@proxmox.com>,  qemu-devel@nongnu.org,  qemu-block@nongnu.org,
 eblake@redhat.com,  hreitz@redhat.com,  jsnow@redhat.com,
 den@virtuozzo.com,  t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com,  pkrempa@redhat.com
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
In-Reply-To: <ZeWnFhLKCamlP97y@redhat.com> (Kevin Wolf's message of "Mon, 4
 Mar 2024 11:48:54 +0100")
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
 <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
 <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru>
 <87o7gbyy8w.fsf@pond.sub.org> <ZUTffE0wfjLH2u+e@redhat.com>
 <87cywqn84g.fsf@pond.sub.org>
 <1310efb0-e211-46f5-b166-d7d529507a43@yandex-team.ru>
 <ZeWnFhLKCamlP97y@redhat.com>
Date: Mon, 04 Mar 2024 13:27:23 +0100
Message-ID: <87ttlmqj10.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 28.02.2024 um 19:07 hat Vladimir Sementsov-Ogievskiy geschrieben:

[...]

>> About the APIs, I think, of course we should deprecate block-job-* API, because we already have jobs which are not block-jobs, so we can't deprecate job-* API.
>> 
>> So I suggest a plan:
>> 
>> 1. Add job-change command simply in block-core.json, as a simple copy
>>    of block-job-change, to not care with resolving inclusion loops.
>>    (ha we could simply name our block-job-change to be job-change and
>>    place it in block-core.json, but now is too late)
>> 
>> 2. Support changing speed in a new job-chage command. (or both in
>>    block-job-change and job-change, keeping them equal)
>
> It should be both block-job-change and job-change.
>
> Having job-change in block-core.json rather than job.json is ugly, but
> if Markus doesn't complain, why would I.

What we have is ugly and confusing: two interfaces with insufficient
guidance on which one to use.

Unifying the interfaces will reduce confusion immediately, and may
reduce ugliness eventually.

I take it.

[...]


