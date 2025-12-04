Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C41D1F9B3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 10:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR6p0-0008HZ-F2; Thu, 04 Dec 2025 05:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vR6ox-0008Gb-NO
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:44:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vR6ov-0000Q5-VO
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764845058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yg1NYs0h32A3I84r2bq21Xhn2hCW5iAI228t8Q6ByVE=;
 b=RS0fADTIBHTpOSxNJF5OwQkuu6tGmfcEVgqSwZIXgo3R/7JFEWrjYhs2WLsJXetYYfWDh7
 Tby/5nIranRSh1BmPGE1C6zEiZcokP7DFOQJExKbbhfbDq9dg5Z5v7oHF3Q008P1xKLDyS
 MsPx8tk+ReTIl6am1feZL9IRuYitgNs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-ea3Q8qOkOni-3yOWV_wDbA-1; Thu,
 04 Dec 2025 05:44:15 -0500
X-MC-Unique: ea3Q8qOkOni-3yOWV_wDbA-1
X-Mimecast-MFC-AGG-ID: ea3Q8qOkOni-3yOWV_wDbA_1764845054
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F19191955F54; Thu,  4 Dec 2025 10:44:13 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.150])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E77C19560A7; Thu,  4 Dec 2025 10:44:11 +0000 (UTC)
Date: Thu, 4 Dec 2025 11:44:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qinwang@redhat.com, bmarzins@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH for-10.2] file-posix: Handle suspended dm-multipath
 better for SG_IO
Message-ID: <aTFl-MGoI9asqwkX@redhat.com>
References: <20251128221440.89125-1-kwolf@redhat.com>
 <1c7784d0-8952-4b4f-9a5e-923bdaef9f2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c7784d0-8952-4b4f-9a5e-923bdaef9f2f@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 03.12.2025 um 18:27 hat Hanna Czenczek geschrieben:
> On 28.11.25 23:14, Kevin Wolf wrote:
> > When introducing DM_MPATH_PROBE_PATHS, we already anticipated that
> > dm-multipath devices might be suspended for a short time when the DM
> > tables are reloaded and that they return -EAGAIN in this case. The
> > behaviour promised in the comment wasn't actually implemented, though:
> > We don't get SG_IO_MAX_RETRIES in practice, because after the first
> > 1ms sleep, DM_MPATH_PROBE_PATHS is called and if that still fails with
> > -EAGAIN, we error out immediately without any retry.
> 
> How so?  `hdev_co_ioctl_sgio_retry()` is what issues `DM_MPATH_PROBE_PATHS`,
> and if it gets `-EAGAIN` it will return `true`, requesting a retry.

Oops... You're right. I somehow ended up testing the old state with a
commit that isn't exactly the same as what went into master and it
didn't have the -EAGAIN special case yet. So this is just me running and
looking at the wrong version of the code.

Unfortunately, it's too late to fix the commit message now. But then,
it's only a random comment about the previous state and doesn't really
make a difference for this patch.

Kevin


