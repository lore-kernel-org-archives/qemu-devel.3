Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA22D6E2DD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 09:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDgtK-0005Ei-83; Wed, 20 Nov 2024 04:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tDgtI-0005EJ-5u
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 04:20:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tDgtG-0006tz-Q6
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 04:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732094449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TeHm5cbjWIzlmYzYDxE3b4m5jFS4c52AYFhn8ztORqw=;
 b=Z5evEMM5PyOGN/jFY5sILAoM7uL5kHnQ1zddK62qhIQaoAv1fYxyBL4WNTgK5+2442lduU
 e8gphWD84V39zjR1LLRYmz9QTGdutATXEEPDBDejfjfBDbXnDu0bgYew27z8ftzc+ZYTM2
 LW5EHGHJAwvf8gwocUp+CPX0rfA3eCU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-X0AiksYlMKGlUwS1PWVW8Q-1; Wed,
 20 Nov 2024 04:20:45 -0500
X-MC-Unique: X0AiksYlMKGlUwS1PWVW8Q-1
X-Mimecast-MFC-AGG-ID: X0AiksYlMKGlUwS1PWVW8Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A447195419F; Wed, 20 Nov 2024 09:20:44 +0000 (UTC)
Received: from redhat.com (dhcp-192-228.str.redhat.com [10.33.192.228])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADBBA1956054; Wed, 20 Nov 2024 09:20:40 +0000 (UTC)
Date: Wed, 20 Nov 2024 10:20:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: Re: [PATCH 2/2] hw/scsi/scsi-disk: Avoid buffer overrun parsing
 'loadparam'
Message-ID: <Zz2p5qm776A3q5J4@redhat.com>
References: <20241120085300.49866-1-philmd@linaro.org>
 <20241120085300.49866-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241120085300.49866-3-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
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

Am 20.11.2024 um 09:53 hat Philippe Mathieu-Daudé geschrieben:
> Coverity reported a 1 byte overrun in scsi_property_set_loadparm
> (CID 15657462). Since loadparam[] length is known, simply directly
> allocate it in the device state.
> 
> Fixes: 429442e52d ("hw: Add 'loadparm' property to scsi disk devices")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Paolo already sent a pull request for a different fix (just allocating
one byte more). I think that's the better approach because other users
might expect the string to actually be null terminated.

Such as scsi_property_get_loadparm(), which you forgot to update:

    static char *scsi_property_get_loadparm(Object *obj, Error **errp)
    {
        return g_strdup(SCSI_DISK_BASE(obj)->loadparm);
    }

Kevin


