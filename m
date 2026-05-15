Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93986CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNu0X-00007C-H8; Fri, 15 May 2026 10:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wNu0Q-00006L-AF
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wNu0O-0004NC-PD
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778857151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkG0RECOA8CZC+SqcKfrpsTr8jCvPtYJa6zizs0rd2Q=;
 b=dxyDloZrB0ui18Hx+uplNQQhMh2OeQoculA4KIuQ756gCQ8sh64TyRJTTKkVoCayhLSsWR
 X9zaBcqQZr3RYwVbuh9tbrD9YEJpUxAECXqWkAGPh9OESIvuxf0HyjxLj4KtUalyAHAz6u
 QXXCsLdGDXfeC7MMa6DxeWCqsPDj3Ns=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-FBq2DG75NMiPpk52EBeGpQ-1; Fri,
 15 May 2026 10:59:07 -0400
X-MC-Unique: FBq2DG75NMiPpk52EBeGpQ-1
X-Mimecast-MFC-AGG-ID: FBq2DG75NMiPpk52EBeGpQ_1778857146
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD2911956055; Fri, 15 May 2026 14:59:05 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.123])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F66819560AB; Fri, 15 May 2026 14:59:02 +0000 (UTC)
Date: Fri, 15 May 2026 16:59:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v6 12/16] tests: validate dmsetup result in test 128
Message-ID: <agc0tMv-GCVIyeQY@redhat.com>
References: <20260513120003.226790-1-berrange@redhat.com>
 <20260513120003.226790-13-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513120003.226790-13-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 13.05.2026 um 13:59 hat Daniel P. Berrangé geschrieben:
> The I/O test 128 uses 'dmsetup create' to create a device, optionally
> using sudo to elevate privileges.
> 
> This dmsetup command works in GitLab CI, however, the test then fails
> with a missing device name:
> 
>   1..1
>   # running raw 128
>   not ok raw 128
>   ----------------------------------- stderr -----------------------------------
>   --- /builds/berrange/qemu/tests/qemu-iotests/128.out
>   +++ /builds/berrange/qemu/build/scratch/raw-file-128/128.out.bad
>   @@ -1,5 +1,5 @@
>    QA output created by 128
> 
>    == reading from error device ==
>   -read failed: Input/output error
>   +qemu-io: can't open device /dev/mapper/eiodev16546: Could not open '/dev/mapper/eiodev16546': No such file or directory
>    *** done
> 
>   (test program exited with status code 1)
> 
> It is believed that this is due to the build env using a manually
> populated /dev, such that the device mapper node won't ever appear.
> It is not a race, since a test adding a sleep did not result in the
> device appearing.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

I wonder how much this test gets run at all then. Tests requiring
passwordless sudo probably aren't something that most people run
locally, and my idea with them was mostly that at least CI will run
them.

So while I don't disagree with your fix, I wonder if the test couldn't
be rewritten to work without dmsetup. Maybe the FUSE export could help?

Anyway, for now:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


