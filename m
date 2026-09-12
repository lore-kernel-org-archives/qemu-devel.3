Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307B2C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5IGM-0002Q5-GC; Sat, 12 Sep 2026 03:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5IGK-0002Pd-TX
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 03:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5IGJ-0000jq-8W
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 03:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789198498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wv+ECiz5HJpXtukGfXlAJAjlWLeksgEIipoaYnmmfuE=;
 b=GlRBaCvPkoPECp1F852YwtoqET/G/qzPZzgNVkYBMvQmeITdTpMEchW2hHXU0kNKpNRkYD
 tmXIUl0ILoqR62jIuwIRTJdgAkyQsgnVmuglzWercBeDlEGCnV5N3LhxvHLMhcO4eMJE6y
 j6QxNQV1ftoDGsSpcvsU68Hq6Aa1ypQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-YOjhYsEqNsCQDcoLWpjB2w-1; Sat,
 12 Sep 2026 03:34:54 -0400
X-MC-Unique: YOjhYsEqNsCQDcoLWpjB2w-1
X-Mimecast-MFC-AGG-ID: YOjhYsEqNsCQDcoLWpjB2w_1789198493
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C516F180AE8F; Sat, 12 Sep 2026 07:34:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1915D18004D4; Sat, 12 Sep 2026 07:34:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ACEA621E6A04; Sat, 12 Sep 2026 09:34:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Eric
 Blake <eblake@redhat.com>,  Jonathan Cameron <jic23@kernel.org>,  Lukas
 Straub <lukasstraub2@web.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  linux-cxl@vger.kernel.org,  Jason Wang
 <jasowangio@gmail.com>,  Hanna Reitz <hreitz@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 3/6] qapi: convert remaining simple intros for machine.json
In-Reply-To: <20260911172200.227914-4-jsnow@redhat.com> (John Snow's message
 of "Fri, 11 Sep 2026 13:21:57 -0400")
References: <20260911172200.227914-1-jsnow@redhat.com>
 <20260911172200.227914-4-jsnow@redhat.com>
Date: Sat, 12 Sep 2026 09:34:49 +0200
Message-ID: <87h5ju3oti.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

John Snow <jsnow@redhat.com> writes:

> These are either structs or unions that are used in an inlinable
> context: i.e. the generated documentation is likely to feature a
> version of this documentation block that does not include the intro in
> context of another command, event, or structure.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/machine.json | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 0516112f8e8..13875fc4642 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -449,8 +449,7 @@
>  
>  ##
>  # @NumaOptions:
> -#
> -# A discriminated record of NUMA options.  (for OptsVisitor)
> +#     A discriminated record of NUMA options.  (for OptsVisitor)
>  #
>  # @type: NUMA option type
>  #

Trivial conflict with my "[PATCH 1/2] qapi/machine: Drop misleading (for
OptsVisitor) doc".  I'll take care of it.


