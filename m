Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBA5C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWsGD-0000iU-2V; Wed, 02 Jul 2025 03:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWsGB-0000hQ-6y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWsG9-0004ZA-4n
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751442718;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RVhEYkU0LKAK4rSwmFltHwoOvslzWPU8HQv8dPhbgYk=;
 b=Lu8l8UDDMx5FzBc7Dv0xxomwUyQCZUzQf+h4eR6JaPcuUvNZx0vvuBGhJWgwdRoq0sEGFt
 NYc79DUhZhXZlvTe7cgxg2qZOEkEK02BxKZWaxQN+zXNw8Tz3E+4dEh/iFfBVDKIcFIiQ4
 slxtTdtABSV2MyEz5slFvFcFxT68ARA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-0oifh1-lPwSaB-BWmkpGCQ-1; Wed,
 02 Jul 2025 03:51:55 -0400
X-MC-Unique: 0oifh1-lPwSaB-BWmkpGCQ-1
X-Mimecast-MFC-AGG-ID: 0oifh1-lPwSaB-BWmkpGCQ_1751442714
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E572180120D; Wed,  2 Jul 2025 07:51:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 570F019560A7; Wed,  2 Jul 2025 07:51:51 +0000 (UTC)
Date: Wed, 2 Jul 2025 08:51:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH] target/s390x: A fix for the trouble with tribles
Message-ID: <aGTk9-nkX7-zO0q9@redhat.com>
References: <20250701194241.434183-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701194241.434183-1-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 01, 2025 at 09:42:41PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> While Tribbles are cute, it should be "triple store" here,
> not "trible store".

Do we really need to fix it ? Tribbles are fun :-)

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/s390x/cpu_features_def.h.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
> index e23e603a792..c017bffcdc4 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -186,7 +186,7 @@ DEF_FEAT(PLO_CSO, "plo-cso", PLO, 25, "PLO Compare and swap (256 bit in paramete
>  DEF_FEAT(PLO_DCSO, "plo-dcso", PLO, 26, "PLO Double compare and swap (256 bit in parameter list)")
>  DEF_FEAT(PLO_CSSTO, "plo-cssto", PLO, 27, "PLO Compare and swap and store (256 bit in parameter list)")
>  DEF_FEAT(PLO_CSDSTO, "plo-csdsto", PLO, 28, "PLO Compare and swap and double store (256 bit in parameter list)")
> -DEF_FEAT(PLO_CSTSTO, "plo-cststo", PLO, 29, "PLO Compare and swap and trible store (256 bit in parameter list)")
> +DEF_FEAT(PLO_CSTSTO, "plo-cststo", PLO, 29, "PLO Compare and swap and triple store (256 bit in parameter list)")
>  DEF_FEAT(PLO_TCS, "plo-tcs", PLO, 30, "Triple compare and swap (32 bit in parameter list)")
>  DEF_FEAT(PLO_TCSG, "plo-tcsg", PLO, 31, "Triple compare and swap (64 bit in parameter list)")
>  DEF_FEAT(PLO_TCSX, "plo-tcsx", PLO, 32, "Triple compare and swap (128 bit in parameter list)")
> -- 
> 2.50.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


