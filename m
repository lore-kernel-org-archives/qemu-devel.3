Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366F5CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux4Tn-0003jg-5a; Fri, 12 Sep 2025 10:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ux4O1-00074f-RP
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ux4Nz-0008SZ-Lt
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757685861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w2MxUGe6lMDwAPfFSTYc7f8GSAViBQux1/MNYdcmjwg=;
 b=TPLXinV4Y3Ibxod3je8EqfMwkhoZcAmHk2ezgGvV5352cM0xO4fUjhMbZAznSdudXs58Kq
 dVDJZcWwfvvHQqBAokyM4U+0nnIZ9DmQHrKQkBZVxV4+3o9ATrst4sHR2TYle9DXh0nUe0
 MvYziBbIPgccXrgHvcSTI7VoY/yXD7Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-MZ1RlWWxOsm_6IrEQaSZhw-1; Fri,
 12 Sep 2025 10:04:19 -0400
X-MC-Unique: MZ1RlWWxOsm_6IrEQaSZhw-1
X-Mimecast-MFC-AGG-ID: MZ1RlWWxOsm_6IrEQaSZhw_1757685857
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2AEC180047F; Fri, 12 Sep 2025 14:04:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2398330002C8; Fri, 12 Sep 2025 14:04:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 68B8F21E6A27; Fri, 12 Sep 2025 16:04:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Dmitry
 Fleytman <dmitry.fleytman@gmail.com>,  Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Jason Wang <jasowang@redhat.com>,  Sriram
 Yagnaraman <sriram.yagnaraman@ericsson.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,  Cornelia
 Huck <cohuck@redhat.com>,  Luigi Rizzo <lrizzo@google.com>,  Giuseppe
 Lettieri <g.lettieri@iet.unipi.it>,  Vincenzo Maffione
 <v.maffione@gmail.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v6 09/14] qmp: update virtio features map to support
 extended features
In-Reply-To: <39761dc3-cd86-4cb2-9765-44bd0bdece1b@redhat.com> (Paolo Abeni's
 message of "Fri, 12 Sep 2025 15:57:28 +0200")
References: <cover.1757676218.git.pabeni@redhat.com>
 <bef09bed78378da9c32d9913eefb83bd42ba8808.1757676218.git.pabeni@redhat.com>
 <87cy7v7pon.fsf@pond.sub.org>
 <39761dc3-cd86-4cb2-9765-44bd0bdece1b@redhat.com>
Date: Fri, 12 Sep 2025 16:04:12 +0200
Message-ID: <87bjnf6a3n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Paolo Abeni <pabeni@redhat.com> writes:

> On 9/12/25 3:42 PM, Markus Armbruster wrote:
>> Paolo Abeni <pabeni@redhat.com> writes:
>> 
>>> Extend the VirtioDeviceFeatures struct with an additional u64
>>> to track unknown features in the 64-127 bit range and decode
>>> the full virtio features spaces for vhost and virtio devices.
>>>
>>> Also add entries for the soon-to-be-supported virtio net GSO over
>>> UDP features.
>>>
>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> 
>> You lost my
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>
> Whoops, sorry!
>
> And thanks for persisting with it :)

No problem :)


