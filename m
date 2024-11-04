Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0160DD132A3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 09:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7tml-0002TT-KN; Mon, 04 Nov 2024 04:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1t7tmj-0002TF-G4
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:54:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1t7tmg-0002gL-9F
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730714042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=om0BsGVtWlV+xOkbgJVxiXOI3g7uqIa94IOaGiuIG2U=;
 b=QQ4+XuBiDQjlVj1xU+jL/2CqGSL24C5bJB9V++8KqiWa5FHKNOAckdBWRnX5YUWKcnw2lx
 /nu1zZbp115lodvlGZHU3GgUIyq0FBFDOcnqDyN6Uu+laqbvHXSgzIcb9UV886CEQdb0+X
 4IhC6G81DrTyJbpci1NHkO8AwST27R0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286--Xyf_2yVMM2PJziJKv_cOQ-1; Mon,
 04 Nov 2024 04:52:43 -0500
X-MC-Unique: -Xyf_2yVMM2PJziJKv_cOQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0BE31955EA2; Mon,  4 Nov 2024 09:52:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.101])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAF7D1955F45; Mon,  4 Nov 2024 09:52:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 94AA3180063D; Mon,  4 Nov 2024 10:52:35 +0100 (CET)
Date: Mon, 4 Nov 2024 10:52:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: How to pass the EFI_MEMORY_SP type to VM in QEMU
Message-ID: <ujqnswmursutk3l235jv7sn6xo32y2fh2cxdmcqttx4mgfoula@3setckow5or6>
References: <BL1PR12MB5317899723624202EDF03FC8F1562@BL1PR12MB5317.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5317899723624202EDF03FC8F1562@BL1PR12MB5317.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 01, 2024 at 02:45:44PM +0000, Luo, Zhigang wrote:
> Dear QEMU Community,
> 
> I hope this message finds everyone well. My name is Zhigang, and I am currently engaged in a project that requires virtualization capabilities provided by QEMU. I am reaching out to the community for guidance on a specific configuration that I need to implement.
> 
> I am looking to pass the EFI_MEMORY_SP (Special Purpose Memory) type memory from host to a virtual machine within QEMU. This memory needs to be EFI_MEMORY_SP type in the virtual machine as well. This particular memory type is essential for the functionality of my project, and I have been facing some difficulties in setting it up correctly.
> 
> I have reviewed the available documentation and resources, but I have not yet found a clear method to achieve this. I would greatly appreciate it if anyone could provide insights, share their experiences, or direct me to relevant documentation or examples that pertain to configuring EFI_MEMORY_SP memory type for a VM in QEMU.

The memory map is passed from qemu to firmware using the etc/e820 fw_cfg
file (on x86).  That would be the natural way to this, for example by
taking a approach simliar to the linux kernel and define a type for this
(E820_TYPE_SOFT_RESERVED).

On arm / riscv etc. the memory map is passed via device tree from qemu
to firmware, so on these platforms the device tree should be used for
EFI_MEMORY_SP too.

take care,
  Gerd


