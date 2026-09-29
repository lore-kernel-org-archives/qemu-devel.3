Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18762CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTHP-0003x7-RI; Tue, 29 Sep 2026 04:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xBTHN-0003wf-IX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xBTHL-0002kg-9H
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790670813;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CXvWXANNzchzrfnAw+ANCycd6cYvJS3wOan8/UfT6Ew=;
 b=Q6GngE2RfLqIw8iiuBbJZ4ZpuGo/DlmAW8EN06Y8oG1hKbPZHWAI4mH9Hk9T34v/+PI3OK
 PN2XX9ahdOhkqz60RILGQRCPbHc/8IMu4mNcCbg1e15x3r3TNS/swac8c+X1Q1Y1Iy0bio
 geRKh+eSCckOjAGYksgW8Bmz/HXHJro=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-5uA4P9ANMx6_DyeCNqx0qA-1; Tue,
 29 Sep 2026 04:33:29 -0400
X-MC-Unique: 5uA4P9ANMx6_DyeCNqx0qA-1
X-Mimecast-MFC-AGG-ID: 5uA4P9ANMx6_DyeCNqx0qA_1790670808
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33BE318007FD; Tue, 29 Sep 2026 08:33:27 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3B211956087; Tue, 29 Sep 2026 08:33:20 +0000 (UTC)
Date: Tue, 29 Sep 2026 09:33:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Filip Hejsek <filip.hejsek@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v7 00/12] virtio-console: notify about the terminal size
Message-ID: <art3zrOdxq5o3Qxz@redhat.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
 <e6ac40a4ff79b9c603c7548acbd8fad9c0c44c87.camel@linux.ibm.com>
 <20260928054918-mutt-send-email-mst@kernel.org>
 <7ac1826c-3891-4750-b5b9-c5f2a4217396@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ac1826c-3891-4750-b5b9-c5f2a4217396@linux.ibm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 28, 2026 at 05:21:25PM -0400, Matthew Rosato wrote:
> On 9/28/26 5:50 AM, Michael S. Tsirkin wrote:
> > On Mon, Sep 28, 2026 at 11:30:03AM +0200, Maximilian Immanuel Brandtner wrote:
> >> I would really appreciate it, if this patch-set could be merged. I know
> >> that things can get really busy, but it seems to me that there aren't
> >> any blockers that should prevent this patch-set from being merged
> >> (apart from some minor refactors), even as is.
> > 
> > Why not address the minor comments you got?
> >
> 
> Just to clarify, Max did not write the subject series; he is expressing
> interest in it because he wrote a patch that builds upon it for s390x
> [1]. 
> 
> Now, I'm not asking anyone to take code that isn't ready; but I would
> like to understand if this series is abandoned or if the developer is
> planning to send a v8 so we (s390x maintainers) know what to do about
> Max's patch.
> 
> @Filip, do you plan to respin and address the comments you received? 
> There isn't much, but it looks like there was at least one real bug
> identified.

The series also has conflicts with Git master, so cannot be applied
as is.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


