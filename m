Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C6BCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSckE-0001OH-2a; Thu, 28 May 2026 11:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSckC-0001O6-NK
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSckA-00074s-OO
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779982436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pnmPn3NH0yQevU1t4SMBja33XUvgg1pAtFhfq0GzIj4=;
 b=GZfduz0JET37/LTnijeLRQK2ZG3xyErN09LYLusAJw8qBCLvEXB3hUgHwkHvMTqGFwh+u0
 TyrXMiTkFwubKgFZGuWC77RD3KocJ/AK7jbTUBPXRV/0shov15BZdBZEtth9NwXYEyIa3g
 WLTMCvKnUW0sK8PfcHW6f7qt2EvOQ5Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-ShivFw4kNOOKHMI526_yUg-1; Thu,
 28 May 2026 11:33:52 -0400
X-MC-Unique: ShivFw4kNOOKHMI526_yUg-1
X-Mimecast-MFC-AGG-ID: ShivFw4kNOOKHMI526_yUg_1779982430
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64C5C1800359; Thu, 28 May 2026 15:33:49 +0000 (UTC)
Received: from localhost (unknown [10.44.49.185])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30F1630001BB; Thu, 28 May 2026 15:33:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>, Alexandra Winter
 <wintera@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Hendrik
 Brueckner <brueckner@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Gautam Gala <ggala@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand
 <david@kernel.org>, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH] target/s390x: Make container ids in SysIB_15x 1-based
In-Reply-To: <9308b8e8-f2f8-4cd7-b25d-6f1f9573c6da@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260511134909.43802-1-wintera@linux.ibm.com>
 <9308b8e8-f2f8-4cd7-b25d-6f1f9573c6da@linux.ibm.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Thu, 28 May 2026 17:33:45 +0200
Message-ID: <87ik87mtuu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 12 2026, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> Am 11.05.26 um 15:49 schrieb Alexandra Winter:
>> The Container Id in a container-type TLE of SysIB_15x is defined as 8-bit
>> unsigned nonzero integer. Make stsi fc 15 emulation architecture compliant,
>> by starting the container ids at 1 for the lowest numbered container.
>> 
>> The qemu misbehaviour without this patch becomes obvious due to a recently
>> proposed kernel fix. Older linux kernels pass the container ids from stsi
>> fc15 unchanged to sysfs, i.e. starting at 1 on s390 hardware. This resulted
>> in off-by-one values when compared to the values from HMC. A Linux kernel
>> fix is being proposed to correct the sysfs topology ids by -1, so they
>> start at 0, e.g. when displayed by 'lscpu -ye'. In case a KVM guest with a
>> fixed kernel runs on a host with a qemu without this fix, this can result
>> in container ids erroneously being shown as 255.
>> Example (Fixed guest on unfixed qemu):
>> $ lscpu -ye
>> CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
>>    0    0    255  255    255    0 0:0:0         yes yes        vert-medium  0
>>    1    0    255  255      0    1 1:1:1         yes yes        vert-medium  1
>> After this fix:
>> $ lscpu -ye
>> CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
>>    0    0      0    0      0    0 0:0:0         yes yes        vert-medium  0
>>    1    0      0    0      1    1 1:1:1         yes yes        vert-medium  1
>> 
>> Fixes: f4f54b582f ("target/s390x/cpu topology: handle STSI(15) and build the SYSIB")
>> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>
> I guess this should go via Connys s390 tree.

Yep, that makes sense.


