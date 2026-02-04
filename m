Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454F6E95398
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncIy-0006mj-9o; Wed, 04 Feb 2026 07:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncIa-0006dx-Om
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:48:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncIX-0002Ls-Vf
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770209276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HrQ2tf58hmCd0a1SyjLIzg8qlLRXp6+1Zsk7Xntv6s=;
 b=B0aUaSm8dzH6BjDRwwo0dcgTH+1ed5gpxT9vSzuufOojwZSzm5s15MVLconm2Qjp9FJ67j
 Hz4LK5LIg9q3q1lZMNgUzEuDLJvwXp2vSIA46ZVFz3udApUcZSIbE5awDzQ2V3DlwpzzQi
 nURZgIPPCUkzSbmkrRvtWTZYQPTO8ew=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-qwnHyu6NP7uDJYULQdyIxw-1; Wed,
 04 Feb 2026 07:47:53 -0500
X-MC-Unique: qwnHyu6NP7uDJYULQdyIxw-1
X-Mimecast-MFC-AGG-ID: qwnHyu6NP7uDJYULQdyIxw_1770209272
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6B1E19560B7; Wed,  4 Feb 2026 12:47:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C95419560AD; Wed,  4 Feb 2026 12:47:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4D07921E692D; Wed, 04 Feb 2026 13:47:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Keesler <ankeesler@google.com>
Cc: alex.bennee@linaro.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/1] Support per-head resolutions with virtio-gpu
In-Reply-To: <20260109202740.362506-2-ankeesler@google.com> (Andrew Keesler's
 message of "Fri, 9 Jan 2026 20:27:39 +0000")
References: <20260109202740.362506-1-ankeesler@google.com>
 <20260109202740.362506-2-ankeesler@google.com>
Date: Wed, 04 Feb 2026 13:47:49 +0100
Message-ID: <87jywsy8sq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Sorry for the delay.  Recovering from the coughing plague.

Andrew Keesler <ankeesler@google.com> writes:

> In 454f4b0f, we started down the path of supporting separate
> configurations per display head (e.g., you have 2 heads - one with
> EDID name "AAA" and the other with EDID name "BBB").
>
> In this change, we add resolution to this configuration surface (e.g.,
> you have 2 heads - one with resolution 111x222 and the other with
> resolution 333x444).
>
>   -display vnc=localhost:0,id=aaa,display=vga,head=0 \
>   -display vnc=localhost:1,id=bbb,display=vga,head=1 \
>   -device '{"driver":"virtio-vga",
>             "max_outputs":2,
>             "id":"vga",
>             "outputs":[
>               {
>                  "name":"AAA",
>                  "xres":111,
>                  "yres":222
>               },
>               {
>                  "name":"BBB",
>                  "xres":333,
>                  "yres":444
>               }
>             ]}'
>
> Here is the behavior matrix of the current resolution configuration
> surface (xres/yres) with the new resolution configuration surface
> (outputs[i].xres/yres).
>
> Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> Behavior: current behavior - outputs[0] enabled with default xres/yres
>
> Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
> Behavior: current behavior - outputs[0] enabled with xres/yres
>
> Case: !(xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
>
> Case: (xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
> Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
>
> Signed-off-by: Andrew Keesler <ankeesler@google.com>

[...]

> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index cd67c4f52e..c1a1fb4997 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -970,15 +970,24 @@
>  ##
>  # @VirtIOGPUOutput:
>  #
> -# Describes configuration of a VirtIO GPU output.
> +# Describes configuration of a VirtIO GPU output.  If both @xres and
> +# @yres are set, they take precedence over root virtio-gpu
> +# resolution configuration and enable the corresponding output.  If
> +# only one or none of @xres or @yres is set, root virtio-gpu
> +# resolution configuration takes precedence and only the first output
> +# is enabled.

So when exactly one of @xres or @yes is present, it's silently ignored?

>  #
>  # @name: the name of the output
>  #
> +# @xres: horizontal resolution of the output in pixels (since 10.2)
> +#
> +# @yres: vertical resolution of the output in pixels (since 10.2)

(since 11.0)

> +#
>  # Since: 10.1
>  ##
>  
>  { 'struct': 'VirtIOGPUOutput',
> -  'data': { 'name': 'str' } }
> +  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
>  
>  ##
>  # @DummyVirtioForceArrays:


