Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF31AC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 14:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2UT6-0002pN-73; Fri, 04 Sep 2026 10:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2UT3-0002om-Ta
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2UT0-00086W-GC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788530426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yow9fczU4j8TBETnXGWXtkTzFgqbSrd1q2UTH+iWgYY=;
 b=UotaRB5yRPi6yts8TEwP8gNSZIzKzLzbiKpwo//uNoTYJ8IRWPAQ2EbEwMHl1TEf27ald7
 UkAsSLIs3d/WetEcmCP8K+n4AgsdU8M0elE3p11ggZbNsqAAm/qsBNgW9GfnNIj1CC/PSr
 dMUPBiHK1M3F9/Xndpk+b3EORc/AJ+k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-ct-ifUK9PfOQxoceSLushQ-1; Fri,
 04 Sep 2026 10:00:25 -0400
X-MC-Unique: ct-ifUK9PfOQxoceSLushQ-1
X-Mimecast-MFC-AGG-ID: ct-ifUK9PfOQxoceSLushQ_1788530424
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0551F195FE10; Fri,  4 Sep 2026 14:00:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C3CB26C; Fri,  4 Sep 2026 14:00:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E63F421E6A04; Fri, 04 Sep 2026 16:00:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Chao Liu
 <chao.liu@processmission.com>
Subject: Re: [PATCH 01/18] checkpatch: Fix checking of newlines in error
 messages
In-Reply-To: <20260902221547.1812481-2-farosas@suse.de> (Fabiano Rosas's
 message of "Wed, 2 Sep 2026 19:15:29 -0300")
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-2-farosas@suse.de>
Date: Fri, 04 Sep 2026 16:00:20 +0200
Message-ID: <87mrtx5d6z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> Using newlines in the g_test_message is fine. It automatically adds
> the '#' required by the TAP protocol to the start of each line.
>
> Relax the regex for this function, but still forbid a trailing newline
> because it's added automatically and usually not what the user wants.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  scripts/checkpatch.pl | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 03f35e75012..fd4534b3a1e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3303,13 +3303,20 @@ sub process {
>  					 info_vreport|
>  					 error_report|
>  					 warn_report|
> -					 info_report|
> -					 g_test_message}x;
> +					 info_report}x;
>  
>  		if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
>  			ERROR("Error messages should not contain newlines\n" . $herecurr);
>  		}
>  
> +		# No newlines at the end
> +		my $trail_newline_error_funcs = qr{g_test_message}x;
> +
> +		if ($rawline =~ /\b(?:$trail_newline_error_funcs)\(.*\".*\\n\"/) {

Unlike the regexp above, this one doesn't accept spaces between the
function name and the parenthesis.  We generally don't have spaces
there, but why rely on that?

> +		    ERROR("Error messages should not contain trailing " .
> +			  "newlines\n" . $herecurr);
> +		}
> +
>  		# Continue checking for error messages that contains newlines.
>  		# This check handles cases where string literals are spread
>  		# over multiple lines.

With the spaces accepted
Reviewed-by: Markus Armbruster <armbru@redhat.com>


