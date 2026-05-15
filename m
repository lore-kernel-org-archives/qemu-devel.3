Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B29CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNuCi-0008EK-UJ; Fri, 15 May 2026 11:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wNuCI-00089l-11
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wNuCD-00089i-0n
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778857883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cd4yBOSUizb8AR1+g5Pai/WWRQIbp7VO/+NvilmGlCA=;
 b=jP9aeq0I4/HqMKQ6U8L5PgxRDqBzPmNcXAQLLs0hM/D7T6XID8BKnvu3jlt7XgjB7n66Cr
 Wm5AVrfU+B3ZZVLmGM2ncizxmxqMlDuPGPKeu4AEvjpSYbP1hPoFRQFLfx/jolc9iOl2N4
 jsKy6ITQk3/OS9KD2V1rxY+DbcA9mlw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-jhjPhdgcNTCrOBdx1lLh0A-1; Fri,
 15 May 2026 11:11:20 -0400
X-MC-Unique: jhjPhdgcNTCrOBdx1lLh0A-1
X-Mimecast-MFC-AGG-ID: jhjPhdgcNTCrOBdx1lLh0A_1778857879
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CCDE180035D; Fri, 15 May 2026 15:11:18 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.123])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38E5530001A2; Fri, 15 May 2026 15:11:15 +0000 (UTC)
Date: Fri, 15 May 2026 17:11:12 +0200
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
Subject: Re: [PATCH v6 00/16] tests: do more testing of block drivers
Message-ID: <agc3kCGk_MjNIpo6@redhat.com>
References: <20260513120003.226790-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513120003.226790-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
>  v1: https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg01650.html
>  v2: https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02083.html
>  v3: https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02939.html
>  v4: https://lists.nongnu.org/archive/html/qemu-devel/2026-02/msg03245.html
>  v5: <...somewhere...mailman is dead again at time of sending...>
> 
> The recent (at the time of v1) set of regressions identified in the LUKS
> block driver re-inforced that despite having a hugely useful set of I/O
> tests, our CI coverage is still letting through too many bugs.
> [...]

I reviewed the patches directly related to qemu-iotests. One general
remark I have about this series is that the commit subject lines often
refer to "tests" when they actually only mean "iotests" (which is the
common subject line prefix for qemu-iotests changes) instead of all
tests. This makes the lines sometimes a bit confusing, so I'd suggest to
change them.

For the other patches more related to CI and the build system in
general, I had a look at them and agree with them/their commit messsage,
but didn't fully review them. For anything I didn't comment on, you can
add:

Acked-by: Kevin Wolf <kwolf@redhat.com>


