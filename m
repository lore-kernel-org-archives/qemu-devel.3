Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35935CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 09:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v79Pl-0007Yd-2J; Fri, 10 Oct 2025 05:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v79Pj-0007YC-9K
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 05:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v79Pg-0007bS-ML
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 05:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760088465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZpisjEBf/ZgP/xzFdxPrDN6QgL+s6L4lQDr1x1X4tao=;
 b=grnP3pzxG/RObFIOdCPhyQQifxiBp80EB6MzHDGUEQYx7mMEqiUgoAPV9eQqw8kmDZxYV9
 Pl4l49vlYs+Bu4hptgDassRKoyvuMSSnltH63T0lYlOmuWdFSfHUtBlPzlCciEiswcbN2y
 fUjZ7+05dAguPcYkCqMRqxtrd5gBKWI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-WkpBk6OuMYOa96p41_WN1Q-1; Fri,
 10 Oct 2025 05:27:42 -0400
X-MC-Unique: WkpBk6OuMYOa96p41_WN1Q-1
X-Mimecast-MFC-AGG-ID: WkpBk6OuMYOa96p41_WN1Q_1760088460
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11F2C19560B2; Fri, 10 Oct 2025 09:27:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.183])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5851D1955F22; Fri, 10 Oct 2025 09:27:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id ECBF1180061F; Fri, 10 Oct 2025 11:27:36 +0200 (CEST)
Date: Fri, 10 Oct 2025 11:27:36 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
Message-ID: <dyzu3h5qh7y3isn7m2ech3tq2lbr23aswrmc6npvjupm3wepqr@366kl5b2jkws>
References: <20251010071008.2555267-1-kraxel@redhat.com>
 <aOjN5VCRh8WtmxJE@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOjN5VCRh8WtmxJE@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> > +static void handle_ovmf_log_range(GString *out,
> > +                                  dma_addr_t start,
> > +                                  dma_addr_t end,
> > +                                  Error **errp)
> > +{

> How about eliminating the intermediate buffer alloocation / printf by
> reading straight into the GString buf ? Something like
> 
>    size_t len = end - start;
>    g_string_set_size(out, out->len + len);
>    if (dma_memory_read(&address_space_memory, start,
>                        out->str + (out->len - len),
> 	               len, MEMTXATTRS_UNSPECIFIED)) {
>        ...
>    }

There are two ranges in the wrap-around case, and I don't think I can
put multiple chunks into a single gstring.

take care,
  Gerd


