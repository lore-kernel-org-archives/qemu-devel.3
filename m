Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC22C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 11:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxmnN-0007In-DC; Fri, 19 Apr 2024 07:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rxmmy-0007Fb-BI
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 07:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rxmmu-0001dd-RH
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 07:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713527534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OxoQ873H7iOSTFVIdgsyHNlTk6QLM+SBF/xfBDJbLcs=;
 b=eBJYKm6mdR4VkeLhRD5lZvziKhm3yWmYfWtjIWQw+2GCjQXb3JYSHRA0ebw/0YGqfSt6EY
 8K8ZOTSKI1jEb2yyBVM9UqGFJa8N3oIlOYF3yypd5Fq8KkNrCFUrP3GlqFBTMlsPxH3+8M
 zXtuPsURz/JDwaAf3UIcLYyviKK3r1U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-jxL5RIEbPxyPtlKzq3f_Rw-1; Fri,
 19 Apr 2024 07:52:09 -0400
X-MC-Unique: jxL5RIEbPxyPtlKzq3f_Rw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 481C3382C46F;
 Fri, 19 Apr 2024 11:52:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBEDB40C1233;
 Fri, 19 Apr 2024 11:52:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AC3861800DFD; Fri, 19 Apr 2024 13:52:07 +0200 (CEST)
Date: Fri, 19 Apr 2024 13:52:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: devel@edk2.groups.io, jonathan.cameron@huawei.com
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>, linuxarm@huawei.com, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Idan Horowitz <idan.horowitz@gmail.com>
Subject: Re: [edk2-devel] [PATCH v3 5/6] target/arm: Do memory type alignment
 check when translation disabled
Message-ID: <kjpkyoux2xcegrqshde5ddhicf33jnlelobuzuo4uj4svvlzdn@rilun7dz6776>
References: <20240301204110.656742-1-richard.henderson@linaro.org>
 <20240301204110.656742-6-richard.henderson@linaro.org>
 <20240416161111.0000607c@huawei.com>
 <0c878d25-3fbb-4f0b-bc9e-ca638f8c4f1e@linaro.org>
 <20240418091555.00006666@Huawei.com>
 <20240418183600.00000345@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418183600.00000345@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

  Hi,

> Gerd, any ideas?  Maybe I needs something subtly different in my
> edk2 build?  I've not looked at this bit of the qemu infrastructure
> before - is there a document on how that image is built?

There is roms/Makefile for that.

make -C roms help
make -C roms efi

So easiest would be to just update the edk2 submodule to what you
need, then rebuild.

The build is handled by the roms/edk2-build.py script,
with the build configuration being in roms/edk2-build.config.
That is usable outside the qemu source tree too, i.e. like this:

  python3 /path/to/qemu.git/roms/edk2-build.py \
    --config /path/to/qemu.git/roms/edk2-build.config \
    --core /path/to/edk2.git \
    --match armvirt \
    --silent --no-logs

That'll try to place the images build in "../pc-bios", so maybe better
work with a copy of the config file where you adjust this.

HTH,
  Gerd


