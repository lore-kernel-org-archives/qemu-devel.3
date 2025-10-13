Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3299DCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 08:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8E8j-0002Xb-0w; Mon, 13 Oct 2025 04:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8E8g-0002XS-Rj
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:42:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8E8e-0007uu-EE
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760344954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Gx18BWScrcB/apdTJfsSp36EfCkQ7kQsNGc4Eh1iY0=;
 b=MBpkLjsjqJ4HbC2TKshFmF4MsvC3gGF3UArsdMf1i7rICGuUZzZdtTIcMN28C9DbVESzun
 gujXlQ9QF6TSy1Z5fxeMZN1Np6m+hfyEy2GfXf/t0JIhQEPPWR761K1oH/QZMIouonjzd4
 2Y/hxCx5qyrAYiwEsWrEJkrSfjpU/9I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-C25DGSwoNJW6Dik_emMHjw-1; Mon,
 13 Oct 2025 04:42:31 -0400
X-MC-Unique: C25DGSwoNJW6Dik_emMHjw-1
X-Mimecast-MFC-AGG-ID: C25DGSwoNJW6Dik_emMHjw_1760344950
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0B451800286; Mon, 13 Oct 2025 08:42:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 742911954105; Mon, 13 Oct 2025 08:42:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 49C2F18000B2; Mon, 13 Oct 2025 10:42:26 +0200 (CEST)
Date: Mon, 13 Oct 2025 10:42:26 +0200
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
Message-ID: <ebe6jknybpvqjtp4kb7oz7std2pofyszywfgradx7ridztxp73@qnope67mp4sc>
References: <20251010071008.2555267-1-kraxel@redhat.com>
 <aOjN5VCRh8WtmxJE@redhat.com>
 <dyzu3h5qh7y3isn7m2ech3tq2lbr23aswrmc6npvjupm3wepqr@366kl5b2jkws>
 <aOjSfQMrRpanYZ7g@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOjSfQMrRpanYZ7g@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Oct 10, 2025 at 10:31:41AM +0100, Daniel P. Berrangé wrote:
> On Fri, Oct 10, 2025 at 11:27:36AM +0200, Gerd Hoffmann wrote:
> > > > +static void handle_ovmf_log_range(GString *out,
> > > > +                                  dma_addr_t start,
> > > > +                                  dma_addr_t end,
> > > > +                                  Error **errp)
> > > > +{
> > 
> > > How about eliminating the intermediate buffer alloocation / printf by
> > > reading straight into the GString buf ? Something like
> > > 
> > >    size_t len = end - start;
> > >    g_string_set_size(out, out->len + len);
> > >    if (dma_memory_read(&address_space_memory, start,
> > >                        out->str + (out->len - len),
> > > 	               len, MEMTXATTRS_UNSPECIFIED)) {
> > >        ...
> > >    }
> > 
> > There are two ranges in the wrap-around case, and I don't think I can
> > put multiple chunks into a single gstring.
> 
> I'm not sure I understand ?  The code I've suggest here satisfies the
> existing API contract you've got for handle_ovmf_log_range, so should
> be happy with being called multiple times.

I've missed the detail that the g_string_set_size() call actually
/expands/ the string.  Tried, works fine.

take care,
  Gerd


