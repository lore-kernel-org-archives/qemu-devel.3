Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0820ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO62-00053C-LY; Sat, 30 Aug 2025 12:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1usGaO-0004pr-SM
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 04:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1usGaM-0007cV-SR
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 04:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756541115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ml8Zf9PK6m5KoAqK+uECD5Djc8eYEKseVRFwnhscRlM=;
 b=JbBM4D64RFakzeV+TjKiXo3LOy9Z07yQce2udS+yuu7zmeVqGo6mWFt1tGXkb8kBbRzyX7
 Eq2hvM7IPznxfhrdL0Tis61pPt+Kis3JhxXEQwiXfmYHdDZtj9r+eSaBnZNCiHZSl/U9Mh
 YAcgh130NnzX8fbDRJd2hGPnWCwKtkQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-G-UyVm5PNmi8h2YvNcLe8A-1; Sat,
 30 Aug 2025 04:05:11 -0400
X-MC-Unique: G-UyVm5PNmi8h2YvNcLe8A-1
X-Mimecast-MFC-AGG-ID: G-UyVm5PNmi8h2YvNcLe8A_1756541110
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EDF51955F26; Sat, 30 Aug 2025 08:05:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 657AC1800447; Sat, 30 Aug 2025 08:05:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A24DD21E6A27; Sat, 30 Aug 2025 10:05:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Akihiko
 Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Cornelia Huck <cohuck@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v5 08/13] qmp: update virtio features map to support
 extended features
In-Reply-To: <91ad4a0f8c1372b6c9405b5b861ce3e86b5d975a.1755080614.git.pabeni@redhat.com>
 (Paolo Abeni's message of "Wed, 13 Aug 2025 12:28:21 +0200")
References: <cover.1755080613.git.pabeni@redhat.com>
 <91ad4a0f8c1372b6c9405b5b861ce3e86b5d975a.1755080614.git.pabeni@redhat.com>
Date: Sat, 30 Aug 2025 10:05:06 +0200
Message-ID: <873499dykt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Paolo Abeni <pabeni@redhat.com> writes:

> Extend the VirtioDeviceFeatures struct with an additional u64
> to track unknown features in the 64-127 bit range and decode
> the full virtio features spaces for vhost and virtio devices.
>
> Also add entries for the soon-to-be-supported virtio net GSO over
> UDP features.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Acked-by: Markus Armbruster <armbru@redhat.com>


