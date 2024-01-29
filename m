Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6542C47DDF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 13:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURd7-0008O1-9X; Mon, 29 Jan 2024 08:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rURd3-0008N9-3y
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:24:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rURcz-0004dH-H3
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706534655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BiJEdaKjrzZXZBO5w7myVP4qeyDsKXqTzd6qMgUk6K8=;
 b=M/qunOdA7iHVYTY6hCDjLU4/ZoSyVxQor9oc+hdCmC9Y0fjT2XQa0oVUWHXwVU6E3Qgo5W
 4sLgRrxg/nXFc/V0a8N1u2EuidcCSM5N+W+xfQcIzKy47cerSI8vfOdKhlQLMOmm/TDzvM
 ckN2P0SEhP6in+bTBNdHcvJOE2pBA28=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-QIlOfQfzOa2sR_bi2RoEnA-1; Mon, 29 Jan 2024 08:24:11 -0500
X-MC-Unique: QIlOfQfzOa2sR_bi2RoEnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47CE7185A780;
 Mon, 29 Jan 2024 13:24:11 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD226488;
 Mon, 29 Jan 2024 13:24:09 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: si-wei.liu@oracle.com, leiyang@redhat.com, yajunw@nvidia.com,
 Ani Sinha <anisinha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 dtatulea@nvidia.com, mcoqueli@redhat.com
Subject: [PATCH 0/2] Move net backend cleanup to NIC cleanup
Date: Mon, 29 Jan 2024 14:24:05 +0100
Message-Id: <20240129132407.1474202-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net=0D
structures if peer nic is present") effectively delayed the backend=0D
cleanup, allowing the frontend or the guest to access it resources as=0D
long as the frontend NIC is still visible to the guest.=0D
=0D
However it does not clean up the resources until the qemu process is=0D
over.  This causes an effective leak if the device is deleted with=0D
device_del, as there is no way to close the vdpa device.  This makes=0D
impossible to re-add that device to this or other QEMU instances until=0D
the first instance of QEMU is finished.=0D
=0D
Move the cleanup from qemu_cleanup to the NIC deletion.=0D
=0D
Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net structure=
s if peer nic is present")=0D
Acked-by: Jason Wang <jasowang@redhat.com>=0D
Reported-by: Lei Yang <leiyang@redhat.com>=0D
Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>=0D
=0D
Eugenio P=C3=A9rez (2):=0D
  net: parameterize the removing client from nc list=0D
  net: move backend cleanup to NIC cleanup=0D
=0D
 net/net.c        | 30 ++++++++++++++++++++----------=0D
 net/vhost-vdpa.c |  8 --------=0D
 2 files changed, 20 insertions(+), 18 deletions(-)=0D
=0D
-- =0D
2.39.3=0D
=0D


