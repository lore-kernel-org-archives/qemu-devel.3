Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9A5C36010
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 13:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txnWn-0001WK-3k; Thu, 27 Mar 2025 09:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txnWl-0001Ry-Av
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 09:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txnWi-0007GY-G3
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 09:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743083045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wxM9uhtx57Ay/8dSm+yAGNTTkGkr9hHYnVk5NRRq+vQ=;
 b=E4GUOTZCQxD+r8PhYSMjuNGmvRxwjBkd0ss9W/nqR9aujf/8GBblKU0nTSQZ2nbsaBKGwl
 +ieC35xd1pN/XfOJj12XSgWqxnVIcAd+GH7wLe4raRsGZq+kVV+ccfIV9PzB6r86NIiOhl
 pPVXUXyWBcvZjq9ayKWCw/6nb7RqmLU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-bI9x4rYxP4WEaT6fH96STg-1; Thu,
 27 Mar 2025 09:44:02 -0400
X-MC-Unique: bI9x4rYxP4WEaT6fH96STg-1
X-Mimecast-MFC-AGG-ID: bI9x4rYxP4WEaT6fH96STg_1743083040
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96B4D1800A3A; Thu, 27 Mar 2025 13:43:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 540051800944; Thu, 27 Mar 2025 13:43:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60C4221E66C7; Thu, 27 Mar 2025 14:43:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: zoudongjie <zoudongjie@huawei.com>
Cc: <alex.chen@huawei.com>,  <chenjianfei3@huawei.com>,
 <eric.fangyi@huawei.com>,  <fam@euphon.net>,  <hreitz@redhat.com>,
 <kwolf@redhat.com>,  <luolongmin@huawei.com>,  <mujinsheng@huawei.com>,
 <qemu-block@nongnu.org>,  <qemu-devel@nongnu.org>,
 <qemu-stable@nongnu.org>,  <renxuming@huawei.com>,
 <stefanha@redhat.com>,  <suxiaodong1@huawei.com>,
 <wangjian161@huawei.com>,  <wangyan122@huawei.com>,
 <yebiaoxiang@huawei.com>,  <zhuyangyang14@huawei.com>
Subject: Re: [PATCH v3 2/2] qapi/throttle: add timeout parameter for
 qmp_block_set_io_throttle()
In-Reply-To: <20250327123443.2250580-1-zoudongjie@huawei.com>
 (zoudongjie@huawei.com's message of "Thu, 27 Mar 2025 20:34:43 +0800")
References: <8734ey2924.fsf@pond.sub.org>
 <20250327123443.2250580-1-zoudongjie@huawei.com>
Date: Thu, 27 Mar 2025 14:43:54 +0100
Message-ID: <8734eytwpx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

zoudongjie <zoudongjie@huawei.com> writes:

> On Thu, 27 Mar 2025 09:04:51 +0100, Markus wrote:
>> zoudongjie <zoudongjie@huawei.com> writes:
>> 
>> > On Wed, Mar 26, 2025 at 10:53:20 +0100, Markus wrote:
>> >> zoudongjie via <qemu-devel@nongnu.org> writes:
>> >> 
>> >> > From: Zhu Yangyang <zhuyangyang14@huawei.com>
>> >> >
>> >> > Calling qmp_block_set_io_throttle() will be blocked for a long time
>> >> > when a network disk is configured and the network failure is just about
>> >> > to occur.
>> 
>> What other commands could similarly block?
>
> In theory, any command may be blocked if it calls bdrv_drained_begin().
> I did a quick check, qmp_block_resize() could similarly block, since it called
> bdrv_drained_begin(), I'm going to verify it later.

Please do.

Should all these commands support time out?

>> >> > Therefore, we add a timeout parameter for qmp_block_set_io_throttle to control
>> >> > its execution duration.
>> >> 
>> >> What's the QMP reply when a block_set_io_throttle command times out?
>> >
>> > The reply is:
>> > {"id":"libvirt-484","error":{"class":"GenericError","desc":"Blk io limits disable timeout"}}
>> 
>> I find the error message confusing.  Suggest "command timed out".
>
> This message doesn't provide more details about the error, especially for developers.
> How about using "command timed out: disable I/O limits"

I don't get what "disable I/O limits" is trying to tell the user.  Can
you explain?

>> >> > The default value of timeout is 0, that is infinite wait, consistent with
>> >> > previous behavior.
>> >> >
>> >> > Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
>> 
>> [...]


