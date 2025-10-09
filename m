Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA667CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rIn-0004HT-MD; Thu, 09 Oct 2025 10:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6rIk-0004A5-R9
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6rId-0007ub-Kv
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760018832;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PWYJgAL524rjLa4pf7U7RdS9ywTYRJpVdQ8o4Wifl6g=;
 b=Be66tgO0DHjdA2FcHDzy6TUBXxAdO9foOR10Tzn6MFWEQMZYBnoME4biD5Z4aYwO7Vxf+T
 aPkYwFbIKCfibwdV7dz8jHFq2KG7rv/mngerr3FULFM383zb4k1tXo5XrhC6zrrQcfv6we
 BcDraZ+rviIFNGeCqfHHhUlEXY2XZ2Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-v9Eob-Q2P1K5DtX_9HcoXg-1; Thu,
 09 Oct 2025 10:06:58 -0400
X-MC-Unique: v9Eob-Q2P1K5DtX_9HcoXg-1
X-Mimecast-MFC-AGG-ID: v9Eob-Q2P1K5DtX_9HcoXg_1760018812
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F29A418002EA; Thu,  9 Oct 2025 14:06:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.196])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E37719560BB; Thu,  9 Oct 2025 14:06:41 +0000 (UTC)
Date: Thu, 9 Oct 2025 15:06:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2] hw/uefi: add "info ovmf-log" + "query-ovmf-log"
 monitor commands
Message-ID: <aOfBYBff1-BVhZao@redhat.com>
References: <20251007135216.1687648-1-kraxel@redhat.com>
 <aOcWOQJt-zLbiyUK@gallifrey> <aOdggKKyDtf3z57J@redhat.com>
 <aOefUN5_bSKjWPLc@gallifrey> <aOejzqM74_NiOHJJ@redhat.com>
 <ef6m5kcsotrgshbtrj2jawjk7waq5ggrt42ugazkxs7u3jt2sq@ccef4acxnshv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef6m5kcsotrgshbtrj2jawjk7waq5ggrt42ugazkxs7u3jt2sq@ccef4acxnshv>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 09, 2025 at 02:41:51PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > OK, what about sanitisation - if that text contains random binary what happens,
> > > or should we make sure it's sanitised?
> > 
> > As prior art, the QGA  'guest-exec' command will return stdout/stderr
> > of the command in base64 format.  The downside is that it is bloated
> > in size, but it is at least safe wrt JSON encoding.
> 
> In theory the log should just be text, but I've managed to f*ck up
> logging with broken patches in the past, with the result that random
> binary crap landed in the log.
> 
> So sending base64 in the json reply makes sense to me.  Do we have a
> qapi type for that?  Or should I use string?
> 
> > The HMP command could still dump the raw data IMHO, as that's human
> > facing and base64 is horrible for human consumption.
> 
> And probably a hmp implementation /not/ using the qmp command so we
> don't convert text -> base64 -> text ...

Although that is indeed inefficient, our overall long term goal is for
*all* HMP comamnds to be implemented by invoking a QMP command. This
will ultimately get us to the point where QAPI describes our public
facing functionality, and HMP could be moved to become an out-of-process
client side interface to QMP.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


