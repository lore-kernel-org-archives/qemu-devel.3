Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162BBF4BB9A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvCXu-0004Bx-E1; Wed, 25 Feb 2026 05:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvCXo-0004Bd-Is
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:55:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvCXk-0000ue-Az
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772016899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ECrzQKuRTVP8rIxsh1wBi6ZL45U8oEQ4dQNbIfOE5LI=;
 b=aWF6v+NsAdJqA9PIG7xGhBVlvXPJYDMBSFIKHkLHCU6Y9DLOjJsWzByEhsJgrNDuP9Q1jV
 Y8ioa2CimEgP8JS9DUoIjdl5xgiXbEbnnXS8ojwMAT+fmPqumuuq1/X/SGTUsdl6l95xl0
 +3vD73PbWfmAZkG3SySHrkOLlTJTMWo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-6CpSe_DfMaaqOcYkot43ZQ-1; Wed,
 25 Feb 2026 05:54:57 -0500
X-MC-Unique: 6CpSe_DfMaaqOcYkot43ZQ-1
X-Mimecast-MFC-AGG-ID: 6CpSe_DfMaaqOcYkot43ZQ_1772016896
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 559FF18004A9; Wed, 25 Feb 2026 10:54:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9D5319560A2; Wed, 25 Feb 2026 10:54:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7234421E692D; Wed, 25 Feb 2026 11:54:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V4 4/4] qapi: examine IOThread attachment status via
 query-iothreads
In-Reply-To: <CAK3tnvJ=_rp-JjkrgMA6cf+WXc0oHFJeQ5CsQsLf-fEd1ikGgw@mail.gmail.com>
 (Zhang Chen's message of "Wed, 25 Feb 2026 18:29:29 +0800")
References: <20260213171622.55629-1-zhangckid@gmail.com>
 <20260213171622.55629-4-zhangckid@gmail.com>
 <87wm0bq047.fsf@pond.sub.org>
 <CAK3tnvKEJSDMVC4bkEbhfsVXpp7nVbq+Kue9fFVmOrd5f_ugCg@mail.gmail.com>
 <874in65y7r.fsf@pond.sub.org>
 <CAK3tnvJ=_rp-JjkrgMA6cf+WXc0oHFJeQ5CsQsLf-fEd1ikGgw@mail.gmail.com>
Date: Wed, 25 Feb 2026 11:54:53 +0100
Message-ID: <87jyw1um82.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Zhang Chen <zhangckid@gmail.com> writes:

> On Tue, Feb 24, 2026 at 4:42=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > On Tue, Feb 17, 2026 at 3:51=E2=80=AFPM Markus Armbruster <armbru@redh=
at.com> wrote:
>> >>
>> >> Zhang Chen <zhangckid@gmail.com> writes:
>> >>
>> >> > Extend the 'IOThreadInfo' structure to include attachment metrics.
>> >> > This allows users to monitor how many devices are associated with
>> >> > a specific IOThread and identify them by their QOM paths.
>> >> >
>> >> > New fields added to IOThreadInfo:
>> >> > - @attached-cnt: An integer representing the number of devices
>> >> >   currently using this IOThread's AioContext.
>> >> > - @attached-dev: A string containing a delimited list ("|") of
>> >> >   QOM paths for the attached devices.
>> >> >
>> >> > These fields are also exposed via the Human Monitor Interface (HMP)
>> >> > command 'info iothreads' to assist with manual debugging and
>> >> > performance tuning.
>> >> >
>> >> > Example QMP output:
>> >> > {
>> >> >     "id": "iothread0",
>> >> >     "thread-id": 3134,
>> >> >     "attached-cnt": 2,
>> >> >     "attached-dev": "/machine/peripheral/blk1/virtio-backend | /mac=
hine/peripheral/blk0/virtio-backend",
>> >> >     ...
>> >> > }
>> >> >
>> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> >>
>> >> [...]
>> >>
>> >> > diff --git a/qapi/misc.json b/qapi/misc.json
>> >> > index 1f5062df2a..ca53638684 100644
>> >> > --- a/qapi/misc.json
>> >> > +++ b/qapi/misc.json
>> >> > @@ -76,6 +76,19 @@
>> >> >  #
>> >> >  # @thread-id: ID of the underlying host thread
>> >> >  #
>> >> > +# @attached-cnt: The parameter is a counter indicating how many
>> >> > +#     active devices are currently associated with this iothread
>> >> > +#     (e.g. virtio-blk).  In hotplug scenarios, users can
>> >> > +#     pre-allocate multiple iothread objects to serve as a persist=
ent
>> >> > +#     thread pool.  When a device is hot-unplugged, the correspond=
ing
>> >> > +#     IOThread is released but remains available, allowing subsequ=
ent
>> >> > +#     hot-plugged devices to attach to and reuse the existing thre=
ad.
>> >> > +#     (since 11.0)
>> >> > +#
>> >> > +# @attached-dev: A list of QOM paths for the devices currently
>> >> > +#     associated with this IOThread, delimited by " | ".
>> >> > +#     Returns "none" if no devices are attached. (since 11.0)

[...]

>> >>
>> >> QAPI schema design maxim: do not encode structured data as strings.
>> >> @attached-devs should be an array of QOM paths instead.
>> >
>> > OK, will fix in next version.
>>
>> Thanks!
>>
>> >> Unless I misunderstand your docs, @attached-cnt is the number of QOM
>> >> paths in @attached-dev, i.e. @attached-dev is redundant.  If this is =
the
>> >> case, drop it.  If it isn't, educate me :)
>> >
>> > As Stefan's comments, I try to address more specific needs:
>> > https://mail.gnu.org/archive/html/qemu-devel/2026-02/msg01892.html
>>
>> As far as I can tell, Stefan asked for the QOM paths of attached
>> devices.  @attached-dev provides it.  Good.  Why have @attached-cnt as
>> well?
>>
>
> Users can obtain the quantity more conveniently, avoiding the need to
> count the number of @attached-dev.
> If you think the @attached-cnt is redundant, I will remove it in next ver=
sion.

Please do.

[...]


