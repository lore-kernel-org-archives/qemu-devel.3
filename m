Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E4606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HBM5gOlN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsjC-0000Vr-Hf; Mon, 02 Nov 2026 09:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshr-0007sl-NK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNshp-0005Cg-BO
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793628492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eu2vs//ronJWG6KONC4cKlwjqxJBcqK+C1Hjm3L59jY=;
 b=HBM5gOlNMDZveJFcczECMAvi6iX1W0EIgQbftowDwdX5dEXRmZOGeCM9/2gYbhJEMbiR1f
 X3ETIzAoh99jzkHZNLHZTHveweFRBb9Y6FyxjL2ri4Wenkfiy7q7XGFD0OTf5sHgLLSmjz
 UNxafRtIAoVpxIEihZOrX0iqPMfvU1Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-8SOtFyh1Np2BClgYbF95ZA-1; Mon,
 02 Nov 2026 09:08:07 -0500
X-MC-Unique: 8SOtFyh1Np2BClgYbF95ZA-1
X-Mimecast-MFC-AGG-ID: 8SOtFyh1Np2BClgYbF95ZA_1793628484
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C4C71955F41; Mon,  2 Nov 2026 14:08:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 229081955D47; Mon,  2 Nov 2026 14:08:01 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 07/18] hw/usb/xen-usb: Do not insert an automatic
 hub
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
In-Reply-To: <20261102092201.1729245-8-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-8-jamin_lin@aspeedtech.com>
Date: Mon, 02 Nov 2026 18:07:30 +0400
Message-Id: <179362845013.3960472.4882687521140300056.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=464;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mOnpZC2X2G+MrwPy4tgIMJCyVf8OT4XCvk/ZEThbFGM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6JkkU3Z3+Gj8o5k+VgGVRtD+k2ZsQ5H25n9et
 eyDTlQ7pjGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauiZJAAKCRDa6OEJdZac
 5fN6D/91mO2uLs2qr0TdRW3+ZXGH0V51+viKxEfMDF/ytHY9Z+8H8SAwhAPBqcnfoGzlZTtp2ro
 3k2eF5sSkbNpscG1PhbD7pRU1eZSiqA37udldyQGy3ZbqbXpql+fGCU84vxjiVFGU0JifF84P5g
 AI9xzFE8WtESqA8EPu+/fVRGxG8PkIx3HRLtPaVfOb/zQB0kZgdBsxNr+ovmpWzJmhx3XrYczcK
 Q3OW/Q8cUJSvib7+BohXxmiJtlsMEoXwW1OxGCvK5kL8IiUc+nYkjhMxKePd7zrrNq73v16jgFh
 ZjYZyDihq54i2IWW42AoyHcll/tjHSlZVCQwbp2ItN03zYhNWQnETjx9Y/ZTIBUMM/haA0tV2zd
 0FVr5X6+Uw1O+l3gOyEs2PVkWtmX31ZAM4rMU4EdyjJ+8voXNr44kJLm6+TX8H0uj1/dGyrHJ4q
 XBrpE+8OEqIaZeY/uJRfHl+f0739JNw0yGgSOEjxavYmitWUybtbzMrR/jOuFDY5ggSPfDrXcXh
 brqr4DAmv6ZAbs13YdphSShZjvZAQck2vXIUf+KKwDy4/tJeGB+9WnfscstiapHTi5EGNB49UsQ
 Qmps0PuNypsvNUKnrwZhq9trQgwxP9ZuDdleiFItuldIAadtQrD/E39Fml9sVIxfbZFGcvHlxtx
 DEWU+4c+9181nCQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 02 Nov 2026 09:22:13 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> xen-usb gives every device a port number. usb_claim_port() then uses
> that port, and never reaches the automatic hub.
> 
> Set auto_hub to false. Every bus creator then sets the flag itself,
> and usb_bus_new() can stop setting a default.
> 
> 
> [...]

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


