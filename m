Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D70CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 08:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl2OA-00008H-GT; Mon, 02 Sep 2024 04:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sl2O8-00006h-MK
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 04:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sl2O7-0002qJ-5E
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 04:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725265573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7InOSuQzXGn8MZHlCqDUTW7B5xWxxJ9aDG+hTKU1KTw=;
 b=O0m4iSXFl3rB8a7ktUzJdd5z7HvC0DYZ9OAFkoZ1yR2s3Sbhu+qooCtgc+srsd9Wssro5/
 4eHeY5xgQ9ItIEXWXBjjqyjUXGonY33Sw7kwoPex6kuKqvcSEwSgC4Lg6hW7YbyVfasswW
 OV/ku40IcFwKt7QO6r6ISHq2g/UgVzo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-47QdFUbqP4yLe1tVlH-NOw-1; Mon,
 02 Sep 2024 04:26:09 -0400
X-MC-Unique: 47QdFUbqP4yLe1tVlH-NOw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CDBA18EA8BA; Mon,  2 Sep 2024 08:26:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACAC730001A4; Mon,  2 Sep 2024 08:26:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 533581800639; Mon,  2 Sep 2024 10:26:05 +0200 (CEST)
Date: Mon, 2 Sep 2024 10:26:05 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/audio/virtio-sound: fix heap buffer overflow
Message-ID: <55wd6crabystdtibfijz67sndrxxvzs4ibkcc2ck2kjftutd5d@5kh6ckpvzwty>
References: <20240901130112.8242-1-vr_qemu@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240901130112.8242-1-vr_qemu@t-online.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Sep 01, 2024 at 03:01:12PM GMT, Volker Rümelin wrote:
> Currently, the guest may write to the device configuration space,
> whereas the virtio sound device specification in chapter 5.14.4
> clearly states that the fields in the device configuration space
> are driver-read-only.
> 
> Remove the set_config function from the virtio_snd class.
> 
> This also prevents a heap buffer overflow. See QEMU issue #2296.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2296
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>


