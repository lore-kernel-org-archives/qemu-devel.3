Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C074FCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 16:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVAeh-0003hN-5X; Thu, 04 Jun 2026 12:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVAed-0003gU-7R
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVAeb-00034o-9D
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 12:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780589443;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfY89U9FlEEQmVa9fIkSfj/aZdfhMPIj/WgntSo8CLM=;
 b=GJFc1HZoZwDbSoiZ1y9jYstt+kKiHRZOfRCmHQot4xM7HQCSoVG2SbFzl8todF+Xbg7SRj
 3JIbxInHflXTsCaSAp9AeYuJyVTJpiocji3qPB7HKN/igTlfrgjb7xAR5NaeMcGsRDBaS5
 BPXFNuUFzOmiriyfEnOiN0DmMY8rL/4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-U74vHk0FMGWv-BJm2Qn-5A-1; Thu,
 04 Jun 2026 12:10:42 -0400
X-MC-Unique: U74vHk0FMGWv-BJm2Qn-5A-1
X-Mimecast-MFC-AGG-ID: U74vHk0FMGWv-BJm2Qn-5A_1780589441
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ECEC180061E
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2026 16:10:41 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5C91180049F; Thu,  4 Jun 2026 16:10:39 +0000 (UTC)
Date: Thu, 4 Jun 2026 17:10:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Subject: Re: [PATCH v3 23/24] hw/i2c/pmbus: fix undefined behavior in
 pmbus_direct_mode2data
Message-ID: <aiGjfMQamilAzhDg@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
 <20260516-qom-tests-v3-23-3f20c3a029a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260516-qom-tests-v3-23-3f20c3a029a7@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, May 16, 2026 at 11:59:22AM +0400, Marc-André Lureau wrote:
> The intermediate result of (Y * 10^-R - b) / m can be negative when
> the bias (b) is large and the raw register value is small (e.g. zero
> on an uninitialized device). Assigning that negative double to uint32_t
> is undefined behavior, caught by UBSan/clang.
> 
> Use a double intermediate and clamp negative results to zero.
> 
> Fixes: 3746d5c15e70 ("hw/i2c: add support for PMBus")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/i2c/pmbus_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
> index 853dc4b4342..861f5b4fb63 100644
> --- a/hw/i2c/pmbus_device.c
> +++ b/hw/i2c/pmbus_device.c
> @@ -23,8 +23,8 @@ uint16_t pmbus_data2direct_mode(PMBusCoefficients c, uint32_t value)
>  uint32_t pmbus_direct_mode2data(PMBusCoefficients c, uint16_t value)
>  {
>      /* X = (Y * 10^-R - b) / m */
> -    uint32_t x = (value / pow(10, c.R) - c.b) / c.m;
> -    return x;
> +    double x = (value / pow(10, c.R) - c.b) / c.m;
> +    return (x > 0) ? (uint32_t)x : 0;

Couldn't  'x' exceed  G_MAXUINT32 and thus truncate here which
while not undefined would still seem undesirable ? If so, then
perhaps

  return (x > 0
            ? (x < G_MAXUINT32 ? (uint32_t)x : G_MAXUINT32)
	    : 0);

?

>  }
>  
>  uint16_t pmbus_data2linear_mode(uint16_t value, int exp)
> 
> -- 
> 2.54.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


