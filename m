Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314E1C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnEKJ-0000u4-Dr; Fri, 24 Jul 2026 07:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wnEKB-0000tY-Ah
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wnEK9-0005aj-KK
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784893456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dp493WtKFn5mgmc6KbXPZLg0UXYbOXpnjuZlb6co53U=;
 b=UP9wKPy7SHEm/579n/Mf0dWk52NMmctkmZK2KQKQxCjdNl+YYH32tQ2NWFC1el0U/hlAWq
 /IU1P1RJm6cPGU8CdoxlcVY+JOev2fd/XDoVVprbpZQBICkhoFVliPZZ21WOzBtPEikVha
 3OW0JcLFO8bs2gc+lVp9tgZCvqvPPlA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-G1w6RvC6Oyug3rwL1J0T1Q-1; Fri,
 24 Jul 2026 07:44:12 -0400
X-MC-Unique: G1w6RvC6Oyug3rwL1J0T1Q-1
X-Mimecast-MFC-AGG-ID: G1w6RvC6Oyug3rwL1J0T1Q_1784893448
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02F2C195DE08; Fri, 24 Jul 2026 11:44:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DE1F30002DE; Fri, 24 Jul 2026 11:44:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D56AA21E6920; Fri, 24 Jul 2026 13:44:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  BALATON Zoltan <balaton@eik.bme.hu>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  "Maciej S. Szmigiero"
 <maciej.szmigiero@oracle.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>,  Igor Mammedov
 <imammedo@redhat.com>,  FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,  Nicholas Piggin <npiggin@gmail.com>,  Aditya Gupta
 <adityag@linux.ibm.com>,  Glenn Miles <milesg@linux.ibm.com>,  Harsh
 Prateek Bora <harshpb@linux.ibm.com>,  qemu-ppc@nongnu.org,  Alex
 Williamson <alex@shazbot.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  Cornelia Huck <cohuck@redhat.com>,  Eric Farman
 <farman@linux.ibm.com>,  Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org,  Luc Michel <luc@lmichel.fr>,  Fam Zheng
 <fam@euphon.net>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-11.2 v3 00/15] qdev: Clarify and enforce the device
 realization lifecycle
In-Reply-To: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp> (Akihiko
 Odaki's message of "Tue, 21 Jul 2026 17:16:50 +0900")
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 24 Jul 2026 13:44:00 +0200
Message-ID: <874ihoa9z3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> qdev currently represents a device's realization state with a single
> boolean. This cannot distinguish a device that has never been realized
> from one whose realization has failed or that has been unrealized, nor
> can it represent realization in progress. Consequently, the same device
> can enter DeviceClass::realize() reentrantly or more than once.

.realized is initially false.  It is only ever modified in
device_set_realized(), which is the setter of QOM property "realized" of
"device" and its subtypes.  device_set_realized() is only called when
the property is set.  It does nothing when the new value is the same as
the old value.

Code changes property "realized" only in qdev_realize() and
qdev_unrealize().

Implementations of .realize may call qdev_realize() for their
components.  Having this loop back would be a bug.

If your claim "can enter reentrantly" is correct, we have bugs to fix.
I believe it is incorrect.

There are two kinds of devices, onboard and user-created.

User-created devices go through qdev_device_add_from_qdict().  If
qdev_realize() fails, the device is immediately destroyed.

Onboard devices get created and realized by board code.  It commonly
treats qdev_realize() failure as fatal error.  Trying again instead
would be a bug.

If your claim "can enter more than once" is correct, we have bugs to
fix.  I believe it is incorrect.

Exception, sort of: users can manipulate properties with QMP command
qom-set.  This is generally unsupported and a Very Bad Idea[*].  There
might be supported exceptions (I don't know), but "realized" is
definitely not among them.  Unsurprisingly, it's a fast path to grief:

    $ qemu-system-x86_64 -S -display none -monitor stdio -nodefaults
    QEMU 11.0.90 monitor - type 'help' for more information
    (qemu) qom-set /machine/i440fx realized false
    (qemu) qom-set /machine/i440fx realized true
    qemu-system-x86_64: ../system/memory.c:2585: memory_region_add_subregion_common: Assertion `!subregion->container' failed.

I figure your series rejects the second qom-set.  I'm pretty sure the
first qom-set already wounds the VM fatally[**].  Same as for a
multitude of other properties that aren't prepared to be qom-set at
arbitrary times.

Mind, I'm not objecting to adding additional guards against .realize()
getting called more than exactly once.  I'm only challenging your cover
letter, and probably your commit messages (which I haven't read).

[...]


[*] One could argue that having command qom-set is a Very Bad Idea.

[**] It just doesn't crash a stopped VM right away for me.


