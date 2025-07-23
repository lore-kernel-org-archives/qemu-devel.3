Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2CFC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 10:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueWGg-0005Uc-ML; Wed, 23 Jul 2025 06:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1ueWGZ-0005RT-M0
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 06:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1ueWGV-0004LK-CQ
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 06:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753264793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ef2bHE+IJ4RJTBKfXUAAnI+DFaqzUKpW2msjx0XNFYQ=;
 b=iFIuYYlYWgY4/kC3d3Qm0J8F34Exx4OCTzbj/KAu01jz65eHaoDYC5LOvSiJNSSZLf7Ewl
 /WfBV62ckOt4yYBLUK8sOXSpSLrWmY551AneNH6A+xJnEmR3McIxMwtC/098y6o+NuLgWR
 0Dhe4x0CX59WUBFFwPk5IABnuwGyS5I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-mLCVnTtRP_KqgR-EA_Hgpg-1; Wed,
 23 Jul 2025 05:59:49 -0400
X-MC-Unique: mLCVnTtRP_KqgR-EA_Hgpg-1
X-Mimecast-MFC-AGG-ID: mLCVnTtRP_KqgR-EA_Hgpg_1753264788
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ADDC19560AA; Wed, 23 Jul 2025 09:59:48 +0000 (UTC)
Received: from localhost (pixel-6a.str.redhat.com [10.33.192.205])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FE5F19560AF; Wed, 23 Jul 2025 09:59:46 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Sebastian Ott <sebott@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH RFC] arm/kvm: report registers we failed to set
In-Reply-To: <b1f7bb67-070f-da38-369b-51ed1962fd2d@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250721161932.548668-1-cohuck@redhat.com>
 <b1f7bb67-070f-da38-369b-51ed1962fd2d@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 23 Jul 2025 11:59:45 +0200
Message-ID: <87jz3z5isu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
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

On Tue, Jul 22 2025, Sebastian Ott <sebott@redhat.com> wrote:

> On Mon, 21 Jul 2025, Cornelia Huck wrote:
>> +/* pretty-print a KVM register */
>> +#define CP_REG_ARM64_SYSREG_OP(_reg, _op)                       \
>> +    ((uint8_t)((_reg & CP_REG_ARM64_SYSREG_ ## _op ## _MASK) >> \
>> +               CP_REG_ARM64_SYSREG_ ## _op ## _SHIFT))
>> +
>> +#define PRI_CP_REG_ARM64_SYSREG(_reg)                    \
>> +    ({                                                   \
>> +        char _out[32];                                   \
>> +        snprintf(_out, sizeof(_out),                     \
>> +                 "op0:%d op1:%d crn:%d crm:%d op2:%d",   \
>> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP0),      \
>> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP1),      \
>> +                 CP_REG_ARM64_SYSREG_OP(_reg, CRN),      \
>> +                 CP_REG_ARM64_SYSREG_OP(_reg, CRM),      \
>> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP2));     \
>> +        _out;                                            \
>> +    })
>
> Gcc correctly complains about a dangling pointer here.

Hum, I maybe should switch to a system with a less ancient
compiler... thanks for testing.


