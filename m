Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F00C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 12:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUQ0x-0007YY-G9; Thu, 18 Jul 2024 08:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhrica@redhat.com>) id 1sUQ0v-0007Xx-JE
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhrica@redhat.com>) id 1sUQ0t-00011V-2g
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721304813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bgji5YSREoHrEnwZ3YkdoW+Izz5eva1pZN/e8Bppvlo=;
 b=CGzg9ZjXKGyjHUujlOJ73wY4m68gCV1LlpsDAJm289U3FiqwOpp+O4URXTsmXFI47DsPCm
 0V2sIp4SQgwCuvwcgZS57pMWj7BoOmYhxgn5BllEGfwXRDOcPhj9M/r3+TpPFda91O58oE
 AGyTNEaKHeinHXmMSaKKgiBvDIONjyE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-BPF-3F84OnashS-I6a8r-w-1; Thu,
 18 Jul 2024 08:13:32 -0400
X-MC-Unique: BPF-3F84OnashS-I6a8r-w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 977931955D44
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 12:13:31 +0000 (UTC)
Received: from m-rh-lap.brq.redhat.com (unknown [10.43.17.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37C20195605F; Thu, 18 Jul 2024 12:13:28 +0000 (UTC)
From: Matej Hrica <mhrica@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, dbassey@redhat.com, aesteve@redhat.com,
 slp@redhat.com, Matej Hrica <mhrica@redhat.com>
Subject: [RFC PATCH 0/2] vhost-user-gpu: Add support for blob resources
Date: Thu, 18 Jul 2024 14:12:45 +0200
Message-ID: <20240718121247.181510-1-mhrica@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mhrica@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,
these patches enable a backend vhost user gpu implementation to support blob
resources.
The first patch simply forwards required feature flags. The second patch
registers a shared memory region for mapping the blob resources in the guest
memory.

I am not sure about the shared memory region creation in the second patch.
Is it fine to rely on the parent object to create the shared memory region?
The parent object should be either virtio-gpu-pci or virtio-vga, though I am
not really sure about the class hierarchy.

These patches are based on this RFC: 
[RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests.

Since this relies on an RFC patch, I am also sending this as an RFC too.

Matej Hrica (2):
  vhost-user-gpu: Forward RESOURCE_BLOB and CONTEXT_INIT flags
  vhost-user-gpu: Add shared memory region support

 hw/display/vhost-user-gpu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

-- 
2.45.2


