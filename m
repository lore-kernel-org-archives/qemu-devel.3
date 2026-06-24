Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF78CDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMy9-0002aK-B9; Wed, 24 Jun 2026 08:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcMy3-0002Zw-3K
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcMy1-00061R-9F
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782305071;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/9q67ZyZJJXzXwX3F1AoJRJhozDvTyqW0ksbKDhyA0=;
 b=YbpzckSLNxeSOqdbnOWFdeQtUSh1z9cYDYHpbVzAjsZBbuR1/Qc7z6J7lqhT8gw7tHrzW+
 pQQs70sMbRG87S5VWK0e6o9iRwgkppYXnN4ad2dzN084/2k3UVUr5oHYSCv5sINqf5EmvE
 dfSkgRJSHgWp1HUpW4kb6xZzUdHjWgo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-1wst6lHdPiimMgTBY2lCPw-1; Wed,
 24 Jun 2026 08:44:30 -0400
X-MC-Unique: 1wst6lHdPiimMgTBY2lCPw-1
X-Mimecast-MFC-AGG-ID: 1wst6lHdPiimMgTBY2lCPw_1782305069
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D11E61955F72; Wed, 24 Jun 2026 12:44:28 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82BCB1800348; Wed, 24 Jun 2026 12:44:27 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:44:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] gitlab: capture filesystem, CPU, memory and kernel info
 in logs
Message-ID: <ajvRJu-1VAk88R1c@redhat.com>
References: <20260521103624.1645809-1-berrange@redhat.com>
 <96a48300-ec95-4291-8cb8-439d255de9aa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96a48300-ec95-4291-8cb8-439d255de9aa@oss.qualcomm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 21, 2026 at 08:25:12AM -0500, Pierrick Bouvier wrote:
> On 5/21/2026 5:36 AM, Daniel P. Berrangé wrote:
> > For tests we have often had wierd failures that are related to the
> > runner environment. For example, tests that fail only with specific
> > filesystem setups.
> > 
> > Since we don't control the runners directly, it is important to
> > capture info about the environment to aid in failure diagnosis.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  .gitlab-ci.d/buildtest-template.yml | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> 
> Good idea,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Maybe add a ls -al /dev and id -a, to sort out potential right issues to
> access devices?

Yes, revisiting this, I'm adding those and doing many other changes
to improve consistency & maintainability. v2 incoming...

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


