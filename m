Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76AAE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 13:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOcxp-0007xC-K8; Fri, 20 Dec 2024 08:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOcxo-0007wt-EY
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 08:22:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOcxl-0001FD-Mj
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 08:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734700959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+NDCm331n3+yDG0AeW7S4n68Ceovys/8JQ3jUv3Rs8w=;
 b=HCwMdAIrIUyXTz6oaghnRPntrMw2g4C5/2vbrBDxNPS0ZN8nXXVecnKsiwyxqUwwGykCAj
 kAAGfDqVp5HECLFtgdDJIpwtKZqCF3HuPfd6x4P3116GxK+pQJREA74kiWwDx7BM4T5pQJ
 vCA2gv/Ju7qi/CjLEHVLfrWjgLfvUdI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-1WhBh10DPGOkktqgOsV6Qg-1; Fri,
 20 Dec 2024 08:22:38 -0500
X-MC-Unique: 1WhBh10DPGOkktqgOsV6Qg-1
X-Mimecast-MFC-AGG-ID: 1WhBh10DPGOkktqgOsV6Qg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA7E319560AF; Fri, 20 Dec 2024 13:22:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29C23195608A; Fri, 20 Dec 2024 13:22:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE58021E66E2; Fri, 20 Dec 2024 14:22:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 09/23] qapi/source: allow multi-line QAPISourceInfo
 advancing
In-Reply-To: <20241213021827.2956769-10-jsnow@redhat.com> (John Snow's message
 of "Thu, 12 Dec 2024 21:18:12 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-10-jsnow@redhat.com>
Date: Fri, 20 Dec 2024 14:22:34 +0100
Message-ID: <87h66y4hgl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> This is for the sake of the new rST generator (the "transmogrifier") so
> we can advance multiple lines on occasion while keeping the
> generated<-->source mappings accurate.
>
> next_line now simply takes an optional n parameter which chooses the
> number of lines to advance.
>
>
> RFC: Here's the exorbitant detail on why I want this:
>
> This is used mainly when converting section syntax in free-form
> documentation to more traditional rST section header syntax, which
> does not always line up 1:1 for line counts.
>
> For example:
>
> ```
>  ##
>  # = Section     <-- Info is pointing here, "L1"
>  #
>  # Lorem Ipsum
>  ##
> ```
>
> would be transformed to rST as:
>
> ```
> =======        <-- L1
> Section        <-- L1
> =======        <-- L1
>                <-- L2
> Lorem Ipsum    <-- L3
> ```

I can't help to wonder...  Could we simply use rST markup instead?

"Later", "maybe later", or even "please ask me later" would be perfectly
acceptable answers.

> After consuming the single "Section" line from the source, we want to
> advance the source pointer to the next non-empty line which requires
> jumping by more than one line.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/source.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
> index 7b379fdc925..ffdc3f482ac 100644
> --- a/scripts/qapi/source.py
> +++ b/scripts/qapi/source.py
> @@ -47,9 +47,9 @@ def set_defn(self, meta: str, name: str) -> None:
>          self.defn_meta = meta
>          self.defn_name = name
>  
> -    def next_line(self: T) -> T:
> +    def next_line(self: T, n: int = 1) -> T:
>          info = copy.copy(self)
> -        info.line += 1
> +        info.line += n
>          return info
>  
>      def loc(self) -> str:

Assuming we need this:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


