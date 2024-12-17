Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A5AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYJX-0007zl-IV; Tue, 17 Dec 2024 09:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tNYJW-0007zR-7B
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:12:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tNYJU-0001xp-R9
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734444759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P8FCoh5d8PjZU4dSBocn837/7dxxwurYY9CqN5r2LyU=;
 b=SXyQfPljfOnN3KeOuQn44ry+zGCuao4iJv7rlZRCRc6iVKSRjfwtlTLtTaUyZirJa0jnhm
 jwLQSlQVGr9DLQOt2lQTLKbEtGzyYxHQNfb5YI6vtC7W5I2KoxkPdka84wWDiPQHADQSnL
 2gDl/AlBt5XNjcLkmtv4W0WPhL2wozU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-cLCDRGthNSyg2oAGjIoP6A-1; Tue,
 17 Dec 2024 09:12:34 -0500
X-MC-Unique: cLCDRGthNSyg2oAGjIoP6A-1
X-Mimecast-MFC-AGG-ID: cLCDRGthNSyg2oAGjIoP6A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CAA71955F2F; Tue, 17 Dec 2024 14:12:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.88])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF09619560A2; Tue, 17 Dec 2024 14:12:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7D12F1800399; Tue, 17 Dec 2024 15:12:26 +0100 (CET)
Date: Tue, 17 Dec 2024 15:12:26 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 2/5] x86/loader: only patch linux kernels
Message-ID: <3gl2kpllzfyuo2hydjj6usmt7jundqzottquxylwzgxae755m2@kpvy6t2qvevj>
References: <20240411094830.1337658-1-kraxel@redhat.com>
 <20240411094830.1337658-3-kraxel@redhat.com>
 <bbc28a3a-7e4b-4f36-b072-f803e48b6198@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc28a3a-7e4b-4f36-b072-f803e48b6198@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Dec 17, 2024 at 02:09:30PM +0300, Michael Tokarev wrote:
> 11.04.2024 12:48, Gerd Hoffmann wrote:
> > If the binary loaded via -kernel is *not* a linux kernel (in which
> > case protocol == 0), do not patch the linux kernel header fields.
> > 
> > It's (a) pointless and (b) might break binaries by random patching
> > and (c) changes the binary hash which in turn breaks secure boot
> > verification.
> > 
> > Background: OVMF happily loads and runs not only linux kernels but
> > any efi binary via direct kernel boot.
> > 
> > Note: Breaking the secure boot verification is a problem for linux
> > kernels too, but fixed that is left for another day ...
> 
> Shouldn't this one be picked up for -stable?

yes, please.

thanks,
  Gerd


