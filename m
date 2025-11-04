Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23C7CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKRG-00046K-4z; Tue, 04 Nov 2025 12:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGKPq-0003I4-Hg
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGKPn-00012e-0U
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762275703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yh2GxF6lpMlqP8VDTVhsqBnKh/1w/IPwdbZGpR/1RD4=;
 b=FuDOrJWIccR13bUJdAcvGt6zAES4S3wCsQurdqAUsNksRN/fETjCgcYiKXZsz1NVCcOlid
 E7t+DCw8pFc0PlIP0S/1j8OtUGon6lAsfC4picQhmEgDPKKqmP2II3n/RwoBIb7U/A829k
 gKSdSp++e5HR72ZjWbGVmiu0ySxltRs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-BmLWrmw4P_mzWGSUZ_LHyA-1; Tue,
 04 Nov 2025 12:01:41 -0500
X-MC-Unique: BmLWrmw4P_mzWGSUZ_LHyA-1
X-Mimecast-MFC-AGG-ID: BmLWrmw4P_mzWGSUZ_LHyA_1762275700
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E34721956070; Tue,  4 Nov 2025 17:01:39 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3C011800451; Tue,  4 Nov 2025 17:01:37 +0000 (UTC)
Date: Tue, 4 Nov 2025 18:01:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Jean-Louis Dupond <jean-louis@dupond.be>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/2] qcow2: queue discards when discard-no-unref enabled
Message-ID: <aQoxbsvnulqywIsD@redhat.com>
References: <20250513132628.1055549-1-jean-louis@dupond.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513132628.1055549-1-jean-louis@dupond.be>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 13.05.2025 um 15:26 hat Jean-Louis Dupond geschrieben:
> Partially based on the proposal of Andrey in
> https://patchew.org/QEMU/20240913163942.423050-1-andrey.drobyshev@virtuozzo.com/
> Split up this from the rest might get it merged a bit quicker hopefully :)
> 
> Since the implementation of discard-no-unref, we did not queue the
> discards correctly when discard-no-unref was enabled.

Thanks, applied to the block branch.

Kevin


