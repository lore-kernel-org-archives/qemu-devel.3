Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798CFC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYqM-0007TA-PN; Tue, 30 Jun 2026 09:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1weYqK-0007Se-6V
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1weYqI-0000VS-NN
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782827375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qeKc532ah8vj+sRhL7oRgH0EIc3h2kQMajXqU0GmmqQ=;
 b=WVQTZYHU1M5FZMw/h5oReF78mxrl85YqPAxExUnNazGeT+b8Irx+IIVdV0ig5ZPUCAqIP/
 eZyjk4knmPoaAI5RD1RkDsWkysUfMl4Ury6W9tTTNCSGvRPWCnuWX5FJ8Ms+WpYew7ih7T
 Bffl/Cia/kH/a+Gy/J5qx4faJ0RRrk4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-ByK7hdMRN9yj8St2iUFhhg-1; Tue,
 30 Jun 2026 09:49:31 -0400
X-MC-Unique: ByK7hdMRN9yj8St2iUFhhg-1
X-Mimecast-MFC-AGG-ID: ByK7hdMRN9yj8St2iUFhhg_1782827370
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAFCE180120E; Tue, 30 Jun 2026 13:49:29 +0000 (UTC)
Received: from localhost (unknown [10.44.34.134])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A955C180067F; Tue, 30 Jun 2026 13:49:28 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eauger@redhat.com>, Sebastian Ott <sebott@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/3] arm: handle CCSIDR_EL1 as a demuxed register
In-Reply-To: <aa1f8006-4665-4fcd-b8ee-5b90cd53e953@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260622135627.40573-1-sebott@redhat.com>
 <20260622135627.40573-3-sebott@redhat.com>
 <aa1f8006-4665-4fcd-b8ee-5b90cd53e953@redhat.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 30 Jun 2026 15:49:26 +0200
Message-ID: <87fr24kujd.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Mon, Jun 29 2026, Eric Auger <eauger@redhat.com> wrote:

> Hi Sebastian,
>
> On 6/22/26 3:56 PM, Sebastian Ott wrote:

(...)

>> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
>> index 6e8b335b8f..d9e058a57e 100644
>> --- a/target/arm/cpu-sysregs.h.inc
>> +++ b/target/arm/cpu-sysregs.h.inc
>> @@ -39,6 +39,7 @@ DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
>>  DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
>>  DEF(ID_DFR1_EL1, 3, 0, 0, 3, 5)
>>  DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
>> +DEF_MUX(CCSIDR_EL1, 3, 1, 0, 0, 0, 16)
> As I mentionned earlier, if this file were to be generated at some
> point, I don't see how I can infer the size of the muxed register from
> the AARCHMRS.
>
> Nevertheless I can move this definition somewhere else later and I think
> this shall not be a blocker for this series

Can we move this to some cpu-sysregs-demux.h.inc file? It would mess up
the order, but that should not be a problem in practice?

>
> Also I wonder if 16 is enough (although it is the current size in
> ArchCPU). In the future might end up = 8 levels x Ind 2 value x 2 value
> TnD = 32
>
> May be Tnd is not featured yet because it is relevant if FEAT_MTE2 is
> supported.

The KVM interface is also limited IIRC, so I guess it would need to be
extended.

>
>>  DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
>>  DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
>>  DEF(CTR_EL0, 3, 3, 0, 0, 1)


