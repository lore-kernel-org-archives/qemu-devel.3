Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E955BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rolTN-0002bp-23; Mon, 25 Mar 2024 10:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1rolTF-0002ac-HT
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1rolTD-0001Lf-HY
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711377516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kddHsGdoems1bpo0xoOt/wOt+Zrb4GEhhdxDzYT3s7M=;
 b=ABDeLATwhjMRhilVfSn4dYmTuLOtgT0vPrmcr5KmCv8h5wN+w180I8NUrVdk7Ih6N2MB8B
 GyTv0UK9NMz1ZbE7AS+xT+L25nPqhmZ2FVvW/K/2K6jAfGG++lxDfQXiF1LRH5zxQwTGDH
 19tdJkz2lEuxCYho+M3g5xgrJHei/BU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-6kffz07VPuKr8Vd0V_JT5A-1; Mon,
 25 Mar 2024 10:37:24 -0400
X-MC-Unique: 6kffz07VPuKr8Vd0V_JT5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 657FB28B6AB2;
 Mon, 25 Mar 2024 14:37:24 +0000 (UTC)
Received: from localhost (unknown [10.22.8.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C7392166B4F;
 Mon, 25 Mar 2024 14:37:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Saif Abrar
 <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com
Subject: Re: [PATCH 09/10] hw/pci: Set write-mask bits for PCIE
 Link-Control-2 register
In-Reply-To: <9268c807-27f4-4c50-bb08-8bb97f0d84fe@kaod.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
 <20240321100422.5347-10-saif.abrar@linux.vnet.ibm.com>
 <9268c807-27f4-4c50-bb08-8bb97f0d84fe@kaod.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 25 Mar 2024 15:37:18 +0100
Message-ID: <87wmpq74yp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 25 2024, C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 3/21/24 11:04, Saif Abrar wrote:
>> PHB updates the register PCIE Link-Control-2.
>> Set the write-mask bits for TLS, ENTER_COMP, TX_MARGIN,
>> HASD, MOD_COMP, COMP_SOS and COMP_P_DE.
>
>
> You should resend this patch independently of the PowerNV PHB changes.
>
>
> Thanks,
>
> C.
>
>
>
>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>> ---
>>   hw/pci/pcie.c                             | 6 ++++++
>>   include/standard-headers/linux/pci_regs.h | 3 +++
>>   2 files changed, 9 insertions(+)

This patch also needs to be split: the code under standard-headers/ is
updated via a Linux headers update, which should either be a full update
against a released kernel version (can be -rc), or a placeholder patch
if the changes have not yet been merged.


