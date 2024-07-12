Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8514AC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCJv-0001KQ-0J; Fri, 12 Jul 2024 05:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSCJs-0001CJ-UD
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSCJr-0001Gv-1F
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720775517;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wp4z8ld5yGXIfTBC2/B+OtpGNZQOM+lGOoUZehorM3k=;
 b=g1LsEZuqKhJKlWTJjGuVj3ehVzjm1rfB85oympzzr8rj73EIGv1sPiZ/O7F6KYq71/nRLu
 AXEoq91gDN2jASQ4DBFbV1Pgl3aiCIK5HrpPr+buNrxAB35yS9sKKL+MQiheh+BoqOKOzn
 zEDz4l5M9GgnEwIYiKaTgW3931PuzIY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-tZ40_m1SMfOVrS6WQ2JW_A-1; Fri,
 12 Jul 2024 05:11:54 -0400
X-MC-Unique: tZ40_m1SMfOVrS6WQ2JW_A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A4BF1958B35; Fri, 12 Jul 2024 09:11:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAB8319560AE; Fri, 12 Jul 2024 09:11:49 +0000 (UTC)
Date: Fri, 12 Jul 2024 10:11:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 6/8] tests/pytest: Convert some tests that download
 files via fetch_asset()
Message-ID: <ZpDzUXpIltncPqB1@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-7-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240711115546.40859-7-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 11, 2024 at 01:55:44PM +0200, Thomas Huth wrote:
> Now that we've got a working fetch_asset() function, we can convert
> some Avocado tests that use this function for downloading their
> required files.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/pytest/meson.build                      | 16 +++++++++++++++
>  .../test_machine_arm_n8x0.py}                 | 20 +++++++------------
>  .../test_machine_avr6.py}                     |  7 ++-----
>  .../test_machine_loongarch.py}                | 11 ++++------
>  .../test_machine_mips_loongson3v.py}          | 19 ++++++------------
>  5 files changed, 35 insertions(+), 38 deletions(-)
>  rename tests/{avocado/machine_arm_n8x0.py => pytest/test_machine_arm_n8x0.py} (71%)
>  rename tests/{avocado/machine_avr6.py => pytest/test_machine_avr6.py} (91%)
>  rename tests/{avocado/machine_loongarch.py => pytest/test_machine_loongarch.py} (89%)
>  rename tests/{avocado/machine_mips_loongson3v.py => pytest/test_machine_mips_loongson3v.py} (59%)

If you take my suggestion in the previous patch, the sha1 hashes
would need updating to sha256 hashes here. Aside from that

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


