Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCC7C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 07:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd3yx-0002og-7K; Thu, 22 Feb 2024 02:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rd3yr-0002hb-HX
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:58:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rd3yo-0005ZF-FA
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708588733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UU39IqS43PDUiY4FECJHL6DHlFpahH/0+K1fiQNtlqs=;
 b=CU+kDdJERptcAhQBnNj4d+SCfQNlBhpV1Ebk5kmvbhBa2CFQ4+ZSnRJRfWgJbwwOsNeC9F
 z2yip3lILdVk1wsHkXoLI68DBAYzxb5Qall2VkXcq/CM9hyEL5UodWzpTog8alsjxZ94eg
 v7lDd7N4ZaVJmjweH2DpWlKm1kyQw/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-10lLxtTiPjaJSW4Ee0qhOA-1; Thu, 22 Feb 2024 02:58:51 -0500
X-MC-Unique: 10lLxtTiPjaJSW4Ee0qhOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 995791064FA0;
 Thu, 22 Feb 2024 07:58:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EC0840C94A7;
 Thu, 22 Feb 2024 07:58:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3640821E66D5; Thu, 22 Feb 2024 08:58:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,  Eric
 Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 2/3] virtio: Declare the decoding functions to static
In-Reply-To: <64ad4aeff59e41df84466fa8d28b21813defcb07.1708525606.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Wed, 21 Feb 2024 22:28:52 +0800")
References: <cover.1708525606.git.yong.huang@smartx.com>
 <64ad4aeff59e41df84466fa8d28b21813defcb07.1708525606.git.yong.huang@smartx.com>
Date: Thu, 22 Feb 2024 08:58:49 +0100
Message-ID: <877cixx746.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hyman Huang <yong.huang@smartx.com> writes:

> qmp_decode_protocols(), qmp_decode_status(), and qmp_decode_features()
> are now only used in virtio-hmp-cmds.c.  So move them into there,
> redeclare them to static, and replace the qmp_ prefix with hmp_.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


