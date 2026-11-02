Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429D606A32D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YnfnkFt+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsib-0008Av-5N; Mon, 02 Nov 2026 09:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshw-0007vK-Rn
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshv-0005Do-7x
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793628498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2a5TS5rWxCs6ZczX1TH3d68zs8Nbe5HYRUZj/2vXxG4=;
 b=YnfnkFt+PIr6DT9M5tWnLcm59FPhK529kySLJVqNMT9szjBbDzVqGp/2Zxgr7RUpynDg3h
 bwXLuIJOhENVhb5zQy5x7WEhBhG3ySwnMArzHh2CsFz2kGryVPKs4Qnau6Ii6if7qr0v+d
 drkw/TONPpqrfOQQ7+mzhEu9HXjv2bs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-0g3KBWzkMUCaOWTYmehgrw-1; Mon,
 02 Nov 2026 09:08:14 -0500
X-MC-Unique: 0g3KBWzkMUCaOWTYmehgrw-1
X-Mimecast-MFC-AGG-ID: 0g3KBWzkMUCaOWTYmehgrw_1793628490
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27C661945105; Mon,  2 Nov 2026 14:08:07 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D0B51955F2D; Mon,  2 Nov 2026 14:08:05 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 08/18] hw/usb/bus: Turn off the automatic hub by default
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, junjie.cao@intel.com, 
 junjie.cao@linux.dev, clg@kaod.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-9-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-9-jamin_lin@aspeedtech.com>
Date: Mon, 02 Nov 2026 18:07:30 +0400
Message-Id: <179362845015.3960472.14396103276249426058.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=450;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Nudz+qd4gdlQDc/ZGrx4gotwouNVcd+MO6oDUjSZiSY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6JkkV2U/dcvQN0lx278ZzYKX3QYfzOm/41fZ5
 6I+vZi7ELqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauiZJAAKCRDa6OEJdZac
 5ZWVD/437TbSBBA1xJg21xrSB7pZVEkGByGKb5CXRvgY9+QzON3K6zcnFGy0/dokDG/DuaM2Tma
 OCouJsTSV1RAVpSDx1g50k37nG8N25WU0eP3MENkJnCbpkhUjfzgSr1cCyH+ilwbQZRFDbUFzC+
 wkUSbI6tJZoxIUftngJtPl5PBErNPdtug97xn/45QSwXZsFbLqMeTbyLF8Ogej2CkQoiP1O7Zx/
 wib0bbVkSHW3Iwkbp9NFj3fUHp0PeWT3ZpkUCYWgfSkj0cxDCbFIsFLeqhqA58nXgrhHRPseuek
 zd7k8uqUvyI2vPlVA8aWGmFknpQAjPZbfYIJs8BcdMkRu/OqyzsWk2l79hyAG+z7rKE2zxjtejr
 dJJNDcz9J2o70hA6I2HArMKjj5PguK8bPBIoa6n77UW7Et+nnVE4YlhvFChX3FF1BujvGr0cWtf
 iLXZ5PtPxJB5M3sKxk8yPJdQrePljSvxhr9MCTT6qb+x1wGlYx7iOy5xPeyZcJH49JcvSWcWp4n
 MrAikT3HU29M0PaJlukV4OgxvJUN2MANu/YYoDESaD+BCPsp73Y65GyEQTr5t7uhFgd42cIjlMm
 H72ahLRYayxcx+dmBA1sX24evFrDGNVwzXi8KvPXOj2wLa6TlGkx3bLvBgG4kXPNAIaoRqHaxRE
 RYbqwv3/IlnAOTQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 09:22:14 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> Every bus creator now sets auto_hub from its own property, or clears
> it outright, so the value usb_bus_new() leaves there is never read.
> 
> Drop the line. A new bus then has no hub unless its controller asks
> for one.
> 
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


