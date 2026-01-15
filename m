Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178A6D4117B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 12:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMC5-0005Ja-P5; Thu, 15 Jan 2026 07:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgMC4-0005JN-Ee
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:11:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgMC2-00017g-6b
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768479071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oitaWc8EGKZ+z4a20+FSgPr05tFUMVe0QvgOO5DVqeE=;
 b=gF6niEy4I0vdHzE7cuTjTnWhKJ9IVGnnq7Si/u8SsvBq5bxNmzVq8MhVRHjWsbvFaowqKS
 rV4Nh+sFCqKeEd9RAfzNj/0aPMHubMJZqpRaLyIrhoazTrnb/iqvHrmuxCG4YETrosXGVe
 DhduLwuztweJRNzXchREzOYXjR867n4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-4vHbCJ3LMHqNt3VDfwmp2g-1; Thu,
 15 Jan 2026 07:11:08 -0500
X-MC-Unique: 4vHbCJ3LMHqNt3VDfwmp2g-1
X-Mimecast-MFC-AGG-ID: 4vHbCJ3LMHqNt3VDfwmp2g_1768479067
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D0ED1800473; Thu, 15 Jan 2026 12:11:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CC311800240; Thu, 15 Jan 2026 12:11:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 25AFA21E692D; Thu, 15 Jan 2026 13:11:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: dave@treblig.org
Cc: armbru@redhat.com,  berrange@redhat.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] hxtool: Split srst/erst add checks
In-Reply-To: <20260115020423.722069-4-dave@treblig.org> (dave@treblig.org's
 message of "Thu, 15 Jan 2026 02:04:22 +0000")
References: <20260115020423.722069-1-dave@treblig.org>
 <20260115020423.722069-4-dave@treblig.org>
Date: Thu, 15 Jan 2026 13:11:04 +0100
Message-ID: <87y0lzvzxj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

dave@treblig.org writes:

> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
> Split the SRST/ERST case and add some checks.
> This is mainly to make it easier to add some checks in following
> patches.
>
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>  scripts/hxtool | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/hxtool b/scripts/hxtool
> index 80516b9437..ea2accef98 100755
> --- a/scripts/hxtool
> +++ b/scripts/hxtool
> @@ -2,15 +2,29 @@
>  
>  hxtoh()
>  {
> -    flag=1
> +    outsiderst=1

I parsed this "outsider st" and went "WAT?  Backtrack... aha".  Name it
outside_rst?  in_h?  Or revert sense and call it in_rst?

>      while read -r str; do
>          case $str in
>              HXCOMM*)
>              ;;
> -            SRST*|ERST*) flag=$(($flag^1))
> +            SRST*)
> +              if [ $outsiderst -eq 0 ]
> +              then
> +                echo "Error: SRST inside another RST" >&2
> +                exit 1
> +              fi
> +              outsiderst=0
> +            ;;
> +            ERST*)
> +              if [ $outsiderst -eq 1 ]
> +              then
> +                echo "Error: ERST already outside RST" >&2
> +                exit 1
> +              fi
> +              outsiderst=1
>              ;;
>              *)
> -            test $flag -eq 1 && printf "%s\n" "$str"
> +            test $outsiderst -eq 1 && printf "%s\n" "$str"
>              ;;
>          esac
>      done


