Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A61DC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 16:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vib2O-0005U6-4c; Wed, 21 Jan 2026 11:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vib1b-000592-1t
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:25:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vib1Z-000390-NA
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769012740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bbAwdcub3kpuHsgHpW/m242bwxKV0QkHHW4R6aMFLHE=;
 b=PFRNe0jX7wtgv9HBTfV2D42z4xWeYjFefyAnJtA3rQfw4DLpde0ULiGwVBgf97G8XcqTst
 KROVUWC1SEvX74Z5rSzfEnQEvV+Ox3P0uvrCrFiMOpISsv0iHNvBOyR4JPB+dhz1ARNyUc
 QlSjAlpnlSZVAsWeEAbL+Avfhp8W1fA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-sUV1nzZsMFu3RxrtvEIgIQ-1; Wed,
 21 Jan 2026 11:25:37 -0500
X-MC-Unique: sUV1nzZsMFu3RxrtvEIgIQ-1
X-Mimecast-MFC-AGG-ID: sUV1nzZsMFu3RxrtvEIgIQ_1769012736
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBA2E19560A1; Wed, 21 Jan 2026 16:25:35 +0000 (UTC)
Received: from localhost (unknown [10.44.34.34])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED9B418008FF; Wed, 21 Jan 2026 16:25:34 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH RFC 1/3] arm: handle demuxed ID registers
In-Reply-To: <20260121094044.000019a8@huawei.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260119172732.140613-1-cohuck@redhat.com>
 <20260119172732.140613-2-cohuck@redhat.com>
 <20260121094044.000019a8@huawei.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Wed, 21 Jan 2026 17:25:32 +0100
Message-ID: <87bjinszk3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Jan 21 2026, Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Mon, 19 Jan 2026 18:27:30 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>> @@ -1083,6 +1102,7 @@ struct ArchCPU {
>>          uint32_t dbgdevid1;
>>          uint64_t reset_pmcr_el0;
>>          uint64_t idregs[NUM_ID_IDX];
>> +        uint64_t idregs_demux[NUM_ID_DEMUX_IDX][16];
> Hi,
>
> Trivial, but I'd like a comment on why 16. I assume because that's
> the biggest you've seen so far (8 levels, 2 types for CCSIDR)
> Just good to have a bread crumb here for future readers.

Yes, this came in via the current ccsidr[] sizing (which also might not
be quite the right thing to use, given that we could have 2*7 + 7
entries with FEAT_MTE2); I'm not at all sure whether that's a reasonable
value, but I'll certainly add a comment if we agree that it is. Or maybe
make it a #define.

>
> Otherwise seems reasonable to me.

Thanks for looking!

>>      } isar;
>>      uint64_t midr;
>>      uint32_t revidr;


