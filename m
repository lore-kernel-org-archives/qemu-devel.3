Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283BAE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWC0D-0006Ip-AZ; Fri, 10 Jan 2025 05:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tWC07-0006Hh-BO
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:12:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tWC05-0005DD-2u
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736503937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/pqtX88KDcZzZ0dVe1dk6IklTTibPaIN8TfYRUX66c=;
 b=PrjNnUD6K2Njw3BUxROlOSt4nI6VP341WgYrRnAJwwk4w6latvFiDFYY4qzVpiKiQV5VnD
 tUNBBoX2wPy52Evqq3oFNA8iTsqoGkBt3WxI1YxbbJGNF2W6eFK0fyz1fydUSgJT63Vilh
 kS5vWLygkJSjBnuFC9t8ChKIAHdvBcw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-SdXBGBaJNH2J4o_v2iX8pQ-1; Fri,
 10 Jan 2025 05:12:14 -0500
X-MC-Unique: SdXBGBaJNH2J4o_v2iX8pQ-1
X-Mimecast-MFC-AGG-ID: SdXBGBaJNH2J4o_v2iX8pQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1177519560B0; Fri, 10 Jan 2025 10:12:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.182])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3E6D1954B24; Fri, 10 Jan 2025 10:12:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8EF8918000A2; Fri, 10 Jan 2025 11:12:09 +0100 (CET)
Date: Fri, 10 Jan 2025 11:12:09 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 2/2] tests/qtest/libqos: add DMA support for writing
 and reading fw_cfg files
Message-ID: <6qzq6jv3wl27mtcbezant2xsitgns5osyjpvtmina3gzuu4ci4@dbtpagjexdyl>
References: <20250109074929.252339-1-anisinha@redhat.com>
 <20250109074929.252339-3-anisinha@redhat.com>
 <87ikqnenn1.fsf@suse.de>
 <790B9C73-B5B0-4AB4-9132-7734248E8B4F@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <790B9C73-B5B0-4AB4-9132-7734248E8B4F@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, Jan 10, 2025 at 10:53:32AM +0530, Ani Sinha wrote:
> 
> 
> > On 10 Jan 2025, at 2:00 AM, Fabiano Rosas <farosas@suse.de> wrote:
> > 
> > Ani Sinha <anisinha@redhat.com> writes:
> > 
> >> At present, the libqos/fw_cfg.c library does not support the modern DMA
> >> interface which is required to write to the fw_cfg files. It only uses the IO
> >> interface. Implement read and write methods based on DMA. This will enable
> >> developers to write tests that writes to the fw_cfg file(s). The structure of
> >> the code is taken from edk2 fw_cfg implementation. It has been tested by
> >> writing a qtest that writes to a fw_cfg file. This test will be part of a
> >> future patch series.
> > 
> > What's the blocker for the rest of the series?
> 
> The broker is that the consumer of this api is a new qtest which is written to test a brand new feature.

A in-tree user of fw_cfg file writes is ramfb, so writing a ramfb test
would be an option ...

take care,
  Gerd


